Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20CEC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMfq-00049y-8f; Thu, 18 Jul 2024 04:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfp-0003yW-0f
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfn-0004kG-1j
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so418665e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291973; x=1721896773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRzCXvtzkPmeeEJYSrxHKRmhlxarGZ8XNXu4iVW4RiU=;
 b=KsQZ7ib1q8SO0uVZ9jpBRRJ7dNMTqJ2sf+8hBmA6i8zia7VCyqZ/4kt/gNLnsfEFGI
 TfC6v5BkpykWOGVi1MMPyhvBuobpgVPR11B9JR+R/iopouNalN0sEhiDbB/x9FhegrJH
 WjhqKSD+S0TRPRCl5acrfevSk1qwFybLNiY3FdBQmlru1UkpzfIpE+C4Rbi6VYoUIiX1
 NbnB+DwTZjh9G+jXtnhAuEjmXmJcyIy2Bjh42UILUjkEY/v/8G6uiboWfSq7ChAJTdjy
 ibbjOimpimAmBHMF6Oock61p2aPLlEn9Xhr8tJuwAYC+h9lFvUh6PJlz9jdddtgWVkhE
 BFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291973; x=1721896773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRzCXvtzkPmeeEJYSrxHKRmhlxarGZ8XNXu4iVW4RiU=;
 b=F+bFYtME2xS7iCipwU6DewWAYYEk8lnXPD0YA6A8VJznW73p4BDU45L9NQ6sm6eXAC
 J+6OhsSitBjFH43/nKNouxcgGo6MGpNX2R+sHosWVRgbvnZOiHKhyF+KR4dLbWgPT4ZS
 BOdY0UnjudRfvpTWguGL1wF890PvebJpMTcIkMAlilwB6VyDU1r324ZZ8J5LcH2QUMxy
 4ua5KAeFddAXWG8dOtBX5hmLeG09o+pQ/AIT8aEDo/um9hmcCtRlDoegeW06nCiZhVVf
 KduRuxh8gB4HCR2O0o+8im0LhtX/FeRYTrfw69sA/llf9oFCo055osZE7lP9HgTPMDus
 VgFQ==
X-Gm-Message-State: AOJu0YyuTAPIJ6p/5d0VfuU3SqgpvCvc4eRbzFme7VsR3lvqIHsSkXL7
 gwmcd1eflmA1//D+YDjYltc7eltcOJkUhfbcM2N0t5a08owPO5nBRt17P9t/uDCRObnQE+61xLU
 mIvU=
X-Google-Smtp-Source: AGHT+IHGedaWeuGycto+/+XzHpQLJmG0G8bV6kLE9d53qpBW5uTHHxcbSjKrUxQtYO09NNZ58ezqVg==
X-Received: by 2002:a05:600c:4511:b0:426:5c36:f57a with SMTP id
 5b1f17b1804b1-427d2b53f8dmr887765e9.14.1721291972891; 
 Thu, 18 Jul 2024 01:39:32 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e436sm2143705e9.33.2024.07.18.01.39.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:39:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 06/18] hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON
 stub
Date: Thu, 18 Jul 2024 10:38:30 +0200
Message-ID: <20240718083842.81199-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Introduce LOONGSON_IPI_COMMON stubs, QDev parent of LOONGSON_IPI.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS                           |  4 ++++
 include/hw/intc/loongson_ipi.h        | 13 +++++++++++--
 include/hw/intc/loongson_ipi_common.h | 26 ++++++++++++++++++++++++++
 hw/intc/loongson_ipi.c                |  7 ++++---
 hw/intc/loongson_ipi_common.c         | 22 ++++++++++++++++++++++
 hw/intc/Kconfig                       |  4 ++++
 hw/intc/meson.build                   |  1 +
 7 files changed, 72 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongson_ipi_common.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..a670c8ee67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1249,8 +1249,10 @@ F: configs/devices/loongarch64-softmmu/default.mak
 F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
+F: include/hw/intc/loongson_ipi_common.h
 F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
+F: hw/intc/loongson_ipi_common.c
 F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
@@ -1385,11 +1387,13 @@ Loongson-3 virtual platforms
 M: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
+F: hw/intc/loongson_ipi_common.c
 F: hw/intc/loongson_ipi.c
 F: hw/intc/loongson_liointc.c
 F: hw/mips/loongson3_bootp.c
 F: hw/mips/loongson3_bootp.h
 F: hw/mips/loongson3_virt.c
+F: include/hw/intc/loongson_ipi_common.h
 F: include/hw/intc/loongson_ipi.h
 F: include/hw/intc/loongson_liointc.h
 F: tests/avocado/machine_mips_loongson3v.py
diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index efb772f384..82cb64ca40 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -8,6 +8,8 @@
 #ifndef HW_LOONGSON_IPI_H
 #define HW_LOONGSON_IPI_H
 
+#include "qom/object.h"
+#include "hw/intc/loongson_ipi_common.h"
 #include "hw/sysbus.h"
 
 /* Mainy used by iocsr read and write */
@@ -31,7 +33,7 @@
 #define IPI_MBX_NUM           4
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPIState, LOONGSON_IPI)
+OBJECT_DECLARE_TYPE(LoongsonIPIState, LoongsonIPIClass, LOONGSON_IPI)
 
 typedef struct IPICore {
     LoongsonIPIState *ipi;
@@ -45,8 +47,15 @@ typedef struct IPICore {
     qemu_irq irq;
 } IPICore;
 
+struct LoongsonIPIClass {
+    LoongsonIPICommonClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
 struct LoongsonIPIState {
-    SysBusDevice parent_obj;
+    LoongsonIPICommonState parent_obj;
+
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
     uint32_t num_cpu;
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
new file mode 100644
index 0000000000..70ac69d0ba
--- /dev/null
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson ipi interrupt header files
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGSON_IPI_COMMON_H
+#define HW_LOONGSON_IPI_COMMON_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+#define TYPE_LOONGSON_IPI_COMMON "loongson_ipi_common"
+OBJECT_DECLARE_TYPE(LoongsonIPICommonState,
+                    LoongsonIPICommonClass, LOONGSON_IPI_COMMON)
+
+struct LoongsonIPICommonState {
+    SysBusDevice parent_obj;
+};
+
+struct LoongsonIPICommonClass {
+    SysBusDeviceClass parent_class;
+};
+
+#endif
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index bab4d8816b..20f3f6bd3f 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -362,8 +362,10 @@ static Property ipi_properties[] = {
 static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
 
-    dc->realize = loongson_ipi_realize;
+    device_class_set_parent_realize(dc, loongson_ipi_realize,
+                                    &lic->parent_realize);
     device_class_set_props(dc, ipi_properties);
     dc->vmsd = &vmstate_loongson_ipi;
 }
@@ -383,8 +385,7 @@ static void loongson_ipi_finalize(Object *obj)
 static const TypeInfo loongson_ipi_types[] = {
     {
         .name               = TYPE_LOONGSON_IPI,
-        .parent             = TYPE_SYS_BUS_DEVICE,
-        .instance_size      = sizeof(LoongsonIPIState),
+        .parent             = TYPE_LOONGSON_IPI_COMMON,
         .class_init         = loongson_ipi_class_init,
         .instance_finalize  = loongson_ipi_finalize,
     }
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
new file mode 100644
index 0000000000..87d992aa95
--- /dev/null
+++ b/hw/intc/loongson_ipi_common.c
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson ipi interrupt common support
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/intc/loongson_ipi_common.h"
+
+static const TypeInfo loongarch_ipi_types[] = {
+    {
+        .name               = TYPE_LOONGSON_IPI_COMMON,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongsonIPICommonState),
+        .class_size         = sizeof(LoongsonIPICommonClass),
+        .abstract           = true,
+    }
+};
+
+DEFINE_TYPES(loongarch_ipi_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 58b6d3a710..a2a0fdca85 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -87,8 +87,12 @@ config GOLDFISH_PIC
 config M68K_IRQC
     bool
 
+config LOONGSON_IPI_COMMON
+    bool
+
 config LOONGSON_IPI
     bool
+    select LOONGSON_IPI_COMMON
 
 config LOONGARCH_PCH_PIC
     bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index afd1aa51ee..a09a527207 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -69,6 +69,7 @@ specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
+specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
-- 
2.41.0


