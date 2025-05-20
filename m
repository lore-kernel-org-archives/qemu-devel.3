Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FACC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMV2-0004ZQ-SI; Tue, 20 May 2025 08:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUP-0002Rj-Cs; Tue, 20 May 2025 08:54:40 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUM-000117-RI; Tue, 20 May 2025 08:54:37 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30e9397802eso2970361a91.1; 
 Tue, 20 May 2025 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745672; x=1748350472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G0lGd9H5YB3nSr0o+UY98M1y1yG48dZRtLGwlQiSB0=;
 b=ZKc5xag9u76rxyy5Ow3RT9IYqEQR3Yt2KlboQd2REK9iwW2MoW2bb5G00j213vMbqx
 0sAa48dprkoQJhi7/jhpUBNrK5UxiALvVBjAsOb0CLIzOHIMo5oAEXkZ0AvEp2wEoLWe
 X6HB+ZY5uk8IxzagOBpLgLzQRccDB2O3xZG3vU/llK04c7/HRuLrD9oUSuU6dDf6IWOi
 9aM0gST6LaMiYQOAP0W2JM1t9hZ+v74n5sjDTdLkCSp7lJKPVsM5wn/6PTBSS7sa8Yj0
 srnjSlENfINlw6c5tLqpLBjAWJZyMqoGouJ8rLV5Wug7CForW8MqFjtdmNWZh/tAMvJl
 NFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745672; x=1748350472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1G0lGd9H5YB3nSr0o+UY98M1y1yG48dZRtLGwlQiSB0=;
 b=ZyNrIKqU0a3dJ0s02Gfktkrk9ddub93oNAwuSfPj0fuSaFX9euzYHfsqTMtfgZyAdV
 AxAuJKRs0rJdSPcTQkgZsCQRU6S28VuxgEdcpndlMVON3Q1uaKimW9FUDkKnoHbkl/iG
 9tYrhrwnOSR71R8DNOLvb7mLJZpO0KVBsS0Xz9LgIw/ihZMLhF/c/nCnLVjPGZacfHeX
 7E3GGDtRQoQ2RXmHbi/YbZnG1JOEggYBHh9d3bdRFcLeqWbcrs+vDyBzQmocEdi0qafT
 8yaXADQd3r4CKHJkDa4hPyjpE7r3e5Epv1pTQdhY8Rn/sAv9WQ4kF3f77NYWW2d9kqwm
 3Fmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFlG/rEqTyx6MHQWdx81NnrI6dnPoX75X1/1Y8YP56NHzStQvc80PcqxhZISrLPHFEU87142HorUM85A==@nongnu.org,
 AJvYcCXLV1Wk6uf7s3MFSFjIsIN1vNzKaVn9Fik2Fe2uuDNPna6EkxJMLrT5T2VT2Nhq9v6M1PFjRm0qpg==@nongnu.org
X-Gm-Message-State: AOJu0YyTNShCvaUalQxADikbfeUr4jSXQnupOH6h3faorrlwnlHaFUaD
 8P07HVxiHSFfOD73B/aGgb4H13Htcjur+tMmWNEuCQDpIzrqEgsHiZ/cQDb0aNS0
X-Gm-Gg: ASbGncviqcGfD214hARw6E9Y9CFYCwNjZD7S5hH/XREi1bFlEkWf/vnmWT3aZW2Vuiz
 whWhSHUINqtVeEeQlgOP9q8bzk7EE1PLkCoIYXV2U3a1SJkHYDvYr2KL1XkVAVQU9/nqWp3dLv+
 uiLCKf9caDbr7Ys3y6OHqO2q/cVs3wm6Xyet9JWCx6ysYZSurcNxmydNfbaK+EB6AtMW7F7Ffxy
 4rak5Q2LFuvU6fpADtWvZA2hH5uhlJI2EbIx3rMU5UaMlYNlWuPhk7YoRdIMaUQR536Vx51G97A
 GR167I5/uHvT9aNC5zDzpCj6u3IOTc3pMi1SO6eEgYnGa0yyau4bnbhrbNI3lA==
X-Google-Smtp-Source: AGHT+IH5jPj4xy/PBDXM5vca25pM/qZpEeUcxUsvmm+yucQ5nKRbbIWJIY0zAt2Pcv7CYRhywuR8Uw==
X-Received: by 2002:a17:90b:2d47:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-30e7d520bfemr28537283a91.14.1747745671552; 
 Tue, 20 May 2025 05:54:31 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:31 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 24/33] tcg/wasm32: Set TCG_TARGET_REG_BITS to 64
Date: Tue, 20 May 2025 21:51:26 +0900
Message-ID: <8e72ec7b0735c14a2359e95606373ac1ade5a33e.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1030.google.com
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

This commit enables to Wasm backend to run as a 64bit backend with removing
TCG_TARGET_REG_BITS = 32 macros.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.c                     |  5 ++-
 tcg/wasm32/tcg-target-reg-bits.h |  8 +---
 tcg/wasm32/tcg-target.c.inc      | 69 +++-----------------------------
 3 files changed, 9 insertions(+), 73 deletions(-)

diff --git a/tcg/wasm32.c b/tcg/wasm32.c
index 4bc53d76d0..b238ccf6d6 100644
--- a/tcg/wasm32.c
+++ b/tcg/wasm32.c
@@ -370,8 +370,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 unsigned i, s, n;
 
                 tci_args_nl(insn, tb_ptr, &len, &ptr);
-                func = ((void **)ptr)[0];
-                cif = ((void **)ptr)[1];
+                tcg_target_ulong *data = (tcg_target_ulong *)ptr;
+                func = (void *)data[0];
+                cif = (void *)data[1];
 
                 n = cif->nargs;
                 for (i = s = 0; i < n; ++i) {
diff --git a/tcg/wasm32/tcg-target-reg-bits.h b/tcg/wasm32/tcg-target-reg-bits.h
index dcb1a203f8..375feccf91 100644
--- a/tcg/wasm32/tcg-target-reg-bits.h
+++ b/tcg/wasm32/tcg-target-reg-bits.h
@@ -7,12 +7,6 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#if UINTPTR_MAX == UINT32_MAX
-# define TCG_TARGET_REG_BITS 32
-#elif UINTPTR_MAX == UINT64_MAX
-# define TCG_TARGET_REG_BITS 64
-#else
-# error Unknown pointer size for tci target
-#endif
+#define TCG_TARGET_REG_BITS 64
 
 #endif
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index ea9131e6fe..9fad96d0fd 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -30,15 +30,9 @@
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
-#if TCG_TARGET_REG_BITS == 32
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
-#else
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
-#endif
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
 typedef uint32_t tcg_insn_unit_tci;
@@ -3083,39 +3077,6 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
-static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                         TCGArg bl, bool const_bl,
-                         TCGArg bh, bool const_bh, TCGLabel *l)
-{
-    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
-                      al, ah, bl, bh, cond);
-    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpBrcond2 outop_brcond2 = {
-    .base.static_constraint = C_O0_I4(r, r, r, r),
-    .out = tgen_brcond2,
-};
-
-static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                          TCGReg al, TCGReg ah,
-                          TCGArg bl, bool const_bl,
-                          TCGArg bh, bool const_bh)
-{
-    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, ret, al, ah, bl, bh, cond);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpSetcond2 outop_setcond2 = {
-    .base.static_constraint = C_O1_I4(r, r, r, r, r),
-    .out = tgen_setcond2,
-};
-
 static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     tcg_out_op_v(s, INDEX_op_mb);
@@ -3242,18 +3203,8 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .out = tgen_qemu_ld,
 };
 
-static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
-    tcg_out_op_rrrr(s, INDEX_op_qemu_ld2, datalo, datahi, addr, TCG_REG_TMP);
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r),
-    .out =
-        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_ld2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
@@ -3268,18 +3219,8 @@ static const TCGOutOpQemuLdSt outop_qemu_st = {
     .out = tgen_qemu_st,
 };
 
-static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
-    tcg_out_op_rrrr(s, INDEX_op_qemu_st2, datalo, datahi, addr, TCG_REG_TMP);
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r),
-    .out =
-        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_st2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
-- 
2.43.0


