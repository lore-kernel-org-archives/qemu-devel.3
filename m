Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FC3C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgy-0002bB-69; Thu, 18 Jul 2024 04:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgt-0002DA-N5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgr-0005QJ-Tf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso514615e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292040; x=1721896840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEa6I7jq4J7xWIwW3IaLiJFVerOaIlf2VUVJqiCeS8k=;
 b=EkI3TNYND4ouXxWIcfA3hO6/7EmPQlts1LdzJhvs79/y06GLrUJ3m1j+nFOAmcTcvk
 hkAaUeSGcxiBDIjlml+lvjDuHvy5PoiLSN6T3fQxNrhsvjGZ0FIZG+cyWIGyDWeuiY/7
 Hn2bHMV3TBlA2Ba3xFx0Mv0BbaZ1M+BqK3355qE6kM6EhrKFJQzpaq/Mr2xwqWKcPZtG
 GSf41GGUtsQjXsHD1yBfSmymXlqQRbI/fRHMk4l3dNbyh9ebmt2LQtn01myRG26hABBV
 bwFKNmmiXMLakKFTY+AU3H8DgeuxeFYwz0zG8m0iwq2QfQPsK/Y3Zv4pYWF3hUpegyaV
 5nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292040; x=1721896840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEa6I7jq4J7xWIwW3IaLiJFVerOaIlf2VUVJqiCeS8k=;
 b=jLRkAtZnpFGe319M9AtKenCDrYe/bvs25eXxFTjL1a/77mHAvu25YHIHxKUO5AsDHD
 nNFzT2+TyUKuQjv+EWaefvYIfoSfBMYWga0m85Fv5lmMQWxuwcijsIDMF99WVCl5EFRH
 fLCXQoTx0KAzGXpwDxQVInNi/+kwl8fyfC8Jm/wqOSIUz4/5MXM04zjDPfWHSFVkpQAV
 MPvpHt9xtJqG0XV4QeN8hiPPwrNreOkKLTLR2D2mmDwMMVy8OQpPsOaph0PRW/1a3XyS
 nk6eN/jWi/0q7PKyGBikfTaydY5Nsnp0iEUMwEykksDf8ajeBn79JGqq7AHhHX+/61+T
 wJDg==
X-Gm-Message-State: AOJu0YzzOPmyOecO6XSBIJBZafWBXN3MU4CgPu4LxkFI2CJ4MYCO2SA5
 HaWg03X2IyBPs1UTKwnISxQFTVFKZ0Lm6Dbjq83Xhm+9bmY4rYKrmgNYpYZZOKQs3etkgG6O7rX
 6X/w=
X-Google-Smtp-Source: AGHT+IHqdu89LC4jYBEm7QjMK2h/JBqZPIrVzfS9uMRerRAnonUE9JhnXudmdS0h+XAS19yQsWFBiA==
X-Received: by 2002:a05:600c:3845:b0:426:62a0:eb6b with SMTP id
 5b1f17b1804b1-427c2cb3bcdmr32992315e9.13.1721292039780; 
 Thu, 18 Jul 2024 01:40:39 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6fd5fsm2470165e9.22.2024.07.18.01.40.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 15/18] hw/intc/loongarch_ipi: Add loongarch IPI support
Date: Thu, 18 Jul 2024 10:38:39 +0200
Message-ID: <20240718083842.81199-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Loongarch IPI is added here, it inherits from class
TYPE_LOONGSON_IPI_COMMON, and two interfaces get_iocsr_as() and
cpu_by_arch_id() are added for Loongarch 3A5000 machine. It can
be used when ipi is emulated in userspace with KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Rebased and simplified]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongarch_ipi.h | 25 ++++++++++++
 hw/intc/loongarch_ipi.c         | 68 +++++++++++++++++++++++++++++++++
 hw/intc/Kconfig                 |  4 ++
 hw/intc/meson.build             |  1 +
 4 files changed, 98 insertions(+)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 hw/intc/loongarch_ipi.c

diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
new file mode 100644
index 0000000000..d134c9d0c7
--- /dev/null
+++ b/include/hw/intc/loongarch_ipi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongarch ipi interrupt header files
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGARCH_IPI_H
+#define HW_LOONGARCH_IPI_H
+
+#include "qom/object.h"
+#include "hw/intc/loongson_ipi_common.h"
+
+#define TYPE_LOONGARCH_IPI  "loongarch_ipi"
+OBJECT_DECLARE_TYPE(LoongarchIPIState, LoongarchIPIClass, LOONGARCH_IPI)
+
+struct LoongarchIPIState {
+    LoongsonIPICommonState parent_obj;
+};
+
+struct LoongarchIPIClass {
+    LoongsonIPICommonClass parent_class;
+};
+
+#endif
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
new file mode 100644
index 0000000000..ccbfad07b7
--- /dev/null
+++ b/hw/intc/loongarch_ipi.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongarch ipi interrupt support
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "hw/intc/loongarch_ipi.h"
+#include "target/loongarch/cpu.h"
+
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
+    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+}
+
+static int archid_cmp(const void *a, const void *b)
+{
+   CPUArchId *archid_a = (CPUArchId *)a;
+   CPUArchId *archid_b = (CPUArchId *)b;
+
+   return archid_a->arch_id - archid_b->arch_id;
+}
+
+static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
+{
+    CPUArchId apic_id, *found_cpu;
+
+    apic_id.arch_id = id;
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+                        ms->possible_cpus->len,
+                        sizeof(*ms->possible_cpus->cpus),
+                        archid_cmp);
+
+    return found_cpu;
+}
+
+static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    CPUArchId *archid;
+
+    archid = find_cpu_by_archid(machine, arch_id);
+    if (archid) {
+        return CPU(archid->cpu);
+    }
+
+    return NULL;
+}
+
+static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
+{
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
+
+    licc->get_iocsr_as = get_iocsr_as;
+    licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
+}
+
+static const TypeInfo loongarch_ipi_types[] = {
+    {
+        .name               = TYPE_LOONGARCH_IPI,
+        .parent             = TYPE_LOONGSON_IPI_COMMON,
+        .class_init         = loongson_ipi_class_init,
+    }
+};
+
+DEFINE_TYPES(loongarch_ipi_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index a2a0fdca85..dd405bdb5d 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -94,6 +94,10 @@ config LOONGSON_IPI
     bool
     select LOONGSON_IPI_COMMON
 
+config LOONGARCH_IPI
+    bool
+    select LOONGSON_IPI_COMMON
+
 config LOONGARCH_PCH_PIC
     bool
     select UNIMP
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index a09a527207..f4d81eb8e4 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -71,6 +71,7 @@ specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
-- 
2.41.0


