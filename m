Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C1CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5xD-0008I5-RY; Wed, 26 Aug 2026 01:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5x6-00084b-5K; Wed, 26 Aug 2026 01:13:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5x4-0005cg-Lv; Wed, 26 Aug 2026 01:13:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VlSo955544; Wed, 26 Aug 2026 05:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6OGCDKh4Yrq3y4vVn
 abwu++T6s867Jz8J5ZZRPO7Bxk=; b=Lp5ZbLMTC+EoZrUDRF+dou75e0zERYBuH
 PhigKTvgYAJjUwpS75Ln3AsjA5WkgPhWFOG+ntd1OfJtV10aIpxWWxgZCJFDdrYe
 R6eYaTYJ7mN+ozOqzd1frdjuvLcO1LNW1950S34+cZ8q2ghZZiwOLddm+2GosUpq
 N6YyNXmj3q6B7uKmP4FBmqy5S5UYOfh1UYeR8jk5R4+mDYxXXljgh4wcwQZ26o5V
 4dJCwdLgqhLvQKAckMtn5crWzz780UX+RX4ptCRIvpWyExcz3TsZ3rGuRpTwVHwt
 Ie4avLwYkOy5UkoHzvDjwpd0CZ2jI0xPzPaxBaQbC71kRimmFn95A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqvm4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:13:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BLl6009888;
 Wed, 26 Aug 2026 05:13:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy7y37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:13:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5DNLd9109768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:13:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DD5520043;
 Wed, 26 Aug 2026 05:13:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2679520040;
 Wed, 26 Aug 2026 05:13:18 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:13:17 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 37/37] target/ppc: Add self as maintainer for PowerPC TCG
 CPUs
Date: Wed, 26 Aug 2026 10:39:03 +0530
Message-ID: <20260826050923.74756-38-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yziIelWjqHDTW7uHgm4P1bY3kIjVJdAr
X-Proofpoint-ORIG-GUID: ionXWz7OgpiqCG0cxe4sNS7k4iFe__sp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX3oUxS/aAzido
 i0w356Twidz995TeIaMoBRiIg8vxVUYJyEaQ2EPoRhhl6D0V5cvZSXCVvbDA4eLKe8C+NZ9+aSV
 70LjOZ5v8ml7QsByOBgmHK7i7zpzsKfQKGFKgWDkYdkCBHBBGiyKwhkXEmicY5gMntUcemooTdQ
 UR00yH9ZQXQrArVVlGlFXgUS2ZfNHX0hIlEXCd69XM+iFA+CMZBxgLAJ9iONjlLQ6ek9DbjVLqS
 FP2EidU24p1s5sI0bGNTCdfhzrux2lCWXsNSlVtP9tbnWSAGXmfND1zUhCwgnDH8yrwDnFvYKMA
 0t81hLRdjyMHGKQaKcb3KMm+sQ8jNm3e1bEkv6SPz68UQlxQP56Yv951Gql51A2g9XlGrQYR17u
 kamkoO3kLtyFMePRzIQP0nqBPigK2OTQPnXHenk5H3c8/2OwNuSWRnsz3CMLKtJi2TSR0uw7CKU
 iQlM2EqScMpvBhVuiUg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8e75f8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=m3VQ6hfItiEfsWDAiLMA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXy6qPECSSLugz
 6lQ+YljrVpmRuNMfZh7sjujjhjuAdV/qOrBvtc/RsgXHPIHlEg+F3j1V5dpfiseQ5HDEiU5cnIV
 97h/u+CeMg8ZzVVxq1ODclCjoMOVtYA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
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

I have been contributing and reviewing code in the PowerPC TCG CPUs
module for a long time now. Stepping up as an active maintainer to
better reflect the current status.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0ee348c4..f040083503 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -337,8 +337,8 @@ F: tests/functional/or1k/meson.build
 F: tests/tcg/or1k/
 
 PowerPC TCG CPUs
+M: Chinmay Rath <rathc@linux.ibm.com>
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Chinmay Rath <rathc@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.55.0


