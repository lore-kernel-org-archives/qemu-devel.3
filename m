Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892F6C5AC81
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzmk-0007Ox-7F; Thu, 06 Aug 2026 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrzmf-0007FN-UX; Thu, 06 Aug 2026 11:13:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrzmW-0007ma-MD; Thu, 06 Aug 2026 11:13:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EnUKx2872752; Thu, 6 Aug 2026 15:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YoyQJzJO1UXUA0Ezv
 MExboCiyempYUHrtshNO+tINOM=; b=YZHmOrsZW+j45QU63/u0mpVohz+BTkTFh
 fTNCw3omKou46MXzRRf+EDw1F1N/5zfUFIw1CksOYaMOPne3LAhrphCOK673A4gb
 z64uO7XWf5rMhC4GLKa+09pZGwm84MYOQG1U86h3regXf8HdUM4q1J37ATKrNGyT
 2u/CAC+NnO2q2+XUqqw9UJRT3VZoA271iCQHNGEqHoly7LrqJp7rkbJonVCd9jKn
 4vUrDmbUFeKoMhpwqdX8RMK5BW/8QQPCY46Ee1NnbMUvqE91z2RYf81CvTWnHRAN
 nwf9ug8h3VKRJ/5tzleJLrM376XDt6WqobhxhYIEvjZpsBhiBSaiQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67j0k28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 15:13:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FBH9q005524;
 Thu, 6 Aug 2026 15:13:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kbprq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 15:13:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 676FD71J33030570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Aug 2026 15:13:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 321EC20043;
 Thu,  6 Aug 2026 15:13:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08E0920040;
 Thu,  6 Aug 2026 15:13:07 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.185])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Aug 2026 15:13:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v14 17/19] target/s390x: Support protected key AES XTS for
 cpacf km instruction
Date: Thu,  6 Aug 2026 17:12:59 +0200
Message-ID: <20260806151302.26846-18-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806151302.26846-1-freude@linux.ibm.com>
References: <20260806151302.26846-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX+h82x4AvjP39
 dOm6H014+H8ylV1RE/shDbRmdYdawjmnzSclZD3sAxpuy7wq5b/UsUf2Q7C3PRJ7dm/5O04OBMn
 fLuOlixu+8KnLneQgsJ0pGdOGl/CsqY=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a74a487 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=D0XGIOQStSI5JxgU9CcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX2MoNU4OaTUw1
 AT7silR87gCKb16TXGsi7ODKRt9e3QnHbvgAcN8S4QXa5qFR39cmRG2uyNGNHtpn/9ALOUoI24S
 JedQrQ9M5F2OV+TRn/rfle35TNFgmMgg71AuKRxj3FxhX8OUE84NQftkzm4SMjfjRZStiknP/jQ
 nl66bw/hYxRgbHEhXiMBUsfFlrcbAHYAW6haedl8abichI9OPOVAn+5BIm3wYQPiT9pTgEUbdsA
 5bHo8+vhqJ2uBZ84CX6c+uQFCEiaxBty0tSUlZJdfeki+m8IWjLbVX40E9YwiBc52YY47k7jrYZ
 0W59UtJms93f6gHqGnIcJibv2oVd3pL4kgfXVWgg7Xql3Ul/L2J/79jAA7VzGrpr2OMqdc8wB70
 UCZAcE0/Mx5gYLDJyPmkmPS5/29padP4ErgcHSJK1pO6aykjFanuirv0VIFHyJwJHIk+yj2Sg9w
 eMqVvtVdq51KejuEWpA==
X-Proofpoint-ORIG-GUID: 5qq-Q69bq7vn-klJs2aYhKEMPeFLZFEe
X-Proofpoint-GUID: 5qq-Q69bq7vn-klJs2aYhKEMPeFLZFEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060115
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PXTS_256
for the cpacf km instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 93 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  6 +++
 4 files changed, 105 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6b206cee83..0afea9fdd0 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -930,6 +930,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_EAES_256,
     S390_FEAT_KM_XTS_AES_128,
     S390_FEAT_KM_XTS_AES_256,
+    S390_FEAT_KM_XTS_EAES_128,
+    S390_FEAT_KM_XTS_EAES_256,
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 4d5e09f715..dc29834cf8 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -297,5 +297,9 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint8_t fc, uint8_t mod);
 int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint8_t fc);
+int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index d1f3b44a15..1de80a7a7f 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -779,3 +779,96 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return 0;
 }
+
+int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case CPACF_KM_PXTS_128:
+        keysize = 16;
+        break;
+    case CPACF_KM_PXTS_256:
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
+                       param_addr + keysize, wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
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
+    /* fetch tweak from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp),
+                       tweak, AES_BLOCK_SIZE);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* fetch one AES block into in */
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        if (mod) {
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
+        } else {
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
+        }
+        /* prep tweak for next round */
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    /* update tweak in param block */
+    write_guest_wrap_u8(env, mmu_idx, ra,
+                        param_addr + keysize + sizeof(wkvp),
+                        tweak, AES_BLOCK_SIZE);
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
index aa27889d97..47176c78be 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -117,6 +117,12 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case CPACF_KM_PXTS_128:
+    case CPACF_KM_PXTS_256:
+        rc = cpacf_paes_xts(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KM, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0


