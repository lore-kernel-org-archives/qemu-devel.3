Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC4FD7237B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFaf-0005ff-Ly; Fri, 23 Jan 2026 06:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZV-00050x-6R; Fri, 23 Jan 2026 06:43:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xi-TT; Fri, 23 Jan 2026 06:43:22 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NBgHRn007756;
 Fri, 23 Jan 2026 11:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5xuTPXIa+1B5CVDVG
 TFhYpG+nvsBAWpL23KODpPcoKk=; b=LivszraxKDX6zl4PT83vDMokB3lkZg4DI
 IhEZ6tJbjO55INsYyMbQfC5QlS4GuDCF3UjMneLcR4DU+SMbkGhLhOwssYMQQOaK
 FPC0PfAYILMqC6xMLJmhOLeeU5HS5XnnVD5M3e78WRVscP62qVMbylNC3UtgN1h5
 JEIhMQ+LI03rkM99Ts6mqk6xWz2Bl5BBx7xSiK7VvVIJVLsy4n5TNUxos2EpzAdM
 3VLDwk9hN3Om6XRYPxp5GFn32oppE5bgUJ7C1eliiC4yseXh7YnnSKFk89YCkW2c
 hPcwcNDa3hXMUGUMQPNns5+ocFKihARXjVeZyewyYjwoHfnJ1Dh4Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukp397-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NB026V001404;
 Fri, 23 Jan 2026 11:43:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyk8m1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBhAw646203366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E76C20040;
 Fri, 23 Jan 2026 11:43:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16E7E20043;
 Fri, 23 Jan 2026 11:43:10 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:10 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 12/14] target/s390x: Support protected key AES CTR for
 cpacf kmctr instruction
Date: Fri, 23 Jan 2026 12:43:06 +0100
Message-ID: <20260123114308.19401-13-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfXwXTrKsQjfgQq
 Ri3aT21yxNnnYcZwbKCC+3PEVurx5w7up/aAiLRNP0ahOLzOnTiTW317bxKchQhRrkMltRBYNCA
 fD+/YhF8MV9p29YetK1XGPf67Cn2BsnX6nwCs7+JV3fqCfB5KyjxY/aY/kFKTm5dILLCNeWGGBQ
 cv6gX71QqYMPSmZvZb/w3xV/4RaKn3NlkmdMyVdEmuSKDlvcjXUJO+0kCAqNJYyIeTT+JdO3Tu+
 7IK6Yx4mrLYC7LDDz0KB6a66LTLM/Wh0tnxgQhLWFbd8qxZ5y843EO9ji6yNDeVqTypRpS5jaxS
 rxMoG4W3rPC2KsU4bU2cwYO8pOcpRiG4XSOUblab9gCERbIasCRavkOvPnYRrubAHwPgp6FXCyx
 PoGmzzmXKazrgqVHuBI/69qYK6i58ODVB/vCPpVbXSxkUbgJdyMGYDLzviM+HjS4wjNJVE8KUUQ
 hzBEIBGloj8jpCtezhw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Ff2AzlR8v_7kNCG2J78A:9
X-Proofpoint-ORIG-GUID: BMKNfvzrVu7XGBljP1XXeOwzS5SCb5cU
X-Proofpoint-GUID: BMKNfvzrVu7XGBljP1XXeOwzS5SCb5cU
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

Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  3 ++
 target/s390x/tcg/cpacf_aes.c     | 84 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  7 +++
 4 files changed, 97 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 074c53aecd..4a131dc191 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -938,6 +938,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_KMCTR_EAES_128,
+    S390_FEAT_KMCTR_EAES_192,
+    S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
     S390_FEAT_PCKMO_AES_128,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 920c1f50fb..35518aef4b 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -39,5 +39,8 @@ int cpacf_paes_ecb(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 int cpacf_paes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                    uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                   uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                   uint64_t *ctr_ptr, uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index c0edc57572..78af0ce8d5 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -702,3 +702,87 @@ int cpacf_paes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                   uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                   uint64_t *ctr_ptr, uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len, processed = 0;
+    int i, keysize, data_reg_len = 64;
+    uint8_t key[32], wkvp[32];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMCTR);
+
+    switch (fc) {
+    case 0x1a: /* CPACF_KMCTR_PAES_128 */
+        keysize = 16;
+        break;
+    case 0x1b: /* CPACF_KMCTR_PAES_192 */
+        keysize = 24;
+        break;
+    case 0x1c: /* CPACF_KMCTR_PAES_256 */
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
+    /* fetch and check wkvp from param block */
+    for (i = 0; i < sizeof(wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        wkvp[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+    /* 'decrypt' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
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
index a69f4edf74..2791e69f84 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -161,6 +161,13 @@ static int cpacf_kmctr(CPUS390XState *env, uintptr_t ra, uint32_t r1,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
         break;
+    case 0x1a: /* CPACF_KMCTR_PAES_128 */
+    case 0x1b: /* CPACF_KMCTR_PAES_192 */
+    case 0x1c: /* CPACF_KMCTR_PAES_256 */
+        rc = cpacf_paes_ctr(env, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


