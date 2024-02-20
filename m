Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B2C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLcT-0003Aj-BI; Tue, 20 Feb 2024 03:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcO-00036b-C0; Tue, 20 Feb 2024 03:36:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcK-00056h-N7; Tue, 20 Feb 2024 03:36:46 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7VAhj005047; Tue, 20 Feb 2024 08:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6jps+aY1PetzDdZ/4d+uAZfFQCxF4IF3LiCKWjKulRU=;
 b=MT8mcu35oIVgcrBYs0OnxbgBhkedOmSMmID5sjEVO25ZjlnP5cs0PpR6jFeKIB4fDS1y
 e6GxH4B1JU3QApwXqpilu5inlPdR3qN+WAcfpzVY3WFC+Kvkxl1k/xRZr7CTLP9hvfmo
 rR0WYydorKF3ShtzXSi/BavtDkSYgOMjiHeht2EM5LmOgmtLcV3/Wn/mQ/ipkk137O+8
 YGqLlHR6pHoiN9GAsh5D+NwDi8Us5UtjcmpAvrwsddz3oDpxPRwM+MIV5CQIo3mc1yx6
 AKJ+mNpxypGAayGjrYKhItBP4E2QAhxJo/ufi4Ai/UWPJXyQOiu7+a9CSg8oHx6cmh97 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpf7ubrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:40 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8UGRW004343;
 Tue, 20 Feb 2024 08:36:40 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpf7ubrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7s076003623; Tue, 20 Feb 2024 08:36:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tf9a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8aX8o6030020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF0FF2004D;
 Tue, 20 Feb 2024 08:36:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4459C20040;
 Tue, 20 Feb 2024 08:36:32 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:32 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 08/15] spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
Date: Tue, 20 Feb 2024 14:06:02 +0530
Message-Id: <20240220083609.748325-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yns1nqgYpwzinUqJMrbaBHmRcoFsqnqJ
X-Proofpoint-GUID: nwFHQLZPAYqMq0ElYqW7nhEPr29yRaki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxlogscore=826 phishscore=0 lowpriorityscore=0 bulkscore=0
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

Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
create and initialize the specified VCPU resource for the previously
created guest. Each guest can have multiple VCPUs upto max 2048.
All VCPUs for a guest gets deallocated on guest delete.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |  2 +
 include/hw/ppc/spapr_nested.h | 10 ++++
 hw/ppc/spapr_nested.c         | 96 +++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c4a79a1785..82b077bdd2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -365,6 +365,7 @@ struct SpaprMachineState {
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
 #define H_STATE           -75
+#define H_IN_USE          -77
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -587,6 +588,7 @@ struct SpaprMachineState {
 #define H_GUEST_GET_CAPABILITIES 0x460
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
+#define H_GUEST_CREATE_VCPU      0x474
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index f282479275..24e87bca08 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -14,6 +14,8 @@ typedef struct SpaprMachineStateNested {
 
 typedef struct SpaprMachineStateNestedGuest {
     uint32_t pvr_logical;
+    unsigned long vcpus;
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
 } SpaprMachineStateNestedGuest;
 
 /* Nested PAPR API related macros */
@@ -27,6 +29,7 @@ typedef struct SpaprMachineStateNestedGuest {
 #define H_GUEST_CAP_P10_MODE_BMAP     2
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
+#define PAPR_NESTED_GUEST_VCPU_MAX    2048
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
@@ -118,8 +121,15 @@ struct nested_ppc_state {
     uint64_t ppr;
 
     int64_t tb_offset;
+    /* Nested PAPR API */
+    uint64_t pvr;
 };
 
+typedef struct SpaprMachineStateNestedGuestVcpu {
+    bool enabled;
+    struct nested_ppc_state state;
+} SpaprMachineStateNestedGuestVcpu;
+
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 09c4a35908..3cc704adda 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -428,6 +428,41 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
+static
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong guestid)
+{
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
+    return guest;
+}
+
+static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
+                                    target_ulong vcpuid)
+{
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
+    /*
+     * Perform sanity checks for the provided vcpuid of a guest.
+     * For now, ensure its valid, allocated and enabled for use.
+     */
+
+    if (vcpuid >= PAPR_NESTED_GUEST_VCPU_MAX) {
+        return false;
+    }
+
+    if (!(vcpuid < guest->vcpus)) {
+        return false;
+    }
+
+    vcpu = &guest->vcpu[vcpuid];
+    if (!vcpu->enabled) {
+        return false;
+    }
+
+    return true;
+}
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -518,6 +553,7 @@ static void
 destroy_guest_helper(gpointer value)
 {
     struct SpaprMachineStateNestedGuest *guest = value;
+    g_free(guest->vcpu);
     g_free(guest);
 }
 
@@ -613,6 +649,65 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    struct nested_ppc_state *l2_state;
+    target_ulong flags = args[0];
+    target_ulong guestid = args[1];
+    target_ulong vcpuid = args[2];
+    SpaprMachineStateNestedGuest *guest;
+
+    if (flags) { /* don't handle any flags for now */
+        return H_UNSUPPORTED_FLAG;
+    }
+
+    guest = spapr_get_nested_guest(spapr, guestid);
+    if (!guest) {
+        return H_P2;
+    }
+
+    if (vcpuid < guest->vcpus) {
+        return H_IN_USE;
+    }
+
+    if (guest->vcpus >= PAPR_NESTED_GUEST_VCPU_MAX) {
+        return H_P3;
+    }
+
+    if (guest->vcpus) {
+        SpaprMachineStateNestedGuestVcpu *vcpus;
+        vcpus = g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
+                            guest->vcpu,
+                            guest->vcpus + 1);
+        if (!vcpus) {
+            return H_NO_MEM;
+        }
+        memset(&vcpus[guest->vcpus], 0,
+               sizeof(SpaprMachineStateNestedGuestVcpu));
+        guest->vcpu = vcpus;
+    } else {
+        guest->vcpu = g_try_new0(SpaprMachineStateNestedGuestVcpu, 1);
+        if (guest->vcpu == NULL) {
+            return H_NO_MEM;
+        }
+    }
+    l2_state = &guest->vcpu[guest->vcpus].state;
+    guest->vcpus++;
+    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */
+    /* Set L1 PVR as L2 default */
+    l2_state->pvr = env->spr[SPR_PVR];
+    guest->vcpu[vcpuid].enabled = true;
+
+    if (!spapr_nested_vcpu_check(guest, vcpuid)) {
+        return H_PARAMETER;
+    }
+    return H_SUCCESS;
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -635,6 +730,7 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
+    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
 }
 
 #else
-- 
2.39.3


