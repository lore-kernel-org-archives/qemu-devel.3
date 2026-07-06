Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F628C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfra-0004Hy-5P; Mon, 06 Jul 2026 05:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgfrU-0004EB-Cz; Mon, 06 Jul 2026 05:43:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgfrP-0003y5-Gs; Mon, 06 Jul 2026 05:43:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IOIT3783318; Mon, 6 Jul 2026 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6K2/aGKo4zl5Q0Q1X
 6JKN0MRm24eGYnHs0LZDXPvgYk=; b=Fvzd323gGGyeDvR5jHglQ3kNLJWRXxVZi
 i1nJ5WUHenaoVePZxZzBgTHJa3SyfhSUzrClY8KJ6WdnzYiGIMHJxZpxSrvpWRmC
 Mh0e/xyvgdF5f9MuTtVyGzjtKQx4+RkmNdupnMK8tRkyIJtQ2R7/zWfzC2iohv9U
 h/waKIqIOMGsRvtdjiqo4CTcmbF+1thawcDkOB199aa+zhlmunzgJlLikyv2vr3H
 EWpCeVAX0Rrchzct+LAHVYsK48+u3woMUYQDOfyr9L/a6Zqc3hVNKaRKdg7TqktB
 5p8LQaNCwAtP3mRH08z2f8OrjeqMxfENuk+Su4LlllTXlwiybwZbw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4gqws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:43:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669YeQ5028347;
 Mon, 6 Jul 2026 09:43:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjw0gs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:43:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669hHns23397078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:43:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2CD82004B;
 Mon,  6 Jul 2026 09:43:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C11120043;
 Mon,  6 Jul 2026 09:43:17 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.193.81])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:43:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v10 08/21] target/s390x: Minimal AES XTS support for cpacf pcc
 instruction
Date: Mon,  6 Jul 2026 11:43:01 +0200
Message-ID: <20260706094317.17032-9-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706094317.17032-1-freude@linux.ibm.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qj1TfJ8Lie37xd41Yc2E8i_Md8qyZQwa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX4p8fDQnqclnG
 Eu6Az/gFz4Sw5ptmgzFhJCnlEWMdHGNt2gP8uMMLBBRG/j2feu20MZbm7hVlyBhg2cp5X72ss9I
 780xjC9Jxbh+XfEX1eVb6bo17hqAGGR6SjRDTl72kxb38VOrkn+yOcSOYtbpPh4kaqH+R3vt3R3
 V+m4EzsumIB0F4+26UfmkUYCGQEqmeMXm4dJtJhH1iArptuuVeG6GRwaMi2k18MY9wlSvNTj3yo
 W2s1v7PqFRcLFe83h3EsM6tbuX5v2GLCjXHD90Y+Kv4kZEFqWj2eU8kqgCQcFU0PCchp0VL0tja
 a40Up4f7/zKIh5APgRrigbybInvWdTnSApdQNB2sIt8SPY48hhcF/fZbdB1kwW8n9xFgbIE5w8S
 HCKkN7CtdEI5z7l3Sr8saCmmNsIlSE3LitalrJkJEEZeJt9TIZcLKRCirVQje3JCNY3b7Rpj9vv
 y1ei0ZDvuMsNIQL0otg==
X-Proofpoint-ORIG-GUID: qj1TfJ8Lie37xd41Yc2E8i_Md8qyZQwa
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b78bb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gr50lgQh3SlUKNVXMSoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX6iRkJtA+lmtf
 S3y5vrWt29qYjG5M5n7/qDqDB+VpCIYKhrIacrQMeBxU3Rttwz7VFogxGLlH1+9YocsmBm5wqB7
 HYmihF0HwL33lERnVL5arYqGYG1r15w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094
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

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
and PCC-Compute-XTS-Parameter-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390
AES XTS implementation in the Linux kernel and Libica and thus
also Opencryptoki clear key via Libica.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 63 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 20 ++++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 59c2a47539..1b6a874b90 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -930,6 +930,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_PCC_XTS_AES_128,
+    S390_FEAT_PCC_XTS_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 3707308661..2e8ed72758 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -247,5 +247,7 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint64_t *ctr_ptr_reg, uint32_t type,
                   uint8_t fc, uint8_t mod);
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 3d6aa19df2..f41b7dc541 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -290,3 +290,66 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    int keysize, i;
+    uint64_t addr;
+    AES_KEY exkey;
+
+    switch (fc) {
+    case CPACF_PCC_XTS_AES_128:
+        keysize = 16;
+        break;
+    case CPACF_PCC_XTS_AES_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + AES_BLOCK_SIZE + i);
+        buf[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* is the block sequence nr 0 ? */
+    for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
+            ;
+    }
+    if (i < AES_BLOCK_SIZE) {
+        /* no, sorry handling of non zero block sequence is not implemented */
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return 1;
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* fetch tweak from param block into tweak */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + 3 * AES_BLOCK_SIZE + i);
+        cpu_stb_mmu(env, addr, buf[i], oi, ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 9be8a14a80..1d447cef30 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -169,6 +169,23 @@ static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                     uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_PCC_XTS_AES_128:
+    case CPACF_PCC_XTS_AES_256:
+            rc = cpacf_aes_pcc(env, mmu_idx, ra, env->regs[1], fc);
+            break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -225,6 +242,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KMCTR:
         rc = cpacf_kmctr(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_PCC:
+        rc = cpacf_pcc(env, mmu_idx, ra, fc);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-- 
2.43.0


