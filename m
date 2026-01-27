Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1663D34088
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkl8i-0002JA-7r; Tue, 27 Jan 2026 10:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8c-0002Aw-QG; Tue, 27 Jan 2026 10:37:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8W-00025C-N5; Tue, 27 Jan 2026 10:37:52 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R84D7F015187;
 Tue, 27 Jan 2026 15:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=l9ZJxN
 I4ClH7PlW2GbusRxosyp89d1meE7O2AemEKFU=; b=VUYQz4Pxi4zc/E9o18qjtE
 o4whdBoaFDoaQ4q9fAOzjPbKamSw6LbLJ68NZFarCyOGowYWK1VM6wCLazJka8IR
 nhR6Su/mCsKIYVulmq4HDFsmYpcBU9W02HzeJD9JqyIQuaqzakj/oQoeIWt6s6TL
 1019ay2Gmy6ENwICtDg9tx1pu4p2DDCja5boHOypgA326nwxL718nAa7iUoNXf+s
 uuiOLZExQ0SyczRb3ktfPOtDyktE98qJSFt1+nx+sgrvzNyEap+osCR0lUn2Os7C
 unD4+Xb0BlzwjBuwdq75XXjIfrMF/B0XeTf4RprC7AG2LQYiCPlkqtUr5+CerTWw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7p6nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REZjkH017966;
 Tue, 27 Jan 2026 15:37:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41rxgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RFbd3s42795476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 15:37:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8A6320049;
 Tue, 27 Jan 2026 15:37:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38E6C20040;
 Tue, 27 Jan 2026 15:37:39 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.80.246])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 15:37:39 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 4/4] tests/tcg/s390x: Test DIVIDE TO INTEGER
Date: Tue, 27 Jan 2026 16:31:45 +0100
Message-ID: <20260127153736.62730-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127153736.62730-1-iii@linux.ibm.com>
References: <20260127153736.62730-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TDHna3AFOTAscmP9sWNZWxp3zOInsr6b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfXw9xM3oY2VL45
 J32W/MUStVtKv9bCfoFT0+DuAh5H1M+oIQShlraesGNEW7jx5JHAaObv22hbyJxpp12RVtsW+4f
 VUZINwSboaKa7R12tEzYk1XyeVwy0lqbvAW8+Qro09WLDxTvCRoRZ1g3VqSwKUDubLLeWD8GkoN
 DeM7f8cOuk0xOioF7j8gA3B7hREQMNRP8SuzJlD0HY47g2KvZOBcPZ5IEr9y2e/XGt15OP863dh
 5GXozsgwj/5ZVEFOcBuMFWOtXz6dDfuQSYWF28PD1a0BQBnYlELx/OM3s70FGudPq8CQZNfSprs
 T5MO87QowcWnM/0By4MDR8tFD6sa7SWR7PoGvnyF7bsCwOA1nPjp/VK+Z8JSMWFoRGo/gWplFKl
 CauwRmbozfK35Q3Aico/qCGAPrWYJEPVkZwvPVcga5WuuOHfDqB+BYhffZTvg3Luk+1KMCqYXZR
 +bdq0mN6nariVIy/CGA==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6978dbc6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=07U5A-B8q1nv-0bo0okA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TDHna3AFOTAscmP9sWNZWxp3zOInsr6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add a test to prevent regressions. Data is generated using a
libFuzzer-based fuzzer and hopefully covers all the important corner
cases.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target     |   5 +
 tests/tcg/s390x/divide-to-integer.c | 242 ++++++++++++++++++++++++++++
 2 files changed, 247 insertions(+)
 create mode 100644 tests/tcg/s390x/divide-to-integer.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index da5fe71a407..0ca030ded01 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -49,14 +49,19 @@ TESTS+=cvd
 TESTS+=cvb
 TESTS+=ts
 TESTS+=ex-smc
+TESTS+=divide-to-integer
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
 
+# The following tests contain inline assembly that requires inlining,
+# and thus cannot be built with -O0.
 rxsbg: CFLAGS+=-O2
+divide-to-integer: CFLAGS+=-O2
 
 cgebra: LDFLAGS+=-lm
 clgebr: LDFLAGS+=-lm
+divide-to-integer: LDFLAGS+=-lm
 
 include $(S390X_SRC)/pgm-specification.mak
 $(PGM_SPECIFICATION_TESTS): pgm-specification-user.o
diff --git a/tests/tcg/s390x/divide-to-integer.c b/tests/tcg/s390x/divide-to-integer.c
new file mode 100644
index 00000000000..10040c7058e
--- /dev/null
+++ b/tests/tcg/s390x/divide-to-integer.c
@@ -0,0 +1,242 @@
+/*
+ * Test DIEBR and DIDBR instructions.
+ *
+ * Most inputs were discovered by fuzzing and exercise various corner cases in
+ * the helpers.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <asm/ucontext.h>
+
+static void sigfpe_handler(int sig, siginfo_t *info, void *puc)
+{
+    struct ucontext *uc = puc;
+    unsigned short *xr_insn;
+    int r;
+
+    xr_insn = (unsigned short *)(uc->uc_mcontext.regs.psw.addr - 6);
+    r = *xr_insn & 0xf;
+    uc->uc_mcontext.regs.gprs[r] = sig;
+}
+
+#define DIVIDE_TO_INTEGER(name, floatN)                                        \
+static inline __attribute__((__always_inline__)) int                           \
+name(floatN *r1, floatN r2, floatN *r3, int m4, int *sig)                      \
+{                                                                              \
+    int cc;                                                                    \
+                                                                               \
+    asm(/* Make the initial CC predictable for suppression tests */            \
+        "xr %[sig],%[sig]\n"                                                   \
+        #name " %[r1],%[r3],%[r2],%[m4]\n"                                     \
+        "ipm %[cc]\n"                                                          \
+        "srl %[cc],28"                                                         \
+        /*                                                                     \
+         * Use earlyclobbers to prevent the compiler from reusing floating     \
+         * point registers. This instruction doesn't like it.                  \
+         */                                                                    \
+        : [r1] "+&f" (*r1), [r3] "+&f" (*r3), [sig] "=r" (*sig), [cc] "=d" (cc)\
+        : [r2] "f" (r2), [m4] "i" (m4)                                         \
+        : "cc");                                                               \
+                                                                               \
+    return cc;                                                                 \
+}
+
+DIVIDE_TO_INTEGER(diebr, float)
+DIVIDE_TO_INTEGER(didbr, double)
+
+#define TEST_DIVIDE_TO_INTEGER(name, intN, int_fmt, floatN, float_fmt)         \
+static inline __attribute__((__always_inline__)) int                           \
+test_ ## name(unsigned intN r1i, unsigned intN r2i, int m4, int fpc,           \
+              unsigned intN r1o, unsigned intN r3o, int cco, unsigned int fpco,\
+              int sigo)                                                        \
+{                                                                              \
+    union {                                                                    \
+        floatN f;                                                              \
+        unsigned intN i;                                                       \
+    } r1, r2, r3;                                                              \
+    int cc, err = 0, sig;                                                      \
+                                                                               \
+    r1.i = r1i;                                                                \
+    r2.i = r2i;                                                                \
+    r3.i = 0x12345678;                                                         \
+    printf("[ RUN      ] %" float_fmt "(0x%" int_fmt                           \
+           ") / %" float_fmt "(0x%" int_fmt ")\n", r1.f, r1.i, r2.f, r2.i);    \
+    asm volatile("sfpc %[fpc]" : : [fpc] "r" (fpc));                           \
+    cc = name(&r1.f, r2.f, &r3.f, m4, &sig);                                   \
+    asm volatile("stfpc %[fpc]" : [fpc] "=Q" (fpc));                           \
+    if (r1.i != r1o) {                                                         \
+        printf("[  FAILED  ] remainder 0x%" int_fmt                            \
+               " != expected 0x%" int_fmt "\n", r1.i, r1o);                    \
+        err += 1;                                                              \
+    }                                                                          \
+    if (r3.i != r3o) {                                                         \
+        printf("[  FAILED  ] quotient 0x%" int_fmt                             \
+               " != expected 0x%" int_fmt "\n", r3.i, r3o);                    \
+        err += 1;                                                              \
+    }                                                                          \
+    if (cc != cco) {                                                           \
+        printf("[  FAILED  ] cc %d != expected %d\n", cc, cco);                \
+        err += 1;                                                              \
+    }                                                                          \
+    if (fpc != fpco) {                                                         \
+        printf("[  FAILED  ] fpc 0x%x != expected 0x%x\n", fpc, fpco);         \
+        err += 1;                                                              \
+    }                                                                          \
+    if (sig != sigo) {                                                         \
+        printf("[  FAILED  ] signal 0x%x != expected 0x%x\n", sig, sigo);      \
+        err += 1;                                                              \
+    }                                                                          \
+                                                                               \
+    return err;                                                                \
+}
+
+TEST_DIVIDE_TO_INTEGER(diebr, int, "x", float, "f")
+TEST_DIVIDE_TO_INTEGER(didbr, long, "lx", double, "lf")
+
+int main(void)
+{
+    struct sigaction act = {
+        .sa_sigaction = sigfpe_handler,
+        .sa_flags = SA_SIGINFO,
+    };
+    int err = 0;
+
+    /* Set up SIG handler */
+    if (sigaction(SIGFPE, &act, NULL)) {
+        printf("[  FAILED  ] sigaction(SIGFPE) failed\n");
+        return EXIT_FAILURE;
+    }
+
+    /* 451 / 460 */
+    err += test_diebr(0x43e1f1f1, 0x43e61616, 7, 0,
+                      0x43e1f1f1, 0, 0, 0, 0);
+
+    /* 480 / 0 */
+    err += test_diebr(0x43f00000, 0, 0, 0,
+                      0x7fc00000, 0x7fc00000, 1, 0x800000, 0);
+
+    /* QNaN / QNaN */
+    err += test_diebr(0xffffffff, 0xffffffff, 0, 0,
+                      0xffffffff, 0xffffffff, 1, 0, 0);
+
+    /* -2.08E-8 / -2.08E-8 */
+    err += test_diebr(0xb2b2b2b2, 0xb2b2b2b2, 0, 0,
+                      0x80000000, 0x3f800000, 0, 0, 0);
+
+    /*
+     * Test partial remainder without quotient scaling (cc2).
+     *
+     * 4.62E-2 / -7.94E-11 = { r = 1.68E-10, n = -5.82E+8 }
+     */
+    err += test_diebr(0x3d3d3d3d, 0xaeaeaeae, 0, 0,
+                      0x2f38b8c0, 0xce0aaaab, 2, 0, 0);
+
+    /* 1.07E-31 / 2.19 */
+    err += test_diebr(0x0c0c0c0c, 0x400c0c0c, 6, 0,
+                      0xc00c0c0c, 0x3f800000, 0, 0x80000, 0);
+
+    /* 2.98E+29 / -5.7E-29 */
+    err += test_diebr(0x7070ffff, 0x90909090, 0, 0,
+                      0x6431c0c0, 0xbf5562aa, 3, 0, 0);
+
+    /*
+     * Test large, but representable quotient.
+     *
+     * a = -12040119/549755813888
+     * b = 1/38685626227668133590597632
+     * q = a / b = -847248053779631702016
+     * n = round(q, float32, to_odd) = q
+     * r_precise = a - b * n = -0
+     * r = round(r_precise, float32, nearest_even) = -0
+     */
+    err += test_diebr(0xb7b7b7b7, 0x15000000, 7, 0,
+                      0x80000000, 0xe237b7b7, 0, 0, 0);
+
+    /* 0 / 0 */
+    err += test_diebr(0, 0, 1, 0,
+                      0x7fc00000, 0x7fc00000, 1, 0x800000, 0);
+
+    /* 4.3E-33 / -2.08E-8 with SIGFPE */
+    err += test_diebr(0x09b2b2b2, 0xb2b2b2b2, 0, 0xfc000007,
+                      0xb2b2b2b1, 0xbf800000, 0, 0xfc000807, SIGFPE);
+
+    /*
+     * Test tiny remainder scaling when FPC Underflow Mask is set.
+     *
+     * 1.19E-39 / -1.28E-9 = { r = 1.19E-39 * 2^192, n = -0 }
+     */
+    err += test_diebr(0x000d0100, 0xb0b0b0b0, 6, 0xfc000000,
+                      0x5ed01000, 0x80000000, 0, 0xfc001000, SIGFPE);
+
+    /*
+     * Test "inexact and incremented" DXC.
+     *
+     * a = 53555504
+     * b = -520849213389117849600
+     * q = a / b = -3347219/32553075836819865600
+     * n = round(q, float32, to_odd) = -1
+     * r_precise = a - b * n = -520849213389064294096
+     * r = round(r_precise, float32, to_odd) = -520849213389117849600
+     * abs(r) - abs(r_precise) = 53555504
+     */
+    err += test_diebr(0x4c4c4c4c, 0xe1e1e1e1, 0, 0xfc000007,
+                      0xe1e1e1e1, 0xbf800000, 0, 0xfc000c07, SIGFPE);
+
+    /* 0 / 0 with SIGFPE */
+    err += test_diebr(0, 0, 0, 0xfc000007,
+                      0, 0x12345678, 0, 0xfc008007, SIGFPE);
+
+    /* 5.76E-16 / 5.39E+34 */
+    err += test_diebr(0x26262626, 0x79262626, 6, 0,
+                      0xf9262626, 0x3f800000, 0, 0x80000, 0);
+
+    /* -4.97E+17 / 2.03E-38 */
+    err += test_diebr(0xdcdcdcdc, 0x00dcdcdc, 7, 0xfc000000,
+                      0x80000000, 0xbb800000, 1, 0xfc000000, 0);
+
+    /* -1.23E+17 / SNaN */
+    err += test_diebr(0xdbdb240b, 0xffac73ff, 4, 0,
+                      0xffec73ff, 0xffec73ff, 1, 0x800000, 0);
+
+    /* 2.34E-38 / 3.27E-33 with SIGFPE */
+    err += test_diebr(0x00ff0987, 0x0987c6f6, 6, 0x08000000,
+                      0x8987c6b6, 0x3f800000, 0, 0x8000800, SIGFPE);
+
+    /* -5.93E+11 / -2.7E+4 */
+    err += test_diebr(0xd30a0040, 0xc6d30a00, 0, 0xc4000000,
+                      0xc74a4400, 0x4ba766c6, 2, 0xc4000000, 0);
+
+    /* 9.86E-32 / -inf */
+    err += test_diebr(0x0c000029, 0xff800000, 0, 0,
+                      0xc000029, 0x80000000, 0, 0, 0);
+
+    /* QNaN / SNaN */
+    err += test_diebr(0xffff94ff, 0xff94ff24, 4, 7,
+                      0xffd4ff24, 0xffd4ff24, 1, 0x800007, 0);
+
+    /* 2.8E-43 / -inf */
+    err += test_diebr(0x000000c8, 0xff800000, 0, 0x7c000007,
+                      0x000000c8, 0x80000000, 0, 0x7c000007, 0);
+
+    /* -1.7E+38 / -inf */
+    err += test_diebr(0xff00003d, 0xff800000, 0, 0,
+                      0xff00003d, 0, 0, 0, 0);
+
+    /* 1.94E-304 / 1.94E-304 */
+    err += test_didbr(0x00e100e100e100e1, 0x00e100e100e100e1, 0, 1,
+                      0, 0x3ff0000000000000, 0, 1, 0);
+
+    /* 4.82E-299 / 5.29E-308 */
+    err += test_didbr(0x0200230200230200, 0x0023020023020023, 0, 0,
+                      0x8001a017d247b3f4, 0x41cb2aa05f000000, 0, 0, 0);
+
+    /* -1.38E-75 / -3.77E+208 */
+    err += test_didbr(0xb063eb3d63b063eb, 0xeb3d63b063eb3d63, 3, 0xe8000000,
+                      0x6b3d63b063eb3d63, 0x3ff0000000000000, 0, 0xe8000c00,
+                      SIGFPE);
+
+    return err ? EXIT_FAILURE : EXIT_SUCCESS;
+}
-- 
2.52.0


