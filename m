Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB6AC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZR1-0001w0-O4; Wed, 22 Jan 2025 07:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1taZQw-0001vY-9F
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1taZQs-0004Nb-6G
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737547324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pTRubCZzEsqrTtZRCK1kVXGdV+yrXyrFPMO/KxXiFtk=;
 b=eqwJNLwosuPqCdiBnBghrBngjvNyiqCYKCoflz48r5XMcJuiqh+qlrybq+dyqhCb8afGPq
 q5mEQ1bWFQSCBJxaHanRXgzYsPF0gCgSmZzhHEiBTPhj67COk55raGMPEsHXNBQqXL/jTl
 C4bsfYTRIArpIvttI8wuZAozy1pqwj4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-1Q2KIfeANzKro56br-CDZA-1; Wed, 22 Jan 2025 07:02:02 -0500
X-MC-Unique: 1Q2KIfeANzKro56br-CDZA-1
X-Mimecast-MFC-AGG-ID: 1Q2KIfeANzKro56br-CDZA
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2162259a5dcso204119575ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 04:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737547321; x=1738152121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pTRubCZzEsqrTtZRCK1kVXGdV+yrXyrFPMO/KxXiFtk=;
 b=eEE5jjrvbGHDXAlhmBOAiwX11Iqr9oRIfuhsSTz66owc1lUAGMHWZ5fFwwRumqE+WM
 /5NCikoHG2iiMzPi9qn+fbbqBwajGuRbOJD/e0296SsW9a2iIzKgBSdVF3x0ishKBKFb
 yVvcu4gOTOoqlcQsEg2P8aatGqsgzbaBAynafOHJ9tGGy8H5qE6gHVDW7IKHj/j7d16q
 kJB8geMyV22qEmL6tvlm3Fve/Ln316mN9Tht9/+DsmdkvXbK2oYBs4ctf8jEBtKTI1ZF
 MoV/LdQ6jhCgkPAgrANdXDqYlcVzECvD2DOKk0yK1fGIzXstLIebmtzfdyIsfjMvWBDm
 XznQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF5sCLUo+OiYhFWW+0YGgifADJhoazVn9/L47J0WVYK+BDY/9URJNT9ytepACRP/DE3lQdX+PArkXd@nongnu.org
X-Gm-Message-State: AOJu0Yz+PCJ+fIUAjj2fJDHMfAhMbuDM4bEU7mUOZ1W6vBlAK6P+4+40
 ENxLEp1uej/uzxQq6laviL+CmiVebiXwbHqnJRQGYlwhZjUvQqbsMdSZ2wwfBavjH7vTOEBHTwM
 MOywcyKp/5Emx9caFZG/mLS5nslw65fGFX9Dm4yw91kFMYFTVDi/Q
X-Gm-Gg: ASbGnctwStvfJ8KuUMRNbERxOMhCBT3zV/HZpKt0+ww2oz0syOb35QUwRXbeQW3R5vB
 4WgDL/2tB30VytxAjG6u083Jfh8ZQFat+wq9nCnFwyxmDbju8CM8BeuYnLrxRgADIjWySYE9IHu
 rNrrw2ZrB4nFSq5ZWj0WZT8rD9wQowUQZFEVIIpRfvXEqsRJATgAJH5z3lpSLqDOUMOjV0eb9SV
 5BNHWJjLLDYhOIFkxCHSGz4M5qsZQM5F6J18SyeXZx0qvrXWBvC6nJtJJbXS4mVb7O2hPXANOz8
 sGse4S3Wbkf3o1z+
X-Received: by 2002:a17:902:d511:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-21c3562167emr379338955ad.44.1737547321336; 
 Wed, 22 Jan 2025 04:02:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9kXF1HDzrAPwo0m1qVL+N0rVWGWPRe+rhUJU/bWwD01+jDQN9ISu6PyuJeG3kmxEjY08QPg==
X-Received: by 2002:a17:902:d511:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-21c3562167emr379338255ad.44.1737547320763; 
 Wed, 22 Jan 2025 04:02:00 -0800 (PST)
Received: from localhost.localdomain ([115.96.146.72])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21c2ce9ee18sm94395145ad.52.2025.01.22.04.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 04:02:00 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4] hw/i386/cpu: remove default_cpu_version and simplify
Date: Wed, 22 Jan 2025 17:31:16 +0530
Message-ID: <20250122120117.1154596-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
introduced 'default_cpu_version' for PCMachineClass. This created three
categories of CPU models:
 - Most unversioned CPU models would use version 1 by default.
 - For machines 4.0.1 and older that do not support cpu model aliases, a
   special default_cpu_version value of CPU_VERSION_LEGACY is used.
 - It was thought that future machines would use the latest value of cpu
   versions corresponding to default_cpu_version value of
   CPU_VERSION_LATEST [1].

All pc machines still use the default cpu version of 1 for
unversioned cpu models. CPU_VERSION_LATEST is a moving target and
changes with time. Therefore, if machines use CPU_VERSION_LATEST, it would
mean that over a period of time, for the same machine type, the cpu version
would be different depending on what is latest at that time. This would
break guests even when they use a constant machine type. Therefore, for
pc machines, use of CPU_VERSION_LATEST is not possible. Currently, only
microvms use CPU_VERSION_LATEST.

This change cleans up the complicated logic around default_cpu_version
including getting rid of default_cpu_version property itself. A couple of new
flags are introduced, one for the legacy model for machines 4.0.1 and older
and other for microvms. For older machines, a new pc machine property is
introduced that separates pc machine versions 4.0.1 and older from the newer
machines. 4.0.1 and older machines are scheduled to be deleted towards
end of 2025 since they would be 6 years old by then. At that time, we can
remove all logic around legacy cpus. Microvms are the only machines that
continue to use the latest cpu version. If this changes later, we can
remove all logic around x86_cpu_model_last_version(). Default cpu version
for unversioned cpu models is hardcoded to the value 1 and applies
unconditionally for all pc machine types of version 4.1 and above.

This change also removes all complications around CPU_VERSION_AUTO
including removal of the value itself.

1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")

CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/microvm.c     |  3 +-
 hw/i386/pc_piix.c     |  6 ++--
 hw/i386/pc_q35.c      |  6 ++--
 hw/i386/x86-common.c  |  4 +--
 include/hw/i386/pc.h  | 19 ++++++++++--
 include/hw/i386/x86.h |  5 +++-
 target/i386/cpu.c     | 69 ++++++++++++++++++++++---------------------
 target/i386/cpu.h     | 23 ++++-----------
 8 files changed, 70 insertions(+), 65 deletions(-)

changelog:
v2: explain in commit log why use of CPU_VERSION_LATEST for machines
is problematic.
v3: fix a bug that broke the pipeline
https://gitlab.com/mstredhat/qemu/-/pipelines/1626171267
when cpu versions are explicitly specified in the command line,
respect that and do not enforce legacy (unversioned) cpu logic.
The pipeline is green now with the fix:
https://gitlab.com/anisinha/qemu/-/pipelines/1626783632
v4: made changes as per Zhao's suggestions.
Pipeline passes https://gitlab.com/anisinha/qemu/-/pipelines/1635829877

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe..ffb1b37fe5 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -458,7 +458,8 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    x86_cpu_uses_lastest_version();
+    x86_cpus_init(x86ms);
 
     microvm_devices_init(mms);
 }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04d2957adc..dc684cb011 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -181,7 +181,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 
     pc_machine_init_sgx_epc(pcms);
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    pc_init_cpus(machine);
 
     if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
@@ -457,7 +458,6 @@ static void pc_i440fx_machine_options(MachineClass *m)
     ObjectClass *oc = OBJECT_CLASS(m);
     pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
     pcmc->pci_root_uid = 0;
-    pcmc->default_cpu_version = 1;
 
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
@@ -669,7 +669,7 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
+    pcmc->no_versioned_cpu_model = true;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 77536dd697..045b05da64 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -187,7 +187,8 @@ static void pc_q35_init(MachineState *machine)
     }
 
     pc_machine_init_sgx_epc(pcms);
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    pc_init_cpus(machine);
 
     if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
@@ -339,7 +340,6 @@ static void pc_q35_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pcmc->pci_root_uid = 0;
-    pcmc->default_cpu_version = 1;
 
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
@@ -547,7 +547,7 @@ static void pc_q35_machine_4_0_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
+    pcmc->no_versioned_cpu_model = true;
     /*
      * This is the default machine for the 4.0-stable branch. It is basically
      * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 008496b5b8..1ed5bc6010 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -66,15 +66,13 @@ out:
     object_unref(cpu);
 }
 
-void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
+void x86_cpus_init(X86MachineState *x86ms)
 {
     int i;
     const CPUArchIdList *possible_cpus;
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
-    x86_cpu_set_default_version(default_cpu_version);
-
     /*
      * Calculates the limit to CPU APIC ID values
      *
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a558705cb9..34106bb52d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -92,9 +92,6 @@ struct PCMachineClass {
 
     /* Compat options: */
 
-    /* Default CPU model version.  See x86_cpu_set_default_version(). */
-    int default_cpu_version;
-
     /* ACPI compat: */
     bool has_acpi_build;
     int pci_root_uid;
@@ -125,11 +122,27 @@ struct PCMachineClass {
      * check for memory.
      */
     bool broken_32bit_mem_addr_check;
+
+    /* whether the machine supports versioned cpu models */
+    bool no_versioned_cpu_model;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
 OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
 
+static inline void pc_init_cpus(MachineState *ms)
+{
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    PCMachineState *pcms = PC_MACHINE(ms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+
+    if (pcmc->no_versioned_cpu_model) {
+        /* use legacy cpu as it does not support versions */
+        x86_cpu_set_legacy_version();
+    }
+    x86_cpus_init(x86ms);
+}
+
 /* ioapic.c */
 
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..41236d2a80 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -114,7 +114,10 @@ void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index);
 
-void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
+void x86_cpus_init(X86MachineState *pcms);
+#ifndef I386_CPU_H
+void x86_cpu_set_legacy_version(void);
+#endif
 void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
 void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                       DeviceState *dev, Error **errp);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b9c11022c..c1f868c4dd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -192,6 +192,9 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
  */
 #define CACHE_DESCRIPTOR_UNAVAILABLE 0xFF
 
+/* default cpu version to use */
+#define DEFAULT_CPU_VERSION 1
+
 /*
  * Return a CPUID 2 cache descriptor for a given cache.
  * If no known descriptor is found, return CACHE_DESCRIPTOR_UNAVAILABLE
@@ -5343,20 +5346,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
     },
 };
 
-/*
- * We resolve CPU model aliases using -v1 when using "-machine
- * none", but this is just for compatibility while libvirt isn't
- * adapted to resolve CPU model versions before creating VMs.
- * See "Runnability guarantee of CPU models" at
- * docs/about/deprecated.rst.
- */
-X86CPUVersion default_cpu_version = 1;
+static bool use_legacy_cpu;
+void x86_cpu_set_legacy_version(void)
+{
+    use_legacy_cpu = true;
+}
 
-void x86_cpu_set_default_version(X86CPUVersion version)
+static bool use_latest_cpu;
+void x86_cpu_uses_lastest_version(void)
 {
-    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
-    assert(version != CPU_VERSION_AUTO);
-    default_cpu_version = version;
+    use_latest_cpu = true;
 }
 
 static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
@@ -5374,14 +5373,11 @@ static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
 /* Return the actual version being used for a specific CPU model */
 static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
 {
-    X86CPUVersion v = model->version;
-    if (v == CPU_VERSION_AUTO) {
-        v = default_cpu_version;
-    }
-    if (v == CPU_VERSION_LATEST) {
+    if (use_latest_cpu) {
         return x86_cpu_model_last_version(model);
     }
-    return v;
+
+    return model->version;
 }
 
 static const Property max_x86_cpu_properties[] = {
@@ -5985,10 +5981,15 @@ static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
     if (!cc->model || !cc->model->is_alias) {
         return NULL;
     }
-    version = x86_cpu_model_resolve_version(cc->model);
-    if (version <= 0) {
+
+    if (use_legacy_cpu) {
+        /* legacy cpu models do not support cpu aliases */
         return NULL;
     }
+
+    version = x86_cpu_model_resolve_version(cc->model);
+    assert(version);
+
     return x86_cpu_versioned_model_name(cc->model->cpudef, version);
 }
 
@@ -6002,11 +6003,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     g_autofree char *model_id = x86_cpu_class_get_model_id(cc);
 
     if (!desc && alias_of) {
-        if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
-            desc = g_strdup("(alias configured by machine type)");
-        } else {
             desc = g_strdup_printf("(alias of %s)", alias_of);
-        }
     }
     if (!desc && cc->model && cc->model->note) {
         desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
@@ -6109,13 +6106,8 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     } else {
         info->deprecated = false;
     }
-    /*
-     * Old machine types won't report aliases, so that alias translation
-     * doesn't break compatibility with previous QEMU versions.
-     */
-    if (default_cpu_version != CPU_VERSION_LEGACY) {
-        info->alias_of = x86_cpu_class_get_alias_of(cc);
-    }
+
+    info->alias_of = x86_cpu_class_get_alias_of(cc);
 
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
@@ -6287,7 +6279,12 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
 
-    if (version == CPU_VERSION_LEGACY) {
+    /*
+     * if the machine uses legacy cpus, use legacy cpus with no versions
+     * when no explict CPU versions are specified in the CPU definition
+     * passed from the command line.
+     */
+    if (version == DEFAULT_CPU_VERSION && use_legacy_cpu) {
         return;
     }
 
@@ -6317,7 +6314,11 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
     const CPUCaches *cache_info = model->cpudef->cache_info;
 
-    if (version == CPU_VERSION_LEGACY) {
+    /*
+     * If machine supports legacy cpus and no explicit cpu versions are
+     * specified, use the cache from the unversioned cpu definition.
+     */
+    if (version == DEFAULT_CPU_VERSION && use_legacy_cpu) {
         return cache_info;
     }
 
@@ -6452,7 +6453,7 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
     /* Unversioned model: */
     m = g_new0(X86CPUModel, 1);
     m->cpudef = def;
-    m->version = CPU_VERSION_AUTO;
+    m->version = DEFAULT_CPU_VERSION;
     m->is_alias = true;
     x86_register_cpu_model_type(def->name, m);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b26e25ba15..9c0ce2adaf 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2679,28 +2679,17 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
 void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
-/* Special values for X86CPUVersion: */
-
-/* Resolve to latest CPU version */
-#define CPU_VERSION_LATEST -1
-
-/*
- * Resolve to version defined by current machine type.
- * See x86_cpu_set_default_version()
- */
-#define CPU_VERSION_AUTO   -2
-
-/* Don't resolve to any versioned CPU models, like old QEMU versions */
-#define CPU_VERSION_LEGACY  0
-
 typedef int X86CPUVersion;
 
 /*
- * Set default CPU model version for CPU models having
- * version == CPU_VERSION_AUTO.
+ * Set CPU model version to the lastest version.
+ * Currently, this is only used by microvm.
  */
-void x86_cpu_set_default_version(X86CPUVersion version);
+void x86_cpu_uses_lastest_version(void);
 
+#ifndef HW_I386_X86_H
+void x86_cpu_set_legacy_version(void);
+#endif
 #ifndef CONFIG_USER_ONLY
 
 void do_cpu_sipi(X86CPU *cpu);
-- 
2.45.2


