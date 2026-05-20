Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B27CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbF7-0006Jl-LT; Wed, 20 May 2026 03:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEu-0006Dj-2m; Wed, 20 May 2026 03:21:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEp-0002Th-JH; Wed, 20 May 2026 03:21:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7CGHv790111; Wed, 20 May 2026 07:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ldzT7KQUgSHEwEhwX
 EHU5hYKYckSJlAntg3oDo4f4DM=; b=AWrJqPrHettdJhpsV/Y9AM0oBbPqVJcRk
 srepGmk2ks2VXTtEJpW6DuQJgHqi82K/pfCELnmZ+oZ3oZJboE2hza7nSbVGK5Ek
 Kt3YvFxhucO6XBgrlOrCO8ZhgVUjmYT5wthxmhisldv4EgYesXjXJm9pj33Fomjo
 +nIIE/hv05s2BAajlDKM7Imfzj/WAshdptDGX8jwl2mdVhB1RPb6pzabqgDzcfpR
 KOvbdpZHx2scL57X97Ust9C6CPGCYMMoH58vw2sbNp8YZ/nmKWSSNZof6OwRUAV1
 xlRvQa6ctcQ+BFWjle2rzJHoQi0ZKqowUOtzeA6WTezJ2BeoatNzQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8fwup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:21:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K79Hew029183;
 Wed, 20 May 2026 07:20:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhp7jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:20:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K7KuZ458130772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 07:20:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AE1E20043;
 Wed, 20 May 2026 07:20:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BB6A2004D;
 Wed, 20 May 2026 07:20:56 +0000 (GMT)
Received: from funtu2.fritz.box (unknown [9.111.209.15])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: [PATCH v5 07/15] target/s390x: Minimal AES XTS support for cpacf pcc
 instruction
Date: Wed, 20 May 2026 09:20:46 +0200
Message-ID: <20260520072054.293306-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520072054.293306-1-freude@linux.ibm.com>
References: <20260520072054.293306-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NyBTYWx0ZWRfX61d4ABj2aWqM
 +/eBYoAPrDGjXDkJ2GCXJYC6IUQaopKv0AutFKkFcBHZcuCNZNlVP5KFN1mqGSf/F/EIXAhowM5
 O8sDriPZ9urlJqwjwfCec1GB3pgTZmVXNS7kZ7FIGH6ecT3uqma5Hrubja9U1a965wNOGo2InF/
 qY3KCupUaYUoZEfxATI3sXgZRk6U2hk2UB5qP9Ih3h0TOJripzED4v7U/7vMz6dQVPsY5BG9nYg
 +25v+N8wFnP4pfK3ENjiR/zgTnJeD6L9gY7gpIbTx9H5wBOLK/IOCwHJVki3nodsyCTXHpooy0h
 od4a3KERQF5PHQX1sZMs+C5fLU1VOKaLG3ErlSa/+P8XOFx3/l6ZIU3Z1I6/wjMZIPl1Xu9UYJD
 SGFDPUtbj+17wpwAHS4d9oZRlvQf2qrdntf0yq7SkUtz6uEnouPfbJ14kT7jfy9thELQXF4udrS
 X1SO4ZkJ5hZeAMJ1mcQ==
X-Proofpoint-GUID: IcbsfL2_zcQ5VhhKuEQu_LZWN2EnD1-C
X-Proofpoint-ORIG-GUID: IcbsfL2_zcQ5VhhKuEQu_LZWN2EnD1-C
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0d60dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=gr50lgQh3SlUKNVXMSoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200067
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
 target/s390x/tcg/cpacf_aes.c     | 70 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 19 +++++++++
 4 files changed, 93 insertions(+)

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
index 7367e513e7..0e500eb183 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -29,5 +29,7 @@ int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                   uint64_t *dst_ptr_reg, uint64_t *src_ptr_reg,
                   uint64_t *src_len_reg, uint64_t *ctr_ptr_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 016b043c56..1fcb762099 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -15,6 +15,13 @@
 #include "crypto/aes.h"
 #include "cpacf.h"
 
+/* #define DEBUG_HELPER */
+#ifdef DEBUG_HELPER
+#define HELPER_LOG(x...) qemu_log(x)
+#else
+#define HELPER_LOG(x...)
+#endif
+
 static void aes_read_block(CPUS390XState *env, uint64_t addr,
                            uint8_t *a, uintptr_t ra)
 {
@@ -284,3 +291,66 @@ int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint8_t fc)
+{
+    uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    int keysize, i;
+    uint64_t addr;
+    AES_KEY exkey;
+
+    switch (fc) {
+    case 0x32: /* CPACF_PCC compute XTS param AES-128 */
+        keysize = 16;
+        break;
+    case 0x34: /* CPACF PCC compute XTS param AES-256 */
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + AES_BLOCK_SIZE + i);
+        buf[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* is the block sequence nr 0 ? */
+    for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
+            ;
+    }
+    if (i < AES_BLOCK_SIZE) {
+        /* no, sorry handling of non zero block sequence is not implemented */
+        cpu_abort(env_cpu(env),
+                  "PCC-compute-XTS-param with non zero block sequence is not implemented\n");
+        return 1;
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* fetch tweak from param block into tweak */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        tweak[i] = cpu_ldub_data_ra(env, addr, ra);
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
+        cpu_stb_data_ra(env, addr, buf[i], ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index c1c79daf19..a7f4e135e1 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -165,6 +165,22 @@ static int cpacf_ppno(CPUS390XState *env, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pcc(CPUS390XState *env, uintptr_t ra, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x32: /* CPACF_PCC compute XTS param AES-128 */
+    case 0x34: /* CPACF PCC compute XTS param AES-256 */
+            rc = cpacf_aes_pcc(env, ra, env->regs[1], fc);
+            break;
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
@@ -221,6 +237,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KMCTR:
         rc = cpacf_kmctr(env, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_PCC:
+        rc = cpacf_pcc(env, ra, fc);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


