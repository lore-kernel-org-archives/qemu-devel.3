Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED3CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFqJ-00031H-N3; Fri, 10 Jan 2025 09:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqI-00030b-Bb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqG-0005BP-V7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZduUwFlq8ThV8LC1UMydbJdj8h9gUjjhRCozRaSNoM=;
 b=PNOSlvZHYUTG4JavulCLKyBSytBV44crnwvoRP0YBzk9jH8s63SItHyh1OQc+RDqdEJTVn
 kjcGc+RjxhhfKwhl1zVafQF1lgmBo2xaYyiop5VefFYqyfX334evB7juFuhIUcxEFS4GGi
 eNpMJLkCNi96N+NYC9BFJN8tBN4IMKA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-rOSkkh7bPSSljbr-MUm0zg-1; Fri,
 10 Jan 2025 09:18:24 -0500
X-MC-Unique: rOSkkh7bPSSljbr-MUm0zg-1
X-Mimecast-MFC-AGG-ID: rOSkkh7bPSSljbr-MUm0zg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E811955DD8; Fri, 10 Jan 2025 14:18:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20927195E3E0; Fri, 10 Jan 2025 14:18:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 7/9] ppc/ppc405: Remove cache handling instructions
Date: Fri, 10 Jan 2025 15:17:58 +0100
Message-ID: <20250110141800.1587589-8-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since the 405 CPU family was phased out, these instructions have no
users anymore.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/ppc/cpu.h       |  6 +-----
 target/ppc/translate.c | 11 -----------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 504924f10561..f83f01a62a12 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2234,9 +2234,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_L3CR              (0x3FA)
 #define SPR_750_TDCH          (0x3FA)
 #define SPR_IABR2             (0x3FA)
-#define SPR_40x_DCCR          (0x3FA)
 #define SPR_ICTC              (0x3FB)
-#define SPR_40x_ICCR          (0x3FB)
 #define SPR_THRM1             (0x3FC)
 #define SPR_403_PBL1          (0x3FC)
 #define SPR_SP                (0x3FD)
@@ -2408,8 +2406,6 @@ enum {
     PPC_TLBIVAX        = 0x0080000000000000ULL,
     /* PowerPC 4xx dedicated instructions                                    */
     PPC_4xx_COMMON     = 0x0100000000000000ULL,
-    /* PowerPC 40x ibct instructions                                         */
-    PPC_40x_ICBT       = 0x0200000000000000ULL,
     /* rfmci is not implemented in all BookE PowerPC                         */
     PPC_RFMCI          = 0x0400000000000000ULL,
     /* rfdi instruction                                                      */
@@ -2440,7 +2436,7 @@ enum {
                         | PPC_SLBI | PPC_WRTEE \
                         | PPC_405_MAC | PPC_440_SPEC | PPC_BOOKE \
                         | PPC_MFAPIDI | PPC_TLBIVA | PPC_TLBIVAX \
-                        | PPC_4xx_COMMON | PPC_40x_ICBT | PPC_RFMCI \
+                        | PPC_4xx_COMMON | PPC_RFMCI \
                         | PPC_RFDI | PPC_DCR | PPC_DCRX | PPC_POPCNTWD \
                         | PPC_CILDST)
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ea5eff7cf0f8..779103c0472d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5042,16 +5042,6 @@ static void gen_dcread(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
-/* icbt */
-static void gen_icbt_40x(DisasContext *ctx)
-{
-    /*
-     * interpreted as no-op
-     * XXX: specification say this is treated as a load by the MMU but
-     *      does not generate any exception
-     */
-}
-
 /* iccci */
 static void gen_iccci(DisasContext *ctx)
 {
@@ -5884,7 +5874,6 @@ GEN_HANDLER(mfdcrx, 0x1F, 0x03, 0x08, 0x00000000, PPC_DCRX),
 GEN_HANDLER(mtdcrx, 0x1F, 0x03, 0x0C, 0x00000000, PPC_DCRX),
 GEN_HANDLER(dccci, 0x1F, 0x06, 0x0E, 0x03E00001, PPC_4xx_COMMON),
 GEN_HANDLER(dcread, 0x1F, 0x06, 0x0F, 0x00000001, PPC_4xx_COMMON),
-GEN_HANDLER2(icbt_40x, "icbt", 0x1F, 0x06, 0x08, 0x03E00001, PPC_40x_ICBT),
 GEN_HANDLER(iccci, 0x1F, 0x06, 0x1E, 0x00000001, PPC_4xx_COMMON),
 GEN_HANDLER(icread, 0x1F, 0x06, 0x1F, 0x03E00001, PPC_4xx_COMMON),
 GEN_HANDLER_E(rfci, 0x13, 0x13, 0x01, 0x03FF8001, PPC_BOOKE, PPC2_BOOKE206),
-- 
2.47.1


