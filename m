Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E73C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMU9-00022S-0e; Tue, 20 May 2025 08:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTv-0001c1-EH; Tue, 20 May 2025 08:54:07 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTp-0000w8-6z; Tue, 20 May 2025 08:54:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30ec226b7d6so2581874a91.2; 
 Tue, 20 May 2025 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745638; x=1748350438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbZX43g+ERfcOdN/FYEqrH5HB45spFaPpgCTkfGLlg0=;
 b=gr1IKavKYMZ4VRNAVe1LjvWHHoscZiTfzjUM3NQ5ZH4O9b8P5e2ZCtC0oeXpxjay68
 GFYjHfgqWLYWtWewblLQb4xAWxilaqwW2McNFo550TKeaxFKbJZ/FeimiJXFR4UUrrFm
 ygZZJZpVZTrUJ1+fcQG/lUgyBSGYTI8AV4OQWbZDp1NumGbpf3xha6bi4792sFVoP2OP
 nnTKl7ihdgrKvR2QpD3XdNoG1dGwbjmODljbqdxCntfPtgNAHatNoiPHswvoNDrnaPV8
 Oe8F+POqTYVJFBxzpcNbdJHzFyHQrt/6F9zCmp6OhZ+TvgN9wSB1KzwAI3wUCYR0TaqQ
 l4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745638; x=1748350438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbZX43g+ERfcOdN/FYEqrH5HB45spFaPpgCTkfGLlg0=;
 b=m7EzyNDMIcHIurW7DjROjINT8QcEAltBcxOfstjSagijt4Zt4WJ1wqdXwlPQxUXBPa
 rQSw+KJkhwa/1r1O2JZU4O5lwfuQ5RTz7/4NvKYAcDmXb4CtQTgeMCzYi04ujJQKFgLT
 10RTor904lxeuHGjGKxerZ2eDHy8HoU7fx/X6ivhof2aZwLy2C6kJpB6Zm7sH4N5tDzG
 ub0nz/lgUlfLkjNMhJDFLbp9Lln6vKFemYwxuBVGlRMBFN3M7VvsXd7s7xJ+gT22V43/
 UkSmnxHfuKdjQaRLmr4q2AW7tErj7IZ/I2ewu7YtFucJlHcbU08l1kLZPwsy25nAFyJx
 2yag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVWzn8mSz/GRS3krtD7wn9H5WzlGnNGxsoLnUQBYgu6oHM6HKh0rYq44dW/w8gGE5aSvaKUizCrw==@nongnu.org,
 AJvYcCWiWcRaENWzgglnsGWeqQBQQuMgi9wOvZnXnnNEoaIqEE4jR6SNu2OHDA2K4zDnOuycR52zRWvIisNrpg==@nongnu.org
X-Gm-Message-State: AOJu0YxFTdutFLV70ubFGEd4rVSJ11h3mzelZEk8SxPwSpLdvX6F3Uyn
 7ReQuy1cT1mnQuoM+xzc+Qdi1hC03cUuSpHvb/iGl4USwsJ+MIt28tjOqA2Dy0oZ
X-Gm-Gg: ASbGnctvZNcd8w2Lyvzb72c+5c5/Vh4exZMW2HaCQpB08/YdNdV27JIq+wbwUQ1z++r
 TLd+EaTKm567Ox6G9BN4mnyQYwVn+LzjVm6EiprHW4gk5x5lqCP7M9Hi8t5XSzkDD+oTAjYN4yO
 1Uk1JBvzDyViFW5cbUKITvsML5mWPy2BLSej9SKFvwyNsFNydZ2KduRl59ArI5Qw58CDoqjb8IU
 WaAy53Awa3fboG8g/+wq8rDMygBKYc77NgnMVUgGs68MseFuOIxIW3lmHbn2Gc38RBib52jsB7w
 0I4AWb3P8oCvjafyfrmt7/UbhvzWEdtGLTVHUJqPi25FGIt41Ac=
X-Google-Smtp-Source: AGHT+IHuOm/86ztaL4MQCbuQAhFYIVkJJTKeycgm07PUBHqOLU5sp7gXPnJumnQRDpcHc7aR0NgZzA==
X-Received: by 2002:a17:90b:1dd1:b0:305:5f32:d9f5 with SMTP id
 98e67ed59e1d1-30e7d4f9220mr28781405a91.7.1747745637647; 
 Tue, 20 May 2025 05:53:57 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:57 -0700 (PDT)
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
Subject: [PATCH 18/33] tcg/wasm32: Add addc/subb instructions
Date: Tue, 20 May 2025 21:51:20 +0900
Message-ID: <a2137c5fc4e332cb991bc191e3d68a07b1d565c7.1747744132.git.ktokunaga.mail@gmail.com>
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

This commit implements addc and subb operations using Wasm instructions. A
carry flag is introduced as the 16th variable in the module following other
15 variables that represent TCG variables.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 151 ++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 75e47f8c8c..167850ea7c 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -118,6 +118,11 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
     15, /* TCG_REG_R15 */
 };
 
+/*
+ * Global variable to store the carry flag
+ */
+#define CARRY_IDX 16
+
 /* Temporary local variables */
 #define TMP32_LOCAL_0_IDX 1
 #define TMP32_LOCAL_1_IDX 2
@@ -324,10 +329,23 @@ static void tcg_wasm_out_op_i32_eqz(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x45);
 }
+static void tcg_wasm_out_op_i64_lt_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x54);
+}
+static void tcg_wasm_out_op_i64_le_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x58);
+}
 static void tcg_wasm_out_op_i64_eqz(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x50);
 }
+static void tcg_wasm_out_op_if_noret(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x04);
+    tcg_wasm_out8(s, 0x40);
+}
 
 static void tcg_wasm_out_op_if_ret_i64(TCGContext *s)
 {
@@ -1789,10 +1807,28 @@ static TCGConstraintSetIndex cset_addsubcarry(TCGType type, unsigned flags)
     return type == TCG_TYPE_REG ? C_O1_I2(r, r, r) : C_NotImplemented;
 }
 
+static void tcg_wasm_out_addco(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+    tcg_wasm_out_op_global_get_r(s, a0);
+    if (a0 == a1) {
+        tcg_wasm_out_op_global_get_r(s, a2);
+    } else {
+        tcg_wasm_out_op_global_get_r(s, a1);
+    }
+    tcg_wasm_out_op_i64_lt_u(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
+}
+
 static void tgen_addco(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_addco, a0, a1, a2);
+    tcg_wasm_out_addco(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_addco = {
@@ -1801,10 +1837,21 @@ static const TCGOutOpBinary outop_addco = {
     .out_rrr = tgen_addco,
 };
 
+static void tcg_wasm_out_addci(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_get(s, CARRY_IDX);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+}
+
 static void tgen_addci(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_addci, a0, a1, a2);
+    tcg_wasm_out_addci(s, a0, a1, a2);
 }
 
 static const TCGOutOpAddSubCarry outop_addci = {
@@ -1813,10 +1860,51 @@ static const TCGOutOpAddSubCarry outop_addci = {
     .out_rrr = tgen_addci,
 };
 
+static void tcg_wasm_out_addcio(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_wasm_out_op_global_get(s, CARRY_IDX);
+    tcg_wasm_out_op_if_noret(s);
+
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+    tcg_wasm_out_op_global_get_r(s, a0);
+    if (a0 == a1) {
+        tcg_wasm_out_op_global_get_r(s, a2);
+    } else {
+        tcg_wasm_out_op_global_get_r(s, a1);
+    }
+    tcg_wasm_out_op_i64_le_u(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
+
+    tcg_wasm_out_op_else(s);
+
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+    tcg_wasm_out_op_global_get_r(s, a0);
+    if (a0 == a1) {
+        tcg_wasm_out_op_global_get_r(s, a2);
+    } else {
+        tcg_wasm_out_op_global_get_r(s, a1);
+    }
+    tcg_wasm_out_op_i64_lt_u(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
+
+    tcg_wasm_out_op_end(s);
+}
+
 static void tgen_addcio(TCGContext *s, TCGType type,
                         TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_addcio, a0, a1, a2);
+    tcg_wasm_out_addcio(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_addcio = {
@@ -1828,6 +1916,8 @@ static const TCGOutOpBinary outop_addcio = {
 static void tcg_out_set_carry(TCGContext *s)
 {
     tcg_out_op_v(s, INDEX_op_tci_setcarry);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -2182,10 +2272,25 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tcg_wasm_out_subbo(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_lt_u(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
+
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+}
+
 static void tgen_subbo(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_subbo, a0, a1, a2);
+    tcg_wasm_out_subbo(s, a0, a1, a2);
 }
 
 static const TCGOutOpAddSubCarry outop_subbo = {
@@ -2194,10 +2299,21 @@ static const TCGOutOpAddSubCarry outop_subbo = {
     .out_rrr = tgen_subbo,
 };
 
+static void tcg_wasm_out_subbi(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_global_get(s, CARRY_IDX);
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+}
+
 static void tgen_subbi(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_subbi, a0, a1, a2);
+    tcg_wasm_out_subbi(s, a0, a1, a2);
 }
 
 static const TCGOutOpAddSubCarry outop_subbi = {
@@ -2206,10 +2322,43 @@ static const TCGOutOpAddSubCarry outop_subbi = {
     .out_rrr = tgen_subbi,
 };
 
+static void tcg_wasm_out_subbio(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_wasm_out_op_global_get(s, CARRY_IDX);
+    tcg_wasm_out_op_if_noret(s);
+
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_le_u(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+
+    tcg_wasm_out_op_else(s);
+
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_lt_u(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_global_get_r(s, a2);
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+
+    tcg_wasm_out_op_end(s);
+}
+
 static void tgen_subbio(TCGContext *s, TCGType type,
                         TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_subbio, a0, a1, a2);
+    tcg_wasm_out_subbio(s, a0, a1, a2);
 }
 
 static const TCGOutOpAddSubCarry outop_subbio = {
@@ -2221,6 +2370,8 @@ static const TCGOutOpAddSubCarry outop_subbio = {
 static void tcg_out_set_borrow(TCGContext *s)
 {
     tcg_out_op_v(s, INDEX_op_tci_setcarry);  /* borrow == carry */
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_global_set(s, CARRY_IDX);
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


