Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C6CCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbF5-0006J0-Te; Wed, 20 May 2026 03:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEt-0006Di-Q9; Wed, 20 May 2026 03:21:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEp-0002TT-DX; Wed, 20 May 2026 03:21:10 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JKfbeZ4007920; Wed, 20 May 2026 07:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gVK+zd0SZBqcAKbD4
 vzLg/mPVlEmi5OshewvlIsbCPY=; b=IDfS2zphfs14yQjy0TluLUHwXXWoR/J6q
 AkcOXiYhiYYxH6XOkckjmQa2Fy7Tw1EAdFGoeDOWUO4BT7h6KdgQho7qCT12ASmE
 fn6809r2rAqqd12ptT+QxeTKhLqxD5WnbU3p2pQhgrCnNrY2Zz1iP/dKEmU1m2XQ
 3QqkT5msODZk3Vqg3G+0EtYRsYwC3U7MWdaRyUS9AakVv6ir7ft24CSYfCZVP3DB
 19j38T9wkbJOKJ3UWnGLhG6cJUNiT5z6nrN7ZvaMeieoi54iuwEVUVuxWpmscoPH
 wIihPB/6db17s6xewTKVJ08I2FrYYnxI7Q1MQX6ItpcSLbxBo6vvg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y0x6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:21:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K799Dw021265;
 Wed, 20 May 2026 07:20:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vxdr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:20:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K7KuZn58130770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 07:20:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0737B20040;
 Wed, 20 May 2026 07:20:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBBD62004B;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
Received: from funtu2.fritz.box (unknown [9.111.209.15])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: [PATCH v5 06/15] target/s390x: Support AES CTR for cpacf kmctr
 instruction
Date: Wed, 20 May 2026 09:20:45 +0200
Message-ID: <20260520072054.293306-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520072054.293306-1-freude@linux.ibm.com>
References: <20260520072054.293306-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NyBTYWx0ZWRfX1ZwQqgK1rBYU
 GkuV7LaXxmUYByeQZkFA30Bct/27c9E0F5odJRANmZSH+vBUftOKy+lNBj9jMqV0Ux+OR4lMPZi
 wSS0zp3D2HrkYfpVEnveSa1bvclv8b55xWgZXeFfT3g9lAoYiu7LaCkiSRz2Nv5Vo/LJL1tP3Ue
 sA2PrMwpgb9w3+RbUAZfPZQgx2NzEvQa6uBii+3jUe5r3RZnIBT1aAMYBsWSMotVlTdxtBEgPku
 BhY0MIpE4BtqLh9DpCb1QVXq88dVURb3LzU21bNl2tz1Na4PTvp3i8uTOqYDwUNW8lQr8KHqR//
 suNFE1kXAbM03awjM6b/h06lEKBSdXt9eTsjIl02Czoq4iBW948cv6Wt9Z872G6t3EXPkCeIU+j
 N78tlGyQSFAywwedK77a3yT9yK3A2rXULAzwmT++CHsawSCFVfc2YyQs0xvukIutYmJYbSNc/Ne
 FhlB5m95NhL7QvyMw2A==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0d60dc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=FtH1yQ7YNcEQcFzwLPgA:9
X-Proofpoint-ORIG-GUID: TBz22JI53ixjQiHktaNemYYPTGw2dWQP
X-Proofpoint-GUID: TBz22JI53ixjQiHktaNemYYPTGw2dWQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200067
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

Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 74 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 23 ++++++++++
 4 files changed, 104 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 9c0c0b229f..59c2a47539 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -927,6 +927,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
+    S390_FEAT_KMCTR_AES_128,
+    S390_FEAT_KMCTR_AES_192,
+    S390_FEAT_KMCTR_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 96dc61e94f..7367e513e7 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -25,5 +25,9 @@ int cpacf_aes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                   uint64_t *dst_ptr_reg, uint64_t *src_ptr_reg,
                   uint64_t *src_len_reg, uint32_t type,
                   uint8_t fc, uint8_t mod);
+int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr_reg, uint64_t *src_ptr_reg,
+                  uint64_t *src_len_reg, uint64_t *ctr_ptr_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 3a7420de48..016b043c56 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -210,3 +210,77 @@ int cpacf_aes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr_reg, uint64_t *src_ptr_reg,
+                  uint64_t *src_len_reg, uint64_t *ctr_ptr_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    uint8_t key[32];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMCTR);
+
+    switch (fc) {
+    case 0x12: /* CPACF_KMCTR_AES_128 */
+        keysize = 16;
+        break;
+    case 0x13: /* CPACF_KMCTR_AES_192 */
+        keysize = 24;
+        break;
+    case 0x14: /* CPACF_KMCTR_AES_256 */
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
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* read in nonce/ctr => ctr */
+        aes_read_block(env, *ctr_ptr_reg + done, ctr, ra);
+        /* encrypt ctr => buf */
+        AES_encrypt(ctr, buf, &exkey);
+        /* read in one block of input data => in */
+        aes_read_block(env, *src_ptr_reg + done, in, ra);
+        /* exor input data with encrypted ctr => out */
+        aes_xor(in, buf, out);
+        /* write out the processed block */
+        aes_write_block(env, *dst_ptr_reg + done, out, ra);
+        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
+    }
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
+                             *ctr_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index df01c1c54e..c1c79daf19 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -128,6 +128,26 @@ static int cpacf_kmc(CPUS390XState *env, uintptr_t ra, uint32_t r1,
     return rc;
 }
 
+static int cpacf_kmctr(CPUS390XState *env, uintptr_t ra, uint32_t r1,
+                       uint32_t r2, uint32_t r3, uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x12: /* CPACF_KMCTR_AES_128 */
+    case 0x13: /* CPACF_KMCTR_AES_192 */
+    case 0x14: /* CPACF_KMCTR_AES_256 */
+        rc = cpacf_aes_ctr(env, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return rc;
+}
+
 static int cpacf_ppno(CPUS390XState *env, uintptr_t ra,
                       uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
 {
@@ -198,6 +218,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KMC:
         rc = cpacf_kmc(env, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_KMCTR:
+        rc = cpacf_kmctr(env, ra, r1, r2, r3, fc, mod);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


