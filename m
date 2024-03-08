Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA70C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYI8-0004Bp-Fj; Fri, 08 Mar 2024 06:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYI0-00049l-8L; Fri, 08 Mar 2024 06:21:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYHx-00040B-2k; Fri, 08 Mar 2024 06:21:23 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428Av52L020148; Fri, 8 Mar 2024 11:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=huUmj5wBJpVQH0RQL1i4TqvvjoAJrmQrKxCJ7TKQ0Q0=;
 b=MpNit9gMQhIFeNKtZ2om6XknTVs3HeJzF9H2kbL5Qgs5jpmP7MhenhtDwxuwhWXLE/wV
 VM49jcNNGAY29wXGv6wnXhIOHS8TijAEj2ev+l7wFm7pmxtH1rgzYm8IL7glSloHM4DM
 /hbqk2KrVSYp1QtGTDpXarmIbdAKrrbmn0dUKDcyWwRzYnl8kC+Ak+GXeronZAE2pOeo
 ZWPan84hN6Sq5QQlcS1Y3pAp0lZU2wKSolIjWU2QG17hYkI/NuwykzRR5RRa35G7p7Pd
 PY2YyAap840wH9hEy4lWvSEIjTPunght5STC7qNe7OfFFRftCMtYxb9tfbqcivB5n4cE cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1c00cs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:15 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428BHHKN013039;
 Fri, 8 Mar 2024 11:21:15 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1c00cs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428AQ3Ct010913; Fri, 8 Mar 2024 11:21:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52ukg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BL9Jb39977394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:21:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D6F62004B;
 Fri,  8 Mar 2024 11:21:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85C4120043;
 Fri,  8 Mar 2024 11:21:06 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:21:06 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 12/14] spapr: nested: Use correct source for parttbl info
 for nested PAPR API.
Date: Fri,  8 Mar 2024 16:49:38 +0530
Message-Id: <20240308111940.1617660-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -6IrBTjn4lZgPqiDloIeVoGR0yTXuwGu
X-Proofpoint-GUID: nn7GOhr5KIZ_zgh0O-nJEXhE_tgXl3nF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=949
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
partition table info, use the same in spapr_get_pate_nested() via
helper.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_nested.h |  4 ++++
 hw/ppc/spapr.c                |  6 ++++--
 hw/ppc/spapr_nested.c         | 22 +++++++++++++++++++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index bd43c6b6ef..152019fe3d 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -518,4 +518,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
 uint8_t spapr_nested_api(SpaprMachineState *spapr);
 void spapr_nested_gsb_init(void);
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry);
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong lpid);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a08ffe55b6..54fc01e462 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1376,11 +1376,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         entry->dw1 = spapr->patb_entry;
         return true;
     } else {
-        assert(spapr_nested_api(spapr));
         if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
             return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        } else if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
+        } else {
+            g_assert_not_reached();
         }
-        return false;
     }
 }
 
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index ca99805ce8..e0b234c786 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -58,6 +58,21 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return true;
 }
 
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    SpaprMachineStateNestedGuest *guest;
+    assert(lpid != 0);
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return false;
+    }
+
+    entry->dw0 = guest->parttbl[0];
+    entry->dw1 = guest->parttbl[1];
+    return true;
+}
+
 #define PRTS_MASK      0x1f
 
 static target_ulong h_set_ptbl(PowerPCCPU *cpu,
@@ -540,7 +555,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
-static
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong guestid)
 {
@@ -1585,6 +1599,12 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return false;
 }
 
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    return false;
+}
+
 void spapr_register_nested_papr(void)
 {
     /* DO NOTHING */
-- 
2.39.3


