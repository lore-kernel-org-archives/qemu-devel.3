Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3387FC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVG-0008QR-W1; Wed, 17 Jul 2024 17:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVF-0008Ma-Uv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVE-0002Gz-0C
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:01 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3680667d831so100666f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252878; x=1721857678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osaZzLJUZUCGk/6XclTFsQUc8CVCiZ78su9DOnBj+d0=;
 b=TUg/bbAaetCxb1Kg9UayrIQLfjoFaBR+EJJBM51LPfOoO0X1IRzsC5wq0SylhVtk21
 ez0Gc0iTum0WEoV+kiLHiNJBT3wAEVJ6qq2p/Gj6N0RkcHOkeRzDIT1hhtOK/c3qRTex
 MeKQrYBS+rxyu2qfSI2IuP73wgyzDcps5T1U8Dk1ngxjcBhQiM5ukWApQOszadPuLL7Q
 8Si4kfE9GSLLXPnVxzlKDuOyulARAaOvXOH5i27FtHDFPh8gpkUtXRMnZ50yZGerdK4K
 F1rhzmzlIp0U7N8FE1ZTU0GhX22Q5OAkdiChaV/36UIfP6SmDipcgaTwvHygUOSNcaI0
 X/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252878; x=1721857678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osaZzLJUZUCGk/6XclTFsQUc8CVCiZ78su9DOnBj+d0=;
 b=fliW4DhN/B+lV81LJOJ+RCnLafHNH4GKVk85aQLESu6VTDVF04NZ3dZrVlsScwqxle
 Pb89UIsXRnSN4qcpIK8k/3qkG938ih1By3UsXe6uxJhE7penpTiGla+5/Ej2mZT8UDOi
 b2EHoewD8AWvGzwL+G6OkhaMkXHlRowTAhM9eEftlS4p0aJtFbn05EsDKW95ndgoZ3MJ
 ToKzdAZ2QdMtGCTCuFN1s6nbloS30emWESjvztWPf1W5cyap2B8qfBMWWRGk5PsfolMK
 MqG6+C3uY1KJzQdWCraZaVPE6rb3K5ZRC6he9a7S8v6otE2J4yxpdNagl+oa33NHtAfA
 wQrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH+3xayx/e3beO4WmUdypTzQxbA2WuxgYsbNWpWD7cHXjJoDocxsPlbpNAQdAXXesWLmamzEhe2+nH+nrmyNlqygq3LOg=
X-Gm-Message-State: AOJu0Yz+MEBNwQpSMAML5yQeElM7d3HmTGiS+/X1VevYXAM1EIKmoQD2
 MBygmxS03H8UkntO0e/HHyKTLYtmvt2dOerQxPcrP4rlc2z/PZPBPyPdxh9TePw=
X-Google-Smtp-Source: AGHT+IEK+dJGmPWQqjxzp5fWP20rrrRYudR50moDJ6YLQjBPcDhV9fO9ZlSksmtK6Mo9anPRB4rBbA==
X-Received: by 2002:a05:6000:369:b0:367:4337:4065 with SMTP id
 ffacd0b85a97d-368317379bdmr1901413f8f.51.1721252878432; 
 Wed, 17 Jul 2024 14:47:58 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3683f5e0119sm1728953f8f.100.2024.07.17.14.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:47:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 05/17] hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON
 stub
Date: Wed, 17 Jul 2024 23:46:56 +0200
Message-ID: <20240717214708.78403-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h        | 13 +++++++++++--
 include/hw/intc/loongson_ipi_common.h | 26 ++++++++++++++++++++++++++
 hw/intc/loongson_ipi.c                |  7 ++++---
 hw/intc/loongson_ipi_common.c         | 25 +++++++++++++++++++++++++
 hw/intc/Kconfig                       |  4 ++++
 hw/intc/meson.build                   |  1 +
 6 files changed, 71 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongson_ipi_common.c

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
index 40ac769aad..e8772f1b96 100644
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
@@ -382,8 +384,7 @@ static void loongson_ipi_finalize(Object *obj)
 
 static const TypeInfo loongson_ipi_info = {
     .name          = TYPE_LOONGSON_IPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongsonIPIState),
+    .parent        = TYPE_LOONGSON_IPI_COMMON,
     .class_init    = loongson_ipi_class_init,
     .instance_finalize = loongson_ipi_finalize,
 };
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
new file mode 100644
index 0000000000..7e3f74d08a
--- /dev/null
+++ b/hw/intc/loongson_ipi_common.c
@@ -0,0 +1,25 @@
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
+static const TypeInfo loongson_ipi_common_info = {
+    .name           = TYPE_LOONGSON_IPI_COMMON,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(LoongsonIPICommonState),
+    .class_size     = sizeof(LoongsonIPICommonClass),
+    .abstract       = true,
+};
+
+static void loongson_ipi_common_register_types(void)
+{
+    type_register_static(&loongson_ipi_common_info);
+}
+
+type_init(loongson_ipi_common_register_types)
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


