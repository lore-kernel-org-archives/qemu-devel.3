Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE7E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8dT-0004wv-I6; Sun, 12 Jan 2025 19:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dR-0004re-Er
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dP-0000n5-QM
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso25780355e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729330; x=1737334130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8B+FcmJQl4fLmWFGHFzifMbuw+jhH3ih5yJZ9fzjY8=;
 b=YxbSsF2DCJvhYtXJdYsvB6c01/5chFOjXtcc0UC95luW+qK5S818Jlf7xN8YkorpEJ
 h3nGpQH6n98wd+AqJneSBF6ErsxLOBzupyrfG0fB3GLxIFEDXwW1pPdlb3FNOu5K6QpY
 /8mJYVwMbU2tYy6O3Wa5boM/8cJaVrGayS0PdPLEQk/P/6K0+daHYTpwsaQHJctovsuA
 CcmflCQhZU0EqTrBF05zaWsRB3PFNRqQhNEAyokaslXTLM9zm6wUl6KEQQ3a22HJI8JD
 bzYOnrl56fqBuj13CZ7wYzr3dl+Ty7uej68yoj2u9saIkr+RwUe2S9xcJ0HFFJCsXocq
 dgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729330; x=1737334130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8B+FcmJQl4fLmWFGHFzifMbuw+jhH3ih5yJZ9fzjY8=;
 b=f34QNuJCk4UbuUhreuZ2PWVd8VKc7HlxKmnkxZzgvm60b2YMehlp0qWpeX4F/i6BDZ
 IYQz6TsJVq+r4oZGFDi7yZ/QI/JzI4HQJmmwEMUhtUtyJPNE3MahcUaZ1lsucefv42kn
 GlWTXWrtp6Wugauecb9zJuaUNuxgYJAnmowluyruubAOgkGmdO5xEyDTUnFlg7xnxUHi
 i3o+RHawk3iMC0jb1Lx98y4yOp9FTYq0WUr/FtikAOs6kZidYXfQp1+5h8TyU/7cyjhQ
 mq0XydVWa54O3ggUuyOdjWx1svvaIn4knEmj+N1T1Vr0xrk/glYgzFjyg7l4igZcKjM2
 36Rw==
X-Gm-Message-State: AOJu0YxFngc6bPZQiUHqNBcBKpLI8//WTRd6cbPAYaJdVALtxwLnysQM
 VvhbkoAb0z3UHYh9aZpOpiKo8go95uxpxeZW1co03DjEzwxHP1WAajPg0rs5BiRI67QORw/9tGB
 F6mw=
X-Gm-Gg: ASbGncsBV1vQE17juTzfNwTPNSVlz/2qjUp+CXcCLB07PKnxjUS+kf6t7uJl9VZnp++
 xLKe5nD5z+6fbomP0ZH/BZutnlwgJ5eHhn60IJZSEvsOLavEHvtq/T9OAP6NGjYTUsjOPplYk7U
 epih+GwU7/Mvnoh2iQONlnc0GdkH5Z6wpcueFV2dEw3SEaI+vgdB4Vn2mnVfNb8Rr4EiQNay0Mm
 UwkC3JuOatccsYTMwSzS+NPf8LadP5oxU74zLKX2FB5xw4/VKZQwJhIpLhokC/8E402tJO9pU5e
 3sD59GF/1amvwKf4BP9cq0wZx5zACvA=
X-Google-Smtp-Source: AGHT+IEd9TSCfdo2xfaOoSAyDOMFEEJw7zWSK6rA0DVwycHCadF5V8NpdOSj1ciZYshqwfzSvhGLlQ==
X-Received: by 2002:a05:600c:3b02:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-436e26d971emr150249805e9.23.1736729329881; 
 Sun, 12 Jan 2025 16:48:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0babsm160519945e9.14.2025.01.12.16.48.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 10/23] hw/mips/bootloader: Propagate CPU env to bl_gen_li()
Date: Mon, 13 Jan 2025 01:47:35 +0100
Message-ID: <20250113004748.41658-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Propagate the target specific CPU env to the locally
declared bl_gen_li() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 34c3043a563..32811e48cdd 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -216,9 +216,10 @@ static void bl_gen_sd(const CPUMIPSState *env, void **p,
 }
 
 /* Pseudo instructions */
-static void bl_gen_li(void **p, bl_reg rt, uint32_t imm)
+static void bl_gen_li(const CPUMIPSState *env, void **p,
+                      bl_reg rt, uint32_t imm)
 {
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         bl_gen_lui_nm(p, rt, extract32(imm, 12, 20));
         bl_gen_ori_nm(p, rt, rt, extract32(imm, 0, 12));
     } else {
@@ -229,7 +230,7 @@ static void bl_gen_li(void **p, bl_reg rt, uint32_t imm)
 
 static void bl_gen_dli(void **p, bl_reg rt, uint64_t imm)
 {
-    bl_gen_li(p, rt, extract64(imm, 32, 32));
+    bl_gen_li(&MIPS_CPU(first_cpu)->env, p, rt, extract64(imm, 32, 32));
     bl_gen_dsll(&MIPS_CPU(first_cpu)->env, p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 16, 16));
     bl_gen_dsll(&MIPS_CPU(first_cpu)->env, p, rt, rt, 16);
@@ -241,7 +242,7 @@ static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
     if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
         bl_gen_dli(p, rt, imm); /* 64bit */
     } else {
-        bl_gen_li(p, rt, imm); /* 32bit */
+        bl_gen_li(&MIPS_CPU(first_cpu)->env, p, rt, imm); /* 32bit */
     }
 }
 
@@ -293,7 +294,7 @@ void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
 
 void bl_gen_write_u32(void **p, target_ulong addr, uint32_t val)
 {
-    bl_gen_li(p, BL_REG_K0, val);
+    bl_gen_li(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
     bl_gen_sw(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
-- 
2.47.1


