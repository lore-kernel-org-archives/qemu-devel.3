Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2FFC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYW-0006uY-BO; Mon, 13 Jan 2025 14:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQY3-0006Ht-D8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:32 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQY1-0007Ux-SO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:31 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso3994737f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798188; x=1737402988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSQ6tOIqSgfSP2eO5tirnLm+sm6xp3bCsJh/HJRKhFk=;
 b=S4NDcSxsIwWOLE1EK3RkznC0XZ3tiVY/UGtERi83ON53nnopreUMONCXX6flybMAt9
 wgAEg3jLSDhiO2ehZHm/1aXggOX+onbR/XWuxw6WRuKsb3FI2/Vie9YW1tSLmgVxr13u
 kIiSMI0gY3rqM96RQYQcr/0UnB4iVcPeO9fu8OiFki9kOe6WMUHeH0RYR1Vxy77vM6R3
 i6wsbDxT5suX5wjuk5pdpdYSoRdHXUwybGzxYYozaG6Deoiw3baLnORTJZ40yg2Evghz
 LlhgsytwyXMUqq1xvUAijkzPQpW+2z5vww7M+Ws7x6wHsVJLIvaRgjEfzOWk2JIDbXhG
 53nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798188; x=1737402988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSQ6tOIqSgfSP2eO5tirnLm+sm6xp3bCsJh/HJRKhFk=;
 b=je/gCrrY9XlkO5yIGN0nXo8St7TfJcENf5cxEQ94YgiQD50G4Vp6tiORowpm06SY7a
 3KhOyTBpSONMf+eWma6dWUAt103gSYi4AHbQ6ojWx/m3wsu0n7ieXggR1yUxA1bSkZgf
 MzaoIEVd7zk2Q4pt8t3JOyXp07I+V6OiqKTAgeM3065IiKBGo4CAWuL3dgC0PUJuXHIC
 Jv36UVfLa6sWc6Y1QSYXg3J33BXPmcMxk/Ie0WrIkYEpWcpnNwdsf1IeCZnfe3mtVA7j
 3dhahg3kAgZTYbHcBS70N21hU3pD6CKbT2eaP27izoakR/uDblOScxqE66BPE1bfC8Ig
 +rBQ==
X-Gm-Message-State: AOJu0YyyVEsT/a3cZ57/4vd0wsrZbuonJhHPqAbS1/Pz7YEh0BC+Fc5X
 oUvweA/vjxK4Gr0p7VlagAM30Y/XlFmyiZqKbxkTMjIbNSksJIrfTlY0oqM2Jj8he1qsOd5sV9p
 uSYs=
X-Gm-Gg: ASbGnctLLW15dhzivQFgI7QWCDMASTCGovLG+AqhXP1NS8NQOvr1hH+l0s1gT0IVZZF
 lkfyz/3nbaJYMfwP2QGFZroGsg4G0PBm/jvpBvonxDoaLnuDI23qQnqrb4F2cDpFc4GyWQktud0
 qdf9pMvpG2hTWgSeweaqS2SmcWs+svpK7PpEN+wFPf7qWmcsrMB3h0rN2MNIvUUFz3MDKdw91c2
 xHHtE7wDQwIe9kX6C9F/aU8LtIpmVJMV0d87N4pCIafynBOXFrUyEKQmSsFddSfVJ5lNUxRyxvF
 Mv4H1pVlT9TghftfdaQL1IbZ4y4NxtI=
X-Google-Smtp-Source: AGHT+IFSaiY38oRk9SbHM4emv/t9WQ9O90IOF0/0Lnmw0Iju67lWNC9g8TaiISP93ZmILEoZ/Tbs1A==
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id
 ffacd0b85a97d-38a87317e45mr18717454f8f.53.1736798188220; 
 Mon, 13 Jan 2025 11:56:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8826sm152686025e9.11.2025.01.13.11.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 12/19] hw/mips/bootloader: Propagate CPU env to
 bl_gen_load_ulong()
Date: Mon, 13 Jan 2025 20:55:18 +0100
Message-ID: <20250113195525.57150-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
declared bl_gen_load_ulong() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 9b074d9903b..198506431c5 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -233,7 +233,8 @@ static void bl_gen_dli(void **p, bl_reg rt, uint64_t imm)
     bl_gen_ori(p, rt, rt, extract64(imm, 0, 16));
 }
 
-static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
+static void bl_gen_load_ulong(const CPUMIPSState *env, void **p,
+                              bl_reg rt, target_ulong imm)
 {
     if (bootcpu_supports_isa(ISA_MIPS3)) {
         bl_gen_dli(p, rt, imm); /* 64bit */
@@ -245,7 +246,9 @@ static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
 /* Helpers */
 void bl_gen_jump_to(const MIPSCPU *cpu, void **p, target_ulong jump_addr)
 {
-    bl_gen_load_ulong(p, BL_REG_T9, jump_addr);
+    const CPUMIPSState *env = &cpu->env;
+
+    bl_gen_load_ulong(env, p, BL_REG_T9, jump_addr);
     bl_gen_jalr(p, BL_REG_T9);
     bl_gen_nop(p); /* delay slot */
 }
@@ -258,20 +261,22 @@ void bl_gen_jump_kernel(const MIPSCPU *cpu, void **p,
                         bool set_a3, target_ulong a3,
                         target_ulong kernel_addr)
 {
+    const CPUMIPSState *env = &cpu->env;
+
     if (set_sp) {
-        bl_gen_load_ulong(p, BL_REG_SP, sp);
+        bl_gen_load_ulong(env, p, BL_REG_SP, sp);
     }
     if (set_a0) {
-        bl_gen_load_ulong(p, BL_REG_A0, a0);
+        bl_gen_load_ulong(env, p, BL_REG_A0, a0);
     }
     if (set_a1) {
-        bl_gen_load_ulong(p, BL_REG_A1, a1);
+        bl_gen_load_ulong(env, p, BL_REG_A1, a1);
     }
     if (set_a2) {
-        bl_gen_load_ulong(p, BL_REG_A2, a2);
+        bl_gen_load_ulong(env, p, BL_REG_A2, a2);
     }
     if (set_a3) {
-        bl_gen_load_ulong(p, BL_REG_A3, a3);
+        bl_gen_load_ulong(env, p, BL_REG_A3, a3);
     }
 
     bl_gen_jump_to(cpu, p, kernel_addr);
@@ -280,8 +285,10 @@ void bl_gen_jump_kernel(const MIPSCPU *cpu, void **p,
 void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
                         target_ulong addr, target_ulong val)
 {
-    bl_gen_load_ulong(p, BL_REG_K0, val);
-    bl_gen_load_ulong(p, BL_REG_K1, addr);
+    const CPUMIPSState *env = &cpu->env;
+
+    bl_gen_load_ulong(env, p, BL_REG_K0, val);
+    bl_gen_load_ulong(env, p, BL_REG_K1, addr);
     if (bootcpu_supports_isa(ISA_MIPS3)) {
         bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
@@ -292,15 +299,19 @@ void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
 void bl_gen_write_u32(const MIPSCPU *cpu, void **p,
                       target_ulong addr, uint32_t val)
 {
+    const CPUMIPSState *env = &cpu->env;
+
     bl_gen_li(p, BL_REG_K0, val);
-    bl_gen_load_ulong(p, BL_REG_K1, addr);
+    bl_gen_load_ulong(env, p, BL_REG_K1, addr);
     bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
 }
 
 void bl_gen_write_u64(const MIPSCPU *cpu, void **p,
                       target_ulong addr, uint64_t val)
 {
+    const CPUMIPSState *env = &cpu->env;
+
     bl_gen_dli(p, BL_REG_K0, val);
-    bl_gen_load_ulong(p, BL_REG_K1, addr);
+    bl_gen_load_ulong(env, p, BL_REG_K1, addr);
     bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
 }
-- 
2.47.1


