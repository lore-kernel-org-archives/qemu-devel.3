Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AC1C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeAm-0006DC-6D; Mon, 26 Feb 2024 11:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAk-0006A9-Oo
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:46 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAi-0006HN-Sr
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:46 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d23d301452so46749661fa.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966183; x=1709570983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wc7ekhdBLxy3L373z/Id77yNGmRbap0pwSIm6jwZffI=;
 b=E4U86/EunGPwPvsmupz3mMo7/d1tBroFq01feGnpQQXAI3mWvDgBnSuQTgohcIuOOC
 PfXLIDhmqA9DKGIF3UbO3VCPnA2p2jH8l9TBSWMTLLEJZZz43nhGHAF9FsOg87OWmEDe
 7UwXmYF3TUieeHz4yciS52wmK8QAWctFl3OFiiT3gim4yXRU8xye6hLuUBOXtHo08cBp
 NylZDC7YdA08lSIqEtdPpOjclUxWpuBtYg0yDSMRybHV7nB1BuqpNVeczRfagMv0rtkc
 5mkrETcw16NZMWdOMCsHfuyrAEkSCmVUHODeEyEm3ZXKpanDPJaaVfpDldQjSsa9y3sT
 94IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966183; x=1709570983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wc7ekhdBLxy3L373z/Id77yNGmRbap0pwSIm6jwZffI=;
 b=ZwYkEF+7X0+AU45KkqTDMGS/I5bzS6+Jrkd68dHceoesI1NZ+ioETLgooxUvzE2E+U
 +iVGPHqIqGSs5g84kUgMPquPn2ECM+pHunQw4GIMSYSiAuboC2hhrDPa7MvFQ0assPHo
 fk6//SYudxoVtF5ETBcBJNaPClWCuH1GBi22ETA4SpCDmOLwJu8xdf1Bcw1teC5v5dQn
 anUGTCBhEORvswWyqYGvWwNWik3RUjf3pv7EkzqtDXJwqhVNW+8Epp64Muhn8At6TSLc
 EYOIFrOT3uklLexACt8fau0zjngnyHFi688Q+Q21etZk2fnIybevTVN31+evVDLT+W5C
 nw+Q==
X-Gm-Message-State: AOJu0YxSPXhEZ3mpOQgQb0d7kFybZjqRPUVS7jhiXU4c6UOG8jVY1xhM
 POnOoCe594fl8EltAUuggEfqICEB2FulEYfhQJcoumuiKbWGGGQbBWNUUJhJhHmnGPd6WuyHdpW
 o
X-Google-Smtp-Source: AGHT+IEPlyFdIASjzn9EA1qd4zGRk/7nSlLV7tTgFW7g5q0irN9Xv94Z0ZdJm5RHU9a2li4mM5Ol2Q==
X-Received: by 2002:a2e:6e0c:0:b0:2d2:4141:d5c3 with SMTP id
 j12-20020a2e6e0c000000b002d24141d5c3mr4443420ljc.7.1708966182743; 
 Mon, 26 Feb 2024 08:49:42 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b00412a2060d5esm5801957wmo.23.2024.02.26.08.49.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 08:49:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 4/5] hw/i386/q35: Wire virtual SMI# lines to ICH9 chipset
Date: Mon, 26 Feb 2024 17:49:11 +0100
Message-ID: <20240226164913.94077-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226164913.94077-1-philmd@linaro.org>
References: <20240226164913.94077-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We use virtual SMI lines for the virtualized q35 machine
(see commit 5ce45c7a2b "hw/isa/lpc_ich9: add broadcast
SMI feature").

Expose them as QDev GPIO at the machine level. Wire them
to the ICH9 chipset. This allows removing a pair of calls
to cpu_interrupt() from the ICH9 model and make it target
agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/isa/ich9_lpc.h     | 12 ++++++++++++
 include/hw/southbridge/ich9.h |  1 +
 hw/i386/pc_q35.c              | 26 ++++++++++++++++++++++++++
 hw/isa/ich9_lpc.c             | 10 ++++------
 hw/southbridge/ich9.c         |  1 +
 5 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/hw/isa/ich9_lpc.h b/include/hw/isa/ich9_lpc.h
index b64d88b395..f11ae7e762 100644
--- a/include/hw/isa/ich9_lpc.h
+++ b/include/hw/isa/ich9_lpc.h
@@ -21,6 +21,17 @@ OBJECT_DECLARE_SIMPLE_TYPE(ICH9LPCState, ICH9_LPC_DEVICE)
 
 #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
 
+/*
+ * Real ICH9 contains a single SMI output line and doesn't broadcast CPUs.
+ * Virtualized ICH9 allows broadcasting upon negatiation with guest, see
+ * commit 5ce45c7a2b.
+ */
+enum {
+    ICH9_VIRT_SMI_BROADCAST,
+    ICH9_VIRT_SMI_CURRENT,
+#define ICH9_VIRT_SMI_COUNT 2
+};
+
 struct ICH9LPCState {
     /* ICH9 LPC PCI to ISA bridge */
     PCIDevice d;
@@ -71,6 +82,7 @@ struct ICH9LPCState {
     Notifier machine_ready;
 
     qemu_irq gsi[IOAPIC_NUM_PINS];
+    qemu_irq virt_smi[ICH9_VIRT_SMI_COUNT];
 };
 
 #define ICH9_MASK(bit, ms_bit, ls_bit) \
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index a8da4a8665..48a4212ed8 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -17,6 +17,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(ICH9State, ICH9_SOUTHBRIDGE)
 #define ICH9_PCIE_FUNC_MAX                      6
 
 #define ICH9_GPIO_GSI "gsi"
+#define ICH9_VIRT_SMI "x-virt-smi"
 
 #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 31ab0ae77b..77fe8932e8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -50,6 +50,7 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/intc/ioapic.h"
 #include "hw/southbridge/ich9.h"
+#include "hw/isa/ich9_lpc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
@@ -58,6 +59,25 @@
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
 
+/*
+ * Kludge IRQ handler for ICH9 virtual SMI delivery.
+ * IRQ#0: broadcast
+ * IRQ#1: deliver to current CPU
+ */
+static void pc_q35_ich9_virt_smi(void *opaque, int irq, int level)
+{
+    assert(level);
+    if (irq) {
+        cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
+    } else {
+        CPUState *cs;
+
+        CPU_FOREACH(cs) {
+            cpu_interrupt(cs, CPU_INTERRUPT_SMI);
+        }
+    }
+}
+
 /* PC hardware initialisation */
 static void pc_q35_init(MachineState *machine)
 {
@@ -65,6 +85,7 @@ static void pc_q35_init(MachineState *machine)
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     Object *phb;
+    qemu_irq *smi_irq;
     DeviceState *ich9;
     Object *lpc_obj;
     MemoryRegion *system_memory = get_system_memory();
@@ -160,6 +181,8 @@ static void pc_q35_init(MachineState *machine)
 
     /* irq lines */
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
+    smi_irq = qemu_allocate_irqs(pc_q35_ich9_virt_smi, NULL,
+                                 ICH9_VIRT_SMI_COUNT);
 
     ich9 = qdev_new(TYPE_ICH9_SOUTHBRIDGE);
     object_property_add_child(OBJECT(machine), "ich9", OBJECT(ich9));
@@ -168,6 +191,9 @@ static void pc_q35_init(MachineState *machine)
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(ich9, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
+    for (i = 0; i < ICH9_VIRT_SMI_COUNT; i++) {
+        qdev_connect_gpio_out_named(ich9, ICH9_VIRT_SMI, i, smi_irq[i]);
+    }
     qdev_prop_set_bit(ich9, "d2p-enabled", false);
     qdev_prop_set_bit(ich9, "smm-enabled", x86_machine_is_smm_enabled(x86ms));
     qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
diff --git a/hw/isa/ich9_lpc.c b/hw/isa/ich9_lpc.c
index b1f41158c5..599cb0ee86 100644
--- a/hw/isa/ich9_lpc.c
+++ b/hw/isa/ich9_lpc.c
@@ -30,7 +30,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/range.h"
@@ -495,12 +494,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
     if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
         if (lpc->smi_negotiated_features &
             (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
-            CPUState *cs;
-            CPU_FOREACH(cs) {
-                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
-            }
+            qemu_irq_raise(lpc->virt_smi[ICH9_VIRT_SMI_BROADCAST]);
         } else {
-            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
+            qemu_irq_raise(lpc->virt_smi[ICH9_VIRT_SMI_CURRENT]);
         }
     }
 }
@@ -700,6 +696,8 @@ static void ich9_lpc_initfn(Object *obj)
 
     qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
                              IOAPIC_NUM_PINS);
+    qdev_init_gpio_out_named(DEVICE(lpc), lpc->virt_smi,
+                             ICH9_VIRT_SMI, ARRAY_SIZE(lpc->virt_smi));
 
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
                                   &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index 521925b462..d5e131cff3 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -64,6 +64,7 @@ static void ich9_init(Object *obj)
 
     object_initialize_child(obj, "lpc", &s->lpc, TYPE_ICH9_LPC_DEVICE);
     qdev_pass_gpios(DEVICE(&s->lpc), DEVICE(s), ICH9_GPIO_GSI);
+    qdev_pass_gpios(DEVICE(&s->lpc), DEVICE(s), ICH9_VIRT_SMI);
     qdev_prop_set_int32(DEVICE(&s->lpc), "addr", ICH9_LPC_DEVFN);
     qdev_prop_set_bit(DEVICE(&s->lpc), "multifunction", true);
     object_property_add_alias(obj, "smm-enabled",
-- 
2.41.0


