Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD54C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5vn-000435-43; Wed, 26 Aug 2026 01:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5vh-0003l6-La; Wed, 26 Aug 2026 01:12:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5vf-0005TS-ON; Wed, 26 Aug 2026 01:12:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3Vcop2830759; Wed, 26 Aug 2026 05:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EhiYhRpiNeiHcmm2O
 BOothJFWZi7xRbaXJN++PTV7OQ=; b=bQIptaJITTko0fyOtpVNMQv6Fr0AjxzQ+
 UTTeLP5kAC9my5t/oQITPIeTL/h1q+qOKMz8IugMlclxjTnlRLJjsjemSrhYMyex
 Dgq7glzbXr6l3Y4zmcBltfMmSp/tJUb5uL9MvXec2tSd5xG/aQv3kNIw3FsL+Xg7
 E/vwsJxKfCxH/p9C1I94irxnbt4R+prBy+ZRNCbAuvh0jrdxWEvFMuK/iPxIKIgq
 pZqOJACAT68/BcKr3844/4EPACd9fy3lDtnlEEWaFQoV0W71V4ZqbyYC+Efb2ARt
 QfB0kng24aGGW1mDNxneZ35BpP5LvrK29ArsQqFJ4L7esMWlurBaw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4vnve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:12:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BHJI009635;
 Wed, 26 Aug 2026 05:11:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy7xuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5Bu2Q30605750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 193FF20043;
 Wed, 26 Aug 2026 05:11:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E275220040;
 Wed, 26 Aug 2026 05:11:50 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:11:50 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 22/37] target/ppc: make do_ea_calc_ra available for 32 bit
 builds
Date: Wed, 26 Aug 2026 10:38:48 +0530
Message-ID: <20260826050923.74756-23-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 0L5evjvn6Tmxbc33RaBaodJ3Lf30S3sV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX/v7hudZIkPHo
 XXUtpz+T7NoHO+SaMY+agUsN+m/lLOXyQ91b4kN7993k82zDz024sPiaQNktNxS7+vJRqWZd/fX
 5ctQZHzC5S3V5gQsZh8yDoapGhoaAIo=
X-Proofpoint-GUID: yx4ffHq4M90wB1ZWtzK_cYaonqlxMqfw
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8e75a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=0RWl5roMYX471uEN2lYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX3hKrU3obYaLF
 YyHQlEk2iMo+6DgTvsWc1XH1UNfGiVNuOz6ZpjA6J3YP+SyAWcoY9TgyiBlijL1bVAzYB4ILgZu
 +lm54r/pCcd6rJB7LOZZEMICqRL/SrRD537p0X3D+kcEY0ubJUfmu3uzK3f21wFZDVbxE/Icj3d
 6SeWq+vEkBD6AqqpPucVyyzfC71blRbIDkceGYGKj5UqY7+XTHGh+8latxL4tquJ/JIkM4oEp8E
 Trny1uScVY/8Qc3cnWKQQJZTDhepYxLA3KEQUSqsDKtQ5lrrH3aiH2ZuFeuJhtBvbnQW3zzqk+K
 wHXWb0BAssuSS5g1GJw3oMBh5uxrKNTTygnRZafwAuebDzOvOd1fWBZ8SJHQZhmlq/pl6YS7ahC
 NTB+d2zlFWLXcaauYnQ5yu19B/qj6azafkcQ034FU3GBjqOjwBzvIaJOy5+oQeqg+m+o6ucPG8d
 MO8DgNHBHtYziUNWmTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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


