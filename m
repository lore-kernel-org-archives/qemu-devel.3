Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765BEC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3Pa-00071P-Jp; Thu, 20 Aug 2026 10:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3PZ-0006wS-5J; Thu, 20 Aug 2026 10:06:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3PX-0006jE-Jy; Thu, 20 Aug 2026 10:06:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K97Kb5424049; Thu, 20 Aug 2026 14:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q61IJlnZFP9HGYAVm
 dLNMQY8zG2o1aaP8oKoTVCfAEY=; b=jwfEtV30JMv6XMMNbIAjlhQT80fz1LBWc
 d2jYs0HsLKU3W4/EyRwOya8RYYnTp9yWjKedvMnS58Af37rNy+W+WiBSf6a9EsXi
 PPay3jgnYHbG59bFDET/bs+NbSqBloUg5WFCG9KdOAJhrDczqJorN54w/8PtquXV
 7wmS33UojmI9JHNb5EgEdaNwj4+yEMduJo2d7xeVxaAtA1ZyN65iyuQrKzEl1cHY
 kBpo/iatiPlnK4uzbfI1uUIDrMtq6jT4rVVUeyGQzdxf+5GXH8GTyWDM+kO4KBAA
 ZIxFOsPmBmibXMyx5xKo7jeG6zZIjzC+RpdBWtWDM89862jclhzmQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1jrqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:06:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuUQ7014706;
 Thu, 20 Aug 2026 14:06:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypnmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:06:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE6IPg50987352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:06:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5796D20043;
 Thu, 20 Aug 2026 14:06:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BB9120040;
 Thu, 20 Aug 2026 14:06:10 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:06:10 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 22/29] target/ppc: make do_ea_calc_ra available for 32 bit
 builds
Date: Thu, 20 Aug 2026 19:30:51 +0530
Message-ID: <20260820140114.327023-23-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a8709e1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0RWl5roMYX471uEN2lYA:9
X-Proofpoint-GUID: ujQ6D47ijkKG-9IpHTzq0Q5E9LOt7y8I
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXzAmOZNzdhkvb
 a8HjddzFfwjm+uV2bcWI939I4ju9PR+BFxoP38DoMm/l3vcD3+re+6FXGJMxwEbFgyXWg1frljP
 jC/HhRbrdFYXk8uxsCgPhcdjHUdjVaE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXwbTN7F9TjmN+
 O1c1dOTKQpQHQ2skaG2T86B/8LkGFFFOSxxvyHYvYE0ZI4ad9rbGsSEAVTW87Xzqj0Vck75/6XE
 q6aNtoI7aVZkkYdHP18zYxgEUG8v0mZo1bfvCGfu1STmFPV3Ak/mJwFYdHem5AO7by6F7/7Yef5
 d9oy7D251FyKj1L1po9T4LeipnqUymdvZLF3ttYqy69tPRDODw1MOpHsRc1NjVmZk2PJTLb75/Q
 /tB5I6W59xK9SLeMtKBiOaJFNZeGv4FXvZjaQXmnUwJ2rSHTIbKA1RJxf11udSxUahsLTITgBqS
 q2x0hg4IrHlkZOaDaYhG0RZHhQ95U2WpfvApaYtCciUMbQpHrvxPYimmfVc5xLts29dIuOy3H5B
 /tbT2N4UyKjbd0erOFzdmhKBsh7Ges0e+QVhH74DHpvbRZG2fp3S8kJTe0FfdO8gBZc5WEC8k8p
 Fbr7vUxIi8Ip7KlXiGQ==
X-Proofpoint-ORIG-GUID: C7O9Ot3LNsugLFHHGW-7txndspJkdcd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There is no reason to keep do_ea_calc_ra exclusive to TARGET_PPC64.
Make it available for PPC32 builds.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5b08d9b282..e40841b68e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2397,7 +2397,6 @@ static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
     return ea;
 }
 
-#if defined(TARGET_PPC64)
 /* EA <- (ra == 0) ? 0 : GPR[ra] */
 static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
 {
@@ -2411,7 +2410,6 @@ static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
     }
     return EA;
 }
-#endif
 
 /***                             Integer load                              ***/
 #define DEF_MEMOP(op) ((op) | ctx->default_tcg_memop_mask)
-- 
2.55.0


