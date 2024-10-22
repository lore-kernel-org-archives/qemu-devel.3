Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40C6D2C57C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 00:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3OpO-0004jX-Ia; Tue, 22 Oct 2024 20:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3OpL-0004i8-3Z; Tue, 22 Oct 2024 20:02:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3OpH-0004Qf-Qf; Tue, 22 Oct 2024 20:02:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLoRB2007731;
 Wed, 23 Oct 2024 00:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AoXtEQCk+Yi2AwNhr
 D+UgZmfp1emmOPrZ8YbLtpdo9A=; b=pv/aYtcNXdapWgkQDset2vq2T4Cw1e4VJ
 YgjNDQfcJeb3bMH2lktyNQQE5IaGWghE/Q2k0axo2LNdhEsAGKMfc1yQwOagy0Eo
 HWz4V1LvLqMMzVWTR3pZrcaadQjvEGCDz2pENxQC/V+S5qAaynyQu34qvkhbtRCh
 zt4rRABgZ9eXE2Ln7V/eWqRD3NhTxg2WbCZEFj2pUBA2Bc1FnDuquvYlPzyAucV1
 RMtxnWXYYJukN/awRXDRYhpdpxcqG/ddBKyZq0p3Ooml6Aiaknnibi7GtSwKYe78
 ytDP3ldRVP/CkmL3HlvS37hnzQmIkp81U/cdeJOTYC6euX91Bj7nA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafrchb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:01:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MM6qN6006876;
 Wed, 23 Oct 2024 00:01:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emjcrayd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:01:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49N01qL421758580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 00:01:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5B6D20043;
 Wed, 23 Oct 2024 00:01:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57B0B20040;
 Wed, 23 Oct 2024 00:01:52 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.26.72])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 00:01:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Add the floating-point multiply-and-add
 test
Date: Wed, 23 Oct 2024 01:59:19 +0200
Message-ID: <20241023000147.34035-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023000147.34035-1-iii@linux.ibm.com>
References: <20241023000147.34035-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pL-ZM2IPZNpcaoQs1_eIvaa2iLYTl-Jd
X-Proofpoint-ORIG-GUID: pL-ZM2IPZNpcaoQs1_eIvaa2iLYTl-Jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220154
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a test to prevent regressions.
Share some useful pieces with the vfminmax test.
Remove the duplicates from the floating point class values.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |   5 +-
 tests/tcg/s390x/float.h         | 104 ++++++++++++++
 tests/tcg/s390x/fma.c           | 233 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/vfminmax.c      | 223 +++++++++++-------------------
 4 files changed, 420 insertions(+), 145 deletions(-)
 create mode 100644 tests/tcg/s390x/float.h
 create mode 100644 tests/tcg/s390x/fma.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 2dab4f45822..da5fe71a407 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -74,8 +74,11 @@ $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
 ifneq ($(CROSS_CC_HAS_Z14),)
-Z14_TESTS=vfminmax
+Z14_TESTS=fma vfminmax
+fma: float.h
+fma: LDFLAGS+=-lm
 vfminmax: LDFLAGS+=-lm
+vfminmax: float.h
 $(Z14_TESTS): CFLAGS+=-march=z14 -O2
 TESTS+=$(Z14_TESTS)
 endif
diff --git a/tests/tcg/s390x/float.h b/tests/tcg/s390x/float.h
new file mode 100644
index 00000000000..9d1682b8fc5
--- /dev/null
+++ b/tests/tcg/s390x/float.h
@@ -0,0 +1,104 @@
+/*
+ * Helpers for floating-point tests.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FLOAT_H
+#define FLOAT_H
+
+/*
+ * Floating-point value classes.
+ */
+#define N_FORMATS 3
+#define CLASS_MINUS_INF 0
+#define CLASS_MINUS_FN 1
+#define CLASS_MINUS_ZERO 2
+#define CLASS_PLUS_ZERO 3
+#define CLASS_PLUS_FN 4
+#define CLASS_PLUS_INF 5
+#define CLASS_QNAN 6
+#define CLASS_SNAN 7
+#define N_SIGNED_CLASSES 8
+static const size_t float_sizes[N_FORMATS] = {
+    /* M4 == 2: short    */ 4,
+    /* M4 == 3: long     */ 8,
+    /* M4 == 4: extended */ 16,
+};
+static const size_t e_bits[N_FORMATS] = {
+    /* M4 == 2: short    */ 8,
+    /* M4 == 3: long     */ 11,
+    /* M4 == 4: extended */ 15,
+};
+struct float_class {
+    size_t n;
+    unsigned char v[2][16];
+};
+static const struct float_class signed_floats[N_FORMATS][N_SIGNED_CLASSES] = {
+    /* M4 == 2: short */
+    {
+        /* -inf */ {1, {{0xff, 0x80, 0x00, 0x00}}},
+        /* -Fn */  {2, {{0xc2, 0x28, 0x00, 0x00},
+                        {0xc2, 0x29, 0x00, 0x00}}},
+        /* -0 */   {1, {{0x80, 0x00, 0x00, 0x00}}},
+        /* +0 */   {1, {{0x00, 0x00, 0x00, 0x00}}},
+        /* +Fn */  {2, {{0x42, 0x28, 0x00, 0x00},
+                        {0x42, 0x2a, 0x00, 0x00}}},
+        /* +inf */ {1, {{0x7f, 0x80, 0x00, 0x00}}},
+        /* QNaN */ {2, {{0x7f, 0xff, 0xff, 0xff},
+                        {0x7f, 0xff, 0xff, 0xfe}}},
+        /* SNaN */ {2, {{0x7f, 0xbf, 0xff, 0xff},
+                        {0x7f, 0xbf, 0xff, 0xfd}}},
+    },
+
+    /* M4 == 3: long */
+    {
+        /* -inf */ {1, {{0xff, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* -Fn */  {2, {{0xc0, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+                        {0xc0, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* -0 */   {1, {{0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* +0 */   {1, {{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* +Fn */  {2, {{0x40, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+                        {0x40, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* +inf */ {1, {{0x7f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* QNaN */ {2, {{0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+                        {0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}}},
+        /* SNaN */ {2, {{0x7f, 0xf7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+                        {0x7f, 0xf7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd}}},
+    },
+
+    /* M4 == 4: extended */
+    {
+        /* -inf */ {1, {{0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* -Fn */  {2, {{0xc0, 0x04, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+                        {0xc0, 0x04, 0x51, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* -0 */   {1, {{0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* +0 */   {1, {{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* +Fn */  {2, {{0x40, 0x04, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+                        {0x40, 0x04, 0x52, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* +inf */ {1, {{0x7f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}}},
+        /* QNaN */ {2, {{0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+                        {0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}}},
+        /* SNaN */ {2, {{0x7f, 0xff, 0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+                        {0x7f, 0xff, 0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd}}},
+    },
+};
+static const unsigned char default_nans[N_FORMATS][16] = {
+    /* M4 == 2: short    */ {0x7f, 0xc0, 0x00, 0x00},
+    /* M4 == 3: long     */ {0x7f, 0xf8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+    /* M4 == 4: extended */ {0x7f, 0xff, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+};
+
+static void dump_v(FILE *f, const void *v, size_t n)
+{
+    for (int i = 0; i < n; i++) {
+        fprintf(f, "%02x", ((const unsigned char *)v)[i]);
+    }
+}
+
+static void snan_to_qnan(char *v, int fmt)
+{
+    size_t bit = 1 + e_bits[fmt];
+    v[bit / 8] |= 1 << (7 - (bit % 8));
+}
+
+#endif
diff --git a/tests/tcg/s390x/fma.c b/tests/tcg/s390x/fma.c
new file mode 100644
index 00000000000..6872f59a7a6
--- /dev/null
+++ b/tests/tcg/s390x/fma.c
@@ -0,0 +1,233 @@
+/*
+ * Test floating-point multiply-and-add instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <fenv.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "float.h"
+
+union val {
+    float e;
+    double d;
+    long double x;
+    char buf[16];
+};
+
+/*
+ * PoP tables as close to the original as possible.
+ */
+static const char *table1[N_SIGNED_CLASSES][N_SIGNED_CLASSES] = {
+     /*         -inf           -Fn          -0             +0             +Fn          +inf           QNaN         SNaN     */
+    {/* -inf */ "P(+inf)",     "P(+inf)",   "Xi: T(dNaN)", "Xi: T(dNaN)", "P(-inf)",   "P(-inf)",     "P(b)",      "Xi: T(b*)"},
+    {/* -Fn  */ "P(+inf)",     "P(a*b)",    "P(+0)",       "P(-0)",       "P(a*b)",    "P(-inf)",     "P(b)",      "Xi: T(b*)"},
+    {/* -0   */ "Xi: T(dNaN)", "P(+0)",     "P(+0)",       "P(-0)",       "P(-0)",     "Xi: T(dNaN)", "P(b)",      "Xi: T(b*)"},
+    {/* +0   */ "Xi: T(dNaN)", "P(-0)",     "P(-0)",       "P(+0)",       "P(+0)",     "Xi: T(dNaN)", "P(b)",      "Xi: T(b*)"},
+    {/* +Fn  */ "P(-inf)",     "P(a*b)",    "P(-0)",       "P(+0)",       "P(a*b)",    "P(+inf)",     "P(b)",      "Xi: T(b*)"},
+    {/* +inf */ "P(-inf)",     "P(-inf)",   "Xi: T(dNaN)", "Xi: T(dNaN)", "P(+inf)",   "P(+inf)",     "P(b)",      "Xi: T(b*)"},
+    {/* QNaN */ "P(a)",        "P(a)",      "P(a)",        "P(a)",        "P(a)",      "P(a)",        "P(a)",      "Xi: T(b*)"},
+    {/* SNaN */ "Xi: T(a*)",   "Xi: T(a*)", "Xi: T(a*)",   "Xi: T(a*)",   "Xi: T(a*)", "Xi: T(a*)",   "Xi: T(a*)", "Xi: T(a*)"},
+};
+
+static const char *table2[N_SIGNED_CLASSES][N_SIGNED_CLASSES] = {
+     /*         -inf           -Fn        -0         +0         +Fn        +inf           QNaN    SNaN     */
+    {/* -inf */ "T(-inf)",     "T(-inf)", "T(-inf)", "T(-inf)", "T(-inf)", "Xi: T(dNaN)", "T(c)", "Xi: T(c*)"},
+    {/* -Fn  */ "T(-inf)",     "R(p+c)",  "R(p)",    "R(p)",    "R(p+c)",  "T(+inf)",     "T(c)", "Xi: T(c*)"},
+    {/* -0   */ "T(-inf)",     "R(c)",    "T(-0)",   "Rezd",    "R(c)",    "T(+inf)",     "T(c)", "Xi: T(c*)"},
+    {/* +0   */ "T(-inf)",     "R(c)",    "Rezd",    "T(+0)",   "R(c)",    "T(+inf)",     "T(c)", "Xi: T(c*)"},
+    {/* +Fn  */ "T(-inf)",     "R(p+c)",  "R(p)",    "R(p)",    "R(p+c)",  "T(+inf)",     "T(c)", "Xi: T(c*)"},
+    {/* +inf */ "Xi: T(dNaN)", "T(+inf)", "T(+inf)", "T(+inf)", "T(+inf)", "T(+inf)",     "T(c)", "Xi: T(c*)"},
+    {/* QNaN */ "T(p)",        "T(p)",    "T(p)",    "T(p)",    "T(p)",    "T(p)",        "T(p)", "Xi: T(c*)"},
+     /* SNaN: can't happen */
+};
+
+static void interpret_tables(union val *r, bool *xi, int fmt,
+                             int cls_a, const union val *a,
+                             int cls_b, const union val *b,
+                             int cls_c, const union val *c)
+{
+    const char *spec1 = table1[cls_a][cls_b];
+    const char *spec2;
+    union val p;
+    int cls_p;
+
+    *xi = false;
+
+    if (strcmp(spec1, "P(-inf)") == 0) {
+        cls_p = CLASS_MINUS_INF;
+    } else if (strcmp(spec1, "P(+inf)") == 0) {
+        cls_p = CLASS_PLUS_INF;
+    } else if (strcmp(spec1, "P(-0)") == 0) {
+        cls_p = CLASS_MINUS_ZERO;
+    } else if (strcmp(spec1, "P(+0)") == 0) {
+        cls_p = CLASS_PLUS_ZERO;
+    } else if (strcmp(spec1, "P(a)") == 0) {
+        cls_p = cls_a;
+        memcpy(&p, a, sizeof(p));
+    } else if (strcmp(spec1, "P(b)") == 0) {
+        cls_p = cls_b;
+        memcpy(&p, b, sizeof(p));
+    } else if (strcmp(spec1, "P(a*b)") == 0) {
+        /*
+         * In the general case splitting fma into multiplication and addition
+         * doesn't work, but this is the case with our test inputs.
+         */
+        cls_p = cls_a == cls_b ? CLASS_PLUS_FN : CLASS_MINUS_FN;
+        switch (fmt) {
+        case 0:
+            p.e = a->e * b->e;
+            break;
+        case 1:
+            p.d = a->d * b->d;
+            break;
+        case 2:
+            p.x = a->x * b->x;
+            break;
+        default:
+            fprintf(stderr, "Unsupported fmt: %d\n", fmt);
+            exit(1);
+        }
+    } else if (strcmp(spec1, "Xi: T(dNaN)") == 0) {
+        memcpy(r, default_nans[fmt], sizeof(*r));
+        *xi = true;
+        return;
+    } else if (strcmp(spec1, "Xi: T(a*)") == 0) {
+        memcpy(r, a, sizeof(*r));
+        snan_to_qnan(r->buf, fmt);
+        *xi = true;
+        return;
+    } else if (strcmp(spec1, "Xi: T(b*)") == 0) {
+        memcpy(r, b, sizeof(*r));
+        snan_to_qnan(r->buf, fmt);
+        *xi = true;
+        return;
+    } else {
+        fprintf(stderr, "Unsupported spec1: %s\n", spec1);
+        exit(1);
+    }
+
+    spec2 = table2[cls_p][cls_c];
+    if (strcmp(spec2, "T(-inf)") == 0) {
+        memcpy(r, signed_floats[fmt][CLASS_MINUS_INF].v[0], sizeof(*r));
+    } else if (strcmp(spec2, "T(+inf)") == 0) {
+        memcpy(r, signed_floats[fmt][CLASS_PLUS_INF].v[0], sizeof(*r));
+    } else if (strcmp(spec2, "T(-0)") == 0) {
+        memcpy(r, signed_floats[fmt][CLASS_MINUS_ZERO].v[0], sizeof(*r));
+    } else if (strcmp(spec2, "T(+0)") == 0 || strcmp(spec2, "Rezd") == 0) {
+        memcpy(r, signed_floats[fmt][CLASS_PLUS_ZERO].v[0], sizeof(*r));
+    } else if (strcmp(spec2, "R(c)") == 0 || strcmp(spec2, "T(c)") == 0) {
+        memcpy(r, c, sizeof(*r));
+    } else if (strcmp(spec2, "R(p)") == 0 || strcmp(spec2, "T(p)") == 0) {
+        memcpy(r, &p, sizeof(*r));
+    } else if (strcmp(spec2, "R(p+c)") == 0 || strcmp(spec2, "T(p+c)") == 0) {
+        switch (fmt) {
+        case 0:
+            r->e = p.e + c->e;
+            break;
+        case 1:
+            r->d = p.d + c->d;
+            break;
+        case 2:
+            r->x = p.x + c->x;
+            break;
+        default:
+            fprintf(stderr, "Unsupported fmt: %d\n", fmt);
+            exit(1);
+        }
+    } else if (strcmp(spec2, "Xi: T(dNaN)") == 0) {
+        memcpy(r, default_nans[fmt], sizeof(*r));
+        *xi = true;
+    } else if (strcmp(spec2, "Xi: T(c*)") == 0) {
+        memcpy(r, c, sizeof(*r));
+        snan_to_qnan(r->buf, fmt);
+        *xi = true;
+    } else {
+        fprintf(stderr, "Unsupported spec2: %s\n", spec2);
+        exit(1);
+    }
+}
+
+struct iter {
+    int fmt;
+    int cls[3];
+    int val[3];
+};
+
+static bool iter_next(struct iter *it)
+{
+    int i;
+
+    for (i = 2; i >= 0; i--) {
+        if (++it->val[i] != signed_floats[it->fmt][it->cls[i]].n) {
+            return true;
+        }
+        it->val[i] = 0;
+
+        if (++it->cls[i] != N_SIGNED_CLASSES) {
+            return true;
+        }
+        it->cls[i] = 0;
+    }
+
+    return ++it->fmt != N_FORMATS;
+}
+
+int main(void)
+{
+    int ret = EXIT_SUCCESS;
+    struct iter it = {};
+
+    do {
+        size_t n = float_sizes[it.fmt];
+        union val a, b, c, exp, res;
+        bool xi_exp, xi;
+
+        memcpy(&a, signed_floats[it.fmt][it.cls[0]].v[it.val[0]], sizeof(a));
+        memcpy(&b, signed_floats[it.fmt][it.cls[1]].v[it.val[1]], sizeof(b));
+        memcpy(&c, signed_floats[it.fmt][it.cls[2]].v[it.val[2]], sizeof(c));
+
+        interpret_tables(&exp, &xi_exp, it.fmt,
+                         it.cls[1], &b, it.cls[2], &c, it.cls[0], &a);
+
+        memcpy(&res, &a, sizeof(res));
+        feclearexcept(FE_ALL_EXCEPT);
+        switch (it.fmt) {
+        case 0:
+            asm("maebr %[a],%[b],%[c]"
+                : [a] "+f" (res.e) : [b] "f" (b.e), [c] "f" (c.e));
+            break;
+        case 1:
+            asm("madbr %[a],%[b],%[c]"
+                : [a] "+f" (res.d) : [b] "f" (b.d), [c] "f" (c.d));
+            break;
+        case 2:
+            asm("wfmaxb %[a],%[c],%[b],%[a]"
+                : [a] "+v" (res.x) : [b] "v" (b.x), [c] "v" (c.x));
+            break;
+        default:
+            fprintf(stderr, "Unsupported fmt: %d\n", it.fmt);
+            exit(1);
+        }
+        xi = fetestexcept(FE_ALL_EXCEPT) == FE_INVALID;
+
+        if (memcmp(&res, &exp, n) != 0 || xi != xi_exp) {
+            fprintf(stderr, "[  FAILED  ] ");
+            dump_v(stderr, &b, n);
+            fprintf(stderr, " * ");
+            dump_v(stderr, &c, n);
+            fprintf(stderr, " + ");
+            dump_v(stderr, &a, n);
+            fprintf(stderr, ": actual=");
+            dump_v(stderr, &res, n);
+            fprintf(stderr, "/%d, expected=", (int)xi);
+            dump_v(stderr, &exp, n);
+            fprintf(stderr, "/%d\n", (int)xi_exp);
+            ret = EXIT_FAILURE;
+        }
+    } while (iter_next(&it));
+
+    return ret;
+}
diff --git a/tests/tcg/s390x/vfminmax.c b/tests/tcg/s390x/vfminmax.c
index 22629df160e..e66285f7625 100644
--- a/tests/tcg/s390x/vfminmax.c
+++ b/tests/tcg/s390x/vfminmax.c
@@ -4,6 +4,8 @@
 #include <stdio.h>
 #include <string.h>
 
+#include "float.h"
+
 /*
  * vfmin/vfmax instruction execution.
  */
@@ -21,98 +23,21 @@ static void vfminmax(unsigned int op,
                      unsigned int m4, unsigned int m5, unsigned int m6,
                      void *v1, const void *v2, const void *v3)
 {
-   insn[3] = (m6 << 4) | m5;
-   insn[4] = (m4 << 4) | 0x0e;
-   insn[5] = op;
+    insn[3] = (m6 << 4) | m5;
+    insn[4] = (m4 << 4) | 0x0e;
+    insn[5] = op;
 
     asm("vl %%v25,%[v2]\n"
         "vl %%v26,%[v3]\n"
         "ex 0,%[insn]\n"
         "vst %%v24,%[v1]\n"
         : [v1] "=m" (*(char (*)[16])v1)
-        : [v2] "m" (*(char (*)[16])v2)
-        , [v3] "m" (*(char (*)[16])v3)
-        , [insn] "m"(insn)
+        : [v2] "m" (*(const char (*)[16])v2)
+        , [v3] "m" (*(const char (*)[16])v3)
+        , [insn] "m" (insn)
         : "v24", "v25", "v26");
 }
 
-/*
- * Floating-point value classes.
- */
-#define N_FORMATS 3
-#define N_SIGNED_CLASSES 8
-static const size_t float_sizes[N_FORMATS] = {
-    /* M4 == 2: short    */ 4,
-    /* M4 == 3: long     */ 8,
-    /* M4 == 4: extended */ 16,
-};
-static const size_t e_bits[N_FORMATS] = {
-    /* M4 == 2: short    */ 8,
-    /* M4 == 3: long     */ 11,
-    /* M4 == 4: extended */ 15,
-};
-static const unsigned char signed_floats[N_FORMATS][N_SIGNED_CLASSES][2][16] = {
-    /* M4 == 2: short */
-    {
-        /* -inf */ {{0xff, 0x80, 0x00, 0x00},
-                    {0xff, 0x80, 0x00, 0x00}},
-        /* -Fn */  {{0xc2, 0x28, 0x00, 0x00},
-                    {0xc2, 0x29, 0x00, 0x00}},
-        /* -0 */   {{0x80, 0x00, 0x00, 0x00},
-                    {0x80, 0x00, 0x00, 0x00}},
-        /* +0 */   {{0x00, 0x00, 0x00, 0x00},
-                    {0x00, 0x00, 0x00, 0x00}},
-        /* +Fn */  {{0x42, 0x28, 0x00, 0x00},
-                    {0x42, 0x2a, 0x00, 0x00}},
-        /* +inf */ {{0x7f, 0x80, 0x00, 0x00},
-                    {0x7f, 0x80, 0x00, 0x00}},
-        /* QNaN */ {{0x7f, 0xff, 0xff, 0xff},
-                    {0x7f, 0xff, 0xff, 0xfe}},
-        /* SNaN */ {{0x7f, 0xbf, 0xff, 0xff},
-                    {0x7f, 0xbf, 0xff, 0xfd}},
-    },
-
-    /* M4 == 3: long */
-    {
-        /* -inf */ {{0xff, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0xff, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* -Fn */  {{0xc0, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0xc0, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* -0 */   {{0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* +0 */   {{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* +Fn */  {{0x40, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x40, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* +inf */ {{0x7f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x7f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* QNaN */ {{0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-                    {0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}},
-        /* SNaN */ {{0x7f, 0xf7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-                    {0x7f, 0xf7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd}},
-    },
-
-    /* M4 == 4: extended */
-    {
-        /* -inf */ {{0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* -Fn */  {{0xc0, 0x04, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0xc0, 0x04, 0x51, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* -0 */   {{0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* +0 */   {{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* +Fn */  {{0x40, 0x04, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x40, 0x04, 0x52, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* +inf */ {{0x7f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-                    {0x7f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},
-        /* QNaN */ {{0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-                    {0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}},
-        /* SNaN */ {{0x7f, 0xff, 0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-                    {0x7f, 0xff, 0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd}},
-    },
-};
-
 /*
  * PoP tables as close to the original as possible.
  */
@@ -285,13 +210,6 @@ struct signed_test {
     },
 };
 
-static void dump_v(FILE *f, const void *v, size_t n)
-{
-    for (int i = 0; i < n; i++) {
-        fprintf(f, "%02x", ((const unsigned char *)v)[i]);
-    }
-}
-
 static int signed_test(struct signed_test *test, int m4, int m5,
                        const void *v1_exp, bool xi_exp,
                        const void *v2, const void *v3)
@@ -320,10 +238,28 @@ static int signed_test(struct signed_test *test, int m4, int m5,
     return 0;
 }
 
-static void snan_to_qnan(char *v, int m4)
+struct iter {
+    int cls[2];
+    int val[2];
+};
+
+static bool iter_next(struct iter *it, int fmt)
 {
-    size_t bit = 1 + e_bits[m4 - 2];
-    v[bit / 8] |= 1 << (7 - (bit % 8));
+    int i;
+
+    for (i = 1; i >= 0; i--) {
+        if (++it->val[i] != signed_floats[fmt][it->cls[i]].n) {
+            return true;
+        }
+        it->val[i] = 0;
+
+        if (++it->cls[i] != N_SIGNED_CLASSES) {
+            return true;
+        }
+        it->cls[i] = 0;
+    }
+
+    return false;
 }
 
 int main(void)
@@ -333,72 +269,71 @@ int main(void)
 
     for (i = 0; i < sizeof(signed_tests) / sizeof(signed_tests[0]); i++) {
         struct signed_test *test = &signed_tests[i];
-        int m4;
+        int fmt;
 
-        for (m4 = 2; m4 <= 4; m4++) {
-            const unsigned char (*floats)[2][16] = signed_floats[m4 - 2];
-            size_t float_size = float_sizes[m4 - 2];
+        for (fmt = 0; fmt < N_FORMATS; fmt++) {
+            size_t float_size = float_sizes[fmt];
+            int m4 = fmt + 2;
             int m5;
 
             for (m5 = 0; m5 <= 8; m5 += 8) {
                 char v1_exp[16], v2[16], v3[16];
                 bool xi_exp = false;
+                struct iter it = {};
                 int pos = 0;
-                int i2;
 
-                for (i2 = 0; i2 < N_SIGNED_CLASSES * 2; i2++) {
-                    int i3;
+                do {
+                    const char *spec = test->table[it.cls[0]][it.cls[1]];
 
-                    for (i3 = 0; i3 < N_SIGNED_CLASSES * 2; i3++) {
-                        const char *spec = test->table[i2 / 2][i3 / 2];
+                    memcpy(&v2[pos],
+                           signed_floats[fmt][it.cls[0]].v[it.val[0]],
+                           float_size);
+                    memcpy(&v3[pos],
+                           signed_floats[fmt][it.cls[1]].v[it.val[1]],
+                           float_size);
+                    if (strcmp(spec, "T(a)") == 0 ||
+                        strcmp(spec, "Xi: T(a)") == 0) {
+                        memcpy(&v1_exp[pos], &v2[pos], float_size);
+                    } else if (strcmp(spec, "T(b)") == 0 ||
+                               strcmp(spec, "Xi: T(b)") == 0) {
+                        memcpy(&v1_exp[pos], &v3[pos], float_size);
+                    } else if (strcmp(spec, "Xi: T(a*)") == 0) {
+                        memcpy(&v1_exp[pos], &v2[pos], float_size);
+                        snan_to_qnan(&v1_exp[pos], fmt);
+                    } else if (strcmp(spec, "Xi: T(b*)") == 0) {
+                        memcpy(&v1_exp[pos], &v3[pos], float_size);
+                        snan_to_qnan(&v1_exp[pos], fmt);
+                    } else if (strcmp(spec, "T(M(a,b))") == 0) {
+                        /*
+                         * Comparing floats is risky, since the compiler might
+                         * generate the same instruction that we are testing.
+                         * Compare ints instead. This works, because we get
+                         * here only for +-Fn, and the corresponding test
+                         * values have identical exponents.
+                         */
+                        int v2_int = *(int *)&v2[pos];
+                        int v3_int = *(int *)&v3[pos];
 
-                        memcpy(&v2[pos], floats[i2 / 2][i2 % 2], float_size);
-                        memcpy(&v3[pos], floats[i3 / 2][i3 % 2], float_size);
-                        if (strcmp(spec, "T(a)") == 0 ||
-                            strcmp(spec, "Xi: T(a)") == 0) {
+                        if ((v2_int < v3_int) ==
+                            ((test->op == VFMIN) != (v2_int < 0))) {
                             memcpy(&v1_exp[pos], &v2[pos], float_size);
-                        } else if (strcmp(spec, "T(b)") == 0 ||
-                                   strcmp(spec, "Xi: T(b)") == 0) {
-                            memcpy(&v1_exp[pos], &v3[pos], float_size);
-                        } else if (strcmp(spec, "Xi: T(a*)") == 0) {
-                            memcpy(&v1_exp[pos], &v2[pos], float_size);
-                            snan_to_qnan(&v1_exp[pos], m4);
-                        } else if (strcmp(spec, "Xi: T(b*)") == 0) {
-                            memcpy(&v1_exp[pos], &v3[pos], float_size);
-                            snan_to_qnan(&v1_exp[pos], m4);
-                        } else if (strcmp(spec, "T(M(a,b))") == 0) {
-                            /*
-                             * Comparing floats is risky, since the compiler
-                             * might generate the same instruction that we are
-                             * testing. Compare ints instead. This works,
-                             * because we get here only for +-Fn, and the
-                             * corresponding test values have identical
-                             * exponents.
-                             */
-                            int v2_int = *(int *)&v2[pos];
-                            int v3_int = *(int *)&v3[pos];
-
-                            if ((v2_int < v3_int) ==
-                                ((test->op == VFMIN) != (v2_int < 0))) {
-                                memcpy(&v1_exp[pos], &v2[pos], float_size);
-                            } else {
-                                memcpy(&v1_exp[pos], &v3[pos], float_size);
-                            }
                         } else {
-                            fprintf(stderr, "Unexpected spec: %s\n", spec);
-                            return 1;
+                            memcpy(&v1_exp[pos], &v3[pos], float_size);
                         }
-                        xi_exp |= spec[0] == 'X';
-                        pos += float_size;
+                    } else {
+                        fprintf(stderr, "Unexpected spec: %s\n", spec);
+                        return 1;
+                    }
+                    xi_exp |= spec[0] == 'X';
+                    pos += float_size;
 
-                        if ((m5 & 8) || pos == 16) {
-                            ret |= signed_test(test, m4, m5,
-                                               v1_exp, xi_exp, v2, v3);
-                            pos = 0;
-                            xi_exp = false;
-                        }
+                    if ((m5 & 8) || pos == 16) {
+                        ret |= signed_test(test, m4, m5,
+                                           v1_exp, xi_exp, v2, v3);
+                        pos = 0;
+                        xi_exp = false;
                     }
-                }
+                } while (iter_next(&it, fmt));
 
                 if (pos != 0) {
                     ret |= signed_test(test, m4, m5, v1_exp, xi_exp, v2, v3);
-- 
2.47.0


