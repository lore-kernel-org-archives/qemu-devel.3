Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF809C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMSw-0000rv-BH; Tue, 20 May 2025 08:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSu-0000rI-9a; Tue, 20 May 2025 08:53:04 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSp-0000ln-Kq; Tue, 20 May 2025 08:53:04 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30572effb26so5232744a91.0; 
 Tue, 20 May 2025 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745575; x=1748350375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bns4HZO2Nb4MGLYLQJB6/ZEKS2CSFb3ypYim5fOiTl8=;
 b=ToMGXGQUo7ViGnuieqa5JEDvfIfhbpXOf/PdQGbgypCyFHEeVG2zc7yvm6OxvIimKD
 6DUDbUrHXovfZxYNeRZmWdBdylx1isq747DRHFLwcgEj4gEzT40H2cb4Vjzqh83XpyEn
 gcydvQV6nNaQ+kwduPZDhSriR3hf16atl0RCYYADHjlNso4cKVaFfZoi+UVd0PmTL1gl
 SQIF4sHoN9tw9XxTuWL9S+uNoU7RFgDV6ae6LP9Mk9gBnxSZiDU3irgWWtuHGHCjVCtJ
 uGp2cWdl+Ca9eKZ10hF5989EjMX8zGsTX65YM+bznTQLYKVkoRt4nz7/kTcf7ITBAnoS
 LMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745575; x=1748350375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bns4HZO2Nb4MGLYLQJB6/ZEKS2CSFb3ypYim5fOiTl8=;
 b=opE/+IVOllyCN5evqs3aKHb7VyLFhah00LyxZ2gyOqW08S2z3fb0QpsrfFseFb8GhG
 8Sn2nM9mz0mepOT2CPSNz8k7D85DQ2D4iI1b9Y8NOwqjx361WM1jJpl2iVcPj1d24tqg
 W/ewaXbGXtu1hdUxadvATZMQbGFBxw7eqKvpVWxywUFWnYo9HAYkriF5OKoQ9k6Qnh+R
 V3MLGc+/ZtJ15FxJOjUzmcLVGRCVUIhgPSl24XDM0UZba3oinNtlXrza7aX8sMG+ci4w
 uFGa+BZGdbWCLbjlTURQkv+nbDM3dFfbLxeZqDriqlisre5ioZOYDzDrhigylszEoWFa
 SLLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7TISJ/Xuwr4EJ78TcsahpyT52tSpCsYtw8uoPmAAmoveDBCvPSS/Nu1j39yt91dirneG8H+SjWG3Utw==@nongnu.org,
 AJvYcCXhiZUrmjcPc08tUWnWmbAILlxSHWIpOwmNtT6ThoHy9G3EMTTlWhJZSZWlfM2Sb6nTem/ZmhpZUg==@nongnu.org
X-Gm-Message-State: AOJu0YxCHLHwbTXw6odBm47aNKZHqdbiBSRA5eGxSPS84exn1UwDh2Zq
 6QczKDaRs0zz/XuFKXv2nCXDmvrm1aeL7M+IAnm/Ybx1z/bfhTXQfG4DvUg+JJ0+
X-Gm-Gg: ASbGncug4xssH/1gfPV91/guAR8m/+snvjmyyBQAMf/xemF5EO6Iws3MHAI8x+IlRQ8
 hVXPzwWGxOnx8MZdlXCe3EGghZp1Cmk7ktUCPh2EpnIyK5+/Dx+562t6hEVhHWt/g8pmFEmJcT9
 JcI7eesdQf4yAH9ejSJJiqmnjZTkzi1vNJw8Gntlg8olMLC/ujApxWgfcWCP+pEctEDa7ZM+AIb
 JI78JUd0YXJQdn18E4u5NrW5XOjFrf/Uol0zA5XGRwVFm9zD8k5AtjPQW8GAthFxdCpLjS4B+vU
 GjqnAgO4ExMPRuJF/1NLIim7dxiIJsTddgSG7HSnzxMCBuU8JoufnYz+rLPV7Q==
X-Google-Smtp-Source: AGHT+IGlDhFteL3xifkGxWzP+tChzeTDjC8nEVDX/xHHzS8M7A6BHOyu+hh3zK9skEJFg3yaRl/GPA==
X-Received: by 2002:a17:90b:33c2:b0:30e:6a9d:d787 with SMTP id
 98e67ed59e1d1-30e7d50b04bmr28998390a91.11.1747745575202; 
 Tue, 20 May 2025 05:52:55 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:52:54 -0700 (PDT)
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
Subject: [PATCH 07/33] tcg/wasm32: Add shl/shr/sar instructions
Date: Tue, 20 May 2025 21:51:09 +0900
Message-ID: <1451b4a4c7547f4077709557f07f3002cfc3d889.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102c.google.com
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

This commit implements shl, shr and sar operations using Wasm
instructions. The Wasm backend uses 64bit variables so the right shift
operation for 32bit values needs to extract the lower 32bit of the operand
before shifting. Additionally, since constant values must be encoded in
LEB128 format, this commit introduces an encoder function implemented
following [1].

[1] https://en.wikipedia.org/wiki/LEB128

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index e4204d3956..b9f2c9c195 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -207,6 +207,26 @@ static void tcg_wasm_out_op_i64_mul(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x7e);
 }
+static void tcg_wasm_out_op_i64_shl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x86);
+}
+static void tcg_wasm_out_op_i64_shr_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x87);
+}
+static void tcg_wasm_out_op_i64_shr_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x88);
+}
+static void tcg_wasm_out_op_i32_wrap_i64(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xa7);
+}
+static void tcg_wasm_out_op_i64_extend_i32_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xac);
+}
 static void tcg_wasm_out_op_var(TCGContext *s, uint8_t instr, uint8_t i)
 {
     tcg_wasm_out8(s, instr);
@@ -245,6 +265,88 @@ tcg_wasm_out_i64_calc(add);
 tcg_wasm_out_i64_calc(sub);
 tcg_wasm_out_i64_calc(mul);
 
+static void tcg_wasm_out_leb128_sint64_t(TCGContext *s, int64_t v)
+{
+    bool more = true;
+    uint8_t b;
+    while (more) {
+        b = v & 0x7f;
+        v >>= 7;
+        if (((v == 0) && ((b & 0x40) == 0)) ||
+            ((v == -1) && ((b & 0x40) != 0))) {
+            more = false;
+        } else {
+            b |= 0x80;
+        }
+        tcg_wasm_out8(s, b);
+    }
+}
+
+static void tcg_wasm_out_op_i64_const(TCGContext *s, int64_t v)
+{
+    tcg_wasm_out8(s, 0x42);
+    tcg_wasm_out_leb128_sint64_t(s, v);
+}
+
+static void tcg_wasm_out_shl(TCGContext *s, TCGReg ret,
+                             TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_shl(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_shr_u(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 0x7f);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_shr_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_shr_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_shr_s(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 0x7f);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_shr_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_shr_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -975,11 +1077,13 @@ static const TCGOutOpBinary outop_rotr = {
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
+    TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
         tcg_out_ext32s(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
+    tcg_wasm_out_shr_s(s, type, a0, orig_a1, a2);
 }
 
 static const TCGOutOpBinary outop_sar = {
@@ -991,6 +1095,7 @@ static void tgen_shl(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_shl, a0, a1, a2);
+    tcg_wasm_out_shl(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_shl = {
@@ -1001,11 +1106,13 @@ static const TCGOutOpBinary outop_shl = {
 static void tgen_shr(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
+    TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
         tcg_out_ext32u(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
+    tcg_wasm_out_shr_u(s, type, a0, orig_a1, a2);
 }
 
 static const TCGOutOpBinary outop_shr = {
-- 
2.43.0


