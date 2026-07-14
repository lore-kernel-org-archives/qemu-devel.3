Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75745C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjifi-0005JW-Rm; Tue, 14 Jul 2026 15:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjifg-0005Hj-UR; Tue, 14 Jul 2026 15:20:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjiff-0002Ht-BA; Tue, 14 Jul 2026 15:20:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EJC5pZ2113207; Tue, 14 Jul 2026 19:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eSi2SD8LuL/2eEeZH
 9D26BmlvGUIMOuBCcaioz01kjQ=; b=TPO0rQlIwRiogeoQl2T0Sw7UZyYzVTBZG
 TRZeom+2fu/wNEH85N7CrMEAaAKZ1yaLQipVF62IIHGlecIwYc9eOQtF9LRx56l0
 OCYDbxy/ngYcpD/615KSZ6w40olGRqv6Qgt4qmuKn2z+u0t/1R+U108n48oBVeZh
 mso6y5pYNMVFGrmuLlFGJTVpx//nWNp1updLB0/mMk+nj7G/ldo4/CjwHAL2Rq4y
 cFEU7teRXzaVolUEVEHqkgqyDJZ4/sXyjE2tFzsDcS2kyXiTo2aloWcI64TfgMwG
 bp5/v/TxqRkMJCWkzcq5TrJaVBnW+Vrl5MhNP5p5Hk2nCkqu4PIGg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwqck1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:19:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EJJtWR001674;
 Tue, 14 Jul 2026 19:19:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw4g9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:19:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EJJodF25100614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 19:19:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4DF72004B;
 Tue, 14 Jul 2026 19:19:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E5C520043;
 Tue, 14 Jul 2026 19:19:50 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 19:19:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Harald Freudenberger <freude@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/2] target/s390x: Make PRNO TRNG interruptible
Date: Tue, 14 Jul 2026 21:17:18 +0200
Message-ID: <20260714191948.342204-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714191948.342204-1-iii@linux.ibm.com>
References: <20260714191948.342204-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _BTI1B6NlpI-w1P32ulHhVg1MaBbhfAI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5OCBTYWx0ZWRfX5HWnc9P0K8Cc
 YqK/aJGBPHWjElY8/ArK02qpcOgHUXD06lny3TlVM24ar/nKdfPGNT8hu7icHb9KAoEFo/KTRJr
 xhSn9UbHs3fRBWG+vQfFiZjTGvQ+bTq3rjE63HN8EFbeZCXnTE8MhYfMIueXkvKoI9i5OOURqcW
 HbX946A7zba3B75hKOb05fd39T6CFUpembwQjM0XcUU00dvpjruvcUFOy8tTGI65nDLJZcAixWS
 ipYMnv4U96wvp+C+l+p6SqU20empScRCte0C5FXEJjEfW5Nla0wSiVGVFw6zavlXHE9+3Ph2W37
 hZFo5+80PYEwXDQzdytTPMHi6UY0pZ6rhvRmEZjCEWKBMuAVNhbTxuTaSSjHP1vEygls5JfZtwJ
 i6JpZrIiwMNfU6GQRypGfRdGOFlyhBOqGVJqZF1wfcL2+VjlALAJFdfeERTIIn4DEzZyT/mPdtb
 ncrCwZQR3ErEv9Quhbg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a568bdb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=x4Cszyr3wkYQ39rAaogA:9 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _BTI1B6NlpI-w1P32ulHhVg1MaBbhfAI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5OCBTYWx0ZWRfXx5yTf6I/Epkr
 5CfiLJC6ATApZoPzv2Szmw3Qs6X9DTThMNEPTNwvKAgIIa3nacv4XIgMyXeNVntV6oDPv7MjMLZ
 H2dZPIgumznTtGreAvEslT0ZeMzRyuA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140198
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
---
 target/s390x/tcg/crypto_helper.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 8fe0a222198..6a5dbe1cafa 100644
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


