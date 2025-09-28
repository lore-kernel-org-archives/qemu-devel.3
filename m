Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C43CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3B-0002hv-Ns; Sun, 28 Sep 2025 15:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x37-0002d7-1F
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x2z-00043b-L3
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:07 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S9kdvh001262
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lwjPqrlF/w9p2p3on
 4FsRc5lA4ANhgT44ZxaWNt2+b0=; b=ZbPx0AWf0oC6Q4IKXZDNKURJkDLDhLoii
 ppBdrMXCiFsWKh0dZwGicNoOAjh3OQocBIRGGBnWG3tXQN+V+eYJhGn7U0AOV+vB
 /f91tD/mf6EsgHEn+qPsNb4Yhbvk07l/1aw6ukGaczEXEy4gfBk8+6jX1idOsISc
 QO5bJblypuNsx3an0feI9I4WBkeO+UO5NGelRXDmmm+rSAuRfpT1IwXGvBeooCBr
 wPUwNEfKqLZBnJrbDIbDnb0EvwHbPvZadCu3hURGllgvO31t7HCTEYMZrAtsKBcb
 lRHw7COtu0dNgJQzgdb58YhDyUR4NAORByBvhTKIgLDLJg5XKkcTw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqevdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SHPLCt003599
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxk008-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQsNK47972708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:26:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F75020049;
 Sun, 28 Sep 2025 19:26:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B2DC20040;
 Sun, 28 Sep 2025 19:26:53 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 11/27] target/ppc: IBM PPE42 exception flags and regs
Date: Mon, 29 Sep 2025 00:56:13 +0530
Message-ID: <20250928192629.139822-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX5XRnm5NAWhPo
 Yr6M7/vKaDWcAe9rlLcUmZEWRO5zsqtGIFSrtmPDJfncuJ0eqImXrc6NlO3Vn3B2UuMFbxw6pYc
 JSIXNpxllCUcWwAe7h4V+uQUd0ndeUltMI+JS6iJWqMrbR83aeLXeTFGQmsduq4kgR+FuA2TDii
 v4JcrntfjUAWGA5mwaJxuu9mqPyodxSCIlaM8OzqxN9VeAzfTe8SnF5EVmJc7wX0RJsA/9JCTe7
 Kepa+agkqBhBrGqd6gj6CUtoX3aQjK4cHhsyp5eDBSO9W1TsBQnrcGUKykpKUJmjiHbouDrbE5f
 eYyy+DSDEejzaOM20HfbgDi496Zz/VAb0zzKEjyZWZAdtitt14gpRq1ytx26XBuZYEHMzwm4Tpy
 8Uij4M6UfAAwC/HtLCwl6VHWMl2VrQ==
X-Proofpoint-GUID: qNOOgmB9cV95nSEqOz_hR_O79AjObnqI
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68d98c02 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=kP3OWSx2Bt75d2xkwRIA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: qNOOgmB9cV95nSEqOz_hR_O79AjObnqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Glenn Miles <milesg@linux.ibm.com>

Introduces flags and register definitions needed
for the IBM PPE42 exception model.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925201758.652077-4-milesg@linux.ibm.com
Message-ID: <20250925201758.652077-4-milesg@linux.ibm.com>
---
 target/ppc/cpu.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8e13ce41a9..787020f6f9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -220,6 +220,8 @@ typedef enum powerpc_excp_t {
     POWERPC_EXCP_POWER10,
     /* POWER11 exception model           */
     POWERPC_EXCP_POWER11,
+    /* PPE42 exception model            */
+    POWERPC_EXCP_PPE42,
 } powerpc_excp_t;
 
 /*****************************************************************************/
@@ -760,6 +762,31 @@ FIELD(MSR, SIBRCA, MSR_SIBRCA7, 8)
 #define ESR_VLEMI PPC_BIT(58) /* VLE operation                          */
 #define ESR_MIF   PPC_BIT(62) /* Misaligned instruction (VLE)           */
 
+/* PPE42 Interrupt Status Register bits */
+#define PPE42_ISR_SRSMS0  PPC_BIT_NR(48) /* Sys Reset State Machine State 0   */
+#define PPE42_ISR_SRSMS1  PPC_BIT_NR(49) /* Sys Reset State Machine State 1   */
+#define PPE42_ISR_SRSMS2  PPC_BIT_NR(50) /* Sys Reset State Machine State 2   */
+#define PPE42_ISR_SRSMS3  PPC_BIT_NR(51) /* Sys Reset State Machine State 3   */
+#define PPE42_ISR_EP      PPC_BIT_NR(53) /* MSR[EE] Maskable Event Pending    */
+#define PPE42_ISR_PTR     PPC_BIT_NR(56) /* Program Interrupt from trap       */
+#define PPE42_ISR_ST      PPC_BIT_NR(57) /* Data Interrupt caused by store    */
+#define PPE42_ISR_MFE     PPC_BIT_NR(60) /* Multiple Fault Error              */
+#define PPE42_ISR_MCS0    PPC_BIT_NR(61) /* Machine Check Status bit0         */
+#define PPE42_ISR_MCS1    PPC_BIT_NR(62) /* Machine Check Status bit1         */
+#define PPE42_ISR_MCS2    PPC_BIT_NR(63) /* Machine Check Status bit2         */
+FIELD(PPE42_ISR, SRSMS, PPE42_ISR_SRSMS3, 4)
+FIELD(PPE42_ISR, MCS, PPE42_ISR_MCS2, 3)
+
+/* PPE42 Machine Check Status field values */
+#define PPE42_ISR_MCS_INSTRUCTION             0
+#define PPE42_ISR_MCS_DATA_LOAD               1
+#define PPE42_ISR_MCS_DATA_PRECISE_STORE      2
+#define PPE42_ISR_MCS_DATA_IMPRECISE_STORE    3
+#define PPE42_ISR_MCS_PROGRAM                 4
+#define PPE42_ISR_MCS_ISI                     5
+#define PPE42_ISR_MCS_ALIGNMENT               6
+#define PPE42_ISR_MCS_DSI                     7
+
 /* Transaction EXception And Summary Register bits                           */
 #define TEXASR_FAILURE_PERSISTENT                (63 - 7)
 #define TEXASR_DISALLOWED                        (63 - 8)
-- 
2.43.5


