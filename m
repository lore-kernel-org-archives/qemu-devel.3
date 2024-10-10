Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24811CF07A8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sym23-0006g6-Pd; Thu, 10 Oct 2024 01:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1w-0006TT-1s; Thu, 10 Oct 2024 01:48:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1u-0005am-If; Thu, 10 Oct 2024 01:48:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3wdCJ013423;
 Thu, 10 Oct 2024 05:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=SOHtcYgwQaAHc
 cQCU1BQEIQxsGvoHsXQvBqvkTsufP8=; b=dn/3T2xKeiJ8We+olKQGRzDmMjNHM
 z71EXN9W3g44NbCNiJebrmE9gDEAZ5f9wzcCKq+ppFHbvEsnX3Myrz0gAIf/loWD
 qjeZwdA/MhZMjjSEG3n56QZ04cdvqlyfZUKuPXvDRsq+Up2jTETsqij36K37D13t
 KpskTk5BJk8XEKJovSDyO4o0lJUK0jWfEj1H0TRX1v29RMpYeRPWZQrlX2fdlaDn
 S7sjVAc7VTTntzGLFIX2Kbz39A83/EAs01hjTCnkqPX8wMzbxImIuReyjtTdZVIr
 t8400AouQB+KY3ei63plZ81qn5c4+YAAX3cJX/QhNxIqgEPKMCtTwLWPg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267gb0apc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A5Lni2030341;
 Thu, 10 Oct 2024 05:47:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmwybn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A5lnGi46203344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 05:47:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E528820043;
 Thu, 10 Oct 2024 05:47:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D496620040;
 Thu, 10 Oct 2024 05:47:47 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 05:47:47 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v4 2/9] target/ppc: optimize hreg_compute_pmu_hflags_value
Date: Thu, 10 Oct 2024 11:17:33 +0530
Message-ID: <20241010054740.1106997-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010054740.1106997-1-harshpb@linux.ibm.com>
References: <20241010054740.1106997-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cGNs4VV387xEdDI1GwxGS_E3I-YuROJZ
X-Proofpoint-ORIG-GUID: cGNs4VV387xEdDI1GwxGS_E3I-YuROJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_02,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=327 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100036
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cache env->spr[SPR_POWER_MMCR0] in a local variable as used in multiple
conditions to avoid multiple indirect accesses.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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


