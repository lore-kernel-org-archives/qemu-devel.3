Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45030D72372
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFaa-0005Zn-T2; Fri, 23 Jan 2026 06:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZV-00050w-5i; Fri, 23 Jan 2026 06:43:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xR-U1; Fri, 23 Jan 2026 06:43:23 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N2PrGo006450;
 Fri, 23 Jan 2026 11:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BVWOsHW2glTWavO1W
 azXYDTaVZJayK1vevs38h74Zk4=; b=T3SJjuOXLiu3eskY4FbKysV/fj4IMjBPE
 y9FbNhhyvHPkubTxvKNwMiBh19ByXBTeJv1brkYW3WJddxHDYss2Ch4Fcsj32QcA
 +7RY61c+26XS8FbCTw/ISUBDwlBGE8mozpcqeptk9DqfN5RP8G5vvldTNRAnF9Xg
 BQ3vFZHyAGt5PtvLs51/UQ8wSY9l7TXGNDL2CYhcZ8TXgVQUOmZ+W1EPn9Z6HiKp
 lXJM+vkAyx0zVph6af2Z+oQUpOUxsJNqdh8i86de6IaHlotvPT30qpJRrTE3U2Jr
 k+X1Wo0yrpJZtw5Z8J7nZ2MsrTPib0XJfvWr0N1/PE6jmfr418a2Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sfqs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N9oRM5024575;
 Fri, 23 Jan 2026 11:43:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas74ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh9NE29557498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04F7A20040;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF1C12004E;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 02/14] target/s390x: Move cpacf sha512 code into a new file
Date: Fri, 23 Jan 2026 12:42:56 +0100
Message-ID: <20260123114308.19401-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BQeTc9PnFx6moCyJHGpbuf-8yCcZTTMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX/IXCzdFBJ6uI
 YEaVHhmsmHmT06Ug7jgpS7XxAx3STGDWqIhGTAcEeAOZZ2TSnl6rii4BGLdt4q6hHjgpwRBd786
 zccQZSPiRukx5ROwjt5/DfwH3cXfSKCL8D4QtsDuRu2cOOwbYXa7OFua1GLOsNIm+Ea39m/7C9/
 e5TftW0fVYSYNXXARaKWMKwNHxhvBHjzIipgmFcq7uxmo551B7k8MSrBYrVQtdmR+bKE2AtaeRQ
 4WcYPg14ETik02an+YDyrXv7R36k7+oYGkuicDsLTQs+qjFYV4HlnJ4myoxjcgCP67TJUtqIypZ
 gDoaPVGxSTdr9jJwNK4gTdUgk8BVBpd36ePzM0nknG2PzxLfmDH85ouhgh4ubx6SROlVHkdq1T5
 TLh6Q26b+hQ+bgDs7dPvIMeyR9h9bBeTzE/0jQ/0GpA2ilIgu9RZoV6sxrGu9tkQOX25laX3I0g
 2pOtxFglR7vwfSKjWLw==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=UGG5zPGqAAAA:8
 a=AX_EWL0yeIb428kAMdMA:9 a=17ibUXfGiVyGqR_YBevW:22
X-Proofpoint-ORIG-GUID: BQeTc9PnFx6moCyJHGpbuf-8yCcZTTMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
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

Move the cpacf sha512 implementation into a new file
cpacf_sha512.c. Add this new file to the build and add a
new header file cpacf.h containing the prototypes for the
s390 cpacf stuff.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf.h         |  15 ++
 target/s390x/tcg/cpacf_sha512.c  | 241 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 225 +----------------------------
 target/s390x/tcg/meson.build     |   1 +
 4 files changed, 258 insertions(+), 224 deletions(-)
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_sha512.c

diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
new file mode 100644
index 0000000000..99b8a11232
--- /dev/null
+++ b/target/s390x/tcg/cpacf.h
@@ -0,0 +1,15 @@
+/*
+ * s390x cpacf
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef S390X_CPACF_H
+#define S390X_CPACF_H
+
+/* from crypto_sha512.c */
+int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                 uint64_t *message_reg, uint64_t *len_reg, uint32_t type);
+
+#endif
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
new file mode 100644
index 0000000000..5df55c3c50
--- /dev/null
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -0,0 +1,241 @@
+/*
+ *  s390 cpacf sha512
+ *
+ *  Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ *  Authors:
+ *   Jason A. Donenfeld <Jason@zx2c4.com>
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
+static uint64_t R(uint64_t x, int c)
+{
+    return (x >> c) | (x << (64 - c));
+}
+static uint64_t Ch(uint64_t x, uint64_t y, uint64_t z)
+{
+    return (x & y) ^ (~x & z);
+}
+static uint64_t Maj(uint64_t x, uint64_t y, uint64_t z)
+{
+    return (x & y) ^ (x & z) ^ (y & z);
+}
+static uint64_t Sigma0(uint64_t x)
+{
+    return R(x, 28) ^ R(x, 34) ^ R(x, 39);
+}
+static uint64_t Sigma1(uint64_t x)
+{
+    return R(x, 14) ^ R(x, 18) ^ R(x, 41);
+}
+static uint64_t sigma0(uint64_t x)
+{
+    return R(x, 1) ^ R(x, 8) ^ (x >> 7);
+}
+static uint64_t sigma1(uint64_t x)
+{
+    return R(x, 19) ^ R(x, 61) ^ (x >> 6);
+}
+
+static const uint64_t K[80] = {
+    0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
+    0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+    0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
+    0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+    0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
+    0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+    0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
+    0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+    0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
+    0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+    0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
+    0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+    0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
+    0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+    0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
+    0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+    0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
+    0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+    0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
+    0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+    0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
+    0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+    0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
+    0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+    0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
+    0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+    0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL
+};
+
+/* a is icv/ocv, w is a single message block. w will get reused internally. */
+static void sha512_bda(uint64_t a[8], uint64_t w[16])
+{
+    uint64_t t, z[8], b[8];
+    int i, j;
+
+    memcpy(z, a, sizeof(z));
+    for (i = 0; i < 80; i++) {
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
+/* a is icv/ocv, w is a single message block that needs be64 conversion. */
+static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
+{
+    uint64_t t[16];
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        t[i] = be64_to_cpu(w[i]);
+    }
+    sha512_bda(a, t);
+}
+
+static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
+                            uint64_t a[8], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 8; i++, addr += 8) {
+        addr = wrap_address(env, addr);
+        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
+    }
+}
+
+static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
+                             uint64_t a[8], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 8; i++, addr += 8) {
+        addr = wrap_address(env, addr);
+        cpu_stq_be_data_ra(env, addr, a[i], ra);
+    }
+}
+
+static void sha512_read_block(CPUS390XState *env, uint64_t addr,
+                              uint64_t a[16], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 16; i++, addr += 8) {
+        addr = wrap_address(env, addr);
+        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
+    }
+}
+
+static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
+                                 uint8_t a[16], uintptr_t ra)
+{
+    int i;
+
+    for (i = 0; i < 16; i++, addr += 1) {
+        addr = wrap_address(env, addr);
+        a[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+}
+
+int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                 uint64_t *message_reg, uint64_t *len_reg, uint32_t type)
+{
+    enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
+    uint64_t len = *len_reg, a[8], processed = 0;
+    int i, message_reg_len = 64;
+
+    g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
+
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    }
+
+    /* KIMD: length has to be properly aligned. */
+    if (type == S390_FEAT_TYPE_KIMD && !QEMU_IS_ALIGNED(len, 128)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    sha512_read_icv(env, param_addr, a, ra);
+
+    /* Process full blocks first. */
+    for (; len >= 128; len -= 128, processed += 128) {
+        uint64_t w[16];
+
+        if (processed >= MAX_BLOCKS_PER_RUN * 128) {
+            break;
+        }
+
+        sha512_read_block(env, *message_reg + processed, w, ra);
+        sha512_bda(a, w);
+    }
+
+    /* KLMD: Process partial/empty block last. */
+    if (type == S390_FEAT_TYPE_KLMD && len < 128) {
+        uint8_t x[128];
+
+        /* Read the remainder of the message byte-per-byte. */
+        for (i = 0; i < len; i++) {
+            uint64_t addr = wrap_address(env, *message_reg + processed + i);
+
+            x[i] = cpu_ldub_data_ra(env, addr, ra);
+        }
+        /* Pad the remainder with zero and set the top bit. */
+        memset(x + len, 0, 128 - len);
+        x[len] = 128;
+
+        /*
+         * Place the MBL either into this block (if there is space left),
+         * or use an additional one.
+         */
+        if (len < 112) {
+            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
+        }
+        sha512_bda_be64(a, (uint64_t *)x);
+
+        if (len >= 112) {
+            memset(x, 0, 112);
+            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
+            sha512_bda_be64(a, (uint64_t *)x);
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
+    sha512_write_ocv(env, param_addr, a, ra);
+    *message_reg = deposit64(*message_reg, 0, message_reg_len,
+                             *message_reg + processed);
+    *len_reg -= processed;
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 0b00d8ba5b..2d1c0290b5 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -18,230 +18,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
-
-static uint64_t R(uint64_t x, int c)
-{
-    return (x >> c) | (x << (64 - c));
-}
-static uint64_t Ch(uint64_t x, uint64_t y, uint64_t z)
-{
-    return (x & y) ^ (~x & z);
-}
-static uint64_t Maj(uint64_t x, uint64_t y, uint64_t z)
-{
-    return (x & y) ^ (x & z) ^ (y & z);
-}
-static uint64_t Sigma0(uint64_t x)
-{
-    return R(x, 28) ^ R(x, 34) ^ R(x, 39);
-}
-static uint64_t Sigma1(uint64_t x)
-{
-    return R(x, 14) ^ R(x, 18) ^ R(x, 41);
-}
-static uint64_t sigma0(uint64_t x)
-{
-    return R(x, 1) ^ R(x, 8) ^ (x >> 7);
-}
-static uint64_t sigma1(uint64_t x)
-{
-    return R(x, 19) ^ R(x, 61) ^ (x >> 6);
-}
-
-static const uint64_t K[80] = {
-    0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
-    0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
-    0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
-    0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
-    0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
-    0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
-    0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
-    0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
-    0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
-    0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
-    0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
-    0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
-    0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
-    0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
-    0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
-    0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
-    0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
-    0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
-    0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
-    0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
-    0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
-    0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
-    0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
-    0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
-    0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
-    0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
-    0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL
-};
-
-/* a is icv/ocv, w is a single message block. w will get reused internally. */
-static void sha512_bda(uint64_t a[8], uint64_t w[16])
-{
-    uint64_t t, z[8], b[8];
-    int i, j;
-
-    memcpy(z, a, sizeof(z));
-    for (i = 0; i < 80; i++) {
-        memcpy(b, a, sizeof(b));
-
-        t = a[7] + Sigma1(a[4]) + Ch(a[4], a[5], a[6]) + K[i] + w[i % 16];
-        b[7] = t + Sigma0(a[0]) + Maj(a[0], a[1], a[2]);
-        b[3] += t;
-        for (j = 0; j < 8; ++j) {
-            a[(j + 1) % 8] = b[j];
-        }
-        if (i % 16 == 15) {
-            for (j = 0; j < 16; ++j) {
-                w[j] += w[(j + 9) % 16] + sigma0(w[(j + 1) % 16]) +
-                        sigma1(w[(j + 14) % 16]);
-            }
-        }
-    }
-
-    for (i = 0; i < 8; i++) {
-        a[i] += z[i];
-    }
-}
-
-/* a is icv/ocv, w is a single message block that needs be64 conversion. */
-static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
-{
-    uint64_t t[16];
-    int i;
-
-    for (i = 0; i < 16; i++) {
-        t[i] = be64_to_cpu(w[i]);
-    }
-    sha512_bda(a, t);
-}
-
-static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
-                            uint64_t a[8], uintptr_t ra)
-{
-    int i;
-
-    for (i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
-    }
-}
-
-static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
-                             uint64_t a[8], uintptr_t ra)
-{
-    int i;
-
-    for (i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        cpu_stq_be_data_ra(env, addr, a[i], ra);
-    }
-}
-
-static void sha512_read_block(CPUS390XState *env, uint64_t addr,
-                              uint64_t a[16], uintptr_t ra)
-{
-    int i;
-
-    for (i = 0; i < 16; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
-    }
-}
-
-static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
-                                 uint8_t a[16], uintptr_t ra)
-{
-    int i;
-
-    for (i = 0; i < 16; i++, addr += 1) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldub_data_ra(env, addr, ra);
-    }
-}
-
-static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
-                      uint64_t *message_reg, uint64_t *len_reg, uint32_t type)
-{
-    enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
-    uint64_t len = *len_reg, a[8], processed = 0;
-    int i, message_reg_len = 64;
-
-    g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
-
-    if (!(env->psw.mask & PSW_MASK_64)) {
-        len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
-    }
-
-    /* KIMD: length has to be properly aligned. */
-    if (type == S390_FEAT_TYPE_KIMD && !QEMU_IS_ALIGNED(len, 128)) {
-        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-    }
-
-    sha512_read_icv(env, param_addr, a, ra);
-
-    /* Process full blocks first. */
-    for (; len >= 128; len -= 128, processed += 128) {
-        uint64_t w[16];
-
-        if (processed >= MAX_BLOCKS_PER_RUN * 128) {
-            break;
-        }
-
-        sha512_read_block(env, *message_reg + processed, w, ra);
-        sha512_bda(a, w);
-    }
-
-    /* KLMD: Process partial/empty block last. */
-    if (type == S390_FEAT_TYPE_KLMD && len < 128) {
-        uint8_t x[128];
-
-        /* Read the remainder of the message byte-per-byte. */
-        for (i = 0; i < len; i++) {
-            uint64_t addr = wrap_address(env, *message_reg + processed + i);
-
-            x[i] = cpu_ldub_data_ra(env, addr, ra);
-        }
-        /* Pad the remainder with zero and set the top bit. */
-        memset(x + len, 0, 128 - len);
-        x[len] = 128;
-
-        /*
-         * Place the MBL either into this block (if there is space left),
-         * or use an additional one.
-         */
-        if (len < 112) {
-            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
-        }
-        sha512_bda_be64(a, (uint64_t *)x);
-
-        if (len >= 112) {
-            memset(x, 0, 112);
-            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
-            sha512_bda_be64(a, (uint64_t *)x);
-        }
-
-        processed += len;
-        len = 0;
-    }
-
-    /*
-     * Modify memory after we read all inputs and modify registers only after
-     * writing memory succeeded.
-     *
-     * TODO: if writing fails halfway through (e.g., when crossing page
-     * boundaries), we're in trouble. We'd need something like access_prepare().
-     */
-    sha512_write_ocv(env, param_addr, a, ra);
-    *message_reg = deposit64(*message_reg, 0, message_reg_len,
-                             *message_reg + processed);
-    *len_reg -= processed;
-    return !len ? 0 : 3;
-}
+#include "cpacf.h"
 
 static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
                             uint64_t *buf_reg, uint64_t *len_reg)
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index ee4e8fec77..6dbc7ead65 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -1,5 +1,6 @@
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'cpacf_sha512.c',
   'crypto_helper.c',
   'excp_helper.c',
   'fpu_helper.c',
-- 
2.43.0


