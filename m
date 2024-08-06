Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E408C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJgt-0002Dd-TO; Tue, 06 Aug 2024 08:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgm-0001QQ-N6
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:23 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgk-00004q-DM
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:20 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52fc4388a64so755589e87.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948796; x=1723553596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U580Wrx23+PhRsFUSNYJ7VRxWznSc+VPsbnAWBKD3bQ=;
 b=sDqRb/RbBX0jVhU208EUXKra82bsALAL6DeXOUAFDWNxuFsF02JR6Ys9g5DGSgDUu4
 uDE5ZADoiJ/LJUH38wVHQiRiHcH1s/6hnqmTaSwlUyrEFAE/YbHSnCl3smBDDvQFbbab
 mDYpYl0iroYvywYFzaKMiBmOXicTnsNwac39haFHBcCRGS24c0M43OdcQMWPHikxY9K8
 b46ZavsqnVYuGiiWMrcS3jen6wSUMB7MCYj9ukSj0RRVA001mIBolZLjTMaZut26wgCC
 xG8d9nPsMNKDw4xvR4/FxxSuhYMqX4Pswoy7F+KslvHUlrEvoAgA5hF1VNERUtIe6Y46
 UDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948796; x=1723553596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U580Wrx23+PhRsFUSNYJ7VRxWznSc+VPsbnAWBKD3bQ=;
 b=DqBny5W78Y9Hb02rctLYXkcYtIq/NCFvqvyLI/NDo9A0umdXwrKYYQd6i135gHjwpE
 RA0T+CxQf8JpskJ3o7qYythtQVwbEKnX9d3XqTcXK33BVY0X0FL2n8mCppzBhP8QNi+h
 Dc8/EapvA4IZW3KcUbZj8dJP3i7Ra0ANA1+sBVP4G/pzTNyMMOfhUceAXTITrp0CtOAk
 YGhoY0V9yhyqyKYjxs2R6DD91IXLEkUkqTvtfOqyv3bgEoyjpKlT1fVMqvtOZCdEKL3W
 YlB5wzqnkkeSUG1d6Z86rQqC5Xl664KbGNkrTpse9MjZ+WIySW5U/ZY3b8nwYoDYSYT3
 eGCQ==
X-Gm-Message-State: AOJu0YxX+8YrWpj9+JJWMUs3N7SFKO7f4s9UcbZMSIxyrImefeFh7ljy
 hcmS9pAkJspwBs17c16J6LZQGNcEbcexC+eC9lkdBt41m5gijpzYDDRDQxfjLDvgOU4MC/yIjOv
 I
X-Google-Smtp-Source: AGHT+IEj9N4cn5WwXBmjwWcidUZC8CWdQYZBhYpacbwWDzAyx2zcWNoXFTylRkL1biBANRw9Aa9FtA==
X-Received: by 2002:a05:6512:3b8b:b0:530:ae0d:9fc8 with SMTP id
 2adb3069b0e04-530bb36b6bcmr11186553e87.2.1722948795857; 
 Tue, 06 Aug 2024 05:53:15 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d433fesm553882366b.142.2024.08.06.05.53.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 12/28] hw/intc/loongarch_ipi: Add loongarch IPI support
Date: Tue,  6 Aug 2024 14:51:40 +0200
Message-ID: <20240806125157.91185-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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
Message-Id: <20240805180622.21001-13-philmd@linaro.org>
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


