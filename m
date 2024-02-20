Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C149FC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLcF-00030r-Gd; Tue, 20 Feb 2024 03:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcE-0002yt-9T; Tue, 20 Feb 2024 03:36:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcB-00054S-GN; Tue, 20 Feb 2024 03:36:37 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8Pqd9032054; Tue, 20 Feb 2024 08:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iuC9bGUQvgHWePDIGVhAI+TtmxrTGZpH+PUSMol64HE=;
 b=RtF93tbK0VPKovYOAtCrnCMPQhXALKOkzbOi7H25mE8yGcG2WcYQC6MbxqBIT7kKgmA0
 KiIn4hxB4kXTnyIMbUd141/AvDa8PvOP2cyLrv0g+d4vpIjNexjYc8eVnytXrS+oC3WH
 B9wHxSpUmx0/x831EtdeFRX8jhwB/BwfTDU7XKJw+b3MO6McunGPYJUFXFVht0V6H6sz
 H4RJZz51HLgJ2NVkvRJVlSwNw8Zvu72gk7lrDjOpAtiQK4gRrcYrRqWciyp9wa4S2kt9
 m/72TGSVea7aqcpoqhS1yHU9jYluGZdyedD7Z4C/TKEZkyPw1i0g3/0t3Aui7oRvP1Q8 xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcqsd97ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:30 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8PoKZ031773;
 Tue, 20 Feb 2024 08:36:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcqsd97a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K5bYLQ009547; Tue, 20 Feb 2024 08:36:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p6xbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8aM6V20513486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53AB920040;
 Tue, 20 Feb 2024 08:36:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC90220043;
 Tue, 20 Feb 2024 08:36:20 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:20 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 02/15] spapr: nested: move nested part of spapr_get_pate
 into spapr_nested.c
Date: Tue, 20 Feb 2024 14:05:56 +0530
Message-Id: <20240220083609.748325-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x7jidl9ZptJNPCcV3o-6WOG3PKUfHaYV
X-Proofpoint-ORIG-GUID: 1rWeAYZ1IwUh-jvOjUMXMkn4i_mCOp4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
index 0d72d286d8..97b69c0e42 100644
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
index a071092eff..b38e2d0be5 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -6,8 +6,38 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
+#include "mmu-book3s-v3.h"
 
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
@@ -405,4 +435,10 @@ void spapr_unregister_nested_hv(void)
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


