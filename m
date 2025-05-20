Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41ECC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMT0-0000tX-Sz; Tue, 20 May 2025 08:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSw-0000rq-Ty; Tue, 20 May 2025 08:53:07 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSt-0000mW-IV; Tue, 20 May 2025 08:53:05 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30eb1c68386so2425242a91.2; 
 Tue, 20 May 2025 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745581; x=1748350381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CN+y9XhejQ1H6My7no7RtPqzXKOX9HgjCuOWMfl1Tw8=;
 b=WEv+PzUkDdtguGtsk1Gv1bjqXEfc4gPVptBS/PiGNDWZisSOaRORcD6QYiphteNCVq
 ohTkzdhafyKuRAg45w4ltajvLkYcnys3TgPwXVv2KitDi8+KMt7meAilPgGTxLsHfLFJ
 th3K62fW9xfph4DGRomZmrxDh3zZ3RWOe30HSnHj0I1JyERYfcDwwqEhyiR9NLeqPn6A
 L8GQJ1lj5uI684INjkk/ayNgRV3oEU3qBo98dNoxqBXZbBXikou18USpZrD96z7R7KPi
 tPgHlwtB6yMdDnHvCnb7zzauGmk1VLpB4AI4MVMrEYAL8Fw2ekWe92ftxjPZN/oVQaKS
 0OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745581; x=1748350381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CN+y9XhejQ1H6My7no7RtPqzXKOX9HgjCuOWMfl1Tw8=;
 b=CTwSGZ7ErK1/CUFf2eqtnypBFzO7KqUHUgQNDuyXy4Mftjdk8+v4M2ihWF8vqNHRA7
 xpZb+kI3FnoSENSc+B7BZEL/4ckO46MW0XpWai4uuOLP0dHRwmsUa/OvgYRizBrJJvPc
 6Q+duVeJpeyXRpmZKp17l0x48Ja914C1blmCrKX9wGtTdQd62+ZuyVreYSr3eNoN/4Ai
 9skvc/GRVCgpo0siRrG/im/aySevvbCmkXls7JY1/N0lsD/Jah9K2TTogWYEFeNG6tvj
 Im/ScBhKDWc7S1BbXB5JJhSG4GBrn/KbU2DSXWfRa6i7g0atEaAsVB4NYGtJFZml/6SH
 ASBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCkCAUliC0WWwZyTCNxyFGR4vGrc7pfCfxQUyKnNrCWPcugGPTQXr9QlLRmw7AfroWLu7O+WjIAw==@nongnu.org,
 AJvYcCXRkmNKhctT+pOiuTgnxgB7yYv8csdXLqEbIimCNP1LDJq0VjfSHKIUtuW+h3/mgzQhVCmtd/310jbptg==@nongnu.org
X-Gm-Message-State: AOJu0YzrxHb4GAd79Bp9MuaWu23GIzALjpsPuBH9c4zUdgfRCS6UZcRM
 l6v4m87C7gm5FSd6sFeT4bN/fdu45+KUvfT2Ia1UNhuOEApbxwmNTqY+eb6wZI8p
X-Gm-Gg: ASbGncsqwxQSLckwofN7a7p2cn9z8O/3nDEADn54E36VP4KyZyNhjckAA8U6yUFipqf
 6ETEYrGBiTy7H4M4zK4JvbKZNx80/flA5z8PS++hAsXETx9gruT1Tl+yKuG2WfiimWCw4gWY619
 skrcLQ7IgKGSPpHcz5NptmDd0HulS7mYfvCtn89Ye00slHneAKMOZO8aLVYWGnLc6nWIyZJd+NE
 ieUqf0mopCvFuzWiYZXi//Wr3MGHCRGYZrPfFhVLA2AsGqg+LvdYmmwDAzl3DlH7VhDn4bbdnQf
 vIyFTCooVqRer9vQLQI5EAzUHxWlYGQYVupxFVzUHNvGVu2tuNNWSGGIXANgfQ==
X-Google-Smtp-Source: AGHT+IHs9HPY+pCVl4LDFEjCRpmaV5LycVby3DD8NvGSExZ1Rp4gMLYFjDp9u1xumNLIdKrLoH5AZA==
X-Received: by 2002:a17:90a:d604:b0:30a:9316:75a2 with SMTP id
 98e67ed59e1d1-30e7d52adcfmr27622113a91.10.1747745580944; 
 Tue, 20 May 2025 05:53:00 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:00 -0700 (PDT)
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
Subject: [PATCH 08/33] tcg/wasm32: Add setcond/negsetcond/movcond instructions
Date: Tue, 20 May 2025 21:51:10 +0900
Message-ID: <9381168a9d8ea609cba8461a242320c374e2487f.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102f.google.com
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

This commit implements setcond and movcond operations using Wasm's if/else
instructions. Support for TCG_COND_TSTEQ and TCG_COND_TSTNE is not yet
implemented, so TCG_TARGET_HAS_tst is set to 0.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target-has.h |   2 +-
 tcg/wasm32/tcg-target.c.inc | 136 ++++++++++++++++++++++++++++++++++--
 2 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/tcg/wasm32/tcg-target-has.h b/tcg/wasm32/tcg-target-has.h
index ab07ce1fcb..1eaa8f65f6 100644
--- a/tcg/wasm32/tcg-target-has.h
+++ b/tcg/wasm32/tcg-target-has.h
@@ -13,7 +13,7 @@
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              1
+#define TCG_TARGET_HAS_tst              0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index b9f2c9c195..b1ed16ad7a 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -227,6 +227,23 @@ static void tcg_wasm_out_op_i64_extend_i32_s(TCGContext *s)
 {
     tcg_wasm_out8(s, 0xac);
 }
+static void tcg_wasm_out_op_i64_extend_i32_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xad);
+}
+static void tcg_wasm_out_op_if_ret_i64(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x04);
+    tcg_wasm_out8(s, 0x7e);
+}
+static void tcg_wasm_out_op_else(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x05);
+}
+static void tcg_wasm_out_op_end(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x0b);
+}
 static void tcg_wasm_out_op_var(TCGContext *s, uint8_t instr, uint8_t i)
 {
     tcg_wasm_out8(s, instr);
@@ -265,6 +282,42 @@ tcg_wasm_out_i64_calc(add);
 tcg_wasm_out_i64_calc(sub);
 tcg_wasm_out_i64_calc(mul);
 
+static const struct {
+    uint8_t i32;
+    uint8_t i64;
+} tcg_cond_to_inst[] = {
+    [TCG_COND_EQ] =  { 0x46 /* i32.eq */   , 0x51 /* i64.eq */},
+    [TCG_COND_NE] =  { 0x47 /* i32.ne */   , 0x52 /* i64.ne */},
+    [TCG_COND_LT] =  { 0x48 /* i32.lt_s */ , 0x53 /* i64.lt_s */},
+    [TCG_COND_GE] =  { 0x4e /* i32.ge_s */ , 0x59 /* i64.ge_s */},
+    [TCG_COND_LE] =  { 0x4c /* i32.le_s */ , 0x57 /* i64.le_s */},
+    [TCG_COND_GT] =  { 0x4a /* i32.gt_s */ , 0x55 /* i64.gt_s */},
+    [TCG_COND_LTU] = { 0x49 /* i32.lt_u */ , 0x54 /* i64.lt_u */},
+    [TCG_COND_GEU] = { 0x4f /* i32.ge_u */ , 0x5a /* i64.ge_u */},
+    [TCG_COND_LEU] = { 0x4d /* i32.le_u */ , 0x58 /* i64.le_u */},
+    [TCG_COND_GTU] = { 0x4b /* i32.gt_u */ , 0x56 /* i64.gt_u */}
+};
+
+static void tcg_wasm_out_op_cond_i64(
+    TCGContext *s, TCGCond cond, TCGReg arg1, TCGReg arg2)
+{
+    uint8_t op = tcg_cond_to_inst[cond].i64;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out8(s, op);
+}
+
+static void tcg_wasm_out_op_cond_i32(
+    TCGContext *s, TCGCond cond, TCGReg arg1, TCGReg arg2)
+{
+    uint8_t op = tcg_cond_to_inst[cond].i32;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out8(s, op);
+}
+
 static void tcg_wasm_out_leb128_sint64_t(TCGContext *s, int64_t v)
 {
     bool more = true;
@@ -288,6 +341,12 @@ static void tcg_wasm_out_op_i64_const(TCGContext *s, int64_t v)
     tcg_wasm_out_leb128_sint64_t(s, v);
 }
 
+static void tcg_wasm_out_op_not(TCGContext *s)
+{
+    tcg_wasm_out_op_i64_const(s, -1);
+    tcg_wasm_out_op_i64_xor(s);
+}
+
 static void tcg_wasm_out_shl(TCGContext *s, TCGReg ret,
                              TCGReg arg1, TCGReg arg2)
 {
@@ -347,6 +406,66 @@ static void tcg_wasm_out_shr_s(
     }
 }
 
+static void tcg_wasm_out_setcond(TCGContext *s, TCGType type, TCGReg ret,
+                                 TCGReg arg1, TCGReg arg2, TCGCond cond)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_cond_i32(s, cond, arg1, arg2);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_cond_i64(s, cond, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_negsetcond(TCGContext *s, TCGType type, TCGReg ret,
+                                    TCGReg arg1, TCGReg arg2, TCGCond cond)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_cond_i32(s, cond, arg1, arg2);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_cond_i64(s, cond, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_movcond(TCGContext *s, TCGType type, TCGReg ret,
+                                 TCGReg c1, TCGReg c2,
+                                 TCGReg v1, TCGReg v2,
+                                 TCGCond cond)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_cond_i32(s, cond, c1, c2);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_cond_i64(s, cond, c1, c2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_op_if_ret_i64(s);
+    tcg_wasm_out_op_global_get_r(s, v1);
+    tcg_wasm_out_op_else(s);
+    tcg_wasm_out_op_global_get_r(s, v2);
+    tcg_wasm_out_op_end(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1261,8 +1380,8 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
-static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
-                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+static void tgen_setcond_tci(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, TCGReg arg2)
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_setcond32
@@ -1270,6 +1389,13 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     tcg_out_op_rrrc(s, opc, dest, arg1, arg2, cond);
 }
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
+    tcg_wasm_out_setcond(s, type, dest, arg1, arg2, cond);
+}
+
 static const TCGOutOpSetcond outop_setcond = {
     .base.static_constraint = C_O1_I2(r, r, r),
     .out_rrr = tgen_setcond,
@@ -1278,8 +1404,9 @@ static const TCGOutOpSetcond outop_setcond = {
 static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGReg dest, TCGReg arg1, TCGReg arg2)
 {
-    tgen_setcond(s, type, cond, dest, arg1, arg2);
+    tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
     tgen_neg(s, type, dest, dest);
+    tcg_wasm_out_negsetcond(s, type, dest, arg1, arg2, cond);
 }
 
 static const TCGOutOpSetcond outop_negsetcond = {
@@ -1290,7 +1417,7 @@ static const TCGOutOpSetcond outop_negsetcond = {
 static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
                         TCGReg arg0, TCGReg arg1, TCGLabel *l)
 {
-    tgen_setcond(s, type, cond, TCG_REG_TMP, arg0, arg1);
+    tgen_setcond_tci(s, type, cond, TCG_REG_TMP, arg0, arg1);
     tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
 }
 
@@ -1307,6 +1434,7 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
                      ? INDEX_op_tci_movcond32
                      : INDEX_op_movcond);
     tcg_out_op_rrrrrc(s, opc, ret, c1, c2, vt, vf, cond);
+    tcg_wasm_out_movcond(s, type, ret, c1, c2, vt, vf, cond);
 }
 
 static const TCGOutOpMovcond outop_movcond = {
-- 
2.43.0


