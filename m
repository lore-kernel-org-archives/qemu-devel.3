Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF48CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbFi-0006R6-Ka; Wed, 20 May 2026 03:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEu-0006Dm-GB; Wed, 20 May 2026 03:21:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEp-0002Ta-OU; Wed, 20 May 2026 03:21:12 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JJNqv82789992; Wed, 20 May 2026 07:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2ct83msy/CR2/D37R
 qr7pGTaze4FnUlgoWEc6opW1nc=; b=cBv2xDAi05tcQn5Q5vP/V5MfKlfz/LZBx
 n84G4izVgZWJppLo8dii+K0dvDWTKH7cAa4ckw+wWvksbTYI5rnLTL4+oiaAkA3c
 hntlWBcQoMLjx0V9djK6H2FhwZX57Dz6tX00BURnlH0MeOjz11d6riZgXii2jUv0
 DPtCNAo8X4fvn1EjI0JQe97Et3g3LqEaY4YvdnCL/gOIccyRnUgLh+SjBGeGcrqf
 kO/kl9DoU0jRcbbb8VPtgBfkMkyxad6TNYxpeLFTFtn6Sn/Lj3es/GIydFABWfgB
 jJzFdbVDNs0vDjBL4l5SAo5tQlb1qymVykjb7cAQ57NlNRH1CppcQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mruk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:21:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K79Hev029183;
 Wed, 20 May 2026 07:20:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhp7jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:20:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K7KtME52232688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 07:20:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E81620043;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64A4320040;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
Received: from funtu2.fritz.box (unknown [9.111.209.15])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: [PATCH v5 03/15] target/s390x: Support cpacf sha256
Date: Wed, 20 May 2026 09:20:42 +0200
Message-ID: <20260520072054.293306-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520072054.293306-1-freude@linux.ibm.com>
References: <20260520072054.293306-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -FU-r6S5GgSsiu5llXxrt9ZdVynVtoeY
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0d60dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Oku5TADFz1XGWIWXx1gA:9
X-Proofpoint-ORIG-GUID: -FU-r6S5GgSsiu5llXxrt9ZdVynVtoeY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NyBTYWx0ZWRfX7VdKJ1uxgUjb
 sh2d4GQcwJUb+NfWSQD3P28+D/WmQ1Rf7kMqNJmC5vrPxoU9xHYHmRtosdGQa2RZxy6Mh2UlslA
 HuP6Bm/SF76TMg0/wDNC8c2kJlbGmmvhj/OykYmjf0lamTgMTHgVuE7TxbvOajSO/h+yitms6NR
 9gGEMCgtn8z3FK+tBE14RSOdPxPoKVqVhAPGqT6el0HqQLLbZuIDY0kJTckkg0iJd8Yu9s96PgI
 luhZnAvoPq0xtejL97uBbmiVdv1af72EBSwLghJKINSsMW/QNBN6TlevJvAy1Vsprxh1YPs0Iq0
 kYQQEGAQCqBIWXWSawZguJIwE/B7tKuVRF9BvGDhPuiioibZnTTu5bV7p323Vb/dD/lIPCM4okz
 1FuTKICdpgWZaAc7GVI597QUL9Y1WasZd+ClSqsKR8In6sowS12ZJ8zIHxco57Dh7ouzu5AyPQT
 kGCBx43GFJaEAaqmDUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200067
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

Add a new file cpacf_sha256.c which implements sha256.
Add support for the sha256 subfuction for CPACF kimd and klmd.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |   2 +
 target/s390x/tcg/cpacf.h         |   4 +
 target/s390x/tcg/cpacf_sha256.c  | 229 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   8 ++
 target/s390x/tcg/meson.build     |   1 +
 5 files changed, 244 insertions(+)
 create mode 100644 target/s390x/tcg/cpacf_sha256.c

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8218e6470e..5cf5b92c37 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -916,7 +916,9 @@ static uint16_t qemu_V7_1[] = {
  */
 static uint16_t qemu_MAX[] = {
     S390_FEAT_MSA_EXT_5,
+    S390_FEAT_KIMD_SHA_256,
     S390_FEAT_KIMD_SHA_512,
+    S390_FEAT_KLMD_SHA_256,
     S390_FEAT_KLMD_SHA_512,
     S390_FEAT_PRNO_TRNG,
 };
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 99b8a11232..79f05e1e14 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -8,6 +8,10 @@
 #ifndef S390X_CPACF_H
 #define S390X_CPACF_H
 
+/* from crypto_sha256.c */
+int cpacf_sha256(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                 uint64_t *message_reg, uint64_t *len_reg, uint32_t type);
+
 /* from crypto_sha512.c */
 int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                  uint64_t *message_reg, uint64_t *len_reg, uint32_t type);
diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
new file mode 100644
index 0000000000..5190aef6fa
--- /dev/null
+++ b/target/s390x/tcg/cpacf_sha256.c
@@ -0,0 +1,229 @@
+/*
+ *  s390 cpacf sha256
+ *
+ *  Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ *
+ * The sha256 implementation here is more or less a copy-and-paste
+ * from Jason A. Donenfeld's implementation of sha 512 with adaptions
+ * for sha 256.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "s390x-internal.h"
+#include "tcg_s390x.h"
+#include "accel/tcg/cpu-ldst.h"
+#include "cpacf.h"
+
+static uint32_t R(uint32_t x, int c)
+{
+    return (x >> c) | (x << (32 - c));
+}
+static uint32_t Ch(uint32_t x, uint32_t y, uint32_t z)
+{
+    return (x & y) ^ (~x & z);
+}
+static uint32_t Maj(uint32_t x, uint32_t y, uint32_t z)
+{
+    return (x & y) ^ (x & z) ^ (y & z);
+}
+static uint32_t Sigma0(uint32_t x)
+{
+    return R(x, 2) ^ R(x, 13) ^ R(x, 22);
+}
+static uint32_t Sigma1(uint32_t x)
+{
+    return R(x, 6) ^ R(x, 11) ^ R(x, 25);
+}
+static uint32_t sigma0(uint32_t x)
+{
+    return R(x, 7) ^ R(x, 18) ^ (x >> 3);
+}
+static uint32_t sigma1(uint32_t x)
+{
+    return R(x, 17) ^ R(x, 19) ^ (x >> 10);
+}
+
+static const uint32_t K[64] = {
+    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
+    0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
+    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
+    0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
+    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
+    0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
+    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
+    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
+    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
+    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
+    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
+};
+
+/* a is icv/ocv, w is a single message block. w will get reused internally. */
+static void sha256_bda(uint32_t a[8], uint32_t w[16])
+{
+    uint32_t t, z[8], b[8];
+    int i, j;
+
+    memcpy(z, a, sizeof(z));
+    for (i = 0; i < 64; i++) {
+        memcpy(b, a, sizeof(b));
+
+        t = a[7] + Sigma1(a[4]) + Ch(a[4], a[5], a[6]) + K[i] + w[i % 16];
+        b[7] = t + Sigma0(a[0]) + Maj(a[0], a[1], a[2]);
+        b[3] += t;
+        for (j = 0; j < 8; ++j) {
+            a[(j + 1) % 8] = b[j];
+        }
+        if (i % 16 == 15) {
+            for (j = 0; j < 16; ++j) {
+                w[j] += w[(j + 9) % 16] + sigma0(w[(j + 1) % 16]) +
+                        sigma1(w[(j + 14) % 16]);
+            }
+        }
+    }
+
+    for (i = 0; i < 8; i++) {
+        a[i] += z[i];
+    }
+}
+
+/* a is icv/ocv, w is a single message block that needs be32 conversion. */
+static void sha256_bda_be32(uint32_t a[8], uint32_t w[16])
+{
+    uint32_t t[16];
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        t[i] = be32_to_cpu(w[i]);
+    }
+    sha256_bda(a, t);
+}
+
+static void sha256_read_icv(CPUS390XState *env, uint64_t addr,
+                            uint32_t a[8], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 8; i++, addr += 4) {
+        addr = wrap_address(env, addr);
+        a[i] = cpu_ldl_be_data_ra(env, addr, ra);
+    }
+}
+
+static void sha256_write_ocv(CPUS390XState *env, uint64_t addr,
+                             uint32_t a[8], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 8; i++, addr += 4) {
+        addr = wrap_address(env, addr);
+        cpu_stl_be_data_ra(env, addr, a[i], ra);
+    }
+}
+
+static void sha256_read_block(CPUS390XState *env, uint64_t addr,
+                              uint32_t a[16], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 16; i++, addr += 4) {
+        addr = wrap_address(env, addr);
+        a[i] = cpu_ldl_be_data_ra(env, addr, ra);
+    }
+}
+
+static void sha256_read_mbl(CPUS390XState *env, uint64_t addr,
+                            uint8_t a[8], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 8; i++, addr += 1) {
+        addr = wrap_address(env, addr);
+        a[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+}
+
+int cpacf_sha256(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                 uint64_t *message_reg, uint64_t *len_reg, uint32_t type)
+{
+    enum { MAX_BLOCKS_PER_RUN = 128 }; /* 128 * 64 = 8K */
+    uint64_t len = *len_reg, processed = 0;
+    int i, message_reg_len = 64;
+    uint32_t a[8];
+
+    g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
+
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    }
+
+    /* KIMD: length has to be properly aligned. */
+    if (type == S390_FEAT_TYPE_KIMD && !QEMU_IS_ALIGNED(len, 64)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    sha256_read_icv(env, param_addr, a, ra);
+
+    /* Process full blocks first. */
+    for (; len >= 64; len -= 64, processed += 64) {
+        uint32_t w[16];
+
+        if (processed >= MAX_BLOCKS_PER_RUN * 64) {
+            break;
+        }
+
+        sha256_read_block(env, *message_reg + processed, w, ra);
+        sha256_bda(a, w);
+    }
+
+    /* KLMD: Process partial/empty block last. */
+    if (type == S390_FEAT_TYPE_KLMD && len < 64) {
+        uint8_t x[64];
+
+        /* Read the remainder of the message byte-per-byte. */
+        for (i = 0; i < len; i++) {
+            uint64_t addr = wrap_address(env, *message_reg + processed + i);
+
+            x[i] = cpu_ldub_data_ra(env, addr, ra);
+        }
+        /* Pad the remainder with zero and set the top bit. */
+        memset(x + len, 0, 64 - len);
+        x[len] = 0x80;
+
+        /*
+         * Place the MBL either into this block (if there is space left),
+         * or use an additional one.
+         */
+        if (len < 56) {
+            sha256_read_mbl(env, param_addr + 32, x + 56, ra);
+        }
+        sha256_bda_be32(a, (uint32_t *)x);
+
+        if (len >= 56) {
+            memset(x, 0, 56);
+            sha256_read_mbl(env, param_addr + 32, x + 56, ra);
+            sha256_bda_be32(a, (uint32_t *)x);
+        }
+
+        processed += len;
+        len = 0;
+    }
+
+    /*
+     * Modify memory after we read all inputs and modify registers only after
+     * writing memory succeeded.
+     *
+     * TODO: if writing fails halfway through (e.g., when crossing page
+     * boundaries), we're in trouble. We'd need something like access_prepare().
+     */
+    sha256_write_ocv(env, param_addr, a, ra);
+    *message_reg = deposit64(*message_reg, 0, message_reg_len,
+                             *message_reg + processed);
+    *len_reg -= processed;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 2d1c0290b5..b69dbb61a6 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -51,6 +51,10 @@ static int cpacf_kimd(CPUS390XState *env, const uintptr_t ra,
     int rc = 0;
 
     switch (fc) {
+    case 0x02: /* CPACF_KIMD_SHA_256 */
+        rc = cpacf_sha256(env, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
+        break;
     case 0x03: /* CPACF_KIMD_SHA_512 */
         rc = cpacf_sha512(env, ra, env->regs[1], &env->regs[r2],
                           &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
@@ -68,6 +72,10 @@ static int cpacf_klmd(CPUS390XState *env, const uintptr_t ra,
     int rc = 0;
 
     switch (fc) {
+    case 0x02: /* CPACF_KLMD_SHA_256 */
+        rc = cpacf_sha256(env, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
+        break;
     case 0x03: /* CPACF_KLMD_SHA_512 */
         rc = cpacf_sha512(env, ra, env->regs[1], &env->regs[r2],
                           &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 6dbc7ead65..4115f4c704 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -1,5 +1,6 @@
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'cpacf_sha256.c',
   'cpacf_sha512.c',
   'crypto_helper.c',
   'excp_helper.c',
-- 
2.43.0


