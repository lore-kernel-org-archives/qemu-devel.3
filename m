Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED90C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb26z-0006z9-Cb; Mon, 05 Aug 2024 14:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26u-0006da-QH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26s-0006P2-Mz
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so33815945e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881224; x=1723486024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZWaQyKyexW3bnn4M8r/s9Z7AMSU2Vex5ont4FDielg=;
 b=jBXNXeFOEhsa/F6X6nmT/SVmUlterKy0oVWzujWdJsHG/hDu0j96fQFp03LtV7dvjF
 qG4YgY7xPfOayIOZH/78Jj0sRfcVHyG5zvfxgIWLXOHBXSmVeLIo9ALXER080/l5YRC2
 rnJ5o9PxWjw9+kPD3GVKXx36vsicjg8pRCbkURfJyaFGWTmeNVK7HJsq+t3L3097KOqS
 FJx5jHPkR0KAkLcYzyRthP0kl2B5laXpJQHkb5095mqAWXwfojb0ZeUNMEOVkEmgF/Fc
 txTrGwrbscLA2Ddu5YbWwcBOjnvAAdqLlttoAV1p5H+r0is1tE5kDnJshKFEl0WvC+L4
 orcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881224; x=1723486024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZWaQyKyexW3bnn4M8r/s9Z7AMSU2Vex5ont4FDielg=;
 b=XfzZLLLoah9ounDlsiEC7uAXfu+N84FC2/IwNzC7LGw7H9F20XgraC2ui9Na2PoRUv
 Ed5o6OW4qCISeprxjNbyvod2uC4wsGEEpEtXrrgDcjjJyvOC2epUaY8/4eIOVbmCNjZq
 wxRit6vtxXtUs5VEt1txb7IB/DcHc5wraSF/hQAdb34k0Ay0cvdAn28einBeVzgQamCr
 fX7M5Zf5SLHHVYvE4XfmP5QKwv8/UbH/j1sN9y6CJ6mlperXrbyrpYQ7Jq4pUoV3U5pu
 +kj1PfTk0gPr9hwbpOPxpI2VkBjmQjce9sXbNDrK8UmHYNbdFBDmhPo41lmkGwwszPzt
 9B6Q==
X-Gm-Message-State: AOJu0YzBUJhzLi2q6nhOx11pZ85rdPP0TTYfeoIK/Uey/vO56P9I5ybd
 Pau603jZ3rIKPNsyFc0ABwWF6FUbl6k96y0c2AXXMO+IYY8wgcRZyHIUcNNqN7aphaa0dzeOPkw
 a
X-Google-Smtp-Source: AGHT+IGBMZkKwufo8VugR6m1fqoMkUsCBufs5z9mSF4SgdxGWwu8JzMSG6CMEUhGh/8tKxKnO0Df4g==
X-Received: by 2002:a05:600c:4746:b0:428:1799:35e3 with SMTP id
 5b1f17b1804b1-428e6b2c884mr81053365e9.21.1722881224592; 
 Mon, 05 Aug 2024 11:07:04 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89aa86sm210627885e9.3.2024.08.05.11.07.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 06/15] hw/intc/loongson_ipi: Move IPICore structure
 to loongson_ipi_common.h
Date: Mon,  5 Aug 2024 20:06:13 +0200
Message-ID: <20240805180622.21001-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Move the IPICore structure and corresponding common fields
of LoongsonIPICommonState to "hw/intc/loongson_ipi_common.h".

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-10-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h        | 17 ---------
 include/hw/intc/loongson_ipi_common.h | 18 ++++++++++
 hw/intc/loongson_ipi.c                | 50 ++++++---------------------
 hw/intc/loongson_ipi_common.c         | 42 ++++++++++++++++++++++
 4 files changed, 70 insertions(+), 57 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 5a52dfbf4d..4e517cc8dc 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -12,22 +12,9 @@
 #include "hw/intc/loongson_ipi_common.h"
 #include "hw/sysbus.h"
 
-#define IPI_MBX_NUM           4
-
 #define TYPE_LOONGSON_IPI "loongson_ipi"
 OBJECT_DECLARE_TYPE(LoongsonIPIState, LoongsonIPIClass, LOONGSON_IPI)
 
-typedef struct IPICore {
-    LoongsonIPIState *ipi;
-    uint32_t status;
-    uint32_t en;
-    uint32_t set;
-    uint32_t clear;
-    /* 64bit buf divide into 2 32bit buf */
-    uint32_t buf[IPI_MBX_NUM * 2];
-    qemu_irq irq;
-} IPICore;
-
 struct LoongsonIPIClass {
     LoongsonIPICommonClass parent_class;
 
@@ -39,10 +26,6 @@ struct LoongsonIPIState {
     LoongsonIPICommonState parent_obj;
 
     MemoryRegion *ipi_mmio_mem;
-    MemoryRegion ipi_iocsr_mem;
-    MemoryRegion ipi64_iocsr_mem;
-    uint32_t num_cpu;
-    IPICore *cpu;
 };
 
 #endif
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index b43b77bda6..967c70ad1c 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -11,12 +11,30 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"
 
+#define IPI_MBX_NUM           4
+
 #define TYPE_LOONGSON_IPI_COMMON "loongson_ipi_common"
 OBJECT_DECLARE_TYPE(LoongsonIPICommonState,
                     LoongsonIPICommonClass, LOONGSON_IPI_COMMON)
 
+typedef struct IPICore {
+    LoongsonIPICommonState *ipi;
+    uint32_t status;
+    uint32_t en;
+    uint32_t set;
+    uint32_t clear;
+    /* 64bit buf divide into 2 32-bit buf */
+    uint32_t buf[IPI_MBX_NUM * 2];
+    qemu_irq irq;
+} IPICore;
+
 struct LoongsonIPICommonState {
     SysBusDevice parent_obj;
+
+    MemoryRegion ipi_iocsr_mem;
+    MemoryRegion ipi64_iocsr_mem;
+    uint32_t num_cpu;
+    IPICore *cpu;
 };
 
 struct LoongsonIPICommonClass {
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 03878b896f..347bc26729 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -64,7 +64,7 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
                                             uint64_t *data,
                                             unsigned size, MemTxAttrs attrs)
 {
-    LoongsonIPIState *ipi = opaque;
+    LoongsonIPICommonState *ipi = opaque;
     IPICore *s;
 
     if (attrs.requester_id >= ipi->num_cpu) {
@@ -160,7 +160,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
                                             MemTxAttrs attrs)
 {
     IPICore *s = opaque;
-    LoongsonIPIState *ipi = s->ipi;
+    LoongsonIPICommonState *ipi = s->ipi;
     int index = 0;
     uint32_t cpuid;
     uint8_t vector;
@@ -214,7 +214,7 @@ static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
                                             uint64_t val, unsigned size,
                                             MemTxAttrs attrs)
 {
-    LoongsonIPIState *ipi = opaque;
+    LoongsonIPICommonState *ipi = opaque;
     IPICore *s;
 
     if (attrs.requester_id >= ipi->num_cpu) {
@@ -277,7 +277,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
 
 static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
 {
-    LoongsonIPIState *s = LOONGSON_IPI(dev);
+    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     int i;
 
@@ -310,6 +310,7 @@ static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
 
 static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 {
+    LoongsonIPICommonState *sc = LOONGSON_IPI_COMMON(dev);
     LoongsonIPIState *s = LOONGSON_IPI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
@@ -320,18 +321,19 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    s->ipi_mmio_mem = g_new0(MemoryRegion, s->num_cpu);
-    for (unsigned i = 0; i < s->num_cpu; i++) {
+    s->ipi_mmio_mem = g_new0(MemoryRegion, sc->num_cpu);
+    for (unsigned i = 0; i < sc->num_cpu; i++) {
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
+
         memory_region_init_io(&s->ipi_mmio_mem[i], OBJECT(dev),
-                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
+                              &loongson_ipi_core_ops, &sc->cpu[i], name, 0x48);
         sysbus_init_mmio(sbd, &s->ipi_mmio_mem[i]);
     }
 }
 
 static void loongson_ipi_common_unrealize(DeviceState *dev)
 {
-    LoongsonIPIState *s = LOONGSON_IPI(dev);
+    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
 
     g_free(s->cpu);
 }
@@ -345,36 +347,6 @@ static void loongson_ipi_unrealize(DeviceState *dev)
     loongson_ipi_common_unrealize(dev);
 }
 
-static const VMStateDescription vmstate_ipi_core = {
-    .name = "ipi-single",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(status, IPICore),
-        VMSTATE_UINT32(en, IPICore),
-        VMSTATE_UINT32(set, IPICore),
-        VMSTATE_UINT32(clear, IPICore),
-        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_loongson_ipi = {
-    .name = TYPE_LOONGSON_IPI,
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPIState, num_cpu,
-                         vmstate_ipi_core, IPICore),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static Property ipi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongsonIPIState, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -384,8 +356,6 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
                                     &lic->parent_realize);
     device_class_set_parent_unrealize(dc, loongson_ipi_unrealize,
                                       &lic->parent_unrealize);
-    device_class_set_props(dc, ipi_properties);
-    dc->vmsd = &vmstate_loongson_ipi;
 }
 
 static const TypeInfo loongson_ipi_types[] = {
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 43002fe556..47796f7ece 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -8,6 +8,47 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi_common.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+static const VMStateDescription vmstate_ipi_core = {
+    .name = "ipi-single",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(status, IPICore),
+        VMSTATE_UINT32(en, IPICore),
+        VMSTATE_UINT32(set, IPICore),
+        VMSTATE_UINT32(clear, IPICore),
+        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_loongson_ipi_common = {
+    .name = "loongson_ipi",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPICommonState,
+                                             num_cpu, vmstate_ipi_core,
+                                             IPICore),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property ipi_common_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, ipi_common_properties);
+    dc->vmsd = &vmstate_loongson_ipi_common;
+}
 
 static const TypeInfo loongarch_ipi_common_types[] = {
     {
@@ -15,6 +56,7 @@ static const TypeInfo loongarch_ipi_common_types[] = {
         .parent             = TYPE_SYS_BUS_DEVICE,
         .instance_size      = sizeof(LoongsonIPICommonState),
         .class_size         = sizeof(LoongsonIPICommonClass),
+        .class_init         = loongson_ipi_common_class_init,
         .abstract           = true,
     }
 };
-- 
2.45.2


