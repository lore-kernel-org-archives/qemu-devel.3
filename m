Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCA7CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SH0-0002iy-8F; Thu, 16 Oct 2025 14:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SGx-0002hH-1v; Thu, 16 Oct 2025 14:00:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SGs-0002xD-TL; Thu, 16 Oct 2025 14:00:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBfFnN021718;
 Thu, 16 Oct 2025 18:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tcnschf6Tzn8lr9Mo
 g6fbobDSxPq5ZSMw3MsU3AWhQQ=; b=nuqGJJCikBA2BsEIY4Ka53TlHB7Uq8aNv
 vr3CWWnDcB64qxZsBOUM/tECS87fF+XgpColpNAYBHvGt2EGlSyWD+86jDnrtaJZ
 pWpKbik7wEBdkNzef0on6xkNyQw7hLZRukYEnJ3eNS6bHl5l+vjvXt4VJn7ArXCE
 kCBuuykkmFdmL5/gMaGeMDy+khjbTCinN498Fg59QjvOdPWMquIjuji92kS/Ujg3
 RBfVpqAX8ubd1tBRw7NqOjWr7HthHAAUtMw3qD2YUtnFQvwYTkKh9kBdDleqWHid
 OW/7mKe3Vza3dfpZywDswY05SLKORAIzhFqs1I7v7ddBafsZZ5Hhg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0b5ty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHhp0Y016705;
 Thu, 16 Oct 2025 18:00:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k737f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GI072L47907282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 18:00:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9864320086;
 Thu, 16 Oct 2025 18:00:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 303B620082;
 Thu, 16 Oct 2025 18:00:07 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 18:00:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v4 2/4] target/s390x: Fix missing clock-comparator interrupts
 after reset
Date: Thu, 16 Oct 2025 19:58:31 +0200
Message-ID: <20251016175954.41153-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175954.41153-1-iii@linux.ibm.com>
References: <20251016175954.41153-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2YHvbkWk6HZ8mPGx9Za13dluyBbkLxN2
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f132aa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=1K0trMwjMfmDt0goFSAA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX4aagrODowtLL
 4dNFS5H53aNJh/n9+jrPpQa8kQ3/j97zIssRJgb++SPkRhoPWVul3DkjgwJ+wY+BO+3N/kDQzL+
 hbcQzha3Z38gUh1fqrY2a7K5qCa/cPFEm93rGYDZP0O+hXl4Tfk735JCyR5yEeSRpSoi6eA9irW
 lRTBEYmsHlCLjPmaMalIksHrhnvS2VFMAi7DsQAbTRzBdFeywDIxg0BPA56ieNkiUQZ8LzBbO8J
 JcfyUJYrcuuP1XIub5Z3b/KA93ubdscv4/+6BxJeRvU3TGexhsnJfj8lJJfbxrWgrLeBQ5W02o7
 bbV7nd1g1oLqfebDXtPsPqYLzRP7lkTUCc3g2ZqIgQANwH1AKfjZQtHXN5in7ZyHEMM23MSUaNQ
 I/nZS2zq/ihklroiYpkkAnuS8MmbdQ==
X-Proofpoint-GUID: 2YHvbkWk6HZ8mPGx9Za13dluyBbkLxN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
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

After reset, CKC value is set to 0, so if clock-comparator interrupts
are enabled, one should occur very shortly thereafter.

Currently the code that loads the respective control register does not
set tod_timer, so this does not happen.

Fix by adding a tcg_s390_tod_updated() call to LCTL and LCTLG.

Cc: qemu-stable@nongnu.org
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/mem_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index f1acb1618f7..24675fc818d 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1959,6 +1959,10 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
+        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val & CR0_CKC_SC)) {
+            BQL_LOCK_GUARD();
+            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
+        }
         env->cregs[i] = val;
         HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%" PRIx64 "\n",
                    i, src, val);
@@ -1989,10 +1993,15 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
     for (i = r1;; i = (i + 1) % 16) {
         uint32_t val = cpu_ldl_data_ra(env, src, ra);
+        uint64_t val64 = deposit64(env->cregs[i], 0, 32, val);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
-        env->cregs[i] = deposit64(env->cregs[i], 0, 32, val);
+        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val64 & CR0_CKC_SC)) {
+            BQL_LOCK_GUARD();
+            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
+        }
+        env->cregs[i] = val64;
         HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%x\n", i, src, val);
         src += sizeof(uint32_t);
 
-- 
2.51.0


