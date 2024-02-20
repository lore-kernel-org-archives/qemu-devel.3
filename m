Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B387C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLcS-00036t-Fd; Tue, 20 Feb 2024 03:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcL-00032s-H0; Tue, 20 Feb 2024 03:36:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcI-00056J-Mg; Tue, 20 Feb 2024 03:36:44 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8ReOn004899; Tue, 20 Feb 2024 08:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kJMZZwgvgMJrrlxencbv42hirslx3/XTTYi1Ib+Yc0M=;
 b=cKEpywaIUwnxLFzvjyF9LpCZe3O66xE9bUdHDJ3Qn2nHhEukFRAF9yCTaBjWn8w7FRGV
 YyOhRsrHxTwlFyWizOJQ1yAUQqaZQs+GKyVelxFhY9EhvZNKTqGohclqjtH6hOp9VST3
 bqh8UCxfj9Ud0pN4jELRELC508UFcVWXVkpponsgIk5Opn2nvyC66LwxlTzcHXCDs2ym
 U4xMzVH2dt7j6XiTQvjPVooeIkNfpbrYOHqHQYzWPEc7xQiN4oQMczSHyEdth1CQBTJX
 LGIIQxMmXQODLcLvm9mnLCWfO2uM3B+lAPUlMxjGFsBHCCGIkXTfZWANu8zeWQ74LFqt CA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcrk9895d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:37 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8RowT005166;
 Tue, 20 Feb 2024 08:36:37 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcrk9892u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7PYaW014339; Tue, 20 Feb 2024 08:36:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2ee0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8aK5v20447806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64FAE2004F;
 Tue, 20 Feb 2024 08:36:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE70420043;
 Tue, 20 Feb 2024 08:36:18 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:18 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 01/15] spapr: nested: register nested-hv api hcalls only
 for cap-nested-hv
Date: Tue, 20 Feb 2024 14:05:55 +0530
Message-Id: <20240220083609.748325-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _zuscy85mWaRhN1yLGJstF-NmF3ChRNB
X-Proofpoint-ORIG-GUID: sbcG1F0Mgpnl4z1blDRV81j5bExgc34T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=935 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Since cap-nested-hv is an optional capability, it makes sense to register
api specfic hcalls only when respective capability is enabled. This
requires to introduce a new API to unregister hypercalls to maintain
sanity across guest reboot since caps are re-applied across reboots and
re-registeration of hypercalls would hit assert otherwise.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h        |  3 +++
 include/hw/ppc/spapr_nested.h |  1 -
 hw/ppc/spapr_caps.c           |  2 ++
 hw/ppc/spapr_hcall.c          | 24 ++++++++++++++++++++++--
 hw/ppc/spapr_nested.c         | 17 +++++++++++++++--
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e91791a1a9..b7ad2a0360 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -631,6 +631,7 @@ typedef target_ulong (*spapr_hcall_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                                        target_ulong *args);
 
 void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
+void spapr_unregister_hypercall(target_ulong opcode);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
@@ -1025,5 +1026,7 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt);
 
 /* H_WATCHDOG */
 void spapr_watchdog_init(SpaprMachineState *spapr);
+void spapr_register_nested_hv(void);
+void spapr_unregister_nested_hv(void);
 
 #endif /* HW_SPAPR_H */
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index d312a5d61d..09d95182b2 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -95,7 +95,6 @@ struct nested_ppc_state {
     int64_t tb_offset;
 };
 
-void spapr_register_nested(void);
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e889244e52..f0c2f4de78 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -487,6 +487,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
             error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
                                     "or use threads=1 with -smp\n");
         }
+        spapr_unregister_nested_hv(); /* reset across reboots */
+        spapr_register_nested_hv();
     }
 }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index fcefd1d1c7..8dbc2863a8 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1521,6 +1521,28 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn)
     *slot = fn;
 }
 
+void spapr_unregister_hypercall(target_ulong opcode)
+{
+    spapr_hcall_fn *slot;
+
+    if (opcode <= MAX_HCALL_OPCODE) {
+        assert((opcode & 0x3) == 0);
+
+        slot = &papr_hypercall_table[opcode / 4];
+    } else if (opcode >= SVM_HCALL_BASE && opcode <= SVM_HCALL_MAX) {
+        /* we only have SVM-related hcall numbers assigned in multiples of 4 */
+        assert((opcode & 0x3) == 0);
+
+        slot = &svm_hypercall_table[(opcode - SVM_HCALL_BASE) / 4];
+    } else {
+        assert((opcode >= KVMPPC_HCALL_BASE) && (opcode <= KVMPPC_HCALL_MAX));
+
+        slot = &kvmppc_hypercall_table[opcode - KVMPPC_HCALL_BASE];
+    }
+
+    *slot = NULL;
+}
+
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args)
 {
@@ -1634,8 +1656,6 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
-
-    spapr_register_nested();
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 121aa96ddc..a071092eff 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -375,20 +375,33 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
-void spapr_register_nested(void)
+void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
     spapr_register_hypercall(KVMPPC_H_ENTER_NESTED, h_enter_nested);
     spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
     spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
 }
+
+void spapr_unregister_nested_hv(void)
+{
+    spapr_unregister_hypercall(KVMPPC_H_SET_PARTITION_TABLE);
+    spapr_unregister_hypercall(KVMPPC_H_ENTER_NESTED);
+    spapr_unregister_hypercall(KVMPPC_H_TLB_INVALIDATE);
+    spapr_unregister_hypercall(KVMPPC_H_COPY_TOFROM_GUEST);
+}
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
     g_assert_not_reached();
 }
 
-void spapr_register_nested(void)
+void spapr_register_nested_hv(void)
+{
+    /* DO NOTHING */
+}
+
+void spapr_unregister_nested_hv(void)
 {
     /* DO NOTHING */
 }
-- 
2.39.3


