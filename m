Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830C2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPuh-0007TK-Bh; Tue, 20 Aug 2024 10:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsK-0001xo-5r
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:21 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsG-0001uS-3U
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:19 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-533461323cdso283724e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164213; x=1724769013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qb70tZhf6O0rqG3q2lg1Kgw4jrd26x22YIO9764ldGo=;
 b=UAzGBwCJ/E31HZOBUM5D7g5qMBTBV1N3/ADz4kYIW6oYn4eAiprCsBgQemw9YrtipF
 SJojCmmzLFmsK2QMMB6UiBH0czAORxIshETJEiJhT/4avwrjdKBq906iNRsWJUL6Ll6N
 abDeDP1n0mmDJk57pDdGFSNP2+MhfE5GWuLnCpsIypxypU46Ht6Z8BJOAb6kZ3cB7GWT
 qN0oslzqb8kzPHIYCj0o0hDwbxvyLvXALRhyt18K48EU2RZ37wvNQ2m1SLrOxHYCw6ir
 ilD+xzQJiRj61Iip8MIpWlI2ueenusk/VMPiVZT7k8INTkpoSQVTfPkH6ELesaVnprB7
 vAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164214; x=1724769014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qb70tZhf6O0rqG3q2lg1Kgw4jrd26x22YIO9764ldGo=;
 b=ejp9VK4NUrH9EBgsKYWWMltGL8K1UIz6/DvdmTfXQ5MQwrebGg1shy1m803qd23zHH
 oV1TGy2uXQnktFSwgOZau33ePs3AUI38bDvHUYz+fWoIRixLIO5J1gbeSlhQXjJfQ/1K
 gthHfxqqPPRD+xfJvnBmvCqz0HDqu9TbyMS+yjUc9im6o8p5Lz5Goo5dQirnyctdeN1s
 C7/Sjwq+VWMJ3y9igjHNf72KGm6izN9SrbzQ0Gp21zlPpjHsthLIN/+Gog+ir+gHHcc8
 GmTG3O45bcSIoLw3ZR/4K0Dsg6BH7aUUVpJDquyoKb7YgnA6T1K1qHJggJ959Q3tmxXd
 5eRw==
X-Gm-Message-State: AOJu0Yw0PNF61K07WGLTK7Dp4ctI/YY7bp6CQ+wOpyJxeDpAamw2Ezes
 O/mWqsr9l/QQdVwNbJrp6j0wl+RTnlh/DvAD2nNf2+n3n/3v2jdRMGdEjo69
X-Google-Smtp-Source: AGHT+IFoXhrlxg3cNGb0+DSA5Qu76KzL7+3HHVZt7gmKWNEWr1BFmaIm+WYR3dUl/tDDDSx61bB+zA==
X-Received: by 2002:a05:6512:641a:b0:533:4477:28a2 with SMTP id
 2adb3069b0e04-53344772a8emr1193165e87.16.1724164212866; 
 Tue, 20 Aug 2024 07:30:12 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-533449f5fdasm118978e87.284.2024.08.20.07.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:30:12 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 11/12] hw/i386/xen: Add a Xen PVH x86 machine
Date: Tue, 20 Aug 2024 16:29:48 +0200
Message-ID: <20240820142949.533381-12-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add a Xen PVH x86 machine based on the abstract PVH Machine.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/i386/xen/meson.build |   1 +
 hw/i386/xen/xen-pvh.c   | 121 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 hw/i386/xen/xen-pvh.c

diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
index 3f0df8bc07..c73c62b8e3 100644
--- a/hw/i386/xen/meson.build
+++ b/hw/i386/xen/meson.build
@@ -4,6 +4,7 @@ i386_ss.add(when: 'CONFIG_XEN', if_true: files(
 ))
 i386_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
   'xen-hvm.c',
+  'xen-pvh.c',
 ))
 
 i386_ss.add(when: 'CONFIG_XEN_BUS', if_true: files(
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
new file mode 100644
index 0000000000..45645667e9
--- /dev/null
+++ b/hw/i386/xen/xen-pvh.c
@@ -0,0 +1,121 @@
+/*
+ * QEMU Xen PVH x86 Machine
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "hw/boards.h"
+#include "sysemu/sysemu.h"
+#include "hw/xen/arch_hvm.h"
+#include <xen/hvm/hvm_info_table.h>
+#include "hw/xen/xen-pvh-common.h"
+
+#define TYPE_XEN_PVH_X86  MACHINE_TYPE_NAME("xenpvh")
+OBJECT_DECLARE_SIMPLE_TYPE(XenPVHx86State, XEN_PVH_X86)
+
+struct XenPVHx86State {
+    /*< private >*/
+    XenPVHMachineState parent;
+
+    DeviceState **cpu;
+};
+
+static DeviceState *xen_pvh_cpu_new(MachineState *ms,
+                                    int64_t apic_id)
+{
+    Object *cpu = object_new(ms->cpu_type);
+
+    object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
+    object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
+    object_unref(cpu);
+
+    return DEVICE(cpu);
+}
+
+static void xen_pvh_init(MachineState *ms)
+{
+    XenPVHx86State *xp = XEN_PVH_X86(ms);
+    int i;
+
+    /* Create dummy cores. This will indirectly create the APIC MSI window.  */
+    xp->cpu = g_malloc(sizeof xp->cpu[0] * ms->smp.max_cpus);
+    for (i = 0; i < ms->smp.max_cpus; i++) {
+        xp->cpu[i] = xen_pvh_cpu_new(ms, i);
+    }
+}
+
+static void xen_pvh_instance_init(Object *obj)
+{
+    XenPVHMachineState *s = XEN_PVH_MACHINE(obj);
+
+    /* Default values.  */
+    s->cfg.ram_low = (MemMapEntry) { 0x0, 0x80000000U };
+    s->cfg.ram_high = (MemMapEntry) { 0xC000000000ULL, 0x4000000000ULL };
+    s->cfg.pci_intx_irq_base = 16;
+}
+
+/*
+ * Deliver INTX interrupts to Xen guest.
+ */
+static void xen_pvh_set_pci_intx_irq(void *opaque, int irq, int level)
+{
+    /*
+     * Since QEMU emulates all of the swizziling
+     * We don't want Xen to do any additional swizzling in
+     * xen_set_pci_intx_level() so we always set device to 0.
+     */
+    if (xen_set_pci_intx_level(xen_domid, 0, 0, 0, irq, level)) {
+        error_report("xendevicemodel_set_pci_intx_level failed");
+    }
+}
+
+static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
+{
+    XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Xen PVH x86 machine";
+    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+
+    /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
+    mc->max_cpus = HVM_MAX_VCPUS;
+
+    /* We have an implementation specific init to create CPU objects.  */
+    xpc->init = xen_pvh_init;
+
+    /*
+     * PCI INTX routing.
+     *
+     * We describe the mapping between the 4 INTX interrupt and GSIs
+     * using xen_set_pci_link_route(). xen_pvh_set_pci_intx_irq is
+     * used to deliver the interrupt.
+     */
+    xpc->set_pci_intx_irq = xen_pvh_set_pci_intx_irq;
+    xpc->set_pci_link_route = xen_set_pci_link_route;
+
+    /* List of supported features known to work on PVH x86.  */
+    xpc->has_pci = true;
+
+    xen_pvh_class_setup_common_props(xpc);
+}
+
+static const TypeInfo xen_pvh_x86_machine_type = {
+    .name = TYPE_XEN_PVH_X86,
+    .parent = TYPE_XEN_PVH_MACHINE,
+    .class_init = xen_pvh_machine_class_init,
+    .instance_init = xen_pvh_instance_init,
+    .instance_size = sizeof(XenPVHx86State),
+};
+
+static void xen_pvh_machine_register_types(void)
+{
+    type_register_static(&xen_pvh_x86_machine_type);
+}
+
+type_init(xen_pvh_machine_register_types)
-- 
2.43.0


