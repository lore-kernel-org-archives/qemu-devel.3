Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D5BD7237B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFad-0005dh-Ad; Fri, 23 Jan 2026 06:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZS-00050O-0R; Fri, 23 Jan 2026 06:43:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xO-SB; Fri, 23 Jan 2026 06:43:21 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N2qUEK006209;
 Fri, 23 Jan 2026 11:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=I6s6euSKtjv3qriJF
 eYyiM2bE1vBTsywb6iIQZFRvUA=; b=knZy9HFkrxL3hfaJmMDAAOXgPc1IesWO0
 kHMSz28w1d9Uq7sEBNJ+WH9WwtZbvSoKvjKpKPOyN6kGPR7YxWJqngGNNT+OU7Qx
 cdNmihAApeKIEtFGyx8dtTPs3VQX2ECQ6HWrPQ7HQz29+EzMVTblW0zdvudTslVF
 DnECu22wzfdTrKJSLy9gEPLi0xuSG4XBW8CP0HZb7D5fIuRxDMALVKdMLUI9wRaJ
 K3weS/Y+EVUWnday2ZNkMX7cAGbh40XsMXLP8bHbRRYGQRrwjaBcIVvpFYDh+Nfd
 R6I6H0g/Y+9fGFLKcxSD0X0xKzJIhv0O6pWf30Bf44I5fx0YdOMwg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sfqs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N8QP2Z006399;
 Fri, 23 Jan 2026 11:43:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf20gcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh9oQ29557500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 485CA20040;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2ECBD2004D;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 04/14] target/s390x: Support AES ECB for cpacf km
 instruction
Date: Fri, 23 Jan 2026 12:42:58 +0100
Message-ID: <20260123114308.19401-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sao7lPK0zXx8CHzs8tqZEJzgDjWp33WR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX5Brmw5EqN4xp
 TMSyCLfJkCFdDyhL73pz50gV12mZe1wXeGPJfQQrz9BWzIv3n6beZR0tvsgAPV0dNu7/Pvnw/0l
 CZEPs6U+xZrF5Klbw/Cv8fxkdqO/Hg3CGZUeZeYpnv553iIZNan+sMS00SDbfgRwNDfthWQ3KQB
 4UVxJ0305UHnSbvzKbeLhbIVa/i/y37DBx/Zs6Vw7phMGBnzfb3IWJAa0v4ZlJ52VyN3B6L6QsV
 ajMM+bAUKkn8HigJGJ3FM6pLK56leyUNTgZoGEHoM3UzlJE7QA3lqzU3i9QFGlN+HkeuhB3nSwc
 KMhoHF72Zd06hBmxzlGGAxodsPlERArbyYgYj0lFmo5WSWf6/e9GybxHw480McmQIeu1K2VGo2D
 Skeqd4+7U9RI6xKHm8eErYXJB7xPizKBqevSuMUpaHmd+nejj09R7Az0pH62cYe0U2/OOP35Hnz
 sYKQH34ihrgCczBB5dw==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=2jo1MQRKDEzzzhCldZQA:9
X-Proofpoint-ORIG-GUID: sao7lPK0zXx8CHzs8tqZEJzgDjWp33WR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230092
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

Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
and CPACF_KM_AES_256 for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   5 ++
 target/s390x/tcg/cpacf_aes.c     | 108 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  24 +++++++
 target/s390x/tcg/meson.build     |   1 +
 5 files changed, 141 insertions(+)
 create mode 100644 target/s390x/tcg/cpacf_aes.c

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 5cf5b92c37..a35d1fd2f9 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -921,6 +921,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KLMD_SHA_256,
     S390_FEAT_KLMD_SHA_512,
     S390_FEAT_PRNO_TRNG,
+    S390_FEAT_KM_AES_128,
+    S390_FEAT_KM_AES_192,
+    S390_FEAT_KM_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 79f05e1e14..06423abc00 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -16,4 +16,9 @@ int cpacf_sha256(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                  uint64_t *message_reg, uint64_t *len_reg, uint32_t type);
 
+/* from crypto_aes.c */
+int cpacf_aes_ecb(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                  uint32_t type, uint8_t fc, uint8_t mod);
+
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
new file mode 100644
index 0000000000..6d234d8ce9
--- /dev/null
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -0,0 +1,108 @@
+/*
+ *  s390 cpacf aes
+ *
+ *  Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "s390x-internal.h"
+#include "tcg_s390x.h"
+#include "accel/tcg/cpu-ldst.h"
+#include "crypto/aes.h"
+#include "cpacf.h"
+
+static void aes_read_block(CPUS390XState *env, uint64_t addr,
+                           uint8_t *a, uintptr_t ra)
+{
+    uint64_t _addr;
+    int i;
+
+    for (i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
+        _addr = wrap_address(env, addr);
+        a[i] = cpu_ldub_data_ra(env, _addr, ra);
+    }
+}
+
+static void aes_write_block(CPUS390XState *env, uint64_t addr,
+                            uint8_t *a, uintptr_t ra)
+{
+    uint64_t _addr;
+    int i;
+
+    for (i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
+        _addr = wrap_address(env, addr);
+        cpu_stb_data_ra(env, _addr, a[i], ra);
+    }
+}
+
+int cpacf_aes_ecb(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                  uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len, processed = 0;
+    int i, keysize, data_reg_len = 64;
+    uint8_t key[32];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+    switch (fc) {
+    case 0x12: /* CPACF_KM_AES_128 */
+        keysize = 16;
+        break;
+    case 0x13: /* CPACF_KM_AES_192 */
+        keysize = 24;
+        break;
+    case 0x14: /* CPACF_KM_AES_256 */
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
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        aes_read_block(env, *src_ptr + processed, in, ra);
+        if (mod) {
+            AES_decrypt(in, out, &exkey);
+        } else {
+            AES_encrypt(in, out, &exkey);
+        }
+        aes_write_block(env, *dst_ptr + processed, out, ra);
+        len -= AES_BLOCK_SIZE, processed += AES_BLOCK_SIZE;
+    }
+
+    *src_ptr = deposit64(*src_ptr, 0, data_reg_len, *src_ptr + processed);
+    *dst_ptr = deposit64(*dst_ptr, 0, data_reg_len, *dst_ptr + processed);
+    *src_len -= processed;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index b69dbb61a6..dff119176e 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -87,6 +87,27 @@ static int cpacf_klmd(CPUS390XState *env, const uintptr_t ra,
     return rc;
 }
 
+
+static int cpacf_km(CPUS390XState *env, uintptr_t ra, uint32_t r1,
+                    uint32_t r2, uint32_t r3, uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x12: /* CPACF_KM_AES_128 */
+    case 0x13: /* CPACF_KM_AES_192 */
+    case 0x14: /* CPACF_KM_AES_256 */
+        rc = cpacf_aes_ecb(env, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KM, fc, mod);
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
@@ -151,6 +172,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, ra, r1, r2, r3, fc);
         break;
+    case S390_FEAT_TYPE_KM:
+        rc = cpacf_km(env, ra, r1, r2, r3, fc, mod);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 4115f4c704..da948471ea 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -1,5 +1,6 @@
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'cpacf_aes.c',
   'cpacf_sha256.c',
   'cpacf_sha512.c',
   'crypto_helper.c',
-- 
2.43.0


