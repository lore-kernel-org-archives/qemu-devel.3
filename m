Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F4DD16258
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KBZ-0000sG-UX; Mon, 14 Oct 2024 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KBG-0000G7-Hk; Mon, 14 Oct 2024 08:28:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KBC-0002Pn-Nc; Mon, 14 Oct 2024 08:28:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ECO5rL004764;
 Mon, 14 Oct 2024 12:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 EJoQ3+5PwCE3vgOz3vHPadE019SdEjR1njmJyKaks5Q=; b=UDvPTrxt9G11UfaS
 V7hBsN9Wj73F6tEvvDuIb6iuKYo+O9JrjCRALstl5kQo5c0CDwdG1/kKFMPlUkR1
 SFjy4+Slabr0tD8185NJgoA7FAUEJe3974MxE7EwstKbIMzJoZ4ExujvxiJml03k
 JB4XZvsMNoyKFvupl7FfkXuwkUewrDFkt4Hp1SeRzs3ERCb4DOhQBwX1f5TlIHDa
 VLHoppz7D9OeVyDF+HfnlyAb6SYfJFSUdBBUOAAKp3z1BE3m2gi8/H/zQ2i3QJjV
 qzCECYjniaFS3peXMHnMnLLlJLPB1HTVkwMMOTl8P5QD+V5OJ20yb8XDNhgKuzNt
 qzmkOQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429391r0gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:28:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ECS02L012316;
 Mon, 14 Oct 2024 12:28:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429391r0gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:28:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49ECPr1X005936;
 Mon, 14 Oct 2024 12:28:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650p4wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:28:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ECRwN339649706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 12:27:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AE4C20043;
 Mon, 14 Oct 2024 12:27:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65F8020040;
 Mon, 14 Oct 2024 12:27:57 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 12:27:57 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v4 13/13] ppc/spapr: remove deprecated machine pseries-2.12
Date: Mon, 14 Oct 2024 17:57:29 +0530
Message-ID: <20241014122729.1136809-14-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014122729.1136809-1-harshpb@linux.ibm.com>
References: <20241014122729.1136809-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -1bQ70w7E9efx6jL9cpzmLuFyAcwDzo2
X-Proofpoint-GUID: jN5UJ9aoShGv5lD_yftcQAEvJaSMldx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=940 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410140089
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

Commit 0cac0f1b964 marked pseries-2.12 machines as deprecated
with reasons mentioned in its commit log.
Removing pseries-2.12 specific code with this patch.

While at it, also remove pre-3.0-migration hacks introduced for backward
compatibility which are now turned useless.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 docs/about/deprecated.rst       |  8 --------
 include/hw/ppc/spapr_cpu_core.h |  1 -
 target/ppc/cpu.h                |  4 ----
 hw/ppc/spapr.c                  | 25 -------------------------
 hw/ppc/spapr_cpu_core.c         | 12 +++---------
 target/ppc/cpu_init.c           |  3 +--
 target/ppc/machine.c            | 18 +-----------------
 7 files changed, 5 insertions(+), 66 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 48b230b0a0..3b312a5de2 100644
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
index 74a0ab768d..506c8c825c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1454,10 +1454,6 @@ struct ArchCPU {
     /* Those resources are used only during code translation */
     /* opcode handlers */
     opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
-
-    /* Fields related to migration compatibility hacks */
-    bool pre_3_0_migration;
-    int32_t mig_slb_nr;
 };
 
 /**
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


