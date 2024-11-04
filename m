Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71D4D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kq8-0001IM-UQ; Sun, 03 Nov 2024 19:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kq6-0001Bs-KH; Sun, 03 Nov 2024 19:21:02 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kq4-0002eX-JQ; Sun, 03 Nov 2024 19:21:02 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-720aa3dbda5so2637145b3a.1; 
 Sun, 03 Nov 2024 16:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679659; x=1731284459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84ZD8pabKLp119VbZhFi0fdSlQOMQdaojXG08AGaLh4=;
 b=dBdeUTP2VpZvu1Dn+BHme58Y95jI1PbPeUwFRTvKbYm3KQBAAyADYgJoGo83ModuHi
 Y1mOmmfq3mJhgCGqXrSwV3bRX5EhT1gKIBvnUaEPH99IXSFpCNI+NrD/Xkp4FtotzQTz
 0dlwG59bJ8J0Auci8w1qTKlzuzTLUhOHFnVQ6okA4z0F/PbIPxkmSXu+QMf7rMZvvSyW
 U7KkfWd/BJsQ/2M6cSB9mrQ8b4iP3MAy9LGm+apQr4RtSd3ifpSd691HGU9mrBDtZd1Z
 JAgDBrRzhXXRVtdaHOfhdl1KtGyqKbzTJ/k/i1VNlhu0cXKu2wVIVPkMAJOC/Tq0IvM2
 auUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679659; x=1731284459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84ZD8pabKLp119VbZhFi0fdSlQOMQdaojXG08AGaLh4=;
 b=B9YHK/GFP7zrQAJnEX9etvHFniVoOUMJB0DXAgXr9LWqnjsaVgbdporm2STKC1RE48
 z72jrkm8L5Fgz8HK07WktmPU0CX+yr58EB31tZT6N8OQ2Up/Gaa71S8WMCEqIXzpJuJi
 8Fq5PeR8S0BDp3LUWo0rVtiuzbFk79v14GfwYifoa639kVh2cGfqIEQmhV+0gUVzlX4j
 0SJywUgTt/UxlvXXG+Os3UjLWw3Gi3oHQhVmBTfx/JcYVgprmQGqUYP1Z8bZmZ02j6mh
 iUaEB6leEBSAb5J3PVkaWthVC6SDoot6nLORC0IFKC9gbTVuo9ARuC8X9S9G4i3aDg+3
 NcKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+LtkUTZ3aFBKFVjRMfInUnnQJV+gvOrUbEitdaC7Gfo/DabWdb2aJIyXOHkTmZH2mp6chkX145A==@nongnu.org
X-Gm-Message-State: AOJu0YwX8TBf6WQVb4aNVr8AKNp67US7CVQWnt14L0QbWVZaT3FCslaY
 k4fZ7B/hECShSFhCFtGevSVxKoiSDuFQOXvidlULaG/J4LMLWVe3s+pnoQ==
X-Google-Smtp-Source: AGHT+IGsOAam8Rg+VizetZPqaWov8/aZr41M4blUUYlAv487W+x9S01PQLJ0B5ujRvf55UUCkltouQ==
X-Received: by 2002:a05:6a20:6a21:b0:1db:db2f:f3a5 with SMTP id
 adf61e73a8af0-1dbdb3025c0mr2588895637.21.1730679658591; 
 Sun, 03 Nov 2024 16:20:58 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/67] ppc/spapr: remove deprecated machine pseries-2.12
Date: Mon,  4 Nov 2024 10:18:18 +1000
Message-ID: <20241104001900.682660-30-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 0cac0f1b964 marked pseries-2.12 machines as deprecated
with reasons mentioned in its commit log.
Removing pseries-2.12 specific code with this patch.

While at it, also remove pre-3.0-migration hacks introduced for backward
compatibility which are now turned useless.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/about/deprecated.rst       |  8 --------
 hw/ppc/spapr.c                  | 25 -------------------------
 hw/ppc/spapr_cpu_core.c         | 12 +++---------
 include/hw/ppc/spapr_cpu_core.h |  1 -
 target/ppc/cpu.h                |  4 ----
 target/ppc/cpu_init.c           |  3 +--
 target/ppc/machine.c            | 18 +-----------------
 7 files changed, 5 insertions(+), 66 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1e1e9f5f18..756186f4f0 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -243,14 +243,6 @@ These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
 instead.
 
-``pseries-2.1`` up to ``pseries-2.12`` (since 9.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Older pseries machines before version 3.0 have undergone many changes
-to correct issues, mostly regarding migration compatibility. These are
-no longer maintained and removing them will make the code easier to
-read and maintain. Use versions 3.0 and above as a replacement.
-
 PPC 405 ``ref405ep`` machine (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index aba0ad26f1..5c02037c56 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5015,31 +5015,6 @@ static void spapr_machine_3_0_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(3, 0);
 
-/*
- * pseries-2.12
- */
-static void spapr_machine_2_12_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { TYPE_POWERPC_CPU, "pre-3.0-migration", "on" },
-        { TYPE_SPAPR_CPU_CORE, "pre-3.0-migration", "on" },
-    };
-
-    spapr_machine_3_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-
-    /* We depend on kvm_enabled() to choose a default value for the
-     * hpt-max-page-size capability. Of course we can't do it here
-     * because this is too early and the HW accelerator isn't initialized
-     * yet. Postpone this to machine init (see default_caps_with_cpu()).
-     */
-    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 0;
-}
-
-DEFINE_SPAPR_MACHINE(2, 12);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 4642245168..1a84345f36 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -197,9 +197,7 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
 {
     CPUPPCState *env = &cpu->env;
 
-    if (!sc->pre_3_0_migration) {
-        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_data);
-    }
+    vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_data);
     spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
     cpu_ppc_tb_free(env);
     qdev_unrealize(DEVICE(cpu));
@@ -285,10 +283,8 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
         return false;
     }
 
-    if (!sc->pre_3_0_migration) {
-        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
-                         cpu->machine_data);
-    }
+    vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
+                     cpu->machine_data);
     return true;
 }
 
@@ -366,8 +362,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
 static Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_INT32("node-id", SpaprCpuCore, node_id, CPU_UNSET_NUMA_NODE_ID),
-    DEFINE_PROP_BOOL("pre-3.0-migration", SpaprCpuCore, pre_3_0_migration,
-                     false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 69a52e39b8..68f7083483 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -28,7 +28,6 @@ struct SpaprCpuCore {
     /*< public >*/
     PowerPCCPU **threads;
     int node_id;
-    bool pre_3_0_migration; /* older machine don't know about SpaprCpuState */
 };
 
 struct SpaprCpuCoreClass {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index faa610197d..b838bc2ab9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1455,10 +1455,6 @@ struct ArchCPU {
     /* Those resources are used only during code translation */
     /* opcode handlers */
     opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
-
-    /* Fields related to migration compatibility hacks */
-    bool pre_3_0_migration;
-    int32_t mig_slb_nr;
 };
 
 /**
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 39c19e6674..011e53d961 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7452,8 +7452,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 }
 
 static Property ppc_cpu_properties[] = {
-    DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
-                     false),
+    /* add default property here */
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 47495b68b1..717bf93e88 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -118,15 +118,6 @@ static const VMStateInfo vmstate_info_vsr = {
 #define VMSTATE_VSR_ARRAY(_f, _s, _n)                             \
     VMSTATE_VSR_ARRAY_V(_f, _s, _n, 0)
 
-#if defined(TARGET_PPC64)
-static bool cpu_pre_3_0_migration(void *opaque, int version_id)
-{
-    PowerPCCPU *cpu = opaque;
-
-    return cpu->pre_3_0_migration;
-}
-#endif
-
 static int cpu_pre_save(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -154,12 +145,6 @@ static int cpu_pre_save(void *opaque)
         env->spr[SPR_IBAT4U + 2 * i + 1] = env->IBAT[1][i + 4];
     }
 
-    if (cpu->pre_3_0_migration) {
-        if (cpu->hash64_opts) {
-            cpu->mig_slb_nr = cpu->hash64_opts->slb_size;
-        }
-    }
-
     /* Used to retain migration compatibility for pre 6.0 for 601 machines. */
     env->hflags_compat_nmsr = 0;
 
@@ -503,12 +488,11 @@ static int slb_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_slb = {
     .name = "cpu/slb",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .needed = slb_needed,
     .post_load = slb_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32_TEST(mig_slb_nr, PowerPCCPU, cpu_pre_3_0_migration),
         VMSTATE_SLB_ARRAY(env.slb, PowerPCCPU, MAX_SLB_ENTRIES),
         VMSTATE_END_OF_LIST()
     }
-- 
2.45.2


