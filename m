Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47D7D72379
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFaU-0005PY-Gt; Fri, 23 Jan 2026 06:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZS-00050P-1I; Fri, 23 Jan 2026 06:43:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xg-Sq; Fri, 23 Jan 2026 06:43:21 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NB4xpV009004;
 Fri, 23 Jan 2026 11:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6LLlKKEkrlolekgnS
 3DulKNFF8OxjxXDxrp+IIFSFkI=; b=YH4FwjdYhrEQBHqGENHphIG9gGuqCgf8o
 qUCVrpl/KRuLyxquaq4rEzoXVO2mp5BSsc94n14FIWKo4mVXqQQ76PbK58HsKld8
 ajguKhvHz0mHakMjThz/Bh8CGo56VAnucA4EHNprPECCJw9E/g30SnTrCCEFf9Mh
 ytnE8Ys/zCp4DWWCiplcM//FcKLw/379YEJ9ofH9M7/tsW/1pD1+VZQ3E3g/UZpK
 iAp5I2xoTBRONZkN33OD054V3Du1Fq639Rvh/FPgnirYTTANSyeGvAlI0tJYJHSK
 YTaoeX/Q1LZ7FWW0EasYx07CRKoazOsEiHNcvz4RB0SeN2k0omlDw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukp398-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N9lSxt016668;
 Fri, 23 Jan 2026 11:43:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4ygxuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh92m29033098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2C2820040;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B6B12004D;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 08/14] target/s390x: Support AES XTS for cpacf km
 instruction
Date: Fri, 23 Jan 2026 12:43:02 +0100
Message-ID: <20260123114308.19401-9-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX1RMh/RK0AlrA
 7dYmnqM1KY/MdYG3sIieDXXSZXfT43iuxxsNYawO1pKi3FlMNpH1pQWNnyxBytCLAqQ4PkA+H5c
 b5jy2pEpobfQKYo10mYonUniAHPIgt+LZlAdkk2sNsH8orxkzXN7tBVGYf2TFIyGneakzolV78X
 kR6wIkQuh1t/NFeQsvsaaz70bRqgR+SYMLaUo1yUOnS+cnxxk7lB2LPEXGwp82T8Rh3YmRE0yby
 E2z7724qD+18T9Nhk0M1NSopSG7sqFtWgcvNscuqQfrvh2n7AanFPbosCQ1xWKw2MrXGG46OSQL
 lyvzQIzbYC2zPyjRXzH8UYqcgTZTNzKCoTwgX3H97yqlSzwq8nc7TE+DFumnSRdMrglc4enaGvt
 IQs9hc493rDjqjLmItIlQsYlv542q+iMhodvmYZ9xSFBNisH7xr2h/HFiaWDxcSob+Eg21nkxkC
 qqaFdj133py54w/O2Gw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=x50AcNjeOBEj4zU0MaUA:9
X-Proofpoint-ORIG-GUID: A8h5aA3B7rDZLOTKmzNX4WK7NxkXgaNY
X-Proofpoint-GUID: A8h5aA3B7rDZLOTKmzNX4WK7NxkXgaNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
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

Support the subfunctions XTS-AES-128 and XTS-AES-256
for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   2 +
 target/s390x/tcg/cpacf.h         |   3 +
 target/s390x/tcg/cpacf_aes.c     | 103 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   6 ++
 4 files changed, 114 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 1b6a874b90..f9b1a40c7c 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -924,6 +924,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_AES_128,
     S390_FEAT_KM_AES_192,
     S390_FEAT_KM_AES_256,
+    S390_FEAT_KM_XTS_AES_128,
+    S390_FEAT_KM_XTS_AES_256,
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index aa39a3c85a..8c1dbee67f 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -28,5 +28,8 @@ int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                   uint64_t *ctr_ptr, uint32_t type, uint8_t fc, uint8_t mod);
 int cpacf_aes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                   uint8_t fc);
+int cpacf_aes_xts(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 1076322e30..f067939f25 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -346,3 +346,106 @@ int cpacf_aes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return 0;
 }
+
+static void aes_xts_prep_next_tweak(uint8_t tweak[AES_BLOCK_SIZE])
+{
+    uint8_t carry;
+    int i;
+
+    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
+
+    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
+        tweak[i] = (uint8_t)((tweak[i] << 1) | (tweak[i - 1] >> 7));
+    }
+
+    tweak[i] = (uint8_t)(tweak[i] << 1);
+    tweak[i] ^= (uint8_t)(0x87 & (uint8_t)(-(int8_t)carry));
+}
+
+int cpacf_aes_xts(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len, processed = 0;
+    uint8_t key[32], tweak[AES_BLOCK_SIZE];
+    int i, keysize, data_reg_len = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case 0x32: /* CPACF_KM_XTS_128 */
+        keysize = 16;
+        break;
+    case 0x34: /* CPACF_KM_XTS_256 */
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
+    if (mod) {
+        AES_set_decrypt_key(key, keysize * 8, &exkey);
+    } else {
+        AES_set_encrypt_key(key, keysize * 8, &exkey);
+    }
+
+    /* fetch tweak from param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        tweak[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* fetch one AES block into buf1  */
+        aes_read_block(env, *src_ptr + processed, buf1, ra);
+        /* buf1 xor tweak => buf2 */
+        aes_xor(buf1, tweak, buf2);
+        if (mod) {
+            /* decrypt buf2 => buf1 */
+            AES_decrypt(buf2, buf1, &exkey);
+        } else {
+            /* encrypt buf2 => buf1 */
+            AES_encrypt(buf2, buf1, &exkey);
+        }
+        /* buf1 xor tweak => buf2 */
+        aes_xor(buf1, tweak, buf2);
+        /* prep tweak for next round */
+        aes_xts_prep_next_tweak(tweak);
+        /* write out this processed block from buf2 */
+        aes_write_block(env, *dst_ptr + processed, buf2, ra);
+        len -= AES_BLOCK_SIZE, processed += AES_BLOCK_SIZE;
+    }
+
+    /* update tweak in param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        cpu_stb_data_ra(env, addr, tweak[i], ra);
+    }
+
+    *src_ptr = deposit64(*src_ptr, 0, data_reg_len, *src_ptr + processed);
+    *dst_ptr = deposit64(*dst_ptr, 0, data_reg_len, *dst_ptr + processed);
+    *src_len -= processed;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index a7f4e135e1..7129b38703 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -101,6 +101,12 @@ static int cpacf_km(CPUS390XState *env, uintptr_t ra, uint32_t r1,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case 0x32: /* CPACF_KM_XTS_128 */
+    case 0x34: /* CPACF_KM_XTS_256 */
+        rc = cpacf_aes_xts(env, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KM, fc, mod);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


