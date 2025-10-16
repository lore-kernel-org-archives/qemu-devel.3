Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC41FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Rvh-00065r-9o; Thu, 16 Oct 2025 13:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9Rvd-00064S-Fn; Thu, 16 Oct 2025 13:38:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9RvX-0007Z0-17; Thu, 16 Oct 2025 13:38:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA9PdO012327;
 Thu, 16 Oct 2025 17:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9rvFSmHMAkvScnZS5
 dX2UIVUaQR0GC7MotewYetAUc4=; b=K56rCZchtb7DxjsyH4+GKjzMLp+ANtb7Z
 gtSWEzL/x7wquauXeaAhHiymYS6G3f1c+/vgR7OeQuzxxQ2L4czXLp1PnStXWvG9
 6SSvEvhFcoVeBpRY8tUff6sg2F7PSRz+/SPosvGDS3fnPgiIZbflkK5ql8cGa1lb
 r3oCciq3yxWfWzUw5o93o5UAz7RWX08Y7l4tZf70XPhm3qzjF1jdngGpwEeqXsTL
 JdaIo+JDPwsuJ/2TpaJUD05G72yMHvQW4DPz/9JFWszHmSe7pJmaZV8vgm3H/bTX
 aSdlBe09EvwaPKx+jfTaP1c0e3Xe6AL1q2nOvZb7Jt8Qc7n/zsawA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrkde0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:38:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GHX0OM022682;
 Thu, 16 Oct 2025 17:38:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrkddw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:38:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GH3Ug9018823;
 Thu, 16 Oct 2025 17:38:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmy2fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:38:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GHbvCw50135530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 17:37:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8294200E1;
 Thu, 16 Oct 2025 17:37:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A5E5200DA;
 Thu, 16 Oct 2025 17:37:55 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.26.252])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 17:37:55 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 4/5] hw/ppc/spapr: Rename resize_hpt_err to errp
Date: Thu, 16 Oct 2025 23:05:02 +0530
Message-ID: <20251016173502.1261674-7-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016173502.1261674-1-vishalc@linux.ibm.com>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f12d7b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=YPwFAxgEYmRXNWQnHQUA:9
X-Proofpoint-GUID: o4XGUs-uGKvFS8FrMoynaBeZMqkDvIS_
X-Proofpoint-ORIG-GUID: oqVAUWrM1s1RcmaZZSQRxE_c8-TSlOuq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX6ALtcseWUcqA
 3AmkLdtNNOADWXhcZxt0bw4nc0lYMRNYnRwVZF4Gl2ePYLt4OLyMK+rl4GYQJ4xv6AWgi1FArmy
 a9+zwOGFbBytvhLpTx+0cNlKi28sZTTKrqsEts6qmTsWGkuVEaGicd96kofjbJABwUP7bOPRL6a
 Xi9kkKueFmQDV6DCBiX1pQjhazuXayzkf6ZKeTfozsol8LCSHnzLQ3aNjeiIdzhnIeFCSE7ZnET
 oUNIYgcYJL624KQM50j2DaO3UzoACa9mEvnQlkTeD+SOsSMYX9LCz7eBnIuCD2gN1SDM1wUW/KO
 kOs/P/pYmc355rSyp0cdHlrxtxYMxE0C3t2iSD574uPlRI4aWf5E3Pq/9npZRgutoboIPHApUKm
 BlNRrmESdrAer104EEr5bC5f9XEapQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Rename resize_hpt_err to standard errp naming convention.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/ppc/spapr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c6e9d46761..9e17b5a31d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2817,7 +2817,7 @@ static void spapr_machine_init(MachineState *machine)
     int i;
     MemoryRegion *sysmem = get_system_memory();
     long load_limit, fw_size;
-    Error *resize_hpt_err = NULL;
+    Error *errp = NULL;
     NICInfo *nd;
 
     if (!filename) {
@@ -2845,7 +2845,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Determine capabilities to run with */
     spapr_caps_init(spapr);
 
-    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
+    kvmppc_check_papr_resize_hpt(&errp);
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
         /*
          * If the user explicitly requested a mode we should either
@@ -2853,10 +2853,10 @@ static void spapr_machine_init(MachineState *machine)
          * it's not set explicitly, we reset our mode to something
          * that works
          */
-        if (resize_hpt_err) {
+        if (errp) {
             spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
-            error_free(resize_hpt_err);
-            resize_hpt_err = NULL;
+            error_free(errp);
+            errp = NULL;
         } else {
             spapr->resize_hpt = smc->resize_hpt_default;
         }
@@ -2864,14 +2864,14 @@ static void spapr_machine_init(MachineState *machine)
 
     assert(spapr->resize_hpt != SPAPR_RESIZE_HPT_DEFAULT);
 
-    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && resize_hpt_err) {
+    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && errp) {
         /*
          * User requested HPT resize, but this host can't supply it.  Bail out
          */
-        error_report_err(resize_hpt_err);
+        error_report_err(errp);
         exit(1);
     }
-    error_free(resize_hpt_err);
+    error_free(errp);
 
     spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
 
-- 
2.51.0


