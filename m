Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B9CC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYI8-0004C4-VD; Fri, 08 Mar 2024 06:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYI1-0004AU-Vr; Fri, 08 Mar 2024 06:21:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYHs-0003z7-De; Fri, 08 Mar 2024 06:21:25 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428AbN8Q026921; Fri, 8 Mar 2024 11:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m7q2MMgLIBNLz8YFU4mao61xzSHGpVcw+1L8cZbGLXs=;
 b=attBk4droeLEX65cXBgjPvogid4VnSuIycxenENuGzKhUusyx29X1FiDbIA8ZB2OJLmt
 gUCR5FamPkbS6P5ZnhKv25q4G4NY8NYf5nUg18qnwQL/MgNQWom/Z8yCInVH9xexGZVz
 cUXB3H0/TwuhiPkv29BFXuV5I3EZUcXBiPJB65hmKn0Qv3Ck8ctg+n6W+CaMsOPyvmuq
 xv0atRKdt3Yi7hVxE0qUJY9C7y3/Ju+EL1PBWdF07CgXWtZG8SyDhVDnd3fvWAoN5Eyt
 dLVEl5CIt+6Y0qg6u5WEvXIprnQk2ht57YwVekhGnWnXw3KZtM8i+yCZ6UHgy0EjGddL Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr12y8kq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428Athi6001978;
 Fri, 8 Mar 2024 11:21:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr12y8kpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4289l1cJ031554; Fri, 8 Mar 2024 11:20:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnkkq13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKoOv37552396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 732D62004E;
 Fri,  8 Mar 2024 11:20:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CC952004D;
 Fri,  8 Mar 2024 11:20:47 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:47 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 06/14] spapr: nested: Introduce
 H_GUEST_[GET|SET]_CAPABILITIES hcalls.
Date: Fri,  8 Mar 2024 16:49:32 +0530
Message-Id: <20240308111940.1617660-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JyoeI--jjFL5BjPbxTIC5JGtBud03vYO
X-Proofpoint-ORIG-GUID: HWKmt4Q6XLHyUlNlIDB0BygYq4HqeCAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Introduce the nested PAPR hcalls:
 - H_GUEST_GET_CAPABILITIES which is used to query the capabilities
   of the API and the L2 guests it provides.
 - H_GUEST_SET_CAPABILITIES which is used to set the Guest API
   capabilities that the Host Partition supports and may use.

[amachhiw: support for p9 compat mode and return register bug fixes]

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Amit Machhiwal <amachhiw@linux.vnet.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |   7 ++-
 include/hw/ppc/spapr_nested.h |  12 ++++
 hw/ppc/spapr_nested.c         | 112 ++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0eb01ea6fd..2906d59137 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -364,6 +364,7 @@ struct SpaprMachineState {
 #define H_NOOP            -63
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
+#define H_STATE           -75
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -583,8 +584,10 @@ struct SpaprMachineState {
 #define H_RPT_INVALIDATE        0x448
 #define H_SCM_FLUSH             0x44C
 #define H_WATCHDOG              0x45C
+#define H_GUEST_GET_CAPABILITIES 0x460
+#define H_GUEST_SET_CAPABILITIES 0x464
 
-#define MAX_HCALL_OPCODE        H_WATCHDOG
+#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
@@ -1033,5 +1036,7 @@ void spapr_watchdog_init(SpaprMachineState *spapr);
 void spapr_register_nested_hv(void);
 void spapr_unregister_nested_hv(void);
 void spapr_nested_reset(SpaprMachineState *spapr);
+void spapr_register_nested_papr(void);
+void spapr_unregister_nested_papr(void);
 
 #endif /* HW_SPAPR_H */
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index bf3a7b8d89..73687e03e4 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -7,8 +7,20 @@ typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
     uint8_t api;
 #define NESTED_API_KVM_HV  1
+    bool capabilities_set;
+    uint32_t pvr_base;
 } SpaprMachineStateNested;
 
+/* Nested PAPR API related macros */
+#define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
+#define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
+#define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
+#define H_GUEST_CAP_VALID_MASK        (H_GUEST_CAPABILITIES_P10_MODE | \
+                                       H_GUEST_CAPABILITIES_P9_MODE)
+#define H_GUEST_CAP_COPY_MEM_BMAP     0
+#define H_GUEST_CAP_P9_MODE_BMAP      1
+#define H_GUEST_CAP_P10_MODE_BMAP     2
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 12fdbe2aba..601f669060 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -7,6 +7,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
+#include "cpu-models.h"
 
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
@@ -16,6 +17,7 @@ void spapr_nested_reset(SpaprMachineState *spapr)
         spapr_register_nested_hv();
     } else {
         spapr->nested.api = 0;
+        spapr->nested.capabilities_set = false;
     }
 }
 
@@ -432,6 +434,92 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
+static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
+                                             SpaprMachineState *spapr,
+                                             target_ulong opcode,
+                                             target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+
+    if (flags) { /* don't handle any flags capabilities for now */
+        return H_PARAMETER;
+    }
+
+    /* P10 capabilities */
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
+        spapr->max_compat_pvr)) {
+        env->gpr[4] |= H_GUEST_CAPABILITIES_P10_MODE;
+    }
+
+    /* P9 capabilities */
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+        spapr->max_compat_pvr)) {
+        env->gpr[4] |= H_GUEST_CAPABILITIES_P9_MODE;
+    }
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
+                                             SpaprMachineState *spapr,
+                                             target_ulong opcode,
+                                              target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong capabilities = args[1];
+    env->gpr[4] = 0;
+
+    if (flags) { /* don't handle any flags capabilities for now */
+        return H_PARAMETER;
+    }
+
+    if (capabilities & H_GUEST_CAPABILITIES_COPY_MEM) {
+        env->gpr[4] = 1;
+        return H_P2; /* isn't supported */
+    }
+
+    /* If there are no capabilities configured, set the R5 to the index of
+     * the first supported Power Processor Mode
+     */
+    if (!capabilities) {
+        env->gpr[4] = 1;
+
+        /* set R5 to the first supported Power Processor Mode */
+        if(ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
+                            spapr->max_compat_pvr)) {
+            env->gpr[5] = H_GUEST_CAP_P10_MODE_BMAP;
+        }
+        else if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                                  spapr->max_compat_pvr)) {
+            env->gpr[5] = H_GUEST_CAP_P9_MODE_BMAP;
+        }
+
+        return H_P2;
+    }
+
+    /* If an invalid capability is set, R5 should contain the index of the
+     * invalid capability bit
+     */
+    if (capabilities & ~H_GUEST_CAP_VALID_MASK) {
+        env->gpr[4] = 1;
+
+        /* Set R5 to the index of the invalid capability */
+        env->gpr[5] = 63 - ctz64(capabilities);
+
+        return H_P2;
+    }
+
+    if (!spapr->nested.capabilities_set) {
+        spapr->nested.capabilities_set = true;
+        spapr->nested.pvr_base = env->spr[SPR_PVR];
+        return H_SUCCESS;
+    } else {
+        return H_STATE;
+    }
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -447,6 +535,19 @@ void spapr_unregister_nested_hv(void)
     spapr_unregister_hypercall(KVMPPC_H_TLB_INVALIDATE);
     spapr_unregister_hypercall(KVMPPC_H_COPY_TOFROM_GUEST);
 }
+
+void spapr_register_nested_papr(void)
+{
+    spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
+    spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
+}
+
+void spapr_unregister_nested_papr(void)
+{
+    spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
+    spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
+}
+
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
@@ -468,4 +569,15 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 {
     return false;
 }
+
+void spapr_register_nested_papr(void)
+{
+    /* DO NOTHING */
+}
+
+void spapr_unregister_nested_papr(void)
+{
+    /* DO NOTHING */
+}
+
 #endif
-- 
2.39.3


