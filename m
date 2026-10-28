Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ignition-web.co.uk header.i=@ignition-web.co.uk header.a=rsa-sha256 header.s=protonmail2 header.b=aQexvoJe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAV9-000063-H0; Wed, 28 Oct 2026 16:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gareth@ignition-web.co.uk>)
 id 1xM8WY-0002gh-OQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:37:23 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gareth@ignition-web.co.uk>)
 id 1xM8WV-0004Nd-Ja
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ignition-web.co.uk;
 s=protonmail2; t=1793212626; x=1793471826;
 bh=2NuPTQQd9jwYb6//IS3lu9/u+2hNuz8ro3DLO7EJEfA=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aQexvoJeG/ewXVCoxNocSWtyIi0MoMc7h3fLW4QYcPYgVhdOPtTk3oAVUk28tAzf6
 3aj8OgppanGSuXWkQ8skZIHLhTE40WF2zf1+Tu3iVkqkQPM6qdwJOVpZ3O4zVGyMHm
 FthcXE8m4+QHwqQdXe57X5ZaTrGxTTZGjNisRLFmRNzjjlmr3t4pJIqrWGsv7Q1QB0
 0wnyxWWHo3WVdykaDZ5IoLvdEG0OeRwTklkOd2hje37NZwvBwj+ORmnmODOZxAEelK
 BNFPac8Y7EPa8N3f+JkD5BFrOl7uuwe2r5naVv1+WrO+3coiW5Qb5f3+b9HtpT8CfH
 hCN//jAS4QcUA==
X-Pm-Submission-Id: 4jFGL741pjz2Scn7
From: Gareth Lloyd <gareth@ignition-web.co.uk>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH] target/i386: use host SSE2 for pack and unpack
Date: Wed, 28 Oct 2026 18:36:19 +0000
Message-ID: <20261028183619.740347-1-gareth@ignition-web.co.uk>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.210.45;
 envelope-from=gareth@ignition-web.co.uk; helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Oct 2026 16:43:53 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These helpers move bytes rather than interpret them, so a host SSE2
instruction gives bit-exact results and needs no gate on the float
environment. A host without the routines keeps the portable loops.

tests/tcg/i386/test-avx.c and test-mmx.c already cover these
instructions.

Signed-off-by: Gareth Lloyd <gareth@ignition-web.co.uk>
---
 MAINTAINERS                          |  1 +
 host/include/generic/host/vec-pack.h | 49 +++++++++++++++++
 host/include/x86_64/host/vec-pack.h  | 78 ++++++++++++++++++++++++++++
 target/i386/ops_sse.h                | 47 +++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 host/include/generic/host/vec-pack.h
 create mode 100644 host/include/x86_64/host/vec-pack.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8884e4177e..2cf806754a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -460,6 +460,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
 F: target/i386/tcg/
+F: host/include/*/host/vec-pack.h
 F: tests/tcg/i386/
 F: tests/tcg/x86_64/
 F: hw/i386/
diff --git a/host/include/generic/host/vec-pack.h b/host/include/generic/host/vec-pack.h
new file mode 100644
index 0000000000..338b2acca8
--- /dev/null
+++ b/host/include/generic/host/vec-pack.h
@@ -0,0 +1,49 @@
+/*
+ * No host specific pack and unpack acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GENERIC_HOST_VEC_PACK_H
+#define GENERIC_HOST_VEC_PACK_H
+
+#define HAVE_VEC_PACK_ACCEL  false
+
+void vec_pack_sswb_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_pack_uswb_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_pack_ssdw_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_lbw_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_lwd_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_ldq_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_hbw_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_hwd_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_hdq_64_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+
+void vec_pack_sswb_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_pack_uswb_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_pack_ssdw_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_lbw_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_lwd_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_ldq_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_hbw_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_hwd_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+void vec_unpck_hdq_128_accel(void *, const void *, const void *)
+    QEMU_ERROR("unsupported accel");
+
+#endif /* GENERIC_HOST_VEC_PACK_H */
diff --git a/host/include/x86_64/host/vec-pack.h b/host/include/x86_64/host/vec-pack.h
new file mode 100644
index 0000000000..21236998fa
--- /dev/null
+++ b/host/include/x86_64/host/vec-pack.h
@@ -0,0 +1,78 @@
+/*
+ * x86 specific pack and unpack acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef X86_HOST_VEC_PACK_H
+#define X86_HOST_VEC_PACK_H
+
+#include <emmintrin.h>
+
+/* SSE2 is in the x86-64 baseline: nothing to detect, no target attribute. */
+#define HAVE_VEC_PACK_ACCEL  true
+
+/* Guest registers have no alignment guarantee, so copy instead of load. */
+static inline __m128i host_vec_ld64(const void *p)
+{
+    __m128i v = _mm_setzero_si128();
+    memcpy(&v, p, 8);
+    return v;
+}
+
+static inline __m128i host_vec_ld128(const void *p)
+{
+    __m128i v;
+    memcpy(&v, p, 16);
+    return v;
+}
+
+#define VEC_PACK_64(op, expr)                                           \
+    static inline void                                                  \
+    glue(glue(vec_, op), _64_accel)(void *d, const void *v,             \
+                                    const void *s)                      \
+    {                                                                   \
+        __m128i a = host_vec_ld64(v), b = host_vec_ld64(s), r = (expr); \
+        memcpy(d, &r, 8);                                               \
+    }
+
+#define VEC_PACK_128(op, expr)                                          \
+    static inline void                                                  \
+    glue(glue(vec_, op), _128_accel)(void *d, const void *v,            \
+                                     const void *s)                     \
+    {                                                                   \
+        __m128i a = host_vec_ld128(v), b = host_vec_ld128(s),           \
+                r = (expr);                                             \
+        memcpy(d, &r, 16);                                              \
+    }
+
+/* Both operands in one register, so one instruction covers both halves. */
+#define VEC_JOIN64   _mm_unpacklo_epi64(a, b)
+/* Interleaving the upper halves is the low instruction on shifted operands. */
+#define VEC_HI64(x)  _mm_srli_si128(x, 4)
+
+VEC_PACK_64(pack_sswb, _mm_packs_epi16(VEC_JOIN64, _mm_setzero_si128()))
+VEC_PACK_64(pack_uswb, _mm_packus_epi16(VEC_JOIN64, _mm_setzero_si128()))
+VEC_PACK_64(pack_ssdw, _mm_packs_epi32(VEC_JOIN64, _mm_setzero_si128()))
+VEC_PACK_64(unpck_lbw, _mm_unpacklo_epi8(a, b))
+VEC_PACK_64(unpck_lwd, _mm_unpacklo_epi16(a, b))
+VEC_PACK_64(unpck_ldq, _mm_unpacklo_epi32(a, b))
+VEC_PACK_64(unpck_hbw, _mm_unpacklo_epi8(VEC_HI64(a), VEC_HI64(b)))
+VEC_PACK_64(unpck_hwd, _mm_unpacklo_epi16(VEC_HI64(a), VEC_HI64(b)))
+VEC_PACK_64(unpck_hdq, _mm_unpacklo_epi32(VEC_HI64(a), VEC_HI64(b)))
+
+VEC_PACK_128(pack_sswb, _mm_packs_epi16(a, b))
+VEC_PACK_128(pack_uswb, _mm_packus_epi16(a, b))
+VEC_PACK_128(pack_ssdw, _mm_packs_epi32(a, b))
+VEC_PACK_128(unpck_lbw, _mm_unpacklo_epi8(a, b))
+VEC_PACK_128(unpck_lwd, _mm_unpacklo_epi16(a, b))
+VEC_PACK_128(unpck_ldq, _mm_unpacklo_epi32(a, b))
+VEC_PACK_128(unpck_hbw, _mm_unpackhi_epi8(a, b))
+VEC_PACK_128(unpck_hwd, _mm_unpackhi_epi16(a, b))
+VEC_PACK_128(unpck_hdq, _mm_unpackhi_epi32(a, b))
+
+#undef VEC_JOIN64
+#undef VEC_HI64
+#undef VEC_PACK_64
+#undef VEC_PACK_128
+
+#endif /* X86_HOST_VEC_PACK_H */
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index b39fcde353..f24bf608f9 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -21,6 +21,8 @@
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
 #include "crypto/clmul.h"
+#include "host/vec-pack.h"
+
 
 #if SHIFT == 0
 #define Reg MMXReg
@@ -47,6 +49,26 @@
 #define LANE_WIDTH (SHIFT ? 16 : 8)
 #define PACK_WIDTH (LANE_WIDTH / 2)
 
+/*
+ * The routines take the register's bytes in order, which is what B(0) gives
+ * on a little-endian host and not on a big-endian one.
+ */
+QEMU_BUILD_BUG_ON(HAVE_VEC_PACK_ACCEL && HOST_BIG_ENDIAN);
+
+#undef VEC_PACK_OK
+#undef VEC_ACCEL
+#undef VEC_ACCEL_CALL
+#if SHIFT == 0
+#define VEC_PACK_OK     HAVE_VEC_PACK_ACCEL
+#define VEC_ACCEL(op)   glue(glue(vec_, op), _64_accel)
+#else
+/* There are no 256-bit routines, so the compiler drops the call for SHIFT 2. */
+#define VEC_PACK_OK     (HAVE_VEC_PACK_ACCEL && SHIFT == 1)
+#define VEC_ACCEL(op)   glue(glue(vec_, op), _128_accel)
+#endif
+#define VEC_ACCEL_CALL(op, d, v, s)                                     \
+    VEC_ACCEL(op)(&(d)->B(0), &(v)->B(0), &(s)->B(0))
+
 #if SHIFT == 0
 #define FPSRL(x, c) ((x) >> shift)
 #define FPSRAW(x, c) ((int16_t)(x) >> shift)
@@ -1184,6 +1206,11 @@ void HELPER(glue(pack ## name, SUFFIX))(CPUX86State *env,     \
 {                                                             \
     uint8_t r[PACK_WIDTH * 2];                                \
     int j, k;                                                 \
+                                                              \
+    if (VEC_PACK_OK) {                                        \
+        VEC_ACCEL_CALL(pack_ ## name, d, v, s);               \
+        return;                                               \
+    }                                                         \
     for (j = 0; j < 4 << SHIFT; j += PACK_WIDTH) {            \
         for (k = 0; k < PACK_WIDTH; k++) {                    \
             r[k] = F((int16_t)v->W(j + k));                   \
@@ -1205,6 +1232,11 @@ void glue(HELPER(packssdw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     uint16_t r[PACK_WIDTH];
     int j, k;
 
+    if (VEC_PACK_OK) {
+        VEC_ACCEL_CALL(pack_ssdw, d, v, s);
+        return;
+    }
+
     for (j = 0; j < 2 << SHIFT; j += PACK_WIDTH / 2) {
         for (k = 0; k < PACK_WIDTH / 2; k++) {
             r[k] = satsw(v->L(j + k));
@@ -1226,6 +1258,11 @@ void glue(HELPER(packssdw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
         uint8_t r[PACK_WIDTH * 2];                                      \
         int j, i;                                                       \
                                                                         \
+        if (VEC_PACK_OK) {                                              \
+            VEC_ACCEL_CALL(unpck_ ## base_name ## bw, d, v, s);         \
+            return;                                                     \
+        }                                                               \
+                                                                        \
         for (j = 0; j < 8 << SHIFT; ) {                                 \
             int k = j + base * PACK_WIDTH;                              \
             for (i = 0; i < PACK_WIDTH; i++) {                          \
@@ -1244,6 +1281,11 @@ void glue(HELPER(packssdw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
         uint16_t r[PACK_WIDTH];                                         \
         int j, i;                                                       \
                                                                         \
+        if (VEC_PACK_OK) {                                              \
+            VEC_ACCEL_CALL(unpck_ ## base_name ## wd, d, v, s);         \
+            return;                                                     \
+        }                                                               \
+                                                                        \
         for (j = 0; j < 4 << SHIFT; ) {                                 \
             int k = j + base * PACK_WIDTH / 2;                          \
             for (i = 0; i < PACK_WIDTH / 2; i++) {                      \
@@ -1262,6 +1304,11 @@ void glue(HELPER(packssdw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
         uint32_t r[PACK_WIDTH / 2];                                     \
         int j, i;                                                       \
                                                                         \
+        if (VEC_PACK_OK) {                                              \
+            VEC_ACCEL_CALL(unpck_ ## base_name ## dq, d, v, s);         \
+            return;                                                     \
+        }                                                               \
+                                                                        \
         for (j = 0; j < 2 << SHIFT; ) {                                 \
             int k = j + base * PACK_WIDTH / 4;                          \
             for (i = 0; i < PACK_WIDTH / 4; i++) {                      \
-- 
2.43.0


