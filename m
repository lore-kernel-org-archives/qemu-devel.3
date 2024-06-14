Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051EDC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1LX-0003DS-NC; Fri, 14 Jun 2024 03:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1LW-0003Cf-7G
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1LU-0000ka-Qn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J6U16qrXeLb/asNfTGBlt6h0s0DAuaM230HKBqvUWQ=;
 b=ZshNH0QAA/Z9xntcSD2rpqk5NotTWJ38FtWMHS8ZUx514wK+hu467Cu2SngDWYOgtyGykM
 wz314usfIK25w6+GBu60wSBpy1a+JdYIrxU3vKdHKrIBfz1WW7++oVPQ0yK1v/ml/MT2uH
 UsWhdsZ2ACDNSv7a/+ABxPL+3NC9FKc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-cYX1J6iCP3eRQgpTECFXXg-1; Fri,
 14 Jun 2024 03:27:34 -0400
X-MC-Unique: cYX1J6iCP3eRQgpTECFXXg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FFD219560B0; Fri, 14 Jun 2024 07:27:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F103B3000219; Fri, 14 Jun 2024 07:27:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 04/19] aspeed/sdmc: remove redundant macros
Date: Fri, 14 Jun 2024 09:26:05 +0200
Message-ID: <20240614072620.1262053-5-clg@redhat.com>
In-Reply-To: <20240614072620.1262053-1-clg@redhat.com>
References: <20240614072620.1262053-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

These macros are no longer used for ASPEED SOCs, so removes them.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/misc/aspeed_sdmc.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 64cd1a81dcd2..74279bbe8ee7 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -76,10 +76,6 @@
 #define     ASPEED_SDMC_VGA_32MB            0x2
 #define     ASPEED_SDMC_VGA_64MB            0x3
 #define ASPEED_SDMC_DRAM_SIZE(x)        (x & 0x3)
-#define     ASPEED_SDMC_DRAM_64MB           0x0
-#define     ASPEED_SDMC_DRAM_128MB          0x1
-#define     ASPEED_SDMC_DRAM_256MB          0x2
-#define     ASPEED_SDMC_DRAM_512MB          0x3
 
 #define ASPEED_SDMC_READONLY_MASK                       \
     (ASPEED_SDMC_RESERVED | ASPEED_SDMC_VGA_COMPAT |    \
@@ -100,17 +96,6 @@
 #define ASPEED_SDMC_CACHE_ENABLE        (1 << 10) /* differs from AST2400 */
 #define ASPEED_SDMC_DRAM_TYPE           (1 << 4)  /* differs from AST2400 */
 
-/* DRAM size definitions differs */
-#define     ASPEED_SDMC_AST2500_128MB       0x0
-#define     ASPEED_SDMC_AST2500_256MB       0x1
-#define     ASPEED_SDMC_AST2500_512MB       0x2
-#define     ASPEED_SDMC_AST2500_1024MB      0x3
-
-#define     ASPEED_SDMC_AST2600_256MB       0x0
-#define     ASPEED_SDMC_AST2600_512MB       0x1
-#define     ASPEED_SDMC_AST2600_1024MB      0x2
-#define     ASPEED_SDMC_AST2600_2048MB      0x3
-
 #define ASPEED_SDMC_AST2500_READONLY_MASK                               \
     (ASPEED_SDMC_HW_VERSION(0xf) | ASPEED_SDMC_CACHE_INITIAL_DONE |     \
      ASPEED_SDMC_AST2500_RESERVED | ASPEED_SDMC_VGA_COMPAT |            \
-- 
2.45.2


