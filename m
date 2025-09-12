Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EF1CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6xZ-00021H-JS; Fri, 12 Sep 2025 12:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6xL-0001kH-22; Fri, 12 Sep 2025 12:49:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6xC-0008Ix-IA; Fri, 12 Sep 2025 12:49:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBWgbZ026794;
 Fri, 12 Sep 2025 16:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=a4UPOHlVa43psFFKt
 z4HnxPuE4ZCZXXiD4xjzzVNAwI=; b=eAiBaAmlf0XKZwdEzO0jmdXBxOJAyq7zN
 x3UnK5ueR+U+uJbGrtzfOIIPiIlEcVjPI1e1z3gmJZoFcmCuORX4ozjv4OpIkWVH
 miWkxjFrqnE9iZIKIuFj0QoOMfIaobBQblqHTU+dWqIdYRpqRK+QoWuz+QWs12zH
 Ss9DNgfKBf+w+WPx6YG15JJUE0crAdDMAGKmM7eAgfYgnDGxSLzt8eT9o6GBPrWX
 5l0U9BBWv15rCn7cj7me5hoz3ufS3hZT+EKQ5RiYiyRDXTTHSYPqmZqFCXeAezHO
 YpMfOD6A/7QStbnkxC9tRkMCXnoiebEkmZeTW5eZECsqZ6DxexOaQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bctbbug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58CGmpma019131;
 Fri, 12 Sep 2025 16:48:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bctbbuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CDGNpc011443;
 Fri, 12 Sep 2025 16:48:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uv5mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58CGmmoE38142478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 16:48:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BBC75805E;
 Fri, 12 Sep 2025 16:48:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01CF858063;
 Fri, 12 Sep 2025 16:48:48 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Sep 2025 16:48:47 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v4 3/9] target/ppc: IBM PPE42 exception flags and regs
Date: Fri, 12 Sep 2025 11:47:31 -0500
Message-ID: <20250912164808.371944-4-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912164808.371944-1-milesg@linux.ibm.com>
References: <20250912164808.371944-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfXywb1YBYfLbjL
 IeE9z69Ek5UbLUzZcilsqzbv83RY0ENWqpBSAYivuumil58TMEgtZkAxwIAAEolpHtMEJx8aTkA
 BLHLejrYIIcTS9uq6mLK0JfnWzpLC5KvEyyjZWM6jKW4aL1Wjlm4GqnPHZDBRsqoYWnzoGRPiQM
 x6hkEFHp/Zp0285SBrg7cZRNIA7dCthk1x9+naR4lUhZZ8qCK9Z4DlL4ZDVDpEpb2J+kiWaxptT
 t1eY9Cd1YTkPPG6UqZ2XFp+RED9xAuVF9Lp1npo8t3OV6ZmhXWTuox/dSBQKEUXj2W2b1i138WY
 LZZbf84XEjQNf8XZ0mCFtbUxUlY7OR0DNoVUxBv5ItsXT0VZcGvr14Q3d6foMozC+x8FSGXYXXH
 EK7Y9Sb/
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c44ef3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=kP3OWSx2Bt75d2xkwRIA:9
X-Proofpoint-GUID: 8UIiwkAuMudlaR8E37hCyJ7Co5lLBqqE
X-Proofpoint-ORIG-GUID: RE_z2J81yRVOqjfqs2Dx_vxdhoG72gId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduces flags and register definitions needed
for the IBM PPE42 exception model.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
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
2.43.0


