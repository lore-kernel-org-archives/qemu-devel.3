Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1DFCC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTY-0005lx-2l; Thu, 15 Oct 2026 08:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTQ-0005Jh-5S
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTM-0005Zk-Gq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYgfizVqdWMDMTKM4CCB+/+PsL+nYOxez2FzvRJ+U7I=;
 b=PX3cSQZbJ3fKN4Xqw8V6335V1LyhD7VqT+O1uCaGC/Teu/XgOUngTfGV5s/blYqnQchD20
 PWL5pD1et0lBrDnV82RVAPMfAWxfY16zupLxfgbj1utGc4n7Us/YjXVy5O6/FYmrjlwGuF
 sdgzQSdISohr35lXG0uSWEbHFS8x2U0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-JvSFIEk-P3ytsOTe_jc-yA-1; Thu,
 15 Oct 2026 12:22:04 +0000
X-MC-Unique: JvSFIEk-P3ytsOTe_jc-yA-1
X-Mimecast-MFC-AGG-ID: JvSFIEk-P3ytsOTe_jc-yA_1792066923
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DBCE1956076; Thu, 15 Oct 2026 12:22:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4BE27D5; Thu, 15 Oct 2026 12:22:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/21] hw/misc/aspeed_sbc: Derive ABR state from OTP config
 straps
Date: Thu, 15 Oct 2026 14:21:34 +0200
Message-ID: <20261015122151.889017-5-clg@redhat.com>
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

The eMMC ABR enable state is currently controlled by the "emmc-abr"
machine property instead of the OTP configuration.

Add helpers to read the OTP configuration and resolve strap values.
Use the ABR strap value to update ABR_EN when R_STATUS is read.

Remove the "emmc-abr" property as the ABR state is now derived from
OTP.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260918065347.3713868-3-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_sbc.h  |  1 -
 include/hw/nvram/aspeed_otp.h | 23 +++++++++++--
 hw/misc/aspeed_sbc.c          | 29 ++++++++++++----
 hw/nvram/aspeed_otp.c         | 63 +++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 10 deletions(-)

diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 756c61235697..b210ffb8aa86 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -32,7 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
 struct AspeedSBCState {
     SysBusDevice parent;
 
-    bool emmc_abr;
     uint32_t signing_settings;
 
     MemoryRegion iomem;
diff --git a/include/hw/nvram/aspeed_otp.h b/include/hw/nvram/aspeed_otp.h
index 2b6c2eaaa353..f91af12ea9ef 100644
--- a/include/hw/nvram/aspeed_otp.h
+++ b/include/hw/nvram/aspeed_otp.h
@@ -24,11 +24,27 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPState, ASPEED_OTP)
  *
  *  - [0, OTP_DATA_DWORD_COUNT]: the data region. Each address contains
  *    64 bits of data.
- *  - [OTP_DATA_DWORD_COUNT, OTP_MEMORY_SIZE / 4]: the configuration
- *    region. Each address contains 32 bits of data.
+ *  - [OTP_DATA_DWORD_COUNT(OTP_CFG0), OTP_MEMORY_SIZE / 4]: the
+ *    configuration region. Each address contains 32 bits of data.
  */
 #define OTP_DATA_DWORD_COUNT            (0x800)
 
+/* Start of the OTP configuration/strap region. */
+#define OTP_CFG0                        (0x800)
+
+/*
+ * OTP straps are a 64-bit value packed as two 32-bit halves starting at
+ * config word OTP_STRAP_START_INDEX (OTPCFG16 and OTPCFG17). Each strap
+ * bit is stored redundantly in OTP_STRAP_COPY_NUM config words, spaced
+ * (OTP_STRAP_BIT_NUM / 32) words apart -- i.e. one word per 32-bit half,
+ * so the two halves interleave; the effective bit value is the XOR of
+ * all copies, matching how the real hardware and the ast-otp reference
+ * tool resolve straps.
+ */
+#define OTP_STRAP_START_INDEX           16
+#define OTP_STRAP_BIT_NUM               64
+#define OTP_STRAP_COPY_NUM              6
+
 typedef struct AspeedOTPState {
     DeviceState parent_obj;
 
@@ -43,4 +59,7 @@ typedef struct AspeedOTPState {
     uint8_t *storage;
 } AspeedOTPState;
 
+uint32_t aspeed_otp_read_config(AspeedOTPState *s, unsigned int cfg_word);
+bool aspeed_otp_read_strap(AspeedOTPState *s, unsigned int bit);
+
 #endif /* ASPEED_OTP_H */
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 3402cef5c3ec..6cec9ad3daf0 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -71,6 +71,9 @@
 #define SBC_OTP_CMD_WRITE 0x23b1e362
 #define SBC_OTP_CMD_PROG 0x23b1e364
 
+/* OTP strap bits */
+#define OTP_STRAP_ABR_EN        0x2b
+
 /* Voltage mode */
 #define MODE_REGISTER               (0x1000)
 #define MODE_REGISTER_A             (0x3000)
@@ -89,7 +92,21 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
         return 0;
     }
 
-    return s->regs[addr];
+    switch (addr) {
+    case R_STATUS: {
+        uint32_t val = s->regs[R_STATUS];
+
+        if (aspeed_otp_read_strap(&s->otp, OTP_STRAP_ABR_EN)) {
+            val |= ABR_EN;
+        } else {
+            val &= ~ABR_EN;
+        }
+
+        return val;
+    }
+    default:
+        return s->regs[addr];
+    }
 }
 
 static bool aspeed_otp_read(AspeedSBCState *s, uint32_t otp_addr,
@@ -388,13 +405,12 @@ static void aspeed_sbc_reset_hold(Object *obj, ResetType type)
 
     memset(s->regs, 0, sizeof(s->regs));
 
-    /* Set secure boot enabled with RSA4096_SHA256 and enable eMMC ABR */
+    /*
+     * ABR_EN is derived from OTP on every read, see aspeed_sbc_read().
+     * Set secure boot enabled with RSA4096_SHA256.
+     */
     s->regs[R_STATUS] = OTP_IDLE | OTP_MEM_IDLE;
 
-    if (s->emmc_abr) {
-        s->regs[R_STATUS] &= ABR_EN;
-    }
-
     if (s->signing_settings) {
         s->regs[R_STATUS] &= SECURE_BOOT_EN;
     }
@@ -452,7 +468,6 @@ static const VMStateDescription vmstate_aspeed_sbc = {
 };
 
 static const Property aspeed_sbc_properties[] = {
-    DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
     DEFINE_PROP_LINK("sram", AspeedSBCState, sram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
index 81304bda3abe..127da15642f2 100644
--- a/hw/nvram/aspeed_otp.c
+++ b/hw/nvram/aspeed_otp.c
@@ -106,6 +106,69 @@ static void aspeed_otp_write(void *opaque, hwaddr otp_offset,
     trace_aspeed_otp_prog(otp_offset, val, value);
 }
 
+/*
+ * Each OTP configuration setting contains 32 bits of data.
+ * Configuration words are grouped in banks of 8, with banks spaced
+ * 0x200 dwords apart and words within a bank spaced 2 dwords apart:
+ *
+ *   offset(n) = OTP_CFG0 + (n / 8) * 0x200 + (n % 8) * 2
+ *
+ * Returns 0 if the OTP read fails.
+ */
+uint32_t aspeed_otp_read_config(AspeedOTPState *s, unsigned int cfg_word)
+{
+    uint32_t otp_addr = OTP_CFG0 + (cfg_word / 8) * 0x200 + (cfg_word % 8) * 2;
+    uint32_t value = 0;
+
+    if (address_space_read(&s->as, otp_addr << 2, MEMTXATTRS_UNSPECIFIED,
+                            &value, sizeof(value)) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to read OTP config word %u\n",
+                      __func__, cfg_word);
+        return 0;
+    }
+
+    return value;
+}
+
+/*
+ * OTP straps are a 64-bit value split across two 32-bit config words,
+ * each of which is repeated OTP_STRAP_COPY_NUM times for reliability.
+ * The two words interleave starting at OTP_STRAP_START_INDEX:
+ *
+ *   cfg_word:    16   17   18   19   20   21   22   23   24   25   26   27
+ *              +----+----+----+----+----+----+----+----+----+----+----+----+
+ *              | L0 | H0 | L1 | H1 | L2 | H2 | L3 | H3 | L4 | H4 | L5 | H5 |
+ *              +----+----+----+----+----+----+----+----+----+----+----+----+
+ *
+ *   Lx = copy #x of bit 0-31, Hx = copy #x of bit 32-63
+ *   (x = 0 .. OTP_STRAP_COPY_NUM - 1)
+ *
+ * To resolve strap bit `n` (0 <= n < OTP_STRAP_BIT_NUM):
+ *   half    = n / 32   -- 0 selects the L* words, 1 selects the H* words
+ *   bit_pos = n % 32   -- bit position within the word
+ *   word(i) = OTP_STRAP_START_INDEX + half + i * (OTP_STRAP_BIT_NUM / 32)
+ *
+ * The effective value of bit `n` is the XOR of bit `bit_pos` across all
+ * OTP_STRAP_COPY_NUM copies of word(i).
+ */
+bool aspeed_otp_read_strap(AspeedOTPState *s, unsigned int bit)
+{
+    uint32_t cfg_word = OTP_STRAP_START_INDEX + bit / 32;
+    uint32_t bit_pos = bit % 32;
+    bool enable = false;
+    int i;
+
+    assert(bit < OTP_STRAP_BIT_NUM);
+
+    for (i = 0; i < OTP_STRAP_COPY_NUM; i++) {
+        enable ^= (aspeed_otp_read_config(s, cfg_word) >> bit_pos) & 0x1;
+        cfg_word += OTP_STRAP_BIT_NUM / 32;
+    }
+
+    return enable;
+}
+
 static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
 {
     uint32_t *p;
-- 
2.56.0


