Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BB0D7237B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFad-0005dW-8p; Fri, 23 Jan 2026 06:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZS-00050R-0h; Fri, 23 Jan 2026 06:43:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xa-SG; Fri, 23 Jan 2026 06:43:21 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N0DXW2014261;
 Fri, 23 Jan 2026 11:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7Ju4lyk4BRJZK0w41
 IZBY8y6Ixl7MX7K4eG5fOiz91Y=; b=BAhsrfecwHc+J77ogl4zaYEKjtCZYZvX6
 Xwt2LcS4qkkw0CBXUQ0z6tiUXBFzrlkV0CvKWui8bIiuq8xsIq2g+8Do/xGB/odd
 BMhQbvg29GvivOX8LVmFFA5Fl/YVfTiKhgFvdZEziRHRUcnPGHb/dJgHVZwQ9sAF
 KgVShu46DdNCTSxfou8ulbkBEDhK9CGol8VeSWHvhEzBDjJ+WkzoQfWlBop9j1L6
 DrdFOTQbm8EDllfOvSJ9myBVA5FFgGvtxjGN1U8SXzHSAG5tilMhMEnGp8QTdqBK
 StLkFyU9e/VjnBkG/IjceIi173GQA4ybI14pvQ1Y99dZqkVU4xbGQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukp395-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NAMffU024614;
 Fri, 23 Jan 2026 11:43:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas74cn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh90m14680570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9772E20043;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 808F020040;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 07/14] target/s390x: Minimal AES XTS support for cpacf pcc
 instruction
Date: Fri, 23 Jan 2026 12:43:01 +0100
Message-ID: <20260123114308.19401-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfXzNBAQ4KYtLjL
 I3ThYpzT9lp/wSi607FGjkKDbkjzYN5c+aYVcGR9OCKKhxuQWqQuZ4ph7Fxe28gesiONW742AWX
 GI31ACHysMQdHsQtb+GA/nhIR4oEZUqa0+faFDnHVMdUaolBjKLER7G7q00srmDg3+ZNAbWY3y1
 neEGGVYqZvFGi48fWnN6csnWHp4KIZ50waH3p+7cTXiiz9qkthyG6EKP7If6R6cw3HwlTRLF8he
 3GmvD/RFKODCzagFBmn1N57ZfQUauZCbsa6MzVYedG2RdQoaj1HiYiY/qLn4IAIwlLvaQXRgqcm
 V0A89w/2Ie71OYeOZIiC+fWzhjGj2xpIFAs5o/7sSmPbkscuknCfIvv1hpBYNjxGUnS65JlpOiL
 dSFI8Spj3+RjKG7JMJSGxC3fyYV11gUjPUTaW5Bwnij7nLKhgT8WjYnMkYXBvgl7zF7JJO2vWKc
 cUiYDdi1db3lgyoCHTg==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=gr50lgQh3SlUKNVXMSoA:9
X-Proofpoint-ORIG-GUID: tc7Uh7Bu6kccLGsjQLUBcjQB2StkWGcV
X-Proofpoint-GUID: tc7Uh7Bu6kccLGsjQLUBcjQB2StkWGcV
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

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
and PCC-Compute-XTS-Parameter-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390
AES XTS implementation in the Linux kernel and Libica and thus
also Opencryptoki clear key via Libica.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
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
index 21fe2e4690..aa39a3c85a 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -26,5 +26,7 @@ int cpacf_aes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                   uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
                   uint64_t *ctr_ptr, uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 750de42f21..1076322e30 100644
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
@@ -276,3 +283,66 @@ int cpacf_aes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
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


