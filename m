Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9690AC54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYJW-00073v-Cg; Fri, 08 Mar 2024 06:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYJQ-0006fT-Da; Fri, 08 Mar 2024 06:22:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYJO-0003uz-LO; Fri, 08 Mar 2024 06:22:52 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428BCCaS007245; Fri, 8 Mar 2024 11:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a8LYDphaLvRzacvkG8suUvMkXZhU2u2pu5SEiHFeqUk=;
 b=ChM9jtQD5HtbbY9jK/oY+6cPq8DvK591NenqZnMBE81M6a73XBtvjBESmh5tCq+Cy4dc
 FwEWHDkTBT4SZjbZM0frwvhH3rd0DF6lTzv0Okd6eIG2RCeChZ0e0Hg4rsUc03I+OZJ+
 i2jAQ0n4gktR8H2mYNDtCAsf1bGbZ88xL/4GnwygvQEeBfUN9yhEQQochtKFwEk2ckBC
 tFEDJrCn7RAsgNujRXdJHrPL6ZimjliE5DtS8TPo4jgWT7GAG/2+CrDoxMrCzp2Lrv8U
 aNTe5THF7xLAs1Z3/mZ/UWH+AxX+9hjXYhR267AdzpDwR7pq6OyxVCEGyba13m/pyrmE Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke04nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:41 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428BEkjn013631;
 Fri, 8 Mar 2024 11:20:40 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke04nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428Amngm006073; Fri, 8 Mar 2024 11:20:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetma8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKYWn42598696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8352E20040;
 Fri,  8 Mar 2024 11:20:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D00320043;
 Fri,  8 Mar 2024 11:20:31 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:30 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 01/14] spapr: nested: register nested-hv api hcalls only
 for cap-nested-hv
Date: Fri,  8 Mar 2024 16:49:27 +0530
Message-Id: <20240308111940.1617660-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5GJ3EZZh28eREbg8X1t4MgA67hyiCvTx
X-Proofpoint-ORIG-GUID: NBM7G1zdr5ZaETxzl04lY00O6MAjBGR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080089
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

Since cap-nested-hv is an optional capability, it makes sense to register
api specfic hcalls only when respective capability is enabled. This
requires to introduce a new API to unregister hypercalls to maintain
sanity across guest reboot since caps are re-applied across reboots and
re-registeration of hypercalls would hit assert otherwise.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h        |  4 ++++
 include/hw/ppc/spapr_nested.h |  1 -
 hw/ppc/spapr.c                |  1 +
 hw/ppc/spapr_hcall.c          | 24 ++++++++++++++++++++++--
 hw/ppc/spapr_nested.c         | 25 +++++++++++++++++++++++--
 5 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5b5ba9ef77..78a736297b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -631,6 +631,7 @@ typedef target_ulong (*spapr_hcall_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                                        target_ulong *args);
 
 void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
+void spapr_unregister_hypercall(target_ulong opcode);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
@@ -1028,5 +1029,8 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt);
 
 /* H_WATCHDOG */
 void spapr_watchdog_init(SpaprMachineState *spapr);
+void spapr_register_nested_hv(void);
+void spapr_unregister_nested_hv(void);
+void spapr_nested_reset(SpaprMachineState *spapr);
 
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55263f0815..0d3c740c5b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1689,6 +1689,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pef_kvm_reset(machine->cgs, &error_fatal);
     spapr_caps_apply(spapr);
+    spapr_nested_reset(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
     if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 75c2d12978..5e1d020e3d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1525,6 +1525,28 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn)
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
@@ -1638,8 +1660,6 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
-
-    spapr_register_nested();
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 121aa96ddc..8e0ee0d22f 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -7,6 +7,14 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
 
+void spapr_nested_reset(SpaprMachineState *spapr)
+{
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
+        spapr_unregister_nested_hv();
+        spapr_register_nested_hv();
+    }
+}
+
 #ifdef CONFIG_TCG
 #define PRTS_MASK      0x1f
 
@@ -375,20 +383,33 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
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


