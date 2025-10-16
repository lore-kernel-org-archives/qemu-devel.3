Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9985BCCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MoQ-00010t-5Y; Thu, 16 Oct 2025 08:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9Mnv-0000iz-GG; Thu, 16 Oct 2025 08:10:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9Mnl-0006yY-Jm; Thu, 16 Oct 2025 08:09:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7QIt7023571;
 Thu, 16 Oct 2025 12:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VsSOpe6pgGj5wbRdO
 8x5We83G5GYrOJq7kqoOz19YGc=; b=TWCBkSUgeuDo1B7UGh8HzHN2WLk4MgUuU
 4cRaiLdxj2ngI8CYz+jRxENhMIX782fjo9RVgIAgla07GvMQPC/r26AkXp3MKQVG
 Cp6fMZRdm2m/vyO7moD6H+bWo4g06aQbnnp2XFOWokqD4fLMUqr+sB7/bNXIm1Bo
 cTLFlUAUNc3HuuTLrqpm5Ti1CWGY5w3+feoGACyhy9drkEKF/YFZJoa66cGXdJ3H
 9foiRTSq9MlVXl//p/b6JDrKaAAgZMILVRBtm4hoqaSuRVd7SqhI0vqWmEqTjfpg
 TZqZTk0oZv3DmkjbD9/Br32ak0eADDzPZXSczvWB1Cl0CetZWsjCg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpm8bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:09:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA9fCc003603;
 Thu, 16 Oct 2025 12:09:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy5ntd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:09:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GC9WHq50463160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 12:09:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70FF920175;
 Thu, 16 Oct 2025 12:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC21620174;
 Thu, 16 Oct 2025 12:09:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.71.186])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 12:09:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v3 1/3] target/s390x: Fix missing interrupts for small CKC
 values
Date: Thu, 16 Oct 2025 14:06:59 +0200
Message-ID: <20251016120928.22467-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016120928.22467-1-iii@linux.ibm.com>
References: <20251016120928.22467-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EyAZp_AL_7BSIwUpTdqEF9AfPUubHlsY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfX8u/8fTahZyqQ
 I69DD4F80ob7UgzEdrLYam9ZYKmhVVlubgVrWXGRY1Z4DORa1fmTZUveoqu4XAFOCbhNWt51cpw
 AKsTwX8gU6K9xNV5Yg4LPApAzSPed7qv2YhGMqjZAuxLMKUzVuqmENQc12ChBqirVDgQQQpWYf0
 ide9eDGX3i7N3BCrJWH/UD0UAixfKK8gSfejo+3ZFZaAGDWsiDpXp45Gz72WCjVpj52lDV6GnA3
 Krgo9uBBcyN/PVuUQsapoy/Xo4991BACzS/ElmKn1cWnWPv03gldjV1vDS9LikosA0YVSAPiVYv
 lmfLoxvB+PRSW15ixR5eQi6XmULD0LpMmE1krUx0TZrsAbIfL4WZ1zM4FcB1X4ja19yG3KTGC9H
 g7FBIEdSqXBk7GjUeoFn0JAV68qSzA==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f0e07f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=DMoVdRysFPNM0ZNGwSsA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: EyAZp_AL_7BSIwUpTdqEF9AfPUubHlsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Suppose TOD clock value is 0x1111111111111111 and clock-comparator
value is 0, in which case clock-comparator interruption should occur
immediately.

With the current code, tod2time(env->ckc - td->base.low) ends up being
a very large number, so this interruption never happens.

Fix by firing the timer immediately if env->ckc < td->base.low.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/misc_helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 6d9d601d29a..215b5b9d933 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -199,11 +199,15 @@ static void update_ckc_timer(CPUS390XState *env)
         return;
     }
 
-    /* difference between origins */
-    time = env->ckc - td->base.low;
+    if (env->ckc < td->base.low) {
+        time = 0;
+    } else {
+        /* difference between origins */
+        time = env->ckc - td->base.low;
 
-    /* nanoseconds */
-    time = tod2time(time);
+        /* nanoseconds */
+        time = tod2time(time);
+    }
 
     timer_mod(env->tod_timer, time);
 }
-- 
2.51.0


