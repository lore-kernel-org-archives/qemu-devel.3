Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00461C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMTb-0001Fb-Pu; Tue, 20 May 2025 08:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTN-00013p-NM; Tue, 20 May 2025 08:53:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTI-0000pV-3c; Tue, 20 May 2025 08:53:31 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-742c5eb7d1cso3484264b3a.3; 
 Tue, 20 May 2025 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745603; x=1748350403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrYdTbrh0HLfQlm+zOWduDlR9Q8yHBtmdY6iR829V3U=;
 b=GWRoDjxrciK3o5xWpiLhtYMT1DOx32/pLIQZEHUjx7+LuNFNEqw1dGpRZFAedlbqzx
 YA4B7YAQsZZ4Y2M2OsqaUOhWyRk+mN4eUrmcC6JRyZIZwwxxBmWJ7xzDdlaxdqFa4NnQ
 6VpNXMm+WTE2oH++tAkeOEVdPoYF3sx3Fd9xt75dtJI4jw7bnjU8FOqvEZX9UtXxlvnO
 +W2J6LQthmnNJIjSuxuUeYnh3nl1/NyyLy065YRK0eA/sPSiE3H2lS3yN7l6GUA19exT
 0R4QgD5KbAuQKrzWlE3Q0fqYKaZW3VA54hHGw8vyCdIkTLdvUKmyiNK/MEN0k4GiEXK+
 qUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745603; x=1748350403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrYdTbrh0HLfQlm+zOWduDlR9Q8yHBtmdY6iR829V3U=;
 b=gCxYJ6STR3NnNG2fwo9CF6I+Ti33+rmYXGKN/qbfT2QcB91iq0kh/XfvLHu8oou0G5
 LkmOi6walaZ2xzlLo2v9S6yGZXW59TTu12HnGwXBJ+shQKk6IAvCH2Yfac0tBHEkfJ7h
 4dDZDxwzVEKoW800ZDSfiyznrKgXUW8xM8WbeJ8t9TzgDQNuCOuPZ1N38T+UJ6/zbcgc
 /IBu3Q0utW33SyexgbN5BGOa4guL4zMkqQrXQhveINGMCIYvQln60fK8W68/gfI8XZFV
 BgA7ZIGBRaq2dAZdlCo5zCEmJDTZqlPwUJnJa+lYw1KQxMnHZiUg7OpABqykR15Pe0CX
 JvoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIlka4tbEuM443LHZnNB9BlqDXOC1KBkZg1NGxlziFaATfwlZmm4W7x47qvxa35GzVFC4uF0xwviTqlA==@nongnu.org,
 AJvYcCXEo4+YY5ONosEXgXHlaLA9Ug7WbULN281Z1baoE6DsWyh0edbcdDT/sh37kALC2WLQYydyOdIZSw==@nongnu.org
X-Gm-Message-State: AOJu0Yzezqz2p8x47rsnaLDXovIeZQl0YoDPIgIm2fnGYkhnsVvM/F9p
 xk8dAkC9eAwFvoKEFd8wxboeQ2wXjELIbd9n6ThrgOUZ8tdyOukQMfvFXZiHy+OP
X-Gm-Gg: ASbGnct66awqvXM9Oo4kMPvdv4V/UlMhb9x6al06Ckts1bXAMMWjf4nmdDUfIvgqsdh
 ipDJgwaHUK4AXKGkwSN8X8y55h1pUIk7jKKKD7WViHox26ZEjVYWykwptMa3bOYs/LLZDLHr4ki
 /BWqSYnY29vbfhQy1FEfca/cVpPExd8k3cpidxukUVn1FNFY4fNUU3x8KyFlnO3XwiL5RpQHywf
 kG9Mlb3Gh/pZbp4R58FLtbRcHtwPet8Z7RFNcIPEj0qB6hC5EaDcqk+l6T6mOZHzWgAMV/2Bj4E
 XLbxVJcnjkt+2DFvLYVXsoUfh/ItVEmV3FeEL5uCRThFPtIuju0mHK1dE3mTYw==
X-Google-Smtp-Source: AGHT+IHSVeSZrqI1p+LKyaXlkp/QemBYcHu0gGDpX+Iuujio4I5h58FLti/L/Smc9nkP49kM+CaNOw==
X-Received: by 2002:a17:90b:4a50:b0:301:98fc:9b5a with SMTP id
 98e67ed59e1d1-30e7d500953mr24868929a91.6.1747745603425; 
 Tue, 20 May 2025 05:53:23 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:22 -0700 (PDT)
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
Subject: [PATCH 12/33] tcg/wasm32: Add ext instructions
Date: Tue, 20 May 2025 21:51:14 +0900
Message-ID: <6c4e1684c2c1207c01ceff9168cf3031707040c6.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x436.google.com
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

This commit implements the ext operations using Wasm's extend instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 79 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 90a5705442..dff79a9854 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -231,7 +231,14 @@ static void tcg_wasm_out_op_i64_extend_i32_u(TCGContext *s)
 {
     tcg_wasm_out8(s, 0xad);
 }
-
+static void tcg_wasm_out_op_i64_extend8_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xc2);
+}
+static void tcg_wasm_out_op_i64_extend16_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xc3);
+}
 static void tcg_wasm_out_op_i32_add(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x6a);
@@ -631,6 +638,60 @@ static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
     tcg_wasm_out_op_global_set_r(s, dest);
 }
 
+static void tcg_wasm_out_ext8s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_extend8_s(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext16s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_extend16_s(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
 static void tcg_wasm_out_ld(
     TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
 {
@@ -1126,33 +1187,39 @@ static const TCGOutOpExtract2 outop_extract2 = {
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_sextract(s, type, rd, rs, 0, 8);
+    tcg_wasm_out_ext8s(s, rd, rs);
 }
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
+    tcg_wasm_out_ext8u(s, rd, rs);
 }
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_sextract(s, type, rd, rs, 0, 16);
+    tcg_wasm_out_ext16s(s, rd, rs);
 }
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
+    tcg_wasm_out_ext16u(s, rd, rs);
 }
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_tci_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_wasm_out_ext32s(s, rd, rs);
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_tci_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_wasm_out_ext32u(s, rd, rs);
 }
 
 static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
@@ -1169,6 +1236,7 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_tci_out_mov(s, TCG_TYPE_I32, rd, rs);
+    tcg_wasm_out_extrl_i64_i32(s, rd, rs);
 }
 
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
@@ -1396,9 +1464,18 @@ static const TCGOutOpBinary outop_eqv = {
 };
 
 #if TCG_TARGET_REG_BITS == 64
+static void tcg_wasm_out_extrh_i64_i32(TCGContext *s, TCGReg a0, TCGReg a1)
+{
+    tcg_wasm_out_op_global_get_r(s, a1);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_global_set_r(s, a0);
+}
+
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
     tcg_tci_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
+    tcg_wasm_out_extrh_i64_i32(s, a0, a1);
 }
 
 static const TCGOutOpUnary outop_extrh_i64_i32 = {
-- 
2.43.0


