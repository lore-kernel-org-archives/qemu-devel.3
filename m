Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48786C56207
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzmm-0007Qj-Am; Thu, 06 Aug 2026 11:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrzmf-0007FO-US; Thu, 06 Aug 2026 11:13:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrzmW-0007mV-Qj; Thu, 06 Aug 2026 11:13:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EnWIY1080237; Thu, 6 Aug 2026 15:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qrSXkVJfHNdlTtbQp
 5q2Z1Zh2jtK5UOfdNzuOJQA2JI=; b=WS6mT5gmASYQvO7Z5Sv9eVpjVu/HHqigK
 gtHdhBmnTp1yavIX4W8/ZMDUsqqpkGJ06yiHXt4DHTU2p7eS824xlF0pC/eHIlvf
 c94WrBnwinAJ2FX6gIEn843FtkJmZgh8RTihvVd2CjdLsN2LMidg3IfWoVBtdPME
 HgeRHS64FJtqQ9+0JQss0ABekCe2YfbLreN0Jwq0je9mMuKevPgGH5cvSTc99wJG
 gPdO50S2siODs9L2cx/5LlDOrx0bsLjMpvoKDnBaLWGhOYCT34JV1WOI4RD3gwrr
 Pw9HC6a2e1tu9vX25U8iq6d5J6qn+H2nj2YkFBKrJSw928vPcm3Qw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr0u83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 15:13:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FBOik031017;
 Thu, 6 Aug 2026 15:13:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qutj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 15:13:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 676FD6EU32965050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Aug 2026 15:13:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99A0220043;
 Thu,  6 Aug 2026 15:13:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FEE920040;
 Thu,  6 Aug 2026 15:13:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.185])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Aug 2026 15:13:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v14 14/19] target/s390x: Support protected key AES CBC for
 cpacf kmc instruction
Date: Thu,  6 Aug 2026 17:12:56 +0200
Message-ID: <20260806151302.26846-15-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806151302.26846-1-freude@linux.ibm.com>
References: <20260806151302.26846-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -La36u0fUcZd_0JX_S2caJgBjxPQSS3v
X-Proofpoint-ORIG-GUID: -La36u0fUcZd_0JX_S2caJgBjxPQSS3v
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX/Q4OzZfaNwwI
 xgXWtRwBu3f+x2gDph3pP7uTn/3Nvg/te3gqPIJky++mK69cblkh5yeIrb3yr0DcpGlHrVU5QoH
 mPRTYKZCLEbzNzdfCd6hsvTOcu7U3o8=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a74a487 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=8AYr_lYigW3ys9mEaM0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX/G9O5NTPkOYd
 whQs1qnsy9dvPAJsuQvucLLL2nfb0fWSOttG4t5DvZjImXQgP88btcQ+/xBELlLa+y4EhvZORx5
 GOTAq8UOOEx8K/Or4WK7j/JsHRvY8ry4b8Wdfl2Rnxuk2qnBSi2CF4H88gP5ocZCUxkhzEJOTJ9
 EqBB7T9ruA7J35/B/+XJL053q+wU34pyVsEf4ByxN0UzhMR8Ts2X/+5IxqIN+T4w1sq6QxQPXge
 R0xJ85vIsWq4y7yZnhsad+07/xQvIvs2GabXFFVA73krrAxRE1xFtxHyZuA/pkZzyDRyY4LvhhX
 6ISoBxR2AdGkMApLFLxdfkBS0ocSY+tEjIx3vDUZHuVdLgn+mdl4Y8MOypPXEFvSAZd0qLgyPXe
 HU870KPYPX/tZ1n9FCElG3sfHMAD4Ghenw3HyRpUIJ19slGnyNeOomtcQnU/6VAAzDM55BhgJfG
 AAz1JOMcaNuxAagB7bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
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

Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
and CPACF_KMC_PAES_256 for the cpacf kmc instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 90 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  7 +++
 4 files changed, 104 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 17de37f183..d1fce9e00c 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -933,6 +933,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
+    S390_FEAT_KMC_EAES_128,
+    S390_FEAT_KMC_EAES_192,
+    S390_FEAT_KMC_EAES_256,
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index b13746b48f..7e8b7fb222 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -286,5 +286,9 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint64_t *dst_ptr_reg,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index a6d3efb383..7373609ced 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -544,3 +544,93 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMC);
+
+    switch (fc) {
+    case CPACF_KMC_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMC_PAES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMC_PAES_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    }
+
+    /* length has to be properly aligned. */
+    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* fetch and check wkvp from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + AES_BLOCK_SIZE + keysize,
+                       wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch iv from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
+
+    /* fetch protected key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + AES_BLOCK_SIZE, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* expand key */
+    if (mod) {
+        AES_set_decrypt_key(key, keysize * 8, &exkey);
+    } else {
+        AES_set_encrypt_key(key, keysize * 8, &exkey);
+    }
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        if (mod) {
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
+        } else {
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
+        }
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    /* update iv in param block */
+    write_guest_wrap_u8(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index b4e9407d60..3c6dd74c70 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -138,6 +138,13 @@ static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KMC, fc, mod);
         break;
+    case CPACF_KMC_PAES_128:
+    case CPACF_KMC_PAES_192:
+    case CPACF_KMC_PAES_256:
+        rc = cpacf_paes_cbc(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KMC, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0


