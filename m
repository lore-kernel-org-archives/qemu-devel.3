Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3831CD98F5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmt3-0007FM-S9; Wed, 17 Jun 2026 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wZmsw-00075X-OQ; Wed, 17 Jun 2026 05:48:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wZmsu-00039i-1R; Wed, 17 Jun 2026 05:48:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mDov4104791; Wed, 17 Jun 2026 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UQE1RJsrMcPn7M+AG
 1mxjRbhMMn3csZqZ9UzCC7RhVA=; b=sPYCa9ZvtuXe7Q8WZfLlPtrECAzhuUiXa
 aYaGd8jRsQn+uh3Zus5lEsML0Cu7jzvfQ0xxNmWTMlVwtxMzeRdD9AYMTB0N4MLg
 hP52AV7k2JcXOGMow/tg9MYm3vJpzM/tcMZ0M2lNs9JbyHbSV/nUY55iifGAU3hN
 PHpJPfk7WkH2VnIFE0pOPsDa8lSIAsgjYZjEwJgxVVJmRFq3krqN6OeHHj+leAso
 0RGzBKL2CZDYL3p4SYiIwwGyuA4qgdvZJJEjPXB1tQEdjF2W+zcV/522ytVu1Ex6
 rKp9iAc/PqmbAMa559jioKyV5Gldl0qtgxWZGugVGbF/IMQHNtwnw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvt90k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:48:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9Yg83008365;
 Wed, 17 Jun 2026 09:48:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvaags1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H9mN4t60621154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 09:48:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29DCF20043;
 Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBD122004E;
 Wed, 17 Jun 2026 09:48:22 +0000 (GMT)
Received: from funtu2.ehn-de.ibm.com (unknown [9.224.92.54])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 09:48:22 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v7 09/17] target/s390x: Support pckmo encrypt AES subfunctions
Date: Wed, 17 Jun 2026 11:48:12 +0200
Message-ID: <20260617094820.34402-10-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617094820.34402-1-freude@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX1WKpvu/TibOJ
 769ZjV1hC8x0Guym7UNt0nTaNb6mgEhs5/p4uiFQDQFYdPRzqn3H3IFuHvZo2UmiqCfkrfSaNhO
 D21gYyciWGR14ENGI5XQ86IZNNJetqo=
X-Proofpoint-GUID: DrvbIl7ZnYr6zJ_54XkkzOciabOyviMu
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a326d6c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Z4AAViVgUL_E5abT2tgA:9
X-Proofpoint-ORIG-GUID: DrvbIl7ZnYr6zJ_54XkkzOciabOyviMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXyLGr51MBGacJ
 bmSejIrHnkhXrUk2htN3CQJhrw0dv6FrIH4rCIv24Cbb5kB4PyXXLecyngOunOFfoQDZ+gsa9eg
 C332kFUKZqQPOP9N4xHj32n7hDbeQCF/pTzlw85RtbfWj2T6irTcHEV6zTk9GvJa3KKlDKmPOCF
 bOYEudC/zsVah5xApWJUrFpqTs8399tYzQVnyzOJu+Vij4G3xwldA8gvHJfJv+S4ufNcxmWERRS
 n13R0Ing2ghNKxxspoY5DBveCzykWcSD2m8kNNv674ux5tzHlMuoTnutgp0oRvasXpJuwkdizUw
 Z6GRTRkeF5aSNcGJOQlT3H7K176hpFEcPwJ9OloFut1nVQnbDDZ9M2OAwTq5E+oL5Phm37HHIYE
 6h/URZtd0320jYV/mkWfPMTarvHEjgLLfQIHJ5HL446ZTQdPhgWzdFBZj5+cdNFM4+9+CG64u5A
 ll+k3fY8/tdOwFvJAUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092
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

Support the subfuctions PCKMO-Encrypt-AES-128-Key,
PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key.

These subfunctions derive a protected key from an AES clear key
by encrypting it with an internal AES wrapping key. More
details can be found in the "z/Architecture Prinziples of
Operation" document.

The qemu version provided here is only a fake indented to make
protected key available for developing and testing purpose:
* The protected key is 'derived' from the clear key by xoring
  the fixed pattern 0xAAAA... onto the key value.
* The AES Wrapping Key Verification Pattern is a fixed
  value of 32 bytes 0xFACEFACE...

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 66 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 21 ++++++++++
 4 files changed, 92 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index f9b1a40c7c..d3e69aaca6 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -934,6 +934,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCKMO_AES_128,
+    S390_FEAT_PCKMO_AES_192,
+    S390_FEAT_PCKMO_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 7e53ce2a14..5588e2bdec 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -38,5 +38,7 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 0312436c43..5a0a3473d5 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -467,3 +467,69 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+/*
+ * Hard coded pattern xored with the AES clear key
+ * to 'produce' the protected key.
+ */
+static const uint8_t protkey_xor_pattern[32] = {
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };
+
+/*
+ * Hard coded wkvp ("Wrapping Key Verification Pattern")
+ */
+static const uint8_t protkey_wkvp[32] = {
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E };
+
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t key[32];
+    int keysize, i;
+    uint64_t addr;
+
+    switch (fc) {
+    case 0x12: /* CPACF_PCKMO_ENC_AES_128_KEY */
+        keysize = 16;
+        break;
+    case 0x13: /* CPACF_PCKMO_ENC_AES_192_KEY */
+        keysize = 24;
+        break;
+    case 0x14: /* CPACF_PCKMO_ENC_AES_256_KEY */
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* 'derive' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+
+    /* store the protected key into param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        cpu_stb_mmu(env, addr, key[i], oi, ra);
+    }
+    /* followed by the fake wkvp */
+    for (i = 0; i < sizeof(protkey_wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        cpu_stb_mmu(env, addr, protkey_wkvp[i], oi, ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 19d625f37f..e1952ae4bc 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -192,6 +192,24 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                       uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x12: /* CPACF_PCKMO_ENC_AES_128_KEY */
+    case 0x13: /* CPACF_PCKMO_ENC_AES_192_KEY */
+    case 0x14: /* CPACF_PCKMO_ENC_AES_256_KEY */
+        rc = cpacf_aes_pckmo(env, mmu_idx, ra, env->regs[1], fc);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -254,6 +272,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCC:
         rc = cpacf_pcc(env, mmu_idx, ra, fc);
         break;
+    case S390_FEAT_TYPE_PCKMO:
+        rc = cpacf_pckmo(env, mmu_idx, ra, fc);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


