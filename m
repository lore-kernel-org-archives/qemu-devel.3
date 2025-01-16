Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685D5E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 03:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYGeo-000193-NU; Wed, 15 Jan 2025 22:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYGem-00018f-8V
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 22:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYGeh-0001i7-33
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 22:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736998488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NOVdDCtpjU2V27KHo74Yx1jv8Twt2Ka2nr4XVoB1bMw=;
 b=dJNaJOAI3LyynXOAkDfbPQb8ES26NnSz/o/suPpOmbR8k5AOQCHGCBOmHJzTf38iaoYalb
 twErCpJONwT0rlnScpOFQgjZMEQ16o5LwPQNXCm8HEHQXRIdgUVVVdN8oHVbmiE8RLW2wO
 8eKoR/TAWz1aZkuIDUMLB6ey6PaKWHg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-14VkgsWOM6GV9lCb7ZW0dQ-1; Wed, 15 Jan 2025 22:34:45 -0500
X-MC-Unique: 14VkgsWOM6GV9lCb7ZW0dQ-1
X-Mimecast-MFC-AGG-ID: 14VkgsWOM6GV9lCb7ZW0dQ
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-21655569152so8967015ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 19:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736998484; x=1737603284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NOVdDCtpjU2V27KHo74Yx1jv8Twt2Ka2nr4XVoB1bMw=;
 b=jernFfPzVgPKAwGRnD7KGPeeoFsxCvCO+qtf80Ubu9GV6jLr8G4doC7PVL4IqUOmsg
 nV+vdlfrTpdo0+bWJOsNCbq9Hbj1KbWzudxM1Bv4qzVDxx1VvAe121O3wUBS9jQWg1AY
 LJUWtSJsLhkLS3QNeIiF6LP3qkDA5tMhSzZcY0guklijiVguVe1lNnazzy5+NrR64gpK
 EcQVxlmaGmlcthhVM9xQXrATTP1fkQ73aqsGe4dRsLPyXjRmFpqXI7Ug+LovLwNBhp1G
 zhSYo5sUontDHR3saVb/Uu2bCbuxBXJMWrRJGp3K0qy74eyXblhE+fMvRCiQr9c41PdK
 ARSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf09I9hyjfZUY9pYBokbXo2IC49RwqthLic9I2Ha3jGwIdVGpRbSG+1ji/T6gEf9ZJhnP8FSKoBDF8@nongnu.org
X-Gm-Message-State: AOJu0Yxn8JN24vSj+aGsA3IKaX6utqg9h5NnfcvbfDzpNOu1eNue3F/5
 rIuts+oay5QIfoBBzjnSQQCXmJcvg1QjOpGMjTfiefCCg7w8zO2RyF3vzh8IbNr6f8aQHNITvPd
 WV8NaGhl0Mjzj5zJ362D/B+8HtoO55S64d7H8RAY3ynuHQyij+JHl
X-Gm-Gg: ASbGncsf/UCmlq3Mw9uyf3g/nhzf62npsnYKXnTNQv6UzWfbBYIj3ZZs2Hz0CrutnDa
 hTmkcIu+yZPsncohCONfFb66LJFyuR5Bp33YkRBgED6Cg7MDhPmJz7LL7RMpfaaF1D4666K4evw
 GxcJwaZ5gEW09L4YVs2zAceV4fOiIRwnCIzXauKwoBq5EHS9GLB95RZO/xOkWAGWzIiwnwcjxPm
 njfgO0NMt8Xm4X5ph8RU6kgRKJugSdg+PBKRYjgsaZ1K+YKG/bvx8jHbN+pR4+3iZkwQqLmpz/4
 bHND
X-Received: by 2002:a17:902:d511:b0:206:9a3f:15e5 with SMTP id
 d9443c01a7336-21a83f69cd4mr496309385ad.32.1736998483819; 
 Wed, 15 Jan 2025 19:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGDjq//dmp8S8yHMoI3E0e1ugsFTMKQHyqy3xUP/FjvjTTj39cdaJk9wvEzENMTL+Ii6WR6A==
X-Received: by 2002:a17:902:d511:b0:206:9a3f:15e5 with SMTP id
 d9443c01a7336-21a83f69cd4mr496308985ad.32.1736998483290; 
 Wed, 15 Jan 2025 19:34:43 -0800 (PST)
Received: from localhost.localdomain ([115.96.151.195])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21a9f219e44sm89241845ad.120.2025.01.15.19.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 19:34:42 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/i386/cpu: remove default_cpu_version and simplify
Date: Thu, 16 Jan 2025 09:04:18 +0530
Message-ID: <20250116033418.226051-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 hw/i386/pc_piix.c     |  6 ++---
 hw/i386/pc_q35.c      |  6 ++---
 hw/i386/x86-common.c  | 15 ++++++++---
 include/hw/i386/pc.h  | 21 ++++++++++++---
 include/hw/i386/x86.h |  5 +++-
 target/i386/cpu.c     | 59 ++++++++++++++++++++++++-------------------
 target/i386/cpu.h     | 21 +++------------
 8 files changed, 78 insertions(+), 57 deletions(-)

changelog:
v2: explain in commit log why use of CPU_VERSION_LATEST for machines
is problematic.
v3: fix a bug that broke the pipeline
https://gitlab.com/mstredhat/qemu/-/pipelines/1626171267
when cpu versions are explicitly specified in the command line,
respect that and do not enforce legacy (unversioned) cpu logic.
The pipeline is green now with the fix:
https://gitlab.com/anisinha/qemu/-/pipelines/1626783632

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe..44259d6bb1 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -458,7 +458,7 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    x86_cpus_init_with_latest_cpu_version(x86ms);
 
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
index 97b4f7d4a0..2e682d1dd8 100644
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
index a558705cb9..ad43a233d8 100644
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
index 0b639848cd..5f89542774 100644
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
@@ -5345,20 +5348,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
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
@@ -5376,14 +5375,11 @@ static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
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
 
 static const Property max_x86_cpu_properties[] = {
@@ -5987,6 +5983,12 @@ static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
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
@@ -6004,11 +6006,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
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
@@ -6115,7 +6113,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
      */
-    if (default_cpu_version != CPU_VERSION_LEGACY) {
+    if (!use_legacy_cpu) {
         info->alias_of = x86_cpu_class_get_alias_of(cc);
     }
 
@@ -6289,7 +6287,12 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
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
 
@@ -6319,7 +6322,11 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
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
 
@@ -6454,7 +6461,7 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
     /* Unversioned model: */
     m = g_new0(X86CPUModel, 1);
     m->cpudef = def;
-    m->version = CPU_VERSION_AUTO;
+    m->version = DEFAULT_CPU_VERSION;
     m->is_alias = true;
     x86_register_cpu_model_type(def->name, m);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dbd8f1ffc7..0529b4f8c2 100644
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


