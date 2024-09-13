Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED551EEE27A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxh6-0001f2-Tm; Fri, 13 Sep 2024 00:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh3-0001PF-Ei; Fri, 13 Sep 2024 00:14:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh1-0002Wf-Vl; Fri, 13 Sep 2024 00:14:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CNIn3D018276;
 Fri, 13 Sep 2024 04:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=89QojaLssW9hk
 2q5hfmc2olaQTMqp5YhEYWbQyUEhWs=; b=k/gMkogi35UvAnTE8UqF/8woFcCIo
 a1MSdFWkD6TMoDCUZ63l5vIJpfokhzI651oisDIPm5O4XaWw67CxW26Hr5NuU0Pu
 PNmfGT+NIvXLdR0BDWq/GkFa32wP5ESRJNTbvYvlqKbyakVAKxLOr2Z7eOfSdKoB
 573vU9/Fl2L3ofLnBVbMjRAQepghc2QUD3731CkxfNX335NlT8LHTswlzIhE7H1X
 /UppNOI8j/J87JrpCL+4Afw4COwL4RohEejoPsZ0SiAD7dAuXTZwYuPwQpKDGBkQ
 YYWM4rNhJr2ShjU93vTvPF2J4xYgneaGQjACESIOJstsbEZrUGfJS9CMA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kyb1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4DoQk008383;
 Fri, 13 Sep 2024 04:13:50 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kyb19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D3dFoI027315;
 Fri, 13 Sep 2024 04:13:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3khnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4DmN054460884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:13:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B0E52004D;
 Fri, 13 Sep 2024 04:13:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EC6120040;
 Fri, 13 Sep 2024 04:13:47 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:13:47 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v3 02/10] target/ppc: optimize hreg_compute_pmu_hflags_value
Date: Fri, 13 Sep 2024 09:43:29 +0530
Message-ID: <20240913041337.912876-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913041337.912876-1-harshpb@linux.ibm.com>
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OwWdWtwee7t7_YwRZuYPsBJwTRSe4VPy
X-Proofpoint-ORIG-GUID: JC76Sfc3GGP9YnbiBbpLuk8BylKmFKbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=322 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index fe543ab3b8..7b23e5ef0e 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -83,15 +83,16 @@ static bool hreg_check_bhrb_enable(CPUPPCState *env)
 static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 {
     uint32_t hflags = 0;
-
 #if defined(TARGET_PPC64)
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC0) {
+    target_ulong mmcr0 = env->spr[SPR_POWER_MMCR0];
+
+    if (mmcr0 & MMCR0_PMCC0) {
         hflags |= 1 << HFLAGS_PMCC0;
     }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC1) {
+    if (mmcr0 & MMCR0_PMCC1) {
         hflags |= 1 << HFLAGS_PMCC1;
     }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
+    if (mmcr0 & MMCR0_PMCjCE) {
         hflags |= 1 << HFLAGS_PMCJCE;
     }
     if (hreg_check_bhrb_enable(env)) {
-- 
2.45.2


