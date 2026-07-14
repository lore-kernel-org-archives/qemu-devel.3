Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6668AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbUW-0003E9-Vp; Tue, 14 Jul 2026 07:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbUU-0003Ck-UX; Tue, 14 Jul 2026 07:39:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbUT-0003jy-BK; Tue, 14 Jul 2026 07:39:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6g9vP547545; Tue, 14 Jul 2026 11:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LyEMwWj2OG++A/94D
 kYOO8antjNJ25WWbew+9An2J1A=; b=A41mKdL3MTdTzsU0C3rdbifQhN0KWmoAd
 WMnyFKrq8E3w3lfnsz5DjdwQE0mmAS9fgLGTcqCePHqxRqS33DAAKbWegRc31Pi5
 ttyY54pe8ohwsgQrQwT4OmcrkQ8/CxCumK3irNTMVzDpTflMwr0IdRmmmI4x4mSK
 cmnF2QafMo3PkLaZUiL/MWsnKtu+AtrszuvsE1rtHsecLGyaHf+KG09hGMXtkDtj
 +TjcPtjsqhiMCUJH1RQwFuLV3SBUA4Uemga593YjtBO4QTJNs8f+ui/pxcSliXcQ
 WtY4fe5eVxOrCBHg27vCegAh2vfdKBnY0c4xeaK/fzEjTnta29Dew==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnefw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:39:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBZ0B3015614;
 Tue, 14 Jul 2026 11:39:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhaf0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:39:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EBdmO562456244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 11:39:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFBCC2004D;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A8822004E;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.75.242]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Harald Freudenberger <freude@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/s390x: Make PRNO TRNG interruptible
Date: Tue, 14 Jul 2026 13:34:50 +0200
Message-ID: <20260714113946.275122-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714113946.275122-1-iii@linux.ibm.com>
References: <20260714113946.275122-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a562009 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=x4Cszyr3wkYQ39rAaogA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNiBTYWx0ZWRfX59+okGRvs34D
 t722Bh+14L6yHgn02KJZeNoHCDNunsqvJCLEtvenhj/q+ymiT5p5XFIUqVI1XP1qbSuR/F0q2KZ
 uby2I+1E+QE1TJpeOy774ROpdwmZCTV4xG8Qkef4Ot3/7XToFWs6GYh4K/n/2Ocq68z3R6akcjd
 eF6YvIDwnHvTuvBo9bvTyv0NqXxmh52vlBZFxrKdetImpdulNRv56dOwgsBr9TmosqUDT/uKuDV
 w6v4rKXV2XWHAghjUZePZylITvjkqSBk8cNi0nUb90zV53LGaa6GF8j+DQqb78FNh8ISFP8J/rm
 JTmHUTpLzjEGRwRtCHZA91VUTzsNiXjFwfKAdyJKhrL6TWY1vUdbBUWxNtGIZBTQ0Xu6uS9itzl
 AhBNcWfNrWY3vmJ1c0hBOTJ446YXACd6eCUKNDKeTlkppBD3ntqz7FoGjaZkKkJl/ckJCQ1cNx0
 dIZciptZAbvkFeCghXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNiBTYWx0ZWRfX0QnSe9ogITXp
 VZWuWn9BVewuMpC82s5yOY8G8YsKH52wH5/FMLm/Mppab6eEg+X5JfaIk/Ps1Ozz8Fk29l66nFv
 JL1o7k+9DXKBjNTua25kk/1QXrMMzVk=
X-Proofpoint-GUID: gnNys6hW9J-ilE7IymUYmLTGvqfDarRu
X-Proofpoint-ORIG-GUID: gnNys6hW9J-ilE7IymUYmLTGvqfDarRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140116
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

Do the same thing as cpacf_sha512(): process only a limited amount of
data per instruction execution and report partial completion with
condition code 3. This way the guest reissues the instruction, and
pending interrupts can be handled in between.

Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: 3dbc5fdacb5a ("target/s390x: support PRNO_TRNG instruction")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 8fe0a222198..4902c4e93ba 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -242,12 +242,13 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return !len ? 0 : 3;
 }
 
-static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
-                            uint64_t *buf_reg, uint64_t *len_reg)
+static int fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                           uint64_t *buf_reg, uint64_t *len_reg)
 {
+    enum { MAX_BYTES_PER_RUN = 8192 }; /* Arbitrary: keep interactivity. */
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t tmp[256];
-    uint64_t len = *len_reg;
+    uint64_t len = *len_reg, processed = 0;
     int buf_reg_len = 64;
 
     if (!(env->psw.mask & PSW_MASK_64)) {
@@ -258,6 +259,10 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     while (len) {
         size_t block = MIN(len, sizeof(tmp));
 
+        if (processed >= MAX_BYTES_PER_RUN) {
+            break;
+        }
+
         qemu_guest_getrandom_nofail(tmp, block);
         for (size_t i = 0; i < block; ++i) {
             cpu_stb_mmu(env, wrap_address(env, *buf_reg), tmp[i], oi, ra);
@@ -265,7 +270,10 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             --*len_reg;
         }
         len -= block;
+        processed += block;
     }
+
+    return !len ? 0 : 3;
 }
 
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
@@ -278,6 +286,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
     MemOpIdx oi;
+    int cc;
 
     switch (type) {
     case S390_FEAT_TYPE_KMAC:
@@ -308,9 +317,13 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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


