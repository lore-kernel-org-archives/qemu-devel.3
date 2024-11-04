Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023F4D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpu-0000Ly-Ef; Sun, 03 Nov 2024 19:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kps-00007t-4R; Sun, 03 Nov 2024 19:20:48 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpq-0002dO-3f; Sun, 03 Nov 2024 19:20:47 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso2804492b3a.3; 
 Sun, 03 Nov 2024 16:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679644; x=1731284444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YC4UNbx99FP/Gn+VAW1VGpffG3LnH4XLkP7F/WOJjQ=;
 b=Q5Dk40Ot4JSzRzjurV0MLop63X5mG7/3MEy1428izX665B3QURO0ypAtQYPomzLQ93
 BCjJmq1HgocNOO92EQakXgjCUy2CpRqTIUAWjGoPA0kfhPu9kfkf+4uq3EO5fisO3xxw
 s1Eys2oMs3KJ3mJ25J33klmqalJtFXMhoAScpF1ZHTscodkSWrntGoVOrd37mew5pGPP
 ChW+e2+EJ5yexHd0YuWlWF8kH9lT2XdAOaLJSSC2zzUzWZo9P7k8EIhpMHyOxIGKCH1i
 g2rfn8hH1c1ElvaNDBiod54vBB7PxMVhMW8twNdyQOXLROX8yGega546JB3GRnzaQFE6
 U1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679644; x=1731284444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YC4UNbx99FP/Gn+VAW1VGpffG3LnH4XLkP7F/WOJjQ=;
 b=IZDfapJrtiUs0VKyJUMuLHjt+Zc0coqX09O3adywBN1L7F7WHGBiKHKNd+Dn7Ev0Lm
 ByrZALBxdnFahUItjlQI/TAKCAVAmsu0jw9EXXMfXa5bEl2Bh++ZbqkKArv+VbLkoqgA
 MOFJK2o/ze2O6OYUzwK9p6kM3RG54C+Im8c5aMxx79IARFXktulDtJmZh7j2RF+SDHK3
 6ATsr8r3VWWA88MDqgOlV2HEn5M466Om/q8saaVjTOhD0NNQq4GBzYn5zcA/fGYBHQQd
 2zHX5e1jti78UioTdCniIzHB27KfPHFd8wDXyTuY1qEXyF5Op1F1fAuJefjGr4zSIobY
 wYUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/qVIKVauD+oA3FEZWwhs+2Ndn8qYgSIzrvpU8i4MFz6ezdmsZ8Z9EGImlMnPyjFQQJQoGnw7TzA==@nongnu.org
X-Gm-Message-State: AOJu0Yxi68uLbF6YauIwTgdE2FK5yC0cP4nlMKrAQSkSN8EvCitcknB7
 z/ZNc978WtL6YyieO5Hr5WMz3MZtIsCDCHTpuA6OjAewgNniJPEa5Dw5jA==
X-Google-Smtp-Source: AGHT+IHEJTNlk853wrnDd7ttSJ2qU7NwMFktQ1slRU4+hm8Z5nGcDAz4c1wfObMRZl46pSZXUGYNmA==
X-Received: by 2002:a05:6a21:e92:b0:1d8:fdf8:973c with SMTP id
 adf61e73a8af0-1dba539790fmr14012577637.29.1730679643720; 
 Sun, 03 Nov 2024 16:20:43 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/67] ppc/spapr: remove deprecated machine pseries-2.9
Date: Mon,  4 Nov 2024 10:18:14 +1000
Message-ID: <20241104001900.682660-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.9 specific code with this patch for now.

While at it, also remove the pre-2.10 migration hacks which now become
obsolete.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xics.c         |  16 -------
 hw/ppc/spapr.c         | 104 -----------------------------------------
 include/hw/ppc/spapr.h |   1 -
 migration/savevm.c     |  19 --------
 target/ppc/cpu.h       |   1 -
 target/ppc/cpu_init.c  |   2 -
 target/ppc/machine.c   |   2 +-
 7 files changed, 1 insertion(+), 144 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 6f4d5271ea..e893363dc9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -335,22 +335,6 @@ static void icp_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-    /*
-     * The way that pre_2_10_icp is handling is really, really hacky.
-     * We used to have here this call:
-     *
-     * vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
-     *
-     * But we were doing:
-     *     pre_2_10_vmstate_register_dummy_icp()
-     *     this vmstate_register()
-     *     pre_2_10_vmstate_unregister_dummy_icp()
-     *
-     * So for a short amount of time we had to vmstate entries with
-     * the same name.  This fixes it.
-     */
-    vmstate_replace_hack_for_ppc(NULL, icp->cs->cpu_index,
-                                 &vmstate_icp_server, icp);
 }
 
 static void icp_unrealize(DeviceState *dev)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 93decfcbeb..14a1314af6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -132,61 +132,6 @@ static bool spapr_is_thread0_in_vcore(SpaprMachineState *spapr,
     return spapr_get_vcpu_id(cpu) % spapr->vsmt == 0;
 }
 
-static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
-{
-    /* Dummy entries correspond to unused ICPState objects in older QEMUs,
-     * and newer QEMUs don't even have them. In both cases, we don't want
-     * to send anything on the wire.
-     */
-    return false;
-}
-
-static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
-    /*
-     * Hack ahead.  We can't have two devices with the same name and
-     * instance id.  So I rename this to pass make check.
-     * Real help from people who knows the hardware is needed.
-     */
-    .name = "icp/server",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = pre_2_10_vmstate_dummy_icp_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UNUSED(4), /* uint32_t xirr */
-        VMSTATE_UNUSED(1), /* uint8_t pending_priority */
-        VMSTATE_UNUSED(1), /* uint8_t mfrr */
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-/*
- * See comment in hw/intc/xics.c:icp_realize()
- *
- * You have to remove vmstate_replace_hack_for_ppc() when you remove
- * the machine types that need the following function.
- */
-static void pre_2_10_vmstate_register_dummy_icp(int i)
-{
-    vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp,
-                     (void *)(uintptr_t) i);
-}
-
-/*
- * See comment in hw/intc/xics.c:icp_realize()
- *
- * You have to remove vmstate_replace_hack_for_ppc() when you remove
- * the machine types that need the following function.
- */
-static void pre_2_10_vmstate_unregister_dummy_icp(int i)
-{
-    /*
-     * This used to be:
-     *
-     *    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
-     *                      (void *)(uintptr_t) i);
-     */
-}
-
 int spapr_max_server_number(SpaprMachineState *spapr)
 {
     MachineState *ms = MACHINE(spapr);
@@ -2711,7 +2656,6 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     const char *type = spapr_get_cpu_core_type(machine->cpu_type);
     const CPUArchIdList *possible_cpus;
     unsigned int smp_cpus = machine->smp.cpus;
@@ -2740,15 +2684,6 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
         boot_cores_nr = possible_cpus->len;
     }
 
-    if (smc->pre_2_10_has_unused_icps) {
-        for (i = 0; i < spapr_max_server_number(spapr); i++) {
-            /* Dummy entries get deregistered when real ICPState objects
-             * are registered during CPU core hotplug.
-             */
-            pre_2_10_vmstate_register_dummy_icp(i);
-        }
-    }
-
     for (i = 0; i < possible_cpus->len; i++) {
         int core_id = i * smp_threads;
 
@@ -3914,21 +3849,9 @@ void spapr_core_release(DeviceState *dev)
 static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     MachineState *ms = MACHINE(hotplug_dev);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
 
-    if (smc->pre_2_10_has_unused_icps) {
-        SpaprCpuCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-        int i;
-
-        for (i = 0; i < cc->nr_threads; i++) {
-            CPUState *cs = CPU(sc->threads[i]);
-
-            pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
-        }
-    }
-
     assert(core_slot);
     core_slot->cpu = NULL;
     qdev_unrealize(dev);
@@ -4009,7 +3932,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     SpaprCpuCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
     SpaprDrc *drc;
@@ -4059,12 +3981,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
         }
     }
 
-    if (smc->pre_2_10_has_unused_icps) {
-        for (i = 0; i < cc->nr_threads; i++) {
-            CPUState *cs = CPU(core->threads[i]);
-            pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
-        }
-    }
 }
 
 static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -5165,26 +5081,6 @@ static void spapr_machine_2_10_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 10);
 
-/*
- * pseries-2.9
- */
-
-static void spapr_machine_2_9_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
-    };
-
-    spapr_machine_2_10_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    smc->pre_2_10_has_unused_icps = true;
-    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
-}
-
-DEFINE_SPAPR_MACHINE(2, 9);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6e9e62386c..af4aa1cb0f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,7 +143,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
     uint32_t nr_xirqs;
     bool broken_host_serial_model; /* present real host info to the guest */
diff --git a/migration/savevm.c b/migration/savevm.c
index 7e1e27182a..839a34402b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -860,25 +860,6 @@ static void vmstate_check(const VMStateDescription *vmsd)
     }
 }
 
-/*
- * See comment in hw/intc/xics.c:icp_realize()
- *
- * This function can be removed when
- * pre_2_10_vmstate_register_dummy_icp() is removed.
- */
-int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
-                                 const VMStateDescription *vmsd,
-                                 void *opaque)
-{
-    SaveStateEntry *se = find_se(vmsd->name, instance_id);
-
-    if (se) {
-        savevm_state_handler_remove(se);
-        g_free(se->compat);
-        g_free(se);
-    }
-    return vmstate_register(obj, instance_id, vmsd, opaque);
-}
 
 int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    const VMStateDescription *vmsd,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 30dba050f6..faa610197d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1457,7 +1457,6 @@ struct ArchCPU {
     opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
 
     /* Fields related to migration compatibility hacks */
-    bool pre_2_10_migration;
     bool pre_3_0_migration;
     int32_t mig_slb_nr;
 };
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7768392986..39c19e6674 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7452,8 +7452,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 }
 
 static Property ppc_cpu_properties[] = {
-    DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
-                     false),
     DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
                      false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 21bed7c7c8..47495b68b1 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -630,7 +630,7 @@ static bool compat_needed(void *opaque)
     PowerPCCPU *cpu = opaque;
 
     assert(!(cpu->compat_pvr && !cpu->vhyp));
-    return !cpu->pre_2_10_migration && cpu->compat_pvr != 0;
+    return cpu->compat_pvr != 0;
 }
 
 static const VMStateDescription vmstate_compat = {
-- 
2.45.2


