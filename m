Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DB3C54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYI0-00049H-2v; Fri, 08 Mar 2024 06:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYHu-00048b-QJ; Fri, 08 Mar 2024 06:21:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYHs-0003wP-E1; Fri, 08 Mar 2024 06:21:18 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428BC5Uk007102; Fri, 8 Mar 2024 11:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AQ4gjAtM/29LJ0e8EwmnH75TL7iMseZmbY5IXm/kxpM=;
 b=HDXSvTgmhXyrvqonhNHSzGQ0QFkZmg8lmsD1mOgPxzjM468ayRKvR3WGdSfQ0Fpg0DTR
 mhuEyKWfIE7/yPx/udlgYQvd8gEe/skrsedfdmuOst4a8htyI37fhY+QK781z8aNZEPz
 XXid1kvMsulPJPzVALKo2u4o/CSpJ7fEY6uzlCBqTk9Jo4lJcY5qhhN8kM1Gp+wDGA5f
 BgyjMx+nOP68hw2n2vJSMEZVQ2TUOtKBUue3jyVUhzAJ87ZRxWqpCoIH6A0hYt5LIN2f
 mBbDr0Re4eRrz4FDE2PIKebzn2xy7tUTY9P5RQMxRxC4bpcdAmh1ELEyGvPCOvgTl03/ fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke04pq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:44 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428BG8d4017158;
 Fri, 8 Mar 2024 11:20:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ke04pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428A84GQ024193; Fri, 8 Mar 2024 11:20:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsqahj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKbTC40829196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FA9820040;
 Fri,  8 Mar 2024 11:20:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7A9D2004B;
 Fri,  8 Mar 2024 11:20:34 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:34 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 02/14] spapr: nested: move nested part of spapr_get_pate
 into spapr_nested.c
Date: Fri,  8 Mar 2024 16:49:28 +0530
Message-Id: <20240308111940.1617660-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qvWPfygghQofnV3lmSOU3BOeIxBWYpf3
X-Proofpoint-ORIG-GUID: IJPikfLF2OB_AMAHf2CXFA-Vw0DFK4-A
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

Most of the nested code has already been moved to spapr_nested.c
This logic inside spapr_get_pate is related to nested guests and
better suited for spapr_nested.c, hence moving there.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr_nested.h |  3 ++-
 hw/ppc/spapr.c                | 28 ++-------------------------
 hw/ppc/spapr_nested.c         | 36 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 09d95182b2..1df1ce14f6 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -96,5 +96,6 @@ struct nested_ppc_state {
 };
 
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
-
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d3c740c5b..65d766b898 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1362,7 +1362,6 @@ void spapr_init_all_lpcrs(target_ulong value, target_ulong mask)
     }
 }
 
-
 static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
@@ -1375,33 +1374,10 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         /* Copy PATE1:GR into PATE0:HR */
         entry->dw0 = spapr->patb_entry & PATE0_HR;
         entry->dw1 = spapr->patb_entry;
-
+        return true;
     } else {
-        uint64_t patb, pats;
-
-        assert(lpid != 0);
-
-        patb = spapr->nested_ptcr & PTCR_PATB;
-        pats = spapr->nested_ptcr & PTCR_PATS;
-
-        /* Check if partition table is properly aligned */
-        if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
-            return false;
-        }
-
-        /* Calculate number of entries */
-        pats = 1ull << (pats + 12 - 4);
-        if (pats <= lpid) {
-            return false;
-        }
-
-        /* Grab entry */
-        patb += 16 * lpid;
-        entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
-        entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
     }
-
-    return true;
 }
 
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 8e0ee0d22f..f7888ca8bd 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -6,6 +6,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
+#include "mmu-book3s-v3.h"
 
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
@@ -16,6 +17,35 @@ void spapr_nested_reset(SpaprMachineState *spapr)
 }
 
 #ifdef CONFIG_TCG
+
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    uint64_t patb, pats;
+
+    assert(lpid != 0);
+
+    patb = spapr->nested_ptcr & PTCR_PATB;
+    pats = spapr->nested_ptcr & PTCR_PATS;
+
+    /* Check if partition table is properly aligned */
+    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
+        return false;
+    }
+
+    /* Calculate number of entries */
+    pats = 1ull << (pats + 12 - 4);
+    if (pats <= lpid) {
+        return false;
+    }
+
+    /* Grab entry */
+    patb += 16 * lpid;
+    entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
+    entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+    return true;
+}
+
 #define PRTS_MASK      0x1f
 
 static target_ulong h_set_ptbl(PowerPCCPU *cpu,
@@ -413,4 +443,10 @@ void spapr_unregister_nested_hv(void)
 {
     /* DO NOTHING */
 }
+
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    return false;
+}
 #endif
-- 
2.39.3


