Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23559D7236C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFaZ-0005Xc-I5; Fri, 23 Jan 2026 06:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZQ-0004zy-2t; Fri, 23 Jan 2026 06:43:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xc-NE; Fri, 23 Jan 2026 06:43:19 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N0bnfV007813;
 Fri, 23 Jan 2026 11:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4OgBkdDKW53MbGVR1
 ADm1TxvOXsXtqMpSiaLDfT61kk=; b=ZZwoB+UDa6T5jlllLbJNp6Khv8OBhk9r0
 l75etDPUs5Y54Nx8JRel0TVwktAWHE+jrpSmskNvWE77xSYwtDNK+lwrBGw57og9
 f9bVFpgyWsi+q+I+lPnVHitoeYHnv8o80Dvc7ktv7lr1IPONPUgz7FYSLiZ1PTL1
 AZpayM54EMYq8hKYdTLjYXfq9sYlpI52gMkA/Jsqsf1MqP1sa/O/lxCSJsx0V+dv
 GVwSVMK45S5dqyCS+6xdeF1j0Hf2JQUQ47nOgD1/Lja2exYz1uDeHv/atFFEGLy3
 p9v4B7ruRK7aKTtjpD+cZUlb6glQqR08/jgZlGL55Dluco2drHCjg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukp396-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NB7kJB009295;
 Fri, 23 Jan 2026 11:43:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8krrjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh9GM14680568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 723852004B;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64FA62004D;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 06/14] target/s390x: Support AES CTR for cpacf kmctr
 instruction
Date: Fri, 23 Jan 2026 12:43:00 +0100
Message-ID: <20260123114308.19401-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX7T/ME56Bx0El
 GAxPEULuzlXJq+HJAdfbgxeJNF7MWYgsEtvSmkYgKRSCL8EcSbmZOf3TARzAgRzw0P4Sg99PGDK
 mikJS2C/cDX6x42ud/kxK4U3aPDSx+XmiD5n98jiR1E3APU/benAoXUg1pdBRx3UhEL7E/f8c/j
 SGKmBI3TOJ5U6vkZ1ozDmovVaHoN9aBs61mp6rAGUXdjmTiAxGgp03LUXuNCgotQx4YZZQX1wZL
 2jObJiMWz2pKbRVfElLwrMF1JJb5Q3NW+noqFuhn7Pxpx9lLivpPIiAOzl2sozOFJt6AV/0Dz/4
 mws0nhiaJwhhbKDXmbvSi6g9bZ1FJdux/s6fENO0Ive7yZI+KFXfskEfL6EKRkMP0Zvt7LTgpvK
 62RhDQ5LErHro/A+WOxP9hRX+hppUEWzMkLYYRthVvheDUYa+o9MKi2War9Vmqt8kSbeDBcKz5u
 YWHvyIB39az7tIiVpPw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=FtH1yQ7YNcEQcFzwLPgA:9
X-Proofpoint-ORIG-GUID: 3pvW9YFa_dHc0HPM_iAktB_VBZeDgxJ6
X-Proofpoint-GUID: 3pvW9YFa_dHc0HPM_iAktB_VBZeDgxJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/s390x/tcg/cpacf.h         |  3 ++
 target/s390x/tcg/cpacf_aes.c     | 70 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 23 +++++++++++
 4 files changed, 99 insertions(+)

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
index 18686991f7..21fe2e4690 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -23,5 +23,8 @@ int cpacf_aes_ecb(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 int cpacf_aes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                   uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                  uint64_t *ctr_ptr, uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index df3d05db41..750de42f21 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -206,3 +206,73 @@ int cpacf_aes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                  uint64_t *ctr_ptr, uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len, processed = 0;
+    int i, keysize, data_reg_len = 64;
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
+        data_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
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
+        aes_read_block(env, *ctr_ptr + processed, ctr, ra);
+        /* encrypt ctr => buf */
+        AES_encrypt(ctr, buf, &exkey);
+        /* read in one block of input data => in */
+        aes_read_block(env, *src_ptr + processed, in, ra);
+        /* exor input data with encrypted ctr => out */
+        aes_xor(in, buf, out);
+        /* write out the processed block */
+        aes_write_block(env, *dst_ptr + processed, out, ra);
+        len -= AES_BLOCK_SIZE, processed += AES_BLOCK_SIZE;
+    }
+
+    *src_ptr = deposit64(*src_ptr, 0, data_reg_len, *src_ptr + processed);
+    *dst_ptr = deposit64(*dst_ptr, 0, data_reg_len, *dst_ptr + processed);
+    *ctr_ptr = deposit64(*ctr_ptr, 0, data_reg_len, *ctr_ptr + processed);
+    *src_len -= processed;
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


