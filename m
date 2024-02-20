Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FA0C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLgq-0004aP-Gb; Tue, 20 Feb 2024 03:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLgn-0004ZZ-QS; Tue, 20 Feb 2024 03:41:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLgj-0005xT-JJ; Tue, 20 Feb 2024 03:41:20 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K6Vrpt005383; Tue, 20 Feb 2024 08:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Hm2uYywLFPx75icryPHBQt5JKZe7ydlqrQyraeotSHs=;
 b=p1EAUHk/hcnhEKP873Mk263DjvEqNMW5imx4BDyD+cY2VFT+ipjZ58/zqOVKRxVuUV8p
 Dk1aKWdwyumSadhet541bIRGFwHJJMmrDY4UPL+DXyXvpyJqho6ger1t81cBzONlxtfM
 ODj9PASJmXv2vTbkT5h3BPj8jpOZn7NUKcHcIXbB5RCqD9rHnGGHm/lp/3OBco4eA6Fu
 FWac7wJlsS0gkSDA93mTq6mavK+R/LNjPuM6nIplBl/qzvmuw3UXP4RDNeGBOp16scX0
 e2ly33XqWw2v1Xzoa+dPovMIZhIyKQq5PmkCklix/e7eC2fCxP26GS5hBwsRhU/lFcoc jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcnc8vsgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:41:13 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8VO2l016320;
 Tue, 20 Feb 2024 08:41:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcnc8vsf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:41:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7Mb9t013522; Tue, 20 Feb 2024 08:36:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h076j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8ah6920513496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6D882004B;
 Tue, 20 Feb 2024 08:36:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B5D220040;
 Tue, 20 Feb 2024 08:36:42 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 13/15] spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
Date: Tue, 20 Feb 2024 14:06:07 +0530
Message-Id: <20240220083609.748325-14-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ryL6tZPbQkD0uYXwc34xzRZRloLf3xqs
X-Proofpoint-ORIG-GUID: JKwtP4XV20NCZ3ADHTRVMTVef_6kpiyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The H_GUEST_RUN_VCPU hcall is used to start execution of a Guest VCPU.
The Hypervisor will update the state of the Guest VCPU based on the
input buffer, restore the saved Guest VCPU state, and start its
execution.

The Guest VCPU can stop running for numerous reasons including HCALLs,
hypervisor exceptions, or an outstanding Host Partition Interrupt.
The reason that the Guest VCPU stopped running is communicated through
R4 and the output buffer will be filled in with any relevant state.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |   1 +
 target/ppc/cpu.h       |   2 +
 hw/ppc/ppc.c           |  10 ++
 hw/ppc/spapr_nested.c  | 333 +++++++++++++++++++++++++++++++++++++----
 4 files changed, 316 insertions(+), 30 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index aabc32f268..036a7db2bc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -592,6 +592,7 @@ struct SpaprMachineState {
 #define H_GUEST_CREATE_VCPU      0x474
 #define H_GUEST_GET_STATE        0x478
 #define H_GUEST_SET_STATE        0x47C
+#define H_GUEST_RUN_VCPU         0x480
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 11205bb9e3..d2978326e7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1566,6 +1566,8 @@ uint64_t cpu_ppc_load_atbl(CPUPPCState *env);
 uint32_t cpu_ppc_load_atbu(CPUPPCState *env);
 void cpu_ppc_store_atbl(CPUPPCState *env, uint32_t value);
 void cpu_ppc_store_atbu(CPUPPCState *env, uint32_t value);
+void cpu_ppc_increase_tb_by_offset (CPUPPCState *env, int64_t offset);
+void cpu_ppc_decrease_tb_by_offset (CPUPPCState *env, int64_t offset);
 uint64_t cpu_ppc_load_vtb(CPUPPCState *env);
 void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value);
 bool ppc_decr_clear_on_delivery(CPUPPCState *env);
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fadb8f5239..55860b9a83 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -633,6 +633,16 @@ void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
                      ((uint64_t)value << 32) | tb);
 }
 
+void cpu_ppc_increase_tb_by_offset (CPUPPCState *env, int64_t offset)
+{
+    env->tb_env->tb_offset += offset;
+}
+
+void cpu_ppc_decrease_tb_by_offset (CPUPPCState *env, int64_t offset)
+{
+    env->tb_env->tb_offset -= offset;
+}
+
 uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 0edb362709..db1c59a8f5 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -193,14 +193,28 @@ static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
         save->sier = env->spr[SPR_POWER_SIER];
         save->vscr = ppc_get_vscr(env);
         save->fpscr = env->fpscr;
+    } else if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+        save->tb_offset = env->tb_env->tb_offset;
     }
+}
 
-    save->tb_offset = env->tb_env->tb_offset;
+static void nested_post_load_state(CPUPPCState *env, CPUState *cs)
+{
+    /*
+     * compute hflags and possible interrupts.
+     */
+    hreg_compute_hflags(env);
+    ppc_maybe_interrupt(env);
+    /*
+     * Nested HV does not tag TLB entries between L1 and L2, so must
+     * flush on transition.
+     */
+    tlb_flush(cs);
+    env->reserve_addr = -1; /* Reset the reservation */
 }
 
 static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
 
@@ -279,22 +293,9 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
         env->spr[SPR_POWER_SIER] = load->sier;
         ppc_store_vscr(env, load->vscr);
         ppc_store_fpscr(env, load->fpscr);
+    } else if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+        env->tb_env->tb_offset = load->tb_offset;
     }
-
-    env->tb_env->tb_offset = load->tb_offset;
-
-    /*
-     * MSR updated, compute hflags and possible interrupts.
-     */
-    hreg_compute_hflags(env);
-    ppc_maybe_interrupt(env);
-
-    /*
-     * Nested HV does not tag TLB entries between L1 and L2, so must
-     * flush on transition.
-     */
-    tlb_flush(cs);
-    env->reserve_addr = -1; /* Reset the reservation */
 }
 
 /*
@@ -309,6 +310,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     struct nested_ppc_state l2_state;
     target_ulong hv_ptr = args[0];
@@ -407,6 +409,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
      * Switch to the nested guest environment and start the "hdec" timer.
      */
     nested_load_state(cpu, &l2_state);
+    nested_post_load_state(env, cs);
 
     hdec = hv_state.hdec_expiry - now;
     cpu_ppc_hdecr_init(env);
@@ -438,6 +441,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
 static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     struct nested_ppc_state l2_state;
     target_ulong hv_ptr = spapr_cpu->nested_host_state->gpr[4];
@@ -459,6 +463,7 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
      */
     assert(env->spr[SPR_LPIDR] != 0);
     nested_load_state(cpu, spapr_cpu->nested_host_state);
+    nested_post_load_state(env, cs);
     env->gpr[3] = env->excp_vectors[excp]; /* hcall return value */
 
     cpu_ppc_hdecr_exit(env);
@@ -536,19 +541,6 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
-void spapr_exit_nested(PowerPCCPU *cpu, int excp)
-{
-    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-
-    assert(spapr_cpu->in_nested);
-    if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
-        spapr_exit_nested_hv(cpu, excp);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong guestid)
 {
@@ -1521,6 +1513,286 @@ static target_ulong h_guest_get_state(PowerPCCPU *cpu,
     return h_guest_getset_state(cpu, spapr, args, false);
 }
 
+static void exit_nested_store_l2(PowerPCCPU *cpu, int excp,
+                                 SpaprMachineStateNestedGuestVcpu *vcpu)
+{
+    CPUPPCState *env = &cpu->env;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    target_ulong now, hdar, hdsisr, asdr;
+
+    assert(sizeof(env->gpr) == sizeof(vcpu->state.gpr)); /* sanity check */
+
+    now = cpu_ppc_load_tbl(env); /* L2 timebase */
+    now -= vcpu->tb_offset; /* L1 timebase */
+    vcpu->state.dec_expiry_tb = now - cpu_ppc_load_decr(env);
+    cpu_ppc_store_decr(env, spapr_cpu->nested_host_state->dec_expiry_tb - now);
+    /* backup hdar, hdsisr, asdr if reqd later below */
+    hdar   = vcpu->state.hdar;
+    hdsisr = vcpu->state.hdsisr;
+    asdr   = vcpu->state.asdr;
+
+    nested_save_state(&vcpu->state, cpu);
+
+    if (excp == POWERPC_EXCP_MCHECK ||
+        excp == POWERPC_EXCP_RESET ||
+        excp == POWERPC_EXCP_SYSCALL) {
+        vcpu->state.nip = env->spr[SPR_SRR0];
+        vcpu->state.msr = env->spr[SPR_SRR1] & env->msr_mask;
+    } else {
+        vcpu->state.nip = env->spr[SPR_HSRR0];
+        vcpu->state.msr = env->spr[SPR_HSRR1] & env->msr_mask;
+    }
+
+    /* hdar, hdsisr, asdr should be retained unless certain exceptions */
+    if ((excp != POWERPC_EXCP_HDSI) && (excp != POWERPC_EXCP_HISI)) {
+        vcpu->state.asdr = asdr;
+    } else if (excp != POWERPC_EXCP_HDSI) {
+        vcpu->state.hdar   = hdar;
+        vcpu->state.hdsisr = hdsisr;
+    }
+}
+
+static int get_exit_ids(uint64_t srr0, uint16_t ids[16])
+{
+    int nr;
+
+    switch (srr0) {
+    case 0xc00:
+        nr = 10;
+        ids[0] = GSB_VCPU_GPR3;
+        ids[1] = GSB_VCPU_GPR4;
+        ids[2] = GSB_VCPU_GPR5;
+        ids[3] = GSB_VCPU_GPR6;
+        ids[4] = GSB_VCPU_GPR7;
+        ids[5] = GSB_VCPU_GPR8;
+        ids[6] = GSB_VCPU_GPR9;
+        ids[7] = GSB_VCPU_GPR10;
+        ids[8] = GSB_VCPU_GPR11;
+        ids[9] = GSB_VCPU_GPR12;
+        break;
+    case 0xe00:
+        nr = 5;
+        ids[0] = GSB_VCPU_SPR_HDAR;
+        ids[1] = GSB_VCPU_SPR_HDSISR;
+        ids[2] = GSB_VCPU_SPR_ASDR;
+        ids[3] = GSB_VCPU_SPR_NIA;
+        ids[4] = GSB_VCPU_SPR_MSR;
+        break;
+    case 0xe20:
+        nr = 4;
+        ids[0] = GSB_VCPU_SPR_HDAR;
+        ids[1] = GSB_VCPU_SPR_ASDR;
+        ids[2] = GSB_VCPU_SPR_NIA;
+        ids[3] = GSB_VCPU_SPR_MSR;
+        break;
+    case 0xe40:
+        nr = 3;
+        ids[0] = GSB_VCPU_SPR_HEIR;
+        ids[1] = GSB_VCPU_SPR_NIA;
+        ids[2] = GSB_VCPU_SPR_MSR;
+        break;
+    case 0xf80:
+        nr = 3;
+        ids[0] = GSB_VCPU_SPR_HFSCR;
+        ids[1] = GSB_VCPU_SPR_NIA;
+        ids[2] = GSB_VCPU_SPR_MSR;
+        break;
+    default:
+        nr = 0;
+        break;
+    }
+
+    return nr;
+}
+
+static void exit_process_output_buffer(PowerPCCPU *cpu,
+                                       SpaprMachineStateNestedGuest *guest,
+                                       target_ulong vcpuid,
+                                       target_ulong *r3)
+{
+    SpaprMachineStateNestedGuestVcpu *vcpu = &guest->vcpu[vcpuid];
+    struct guest_state_request gsr;
+    struct guest_state_buffer *gsb;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    int exit_id_count = 0;
+    uint16_t exit_cause_ids[16];
+    hwaddr len;
+
+    len = vcpu->runbufout.size;
+    gsb = address_space_map(CPU(cpu)->as, vcpu->runbufout.addr, &len, true,
+                            MEMTXATTRS_UNSPECIFIED);
+    if (!gsb || len != vcpu->runbufout.size) {
+        address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
+        *r3 = H_P2;
+        return;
+    }
+
+    exit_id_count = get_exit_ids(*r3, exit_cause_ids);
+
+    /* Create a buffer of elements to send back */
+    gsb->num_elements = cpu_to_be32(exit_id_count);
+    element = gsb->elements;
+    for (int i = 0; i < exit_id_count; i++) {
+        type = guest_state_element_type_find(exit_cause_ids[i]);
+        assert(type);
+        element->id = cpu_to_be16(exit_cause_ids[i]);
+        element->size = cpu_to_be16(type->size);
+        element = guest_state_element_next(element, NULL, NULL);
+    }
+    gsr.gsb = gsb;
+    gsr.len = VCPU_OUT_BUF_MIN_SZ;
+    gsr.flags = 0; /* get + never guest wide */
+    getset_state(guest, vcpuid, &gsr);
+
+    address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
+    return;
+}
+
+static
+void spapr_exit_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu, int excp)
+{
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    target_ulong r3_return = env->excp_vectors[excp]; /* hcall return value */
+    target_ulong lpid = 0, vcpuid = 0;
+    struct SpaprMachineStateNestedGuestVcpu *vcpu = NULL;
+    struct SpaprMachineStateNestedGuest *guest = NULL;
+
+    lpid = spapr_cpu->nested_host_state->gpr[5];
+    vcpuid = spapr_cpu->nested_host_state->gpr[6];
+    guest = spapr_get_nested_guest(spapr, lpid);
+    assert(guest);
+    spapr_nested_vcpu_check(guest, vcpuid, false);
+    vcpu = &guest->vcpu[vcpuid];
+
+    exit_nested_store_l2(cpu, excp, vcpu);
+    /* do the output buffer for run_vcpu*/
+    exit_process_output_buffer(cpu, guest, vcpuid, &r3_return);
+
+    assert(env->spr[SPR_LPIDR] != 0);
+    nested_load_state(cpu, spapr_cpu->nested_host_state);
+    cpu_ppc_decrease_tb_by_offset(env, vcpu->tb_offset);
+    env->gpr[3] = H_SUCCESS;
+    env->gpr[4] = r3_return;
+    nested_post_load_state(env, cs);
+    cpu_ppc_hdecr_exit(env);
+
+    spapr_cpu->in_nested = false;
+    g_free(spapr_cpu->nested_host_state);
+    spapr_cpu->nested_host_state = NULL;
+}
+
+void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    assert(spapr_cpu->in_nested);
+    if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+        spapr_exit_nested_hv(cpu, excp);
+    } else if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+        spapr_exit_nested_papr(spapr, cpu, excp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static void nested_papr_load_l2(PowerPCCPU *cpu,
+                                CPUPPCState *env,
+                                SpaprMachineStateNestedGuestVcpu *vcpu,
+                                target_ulong now)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    target_ulong lpcr, lpcr_mask, hdec;
+    lpcr_mask = LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
+
+    assert(vcpu);
+    assert(sizeof(env->gpr) == sizeof(vcpu->state.gpr));
+    nested_load_state(cpu, &vcpu->state);
+    lpcr = (env->spr[SPR_LPCR] & ~lpcr_mask) |
+           (vcpu->state.lpcr & lpcr_mask);
+    lpcr |= LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
+    lpcr &= ~LPCR_LPES0;
+    env->spr[SPR_LPCR] = lpcr & pcc->lpcr_mask;
+
+    hdec = vcpu->hdecr_expiry_tb - now;
+    cpu_ppc_store_decr(env, vcpu->state.dec_expiry_tb - now);
+    cpu_ppc_hdecr_init(env);
+    cpu_ppc_store_hdecr(env, hdec);
+
+    cpu_ppc_increase_tb_by_offset(env, vcpu->tb_offset);
+}
+
+static void nested_papr_run_vcpu(PowerPCCPU *cpu,
+                                 uint64_t lpid,
+                                 SpaprMachineStateNestedGuestVcpu *vcpu)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    target_ulong now = cpu_ppc_load_tbl(env);
+
+    assert(env->spr[SPR_LPIDR] == 0);
+    assert(spapr->nested.api); /* ensure API version is initialized */
+    spapr_cpu->nested_host_state = g_try_new(struct nested_ppc_state, 1);
+    assert(spapr_cpu->nested_host_state);
+    nested_save_state(spapr_cpu->nested_host_state, cpu);
+    spapr_cpu->nested_host_state->dec_expiry_tb = now - cpu_ppc_load_decr(env);
+    nested_papr_load_l2(cpu, env, vcpu, now);
+    env->spr[SPR_LPIDR] = lpid; /* post load l2 */
+
+    spapr_cpu->in_nested = true;
+    nested_post_load_state(env, cs);
+}
+
+static target_ulong h_guest_run_vcpu(PowerPCCPU *cpu,
+                                     SpaprMachineState *spapr,
+                                     target_ulong opcode,
+                                     target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong lpid = args[1];
+    target_ulong vcpuid = args[2];
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
+    struct guest_state_request gsr;
+    SpaprMachineStateNestedGuest *guest;
+    target_ulong rc;
+
+    if (flags) /* don't handle any flags for now */
+        return H_PARAMETER;
+
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return H_P2;
+    }
+    if (!spapr_nested_vcpu_check(guest, vcpuid, true)) {
+        return H_P3;
+    }
+
+    if (guest->parttbl[0] == 0) {
+        /* At least need a partition scoped radix tree */
+        return H_NOT_AVAILABLE;
+    }
+
+    vcpu = &guest->vcpu[vcpuid];
+
+    /* Read run_vcpu input buffer to update state */
+    gsr.buf = vcpu->runbufin.addr;
+    gsr.len = vcpu->runbufin.size;
+    gsr.flags = GUEST_STATE_REQUEST_SET; /* Thread wide + writing */
+    rc = map_and_getset_state(cpu, guest, vcpuid, &gsr);
+    if (rc == H_SUCCESS) {
+        nested_papr_run_vcpu(cpu, lpid, vcpu);
+    } else {
+        env->gpr[3] = rc;
+    }
+    return env->gpr[3];
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -1546,6 +1818,7 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
     spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
     spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
+    spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu);
 }
 
 #else
-- 
2.39.3


