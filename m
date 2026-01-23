Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCF2D7236C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFaf-0005fd-1F; Fri, 23 Jan 2026 06:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZV-00050u-5L; Fri, 23 Jan 2026 06:43:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006yP-T3; Fri, 23 Jan 2026 06:43:24 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N2kIwK028553;
 Fri, 23 Jan 2026 11:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VNHvC5hsiBdjpBnmb
 UOvVfNlNC44IsIDahUU2XUrgjo=; b=cuINxmQGzaH7U6fW5ESXYfWGoVRFQMjan
 VrcdCHQYVqxbX3boQLPuZoA3zsHlDJqd28P+LHQ2gHUSNKEnC+3ckcYybN8kNXUy
 4ctyiOYFbmeXwGJ8FrtXFEC+xrCm4evWcqog5Ba/4yvNPQj8jBfiEV9tc8Z/YUM2
 iEOSUeliDQmoKt1XXeQ7Mipjmz4jjzZycg9HDGvN/2jxZraCkYfQjx7QdxMX24Ew
 AepDN2mIwOJGqzi3o706frgTSjWXvYNw2dr0byKF7ERF6YEsFCvOm7DzScHwv6lK
 3C/OAqJFB7r7XOVfrSGdDggfCDaATMilW8N2gDc21xoXAHB9Etemw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f38rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NAnC5G009273;
 Fri, 23 Jan 2026 11:43:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8krrjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBhA2E46203364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 069E12004B;
 Fri, 23 Jan 2026 11:43:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDEF020040;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 11/14] target/s390x: Support protected key AES CBC for
 cpacf kmc instruction
Date: Fri, 23 Jan 2026 12:43:05 +0100
Message-ID: <20260123114308.19401-12-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=69735ed3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=1XR5bUzyU_lZOmb26nMA:9
X-Proofpoint-GUID: 0dsbrmohyMTW8dt26eea_WSL4t7XZUh2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX4KJsrsyQF0qr
 +lPK5Yr1Z1BUz7t4XmNuqz9q1KVEvYq5q8QIIyooqhpczcSA2P08gbaofcQlUHZHc70cKTCCH6n
 3CUlAVS7SDSAYkaJBzDe11KefstGysFyprq4z4VZ42fUf9407K0cWbMSfFDoXkDU3wY9hTZaLr8
 uEEYBYBuzl48AvxlnwoEB6208Z2Y31rqBvy/M0AoaPZzeJqnlwzFH53+bEnQOonShzv++wqOYqQ
 L1S0q5/x8d9kS/7Zt5Rw2he8nF0SjJUsjSZVGytsfXckCf2D+Dwb6dSgHbNYzdMHJVbFUk1V1rf
 WwfdYHzH4yoMydzaMp9/HfaOCzToA2MwnmENf/rKih1Qqj01dQjazmeAmNZAKCJbM4pf6aOCLXS
 PvMYtr0yjL2vluB9cFsizZotg/J/c6tHIjBdHMnoVCtcH4yz2UORdwQKBcZIoHUht46otOxYmb8
 BQoPG2llRcXmTfppG0g==
X-Proofpoint-ORIG-GUID: 0dsbrmohyMTW8dt26eea_WSL4t7XZUh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
and CPACF_KMC_PAES_256 for the cpacf kmc instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   3 +
 target/s390x/tcg/cpacf_aes.c     | 105 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   7 +++
 4 files changed, 118 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 71e0e41d6e..074c53aecd 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -932,6 +932,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
+    S390_FEAT_KMC_EAES_128,
+    S390_FEAT_KMC_EAES_192,
+    S390_FEAT_KMC_EAES_256,
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 4c1e0ee58d..920c1f50fb 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -36,5 +36,8 @@ int cpacf_aes_pckmo(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 int cpacf_paes_ecb(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                    uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                   uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 6f909e433d..c0edc57572 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -597,3 +597,108 @@ int cpacf_paes_ecb(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                   uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len, processed = 0;
+    int i, keysize, data_reg_len = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMC);
+
+    switch (fc) {
+    case 0x1a: /* CPACF_KMC_PAES_128 */
+        keysize = 16;
+        break;
+    case 0x1b: /* CPACF_KMC_PAES_192 */
+        keysize = 24;
+        break;
+    case 0x1c: /* CPACF_KMC_PAES_256 */
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
+        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + keysize + i);
+        wkvp[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch iv from param blick */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + i);
+        iv[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* fetch protected key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
+        key[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+    /* 'decrypt' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
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
+        aes_read_block(env, *src_ptr + processed, in, ra);
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
+        aes_write_block(env, *dst_ptr + processed, out, ra);
+        len -= AES_BLOCK_SIZE, processed += AES_BLOCK_SIZE;
+    }
+
+    /* update iv in param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + i);
+        cpu_stb_data_ra(env, addr, iv[i], ra);
+    }
+
+    *src_ptr = deposit64(*src_ptr, 0, data_reg_len, *src_ptr + processed);
+    *dst_ptr = deposit64(*dst_ptr, 0, data_reg_len, *dst_ptr + processed);
+    *src_len -= processed;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 146f970713..a69f4edf74 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -134,6 +134,13 @@ static int cpacf_kmc(CPUS390XState *env, uintptr_t ra, uint32_t r1,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KMC, fc, mod);
         break;
+    case 0x1a: /* CPACF_KMC_PAES_128 */
+    case 0x1b: /* CPACF_KMC_PAES_192 */
+    case 0x1c: /* CPACF_KMC_PAES_256 */
+        rc = cpacf_paes_cbc(env, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KMC, fc, mod);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


