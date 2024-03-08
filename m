Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E901C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYKu-0003Zw-Tb; Fri, 08 Mar 2024 06:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYKs-0003ZW-Sg; Fri, 08 Mar 2024 06:24:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYKr-0004oo-1m; Fri, 08 Mar 2024 06:24:22 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428BC8hV007143; Fri, 8 Mar 2024 11:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gj/hIdL08uAUk+NfZ5haCwj4wgBBKA1sY9M1jYGBBGQ=;
 b=LhYgoDocP9IKusFGQRbSQaFrvPfJDrKKoez7xrNHS/eYPVoeaMdZipICHB4z5kQlaoNX
 KnLxIeX5sTEQe8MReJl8TBkQ2FIgm9qm/BFnavZSmqRtwyf2g10Fy2z5jgNdXaY8k2QV
 m03CMM6qddCgl90j1hb7if15puuMkgXthFIBT/HkYv6ptoOPbGuvCQK80mb18RmAtXhw
 Vwzup6qvit8vupzOhpWY5jPJfl1LVRfXyc5tq5mY9JLcnPYnrSqPKWPhj7BgnfTxrxXl
 UhP1FE2bTH4FejdtdGxDGf1OavNxnBKkC1pKGBX7br0cr9QyOkMICfRIvbdy6MPrS/B2 FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke057x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:24:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428BKBsm029300;
 Fri, 8 Mar 2024 11:24:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke04r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:24:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428AQ3Cq010913; Fri, 8 Mar 2024 11:20:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52ukeb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKi1P33947930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 292BE2004D;
 Fri,  8 Mar 2024 11:20:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6902C20043;
 Fri,  8 Mar 2024 11:20:41 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 04/14] spapr: nested: keep nested-hv related code
 restricted to its API.
Date: Fri,  8 Mar 2024 16:49:30 +0530
Message-Id: <20240308111940.1617660-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fiu1gJZ-Sjnara3Uns2krIuwtUpWJWcF
X-Proofpoint-ORIG-GUID: peWS3iGudkKmWCTW9gN6ap8OV0x6uCzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=819 phishscore=0 mlxscore=0
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

spapr_exit_nested and spapr_get_pate_nested_hv contains code which
is specific to nested-hv API. Isolating code flows based on API
helps extending it to be used with different API as well.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr_nested.h |  3 +++
 hw/ppc/spapr.c                |  6 +++++-
 hw/ppc/spapr_nested.c         | 25 ++++++++++++++++++++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 2488ea98da..bf3a7b8d89 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -5,6 +5,8 @@
 
 typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
+    uint8_t api;
+#define NESTED_API_KVM_HV  1
 } SpaprMachineStateNested;
 
 /*
@@ -103,4 +105,5 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
+uint8_t spapr_nested_api(SpaprMachineState *spapr);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 65d766b898..a08ffe55b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1376,7 +1376,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         entry->dw1 = spapr->patb_entry;
         return true;
     } else {
-        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        assert(spapr_nested_api(spapr));
+        if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+            return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        }
+        return false;
     }
 }
 
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index c2a33fc3a9..12fdbe2aba 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -11,11 +11,19 @@
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
     if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
+        spapr->nested.api = NESTED_API_KVM_HV;
         spapr_unregister_nested_hv();
         spapr_register_nested_hv();
+    } else {
+        spapr->nested.api = 0;
     }
 }
 
+uint8_t spapr_nested_api(SpaprMachineState *spapr)
+{
+    return spapr->nested.api;
+}
+
 #ifdef CONFIG_TCG
 
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
@@ -310,7 +318,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     return env->gpr[3];
 }
 
-void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
@@ -322,8 +330,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
-    assert(spapr_cpu->in_nested);
-
     nested_save_state(&l2_state, cpu);
     hsrr0 = env->spr[SPR_HSRR0];
     hsrr1 = env->spr[SPR_HSRR1];
@@ -413,6 +419,19 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
+void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    assert(spapr_cpu->in_nested);
+    if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+        spapr_exit_nested_hv(cpu, excp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
-- 
2.39.3


