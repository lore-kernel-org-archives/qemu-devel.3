Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93A9CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcIhZ-0005oT-9w; Wed, 24 Jun 2026 04:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wcIh8-0005ej-6L; Wed, 24 Jun 2026 04:10:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wcIh4-0005jO-Rh; Wed, 24 Jun 2026 04:10:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O6IPJT299255; Wed, 24 Jun 2026 08:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NQM35rD/wAa15nM54
 R6FB5XTBVyQlKBcoLY/z0cYsW0=; b=foAtzgo89L2wO/zIlIXV6IUxWvjBfuRvI
 5JuzfGbGAAW+eo57oHhX+0W79tysDZItg822CT5B8NS/nhu187Jz7Lp8oWOrnaLb
 XmlX4cZipDOICrT8BmA+y3h/3s7RhmdoE4KZhGUT61ckpUl2VPYcCCVX/JZKoS0X
 BCZpuD9XnMtE2wIoPWM84HGWtl4aIF0AVF6Kx+988SUkZ1F7mX97KB806tz911j1
 vcVw5dPYHmE6ROwfXHpGHsIoAp+KBG3RnD6CGjYLUCNz41omtR3Syx176WEr0p/J
 g4cItn6gISzsCv81WeP+YNt4FX3LHg5anwVA3LOTbfaLw7ivJJ1SQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqu082-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:10:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84fYN010425;
 Wed, 24 Jun 2026 08:10:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwfq19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:10:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65O8AWFf47579510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 08:10:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D8162004D;
 Wed, 24 Jun 2026 08:10:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 000BE2004B;
 Wed, 24 Jun 2026 08:10:31 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 08:10:31 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 06/18] target/s390x: Support AES CBC for cpacf kmc
 instruction
Date: Wed, 24 Jun 2026 10:10:03 +0200
Message-ID: <20260624081029.23815-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081029.23815-1-freude@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3b90fd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4s_zGP7M7QCs5o7xjogA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX1yVkJhHnVKAq
 AeaJ8QJEmhSXRjaEo6N80dRQlkHlFmlHvPqcDRE0b6V4zabKgfnws97YfQX7rb4BAGXByyQAgm1
 pFevlrYUSXMEhleKCaZ5qbz+p2fUplSGpurFrR7qeWR8P0YlLAlsq6lrLZR8z3q4T7OtWd0+R7z
 XuBORiVJo2gsyofVCZbZpLf095wbRHXkPAv/o2VNFUzVJj9+KQaaKaw/CbOvgsf6CgLT3RyWiyo
 9q2gdqqyX41A5R1CEhtEZsUk/bTQDgfMtDvTM33U5irNUYTX4Y+gjAaDJG4IQcWk7UzeePqZLwt
 GCiyBEdEOF3I//G/cAoRYui9Tx1Nq5kYWw8aKi2ymXpM/kqq1/suFUX7C6gXQEGwe8vhtYH+7Fr
 e1jaM8Nfc7592YiHkUCtxcVGSA3SQ/B3nAoqMYwltrUJl3BKP+sOY71Ojox60WnZlKCtcOTsiXk
 dgmKagbEG5GT8tjCJVw==
X-Proofpoint-GUID: zJCglAIvIvPd-YimXJCAVbz8XinsCRh6
X-Proofpoint-ORIG-GUID: zJCglAIvIvPd-YimXJCAVbz8XinsCRh6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX6p6VfdIT2ziB
 JLfOsDEFS9NCGQ1Eh0Whbnhj9V8nayUOTBdKK05SImKivrpAkCVG+pnD616YrUFC5W1U4AXzPDn
 fFwIXz+95Fh7JPwlWrNT6TmsI3aBjQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240063
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

Support the subfunctions CPACF_KMC_AES_128, CPACF_KMC_AES_192
and CPACF_KMC_AES_256 for the cpacf kmc instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 102 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  24 ++++++++
 4 files changed, 133 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a35d1fd2f9..9c0c0b229f 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -924,6 +924,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_AES_128,
     S390_FEAT_KM_AES_192,
     S390_FEAT_KM_AES_256,
+    S390_FEAT_KMC_AES_128,
+    S390_FEAT_KMC_AES_192,
+    S390_FEAT_KMC_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 2c6263fc7f..2220a53d94 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -26,5 +26,9 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index ba836f1473..6412cc187d 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -111,3 +111,105 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t *dst)
+{
+    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+        dst[i] = src1[i] ^ src2[i];
+    }
+}
+
+int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    uint8_t key[32], iv[AES_BLOCK_SIZE];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMC);
+
+    switch (fc) {
+    case 0x12: /* CPACF_KMC_AES_128 */
+        keysize = 16;
+        break;
+    case 0x13: /* CPACF_KMC_AES_192 */
+        keysize = 24;
+        break;
+    case 0x14: /* CPACF_KMC_AES_256 */
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
+    /* fetch iv from param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + i);
+        iv[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
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
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        if (mod) {
+            /* decrypt in => buf */
+            AES_decrypt(in, buf, &exkey);
+            /* buf xor iv => out */
+            aes_xor(buf, iv, out);
+            /* prep iv for next round */
+            memcpy(iv, in, AES_BLOCK_SIZE);
+        } else {
+            /* in xor iv => buf */
+            aes_xor(in, iv, buf);
+            /* encrypt buf => out */
+            AES_encrypt(buf, out, &exkey);
+            /* prep iv for next round */
+            memcpy(iv, out, AES_BLOCK_SIZE);
+        }
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
+    }
+
+    /* update iv in param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + i);
+        cpu_stb_mmu(env, addr, iv[i], oi, ra);
+    }
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
index 28baebaad4..590adff9e6 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -110,6 +110,27 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                     uint32_t r1, uint32_t r2, uint32_t r3,
+                     uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x12: /* CPACF_KMC_AES_128 */
+    case 0x13: /* CPACF_KMC_AES_192 */
+    case 0x14: /* CPACF_KMC_AES_256 */
+        rc = cpacf_aes_cbc(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KMC, fc, mod);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                       uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
 {
@@ -177,6 +198,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KM:
         rc = cpacf_km(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_KMC:
+        rc = cpacf_kmc(env, mmu_idx, ra, r1, r2, r3, fc, mod);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-- 
2.43.0


