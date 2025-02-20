Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463B3C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JN-0007DZ-Ul; Thu, 20 Feb 2025 11:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JM-0007CA-Ok
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JK-0008Fx-Im
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:04 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso7477845e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068521; x=1740673321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ao49HT4i9O6KBX65SL+cSZHbatLDTW2o2wBoVzrSVmQ=;
 b=DofQtM2AlXffamDUXKCDsFX++9sgT3LsKTmyuD8UqDtENuKc4jmUDZgEVIt5XwzbVu
 IkkWze3TsClCAvSeHy+uhpCy2TznyO1x5Wr1HCL+QePhUCAmimhCM4Y81CFIow6vS1bS
 h5zD/JKLmawgT3+va+pYiRA6RhJhN2hrEGQRsitr1gbYe961YihtHVvQN4sUfCOsMums
 R0Dvfmj12jnaLoB/TFK0YGuQcsCMCMAoawrJeI5AJABHHJrlE0JJR4PuYDtFohZuVPr4
 1wesz6HCqq5Oo0yXEGrOMp2B7DnVedYekTnXzSgubAH1dOQXdQG5T31tKPSQY9BXQFLj
 jo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068521; x=1740673321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ao49HT4i9O6KBX65SL+cSZHbatLDTW2o2wBoVzrSVmQ=;
 b=DdTE7361B/jJwaOSGNcjB8EoJbRs0bOQtHaB4UwAWVzoWZrn+Nf1vnBit/d8wDuJ73
 F5dlf4EeM2z2rh7hlte8bJy3N+gjSbhgCdCUCMgvcPB/bVxcvppLk0swDZlLHSXI/62Z
 sZgZtMqURotz2L5lvO0u3SLDkaRhOoB8IWAqMXYPD2CLz5tleI74z4ZKJgZpzu1vFK1y
 tE2UUdE6Loj8kMA52RKEeGjxAZOhbvnt2VSqOUSnYRMDYVUsIiT1OEq4rJG6eLTGDQ0a
 N1kg/IhmhVli7jmlY0m3gFO0Ws77vc9MDHwxjaNRiWQ7souitQn71idDllXubu/jlVJk
 a2cA==
X-Gm-Message-State: AOJu0YxjYcGEtqRmBREhSDoUnwg1PJdMrD5/EThzfdbXLbE/2Wnw7h76
 dPXa4QfzTaHIevA6OnAbCjz9c/YlYr+bNblY7IautbR7hLeKPVAwKbbwuEAKBt96JGXLAHQC4S0
 6
X-Gm-Gg: ASbGncsc/gNDRaUgVd2iSERKRjAG43zGcp+JIiziTNTZURUprPlBbWfMsz6gqfJ6nf8
 PdENyDB6KkQ9JsHMP//vQ7GvHq9c/6A+DsohZSdOT6cqfA5+nhHRr9n6ddCu1t0GXsD279HJFo9
 BBMWgCCyuSsAYr+tdReB1SmIDZgeKSAMlylLnn82ITM1SsVwjnq7kIKV7ZEorKdxLMNN6wIegtM
 niP3chlWLS/M4FLrkRkr3g2wxBvP8HZObzoHmZJa8kT3Gi1YmlrpaVIs6I4+TcpPZ08IcLU8Wdj
 St3u1EtJk8DsHY2N9MiUqw==
X-Google-Smtp-Source: AGHT+IGoNp7HkztD6VxtqWbfIzUdpZ1buPFMEhepkulcaCpOEbhsKbjD7V5eprB6ij5aE+qNfbtC9w==
X-Received: by 2002:a05:600c:4e8c:b0:439:9274:81db with SMTP id
 5b1f17b1804b1-43999d76ddcmr89758445e9.5.1740068520854; 
 Thu, 20 Feb 2025 08:22:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/41] hw/misc: Move NPCM7XX GCR to NPCM GCR
Date: Thu, 20 Feb 2025 16:21:10 +0000
Message-ID: <20250220162123.626941-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

A lot of NPCM7XX and NPCM8XX GCR modules share the same code,
this commit moves the NPCM7XX GCR to NPCM GCR for these
properties.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-6-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm7xx.h   |  2 +-
 include/hw/misc/npcm_gcr.h |  7 +--
 hw/misc/npcm_gcr.c         | 92 +++++++++++++++++++++-----------------
 hw/misc/trace-events       |  6 +--
 4 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 510170471e0..2e708471ece 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -89,7 +89,7 @@ struct NPCM7xxState {
     MemoryRegion        ram3;
     MemoryRegion        *dram;
 
-    NPCM7xxGCRState     gcr;
+    NPCMGCRState        gcr;
     NPCM7xxCLKState     clk;
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxADCState     adc;
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 9b4998950cc..6d3d00d2602 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -55,7 +55,7 @@
  */
 #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
 
-struct NPCM7xxGCRState {
+typedef struct NPCMGCRState {
     SysBusDevice parent;
 
     MemoryRegion iomem;
@@ -65,9 +65,10 @@ struct NPCM7xxGCRState {
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
-};
+} NPCMGCRState;
 
+#define TYPE_NPCM_GCR "npcm-gcr"
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxGCRState, NPCM7XX_GCR)
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMGCRState, NPCM_GCR)
 
 #endif /* NPCM_GCR_H */
diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 826fd41123b..0959f2e5c4b 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -84,10 +84,10 @@ static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
     [NPCM7XX_GCR_USB2PHYCTL]    = 0x034730e4,
 };
 
-static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxGCRState *s = opaque;
+    NPCMGCRState *s = opaque;
 
     if (reg >= NPCM7XX_GCR_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -96,19 +96,19 @@ static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
         return 0;
     }
 
-    trace_npcm7xx_gcr_read(offset, s->regs[reg]);
+    trace_npcm_gcr_read(offset, s->regs[reg]);
 
     return s->regs[reg];
 }
 
-static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
+static void npcm_gcr_write(void *opaque, hwaddr offset,
                               uint64_t v, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxGCRState *s = opaque;
+    NPCMGCRState *s = opaque;
     uint32_t value = v;
 
-    trace_npcm7xx_gcr_write(offset, value);
+    trace_npcm_gcr_write(offset, value);
 
     if (reg >= NPCM7XX_GCR_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -142,9 +142,9 @@ static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
     s->regs[reg] = value;
 }
 
-static const struct MemoryRegionOps npcm7xx_gcr_ops = {
-    .read       = npcm7xx_gcr_read,
-    .write      = npcm7xx_gcr_write,
+static const struct MemoryRegionOps npcm_gcr_ops = {
+    .read       = npcm_gcr_read,
+    .write      = npcm_gcr_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid      = {
         .min_access_size        = 4,
@@ -155,7 +155,7 @@ static const struct MemoryRegionOps npcm7xx_gcr_ops = {
 
 static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
 {
-    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
+    NPCMGCRState *s = NPCM_GCR(obj);
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
@@ -165,10 +165,10 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
 }
 
-static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
+static void npcm_gcr_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    NPCM7xxGCRState *s = NPCM7XX_GCR(dev);
+    NPCMGCRState *s = NPCM_GCR(dev);
     uint64_t dram_size;
     Object *obj;
 
@@ -210,55 +210,65 @@ static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
     s->reset_intcr3 |= ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) << 8;
 }
 
-static void npcm7xx_gcr_init(Object *obj)
+static void npcm_gcr_init(Object *obj)
 {
-    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
+    NPCMGCRState *s = NPCM_GCR(obj);
 
-    memory_region_init_io(&s->iomem, obj, &npcm7xx_gcr_ops, s,
-                          TYPE_NPCM7XX_GCR, 4 * KiB);
+    memory_region_init_io(&s->iomem, obj, &npcm_gcr_ops, s,
+                          TYPE_NPCM_GCR, 4 * KiB);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
 }
 
-static const VMStateDescription vmstate_npcm7xx_gcr = {
-    .name = "npcm7xx-gcr",
-    .version_id = 0,
-    .minimum_version_id = 0,
+static const VMStateDescription vmstate_npcm_gcr = {
+    .name = "npcm-gcr",
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, NPCM7xxGCRState, NPCM7XX_GCR_NR_REGS),
+        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM7XX_GCR_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
 };
 
-static const Property npcm7xx_gcr_properties[] = {
-    DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0),
-    DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0),
+static const Property npcm_gcr_properties[] = {
+    DEFINE_PROP_UINT32("disabled-modules", NPCMGCRState, reset_mdlr, 0),
+    DEFINE_PROP_UINT32("power-on-straps", NPCMGCRState, reset_pwron, 0),
 };
 
-static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
+static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 {
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
+    dc->realize = npcm_gcr_realize;
+    dc->vmsd = &vmstate_npcm_gcr;
 
+    device_class_set_props(dc, npcm_gcr_properties);
+}
+
+static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END != NPCM7XX_GCR_NR_REGS);
     dc->desc = "NPCM7xx System Global Control Registers";
-    dc->realize = npcm7xx_gcr_realize;
-    dc->vmsd = &vmstate_npcm7xx_gcr;
     rc->phases.enter = npcm7xx_gcr_enter_reset;
 
-    device_class_set_props(dc, npcm7xx_gcr_properties);
 }
 
-static const TypeInfo npcm7xx_gcr_info = {
-    .name               = TYPE_NPCM7XX_GCR,
-    .parent             = TYPE_SYS_BUS_DEVICE,
-    .instance_size      = sizeof(NPCM7xxGCRState),
-    .instance_init      = npcm7xx_gcr_init,
-    .class_init         = npcm7xx_gcr_class_init,
+static const TypeInfo npcm_gcr_info[] = {
+    {
+        .name               = TYPE_NPCM_GCR,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(NPCMGCRState),
+        .instance_init      = npcm_gcr_init,
+        .class_init         = npcm_gcr_class_init,
+        .abstract           = true,
+    },
+    {
+        .name               = TYPE_NPCM7XX_GCR,
+        .parent             = TYPE_NPCM_GCR,
+        .class_init         = npcm7xx_gcr_class_init,
+    },
 };
-
-static void npcm7xx_gcr_register_type(void)
-{
-    type_register_static(&npcm7xx_gcr_info);
-}
-type_init(npcm7xx_gcr_register_type);
+DEFINE_TYPES(npcm_gcr_info)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b35b0e77f7d..0f7204a237e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -134,9 +134,9 @@ mos6522_read(uint64_t addr, const char *name, unsigned val) "reg=0x%"PRIx64 " [%
 npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
-# npcm7xx_gcr.c
-npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
-npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+# npcm_gcr.c
+npcm_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
 # npcm7xx_mft.c
 npcm7xx_mft_read(const char *name, uint64_t offset, uint16_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-- 
2.43.0


