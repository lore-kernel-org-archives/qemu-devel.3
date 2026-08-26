Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91BCC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5x3-0007zo-Cv; Wed, 26 Aug 2026 01:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5wt-0007tX-OG; Wed, 26 Aug 2026 01:13:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5wr-0005bk-W4; Wed, 26 Aug 2026 01:13:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3Vump1702564; Wed, 26 Aug 2026 05:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fRPigfNfgBmKy8ugX
 Iwu0S6OuMdCuCm+/QA1D2Cj5KY=; b=Ov0Ve+KFcpQSBU5210YYZpulNgW0Qk8kC
 O7U4/TDgH3P8AFg5mIYSMExTOt76mBDKV6YA8yI6+SDBcaqrfE2URffDG2HZxKPJ
 JgT4LEl8NoZ+S4RVoFk63pJmBw1nlYqedwd4i6Ly5YZEWYymo1aSlcD1pxwN48Yu
 dkCTLcjiIwokcURkwK7PN0YIt2jaIH4PT1PLpv4CtIaf4RtM3NTZG5FZBQ3l37Ji
 RxG593uHjqsUgGBsuqP44Q43fenOsSgBcUqeJuTREvNcQBG940b4/bddQ3cQAVd2
 zyBTyAyGg0ldbFvl8xMGAjW5EUslWsNxVK9IzCEwcSOeC+4pJ552w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726emk8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:13:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BJ5Q029298;
 Wed, 26 Aug 2026 05:13:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q8e8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:13:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5DBWe39715258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:13:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75C532004D;
 Wed, 26 Aug 2026 05:13:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C430F20043;
 Wed, 26 Aug 2026 05:13:04 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:13:04 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 35/37] target/ppc: Reorder PPC2 flags
Date: Wed, 26 Aug 2026 10:39:01 +0530
Message-ID: <20260826050923.74756-36-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8e75ec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=n9CTefPPWk96pEdnryYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXxnERMoTEnpZI
 h1ZHJazlMzNY2vvbYQO2BXJh4r0Fd+n610Itx8lNHv4O/NmenU4kmeUJ5n+sO9tbjS53dUgUDZZ
 MGPiqg8TC18PnFCj5mm8t8kW+UeOs2k=
X-Proofpoint-GUID: YF8EVUAM_nsNAtTKB3gFHoAO_vCkNPJE
X-Proofpoint-ORIG-GUID: RFLXiTJS0jPZ06MYDu9cY-PgwGVDGBIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX/qdEN3nKXtOy
 Qy4n53GYLjZIpUwWcl/hAA9vcKD/gaXMGjT37OdGVA2PONb4Dh4+p3nuIdbb+wqiO6nvFwgUs0H
 7FQINPzbMRAeG8FGzYdb1ZrfIHBdeofJnnDBOnIq9kPbUtqbsDhnI3o42hsettKIfJEVIbVub0g
 ky8nVArCuPtc4yA4Eq38VHMEmT5u7R+328ZMMZSxqPZF2OnYQsQD8ZUdAzsKL2MtTbCn+qroMXd
 D5NUUdfUEoEJ9+pfnZ5UjSNij1t5i2JjcahYNcf/fGyhwFFc/tbptOmMg/0oI7kZ5BzpFJZ2T+l
 5OgPTnOkWPIaEn66b8vYg4uF750iCvdwppBtgVfM1zs0cJ1YxdKQTobMp8awGXxbSMjoBj3xA8s
 tyN8M6EW0Q9UfaDs3aeomrsCZ/PgVsXSeig9Z5+oVARz+MQvYjGt6HeOmjZ593jMrwIxEB54TLN
 wiRzVdBimsFoP3kqphw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Consolidation of different variations of Power ISA 2.07 flags
into the PPC2_ISA207 flag has left gaps in the flag encoding.
This patch reorders them, restoring the expected incremental order
without any gaps, freeing up bits for future use.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/cpu.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4a77607f80..3fb51bbeb8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2578,25 +2578,25 @@ enum {
     /* ISA 2.06B floating point test instructions                            */
     PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
     /* Double precision floating point conversion for signed integer 64      */
-    PPC2_FP_CVT_S64    = 0x0000000000010000ULL,
+    PPC2_FP_CVT_S64    = 0x0000000000001000ULL,
     /* Transactional Memory (ISA 2.07, Book II)                              */
-    PPC2_TM            = 0x0000000000020000ULL,
+    PPC2_TM            = 0x0000000000002000ULL,
     /* Server PM instructgions (ISA 2.06, Book III)                          */
-    PPC2_PM_ISA206     = 0x0000000000040000ULL,
+    PPC2_PM_ISA206     = 0x0000000000004000ULL,
     /* POWER ISA 3.0                                                         */
-    PPC2_ISA300        = 0x0000000000080000ULL,
+    PPC2_ISA300        = 0x0000000000008000ULL,
     /* POWER ISA 3.1                                                         */
-    PPC2_ISA310        = 0x0000000000100000ULL,
+    PPC2_ISA310        = 0x0000000000010000ULL,
     /*   lwsync instruction                                                  */
-    PPC2_MEM_LWSYNC    = 0x0000000000200000ULL,
+    PPC2_MEM_LWSYNC    = 0x0000000000020000ULL,
     /* ISA 2.06 BCD assist instructions                                      */
-    PPC2_BCDA_ISA206   = 0x0000000000400000ULL,
+    PPC2_BCDA_ISA206   = 0x0000000000040000ULL,
     /* PPE42 instructions                                                    */
-    PPC2_PPE42         = 0x0000000000800000ULL,
+    PPC2_PPE42         = 0x0000000000080000ULL,
     /* PPE42X instructions                                                   */
-    PPC2_PPE42X        = 0x0000000001000000ULL,
+    PPC2_PPE42X        = 0x0000000000100000ULL,
     /* PPE42XM instructions                                                  */
-    PPC2_PPE42XM       = 0x0000000002000000ULL,
+    PPC2_PPE42XM       = 0x0000000000200000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
                         PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
-- 
2.55.0


