Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D815FC28B25
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDUT-0003iY-8T; Thu, 06 Mar 2025 10:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTs-0001ff-0r
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:52 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTq-0006Pv-AO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso533535f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276188; x=1741880988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tN8MUCR59yT1PPc6yhlXwubOk3u9382+22fqIhPwV6Q=;
 b=F1+dCZfx9smevkYfX546qkYJuRQPls9DVG8+aPO+1MWnzHeNtdQZZT1uLKyfOF9joL
 to89XuqEcsPRanXi4FH3x/GFgm1tkj+ElYkSt1J5dHvJKNSyS9doWZvrWB8QJqnre1MT
 1jCl4T6p+74C6aF4MS3lwPBfwewMKs4/qn7qpGqy3wbnUq+KknhNX24RR254yceb/QCm
 ogZBGHDeJA1TeKptwAe+MtSbb2HGfP47EgDx3LUBQPs/CvZukb7owEZQnIwQSx5ARDq+
 W4C4DhyDIvSzgGi4j5TfAy1fCDug3RA12FGfQrljRdPK/m9MlAGKeyLiwjQjAKQYC+zx
 0SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276188; x=1741880988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tN8MUCR59yT1PPc6yhlXwubOk3u9382+22fqIhPwV6Q=;
 b=sMH55rRV9jHX83kk/Z1cuEkF4y1kYLxuB1d1HDRMHuz88iFw19D89Zkmj81cZcOnL9
 xUYHPNujG1kHL/MEX+VE9CAsfqVmAMe+dD9Qhi93HcwRc8Ev5oWe4pMsLGOOPyu78If3
 ulA9VkiSpshH91dgNfqowIkaIuq6L6N/6w9F9me8alNhv41qElo2ziWhVw9WtmtdKqs8
 O1dE+aiSC6ZeH9DXjP7hyAuBUIBwOn/TxgnBJaXFYUsW5kqCjGYcfY0sYZwN/qAl7kCE
 5YgE5Y2z7/txxIooKT1xDmiB7A3pGg77T3/yotQhqk2G/sXQHPvGyxYqnj2NKAacDnLg
 nljw==
X-Gm-Message-State: AOJu0Yxy+AgcZxqD3xRt9R6E7lT0QgPOXOs0dkGCG/XcV/lACFJIt/vJ
 8wjaWyUSfztDkxPxzTr3MwOgn/KKI9yYBkxMFg5OQjdkgRDeAZIMunE3i5/o6b+UWLIndMcKUjc
 Iqgk=
X-Gm-Gg: ASbGncu92On7+ug1EyNwknhtLxjiCa5nANN9jPxKww0DyopFRx49JSEPQq+esmWUy9y
 UA7k/aQOYvmQFW7Lwpva61nG4GJeKS/HbJDF/ou9KppKSWHCjhDqjonrG3g2oYjIL3yrO5+2Kf2
 EFJiSgd7uzzTSeO1Ti8mEtVu/LaUlgGmzIjtRBLWCDyLjY4QHG/dhwmRRwaIgTJ5WgCmkbIKyIJ
 jfBFX9tKqmSLDKf5EbGieC5GpZ3O/NiKj3sNStPYmrjWmBCkmfsRHp0TgeXk/WHZy5yf2b2mQCs
 Po2pHoHiQ2fv7ZoHz6mVkpxwcGGhWSaqk1S/h9dfbNS4nxJQKWM0Ay/n/1/62xgzKmzF905ggCX
 zxcHoLSoKbSmTPzm/WRM=
X-Google-Smtp-Source: AGHT+IHxRlfu4FBJ94iJFB9sf/brhCb/i8kpYjVchB/zZlv7pql9rvIAphOvf+hmqJHy0WQAw8xVHw==
X-Received: by 2002:a5d:6da2:0:b0:38f:451b:653c with SMTP id
 ffacd0b85a97d-3911f72fe43mr5891315f8f.7.1741276188481; 
 Thu, 06 Mar 2025 07:49:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103035sm2380215f8f.88.2025.03.06.07.49.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/54] target/microblaze: Consider endianness while translating
 code
Date: Thu,  6 Mar 2025 16:47:11 +0100
Message-ID: <20250306154737.70886-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Consider the CPU ENDI bit, swap instructions when the CPU
endianness doesn't match the binary one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241105130431.22564-17-philmd@linaro.org>
---
 target/microblaze/cpu.h       | 7 +++++++
 target/microblaze/translate.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f6879eee352..e44ddd53078 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -414,6 +414,13 @@ void mb_translate_code(CPUState *cs, TranslationBlock *tb,
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
+static inline bool mb_cpu_is_big_endian(CPUState *cs)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    return !cpu->cfg.endi;
+}
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b5389d65b2e..b54e5ac4b2f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -710,7 +710,7 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
@@ -1647,7 +1647,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
+    ir = translator_ldl_swap(cpu_env(cs), &dc->base, dc->base.pc_next,
+                             mb_cpu_is_big_endian(cs) != TARGET_BIG_ENDIAN);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.47.1


