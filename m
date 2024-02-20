Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E619C54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLcT-0003BC-Kl; Tue, 20 Feb 2024 03:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcL-00032t-HB; Tue, 20 Feb 2024 03:36:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcI-00056H-1j; Tue, 20 Feb 2024 03:36:44 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7VEEi005376; Tue, 20 Feb 2024 08:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RcOYDaNHMPAPGX43kqxrJL8EsUkRUJeDEnh7Y8JOySo=;
 b=HGFn0Q5FYvijl+wFOHwCcmgut0Vy3K9QaxTRV273fC+nKaeW6fv05YOrUImc7fPTb+7s
 FlENDdTPg7vzWrpzk8ZlbGcsoSs2tZd8DMxy2agycB/DowEM5WMvAErm0F+QDFaehS+x
 DW76whnYwk5XC6JsGmvF83I3ddNrzlJntMWxg5TydHrjyWkX9hr0MSgrboRSvaSxZnOT
 o4hPAeE1CygV9/8wN/s12g1hfq2LgZO+7+NNVVCAV+y0w7XYFA5PvysefhtiTcSqokBB
 /znhIwN2s1iFU4ififP8WCIyxdJJ5Ve3SVMDK+NPa2RFp1fRikl6Ck+iPBdMVptpkXRP fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpf7ubq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:37 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K7vmFx020927;
 Tue, 20 Feb 2024 08:36:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpf7ubpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7SW2F013472; Tue, 20 Feb 2024 08:36:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h076hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8aUx164094610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1006C20040;
 Tue, 20 Feb 2024 08:36:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69F2D2004E;
 Tue, 20 Feb 2024 08:36:28 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:28 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 06/15] spapr: nested: Introduce
 H_GUEST_[GET|SET]_CAPABILITIES hcalls.
Date: Tue, 20 Feb 2024 14:06:00 +0530
Message-Id: <20240220083609.748325-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cOfJqPX-JAug72g4-y5B1pfVvMDxeGOP
X-Proofpoint-GUID: eg6KwAZ_9WPUI5iGYuyMty48lW2HKjkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
 include/hw/ppc/spapr.h        |   6 +-
 include/hw/ppc/spapr_nested.h |  12 ++++
 hw/ppc/spapr_nested.c         | 100 ++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 63e9d4c476..d745d487a1 100644
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
@@ -1029,5 +1032,6 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt);
 void spapr_watchdog_init(SpaprMachineState *spapr);
 void spapr_register_nested_hv(void);
 void spapr_unregister_nested_hv(void);
+void spapr_register_nested_papr(void);
 
 #endif /* HW_SPAPR_H */
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 3f07c81c3d..599373692b 100644
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
index 9096dd96a4..012af27881 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -7,10 +7,12 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
+#include "cpu-models.h"
 
 void spapr_nested_init(SpaprMachineState *spapr)
 {
     spapr->nested.api = 0;
+    spapr->nested.capabilities_set = false;
 }
 
 uint8_t spapr_nested_api(SpaprMachineState *spapr)
@@ -426,6 +428,92 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
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
@@ -441,6 +529,13 @@ void spapr_unregister_nested_hv(void)
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
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
@@ -462,4 +557,9 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 {
     return false;
 }
+
+void spapr_register_nested_papr(void)
+{
+    /* DO NOTHING */
+}
 #endif
-- 
2.39.3


