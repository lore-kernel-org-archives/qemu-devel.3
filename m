Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB85C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90Ky-0000i7-HX; Mon, 20 May 2024 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90Kx-0000hO-9V; Mon, 20 May 2024 06:33:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90Kv-0008VA-HG; Mon, 20 May 2024 06:33:46 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44KAUx6U001291; Mon, 20 May 2024 10:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HjqK2NAGi9XWKEgUhbZl8ayDln1Jdj+CNjARTqU5kCo=;
 b=Dmqn1+FFJgW9eAsCroQLVDdJhg5Qhb2eaXiL3aqGwZASX8bRExZTYAcYSC6PL7DCL4Bc
 hKRSntQ7O24OL/RYKb6KYMwrQcxL8Z5ar6fm21TDfSvHYycK8+7f7kVK4wPAu9SG9FF5
 OlFHq43XrnEcelhv7tFkl0p6zTAupCAyjjAjIl/gfU4Z3b5pRaP90GTEC2BJuzBwpRYv
 vpBElog4tF8pflTEHO1cuJAtnU6KsZU+smYfcV2flcDVJ3DaLyllgXZUW/8/1a6o8Pn4
 F4FkG1fdMuZIp6wJ/tQKxUhHtvATqFCtK3kFfJeXMP78zPvqiMJO/3EXeeGVrPNgeddX sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y82k58a8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:43 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KAXh76006717;
 Mon, 20 May 2024 10:33:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y82k58a8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K9cnXx023485; Mon, 20 May 2024 10:33:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77nny83q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44KAXcTT52167142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 10:33:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87BBC20076;
 Mon, 20 May 2024 10:33:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4760120040;
 Mon, 20 May 2024 10:33:37 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.195.33.101]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 May 2024 10:33:37 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/ppc: optimize hreg_compute_pmu_hflags_value
Date: Mon, 20 May 2024 16:03:25 +0530
Message-Id: <20240520103329.381158-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240520103329.381158-1-harshpb@linux.ibm.com>
References: <20240520103329.381158-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IAHv8jm-KbRJ07_Pez8VygllLfOgoPg6
X-Proofpoint-ORIG-GUID: 6NvQfNilhiwHnRn1DuVUm5pb2LsYDEbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 mlxlogscore=399 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405200087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cache env->spr[SPR_POWER_MMCR0] in a local variable as used in multiple
conditions to avoid multiple indirect accesses.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/helper_regs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 945fa1a596..5de0df5795 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -50,15 +50,16 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
 static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 {
     uint32_t hflags = 0;
-
 #if defined(TARGET_PPC64)
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC0) {
+    target_ulong spr_power_mmcr0 = env->spr[SPR_POWER_MMCR0];
+
+    if (spr_power_mmcr0 & MMCR0_PMCC0) {
         hflags |= 1 << HFLAGS_PMCC0;
     }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC1) {
+    if (spr_power_mmcr0 & MMCR0_PMCC1) {
         hflags |= 1 << HFLAGS_PMCC1;
     }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
+    if (spr_power_mmcr0 & MMCR0_PMCjCE) {
         hflags |= 1 << HFLAGS_PMCJCE;
     }
 
-- 
2.39.3


