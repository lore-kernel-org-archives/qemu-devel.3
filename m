Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C6CEE3693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvE-0005h2-KI; Thu, 12 Feb 2026 09:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXut-0005NE-RO
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuF-0005mx-1c
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdxcduUlG5JK7yqtdX81R2qI0Off0b1Jl2z54JAiMCo=;
 b=C14o+jXm8Q9TqQ3TKuPoWHo3Tpz2XLHtsfqK3PisHgNHmaVmC9dSRVyHRNLeiatQBvBEv7
 YTbrxtn8JgygFDKoljr5UWoMmx21acQgqyQy+4grq8hTTrkMYd+04OJGGLTZeMiL4gurkn
 WeVZnVsOa5ATxZGDucfWfDJ5/38ZdyM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-5ygL2gusPaWR6neiaqGj_Q-1; Thu, 12 Feb 2026 09:42:56 -0500
X-MC-Unique: 5ygL2gusPaWR6neiaqGj_Q-1
X-Mimecast-MFC-AGG-ID: 5ygL2gusPaWR6neiaqGj_Q_1770907375
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43771113b3bso2194633f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907374; x=1771512174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdxcduUlG5JK7yqtdX81R2qI0Off0b1Jl2z54JAiMCo=;
 b=mi2seGNSCNkplXagQTQnddhBps3wsjM+TveEPtWsQI/X5HSI1rs9aGdYABWTiAwdNk
 5Vr+z89JbfswE2HLyyl+N4aZhZe8Fr2WvcDrDeYdBoNgbuswhcK4hJLj1LXZ4b6pQlWM
 AXXG1o/YdeWboeVeI0kZAqvPZSP8qQl6AZeIVmdAN4VIxVsYcN0pwT+MMZM7SZTl/wss
 gUtMlr6oaCs/bJiVd5fgchxqxNAR5HlU9sp/boOF8L+6nmG4fhtLIYbKbFUn1jj8yUWQ
 KmBSgiD7CYCkh0nD2YklpcPyiuhkbCa24XShEowKSY+9ZseWWHAYmvVG0EVbBZTtxLMY
 uN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907374; x=1771512174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BdxcduUlG5JK7yqtdX81R2qI0Off0b1Jl2z54JAiMCo=;
 b=o0nNNLqMr7LOij4+Ezmb28+6bUFYuCDPFrhH3lq9b2hly3HCHXhQtTOwdELY75IN96
 kejERbn1sMQVc5tolJBwuaINnDxe/5nd4rBcYOtiUmovgTcJs9kx6fC/162V21V8mB4s
 8HEbf3ymTaxLY7e0KkqEZpqEt1+jIPH4fM2fSZ54salRzW0yhdjuNSL6xYBroSNMmDBa
 KxaaOYqibr6C43MWnNQi2hYn+4NITEBicuCiJGJTd2oYRMq8e+PLhv0W/6XGggP4uQkc
 A1TN/cg0/YYGDEFjy6WQhoyQ75Yqmip0RlnBnoOBBDEQEyTu+syYTCN+6U/5x6Kp4+cM
 +Rsg==
X-Gm-Message-State: AOJu0YzVY6iNXpWClFLLNnYIyJLxG6oM+FR5Q+PWDOoRPZUGmTlEjW1G
 NAJHJ9UQecWulyalqHOHWjTUF46en5MsOpXLZzY+xBLhq7ekgyexzC6j19GKpYtrNQBH5nnu/c+
 HxyqpZIAWtrDtA01iexT64RWNa6ao2NAp2jgsyiSERBGvVyt1cGX6gPO5gZtdDY4NjEi5l5/LM3
 8gN6SKh92DFcNr8SxPjdxUnNNXtDO4F8dhjHVLznna
X-Gm-Gg: AZuq6aJNzVJn5NFxlmKGkGPPMmieOBIUcZl1EJ0f+1xfgOtUxhEsFZkX1pr4ZH1A6kt
 uOkd3Ww/zdxLMKlvMqcEYHRQh7PL5UEExMR8VSVSMKqQI+lYJKkEhyNdJNvjvtTICyJ63ikl58R
 kzMnSZU+S0yS44q6d61V9fGJXi94zC9f8zUurlu4pAL8hcT8SbRBxkyjsAmugGOUvfU/AmfKFWD
 bTZWcP56LCY7GfjWmjtxXzL9s1w1LJxWGHdKOCmUc611OULSKw39smuZI/bPOI8MKHwkFp7fQ/p
 +rGV55dCINmwJLYd7NSMufJMEzeIWH6CRTHRh1x1IIQ75GBZDXfMC15mEL+zmUDd1b7NWnAHWgJ
 81BoToQB6dv+mkRzGn4K9dLwF2MleHzmJklunNK02akEzKpTjRUsSuzPVxlo44gCSAM1jzx7u49
 vgtIy+66JGV9Z8yr5usQRF2z2xYz0cgZhA1nafyDiGQMUuD2q4wHI=
X-Received: by 2002:a5d:5f54:0:b0:435:a2f8:1534 with SMTP id
 ffacd0b85a97d-4378f16db5cmr4189212f8f.49.1770907373762; 
 Thu, 12 Feb 2026 06:42:53 -0800 (PST)
X-Received: by 2002:a5d:5f54:0:b0:435:a2f8:1534 with SMTP id
 ffacd0b85a97d-4378f16db5cmr4189146f8f.49.1770907373177; 
 Thu, 12 Feb 2026 06:42:53 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfc54csm11978563f8f.25.2026.02.12.06.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 04/41] pc: Start with modern CPU hotplug interface by default
Date: Thu, 12 Feb 2026 15:42:06 +0100
Message-ID: <20260212144244.22579-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhao Liu <zhao1.liu@intel.com>

For compatibility reasons PC/Q35 will start with legacy CPU hotplug
interface by default but with new CPU hotplug AML code since 2.7
machine type (in commit 679dd1a957df ("pc: use new CPU hotplug interface
since 2.7 machine type")). In that way, legacy firmware that doesn't use
QEMU generated ACPI tables was able to continue using legacy CPU hotplug
interface.

While later machine types, with firmware supporting QEMU provided ACPI
tables, generate new CPU hotplug AML, which will switch to new CPU
hotplug interface when guest OS executes its _INI method on ACPI tables
loading.

Since 2.6 machine type is now gone, and consider that the legacy BIOS
(based on QEMU ACPI prior to v2.7) should be no longer in use, previous
compatibility requirements are no longer necessary. So initialize
'modern' hotplug directly from the very beginning for PC/Q35 machines
with cpu_hotplug_hw_init(), and drop _INIT method.

Additionally, remove the checks and settings around cpu_hotplug_legacy
in cpuhp VMState (for piix4 & ich9), to eliminate the risk of
segmentation faults, as gpe_cpu no longer has the opportunity to be
initialized. This is safe because all hotplug now start with the modern
way, and it's impossible to switch to legacy way at runtime (even the
"cpu-hotplug-legacy" properties does not allow it either).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20260108033051.777361-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/acpi/cpu.h          |  1 -
 hw/acpi/cpu.c                  | 10 ----------
 hw/acpi/ich9.c                 | 22 +++-------------------
 hw/acpi/piix4.c                | 21 +++------------------
 hw/i386/acpi-build.c           |  2 +-
 hw/loongarch/virt-acpi-build.c |  1 -
 6 files changed, 7 insertions(+), 50 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 557219d2c63..2809dd8a911 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -54,7 +54,6 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 
 typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
-    bool has_legacy_cphp;
     bool fw_unplugs_cpu;
     const char *smi_path;
 } CPUHotplugFeatures;
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 6f1ae79edbf..d63ca83c1bc 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -408,16 +408,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_reserved_field(4 * 8));
         aml_append(field, aml_named_field(CPU_DATA, 32));
         aml_append(cpu_ctrl_dev, field);
-
-        if (opts.has_legacy_cphp) {
-            method = aml_method("_INI", 0, AML_SERIALIZED);
-            /* switch off legacy CPU hotplug HW and use new one,
-             * on reboot system is in new mode and writing 0
-             * in CPU_SELECTOR selects BSP, which is NOP at
-             * the time _INI is called */
-            aml_append(method, aml_store(zero, aml_name(CPU_SELECTOR)));
-            aml_append(cpu_ctrl_dev, method);
-        }
     }
     aml_append(sb_scope, cpu_ctrl_dev);
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2b3b493c014..54590129c69 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -183,26 +183,10 @@ static const VMStateDescription vmstate_tco_io_state = {
     }
 };
 
-static bool vmstate_test_use_cpuhp(void *opaque)
-{
-    ICH9LPCPMRegs *s = opaque;
-    return !s->cpu_hotplug_legacy;
-}
-
-static int vmstate_cpuhp_pre_load(void *opaque)
-{
-    ICH9LPCPMRegs *s = opaque;
-    Object *obj = OBJECT(s->gpe_cpu.device);
-    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
-    return 0;
-}
-
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "ich9_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_test_use_cpuhp,
-    .pre_load = vmstate_cpuhp_pre_load,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
@@ -338,8 +322,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     pm->powerdown_notifier.notify = pm_powerdown_req;
     qemu_register_powerdown_notifier(&pm->powerdown_notifier);
 
-    legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
-        OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
+    cpu_hotplug_hw_init(pci_address_space_io(lpc_pci),
+        OBJECT(lpc_pci), &pm->cpuhp_state, ICH9_CPU_HOTPLUG_IO_BASE);
 
     acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
                              &pm->acpi_memory_hotplug,
@@ -419,7 +403,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
-    pm->cpu_hotplug_legacy = true;
+    pm->cpu_hotplug_legacy = false;
     pm->disable_s3 = 0;
     pm->disable_s4 = 0;
     pm->s4_val = 2;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 19d4d4be932..0eda692084d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -195,25 +195,10 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };
 
-static bool vmstate_test_use_cpuhp(void *opaque)
-{
-    PIIX4PMState *s = opaque;
-    return !s->cpu_hotplug_legacy;
-}
-
-static int vmstate_cpuhp_pre_load(void *opaque)
-{
-    Object *obj = OBJECT(opaque);
-    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
-    return 0;
-}
-
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "piix4_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_test_use_cpuhp,
-    .pre_load = vmstate_cpuhp_pre_load,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
         VMSTATE_END_OF_LIST()
@@ -573,12 +558,12 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
         qbus_set_hotplug_handler(BUS(pci_get_bus(PCI_DEVICE(s))), OBJECT(s));
     }
 
-    s->cpu_hotplug_legacy = true;
+    s->cpu_hotplug_legacy = false;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
                              piix4_get_cpu_hotplug_legacy,
                              piix4_set_cpu_hotplug_legacy);
-    legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s->gpe_cpu,
-                                 PIIX4_CPU_HOTPLUG_IO_BASE);
+    cpu_hotplug_hw_init(parent, OBJECT(s), &s->cpuhp_state,
+                        PIIX4_CPU_HOTPLUG_IO_BASE);
 
     if (s->acpi_memory_hotplug.is_enabled) {
         acpi_memory_hotplug_init(parent, OBJECT(s), &s->acpi_memory_hotplug,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 19c62362e31..cdd72cbcaa0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -964,7 +964,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
-            .acpi_1_compatible = true, .has_legacy_cphp = true,
+            .acpi_1_compatible = true,
             .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
             .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
         };
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 54ac94e17d3..3e34bedcd6f 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -369,7 +369,6 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
 
     if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
         opts.acpi_1_compatible = false;
-        opts.has_legacy_cphp = false;
         opts.fw_unplugs_cpu = false;
         opts.smi_path = NULL;
 
-- 
2.52.0


