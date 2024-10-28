Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CEFD13570
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 09:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5LrD-000665-Vj; Mon, 28 Oct 2024 05:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1t5LrC-00065c-Gw; Mon, 28 Oct 2024 05:16:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1t5LrA-0006Dx-KX; Mon, 28 Oct 2024 05:16:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S4WcKh014824;
 Mon, 28 Oct 2024 09:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=US5bFQgBmGn4kfWluInv+VpA5egg1XHmMAMzGm18X
 LE=; b=ovunFy5iMleJ7S5XyP2HdOoWSG/i5IIFmxyq52nSfIv79xOpa6Ur0U+ao
 gK8RBcklROVpJpia/ZR2z26xlCvpx91qzZI93gUBOhFcoOSbLIuFu6c/LouZrJ+i
 W3v6zFrmkvJDuYGaoEil+i8QVHSfjTzW7ltkGCWeSrFpHj7Toa3GtxcgIySu6Rqc
 sjE3bpcudXwjxK71u6YPNFu2Dm3hROd4fpiJHbNs+nu80XXLqyfca1T4T8n8oxG8
 LGuc7kG+pxY90KeNZ8nxsfYwdfs+gwAEu3aCRxJbhTkCaPq3eXiLJfKc0WwOxKaw
 P2RB2gcEVGgqz9dKzdQz7wwJOh5xg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nshdcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Oct 2024 09:16:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49S9G23L026367;
 Mon, 28 Oct 2024 09:16:02 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nshdcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Oct 2024 09:16:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49S52OP1015831;
 Mon, 28 Oct 2024 09:16:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hdf155f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Oct 2024 09:16:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49S9FvKl15270270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Oct 2024 09:15:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9F702033E;
 Mon, 28 Oct 2024 09:15:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E9402034C;
 Mon, 28 Oct 2024 09:15:47 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com.com (unknown
 [9.39.17.130]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Oct 2024 09:15:47 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH] spapr: nested: Add Power11 capability support for Nested PAPR
 guests in TCG L0
Date: Mon, 28 Oct 2024 14:45:36 +0530
Message-ID: <20241028091536.600913-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uvwQBfUsbYy0kL3D8VjfUXwAja-5zmoa
X-Proofpoint-GUID: _8ThbooamAo6pPICOhcILlK7lS9UIjlL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280073
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Power11 architected and raw mode support in Linux was merged via [1]
and the corresponding support in QEMU is waiting to be added by [2]
which in V6 currently.

Add the Power11 capabilities and the required handling in TCG L0
implementation of the "Nested PAPR API".

Note: This patch is based on [2].

[1] https://lore.kernel.org/all/20240221044623.1598642-1-mpe@ellerman.id.au/
[2] https://lore.kernel.org/all/20240731055022.696051-1-adityag@linux.ibm.com/

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/ppc/spapr_nested.c         | 12 +++++++++++-
 include/hw/ppc/spapr_nested.h |  5 ++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index c02785756c1e..066d40e3c1b7 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -771,6 +771,7 @@ static void copy_logical_pvr(void *a, void *b, bool set)
 
     if (*pvr_logical_ptr) {
         switch (*pvr_logical_ptr) {
+        case CPU_POWERPC_LOGICAL_3_10_P11:
         case CPU_POWERPC_LOGICAL_3_10:
             pcr = PCR_COMPAT_3_10 | PCR_COMPAT_3_00;
             break;
@@ -1184,6 +1185,12 @@ static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
+    /* P11 capabilities */
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10_P11, 0,
+        spapr->max_compat_pvr)) {
+        env->gpr[4] |= H_GUEST_CAPABILITIES_P11_MODE;
+    }
+
     /* P10 capabilities */
     if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
         spapr->max_compat_pvr)) {
@@ -1226,7 +1233,10 @@ static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
         env->gpr[4] = 1;
 
         /* set R5 to the first supported Power Processor Mode */
-        if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
+        if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10_P11, 0,
+                             spapr->max_compat_pvr)) {
+            env->gpr[5] = H_GUEST_CAP_P11_MODE_BMAP;
+        } else if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
                              spapr->max_compat_pvr)) {
             env->gpr[5] = H_GUEST_CAP_P10_MODE_BMAP;
         } else if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 93ef14adcc5e..24531c3fd2e9 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -210,11 +210,14 @@ typedef struct SpaprMachineStateNestedGuest {
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
 #define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
-#define H_GUEST_CAP_VALID_MASK        (H_GUEST_CAPABILITIES_P10_MODE | \
+#define H_GUEST_CAPABILITIES_P11_MODE 0x1000000000000000
+#define H_GUEST_CAP_VALID_MASK        (H_GUEST_CAPABILITIES_P11_MODE | \
+                                       H_GUEST_CAPABILITIES_P10_MODE | \
                                        H_GUEST_CAPABILITIES_P9_MODE)
 #define H_GUEST_CAP_COPY_MEM_BMAP     0
 #define H_GUEST_CAP_P9_MODE_BMAP      1
 #define H_GUEST_CAP_P10_MODE_BMAP     2
+#define H_GUEST_CAP_P11_MODE_BMAP     3
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
 #define PAPR_NESTED_GUEST_VCPU_MAX    2048

-- 
2.47.0


