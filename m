Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB06C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1R4-0006lH-C0; Thu, 08 May 2025 09:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1R0-0006VZ-4t
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:37:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Qw-0003kh-BS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:37:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e7e5bce38so10598675ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711414; x=1747316214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqgogeCazIgNGaFHm1QR/r57XUs47z0A0mc8QZ9eeJQ=;
 b=lg1J/RLxw7h6JC5kj12K56gBfyxYWysdmWuVU5vKMZID/tAcNKwy1Ha3AWU709Z+VT
 I6spfmICa0WAdUYxvj6Gx1qWB7s10+13Mf0jPyu5vdRHwD5dpBavTuUQjQjy+sK+fFXo
 TOpxOXlG7th2y3yvbhSnB9ATdbIRbhCAyWFSr/MgGGPDrKnbxNIkdPGaT0xTniId0rSD
 bK8Dd3QjN2NsUMkzU8DjSI1923ucaAFqfgXSeaXcuVPnTgGGF9gllqtbW+RuTWoVjTGe
 93tvKw5uD+2ajDEHjiNsRG57b26kaZkJ7M6enQdoxOJfcGuXgjl1piSqtSVcHjbsJoHe
 4YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711414; x=1747316214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqgogeCazIgNGaFHm1QR/r57XUs47z0A0mc8QZ9eeJQ=;
 b=WsumzT0PReXaer2eAmFQuVuLrrA5a/GQe9XKLiPlilyAbDINHGcx5N3X+abBDttB//
 ip9U0nppD5kOY9+zV0o9P+/Se8K2Os3tO84apTKw8QOOHccAG2e1m6FkX+nFM2foN1CU
 ilbYAqX8r+rpnwvHyImbi75IaYViUw/0OXN7iR/zKREOdl+a7wHRBknvt3+b7SQw4gUl
 UnNKsPx8RhciOHSe4JHuIjkUlR5q4rkxStT1s/YFAjs6aLNyljt5V4sQQKqFAIHG0Rjn
 VvzYQYRCGCLmVg6IqS5TRYFJoH0C0WDclb+HPZLqZ+YlbkQxbHe43q4AjIZR4C4/aVO4
 JxLw==
X-Gm-Message-State: AOJu0Yy4g6QbNOjsUUPEt7NxM1slLWjF2DLj8sW4FiVXcrg2RP/lUEBI
 uqathXdJeHxic+1ZnOlFf00N7P2Yffgx9c3O8cvDDJDbeHWnWGpBQNlpWremy14p75X1e4CnhYR
 K1euljQ==
X-Gm-Gg: ASbGncvvoMuq8I5Ebk76CXeo053DanSee9i1qNFSgQjcjQhbnxf0bSWHH1eS8lwuT7Z
 7eeQu189JaS99hdif/KkOqZlrRHO9TNksQMG1RlFtIU8em/nrGJM/1BCTFNyAU7B1bzajz0OsTv
 kU7+PV3vkBz0ivMgBvNcjtSUXlkozY4zMMiB6bUOHdr3Ud6EIzAANJxqhv0c3b0C+simo0CxGds
 ufdxSqFUEMJLd8RcZEoMCp/oFbNK0re6holAW9Q4OrJ5LRdT/pXML7FWzr1IoEk+r8cB+bRdume
 9Ks+4WtvhTjMlWuSpemSo2t8Dw77ooFJhYVg/s9oRxm+aMBz6pVIKOKe+Y3pGBw5O/OhZA/jq6g
 P00V0yEiwaDMQY8Y=
X-Google-Smtp-Source: AGHT+IHzRcRoYGKRyL2InxQZiJOyVQM9F7k5lWp6pNqPQagR6HqU92+zSX+mrGYl3Qn7IdnQhr3s3A==
X-Received: by 2002:a17:902:e950:b0:22e:3f1e:a106 with SMTP id
 d9443c01a7336-22e5ea422a2mr118803165ad.5.1746711413862; 
 Thu, 08 May 2025 06:36:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97eesm112419795ad.71.2025.05.08.06.36.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:36:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 02/27] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
Date: Thu,  8 May 2025 15:35:25 +0200
Message-ID: <20250508133550.81391-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The PCMachineClass::legacy_cpu_hotplug boolean was only used
by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Remove it and simplify build_dsdt(), removing
build_legacy_cpu_hotplug_aml() altogether.

Note, this field was added by commit 679dd1a957d ("pc: use
new CPU hotplug interface since 2.7 machine type"):

 >  For compatibility reasons PC/Q35 will start with legacy
 >  CPU hotplug interface by default but with new CPU hotplug
 >  AML code since 2.7 machine type. That way legacy firmware
 >  that doesn't use QEMU generated ACPI tables will be
 >  able to continue using legacy CPU hotplug interface.
 >
 >  While new machine type, with firmware supporting QEMU
 >  provided ACPI tables, will generate new CPU hotplug AML,
 >  which will switch to new CPU hotplug interface when
 >  guest OS executes its _INI method on ACPI tables
 >  loading.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/acpi/cpu_hotplug.h |   3 -
 include/hw/i386/pc.h          |   3 -
 hw/acpi/cpu_hotplug.c         | 230 ----------------------------------
 hw/i386/acpi-build.c          |   4 +-
 4 files changed, 1 insertion(+), 239 deletions(-)

diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
index 3b932abbbbe..aeee630cf05 100644
--- a/include/hw/acpi/cpu_hotplug.h
+++ b/include/hw/acpi/cpu_hotplug.h
@@ -34,7 +34,4 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
 void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
                                 CPUHotplugState *cpuhp_state,
                                 uint16_t io_port);
-
-void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
-                                  uint16_t io_base);
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 79b72c54dd3..a3de3e9560d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -110,9 +110,6 @@ struct PCMachineClass {
     bool enforce_amd_1tb_hole;
     bool isa_bios_alias;
 
-    /* generate legacy CPU hotplug AML */
-    bool legacy_cpu_hotplug;
-
     /* use PVH to load kernels that support this feature */
     bool pvh_enabled;
 
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index aa0e1e3efa5..fe439705bda 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -116,233 +116,3 @@ void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
     memory_region_del_subregion(parent, &gpe_cpu->io);
     cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port);
 }
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
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a3328..625889783ec 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1465,9 +1465,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
     aml_append(dsdt, scope);
 
-    if (pcmc->legacy_cpu_hotplug) {
-        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
-    } else {
+    {
         CPUHotplugFeatures opts = {
             .acpi_1_compatible = true, .has_legacy_cphp = true,
             .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
-- 
2.47.1


