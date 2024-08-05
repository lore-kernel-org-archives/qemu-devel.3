Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EFFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb27a-0002sz-Iw; Mon, 05 Aug 2024 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27Y-0002fR-I4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27W-0006SQ-GZ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3687f91af40so6439383f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881262; x=1723486062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/kSm1HWmhuEc0hDCxHXx4k+YsK8CefOInECn4KJlHc=;
 b=EB3viguV6aJnJKzA3/FJgVA8VPtXvCojjwanfyfDIUYCnddhw4I1TATfDSHrJHoTRE
 hpN0VAr9aZDMXarL3u5keg30hjKKi7D85Dqrb3+iFxlN2dSfBzGM185si2oac8E7T81t
 gvHV7+yT+/jsAm8VJSIeXpEsewtxMBHHGyWkXKDWArTe+4a7LMMLLIrEbmJuIW9MPkxB
 sYFrgxOAgvH4GJty74LMT4qiXwK1wnraV03Tb8F/46g5DRWQlXTphEdC8kS1SCrmxboC
 h++uNhd1brwpif+zdlOGP4wt2j15/5j/FvOWRd00RBJPXbkOT14ae4Xxr6qXYNZjy5Tp
 t5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881262; x=1723486062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/kSm1HWmhuEc0hDCxHXx4k+YsK8CefOInECn4KJlHc=;
 b=NwE2LBUoI7IswwEyNxSIjlZRXROMVRJH0ey2zmR+fLalWqZHuLMd05zhLeSRrt11u2
 XrA+DgkDjTajSXfk8P6CJpTe8BROaE+rgPVK7vGf4K6nAdGwx5OBfMVZYJH9YCBP68nF
 PQcnNTqkwcRc14GGcSaI3jaLygFPse19qyoEV/AkoQzgkqx4tjkv2EePHy5NXbOHMYnG
 pF7NKbjFLsXC3Zee4jc15En3XGninTDgxPUIe6Ti6aqiq8NYpCrDbajJX4hs5zaOVlwb
 NKVTuRBlOfV6/LBs8AW3jDmKvABSzMcaqp95q2cbP6pdJhkFzKRa2HG+mtUzrao8IhGL
 yz3Q==
X-Gm-Message-State: AOJu0YwDczWlVUWWdSxRhlQpXj1Sr/oO2Pbwm79nLQBCdH9WOqQGkcSf
 BMXNri8F2DQhM2W1pRFjaMCjUUgn1eEqdgfrc+fUnXP2EnyedW1xQ9snJe7s4j7Ckmfk6eULe5v
 T
X-Google-Smtp-Source: AGHT+IGzXZaDCLlnIK4QPoVEPbHu2B3wkDdU1Hmtvvtt0ywj16TqzpHoG9ZlqC9ale5dnW6GHrGl5g==
X-Received: by 2002:a5d:5d86:0:b0:36b:c126:fe6d with SMTP id
 ffacd0b85a97d-36bc127010cmr5831283f8f.24.1722881262267; 
 Mon, 05 Aug 2024 11:07:42 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd05b92esm10890601f8f.85.2024.08.05.11.07.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 12/15] hw/intc/loongarch_ipi: Add loongarch IPI
 support
Date: Mon,  5 Aug 2024 20:06:19 +0200
Message-ID: <20240805180622.21001-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
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

Loongarch IPI is added here, it inherits from class
TYPE_LOONGSON_IPI_COMMON, and two interfaces get_iocsr_as() and
cpu_by_arch_id() are added for Loongarch 3A5000 machine. It can
be used when ipi is emulated in userspace with KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Rebased and simplified]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-16-philmd@linaro.org>
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
index 0000000000..276b3040a3
--- /dev/null
+++ b/include/hw/intc/loongarch_ipi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch IPI interrupt header files
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
index 0000000000..2ae1a42c46
--- /dev/null
+++ b/hw/intc/loongarch_ipi.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch IPI interrupt support
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
+        .class_init         = loongarch_ipi_class_init,
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
2.45.2


