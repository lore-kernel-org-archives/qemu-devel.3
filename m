Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B98BCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTQ-0005KT-M3; Thu, 15 Oct 2026 08:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTL-00053A-UF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTK-0005ZA-2e
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9M2xBgQWPWaVKo67VqFCMKG1rJuA68OyjWlVr/7Q7pw=;
 b=TtolOz9innCRYZf8whl6/wJSB2VDW45lS+IMjmB1IJIlboP54I/elBovP4AI72mIvNmISR
 AdhEg0ZvPIMvBKtOZgq27R2TIGgashfiFihRhnbX/YSvZrddmXgTn/UvxFYbtCpJjQdej8
 SLwqedLH7Zke1SARaDFDL/dNYE6/6SI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-eLSo1SugP4KErEfol1qAYQ-1; Thu,
 15 Oct 2026 12:22:06 +0000
X-MC-Unique: eLSo1SugP4KErEfol1qAYQ-1
X-Mimecast-MFC-AGG-ID: eLSo1SugP4KErEfol1qAYQ_1792066925
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37AFE1944D20; Thu, 15 Oct 2026 12:22:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9B4F7D8; Thu, 15 Oct 2026 12:22:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/21] hw/misc/aspeed_sbc: Derive secure boot state from OTP
 config
Date: Thu, 15 Oct 2026 14:21:35 +0200
Message-ID: <20261015122151.889017-6-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Kane Chen <kane_chen@aspeedtech.com>

The secure boot state is currently controlled by the
"signing-settings" machine property instead of the OTP configuration.

Derive SECURE_BOOT_EN and R_QSR from the OTP configuration when the
registers are read.

Remove the "signing-settings" property as the secure boot state is now
derived from OTP.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260918065347.3713868-4-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_sbc.h |  2 --
 hw/misc/aspeed_sbc.c         | 22 +++++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index b210ffb8aa86..7f3fa7062f96 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -32,8 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
 struct AspeedSBCState {
     SysBusDevice parent;
 
-    uint32_t signing_settings;
-
     MemoryRegion iomem;
 
     uint32_t regs[ASPEED_SBC_NR_REGS];
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 6cec9ad3daf0..ad4c2b4b1d0c 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -79,6 +79,8 @@
 #define MODE_REGISTER_A             (0x3000)
 #define MODE_REGISTER_B             (0x5000)
 
+static bool aspeed_sbc_otp_read(AspeedSBCState *s, uint32_t otp_addr);
+
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -102,8 +104,16 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
             val &= ~ABR_EN;
         }
 
+        if (aspeed_otp_read_config(&s->otp, 0) & BIT(1)) {
+            val |= SECURE_BOOT_EN;
+        } else {
+            val &= ~SECURE_BOOT_EN;
+        }
+
         return val;
     }
+    case R_QSR:
+        return aspeed_otp_read_config(&s->otp, 0);
     default:
         return s->regs[addr];
     }
@@ -406,16 +416,11 @@ static void aspeed_sbc_reset_hold(Object *obj, ResetType type)
     memset(s->regs, 0, sizeof(s->regs));
 
     /*
-     * ABR_EN is derived from OTP on every read, see aspeed_sbc_read().
-     * Set secure boot enabled with RSA4096_SHA256.
+     * ABR_EN and SECURE_BOOT_EN are derived from OTP on every read, see
+     * aspeed_sbc_read(), since the SBC status register is just a
+     * reflection of the OTP fuse state.
      */
     s->regs[R_STATUS] = OTP_IDLE | OTP_MEM_IDLE;
-
-    if (s->signing_settings) {
-        s->regs[R_STATUS] &= SECURE_BOOT_EN;
-    }
-
-    s->regs[R_QSR] = s->signing_settings;
 }
 
 static void aspeed_sbc_instance_init(Object *obj)
@@ -468,7 +473,6 @@ static const VMStateDescription vmstate_aspeed_sbc = {
 };
 
 static const Property aspeed_sbc_properties[] = {
-    DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
     DEFINE_PROP_LINK("sram", AspeedSBCState, sram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
-- 
2.56.0


