Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4547D1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM3T-0005A2-En; Wed, 26 Nov 2025 15:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3Q-00051d-Pg
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3N-0002bZ-VK
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3c965ca9so124997f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188630; x=1764793430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT9mHQh/gZZ2dKo4MF+31YkpX2DzjKOcapwS4tgx374=;
 b=r4WgKfm2meBORpFb5w6ZXIQdvvaeYHGM/IdhCK/nSir1wDlbJCRnkunXwOZt43HIfU
 1N0k2gLhcrSZUKqDti9T2j+9Cetj14w4s826PucBZIjJSRq12cvDlgeARjphArGoATgI
 7GrzI8iYl0sTenxjofg8mpFjycUGT+wKlLZRIX1wZgA5KL3ooWN1EbWH40sUcSUwmb5V
 oXB6pIocPDUSB7AlEDmnpnPi2juRlAhGvQtejQmDvqdBdPZlTZuXwdwRJRvc1UvAcT18
 LkNh0HNJN4E9HjYBjuI1+9wZVt9ffs1J6wvop6c2CKlT/6NS7RcOq3xP6byxmNu2ouYF
 EIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188630; x=1764793430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mT9mHQh/gZZ2dKo4MF+31YkpX2DzjKOcapwS4tgx374=;
 b=YSEyrmY2us4Eull+DDh4y7vvnPurL0s3/sgWV+Ieae/QJBpkk9zWbv7rEK+ASgeBMT
 CuoHR8S1Y5h3T4+5/7OcqpT2D2Ex0C5vcBE+t5DRC9AlUQNM/nWEoXcE5oqOXmlIJtco
 EPZrLk92x8yR0qsD7LPqeUqnxd+wahq5R2AAepO4EgPICYWOYiwx8NYNJa+ZAZSeA7tl
 zTQJCU3n/DO5G/fyP4CqV5tlznkcGvNtSKkRPgecMTR+qvYC1ngdOZItegjnQ0zHKHt4
 PIn31c7kTEwvH/wftKbmr+CyAU0xFb86m1T1zZ8nmklZdl6gbDjxvTqi466FxqjN17oH
 I27w==
X-Gm-Message-State: AOJu0Yzh/CVjgUPBAt0qLRa/ljc8aik++RkU4YyT3Cqa377IAL9GuNMd
 89NL7UZlisdfuULeVzP9bF4ByguKnx5ktCV21RzLBVi5akSpNWO3QCR+f3wO0jB+XD4i8Xye/Ol
 TPaUc23A3wN+G
X-Gm-Gg: ASbGncsELAKkE3qQWgePwIaFMog7pa8iQ3vvVOkIGtZczCLoxXQSk2TBLmHNu5fuA4a
 2bm1f1Wx+sUcsPsUAfgurH0rk2QtnibxwPzSophlyrSEysG9O3eChtSWnxs4fpGApUpDJJP58HB
 r9w6KRo0/9R+zbb5qdeJ1uda7jOBjGs4Bv7a4VQP1Xcx3K0psGzNoqNRnXi2TgaPhf9HVbqLb6C
 EqWR6Dx6XZvr0UuzaCdRY5saT5auQ2C0+sCN8DeQZCIKMBwHLY7IVw7CUdrLYE8I31ksgvemveE
 h3Zted7qQma8b7Q5K76MgelFF1ejqKOCwiomT5NCz3MPudGfkxYjj6tiYXPQULjKNKDjTtmwxVN
 AXgkCIVTs/eRwRxQpH7kBbQxkMtQr/R1vHAwfGYQK7lQN2XkXKzQDTj+FiWmkenmhel1hOFKMFC
 2+1xQZ0DEgMnQfyVKlKeJrz8g4aVXDeMDDUrzMFpYGQoE/lbg4hAzlZdiAgvnIm+pfhzZT8xc=
X-Google-Smtp-Source: AGHT+IH6A5olRv9vT3iAKm0EUfEljGHGk+u3N+1fknFAFoY7FJxe0Ah6eULZhjKtBubGZF6M0ES+Sw==
X-Received: by 2002:a05:6000:4205:b0:42b:3aca:5a86 with SMTP id
 ffacd0b85a97d-42cc1d6261bmr24005153f8f.57.1764188629734; 
 Wed, 26 Nov 2025 12:23:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm33016245f8f.7.2025.11.26.12.23.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.0 v3 15/22] target/mips: Inline cpu_ld*_mmuidx_ra()
 calls in atomic load helpers
Date: Wed, 26 Nov 2025 21:21:51 +0100
Message-ID: <20251126202200.23100-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

In preparation of removing the cpu_ld*_mmuidx_ra() calls, inline them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 11 +++++------
 target/mips/tcg/translate.c   |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index bef384575c2..85f73c9081d 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -33,7 +33,6 @@
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int memop_idx)\
 {                                                                             \
     MemOpIdx oi = memop_idx;                                                  \
-    unsigned mem_idx = get_mmuidx(oi);                                        \
     MemOp op = get_memop(oi);                                                 \
     unsigned size = memop_size(op);                                           \
     if (arg & (size - 1)) {                                                   \
@@ -45,21 +44,21 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int memop_idx)\
     env->CP0_LLAddr = cpu_mips_translate_address(env, arg, MMU_DATA_LOAD,     \
                                                  GETPC());                    \
     env->lladdr = arg;                                                        \
-    env->llval = cpu_load(env, arg, mem_idx, GETPC());                        \
+    env->llval = cpu_load(env, arg, oi, GETPC());                             \
     return env->llval;                                                        \
 }
 
 static target_ulong loads4(CPUMIPSState *env, target_ulong arg,
-                           unsigned mem_idx, uintptr_t ra)
+                           MemOpIdx oi, uintptr_t ra)
 {
-    return (target_long)(int32_t)cpu_ldl_mmuidx_ra(env, arg, mem_idx, ra);
+    return (target_long)(int32_t)cpu_ldl_mmu(env, arg, oi, ra);
 }
 HELPER_LD_ATOMIC(ll, loads4)
 #ifdef TARGET_MIPS64
 static target_ulong loadu8(CPUMIPSState *env, target_ulong arg,
-                           unsigned mem_idx, uintptr_t ra)
+                           MemOpIdx oi, uintptr_t ra)
 {
-    return (target_ulong)cpu_ldq_mmuidx_ra(env, arg, mem_idx, ra);
+    return (target_ulong)cpu_ldq_mmu(env, arg, oi, ra);
 }
 HELPER_LD_ATOMIC(lld, loadu8)
 #endif
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index c476271d6d5..bb9e91069d6 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1936,7 +1936,7 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-    MemOpIdx oi = make_memop_idx(mop | mo_endian(ctx), mem_idx);           \
+    MemOpIdx oi = make_memop_idx(mop | mo_endian(ctx) | MO_UNALN, mem_idx);\
     gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
 }
 #endif
-- 
2.51.0


