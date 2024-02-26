Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6419BC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeAf-00063o-Ts; Mon, 26 Feb 2024 11:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAe-0005y9-Jf
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:40 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAc-0006Gn-Hc
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412a57832fcso7833435e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966176; x=1709570976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSZsP7iZ+WCm1GRQ6l/dckqzk5JVKU9/jCan+ZQ8ppM=;
 b=GPopM5Kgqxq1LK39e2qEN0yZEP86Ffebq/R8Mc2TB/iZuZsU9M4vu9z18xHV0/evAK
 yRBmmQYB1o+DRTO6eitcl/qT+RY+nWy34KAv6mq2CdTFK42lxLGoA0NvsRigrOM8H0L7
 7EQ/NSCTBsTa++I/tumLwWgkk9CAJEiqJNZVEqU9TbjER+UObQSWOk0Nirpzr+4A/8G7
 OAvQR3vwpwMVrp6aGNq88629H1e+4xFv9vIVS/DSNMY+4eqdKvmxh5dA53c758kmh3O6
 dXUgXqnElSPFplYgI9jCgDGtAvHbnpm7krZQp7nz9PgRl1EOB5fSknU2iJafwa4/zbpc
 MtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966176; x=1709570976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSZsP7iZ+WCm1GRQ6l/dckqzk5JVKU9/jCan+ZQ8ppM=;
 b=VbXiFbwEqcTtVSybF20idAE37JiuColuyDETxvqTNMrr81DpYF144d+s+TL/sHgGYs
 npBDqd9LH8io/z3fI49WjbYGVV+SSD+GjqqEXPBeBbU/MlG8RdU4u+LnnTKwkeSYP55/
 8ZkRYVSoUMSvg1PSDAElwafVmYiqH4aFpPMQDnOhY1Is6M5QHFZxh/yyFk7ntH0psXWO
 cssKfhnrfLTsmsOK5cjJUSFc02Rc/xhj4Lk65IHdcmnMXwZfOHqwUqttc1C9BVavr/AA
 BwtPZoxUS25hcxMtBa6IZK9oCId4OOsYkw/1Gfj4yQewH3vCgJq9V1ZHU11UbzKfcTvA
 eLyA==
X-Gm-Message-State: AOJu0YxSaL/OWlltdS6qgcFP1yXUQwCcZd0Jwb+yvGIisAP/HAa7rz7h
 D/g8CpqKo31Yy+CE0tlrn5UzI/GTTQ6lN2G2r/5+05X4hzvQ1XSV7gaJfoOmT45RWbxneZ7nsfl
 S
X-Google-Smtp-Source: AGHT+IFSqJhGU2EosIlK+UpRwF6yY5sOcOjxBheJ49rYM49QKig+cwz48xBMpyY0ZV2EeaJixfFq6A==
X-Received: by 2002:a05:600c:1f86:b0:412:8306:a7bb with SMTP id
 je6-20020a05600c1f8600b004128306a7bbmr6393130wmb.12.1708966176308; 
 Mon, 26 Feb 2024 08:49:36 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b00412157dc70bsm8942178wms.30.2024.02.26.08.49.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 08:49:35 -0800 (PST)
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
Subject: [RFC PATCH 3/5] hw/ahci/ich9_tco: Set CPU SMI# interrupt using QDev
 GPIO API
Date: Mon, 26 Feb 2024 17:49:10 +0100
Message-ID: <20240226164913.94077-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226164913.94077-1-philmd@linaro.org>
References: <20240226164913.94077-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Use the CPU "SMI" IRQ, removing a call to cpu_interrupt()
from hw/. Keep a reference to the IRQ in the TCOIORegs
structure, which while being names with the Regs suffix
doesn't contain only registers. Remove ich9_generate_smi().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I suppose ideally ICH9 TCO would be a QOM object...
---
 include/hw/acpi/ich9.h     |  1 +
 include/hw/acpi/ich9_tco.h |  4 ++--
 hw/acpi/ich9.c             |  3 ++-
 hw/acpi/ich9_tco.c         | 13 ++++++++++---
 hw/isa/ich9_lpc.c          |  5 -----
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 3587a35c9f..84e1557257 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -49,6 +49,7 @@ typedef struct ICH9LPCPMRegs {
     uint32_t smi_sts;
 
     qemu_irq irq;      /* SCI */
+    qemu_irq smi;      /* SMI */
 
     uint32_t pm_io_base;
     Notifier powerdown_notifier;
diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index 68ee64942f..31730b8e14 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -73,10 +73,10 @@ typedef struct TCOIORegs {
     uint8_t timeouts_no;
 
     MemoryRegion io;
+    qemu_irq smi;
 } TCOIORegs;
 
-void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
-void ich9_generate_smi(void);
+void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent, qemu_irq smi);
 
 extern const VMStateDescription vmstate_ich9_sm_tco;
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 1f41ab49c4..e0b3838365 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -318,7 +318,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
 
     if (pm->enable_tco) {
-        ich9_acpi_pm_tco_init(&pm->tco_regs, &pm->io);
+        pm->smi = qdev_get_gpio_in_named(DEVICE(first_cpu), "SMI", 0);
+        ich9_acpi_pm_tco_init(&pm->tco_regs, &pm->io, pm->smi);
     }
 
     if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
diff --git a/hw/acpi/ich9_tco.c b/hw/acpi/ich9_tco.c
index 7499ec17db..1061b18b7e 100644
--- a/hw/acpi/ich9_tco.c
+++ b/hw/acpi/ich9_tco.c
@@ -14,6 +14,7 @@
 
 #include "hw/acpi/ich9_tco.h"
 #include "hw/isa/ich9_lpc.h"
+#include "hw/irq.h"
 #include "trace.h"
 
 enum {
@@ -31,6 +32,11 @@ enum {
     SW_IRQ_GEN_DEFAULT      = 0x03,
 };
 
+static void ich9_generate_smi(TCOIORegs *tr)
+{
+    qemu_irq_raise(tr->smi);
+}
+
 static inline void tco_timer_reload(TCOIORegs *tr)
 {
     int ticks = tr->tco.tmr & TCO_TMR_MASK;
@@ -72,7 +78,7 @@ static void tco_timer_expired(void *opaque)
     }
 
     if (pm->smi_en & ICH9_PMIO_SMI_EN_TCO_EN) {
-        ich9_generate_smi();
+        ich9_generate_smi(tr);
     }
     tr->tco.rld = tr->tco.tmr;
     tco_timer_reload(tr);
@@ -154,7 +160,7 @@ static void tco_ioport_writew(TCOIORegs *tr, uint32_t addr, uint32_t val)
     case TCO_DAT_IN:
         tr->tco.din = val;
         tr->tco.sts1 |= SW_TCO_SMI;
-        ich9_generate_smi();
+        ich9_generate_smi(tr);
         break;
     case TCO_DAT_OUT:
         tr->tco.dout = val;
@@ -225,7 +231,7 @@ static const MemoryRegionOps tco_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
+void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent, qemu_irq smi)
 {
     *tr = (TCOIORegs) {
         .tco = {
@@ -245,6 +251,7 @@ void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
         .tco_timer     = timer_new_ns(QEMU_CLOCK_VIRTUAL, tco_timer_expired, tr),
         .expire_time   = -1,
         .timeouts_no   = 0,
+        .smi = smi,
     };
     memory_region_init_io(&tr->io, memory_region_owner(parent),
                           &tco_io_ops, tr, "sm-tco", ICH9_PMIO_TCO_LEN);
diff --git a/hw/isa/ich9_lpc.c b/hw/isa/ich9_lpc.c
index 2339f66e0f..b1f41158c5 100644
--- a/hw/isa/ich9_lpc.c
+++ b/hw/isa/ich9_lpc.c
@@ -353,11 +353,6 @@ static PCIINTxRoute ich9_route_intx_pin_to_irq(void *opaque, int pirq_pin)
     return route;
 }
 
-void ich9_generate_smi(void)
-{
-    cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
-}
-
 /* Returns -1 on error, IRQ number on success */
 static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
 {
-- 
2.41.0


