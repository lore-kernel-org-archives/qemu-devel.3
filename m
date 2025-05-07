Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02604C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4w-0006CM-KI; Wed, 07 May 2025 17:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4l-000694-4b
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4j-0006Cg-DE
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso372747b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652388; x=1747257188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EprzNqSDVLOk3XX3wLzyS3Mr8if5bv8/i0zNJtnFHWU=;
 b=dQT6qzKFNaylsnAuZhEuNMPUiMXjONyLbpCQh3nDreNTCnGLmriUMy3SbwoOWpuNPX
 QR5gSxCxJKIOXllvDqL6zUAL8mWfBP40LBi1VBExLn1hDj4NP0aY/FwZbHLGuZCObpr7
 PFlipGHY9Ply/qDsUn3hiCk7CK4hhwNWPjoH92rbWwc09X/eijdQi99yo1goj07mcmNV
 zGBQleV9sYqH+kvJvxksWwMjMam13lUm0yiK0qwMmhCmOrcJOokfjC4bd/1nb21wNvaJ
 FpZiGAFeU20MsKZNiLZ/FRdWQPJ2CYCt2j6cf2IqLXJwiz3LMJLTnuBEFUPkNh8cQRgc
 g2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652388; x=1747257188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EprzNqSDVLOk3XX3wLzyS3Mr8if5bv8/i0zNJtnFHWU=;
 b=IH5oDtDKeaUyBSKZ8Bk78uR8CftkQlLNlvFKuNE6qzcG7DxKd10aSgi/LOUYFgHCwp
 0T2aX7rwOOFM51JYznE1kGQJsHZqYuieiXNYpOgyv77gj/jkDhqt9jPPyVN4VEngagFk
 w/ByZENwkvOCgdyoHBPcf4bfDqhxuG4SnrBohPFWnNu6K4fvawriz1NACvCAjJ2RcNOt
 sboJOBTNSnhkL68hrMMQrbpE7ac5yWpxcaWzxtIeC4vVS7ftg/Z7ekIL12SrF2tE3JKB
 scjpxjzUQ6zbvmTmfw3RQTjuAHyJT/ObKOU/3NLqpaHyuLXreqJGaKAF0l28ZSHnKg/X
 kbUg==
X-Gm-Message-State: AOJu0YyaD3Z9eYVZ5DCTZ6fu4XuSFh+nZfbxIJ0Loq4ukwQCfJikPCrO
 X1Zl9ukrGtbIKISa4uAbza8IDufEeKAacBEXqhgVMXtLqiZ2C7pkNwLup6QHOgRsJ2FV0z+V0cI
 9
X-Gm-Gg: ASbGnctHEFVcy9MGNJV+N9XZ86EG3op3Mcqkz8EhWb/HFd53o6E7oxAi+eXL/I+0zm3
 60V63jtexTqAFDazWpPxRI8531mdd+DqGirRvdDTFNRGuBr/SgjAQGsfbHzIjQOtdBRL9uulhZs
 YWJGlW7rd+UV7jWu2w4Ti46wkCgScaZMU0H4j2utg//+KZvVBfk6iWitDsOFHg49X7RNhXiDOF/
 zg7F5bUvBDKqsKO0oyXWyX9Klwi/QMIEZuA/Z5XdXSDqKO57Gl7VE6HjYO/l1y8Cze8fqL9Ur4G
 aEshbd+TB/1EiNMr0s4YI6lNHginAgOpYBpWQExMcMWzZ4oQfjSEsK132pewEF8eOvuDycljgBY
 =
X-Google-Smtp-Source: AGHT+IGWu7LBbLfVmM1UcQH04FOxl3JOrAQZJa1yR+Eh49szQzCCmvDQeov2+TgfSR6wCR3uQ4nZtQ==
X-Received: by 2002:a05:6a00:35c6:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-740a99638a6mr1176389b3a.4.1746652388021; 
 Wed, 07 May 2025 14:13:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 07/24] target/m68k: Merge gen_ea into SRC_EA and DEST_EA
Date: Wed,  7 May 2025 14:12:42 -0700
Message-ID: <20250507211300.9735-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

This will enable further cleanups further down the call chain.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 340d72bc4f..b9633e06da 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -897,14 +897,6 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     return NULL_QREG;
 }
 
-static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                   int opsize, TCGv val, TCGv *addrp, ea_what what, int index)
-{
-    int mode = extract32(insn, 3, 3);
-    int reg0 = REG(insn, 0);
-    return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what, index);
-}
-
 static TCGv_ptr gen_fp_ptr(int freg)
 {
     TCGv_ptr fp = tcg_temp_new_ptr();
@@ -1368,18 +1360,22 @@ static void gen_exit_tb(DisasContext *s)
     s->base.is_jmp = DISAS_EXIT;
 }
 
-#define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
-        result = gen_ea(env, s, insn, opsize, NULL_QREG, addrp,         \
-                        op_sign ? EA_LOADS : EA_LOADU, IS_USER(s));     \
+#define SRC_EA(env, result, opsize, op_sign, addrp)                     \
+    do {                                                                \
+        result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
+                             REG(insn, 0), opsize, NULL_QREG, addrp,    \
+                             op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
         }                                                               \
     } while (0)
 
-#define DEST_EA(env, insn, opsize, val, addrp) do {                     \
-        TCGv ea_result = gen_ea(env, s, insn, opsize, val, addrp,       \
-                                EA_STORE, IS_USER(s));                  \
+#define DEST_EA(env, insn, opsize, val, addrp)                          \
+    do {                                                                \
+        TCGv ea_result = gen_ea_mode(env, s, extract32(insn, 3, 3),     \
+                                     REG(insn, 0), opsize, val, addrp,  \
+                                     EA_STORE, IS_USER(s));             \
         if (IS_NULL_QREG(ea_result)) {                                  \
             gen_addr_fault(s);                                          \
             return;                                                     \
-- 
2.43.0


