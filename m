Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F4C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaEL-00073I-6o; Thu, 27 Aug 2026 09:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaE4-0006kV-Mi; Thu, 27 Aug 2026 09:33:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaE3-0001uA-1k; Thu, 27 Aug 2026 09:33:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVVxM1125995; Thu, 27 Aug 2026 13:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=N5oFhG2ZFtkOL8EUp
 upgX5Y6UQHGQifNqch3a133TWA=; b=hQtoEZ64RbqZOZW8c5dmttfjEtpH3vFct
 dmrtBkiUYi+0wZv7Qm41o1zHx5YlVPL71Pejc6qu0CUSUnLHhozGS63F885Q1Llh
 ubRgF1kCVzfvU8zr9tyhqdapDpGP4exZma6QYVK1OOgfsdPzrEpJE7dK99IM0bbQ
 TNDOTXd4T0uWbVeKvKAc0PbHO6OlN60E2qvbzJoz71mcXG4Xh515Z9wkMPx9toQc
 iCZIe8TQ/pANaeRApGEf6gvNO/SFATXX0VGb1XHZUZgZwqEvdxiBR7QWOpsXB0ni
 D8CSkeKkJJfbPGOT7bdNkQiQXttUNLinyUf40vgFQuHkz101J88/w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er5k2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:33:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQOEw013344;
 Thu, 27 Aug 2026 13:32:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qgh9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDWs2N41353692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:32:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 479CB20043;
 Thu, 27 Aug 2026 13:32:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F60220040;
 Thu, 27 Aug 2026 13:32:48 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:32:48 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 22/37] target/ppc: make do_ea_calc_ra available for 32 bit
 builds
Date: Thu, 27 Aug 2026 18:59:37 +0530
Message-ID: <20260827133010.278889-23-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1_NsHOK8BHzOHdphueO9Xou5g7kRc7Ca
X-Proofpoint-ORIG-GUID: jlCx5NnR4DUSqpJ0hZO_LA_4Q9Y8Dg4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX/r9nfwe7esUK
 bSvGJpKv+XMnHmgXtazlb90GUo1e5kgKiiKyQpMScSayLAwQuuhAB3XIQ1UHp5gP705EQm3WhQP
 5r0b/76dmHk3yftrTN0mGyW4RLDtZTGQPLFpwr9A5WFORb1z+w1iaZTohpm9gYE31ejViCyEq5S
 x0buVW++tO6M45okmeFVQXWFBNY8AwQu+rK9mPRboxYzVOMG18vOKZNFbEkrd8itWO5LRGh/2u0
 dvKuhDtuX1u34vpxdipPuSk2GDvE4XPeGEwmlHXc/0bRSuBzuaCKrCRrbStwF5TZCIkFi79OP7U
 IMyhwJcQsvItBhXvL0NYKv62xRKZwPFfmzoAJ93Y/J8VPFPlPJsMwZr2rXlzGeqPHNv/JnuwJ6N
 RirbzruB27GQ6xem5MTrcJe/tTwogDd7KIBPqen1ogkpVyOYtvnjuG4kibwJXgcOyWvBryzXw9W
 qSpNcmJRkrVMTyuy9uA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a903c8c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=0RWl5roMYX471uEN2lYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX3jt1KkH+O8lG
 ASK5nXlTB0Ag9L0IP/5VWa4IFsh4gEAD0ERfFWnYM6JIHu18wo875ai3sQSsvaIMe4NOsjQoJ6m
 FGEA0V4PdULxnU3dHonNoAuvfTnkkpQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
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
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c5361d8db5..c45883ac30 100644
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


