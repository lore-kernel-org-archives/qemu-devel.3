Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6843C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCaz-0000kV-RF; Wed, 12 Aug 2026 13:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZs-0000B7-D7; Wed, 12 Aug 2026 13:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZo-0000ot-LC; Wed, 12 Aug 2026 13:17:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1TCw4087968; Wed, 12 Aug 2026 17:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=U4x4Xf7uo9thTZpnm
 pApx0k1GI2zyRmOy4R/QNdhw5c=; b=gnVw3fRtRJkNPW2vbbhdtlxgvBqONZF9T
 k7pUtsSaZkxH+AEhkmgTjYn2kZo991TBeV7Vva9WJhDCT46Lm5ijtKj0MQgYgiAn
 JhVrpMvYQJ6eYkcvzuNvmqmXXOniS78Dve3REIeAgPkbXpCFAOu3SqeEf5cof8pD
 N49PhCpn6jr9SnSlqo30U4gqME+SC6BOUj2VZ5HmN5zdWxNNRX8uzkCLMJu5nGXi
 fWflh1utDHGu8+UtuL3BhXlCI145HgVXWbuNNFQT3b/RVR+pLeE/GOeYewGr8NY3
 fDWWY/V5Sb+n3J4bzXfdAqubkwaSUG9f3DF2bFZFNz7Pi5P/cCMiw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9us2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBQwA028259;
 Wed, 12 Aug 2026 17:17:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjy4s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHA1n34013782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC95D58051;
 Wed, 12 Aug 2026 17:17:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 073AC5805A;
 Wed, 12 Aug 2026 17:17:10 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:09 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 01/15] target/s390x: Make PRNO TRNG interruptible
Date: Wed, 12 Aug 2026 13:16:53 -0400
Message-ID: <20260812171707.1605637-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX9LA8IqcJHUAA
 svZgyOV/T7jIpudUM80Jcm/GHD+tLcUzvH6w4rRdtX9P67lpRf78Rb3Ke8EK0idBiajV4v45TaH
 eNuM/jfkz0HBuHaMpyxR5t6TYUKyFrLwsIUTspkCskPa3CjQSwXFTpJJ94hfIvPXCS7bjYBx6yt
 iXXayM+DsfJwPKBms7cpmFWaYSYILg4vQ5XuIw18aoNsoX9Vu5Gm13Lc6Nm99swYyCPJLpQhcgr
 3hZPKmBxZfeMlF+Vyg/h8ReXw6dd4Lo0iXz+3FkjGZy33D8RY6sVWml2rAN+fqn+zjZytzNqKfW
 sU9+XRfPxjeKzYOj9RvtLYp/+3cMU57cSSoD1gbVL4S1JItcq3kz1BIKT5Z5rLy4SEifikPzjhj
 L6mFFPyltimdfeQu8sTRLcg3GXrEH31BC6Ysb8SSekSQglCF+jrIrEYL3Mhno63NRBAoS4JWduG
 f1Rza/8QhFL2EqiUCVg==
X-Proofpoint-ORIG-GUID: Mzh5SfhuX0bOatIcLSfvestU7K5qAV6X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX1TksnxZy3IYG
 hW3ldD8Ec7e6AWgBL0af9tR1PqeqZRcIL17iFmf2S+pRENv5kqVJ+WHkbC1vhBqmJ7kW9VRAfm1
 B++nAVHrOwV4QnVc0N5N3pS/ipCgFCM=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7caa99 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=x4Cszyr3wkYQ39rAaogA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Mzh5SfhuX0bOatIcLSfvestU7K5qAV6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

fill_buf_random() writes the entire guest-requested amount of random
bytes in one go. Since the length is a full 64-bit value, a guest can
request several gigabytes and keep the vCPU spinning inside the helper,
without a chance to react to interrupts.

Do the same thing as HELPER(mvcl): check cpu_loop_exit_requested() at the
bottom of the loop, and when a return to the main loop is pending, stop
and report partial completion with condition code 3.

Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: 3dbc5fdacb5a ("target/s390x: support PRNO_TRNG instruction")
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714191948.342204-2-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 8fe0a22219..6a5dbe1caf 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -16,6 +16,7 @@
 #include "qemu/guest-random.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
@@ -242,8 +243,8 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return !len ? 0 : 3;
 }
 
-static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
-                            uint64_t *buf_reg, uint64_t *len_reg)
+static int fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                           uint64_t *buf_reg, uint64_t *len_reg)
 {
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t tmp[256];
@@ -265,7 +266,13 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             --*len_reg;
         }
         len -= block;
+
+        if (cpu_loop_exit_requested(env_cpu(env))) {
+            break;
+        }
     }
+
+    return len == 0 ? 0 : 3;
 }
 
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
@@ -278,6 +285,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
     MemOpIdx oi;
+    int cc;
 
     switch (type) {
     case S390_FEAT_TYPE_KMAC:
@@ -308,9 +316,13 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
         return cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
                             &env->regs[r2 + 1], type);
     case 114: /* CPACF_PRNO_TRNG */
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
-        break;
+        cc = fill_buf_random(env, mmu_idx, ra,
+                             &env->regs[r1], &env->regs[r1 + 1]);
+        if (cc == 0) {
+            cc = fill_buf_random(env, mmu_idx, ra,
+                                 &env->regs[r2], &env->regs[r2 + 1]);
+        }
+        return cc;
     default:
         /* we don't implement any other subfunction yet */
         g_assert_not_reached();
-- 
2.55.0


