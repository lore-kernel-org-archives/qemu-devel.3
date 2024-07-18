Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A03C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURGt-0006Yq-M3; Thu, 18 Jul 2024 09:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGs-0006U7-FB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGq-0008Tg-Gt
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3686b285969so56069f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309647; x=1721914447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5/k8L384L3wuw6eUDlmJEyK1Cofx+7INGx2FWPkB4s=;
 b=J54g9hVICpesu8SwF5MPOtWDOVvieA/ydspDu/y2WUC2+Z6pzluxbYi5Dyc13wizb/
 7nBJS5ee3iwOBypBzok42TtTWlTEF7g4I3UkiocqwPr8zj0P1b7nr6zA9h3Hk0kkXx4k
 jQUp+lpKGfr3dR+yxT1AWRY9ra3aaNxV0UJ7coZR7+dK0ek+qfMveWBIG5ybae56u1Hu
 79p2cFC18CrV4U6cdMVlCGzdeeQEQMTibYD+4YliaBKk6M0xT+OWrDWcGixPu4IXihYT
 UZfgcJUZqrrlpZBETtGNi5+2qeNAn3UXVKuotEON+DqqJpB1j4K5YyPl3IIxP9ZmSTrw
 L0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309647; x=1721914447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5/k8L384L3wuw6eUDlmJEyK1Cofx+7INGx2FWPkB4s=;
 b=kncRXSAYwZL/Qiz+utzEBeDluTeh/BMXQZXPvESh+CpWEteO6j/qQsKyKonWiedwRZ
 2LJDMelOo01Z7PlC4p9hVB+aMyO838DxGbXp0CBxeOC7sPN3vAeSK+LL51d8wcAJ1/OK
 BYgxJfvVVmXIFo/Q6Iyl3kNZ+apNGIrHhAQBDAOLArGZnwpOCXesk4g4m7RfDocNC/Kf
 XGmiyAW/0PB09qmclcDuU1DQDG7sP32YtmrxfGMt9YyIwVvBSAuIQ4QK5261egs8Uf6q
 mFOEbk0ABZHfVoEyCQ1eZUWTyASK0UBYyo4q+N5o8jx+4pcPbwul0CDAx7pwt6eavL15
 9XgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlHjGWxIJRhPMaGN8BH6oP96yFSoPQZPnt8ZxffUZc7j5L3GMctwRo7vrStixGaOmDYcjpoZfDrG5X4ZYtv+Pz6Q7pU0A=
X-Gm-Message-State: AOJu0Yz1BRxqqaFQhZ+ttteg0ciHLBKjL9g0y1tXWPJ+VPn7OmxW6HoX
 Ho2ATv/A+hgEx1LK17Tv7gE//tAVne4folDmhwP1TBbTcBEYAJXhHUOjUTKtS3I=
X-Google-Smtp-Source: AGHT+IFOjUXe+cGDcU3ny4pBNuxl8quHyGdktO4JXmBWnF5bXN05lWizT1SnG1/nRqTNdxg7Q016+g==
X-Received: by 2002:a5d:4565:0:b0:360:7887:31ae with SMTP id
 ffacd0b85a97d-3683174660cmr3184069f8f.54.1721309647045; 
 Thu, 18 Jul 2024 06:34:07 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36816758620sm11860987f8f.19.2024.07.18.06.34.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 09/19] hw/intc/loongson_ipi: Move IPICore structure to
 loongson_ipi_common.h
Date: Thu, 18 Jul 2024 15:33:01 +0200
Message-ID: <20240718133312.10324-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
---
 include/hw/intc/loongson_ipi.h        | 17 --------
 include/hw/intc/loongson_ipi_common.h | 18 +++++++++
 hw/intc/loongson_ipi.c                | 56 +++++----------------------
 hw/intc/loongson_ipi_common.c         | 50 ++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 64 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 00a65a82fb..bb55899991 100644
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
 
@@ -38,10 +25,6 @@ struct LoongsonIPIState {
     LoongsonIPICommonState parent_obj;
 
     MemoryRegion *ipi_mmio_mem;
-    MemoryRegion ipi_iocsr_mem;
-    MemoryRegion ipi64_iocsr_mem;
-    uint32_t num_cpu;
-    IPICore *cpu;
 };
 
 #endif
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index b43b77bda6..891b43644d 100644
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
+    /* 64bit buf divide into 2 32bit buf */
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
index 2319aea18f..f3d1f031bc 100644
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
@@ -320,45 +321,16 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
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
@@ -366,15 +338,6 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 
     device_class_set_parent_realize(dc, loongson_ipi_realize,
                                     &lic->parent_realize);
-    device_class_set_props(dc, ipi_properties);
-    dc->vmsd = &vmstate_loongson_ipi;
-}
-
-static void loongson_ipi_common_finalize(Object *obj)
-{
-    LoongsonIPIState *s = LOONGSON_IPI(obj);
-
-    g_free(s->cpu);
 }
 
 static void loongson_ipi_finalize(Object *obj)
@@ -382,7 +345,6 @@ static void loongson_ipi_finalize(Object *obj)
     LoongsonIPIState *s = LOONGSON_IPI(obj);
 
     g_free(s->ipi_mmio_mem);
-    loongson_ipi_common_finalize(obj);
 }
 
 static const TypeInfo loongson_ipi_types[] = {
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 970525c242..cc49896b2d 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -8,6 +8,54 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi_common.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+static void loongson_ipi_common_finalize(Object *obj)
+{
+    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(obj);
+
+    g_free(s->cpu);
+}
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
+static const VMStateDescription vmstate_loongson_ipi = {
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
+static Property ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, ipi_properties);
+    dc->vmsd = &vmstate_loongson_ipi;
+}
 
 static const TypeInfo loongarch_ipi_types[] = {
     {
@@ -15,6 +63,8 @@ static const TypeInfo loongarch_ipi_types[] = {
         .parent             = TYPE_SYS_BUS_DEVICE,
         .instance_size      = sizeof(LoongsonIPICommonState),
         .class_size         = sizeof(LoongsonIPICommonClass),
+        .class_init         = loongson_ipi_common_class_init,
+        .instance_finalize  = loongson_ipi_common_finalize,
         .abstract           = true,
     }
 };
-- 
2.41.0


