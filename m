Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF0FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYKx-0003bM-SP; Fri, 08 Mar 2024 06:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYKv-0003aV-TA; Fri, 08 Mar 2024 06:24:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYKu-0004pC-0U; Fri, 08 Mar 2024 06:24:25 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428BO8Pc003138; Fri, 8 Mar 2024 11:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fJiFvgRK6RJh/ye/oC20OUXmFaa+58oH8bb5sAuJkqw=;
 b=b3PHRm+eVKzRpVuzst6Ce2W2VQiFJoGcPQm741zyrdcqKIsWXMpEtZq53eFEwwl+jiGH
 FB2gnIHg2GFf72P4MNrkPHeotLL+3XHjX8BZbqCTacGTO6y9TyW2jHoSajHk7pAzqCC6
 ZY4MxlCm2CFXID2kFTPr7Px3AMBmhC3/XBCCZy/LFCzSt5TLFHqlqCoY1X+ss5stQqEZ
 pPe5KliVnLQujwE2cy77LmxYbJR++lJuWWJY2+gIiCPuwOXQpIRHdbXDYCDZ2oJQbzmy
 JkrHWj4hCS7uA4IrrWsar6Z/RMZiK7sfljqRUw8UvAd5GURytmr92CZ0wyXFKyn7jFPT HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke058d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:24:11 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428BOAwG003333;
 Fri, 8 Mar 2024 11:24:10 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke04tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:24:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428AMXb4010881; Fri, 8 Mar 2024 11:21:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52ukfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKtAU35848448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9F4620040;
 Fri,  8 Mar 2024 11:20:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7475920043;
 Fri,  8 Mar 2024 11:20:53 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:53 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 08/14] spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
Date: Fri,  8 Mar 2024 16:49:34 +0530
Message-Id: <20240308111940.1617660-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 27QMMVLn_BqOBK3T_v1Y9i-Pqpgsrby1
X-Proofpoint-ORIG-GUID: EC0uuxLU_xU47rsqlZUAoT-wXc7_FPGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=952 phishscore=0 mlxscore=0
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

Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
create and initialize the specified VCPU resource for the previously
created guest. Each guest can have multiple VCPUs upto max 2048.
All VCPUs for a guest gets deallocated on guest delete.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |  2 ++
 include/hw/ppc/spapr_nested.h |  8 +++++
 hw/ppc/spapr_nested.c         | 61 +++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 13416fc3d7..070135793a 100644
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
index 56d43e540b..2ac3076fac 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -14,6 +14,8 @@ typedef struct SpaprMachineStateNested {
 
 typedef struct SpaprMachineStateNestedGuest {
     uint32_t pvr_logical;
+    unsigned long nr_vcpus;
+    struct SpaprMachineStateNestedGuestVcpu *vcpus;
 } SpaprMachineStateNestedGuest;
 
 /* Nested PAPR API related macros */
@@ -27,6 +29,7 @@ typedef struct SpaprMachineStateNestedGuest {
 #define H_GUEST_CAP_P10_MODE_BMAP     2
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
+#define PAPR_NESTED_GUEST_VCPU_MAX    2048
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
@@ -120,6 +123,11 @@ struct nested_ppc_state {
     int64_t tb_offset;
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
index 13674c0857..4c0e2e91e1 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -8,6 +8,7 @@
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
+#include "qemu/log.h"
 
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
@@ -434,6 +435,16 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
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
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -524,6 +535,7 @@ static void
 destroy_guest_helper(gpointer value)
 {
     struct SpaprMachineStateNestedGuest *guest = value;
+    g_free(guest->vcpus);
     g_free(guest);
 }
 
@@ -619,6 +631,53 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
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
+    if (vcpuid < guest->nr_vcpus) {
+        qemu_log_mask(LOG_UNIMP, "vcpuid %ld already in use, return.", vcpuid);
+        return H_IN_USE;
+    }
+    /* linear vcpuid allocation only */
+    assert(vcpuid == guest->nr_vcpus);
+
+    if (guest->nr_vcpus >= PAPR_NESTED_GUEST_VCPU_MAX) {
+        return H_P3;
+    }
+
+    SpaprMachineStateNestedGuestVcpu *vcpus, *curr_vcpu;
+    vcpus = g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
+                        guest->vcpus,
+                        guest->nr_vcpus + 1);
+    if (!vcpus) {
+        return H_NO_MEM;
+    }
+    guest->vcpus = vcpus;
+    curr_vcpu = &vcpus[guest->nr_vcpus];
+    memset(curr_vcpu, 0, sizeof(SpaprMachineStateNestedGuestVcpu));
+
+    curr_vcpu->enabled = true;
+    guest->nr_vcpus++;
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -641,6 +700,7 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
+    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
 }
 
 void spapr_unregister_nested_papr(void)
@@ -649,6 +709,7 @@ void spapr_unregister_nested_papr(void)
     spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
     spapr_unregister_hypercall(H_GUEST_CREATE);
     spapr_unregister_hypercall(H_GUEST_DELETE);
+    spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
 }
 
 #else
-- 
2.39.3


