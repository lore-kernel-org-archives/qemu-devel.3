Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871C3C28B26
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqUsC-0002LS-5a; Fri, 07 Mar 2025 05:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tqUs2-0002Kj-CE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:23:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tqUrz-0003Ox-MT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741343030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fc6EJBBurBrC/uc2XLy5kiienQ0yIYcwnjSmGlku4UM=;
 b=PwCWka9KJ2uIZRtHUZmClQLKqtE6YOtbMlazOZt3YzleYzbMBgsRd5BFWjdrlokmZRjo2x
 aNWKLmxlUNb+rUaR9HBe5/zjxIq4f94W7nl/K+WottHk4hniDpZOpUg0nwKpCwT6tto4nF
 TXs8pVy8JWY+EEqbxKraBRqBLU35zNs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-UAzw5D6CNaepNpuRqTPKCg-1; Fri, 07 Mar 2025 05:23:46 -0500
X-MC-Unique: UAzw5D6CNaepNpuRqTPKCg-1
X-Mimecast-MFC-AGG-ID: UAzw5D6CNaepNpuRqTPKCg_1741343025
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff78dd28ecso2797575a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 02:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741343025; x=1741947825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fc6EJBBurBrC/uc2XLy5kiienQ0yIYcwnjSmGlku4UM=;
 b=PAkFicdv1uZkDt5eGfBctOjaIAUTLJmBnBmrW5JUDXFRg0Ir2ypx7Hie2Coy86Pxhd
 +6tOPLmfrihmxiCII5YnkG2wltJ+7EceQa3pzDSx5HpjRRotiWC0dxbIZKf/w/V/lrBk
 Ak9LxLohHOz3+JElh+T/b3FI4gYQ0ynt5jJ5kV6PsNArKIA5935S4FGYX6HK7sC5RRUx
 blRTdHLw5skoTqHUHMzmY3Z4sVzahYq54bQBWnvnmAHRRYpKoTskkO82RBciDWRRlB8h
 Zb/sprv6zgk2pc4zBx2/Z+ooWJZwjzl0azeRgItuZxEq8v72wBg1F4jZsIsByou8f/i0
 siAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU2QgdyTXde1i2rYvz+blkeW3ZyKIGySU5i7jrjQLCC1ewV2+40Abgs+SpnF/ninuYdZ6AkFMqKJeZ@nongnu.org
X-Gm-Message-State: AOJu0YymTEus68CjfZsp558SQBKPf3CNHsLGYCkhbk0O1vhnIgStDvSz
 +iEJaZFMAO66LQUy6jPk4Bmg1NsqHAUAdazDgpaCdG5RdebynxfFPCpAjFiE1MtOxuCGMbIkN/v
 up6CUYxSF+FLXr/uXe4POPV/98cBxzmTaUumnZtwO3ND9LNkdnSS+
X-Gm-Gg: ASbGncv97YPVxkodIqLfwtmDQNw7/02m3plE8VmMhF7f7FLKje1W+IAW00/rybSU3DH
 v6YlBWSQZHFrMANAzPFBlwaN0YcnTv/Xdps4YfXRDEdxCPB7CwfFLjIaE3aPGgrBG/pOb2k6bmC
 0qUy8nsZgOxSVyA+gClYuHLVceIo8IxBY/KLMH7qkBWKOWxri4lxAJ1dC9C57Ra8XWRLzJneLRM
 DkWyujTw/+tE64cBZPAHSan77Tnm3PGNG9GXK8stJT6MsBGPXZ3F5i1hofP5PnDdveBXQxOAaXL
 QbF4j/iX/hKarwj/fZNYINbOuk169czzoEEaGfo=
X-Received: by 2002:a05:6a21:4d81:b0:1f3:421b:d51f with SMTP id
 adf61e73a8af0-1f544aee902mr5297055637.15.1741343024884; 
 Fri, 07 Mar 2025 02:23:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXsCqB43uI49FVxco0QC7Hx0dERYKoBEXbMnjj+fK3Hqyo/+EIw7bsPBJLwJncJH2fZqPzqA==
X-Received: by 2002:a05:6a21:4d81:b0:1f3:421b:d51f with SMTP id
 adf61e73a8af0-1f544aee902mr5297010637.15.1741343024402; 
 Fri, 07 Mar 2025 02:23:44 -0800 (PST)
Received: from localhost.localdomain ([116.72.130.116])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-736a0e659afsm2245883b3a.169.2025.03.07.02.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 02:23:43 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7] hw/i386/cpu: remove default_cpu_version and simplify
Date: Fri,  7 Mar 2025 15:53:28 +0530
Message-ID: <20250307102329.556260-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
unversioned cpu models. Use of CPU_VERSION_LATEST was removed in [2].

This change cleans up the complicated logic around default_cpu_version
including getting rid of default_cpu_version property itself. One new
flag is introduced for the legacy model for machines 4.0.1 and older.
For older machines, a new pc machine property is
introduced that separates pc machine versions 4.0.1 and older from the newer
machines. 4.0.1 and older machines are scheduled to be deleted towards
end of 2025 since they would be 6 years old by then. At that time, we can
remove all logic around legacy cpus.
This change also removes all complications around CPU_VERSION_AUTO
including removal of the value itself.

1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
2) See commit XXX ("microvm: do not use the lastest cpu version")

CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/microvm.c     |  2 +-
 hw/i386/pc.c          |  1 +
 hw/i386/pc_piix.c     | 10 +++++---
 hw/i386/pc_q35.c      | 10 +++++---
 hw/i386/x86-common.c  |  4 +---
 include/hw/i386/pc.h  |  6 ++---
 include/hw/i386/x86.h |  2 +-
 target/i386/cpu.c     | 56 ++++++++++++-------------------------------
 target/i386/cpu.h     | 16 +------------
 9 files changed, 37 insertions(+), 70 deletions(-)

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
v5: adjustment of pc_init_cpus() declaration as per Zhao's suggestion. This
simplifies things and also passes compilation.
CI still passes https://gitlab.com/anisinha/qemu/-/pipelines/1637657451
v6: cosmetic commit log correction as suggested by Igor. rebase, added tags.
v7: This patch is based off the top of
https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg00934.html.
Igor's inputs taken into consideration.
CI passed.
Note: The above patch has not merged to QEMU upstream yet. Hence, its
commit hash is marked as XXX in the commit log for this patch.

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a340a5fd39..0eca629958 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -491,7 +491,7 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, 1);
+    x86_cpus_init(x86ms);
 
     microvm_devices_init(mms);
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 63a96cd23f..6a2ccfd42a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -30,6 +30,7 @@
 #include "hw/hyperv/hv-balloon.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/vmport.h"
+#include "target/i386/cpu.h"
 #include "system/cpus.h"
 #include "hw/ide/ide-bus.h"
 #include "hw/timer/hpet.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04d2957adc..b793a4c765 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -181,7 +181,12 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 
     pc_machine_init_sgx_epc(pcms);
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (pcmc->no_versioned_cpu_model) {
+        /* use legacy cpu as it does not support versions */
+        x86_cpu_set_legacy_version();
+    }
+    x86_cpus_init(x86ms);
 
     if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
@@ -457,7 +462,6 @@ static void pc_i440fx_machine_options(MachineClass *m)
     ObjectClass *oc = OBJECT_CLASS(m);
     pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
     pcmc->pci_root_uid = 0;
-    pcmc->default_cpu_version = 1;
 
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
@@ -669,7 +673,7 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
+    pcmc->no_versioned_cpu_model = true;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 77536dd697..be7775e9de 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -187,7 +187,12 @@ static void pc_q35_init(MachineState *machine)
     }
 
     pc_machine_init_sgx_epc(pcms);
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (pcmc->no_versioned_cpu_model) {
+        /* use legacy cpu as it does not support versions */
+        x86_cpu_set_legacy_version();
+    }
+    x86_cpus_init(x86ms);
 
     if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
@@ -339,7 +344,6 @@ static void pc_q35_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pcmc->pci_root_uid = 0;
-    pcmc->default_cpu_version = 1;
 
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
@@ -547,7 +551,7 @@ static void pc_q35_machine_4_0_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_4_1_options(m);
-    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
+    pcmc->no_versioned_cpu_model = true;
     /*
      * This is the default machine for the 4.0-stable branch. It is basically
      * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 1b0671c523..e8c827c1da 100644
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
index 103b54301f..477960275e 100644
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
@@ -125,6 +122,9 @@ struct PCMachineClass {
      * check for memory.
      */
     bool broken_32bit_mem_addr_check;
+
+    /* whether the machine supports versioned cpu models */
+    bool no_versioned_cpu_model;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..2d2b987fa1 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -114,7 +114,7 @@ void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index);
 
-void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
+void x86_cpus_init(X86MachineState *pcms);
 void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
 void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                       DeviceState *dev, Error **errp);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2da2cf36fd..e5c8dd98d0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5624,30 +5624,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
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
-
-void x86_cpu_set_default_version(X86CPUVersion version)
+static bool no_cpu_alias;
+void x86_cpu_set_legacy_version(void)
 {
-    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
-    assert(version != CPU_VERSION_AUTO);
-    default_cpu_version = version;
+    no_cpu_alias = true;
 }
 
 /* Return the actual version being used for a specific CPU model */
 static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
 {
-    X86CPUVersion v = model->version;
-    if (v == CPU_VERSION_AUTO) {
-        v = default_cpu_version;
-    }
-    return v;
+    return model->version;
 }
 
 static const Property max_x86_cpu_properties[] = {
@@ -6251,10 +6237,15 @@ static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
     if (!cc->model || !cc->model->is_alias) {
         return NULL;
     }
-    version = x86_cpu_model_resolve_version(cc->model);
-    if (version <= 0) {
+
+    if (no_cpu_alias) {
+        /* legacy cpu models do not support cpu aliases */
         return NULL;
     }
+
+    version = x86_cpu_model_resolve_version(cc->model);
+    assert(version);
+
     return x86_cpu_versioned_model_name(cc->model->cpudef, version);
 }
 
@@ -6268,11 +6259,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     g_autofree char *model_id = x86_cpu_class_get_model_id(cc);
 
     if (!desc && alias_of) {
-        if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
-            desc = g_strdup("(alias configured by machine type)");
-        } else {
-            desc = g_strdup_printf("(alias of %s)", alias_of);
-        }
+        desc = g_strdup_printf("(alias of %s)", alias_of);
     }
     if (!desc && cc->model && cc->model->note) {
         desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
@@ -6375,13 +6362,8 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
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
@@ -6553,10 +6535,6 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
 
-    if (version == CPU_VERSION_LEGACY) {
-        return;
-    }
-
     for (vdef = x86_cpu_def_get_versions(model->cpudef); vdef->version; vdef++) {
         PropValue *p;
 
@@ -6583,10 +6561,6 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
     const CPUCaches *cache_info = model->cpudef->cache_info;
 
-    if (version == CPU_VERSION_LEGACY) {
-        return cache_info;
-    }
-
     for (vdef = x86_cpu_def_get_versions(model->cpudef); vdef->version; vdef++) {
         if (vdef->cache_info) {
             cache_info = vdef->cache_info;
@@ -6718,7 +6692,7 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
     /* Unversioned model: */
     m = g_new0(X86CPUModel, 1);
     m->cpudef = def;
-    m->version = CPU_VERSION_AUTO;
+    m->version = 1;
     m->is_alias = true;
     x86_register_cpu_model_type(def->name, m);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 113cf10aea..ee1edaa987 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2739,23 +2739,9 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
 void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
-/* Special values for X86CPUVersion: */
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
 
-/*
- * Set default CPU model version for CPU models having
- * version == CPU_VERSION_AUTO.
- */
-void x86_cpu_set_default_version(X86CPUVersion version);
+void x86_cpu_set_legacy_version(void);
 
 #ifndef CONFIG_USER_ONLY
 
-- 
2.45.2


