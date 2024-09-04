Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FB0CD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsgA-0002bw-Df; Wed, 04 Sep 2024 12:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsft-0001OQ-0t
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:07 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfp-0002JD-UW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:04 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f3f07ac2dcso75455441fa.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466559; x=1726071359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNAX37zDCliJxTzZOV0veuq7ySJeesgiUypThOWliKg=;
 b=jP1bF6lYImm+DYszxpvwfDNagkmnrsIiSIBJuQyDuMzf5h9ny/oPXKY9foQAUrdgK7
 FjydpTnnwweJyoJiDAid3DZl3rkaqr0A3c7QUvA4aOA5dp5Yr3CxYLmr6LYPse2CPla0
 rXy7prw5L6yXAogtF+YzsFwdlEYIPuJGgVIdrLDup6b2yUkDVC1Gwfz13hprn1yfMlEn
 cG9bl6A8lyab04H1SUNuFrXdYGXaGkFlOK0opQ+n/QHLl5Y4DhmtPElomW/2GLv4CWSB
 o1s/6O1RdqAvHe5BfZoZWNp3n8XBfWG/fk9OcnWTN2s2jcwT7/BL5loo5dtmwisvLkF2
 2rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466559; x=1726071359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNAX37zDCliJxTzZOV0veuq7ySJeesgiUypThOWliKg=;
 b=PwWFHFPVPbuBkojL1hEC28SV1m7wT2vyznHyr3Kzxp/YXb3B/Kq5hhYHynllaHy62i
 I3QX3pKesFV4Pm3nk7SIi6Hzh3lu69nsjDJ6efvKrLJ6I+fLO8XoTpvtZSZGxJcz2SjB
 vpZ0iFKS4NRX8fQydtC2V7esA9bNqEkMFy9AjaGb/DSy3jh2ojOPw36Q3/gYd+76L7Re
 8ahLB6IGoeYoul0cohOaaD+A8mYO50H70r+0tfihr6ZueHYuHObWm1x8jjFYm9otxeeC
 fvTmhEcX600pkAneKo0kU/uA2FmydgDU/A0Rx5S3wIm6CHZYPWfpSjVlNmb0uS1/FZ25
 3kUw==
X-Gm-Message-State: AOJu0Yww09tgM9Hn4U6EAcaOMcZ1KuMO6SVr0WOJUwph44lGEIzuK2mR
 fgPMhqCx+GbB6uGe3BoD4G903mKsAnWATyAbTBSvKakbZ9lCwmj8umG/ViZt
X-Google-Smtp-Source: AGHT+IEAwPaVJCHA49+7M5oevfh+eYRN2zuFYPqyzy6yv+vvfKCbQ+16M9Wi0x4p76qr+HpI/LDCcw==
X-Received: by 2002:a2e:be03:0:b0:2ef:2b45:b71d with SMTP id
 38308e7fff4ca-2f6103c83ccmr138143261fa.24.1725466558973; 
 Wed, 04 Sep 2024 09:15:58 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f614f384eesm24841131fa.62.2024.09.04.09.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:58 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v1 11/12] hw/i386/xen: Add a Xen PVH x86 machine
Date: Wed,  4 Sep 2024 18:15:35 +0200
Message-ID: <20240904161537.664189-12-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22e.google.com
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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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


