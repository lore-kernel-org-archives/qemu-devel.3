Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B889AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzI6-0001f3-31; Tue, 11 Mar 2025 09:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEI-0005QP-Qa; Tue, 11 Mar 2025 09:01:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzED-0000CT-QB; Tue, 11 Mar 2025 09:01:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22355618fd9so99664825ad.3; 
 Tue, 11 Mar 2025 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698059; x=1742302859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Biw+0LaKs2HJdMoWQD130jxziht29GfeWu2Z9l8GRBs=;
 b=jNgGFDfs+JE4sbk8FPEcPOiBf2oLd8vucgPWU6NrziL5kR2Lf/WfdVQqi5fod8WWFi
 Mt5PtO5KZvRTvV6Dg+xVcq4nypNLe3B4+9tDFrPXlSpaKhHVcmSq8NDqmJcGAjCL55Mw
 SAN4XqUqNQv/ZlpeRvXwxSH43ZG/5JAoncWx+r8iRQxqWJqhRRtePGG2QONWziotXj9W
 j+/i6a9Ug0PDEFAmQpY2uq84fLhnSc0X7bFRCZrGpBSiTovnMmxUzCl1T+grDPXsgBDo
 J+64yMUvrK+49RSH9y4LdovP/OeWkXuyrMzpQmATVOdVrWPK1uDGo0nomiZNSHSA6Eh2
 6dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698059; x=1742302859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Biw+0LaKs2HJdMoWQD130jxziht29GfeWu2Z9l8GRBs=;
 b=fM4tjZzEa9l28/ytnGyPPHWQuwwOZ1LQYs0e897Cp0aWuEeulq2NIrSBrBlPzmoIjF
 xqXjAEt6RwrR5JqQd6YWyRMIb/1d8zk4IOqrA2XVysqBzp0nLn45U9fxktVdNmBGEZBf
 7cZbpDGJrQ7wk0IqwgNatX2/KKvm/tyTLZclDCwNNIyJqMxSzt/KXbdgMTzOztAGDTB2
 lwJZRbjUnRGUac4D3Ya91J/ArRHZMBBPq77aM8egtPcKQoJLlmdd/Lc26TmRbpxXo7F7
 lHY5ePfSpmJNm0BonIb7Y9bXeaHghfXZdeiKVq+WKnj5/5daA7BEMGQDsabHDB/QM69R
 ZXSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Ys8zXU+SLE73bhNCYMKI2mUqsZGsR5PhXFwTeUthNQ0E5x4dpHU5ByxufiDvft427O2VK/ubLQ==@nongnu.org
X-Gm-Message-State: AOJu0YwYBiXH+ElDlBfW1UUXeCCdr+9a1cjCFuWnCKMX45tPWjT2wok/
 gyK+JWp/GGDHYpEMxIkiwDIN90SgIPLhnpUxxMJY5sjSJ0YSxGOZQJC2Bw==
X-Gm-Gg: ASbGncsU3BQWghfGrrS1mg/8d1DwLZ/HoegM4pYdqqSWr1DgO+JsYoV4HSHKWsVb2zq
 ju1MdYXot9Qll6b0083DbEbui7gnWZngl+Kk5iTdC9md8BsU3a6uFUrPhP29zbqZHBLiAC21qac
 iXlndXexSN2K4IrqiF8oAkGJ8EUVD/H5ooZkDkQ1V9eZdOB3UL0COdRv7T/AYTbd/TaZZwxQRqG
 mPgj9gvygHzIBWrp1zrtSs+Q98k6wkcYADQpQxYYwu2Jap6d/C8z1fkTeNURGMly0Bswmy9Jk7U
 jdHZqzf63I23qLfwkv2vFJF7rcvzwXMxmNXEBR5cnM5WeZvkRwY=
X-Google-Smtp-Source: AGHT+IEN2raaLOqVO0ZPFX4PCEgIolIjqfTVMFmar8x3HrSJ/wAhF1QBtB3+lHf9sRyqOCUeLk3sHA==
X-Received: by 2002:a17:902:d2cd:b0:224:255b:c934 with SMTP id
 d9443c01a7336-225931af86amr33975445ad.51.1741698059286; 
 Tue, 11 Mar 2025 06:00:59 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 50/72] target/ppc: Restrict various common helpers to TCG
Date: Tue, 11 Mar 2025 22:57:44 +1000
Message-ID: <20250311125815.903177-51-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move helpers common to system/user emulation to tcg-excp_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-12-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c     | 141 ----------------------------------
 target/ppc/tcg-excp_helper.c | 143 +++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 141 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6a12402b23..511e27f726 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2711,148 +2711,7 @@ void helper_rfmci(CPUPPCState *env)
     /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
     do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
 }
-#endif /* !CONFIG_USER_ONLY */
-
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
index 268a161459..2459d2d095 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -66,6 +66,149 @@ void raise_exception(CPUPPCState *env, uint32_t exception)
     raise_exception_err_ra(env, exception, 0, 0);
 }
 
+#endif /* !CONFIG_USER_ONLY */
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


