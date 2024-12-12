Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E6BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkVn-0004CU-4t; Thu, 12 Dec 2024 09:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tLkVg-00049h-0b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tLkVX-0004m7-PT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734014976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WDKU6Q/9hksjRZijlxpLy0rH0yW2YxNzuP8/GRUjoM4=;
 b=br+aNe+7KBiSnISB01lV4zeLhZTYCic+8yRJMUhkaIPhpPALuct+26gPDmsrDmVP/7s5uV
 5/i9Yzyb01WqRjHBBqM2Lk/YAuSwFEb4W1FOLXKbqSJU6krMx2jxHkO+IX4iqrTEPOIm6P
 nYFHFFPvDcutPpBPBHMC6KGnhz9z0lE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-qEiZZEggOtmf5txQ1taxEA-1; Thu, 12 Dec 2024 09:49:34 -0500
X-MC-Unique: qEiZZEggOtmf5txQ1taxEA-1
X-Mimecast-MFC-AGG-ID: qEiZZEggOtmf5txQ1taxEA
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7fd48914d9bso529459a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014973; x=1734619773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WDKU6Q/9hksjRZijlxpLy0rH0yW2YxNzuP8/GRUjoM4=;
 b=K1xxG4+jRJk2uoauXox4zXcbK3Lw0anVrUI0SmzJvy55stZYdmor26RY0Hm5+2oC8e
 GGK10d9hfMm6MonSIynqtFHyd/I3PGpRQLazmrO2IjZiIdzauik+G8dv5j9cXMUdijxZ
 2NnfY7JrHijDNwfMTqVvflbmAKGPELa9S21N9JuAUM1jgwDuQRavZz1LbFFO+GyFk7lm
 eplsHQ3iionP3V6tD4hc08MRwlmiyF8BJkgextjfbz2eYvlfotcNY+SuuvjtRvMzAy9u
 JMZpmOjCacI5Qp2tOoStPE2lHjzfUwqibeO1rm09nIZ7eGaFZstS2w81ldNAnILua6N+
 AJsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1nz5hhXumZwr5zioDaPq9O9q0wsv7riNnXE26y1fN6Vgn7izE7mpos7K05rjgxTZbEd12BtE6FrGQ@nongnu.org
X-Gm-Message-State: AOJu0Yy9mqSgQgftDcITHrteyZrQbp7DwwJCnMX2Hr6tHe6EIwpWskBV
 7ImcgtHOQ6yUmo9yfwlJlnKxaZJ88fNLruTkCRh9nAPdVS81xq/RZ8lV69ICYHG4/2lwwvoP4yJ
 Yd+OnQL7ASKZSeLAQWpuEKGCe867EmBzX6W27MNFe0Ncac8AOqucO
X-Gm-Gg: ASbGncsojexcS0p7OCMlkuU6TaWLDrOVa3STkpPXKcNFOCVUDg9GzKbuoCYn6x5oPcm
 nRY4uF6TjbO2EVgMskkD2AANlkH6M2iGJAM5yMWP/ESZuVmkoJdaPvzPlEBD9gQK0YTZTCYE/ow
 /bCf1BRoLlxHY8fd/COYvOZ63DA6l621yfZUfCQ5oDPe8e/O6pOpdLKt03kZEe2f5ybRAQR3yMT
 PvXM/m1SDJDzEvZcIi9N+jDMD0SncYM8cWfQ8bemVaBLcGWIYUKqIKPdxzuFU6xpN+TDK2ncxep
 NaPn
X-Received: by 2002:a05:6a20:258e:b0:1db:a33e:2c6 with SMTP id
 adf61e73a8af0-1e1dab63872mr815740637.18.1734014973459; 
 Thu, 12 Dec 2024 06:49:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkzLcitTfYtU3MSiXpEVn60yrJcQPBV/y1lGKC9di7Qj0f2zsKWdKSFv0+c8XUJeduMzgr5Q==
X-Received: by 2002:a05:6a20:258e:b0:1db:a33e:2c6 with SMTP id
 adf61e73a8af0-1e1dab63872mr815697637.18.1734014972978; 
 Thu, 12 Dec 2024 06:49:32 -0800 (PST)
Received: from localhost.localdomain ([115.96.132.218])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-725a29c5af9sm12948507b3a.19.2024.12.12.06.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 06:49:32 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/i386/cpu: remove default_cpu_version and simplify
Date: Thu, 12 Dec 2024 20:19:18 +0530
Message-ID: <20241212144918.981542-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 hw/i386/microvm.c     |  2 +-
 hw/i386/pc_piix.c     |  6 +++---
 hw/i386/pc_q35.c      |  6 +++---
 hw/i386/x86-common.c  | 15 ++++++++++---
 include/hw/i386/pc.h  | 21 +++++++++++++++---
 include/hw/i386/x86.h |  5 ++++-
 target/i386/cpu.c     | 50 +++++++++++++++++++++----------------------
 target/i386/cpu.h     | 21 ++++--------------
 8 files changed, 69 insertions(+), 57 deletions(-)

changelog:
v2: explain in commit log why use of CPU_VERSION_LATEST for machines
is problematic.

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 86637afa0f..2cbe08caea 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -458,7 +458,7 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    x86_cpus_init_with_latest_cpu_version(x86ms);
 
     microvm_devices_init(mms);
 }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2bf6865d40..8e0ab0387f 100644
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
@@ -454,7 +455,6 @@ static void pc_i440fx_machine_options(MachineClass *m)
     ObjectClass *oc = OBJECT_CLASS(m);
     pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
     pcmc->pci_root_uid = 0;
-    pcmc->default_cpu_version = 1;
 
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
@@ -661,7 +661,7 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
+    pcmc->no_versioned_cpu_model = true;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8319b6d45e..9a4f14b336 100644
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
@@ -336,7 +337,6 @@ static void pc_q35_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pcmc->pci_root_uid = 0;
-    pcmc->default_cpu_version = 1;
 
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
@@ -537,7 +537,7 @@ static void pc_q35_machine_4_0_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
+    pcmc->no_versioned_cpu_model = true;
     /*
      * This is the default machine for the 4.0-stable branch. It is basically
      * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dc031af662..37dfdb7300 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -66,15 +66,24 @@ out:
     object_unref(cpu);
 }
 
-void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
+void x86_legacy_cpus_init(X86MachineState *x86ms)
+{
+    machine_uses_legacy_cpu();
+    x86_cpus_init(x86ms);
+}
+
+void x86_cpus_init_with_latest_cpu_version(X86MachineState *x86ms)
+{
+    x86_cpu_uses_lastest_version();
+    x86_cpus_init(x86ms);
+}
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
index 14ee06287d..b514b957d9 100644
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
@@ -125,11 +122,29 @@ struct PCMachineClass {
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
+        x86_legacy_cpus_init(x86ms);
+    } else {
+        /* use non-legacy cpus */
+        x86_cpus_init(x86ms);
+    }
+}
+
 /* ioapic.c */
 
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..a90464f74b 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -114,7 +114,10 @@ void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index);
 
-void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
+void x86_cpus_init(X86MachineState *pcms);
+void x86_legacy_cpus_init(X86MachineState *x86ms);
+void x86_cpus_init_with_latest_cpu_version(X86MachineState *x86ms);
+
 void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
 void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                       DeviceState *dev, Error **errp);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3725dbbc4b..14f5aa359b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -191,6 +191,9 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
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
+void machine_uses_legacy_cpu(void)
+{
+    use_legacy_cpu = true;
+}
 
-void x86_cpu_set_default_version(X86CPUVersion version)
+static bool use_last_cpu_version;
+void x86_cpu_uses_lastest_version(void)
 {
-    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
-    assert(version != CPU_VERSION_AUTO);
-    default_cpu_version = version;
+    use_last_cpu_version = true;
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
+    if (use_last_cpu_version) {
         return x86_cpu_model_last_version(model);
     }
-    return v;
+
+    return model->version;
 }
 
 static Property max_x86_cpu_properties[] = {
@@ -5986,6 +5982,12 @@ static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
     if (!cc->model || !cc->model->is_alias) {
         return NULL;
     }
+
+    if (use_legacy_cpu) {
+        /* legacy cpu models do not support cpu aliases */
+        return NULL;
+    }
+
     version = x86_cpu_model_resolve_version(cc->model);
     if (version <= 0) {
         return NULL;
@@ -6003,11 +6005,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
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
@@ -6114,7 +6112,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
      */
-    if (default_cpu_version != CPU_VERSION_LEGACY) {
+    if (!use_legacy_cpu) {
         info->alias_of = x86_cpu_class_get_alias_of(cc);
     }
 
@@ -6288,7 +6286,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
 
-    if (version == CPU_VERSION_LEGACY) {
+    if (use_legacy_cpu) {
         return;
     }
 
@@ -6318,7 +6316,7 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
     const CPUCaches *cache_info = model->cpudef->cache_info;
 
-    if (version == CPU_VERSION_LEGACY) {
+    if (use_legacy_cpu) {
         return cache_info;
     }
 
@@ -6453,7 +6451,7 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
     /* Unversioned model: */
     m = g_new0(X86CPUModel, 1);
     m->cpudef = def;
-    m->version = CPU_VERSION_AUTO;
+    m->version = DEFAULT_CPU_VERSION;
     m->is_alias = true;
     x86_register_cpu_model_type(def->name, m);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c239a6970..5ad80c8a97 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2658,28 +2658,15 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
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
 
+void machine_uses_legacy_cpu(void);
 #ifndef CONFIG_USER_ONLY
 
 void do_cpu_sipi(X86CPU *cpu);
-- 
2.45.2


