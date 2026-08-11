Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DE2C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPX-0006sm-Ty; Tue, 11 Aug 2026 12:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPF-0005j8-HW
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPC-00016R-T7
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBNby7R+cz94z1o7+dz3UnoJdPTQIrs6Pr2uE7tn03Q=;
 b=SKJqQwIA7ChfCwW4YcltfmeCOkgaf2Wm8/JROR27saO/qMze3IRTSPpFUS8fsaYn7iWeYt
 rRhyioElfuc4tSBWfp5+DmH+wdChjPPz5pHt90QLZW6jL3Tn+XGnHdF+pUgERgyV7nYObw
 BNVyYXWIAz4/mdWuFpauMZDGsd0M4eA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-IvPL1vn5OtyOWIXTdFi2kA-1; Tue,
 11 Aug 2026 12:32:41 -0400
X-MC-Unique: IvPL1vn5OtyOWIXTdFi2kA-1
X-Mimecast-MFC-AGG-ID: IvPL1vn5OtyOWIXTdFi2kA_1786465960
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 326FB1954B0C; Tue, 11 Aug 2026 16:32:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BAFA195DF91; Tue, 11 Aug 2026 16:32:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 82/83] hw/misc/aspeed_hace: Enable the crypto command on the
 AST2700
Date: Tue, 11 Aug 2026 18:29:37 +0200
Message-ID: <20260811162938.1403216-83-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

With direct/scatter-gather access, 64-bit DMA and AES-GCM all in place,
the AST2700 crypto engine is now fully modelled. Drop its temporary
interrupt-only workaround so the crypto command runs for real, like the
other HACE variants.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-16-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_hace.h |  1 -
 hw/misc/aspeed_hace.c         | 15 +--------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index b5416b0cb5d3..9b0e7683fa88 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -49,7 +49,6 @@ struct AspeedHACEClass {
     uint32_t key_mask;
     uint32_t hash_mask;
     uint64_t nr_regs;
-    bool raise_crypt_interrupt_workaround;
     uint32_t src_hi_mask;
     uint32_t dest_hi_mask;
     uint32_t key_hi_mask;
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 23dacc9be85e..8de05a9d98b3 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -1005,14 +1005,7 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     }
     case R_CRYPT_CMD:
-        /*
-         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which are
-         * added later; until then it keeps the temporary workaround of only
-         * raising the completion interrupt without running the command.
-         */
-        if (!ahc->raise_crypt_interrupt_workaround) {
-            do_crypt_operation(s, data);
-        }
+        do_crypt_operation(s, data);
 
         /* Hardware raises the crypt interrupt once the command finishes. */
         s->regs[R_STATUS] |= CRYPT_IRQ;
@@ -1214,12 +1207,6 @@ static void aspeed_ast2700_hace_class_init(ObjectClass *klass, const void *data)
     ahc->dest_hi_mask = 0x00000003;
     ahc->key_hi_mask = 0x00000003;
 
-    /*
-     * Currently, it does not support the CRYPT command. Instead, it only
-     * sends an interrupt to notify the firmware that the crypt command
-     * has completed. It is a temporary workaround.
-     */
-    ahc->raise_crypt_interrupt_workaround = true;
     ahc->has_dma64 = true;
 }
 
-- 
2.55.0


