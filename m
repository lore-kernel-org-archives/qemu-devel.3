Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975ED11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM40-0005rP-2u; Wed, 26 Nov 2025 15:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3c-0005h4-E3
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3Z-0002e3-8s
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:07 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso972165e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188643; x=1764793443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFt8xjFc2jyIEqMIXlWNQ0K51n6YypSN5PbrP8ZEBgM=;
 b=Kgf1uwJql0i0V+yh8VTby46QQNmq1qoBuvKCiZS2urU1QUbwvaXyYCp75UKyK5fbx4
 QJLMyzEAPCBBRAt4TyX2UcbuuSispsDY2kKh9zttOwO81vYkgdRzRza5Ulih0ctzJTAa
 sDZI1TS3bGlgkLO/HREln4DR32dWhcqYFGi296i8r/9jilJt76QQ2VYYFI7CAHRxWQ+0
 3rbP7lyyWfdUFvpoJQ8lc/mgFs6xU/0s3XBg4M/9ccepYC056Edlkk4nTwQ0SwMZf3Fn
 IQEY1fEcXX0mIEOMN2//jO/NKpwthFwrTzlTwzQs0Ay9cH9LGdffaRrlDauNA9aosHLL
 gY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188643; x=1764793443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OFt8xjFc2jyIEqMIXlWNQ0K51n6YypSN5PbrP8ZEBgM=;
 b=A1Y1VKfl8DoWCc/q3jZ5JQ1NEdP7UC9/Fj9gCQCtGLljI6crllH+q8aNyvTNda8m0I
 S8mQ+YYU5U02EJPpOfj9yevHZKsBwFSfz0h+wGmvVQGQz6OWeJ5AzWblP15tEfN8dcdY
 JZbmfJkV0IP5V54Hm4zY1MOGeMQXrqooRQOP+TLAAEcshPC0o2w7iSJ4zc+xzWjRKptH
 8I3tdsSzPjtj0l+cp8TPudts+wC5umcOXTMgsiNflP2kH1eo8WVjdY7eSdK0s6TwUhNA
 vB9KIqDHBL4DJI4/5vJybCvPgmUneVwFlFKDSHQ9VJIVwjyr95iVC8XGfifotguHCqyF
 Ie2w==
X-Gm-Message-State: AOJu0YxA0c8MuKrEKHNOz7nR0MsBPEjiaTzlb38TxmXqbvJoHdRYJELD
 lrx7eg1/Y6TewZ3WftiDGzV0z09QWkW9hdlfO5BQAeyMP6WE+hweVNdnGQ/sjw4Z0LrhdJHiWto
 2LlSClbwR2dcy
X-Gm-Gg: ASbGnctcRBuUb8zV20nBa7m0x1sr+Xwhr0OT6pDBqj54oKPS9Jc7psSayqAO8jLCxOQ
 ryNd7F7UwSUGOaH3iiKGmzDCsv3JpA7UA9zgTBvgeG/aj2cuMUG0Sq0gzz/zqwma8y2x0dOPzda
 FKDd6UyP8/feLw3fwWnLuAZ0/5cg9zfKQTpmbligGGwrLvcYERxTfSLPhz3WQN8Nhr36sSVezRV
 E7PqG4oq2NO81K7xZ/Osvfx5qSwi+0ooqvNCYpqBdxKkXeW0SM8nQOOF8NEavShea42gw89bsMa
 8ZWyb4Vqx3BruiOzcyKzx4Aq/PbwOINcAla03hTOwd08HvT9pDOG3IzD3+/uL01yJXfkbzPb8Q6
 MfyR/raA2r6iOht0+zHTiIGdm7ZaUerHXAYI9YiwCb+Go/P5WXYuf1r2NyllnSGr9VyuCEzFGvd
 yT19fWuh75tYcUWtK8kN3zFYvlsTmqdAUDk+YVFjqwq0EUEuyRl30+ANvjheXT
X-Google-Smtp-Source: AGHT+IF9rzJSNaNQ3ISJDVVX4suoyj3Pd104uEdaJyVxO1Y7FY2YVCJdnXi6wOEk17aocQFzReEIjg==
X-Received: by 2002:a05:600c:1c29:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-477c10c85e2mr238459565e9.4.1764188643478; 
 Wed, 26 Nov 2025 12:24:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a28sm63171165e9.9.2025.11.26.12.24.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:24:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.0 v3 17/22] target/mips: Inline cpu_ld/st_mmuidx_ra()
 calls in memory helpers
Date: Wed, 26 Nov 2025 21:21:53 +0100
Message-ID: <20251126202200.23100-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
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

In preparation of removing the cpu_ld*_mmuidx_ra() and
cpu_st*_mmuidx_ra() calls, inline them. Expand MO_TE to
mo_endian_env(env).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 49 +++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index f3652034afa..716b60e3a39 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -237,8 +237,10 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
 static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
 
 void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t mmu_idx)
 {
+    MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
+    MemOpIdx oi = make_memop_idx(op, mmu_idx);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -247,20 +249,22 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 
         for (i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
-                (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
+                (target_long)cpu_ldl_mmu(env, addr, oi, GETPC());
             addr += 4;
         }
     }
 
     if (do_r31) {
         env->active_tc.gpr[31] =
-            (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
+            (target_long)cpu_ldl_mmu(env, addr, oi, GETPC());
     }
 }
 
 void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t mmu_idx)
 {
+    MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
+    MemOpIdx oi = make_memop_idx(op, mmu_idx);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -268,58 +272,59 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
-            cpu_stl_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
-                              mem_idx, GETPC());
+            cpu_stl_mmu(env, addr, env->active_tc.gpr[multiple_regs[i]],
+                        oi, GETPC());
             addr += 4;
         }
     }
 
     if (do_r31) {
-        cpu_stl_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
+        cpu_stl_mmu(env, addr, env->active_tc.gpr[31], oi, GETPC());
     }
 }
 
 #if defined(TARGET_MIPS64)
 void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t mmu_idx)
 {
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
+    uintptr_t retaddr = GETPC();
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ | MO_UNALN,
+                                 mmu_idx);
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
-            env->active_tc.gpr[multiple_regs[i]] =
-                cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
+        for (unsigned i = 0; i < base_reglist; i++) {
+            env->active_tc.gpr[multiple_regs[i]] = cpu_ldq_mmu(env, addr,
+                                                               oi, retaddr);
             addr += 8;
         }
     }
 
     if (do_r31) {
-        env->active_tc.gpr[31] =
-            cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
+        env->active_tc.gpr[31] = cpu_ldq_mmu(env, addr, oi, retaddr);
     }
 }
 
 void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t mmu_idx)
 {
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
+    uintptr_t retaddr = GETPC();
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ | MO_UNALN,
+                                 mmu_idx);
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
-            cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
-                              mem_idx, GETPC());
+        for (unsigned i = 0; i < base_reglist; i++) {
+            cpu_stq_mmu(env, addr, env->active_tc.gpr[multiple_regs[i]],
+                        oi, retaddr);
             addr += 8;
         }
     }
 
     if (do_r31) {
-        cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
+        cpu_stq_mmu(env, addr, env->active_tc.gpr[31], oi, retaddr);
     }
 }
 
-- 
2.51.0


