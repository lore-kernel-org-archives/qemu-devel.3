Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7D7C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Cu-00061H-09; Thu, 23 Jan 2025 16:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CK-00058j-4Z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:13 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CH-0002rf-E8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:11 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso15066105e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669427; x=1738274227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C4Efdk0ebVZpJSRXTPNWvPX73CGAEaLiQLefsCf/+k=;
 b=fN2PVtR/K1tXDDmz2i9a8VirgD5oiBIk8yL5km6OtIwTAMTb4ol1EiJ9+daZDmXAtw
 Me39SkNpb+gHO/Filv5uJ+948v6TRF9YDqDIOz6K6ruY+tGvlWgYih9G3C4BfshqIufI
 DRlJQrRx76NnNR04uVAF+N1ZE+dAiSRHyG2Ve73ZOwxr6P954A4h6zSacK7sB8YJr8n7
 UqpK6D4yfNVv5c7A+FkNbLCH6Whp4DHiXi89WaSda5RbvPr1cSYYptdPRrc+cgWlpUB2
 4XT+qgFX7sjXJ/qkp/pJw+LxV7/0KdELbQvxiVkq6hVi8UWDt6MMq+dXBHAnHdrHE/m1
 G8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669427; x=1738274227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/C4Efdk0ebVZpJSRXTPNWvPX73CGAEaLiQLefsCf/+k=;
 b=XGQLvdpcPi0D6jwceVkjuA8Obhcw+X+lx6TAXLh42TqcLPc2SadPteUyGPTjydO6cy
 pgVA/c9R9lgwRI54MwIioo9N0eJ/VBYyfBseXYiyv9pYGzSC99tYz4CUk3RNgvq0EsRd
 lw/CxExMv4jFxclYgz92RlNNPuWJ8mgBP38UJB2vOX9mhOeNU25xHoS6kwYHeFyc6LOZ
 1R5yNir9eRwkgrpjUwLLfujddkWrrnUQyAW6Ac7XPUftBo+NEK50BfkkZShQkucHX9pj
 MmtFW2laaeHYJ/vg0cONv9XyNjHBws2DuIi1oBTaJ7/WCTDp5MZRHKH8XSW0ltPaxzCT
 ka3Q==
X-Gm-Message-State: AOJu0Ywav8f3IrSA/3+o5skruTHUXSmPy9TzTA3VE1X3Fk0I/UeQVxxq
 IqXQD2O9mBJWLCUWcgaPo8IH5o7Bbu9Ri2UlsZgyvx30bcPOgC41s2VdVR9ulUy9Ar2PcAR9wQ9
 ywao=
X-Gm-Gg: ASbGnctpeZO33KDU2spwGz9nlhfvHKVeaQ7l5YIplKqKG+EwVpXFiivIS+LWvG9cVXS
 jR9G03/dMPdMg+DlJJfeAnr1X6kfOvPJ4BBAKVWeyhrB+x7Zp5Q/M8GzRtYPP1AtiCRuDFJUxPd
 aAER29vT+pA4Ld15SkFvbWq+ylU+Y4htqqbURFohbcJbiHAH0qsI55uBw8/DkECmaUdgfbe5N24
 q40VgLV81BdNubmeL1iTSrbLx90Uj8nvCn2+QZmIc1FmiUNP2uv+/SnbjpAALCxte+1G+lYjK7s
 w3G+e3wFJPAqIcCVFeCaBZ9J4cV6gn/4kfEVkGw7FKCs7PlOQ+NM0dM=
X-Google-Smtp-Source: AGHT+IGRqmNkAsF8L61pohPolnGy2aSW2ZwP3BX1txnxnbiDatzUY2WdHPgqvugJzzl/9B4gyEaYDg==
X-Received: by 2002:a05:6000:186f:b0:385:ec6e:e87a with SMTP id
 ffacd0b85a97d-38bf57b75efmr27127807f8f.43.1737669427512; 
 Thu, 23 Jan 2025 13:57:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bbc8dsm784421f8f.72.2025.01.23.13.57.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:57:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/15] target/ppc: Restrict various common helpers to TCG
Date: Thu, 23 Jan 2025 22:56:05 +0100
Message-ID: <20250123215609.30432-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move helpers common to system/user emulation to tcg-excp_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c     | 141 ----------------------------------
 target/ppc/tcg-excp_helper.c | 143 +++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 141 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 56a56148a40..48e08d65bd7 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2634,148 +2634,7 @@ void helper_rfmci(CPUPPCState *env)
     /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
     do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
 }
-#endif /* !CONFIG_USER_ONLY */
 
-void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
-               uint32_t flags)
-{
-    if (!likely(!(((int32_t)arg1 < (int32_t)arg2 && (flags & 0x10)) ||
-                  ((int32_t)arg1 > (int32_t)arg2 && (flags & 0x08)) ||
-                  ((int32_t)arg1 == (int32_t)arg2 && (flags & 0x04)) ||
-                  ((uint32_t)arg1 < (uint32_t)arg2 && (flags & 0x02)) ||
-                  ((uint32_t)arg1 > (uint32_t)arg2 && (flags & 0x01))))) {
-        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                               POWERPC_EXCP_TRAP, GETPC());
-    }
-}
-
-#ifdef TARGET_PPC64
-void helper_TD(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
-               uint32_t flags)
-{
-    if (!likely(!(((int64_t)arg1 < (int64_t)arg2 && (flags & 0x10)) ||
-                  ((int64_t)arg1 > (int64_t)arg2 && (flags & 0x08)) ||
-                  ((int64_t)arg1 == (int64_t)arg2 && (flags & 0x04)) ||
-                  ((uint64_t)arg1 < (uint64_t)arg2 && (flags & 0x02)) ||
-                  ((uint64_t)arg1 > (uint64_t)arg2 && (flags & 0x01))))) {
-        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                               POWERPC_EXCP_TRAP, GETPC());
-    }
-}
-#endif /* TARGET_PPC64 */
-
-static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
-{
-    const uint16_t c = 0xfffc;
-    const uint64_t z0 = 0xfa2561cdf44ac398ULL;
-    uint16_t z = 0, temp;
-    uint16_t k[32], eff_k[32], xleft[33], xright[33], fxleft[32];
-
-    for (int i = 3; i >= 0; i--) {
-        k[i] = key & 0xffff;
-        key >>= 16;
-    }
-    xleft[0] = x & 0xffff;
-    xright[0] = (x >> 16) & 0xffff;
-
-    for (int i = 0; i < 28; i++) {
-        z = (z0 >> (63 - i)) & 1;
-        temp = ror16(k[i + 3], 3) ^ k[i + 1];
-        k[i + 4] = c ^ z ^ k[i] ^ temp ^ ror16(temp, 1);
-    }
-
-    for (int i = 0; i < 8; i++) {
-        eff_k[4 * i + 0] = k[4 * i + ((0 + lane) % 4)];
-        eff_k[4 * i + 1] = k[4 * i + ((1 + lane) % 4)];
-        eff_k[4 * i + 2] = k[4 * i + ((2 + lane) % 4)];
-        eff_k[4 * i + 3] = k[4 * i + ((3 + lane) % 4)];
-    }
-
-    for (int i = 0; i < 32; i++) {
-        fxleft[i] = (rol16(xleft[i], 1) &
-            rol16(xleft[i], 8)) ^ rol16(xleft[i], 2);
-        xleft[i + 1] = xright[i] ^ fxleft[i] ^ eff_k[i];
-        xright[i + 1] = xleft[i];
-    }
-
-    return (((uint32_t)xright[32]) << 16) | xleft[32];
-}
-
-static uint64_t hash_digest(uint64_t ra, uint64_t rb, uint64_t key)
-{
-    uint64_t stage0_h = 0ULL, stage0_l = 0ULL;
-    uint64_t stage1_h, stage1_l;
-
-    for (int i = 0; i < 4; i++) {
-        stage0_h |= ror64(rb & 0xff, 8 * (2 * i + 1));
-        stage0_h |= ((ra >> 32) & 0xff) << (8 * 2 * i);
-        stage0_l |= ror64((rb >> 32) & 0xff, 8 * (2 * i + 1));
-        stage0_l |= (ra & 0xff) << (8 * 2 * i);
-        rb >>= 8;
-        ra >>= 8;
-    }
-
-    stage1_h = (uint64_t)helper_SIMON_LIKE_32_64(stage0_h >> 32, key, 0) << 32;
-    stage1_h |= helper_SIMON_LIKE_32_64(stage0_h, key, 1);
-    stage1_l = (uint64_t)helper_SIMON_LIKE_32_64(stage0_l >> 32, key, 2) << 32;
-    stage1_l |= helper_SIMON_LIKE_32_64(stage0_l, key, 3);
-
-    return stage1_h ^ stage1_l;
-}
-
-static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
-                    target_ulong rb, uint64_t key, bool store)
-{
-    uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
-
-    if (store) {
-        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
-    } else {
-        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
-        if (loaded_hash != calculated_hash) {
-            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                POWERPC_EXCP_TRAP, GETPC());
-        }
-    }
-}
-
-#include "qemu/guest-random.h"
-
-#ifdef TARGET_PPC64
-#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
-void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
-                 target_ulong rb)                                             \
-{                                                                             \
-    if (env->msr & R_MSR_PR_MASK) {                                           \
-        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PRO_##dexcr_aspect##_MASK ||      \
-            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
-            return;                                                           \
-    } else if (!(env->msr & R_MSR_HV_MASK)) {                                 \
-        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PNH_##dexcr_aspect##_MASK ||      \
-            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
-            return;                                                           \
-    } else if (!(env->msr & R_MSR_S_MASK)) {                                  \
-        if (!(env->spr[SPR_HDEXCR] & R_HDEXCR_HNU_##dexcr_aspect##_MASK))     \
-            return;                                                           \
-    }                                                                         \
-                                                                              \
-    do_hash(env, ea, ra, rb, key, store);                                     \
-}
-#else
-#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
-void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
-                 target_ulong rb)                                             \
-{                                                                             \
-    do_hash(env, ea, ra, rb, key, store);                                     \
-}
-#endif /* TARGET_PPC64 */
-
-HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
-HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
-HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
-HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
-
-#ifndef CONFIG_USER_ONLY
 /* Embedded.Processor Control */
 static int dbell2irq(target_ulong rb)
 {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index ecc9e4de8ba..124a81fd699 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -66,6 +66,149 @@ void raise_exception(CPUPPCState *env, uint32_t exception)
     raise_exception_err_ra(env, exception, 0, 0);
 }
 
+#endif /* CONFIG_USER_ONLY */
+
+void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+               uint32_t flags)
+{
+    if (!likely(!(((int32_t)arg1 < (int32_t)arg2 && (flags & 0x10)) ||
+                  ((int32_t)arg1 > (int32_t)arg2 && (flags & 0x08)) ||
+                  ((int32_t)arg1 == (int32_t)arg2 && (flags & 0x04)) ||
+                  ((uint32_t)arg1 < (uint32_t)arg2 && (flags & 0x02)) ||
+                  ((uint32_t)arg1 > (uint32_t)arg2 && (flags & 0x01))))) {
+        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                               POWERPC_EXCP_TRAP, GETPC());
+    }
+}
+
+#ifdef TARGET_PPC64
+void helper_TD(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+               uint32_t flags)
+{
+    if (!likely(!(((int64_t)arg1 < (int64_t)arg2 && (flags & 0x10)) ||
+                  ((int64_t)arg1 > (int64_t)arg2 && (flags & 0x08)) ||
+                  ((int64_t)arg1 == (int64_t)arg2 && (flags & 0x04)) ||
+                  ((uint64_t)arg1 < (uint64_t)arg2 && (flags & 0x02)) ||
+                  ((uint64_t)arg1 > (uint64_t)arg2 && (flags & 0x01))))) {
+        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                               POWERPC_EXCP_TRAP, GETPC());
+    }
+}
+#endif /* TARGET_PPC64 */
+
+static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
+{
+    const uint16_t c = 0xfffc;
+    const uint64_t z0 = 0xfa2561cdf44ac398ULL;
+    uint16_t z = 0, temp;
+    uint16_t k[32], eff_k[32], xleft[33], xright[33], fxleft[32];
+
+    for (int i = 3; i >= 0; i--) {
+        k[i] = key & 0xffff;
+        key >>= 16;
+    }
+    xleft[0] = x & 0xffff;
+    xright[0] = (x >> 16) & 0xffff;
+
+    for (int i = 0; i < 28; i++) {
+        z = (z0 >> (63 - i)) & 1;
+        temp = ror16(k[i + 3], 3) ^ k[i + 1];
+        k[i + 4] = c ^ z ^ k[i] ^ temp ^ ror16(temp, 1);
+    }
+
+    for (int i = 0; i < 8; i++) {
+        eff_k[4 * i + 0] = k[4 * i + ((0 + lane) % 4)];
+        eff_k[4 * i + 1] = k[4 * i + ((1 + lane) % 4)];
+        eff_k[4 * i + 2] = k[4 * i + ((2 + lane) % 4)];
+        eff_k[4 * i + 3] = k[4 * i + ((3 + lane) % 4)];
+    }
+
+    for (int i = 0; i < 32; i++) {
+        fxleft[i] = (rol16(xleft[i], 1) &
+            rol16(xleft[i], 8)) ^ rol16(xleft[i], 2);
+        xleft[i + 1] = xright[i] ^ fxleft[i] ^ eff_k[i];
+        xright[i + 1] = xleft[i];
+    }
+
+    return (((uint32_t)xright[32]) << 16) | xleft[32];
+}
+
+static uint64_t hash_digest(uint64_t ra, uint64_t rb, uint64_t key)
+{
+    uint64_t stage0_h = 0ULL, stage0_l = 0ULL;
+    uint64_t stage1_h, stage1_l;
+
+    for (int i = 0; i < 4; i++) {
+        stage0_h |= ror64(rb & 0xff, 8 * (2 * i + 1));
+        stage0_h |= ((ra >> 32) & 0xff) << (8 * 2 * i);
+        stage0_l |= ror64((rb >> 32) & 0xff, 8 * (2 * i + 1));
+        stage0_l |= (ra & 0xff) << (8 * 2 * i);
+        rb >>= 8;
+        ra >>= 8;
+    }
+
+    stage1_h = (uint64_t)helper_SIMON_LIKE_32_64(stage0_h >> 32, key, 0) << 32;
+    stage1_h |= helper_SIMON_LIKE_32_64(stage0_h, key, 1);
+    stage1_l = (uint64_t)helper_SIMON_LIKE_32_64(stage0_l >> 32, key, 2) << 32;
+    stage1_l |= helper_SIMON_LIKE_32_64(stage0_l, key, 3);
+
+    return stage1_h ^ stage1_l;
+}
+
+static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
+                    target_ulong rb, uint64_t key, bool store)
+{
+    uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
+
+    if (store) {
+        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
+    } else {
+        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
+        if (loaded_hash != calculated_hash) {
+            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                POWERPC_EXCP_TRAP, GETPC());
+        }
+    }
+}
+
+#include "qemu/guest-random.h"
+
+#ifdef TARGET_PPC64
+#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
+void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
+                 target_ulong rb)                                             \
+{                                                                             \
+    if (env->msr & R_MSR_PR_MASK) {                                           \
+        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PRO_##dexcr_aspect##_MASK ||      \
+            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
+            return;                                                           \
+    } else if (!(env->msr & R_MSR_HV_MASK)) {                                 \
+        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PNH_##dexcr_aspect##_MASK ||      \
+            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
+            return;                                                           \
+    } else if (!(env->msr & R_MSR_S_MASK)) {                                  \
+        if (!(env->spr[SPR_HDEXCR] & R_HDEXCR_HNU_##dexcr_aspect##_MASK))     \
+            return;                                                           \
+    }                                                                         \
+                                                                              \
+    do_hash(env, ea, ra, rb, key, store);                                     \
+}
+#else
+#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
+void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
+                 target_ulong rb)                                             \
+{                                                                             \
+    do_hash(env, ea, ra, rb, key, store);                                     \
+}
+#endif /* TARGET_PPC64 */
+
+HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
+HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
+HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
+HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
+
+#ifndef CONFIG_USER_ONLY
+
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr)
-- 
2.47.1


