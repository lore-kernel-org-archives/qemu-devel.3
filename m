Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28D3CFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxppN-0002ez-0n; Mon, 07 Oct 2024 11:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxppF-0002Ot-Dz; Mon, 07 Oct 2024 11:39:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxppD-0001X6-Ap; Mon, 07 Oct 2024 11:39:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497EnPoL029841;
 Mon, 7 Oct 2024 15:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 PnxrjHluH/BIFlJ2eGSam94qTVJlAiyG9F+xUihXJQU=; b=PC4YTV8CXACiYmoq
 ICtb0cHEMHXjxRvmgl3OdReT9VQiCTSuLDQ7NIvTeryiZrPZZkpPHjHhflofRX0m
 lfe450LhAFwl9XLYQt+CyeACLXYJY73FMvuBxXquxEUvDzc7hIc5EzWCvcKvQy6a
 Bp45eXTJoOS3BRURz1trisl7bFEP8bqVUL7SNszpls8/DgI0Uqtze2nQAu0bQhoc
 UfPSkXkyD+VfrLVAWY4jkfAIH+IjmzXwISm7LxdJbdJn7r6Q0GtL7DEjRvL10xFD
 xVMhgOcCpB9Eo5uFHSsOqwxhdoeX/kSZcF+nRLZPVJXrkbOfu2yGVn1CBqOWAlUM
 XT9w2g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424hra88q6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497FcwGQ001683;
 Mon, 7 Oct 2024 15:38:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424hra88q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497DRBId013784;
 Mon, 7 Oct 2024 15:38:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fsrymcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 497Fctdh35390068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2024 15:38:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D94252004B;
 Mon,  7 Oct 2024 15:38:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F047B20040;
 Mon,  7 Oct 2024 15:38:54 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2024 15:38:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v3 09/14] ppc/spapr: remove deprecated machine pseries-2.9
Date: Mon,  7 Oct 2024 21:08:33 +0530
Message-ID: <20241007153838.1085522-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007153838.1085522-1-harshpb@linux.ibm.com>
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6MQg2lpwSytMZpSOtLCVoylVi-JJ5_SJ
X-Proofpoint-ORIG-GUID: OTrL5tdhbUg5ebXFucLHmkH4-NkvCkFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.9 specific code with this patch for now.

While at it, also remove the pre-2.10 migration hacks which now become
obsolete.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |   1 -
 target/ppc/cpu.h       |   1 -
 hw/intc/xics.c         |  16 -------
 hw/ppc/spapr.c         | 104 -----------------------------------------
 migration/savevm.c     |  19 --------
 target/ppc/cpu_init.c  |   2 -
 target/ppc/machine.c   |   2 +-
 7 files changed, 1 insertion(+), 144 deletions(-)

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
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cab4a46fc1..74a0ab768d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1456,7 +1456,6 @@ struct ArchCPU {
     opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
 
     /* Fields related to migration compatibility hacks */
-    bool pre_2_10_migration;
     bool pre_3_0_migration;
     int32_t mig_slb_nr;
 };
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


