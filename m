Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1017CCF07AA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sym1v-0006QK-AP; Thu, 10 Oct 2024 01:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1t-0006Io-Fc; Thu, 10 Oct 2024 01:48:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1r-0005bB-6u; Thu, 10 Oct 2024 01:48:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3p8JU009563;
 Thu, 10 Oct 2024 05:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=o3EfDWyizLycy
 sh4S4vLnOb8FJzeQ7p0kdHiJGFmu7c=; b=m5epNTHw2+HKXE2nkcOdtotXiW6eN
 s8+vth0xqM3xhPPEkntQQD29F1l9KWcfRi/okqulUGBwjLcDTnEAPTy2F7u4LhBR
 EUbhFXWzf38YpqImSSO/c0EYiLeucK3VrEyyztYdsC4Ii9pMs92Xam4hgZvwXx0G
 8O35o74zyFQmxIL179AJSj7M8zPE4rHpU5/E6CjDGSoGZ1U2ctC6MEevcRWv7tvC
 5sw9SFU3QDGwd8CCiED+EJJM649OeC+i+KVRdS+HsrzDwABFq8lcz9oa0hrml/p/
 FGnyRlEZensF7cQecLtNLH8BDdZuUjXyMehLbxrX3KadZ//PXGkZmLGXw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267cmrd4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A5lrmO008937;
 Thu, 10 Oct 2024 05:47:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267cmrd49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A51lbj011535;
 Thu, 10 Oct 2024 05:47:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xx2n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A5lohs53346742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 05:47:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 361DD20043;
 Thu, 10 Oct 2024 05:47:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32BF320040;
 Thu, 10 Oct 2024 05:47:49 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 05:47:49 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v4 3/9] target/ppc: optimize hreg_compute_pmu_hflags_value
Date: Thu, 10 Oct 2024 11:17:34 +0530
Message-ID: <20241010054740.1106997-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010054740.1106997-1-harshpb@linux.ibm.com>
References: <20241010054740.1106997-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RdWtWUBF6XkB7TF6twTFRDRq3v76j2Pj
X-Proofpoint-GUID: o4RK19p6Z9Va8wWdXHWLJF_bq9WRf7zq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_02,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=384 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100034
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The second if-condition can be true only if the first one above is true.
Enclose the latter into the former to avoid un-necessary check if first
condition fails.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/helper_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 7b23e5ef0e..42c681ca4a 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -102,9 +102,9 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 #ifndef CONFIG_USER_ONLY
     if (env->pmc_ins_cnt) {
         hflags |= 1 << HFLAGS_INSN_CNT;
-    }
-    if (env->pmc_ins_cnt & 0x1e) {
-        hflags |= 1 << HFLAGS_PMC_OTHER;
+        if (env->pmc_ins_cnt & 0x1e) {
+            hflags |= 1 << HFLAGS_PMC_OTHER;
+        }
     }
 #endif
 #endif
-- 
2.45.2


