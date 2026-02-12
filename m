Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CAEEE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvP-0005vI-EE; Thu, 12 Feb 2026 09:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-0005Nf-JJ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuI-0005u5-Pa
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MACQ+pwC/87xSTSNF00O4q88/dO5XENN7b3QlytZ5Lk=;
 b=VjqIMR/TMKja4MVjKmy9zoP34D3QXGEUUGGkheT7h8KFw4Z/lhiJM3a9sDpT3PU9tXWdK1
 mZmWR1RYvt0SNMYMIg4cg7aFgaNROBRWfjRUW2EMpV4DWUOSohpdsaOm9C7q3Arka5YrXo
 ZFh9lYu9cmIXvVFEb7eqtAEuulIbtIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-2p9q5RaIM56W56udVssbsg-1; Thu, 12 Feb 2026 09:43:00 -0500
X-MC-Unique: 2p9q5RaIM56W56udVssbsg-1
X-Mimecast-MFC-AGG-ID: 2p9q5RaIM56W56udVssbsg_1770907379
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4376c206493so3657508f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907379; x=1771512179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MACQ+pwC/87xSTSNF00O4q88/dO5XENN7b3QlytZ5Lk=;
 b=VwIlsRLpmu4piVHA9PVMu6J4Pk+BphF9rH5Om6VLDWfca111JeLdwK2GP8xX0Tp07g
 7dXV5HlBeoy85YB47Neqn3sQNvuI0lXBzk25WF408iPdyEMpiMjaApXaiYSRpqRS7pxG
 ofYd+edUHmfTI0UFw874e0xE02gv8ZJa8TbOVFOVEeQLmQj1XgB0qveVAAfv+X6AHeZL
 fjNqYMux9bTPOldhKBwRVRPkwRpC2ZtL/1A9en36Ij5c9xT7d0d7HFuWY0CfJvNG4TgP
 W06/pVPE/G1iFSn3fX1h9qx7oR+2G7GmmwpbgnH07ejxE4waKNTfwffua67FbszRFzIE
 3UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907379; x=1771512179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MACQ+pwC/87xSTSNF00O4q88/dO5XENN7b3QlytZ5Lk=;
 b=BIbwziaPXPQpWVpyEC5xUB6pS8bXszOmpBAYScb+RtKdtmH7yreKSGF464lOurwY6Q
 NTYB95PQaOL1ZQO12a2rzyu0VPPJtEaKSL5uwV4uei/5Ef4VrJBKVsiJnTgSRaitbgjP
 yMvKZDJLmOeMQDoyVSS/qBpPGXIFXr15nf1L5DHCD+67bJ+dQ5+ljyd9RRT2LEbZxOjs
 wxUN07M4puKksdAIFKfF9c67uIJ8gsPuSitpmKB8AxdPfOUWc/rOWQe/pGMSGI88ffOI
 IpbaN914u6WDd5yHIgdGLWABtyN4OvkyCS6Gq9tru2PPgRs+Kfb2SBgf6J8FLaxrJ5Ex
 HG7Q==
X-Gm-Message-State: AOJu0YwsGzY+AQnXX1GfmC3Z48htnBidXoGwCB9FjkVXLK3shh4EhpjE
 tUAS6/a74819dgmPlUDc9qGI/vWgH7uaCVYMK1/hU56uytMaGIpn8nMpbBptvb+0TE3GX5/Cmmy
 AisD06qnFkn5ZIHAeGIPmB7NNtznuFZ/sUqiJGT7cuMB5hUQishK+Oa+w96Dsi+eY1YVKcoE0KM
 brtBprQNOu1FAdgLchGpK5evmib7dZZW97Hzm1aE+L
X-Gm-Gg: AZuq6aLSUrx6vZfWxVNWoD1x/CM2dSy5855j5AiWmefHcxUch4sW8JvJOajWjm3pIKE
 sKd6PbaDCoPhKXHWCsS93TB6OADP4S5+XwFsuzgHCAAk7Cv7lvfHdcczFTLJ8iENBjVpXiEEb91
 nVVJg66DKeAK/3jeII74UXPx915qjgu/Ff9gco/2gDj0Fpoq7KYYiDynKGG/Vg0baGB5a8Eoha8
 H2czHj3cp5y7C7RGWLkahjdJf0Gr28js6g/mBACdpJlpUw5xqutZf28/Vix6Ao7GQxQdpGS6U44
 jxECLvdlWhusVHK9YghkDoi2W9LIMdMay5NMAI1Ssgd5zE37m5/ypBTOavt4H9EBXQTNMw7pB5I
 wlOvGW4ab7JHe7HpQRpv8g7jSLU8hyMyJ9GFC+4y9JGLtGVmEMZMoo7YV8sl8ZHrJpPcbE5rpWU
 ED9EOa+wb541RYYaud4X7NNPV4cb/tAcMf3hORvC2Cx3RGNmrG3Pc=
X-Received: by 2002:a05:6000:4023:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4378aa01778mr4321096f8f.6.1770907378475; 
 Thu, 12 Feb 2026 06:42:58 -0800 (PST)
X-Received: by 2002:a05:6000:4023:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4378aa01778mr4321034f8f.6.1770907377716; 
 Thu, 12 Feb 2026 06:42:57 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d46f9csm12212405f8f.10.2026.02.12.06.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 06/41] acpi: Remove legacy cpu hotplug utilities
Date: Thu, 12 Feb 2026 15:42:08 +0100
Message-ID: <20260212144244.22579-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The cpu_hotplug.h and cpu_hotplug.c contain legacy cpu hotplug
utilities. Now there's no use case of legacy cpu hotplug, so it's safe
to drop legacy cpu hotplug support totally.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20260108033051.777361-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/acpi/ich9.h          |   2 +-
 include/hw/acpi/piix4.h         |   2 +-
 hw/acpi/acpi-cpu-hotplug-stub.c |  19 +-
 hw/acpi/cpu_hotplug.c           | 348 --------------------------------
 hw/acpi/generic_event_device.c  |   1 +
 hw/acpi/ich9.c                  |   1 +
 hw/acpi/piix4.c                 |   2 +-
 hw/i386/acpi-build.c            |   1 +
 hw/i386/pc.c                    |   3 +-
 hw/i386/x86-common.c            |   1 -
 hw/acpi/meson.build             |   2 +-
 11 files changed, 10 insertions(+), 372 deletions(-)
 delete mode 100644 hw/acpi/cpu_hotplug.c

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 6a21472eb32..019f0915c11 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -22,12 +22,12 @@
 #define HW_ACPI_ICH9_H
 
 #include "hw/acpi/acpi.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/ich9_tco.h"
+#include "hw/acpi/cpu.h"
 
 #define ACPI_PCIHP_ADDR_ICH9 0x0cc0
 
diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
index e075f0cbeaf..863382a814a 100644
--- a/include/hw/acpi/piix4.h
+++ b/include/hw/acpi/piix4.h
@@ -24,11 +24,11 @@
 
 #include "hw/pci/pci_device.h"
 #include "hw/acpi/acpi.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/isa/apm.h"
+#include "hw/acpi/cpu.h"
 
 #define TYPE_PIIX4_PM "PIIX4_PM"
 OBJECT_DECLARE_SIMPLE_TYPE(PIIX4PMState, PIIX4_PM)
diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 9872dd55e43..72c5f05f5c4 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -1,22 +1,10 @@
 #include "qemu/osdep.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "migration/vmstate.h"
-
+#include "hw/acpi/cpu.h"
 
 /* Following stubs are all related to ACPI cpu hotplug */
 const VMStateDescription vmstate_cpu_hotplug;
 
-void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
-                                CPUHotplugState *cpuhp_state,
-                                uint16_t io_port)
-{
-}
-
-void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
-                                  AcpiCpuHotplug *gpe_cpu, uint16_t base)
-{
-}
-
 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
                          CPUHotplugState *state, hwaddr base_addr)
 {
@@ -31,11 +19,6 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
 {
 }
 
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
-                             AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
-{
-}
-
 void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
                         DeviceState *dev, Error **errp)
 {
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
deleted file mode 100644
index aa0e1e3efa5..00000000000
--- a/hw/acpi/cpu_hotplug.c
+++ /dev/null
@@ -1,348 +0,0 @@
-/*
- * QEMU ACPI hotplug utilities
- *
- * Copyright (C) 2013 Red Hat Inc
- *
- * Authors:
- *   Igor Mammedov <imammedo@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-#include "qemu/osdep.h"
-#include "hw/acpi/cpu_hotplug.h"
-#include "qapi/error.h"
-#include "hw/core/cpu.h"
-#include "hw/i386/x86.h"
-#include "hw/pci/pci_device.h"
-#include "qemu/error-report.h"
-
-#define CPU_EJECT_METHOD "CPEJ"
-#define CPU_MAT_METHOD "CPMA"
-#define CPU_ON_BITMAP "CPON"
-#define CPU_STATUS_METHOD "CPST"
-#define CPU_STATUS_MAP "PRS"
-#define CPU_SCAN_METHOD "PRSC"
-
-static uint64_t cpu_status_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    AcpiCpuHotplug *cpus = opaque;
-    uint64_t val = cpus->sts[addr];
-
-    return val;
-}
-
-static void cpu_status_write(void *opaque, hwaddr addr, uint64_t data,
-                             unsigned int size)
-{
-    /* firmware never used to write in CPU present bitmap so use
-       this fact as means to switch QEMU into modern CPU hotplug
-       mode by writing 0 at the beginning of legacy CPU bitmap
-     */
-    if (addr == 0 && data == 0) {
-        AcpiCpuHotplug *cpus = opaque;
-        object_property_set_bool(cpus->device, "cpu-hotplug-legacy", false,
-                                 &error_abort);
-    }
-}
-
-static const MemoryRegionOps AcpiCpuHotplug_ops = {
-    .read = cpu_status_read,
-    .write = cpu_status_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-    },
-    .impl = {
-        .max_access_size = 1,
-    },
-};
-
-static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
-                                     bool *swtchd_to_modern)
-{
-    int64_t cpu_id;
-
-    cpu_id = cpu->cc->get_arch_id(cpu);
-    if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
-        object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
-                                 &error_abort);
-        *swtchd_to_modern = true;
-        return;
-    }
-
-    *swtchd_to_modern = false;
-    g->sts[cpu_id / 8] |= (1 << (cpu_id % 8));
-}
-
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
-                             AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
-{
-    bool swtchd_to_modern;
-    Error *local_err = NULL;
-
-    acpi_set_cpu_present_bit(g, CPU(dev), &swtchd_to_modern);
-    if (swtchd_to_modern) {
-        /* propagate the hotplug to the modern interface */
-        hotplug_handler_plug(hotplug_dev, dev, &local_err);
-    } else {
-        acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
-    }
-}
-
-void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
-                                  AcpiCpuHotplug *gpe_cpu, uint16_t base)
-{
-    CPUState *cpu;
-    bool swtchd_to_modern;
-
-    memory_region_init_io(&gpe_cpu->io, owner, &AcpiCpuHotplug_ops,
-                          gpe_cpu, "acpi-cpu-hotplug", ACPI_GPE_PROC_LEN);
-    memory_region_add_subregion(parent, base, &gpe_cpu->io);
-    gpe_cpu->device = owner;
-
-    CPU_FOREACH(cpu) {
-        acpi_set_cpu_present_bit(gpe_cpu, cpu, &swtchd_to_modern);
-    }
-}
-
-void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
-                                CPUHotplugState *cpuhp_state,
-                                uint16_t io_port)
-{
-    MemoryRegion *parent = pci_address_space_io(PCI_DEVICE(gpe_cpu->device));
-
-    memory_region_del_subregion(parent, &gpe_cpu->io);
-    cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port);
-}
-
-void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
-                                  uint16_t io_base)
-{
-    Aml *dev;
-    Aml *crs;
-    Aml *pkg;
-    Aml *field;
-    Aml *method;
-    Aml *if_ctx;
-    Aml *else_ctx;
-    int i, apic_idx;
-    Aml *sb_scope = aml_scope("_SB");
-    uint8_t madt_tmpl[8] = {0x00, 0x08, 0x00, 0x00, 0x00, 0, 0, 0};
-    Aml *cpu_id = aml_arg(1);
-    Aml *apic_id = aml_arg(0);
-    Aml *cpu_on = aml_local(0);
-    Aml *madt = aml_local(1);
-    Aml *cpus_map = aml_name(CPU_ON_BITMAP);
-    Aml *zero = aml_int(0);
-    Aml *one = aml_int(1);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-
-    /*
-     * _MAT method - creates an madt apic buffer
-     * apic_id = Arg0 = Local APIC ID
-     * cpu_id  = Arg1 = Processor ID
-     * cpu_on = Local0 = CPON flag for this cpu
-     * madt = Local1 = Buffer (in madt apic form) to return
-     */
-    method = aml_method(CPU_MAT_METHOD, 2, AML_NOTSERIALIZED);
-    aml_append(method,
-        aml_store(aml_derefof(aml_index(cpus_map, apic_id)), cpu_on));
-    aml_append(method,
-        aml_store(aml_buffer(sizeof(madt_tmpl), madt_tmpl), madt));
-    /* Update the processor id, lapic id, and enable/disable status */
-    aml_append(method, aml_store(cpu_id, aml_index(madt, aml_int(2))));
-    aml_append(method, aml_store(apic_id, aml_index(madt, aml_int(3))));
-    aml_append(method, aml_store(cpu_on, aml_index(madt, aml_int(4))));
-    aml_append(method, aml_return(madt));
-    aml_append(sb_scope, method);
-
-    /*
-     * _STA method - return ON status of cpu
-     * apic_id = Arg0 = Local APIC ID
-     * cpu_on = Local0 = CPON flag for this cpu
-     */
-    method = aml_method(CPU_STATUS_METHOD, 1, AML_NOTSERIALIZED);
-    aml_append(method,
-        aml_store(aml_derefof(aml_index(cpus_map, apic_id)), cpu_on));
-    if_ctx = aml_if(cpu_on);
-    {
-        aml_append(if_ctx, aml_return(aml_int(0xF)));
-    }
-    aml_append(method, if_ctx);
-    else_ctx = aml_else();
-    {
-        aml_append(else_ctx, aml_return(zero));
-    }
-    aml_append(method, else_ctx);
-    aml_append(sb_scope, method);
-
-    method = aml_method(CPU_EJECT_METHOD, 2, AML_NOTSERIALIZED);
-    aml_append(method, aml_sleep(200));
-    aml_append(sb_scope, method);
-
-    method = aml_method(CPU_SCAN_METHOD, 0, AML_NOTSERIALIZED);
-    {
-        Aml *while_ctx, *if_ctx2, *else_ctx2;
-        Aml *bus_check_evt = aml_int(1);
-        Aml *remove_evt = aml_int(3);
-        Aml *status_map = aml_local(5); /* Local5 = active cpu bitmap */
-        Aml *byte = aml_local(2); /* Local2 = last read byte from bitmap */
-        Aml *idx = aml_local(0); /* Processor ID / APIC ID iterator */
-        Aml *is_cpu_on = aml_local(1); /* Local1 = CPON flag for cpu */
-        Aml *status = aml_local(3); /* Local3 = active state for cpu */
-
-        aml_append(method, aml_store(aml_name(CPU_STATUS_MAP), status_map));
-        aml_append(method, aml_store(zero, byte));
-        aml_append(method, aml_store(zero, idx));
-
-        /* While (idx < SizeOf(CPON)) */
-        while_ctx = aml_while(aml_lless(idx, aml_sizeof(cpus_map)));
-        aml_append(while_ctx,
-            aml_store(aml_derefof(aml_index(cpus_map, idx)), is_cpu_on));
-
-        if_ctx = aml_if(aml_and(idx, aml_int(0x07), NULL));
-        {
-            /* Shift down previously read bitmap byte */
-            aml_append(if_ctx, aml_shiftright(byte, one, byte));
-        }
-        aml_append(while_ctx, if_ctx);
-
-        else_ctx = aml_else();
-        {
-            /* Read next byte from cpu bitmap */
-            aml_append(else_ctx, aml_store(aml_derefof(aml_index(status_map,
-                       aml_shiftright(idx, aml_int(3), NULL))), byte));
-        }
-        aml_append(while_ctx, else_ctx);
-
-        aml_append(while_ctx, aml_store(aml_and(byte, one, NULL), status));
-        if_ctx = aml_if(aml_lnot(aml_equal(is_cpu_on, status)));
-        {
-            /* State change - update CPON with new state */
-            aml_append(if_ctx, aml_store(status, aml_index(cpus_map, idx)));
-            if_ctx2 = aml_if(aml_equal(status, one));
-            {
-                aml_append(if_ctx2,
-                    aml_call2(AML_NOTIFY_METHOD, idx, bus_check_evt));
-            }
-            aml_append(if_ctx, if_ctx2);
-            else_ctx2 = aml_else();
-            {
-                aml_append(else_ctx2,
-                    aml_call2(AML_NOTIFY_METHOD, idx, remove_evt));
-            }
-        }
-        aml_append(if_ctx, else_ctx2);
-        aml_append(while_ctx, if_ctx);
-
-        aml_append(while_ctx, aml_increment(idx)); /* go to next cpu */
-        aml_append(method, while_ctx);
-    }
-    aml_append(sb_scope, method);
-
-    /* The current AML generator can cover the APIC ID range [0..255],
-     * inclusive, for VCPU hotplug. */
-    QEMU_BUILD_BUG_ON(ACPI_CPU_HOTPLUG_ID_LIMIT > 256);
-    if (x86ms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
-        error_report("max_cpus is too large. APIC ID of last CPU is %u",
-                     x86ms->apic_id_limit - 1);
-        exit(1);
-    }
-
-    /* create PCI0.PRES device and its _CRS to reserve CPU hotplug MMIO */
-    dev = aml_device("PCI0." stringify(CPU_HOTPLUG_RESOURCE_DEVICE));
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A06")));
-    aml_append(dev,
-        aml_name_decl("_UID", aml_string("CPU Hotplug resources"))
-    );
-    /* device present, functioning, decoding, not shown in UI */
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
-    crs = aml_resource_template();
-    aml_append(crs,
-        aml_io(AML_DECODE16, io_base, io_base, 1, ACPI_GPE_PROC_LEN)
-    );
-    aml_append(dev, aml_name_decl("_CRS", crs));
-    aml_append(sb_scope, dev);
-    /* declare CPU hotplug MMIO region and PRS field to access it */
-    aml_append(sb_scope, aml_operation_region(
-        "PRST", AML_SYSTEM_IO, aml_int(io_base), ACPI_GPE_PROC_LEN));
-    field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
-    aml_append(field, aml_named_field("PRS", 256));
-    aml_append(sb_scope, field);
-
-    /* build Processor object for each processor */
-    for (i = 0; i < apic_ids->len; i++) {
-        int cpu_apic_id = apic_ids->cpus[i].arch_id;
-
-        assert(cpu_apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
-
-        dev = aml_processor(i, 0, 0, "CP%.02X", cpu_apic_id);
-
-        method = aml_method("_MAT", 0, AML_NOTSERIALIZED);
-        aml_append(method,
-            aml_return(aml_call2(CPU_MAT_METHOD,
-                                 aml_int(cpu_apic_id), aml_int(i))
-        ));
-        aml_append(dev, method);
-
-        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
-        aml_append(method,
-            aml_return(aml_call1(CPU_STATUS_METHOD, aml_int(cpu_apic_id))));
-        aml_append(dev, method);
-
-        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-        aml_append(method,
-            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(cpu_apic_id),
-                aml_arg(0)))
-        );
-        aml_append(dev, method);
-
-        aml_append(sb_scope, dev);
-    }
-
-    /* build this code:
-     *   Method(NTFY, 2) {If (LEqual(Arg0, 0x00)) {Notify(CP00, Arg1)} ...}
-     */
-    /* Arg0 = APIC ID */
-    method = aml_method(AML_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
-    for (i = 0; i < apic_ids->len; i++) {
-        int cpu_apic_id = apic_ids->cpus[i].arch_id;
-
-        if_ctx = aml_if(aml_equal(aml_arg(0), aml_int(cpu_apic_id)));
-        aml_append(if_ctx,
-            aml_notify(aml_name("CP%.02X", cpu_apic_id), aml_arg(1))
-        );
-        aml_append(method, if_ctx);
-    }
-    aml_append(sb_scope, method);
-
-    /* build "Name(CPON, Package() { One, One, ..., Zero, Zero, ... })"
-     *
-     * Note: The ability to create variable-sized packages was first
-     * introduced in ACPI 2.0. ACPI 1.0 only allowed fixed-size packages
-     * ith up to 255 elements. Windows guests up to win2k8 fail when
-     * VarPackageOp is used.
-     */
-    pkg = x86ms->apic_id_limit <= 255 ? aml_package(x86ms->apic_id_limit) :
-                                        aml_varpackage(x86ms->apic_id_limit);
-
-    for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
-        int cpu_apic_id = apic_ids->cpus[i].arch_id;
-
-        for (; apic_idx < cpu_apic_id; apic_idx++) {
-            aml_append(pkg, aml_int(0));
-        }
-        aml_append(pkg, aml_int(apic_ids->cpus[i].cpu ? 1 : 0));
-        apic_idx = cpu_apic_id + 1;
-    }
-    aml_append(sb_scope, aml_name_decl(CPU_ON_BITMAP, pkg));
-    aml_append(ctx, sb_scope);
-
-    method = aml_method("\\_GPE._E02", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_call0("\\_SB." CPU_SCAN_METHOD));
-    aml_append(ctx, method);
-}
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 6741f46723c..30dab43a00c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
+#include "hw/acpi/cpu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pci.h"
 #include "hw/core/irq.h"
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index f254f387971..bbb1bd60a20 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -40,6 +40,7 @@
 #include "hw/southbridge/ich9.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/pc-hotplug.h"
 
 static void ich9_pm_update_sci_fn(ACPIREGS *regs)
 {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 05f9d6372a9..138ac3d3940 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -33,7 +33,6 @@
 #include "system/xen.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
 #include "hw/core/hotplug.h"
 #include "hw/mem/pc-dimm.h"
@@ -43,6 +42,7 @@
 #include "migration/vmstate.h"
 #include "hw/core/cpu.h"
 #include "qom/object.h"
+#include "hw/acpi/pc-hotplug.h"
 
 #define GPE_BASE 0xafe0
 #define GPE_LEN 4
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 22bd497c9be..f622b91b76a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -35,6 +35,7 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/pc-hotplug.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/acpi_aml_interface.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cb074c0a08..716962f24fc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -48,7 +48,8 @@
 #include "hw/xen/xen.h"
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
-#include "hw/acpi/cpu_hotplug.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/pc-hotplug.h"
 #include "acpi-build.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c1c92240392..85b90ff4324 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -36,7 +36,6 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "target/i386/sev.h"
 
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/core/irq.h"
 #include "hw/core/loader.h"
 #include "multiboot.h"
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 56b5d1ec969..66c978aae83 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -6,7 +6,7 @@ acpi_ss.add(files(
   'core.c',
   'utils.c',
 ))
-acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c', 'cpu_hotplug.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false: files('acpi-cpu-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true: files('memory_hotplug.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false: files('acpi-mem-hotplug-stub.c'))
-- 
2.52.0


