Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC99ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MoS-0001CT-22; Thu, 16 Oct 2025 08:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9Mo1-0000mn-Sa; Thu, 16 Oct 2025 08:10:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9Mnj-0006yu-Go; Thu, 16 Oct 2025 08:10:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G2HTuB010194;
 Thu, 16 Oct 2025 12:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Y2h6TdWlxVDiVfPno
 YF5l9frUy5Kex2iUmuv1+WHI28=; b=NYhRUgjgy/bBwh9+cyKritAVKYp6NafhV
 c39bEoLlIW/7AkzouT72441upna0lg8wA2pzVQOzDem5iDgtXxPgEuj0Di+/DEZ4
 Of5xb3O21mhxoyS+MlqYGoZ/lUdM3JrvXHkNe5Q0AnKWmGNeyJ7ZcmaZjI2vz1Ei
 LxFa31bApYRpqS04JMLors55TNRkRI1GI7n5TSP0wp99pnotthJsN1f49qHa7/ZU
 Z4NWkajejV/AfWv5JdsvCFZ5libvQQOjRzwMK2T8Pg8p6u10fIxHWfnWaBE01uq6
 L1541u0VfqCKLblZG0LM6ndDMkmg6iTK0TtjvqNxn5u0tBWEcM5Wg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewuagx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:09:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAogQ2015041;
 Thu, 16 Oct 2025 12:09:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjnbbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:09:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GC9X9F59179408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 12:09:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1147820173;
 Thu, 16 Oct 2025 12:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8783920174;
 Thu, 16 Oct 2025 12:09:32 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.71.186])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 12:09:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v3 2/3] target/s390x: Fix missing clock-comparator interrupts
 after reset
Date: Thu, 16 Oct 2025 14:07:00 +0200
Message-ID: <20251016120928.22467-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016120928.22467-1-iii@linux.ibm.com>
References: <20251016120928.22467-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B1s7OgcwQQJaaw3tZRPcTrg5Q8eQIY8I
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f0e07f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=1K0trMwjMfmDt0goFSAA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: B1s7OgcwQQJaaw3tZRPcTrg5Q8eQIY8I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX2QJArvhpb/CJ
 k/mqtuZjsGE8ndgllW2ZSFhSVzkNBFB5W4DtqcI4LXR6Y/8oqBNRbddOsvj7AtZJZ1kfi8iXMsL
 DVRdhRNSj/sHzOSk3Zq2+7m4MxyXnB390aZkD9o56VSq1MzYNZAR+MPXq5DKD59n/XOlDpGe914
 56jx0l6kRW24cZhV1+r5nVeJDBmBNoXubP5dKjsK6QpX6VTsd41be/xCNrx4UZolZ3GrcMidguO
 eFvXYklczz2zwO86b7ZUccbegSRcaGM4ju8vFxD85YWtNuZdmspjmLMYyHz6TMQAjGyk4yp+3/s
 mchSfiAiooAvoAJcw3gmsduVCCjlUn/YZybSi45kERzP5Au5LqfPl/o6PD3WF05HgcBoNe1OCaH
 XYA4xx2Y85RJ1prBsM+y6HCIg/BhrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


