Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B3BCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSIt-0007fG-1e; Wed, 10 Apr 2024 03:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIo-0007Ye-GT; Wed, 10 Apr 2024 03:23:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIl-0003uA-Jl; Wed, 10 Apr 2024 03:23:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D00B55D676;
 Wed, 10 Apr 2024 10:25:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 72C36B02B7;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191665 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 07/87] target/arm: Fix 32-bit SMOPA
Date: Wed, 10 Apr 2024 10:21:40 +0300
Message-Id: <20240410072303.4191455-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

While the 8-bit input elements are sequential in the input vector,
the 32-bit output elements are not sequential in the output matrix.
Do not attempt to compute 2 32-bit outputs at the same time.

Cc: qemu-stable@nongnu.org
Fixes: 23a5e3859f5 ("target/arm: Implement SME integer outer product")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2083
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240305163931.242795-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d572bcb222010b38b382871a23b2f38e2c3f4d2d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 904bfdac43..e2e0575039 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1083,11 +1083,32 @@ void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
-typedef uint64_t IMOPFn(uint64_t, uint64_t, uint64_t, uint8_t, bool);
+typedef uint32_t IMOPFn32(uint32_t, uint32_t, uint32_t, uint8_t, bool);
+static inline void do_imopa_s(uint32_t *za, uint32_t *zn, uint32_t *zm,
+                              uint8_t *pn, uint8_t *pm,
+                              uint32_t desc, IMOPFn32 *fn)
+{
+    intptr_t row, col, oprsz = simd_oprsz(desc) / 4;
+    bool neg = simd_data(desc);
+
+    for (row = 0; row < oprsz; ++row) {
+        uint8_t pa = (pn[H1(row >> 1)] >> ((row & 1) * 4)) & 0xf;
+        uint32_t *za_row = &za[tile_vslice_index(row)];
+        uint32_t n = zn[H4(row)];
 
-static inline void do_imopa(uint64_t *za, uint64_t *zn, uint64_t *zm,
-                            uint8_t *pn, uint8_t *pm,
-                            uint32_t desc, IMOPFn *fn)
+        for (col = 0; col < oprsz; ++col) {
+            uint8_t pb = pm[H1(col >> 1)] >> ((col & 1) * 4);
+            uint32_t *a = &za_row[H4(col)];
+
+            *a = fn(n, zm[H4(col)], *a, pa & pb, neg);
+        }
+    }
+}
+
+typedef uint64_t IMOPFn64(uint64_t, uint64_t, uint64_t, uint8_t, bool);
+static inline void do_imopa_d(uint64_t *za, uint64_t *zn, uint64_t *zm,
+                              uint8_t *pn, uint8_t *pm,
+                              uint32_t desc, IMOPFn64 *fn)
 {
     intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
     bool neg = simd_data(desc);
@@ -1107,25 +1128,16 @@ static inline void do_imopa(uint64_t *za, uint64_t *zn, uint64_t *zm,
 }
 
 #define DEF_IMOP_32(NAME, NTYPE, MTYPE) \
-static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
+static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
 {                                                                           \
-    uint32_t sum0 = 0, sum1 = 0;                                            \
+    uint32_t sum = 0;                                                       \
     /* Apply P to N as a mask, making the inactive elements 0. */           \
     n &= expand_pred_b(p);                                                  \
-    sum0 += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                              \
-    sum0 += (NTYPE)(n >> 8) * (MTYPE)(m >> 8);                              \
-    sum0 += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                            \
-    sum0 += (NTYPE)(n >> 24) * (MTYPE)(m >> 24);                            \
-    sum1 += (NTYPE)(n >> 32) * (MTYPE)(m >> 32);                            \
-    sum1 += (NTYPE)(n >> 40) * (MTYPE)(m >> 40);                            \
-    sum1 += (NTYPE)(n >> 48) * (MTYPE)(m >> 48);                            \
-    sum1 += (NTYPE)(n >> 56) * (MTYPE)(m >> 56);                            \
-    if (neg) {                                                              \
-        sum0 = (uint32_t)a - sum0, sum1 = (uint32_t)(a >> 32) - sum1;       \
-    } else {                                                                \
-        sum0 = (uint32_t)a + sum0, sum1 = (uint32_t)(a >> 32) + sum1;       \
-    }                                                                       \
-    return ((uint64_t)sum1 << 32) | sum0;                                   \
+    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
+    sum += (NTYPE)(n >> 8) * (MTYPE)(m >> 8);                               \
+    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
+    sum += (NTYPE)(n >> 24) * (MTYPE)(m >> 24);                             \
+    return neg ? a - sum : a + sum;                                         \
 }
 
 #define DEF_IMOP_64(NAME, NTYPE, MTYPE) \
@@ -1151,16 +1163,17 @@ DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
 DEF_IMOP_64(sumopa_d, int16_t, uint16_t)
 DEF_IMOP_64(usmopa_d, uint16_t, int16_t)
 
-#define DEF_IMOPH(NAME) \
-    void HELPER(sme_##NAME)(void *vza, void *vzn, void *vzm, void *vpn,      \
-                            void *vpm, uint32_t desc)                        \
-    { do_imopa(vza, vzn, vzm, vpn, vpm, desc, NAME); }
-
-DEF_IMOPH(smopa_s)
-DEF_IMOPH(umopa_s)
-DEF_IMOPH(sumopa_s)
-DEF_IMOPH(usmopa_s)
-DEF_IMOPH(smopa_d)
-DEF_IMOPH(umopa_d)
-DEF_IMOPH(sumopa_d)
-DEF_IMOPH(usmopa_d)
+#define DEF_IMOPH(NAME, S) \
+    void HELPER(sme_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
+                                  void *vpn, void *vpm, uint32_t desc)      \
+    { do_imopa_##S(vza, vzn, vzm, vpn, vpm, desc, NAME##_##S); }
+
+DEF_IMOPH(smopa, s)
+DEF_IMOPH(umopa, s)
+DEF_IMOPH(sumopa, s)
+DEF_IMOPH(usmopa, s)
+
+DEF_IMOPH(smopa, d)
+DEF_IMOPH(umopa, d)
+DEF_IMOPH(sumopa, d)
+DEF_IMOPH(usmopa, d)
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index cded1d01fc..ea3e232e65 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -67,7 +67,7 @@ endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-AARCH64_TESTS += sme-outprod1
+AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
 endif
 
 # System Registers Tests
diff --git a/tests/tcg/aarch64/sme-smopa-1.c b/tests/tcg/aarch64/sme-smopa-1.c
new file mode 100644
index 0000000000..c62d5e0007
--- /dev/null
+++ b/tests/tcg/aarch64/sme-smopa-1.c
@@ -0,0 +1,47 @@
+#include <stdio.h>
+#include <string.h>
+
+int main()
+{
+    static const int cmp[4][4] = {
+        {  110,  134,  158,  182 },
+        {  390,  478,  566,  654 },
+        {  670,  822,  974, 1126 },
+        {  950, 1166, 1382, 1598 }
+    };
+    int dst[4][4];
+    int *tmp = &dst[0][0];
+
+    asm volatile(
+        ".arch armv8-r+sme\n\t"
+        "smstart\n\t"
+        "index z0.b, #0, #1\n\t"
+        "movprfx z1, z0\n\t"
+        "add z1.b, z1.b, #16\n\t"
+        "ptrue p0.b\n\t"
+        "smopa za0.s, p0/m, p0/m, z0.b, z1.b\n\t"
+        "ptrue p0.s, vl4\n\t"
+        "mov w12, #0\n\t"
+        "st1w { za0h.s[w12, #0] }, p0, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w { za0h.s[w12, #1] }, p0, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w { za0h.s[w12, #2] }, p0, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w { za0h.s[w12, #3] }, p0, [%0]\n\t"
+        "smstop"
+        : "+r"(tmp) : : "memory");
+
+    if (memcmp(cmp, dst, sizeof(dst)) == 0) {
+        return 0;
+    }
+
+    /* See above for correct results. */
+    for (int i = 0; i < 4; ++i) {
+        for (int j = 0; j < 4; ++j) {
+            printf("%6d", dst[i][j]);
+        }
+        printf("\n");
+    }
+    return 1;
+}
diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smopa-2.c
new file mode 100644
index 0000000000..c9f48c3bfc
--- /dev/null
+++ b/tests/tcg/aarch64/sme-smopa-2.c
@@ -0,0 +1,54 @@
+#include <stdio.h>
+#include <string.h>
+
+int main()
+{
+    static const long cmp[4][4] = {
+        {  110,  134,  158,  182 },
+        {  390,  478,  566,  654 },
+        {  670,  822,  974, 1126 },
+        {  950, 1166, 1382, 1598 }
+    };
+    long dst[4][4];
+    long *tmp = &dst[0][0];
+    long svl;
+
+    /* Validate that we have a wide enough vector for 4 elements. */
+    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=r"(svl));
+    if (svl < 32) {
+        return 0;
+    }
+
+    asm volatile(
+        "smstart\n\t"
+        "index z0.h, #0, #1\n\t"
+        "movprfx z1, z0\n\t"
+        "add z1.h, z1.h, #16\n\t"
+        "ptrue p0.b\n\t"
+        "smopa za0.d, p0/m, p0/m, z0.h, z1.h\n\t"
+        "ptrue p0.d, vl4\n\t"
+        "mov w12, #0\n\t"
+        "st1d { za0h.d[w12, #0] }, p0, [%0]\n\t"
+        "add %0, %0, #32\n\t"
+        "st1d { za0h.d[w12, #1] }, p0, [%0]\n\t"
+        "mov w12, #2\n\t"
+        "add %0, %0, #32\n\t"
+        "st1d { za0h.d[w12, #0] }, p0, [%0]\n\t"
+        "add %0, %0, #32\n\t"
+        "st1d { za0h.d[w12, #1] }, p0, [%0]\n\t"
+        "smstop"
+        : "+r"(tmp) : : "memory");
+
+    if (memcmp(cmp, dst, sizeof(dst)) == 0) {
+        return 0;
+    }
+
+    /* See above for correct results. */
+    for (int i = 0; i < 4; ++i) {
+        for (int j = 0; j < 4; ++j) {
+            printf("%6ld", dst[i][j]);
+        }
+        printf("\n");
+    }
+    return 1;
+}
-- 
2.39.2


