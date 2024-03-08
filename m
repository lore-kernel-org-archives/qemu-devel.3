Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F57C54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYJa-0007Qc-Re; Fri, 08 Mar 2024 06:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYJX-0007Eh-RF; Fri, 08 Mar 2024 06:22:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYJW-0003w0-4v; Fri, 08 Mar 2024 06:22:59 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428B2s8s000906; Fri, 8 Mar 2024 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tXaNVJKE0RPvF3m5WKE+JNKuFzH6MrZCQ1X2ucMYMQY=;
 b=UZNLtdsk28y5q4jazaTDxjZzXo+iynOrb/wC5AbNlVfrotLZmXCRIm9K68RmQt6yO82J
 cH5yDmlQjWHxLoQPY2m11ESvKYpiYjYQfTBptQaJyKpDOV28e1lUpoZQm5uqszD1sZvd
 j9CvEH0Fj1anWLAZmOSE5A+OYOYXnbq7cXu5cyaMqWOFFF/7P22NQJ8nIfnvoOhIct9E
 Lz0nVRkUj/4ZP+kucsqJP+gFOPqP+OJb/N9JWqO3m1CDTVVHdFJ9TIaYIDvq9Gg/tAl/
 qsA5v7q3S4763yhiYYVZwn5R2kzIkIqIsuWptCGCj6hTH4wTgIuS8SD1LpKOnYK/auPK 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1f3g8yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:47 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428B4JQn003762;
 Fri, 8 Mar 2024 11:20:47 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1f3g8ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4289fgtO031560; Fri, 8 Mar 2024 11:20:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnkkq05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKfPX42336704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07F8220040;
 Fri,  8 Mar 2024 11:20:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCBBD20043;
 Fri,  8 Mar 2024 11:20:37 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:37 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 03/14] spapr: nested: Introduce SpaprMachineStateNested to
 store related info.
Date: Fri,  8 Mar 2024 16:49:29 +0530
Message-Id: <20240308111940.1617660-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GhL3pLRY4OAIod3p_-yCnSE2TAXv_o5C
X-Proofpoint-GUID: riMQC7VDZlnmoGCr6l_DLpIgo9Z-kVeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Currently, nested_ptcr is being used by existing nested-hv API to store
nested guest related info. This need to be organised to extend support
for the nested PAPR API which would need to store additional info
related to nested guests in next series of patches.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h        | 3 ++-
 include/hw/ppc/spapr_nested.h | 5 +++++
 hw/ppc/spapr_nested.c         | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 78a736297b..0eb01ea6fd 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -12,6 +12,7 @@
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/ppc/spapr_nested.h" /* For SpaprMachineStateNested */
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -213,7 +214,7 @@ struct SpaprMachineState {
     uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
 
     /* Nested HV support (TCG only) */
-    uint64_t nested_ptcr;
+    SpaprMachineStateNested nested;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 1df1ce14f6..2488ea98da 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -3,6 +3,10 @@
 
 #include "target/ppc/cpu.h"
 
+typedef struct SpaprMachineStateNested {
+    uint64_t ptcr;
+} SpaprMachineStateNested;
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
@@ -96,6 +100,7 @@ struct nested_ppc_state {
 };
 
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
+typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index f7888ca8bd..c2a33fc3a9 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -25,8 +25,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 
     assert(lpid != 0);
 
-    patb = spapr->nested_ptcr & PTCR_PATB;
-    pats = spapr->nested_ptcr & PTCR_PATS;
+    patb = spapr->nested.ptcr & PTCR_PATB;
+    pats = spapr->nested.ptcr & PTCR_PATS;
 
     /* Check if partition table is properly aligned */
     if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
@@ -63,7 +63,7 @@ static target_ulong h_set_ptbl(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    spapr->nested_ptcr = ptcr; /* Save new partition table */
+    spapr->nested.ptcr = ptcr; /* Save new partition table */
 
     return H_SUCCESS;
 }
@@ -195,7 +195,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
-    if (spapr->nested_ptcr == 0) {
+    if (spapr->nested.ptcr == 0) {
         return H_NOT_AVAILABLE;
     }
 
-- 
2.39.3


