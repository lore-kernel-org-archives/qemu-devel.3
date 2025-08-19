Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF6DCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0B-00063a-4y; Tue, 19 Aug 2025 14:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR06-0005t6-0E; Tue, 19 Aug 2025 14:24:02 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzz-0003tR-Sd; Tue, 19 Aug 2025 14:23:59 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b472fd93ad1so2786552a12.0; 
 Tue, 19 Aug 2025 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627834; x=1756232634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykVIUD/HZ1RbVXRktPCz8rfsNfoXb77ATTdPNzikBa8=;
 b=IA22oqJclGqQLSShC9aJmXgacH45BuWcgzegj8dcQvtp7cXu7bbao2dJ/XjSx1RpFd
 M5W3lDTyg7ciHZNtP6tIoNlBpTNBPgWL2xpSgtrrQI01HhMAij0+GGBmezj+lInZgb6d
 8MEFNSK1LFAs3PkucAHwm5JRbCVhYehPZwloDZf/4B5l156VwDssekViowz8hMY8GyIU
 JlKedutv9jDhvIFjQvc0Tyc6/I7RAoq71sbhYTmSzIZDke8v+nfXbqiA7Jx0+lUCzs2m
 c1pkOawlG+GTgJSXZ0fl9H81DUFjTWMEY725ESlUBJ7iKijTHC3r5B8X+MWb5uJMTSWM
 6MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627834; x=1756232634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykVIUD/HZ1RbVXRktPCz8rfsNfoXb77ATTdPNzikBa8=;
 b=wuWJ+KI3wtYxzx+juqDfajcdkq2SeFMU2fU+ft4YaIG3E85V0SytIQk0enlz+gKtNU
 2SFS/9i7eivUEDh8zfxLPWF0AMg6lpKRMt3vvHX2Ri9z90/atOKRsR0JFtjWbmqRf9op
 q0aTK2OwHYywZvZGZENS6comnS7cbEWLAWpaKoS4BRy3Ks2DpZa9hyDBWaJE6N7/tE/0
 KqJ5VK/iXkMAi5D2S1xJpIWZz9FHmGnwTgF2G9gpo6q7xDPGvAeI4AqlhvlGZPIKInhM
 G3KumZgyDQjgaQ62iKGnK89mvD4TySJXyK4pypNC4hSTUvDDHoC8zyjFXG1o4h19Nrql
 Jjog==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5np4G2/I8i/QmqXjcVyvzYw54KNZw6liLVkEZT6R5Q867ATvzpRqViA1cv1Cai+uln7HHlALHxw==@nongnu.org,
 AJvYcCWgHNrz9kcqTeRbUVR2tx5UW/4+4aHA+nDHige1uCK8XUkenpm8kMLJDbzYCNg9o7iULRq/8b7KP+2QXw==@nongnu.org
X-Gm-Message-State: AOJu0YzklNurooTLUQSDqVCndHNvWf+ZrJAOPNRhcrExWt5FaTpZ8Yp0
 qLwrf5kvsQpDIic18LcPE0RBmhtJUE9d8xOrzAuYA/YJmSotJApghUSozWLHqRUq
X-Gm-Gg: ASbGncuO/ACHAmqyBygoICXWwSG1B0fDJdjLx+XPOA7TAmp0IyxAELp9UvqoCCvJkvQ
 vETf9xevu/K/uGeUdqbmvfpCkJRRTdK14wljyDONl8oufstoI/dI5Q8ekjWi9lY+nzF6e71UGSM
 6RmMpioqasGCoeox5I5vZXHrHMziR5AsGEhmpxFo98xDbaOXmHEP+c5sfIaiZaLBJmxrxdK8h3+
 oNFZmg/fIeEr4CI9mWC3ATqhbRdf+yBR/es6weQH5ZJZkKtJXen8+YC8mYEIS3tBeC0Z6Gj7joc
 Rlqcpj6ws2RBA7sGnhRld+bHYRvFHCULWKDYENS8DdTJ/x9g2okuezDxerCowQ6Aq99b/k1vgIy
 gfi4/9323haDwGU+rKTkhZt/ytHOULQJQ
X-Google-Smtp-Source: AGHT+IHkTJyh71TMZ1dvRbUUt9zt76fSqMzH69SwvpGbK7QiB0lli5yfz5jrR66mr0P/DcV+1N8Zaw==
X-Received: by 2002:a17:902:e783:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-245e0307a8fmr46014385ad.13.1755627833675; 
 Tue, 19 Aug 2025 11:23:53 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:53 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 14/35] tcg/wasm: Add deposit/sextract/extract instrcutions
Date: Wed, 20 Aug 2025 03:21:43 +0900
Message-ID: <c59e13b025fd8a631463ce6033c50b02d3906b38.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x533.google.com
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

The tcg_out_extract and tcg_out_sextract functions were used by several
other functions (e.g. tcg_out_ext*) and intended to emit TCI code. So they
have been renamed to tcg_tci_out_extract and tcg_tci_out_sextract.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 104 +++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 13 deletions(-)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 03cb3b2f46..6220b43f98 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -163,7 +163,10 @@ typedef enum {
     OPC_I64_SHR_U = 0x88,
 
     OPC_I32_WRAP_I64 = 0xa7,
+    OPC_I64_EXTEND_I32_S = 0xac,
     OPC_I64_EXTEND_I32_U = 0xad,
+    OPC_I64_EXTEND8_S = 0xc2,
+    OPC_I64_EXTEND16_S = 0xc3,
 } WasmInsn;
 
 typedef enum {
@@ -380,6 +383,66 @@ static void tcg_wasm_out_movcond(TCGContext *s, TCGType type, TCGReg ret,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_deposit(TCGContext *s,
+                                 TCGReg dest, TCGReg arg1, TCGReg arg2,
+                                 int pos, int len)
+{
+    int64_t mask = (((int64_t)1 << len) - 1) << pos;
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, ~mask);
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
+    tcg_wasm_out_op(s, OPC_I64_SHL);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op(s, OPC_I64_OR);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
+static void tcg_wasm_out_extract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                 int pos, int len)
+{
+    int64_t mask = ~0ULL >> (64 - len);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    if (pos > 0) {
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
+        tcg_wasm_out_op(s, OPC_I64_SHR_U);
+    }
+    if ((pos + len) < 64) {
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
+        tcg_wasm_out_op(s, OPC_I64_AND);
+    }
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
+static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                  int pos, int len)
+{
+    int discard = 64 - len;
+    int high = discard - pos;
+
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+
+    if ((pos == 0) && (len == 8)) {
+        tcg_wasm_out_op(s, OPC_I64_EXTEND8_S);
+    } else if ((pos == 0) && (len == 16)) {
+        tcg_wasm_out_op(s, OPC_I64_EXTEND16_S);
+    } else if ((pos == 0) && (len == 32)) {
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);
+    } else {
+        if (high > 0) {
+            tcg_wasm_out_op_const(s, OPC_I64_CONST, high);
+            tcg_wasm_out_op(s, OPC_I64_SHL);
+        }
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, discard);
+        tcg_wasm_out_op(s, OPC_I64_SHR_S);
+    }
+
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -591,6 +654,12 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
+static void tcg_tci_out_extract(TCGContext *s, TCGType type, TCGReg rd,
+                                TCGReg rs, unsigned pos, unsigned len)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, pos, len);
+}
+
 static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
                          TCGReg base, intptr_t offset)
 {
@@ -651,7 +720,8 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
                             TCGReg rs, unsigned pos, unsigned len)
 {
-    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, pos, len);
+    tcg_tci_out_extract(s, type, rd, rs, pos, len);
+    tcg_wasm_out_extract(s, rd, rs, pos, len);
 }
 
 static const TCGOutOpExtract outop_extract = {
@@ -659,10 +729,17 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tcg_out_extract,
 };
 
+static void tcg_tci_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
+                                 TCGReg rs, unsigned pos, unsigned len)
+{
+    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
+}
+
 static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
                              TCGReg rs, unsigned pos, unsigned len)
 {
-    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
+    tcg_tci_out_sextract(s, type, rd, rs, pos, len);
+    tcg_wasm_out_sextract(s, rd, rs, pos, len);
 }
 
 static const TCGOutOpExtract outop_sextract = {
@@ -676,34 +753,34 @@ static const TCGOutOpExtract2 outop_extract2 = {
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_out_sextract(s, type, rd, rs, 0, 8);
+    tcg_tci_out_sextract(s, type, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
+    tcg_tci_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_out_sextract(s, type, rd, rs, 0, 16);
+    tcg_tci_out_sextract(s, type, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
+    tcg_tci_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_tci_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_tci_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
 static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
@@ -891,6 +968,7 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
     tcg_out_op_rrrbb(s, INDEX_op_deposit, a0, a1, a2, ofs, len);
+    tcg_wasm_out_deposit(s, a0, a1, a2, ofs, len);
 }
 
 static const TCGOutOpDeposit outop_deposit = {
@@ -948,7 +1026,7 @@ static const TCGOutOpBinary outop_eqv = {
 #if TCG_TARGET_REG_BITS == 64
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
-    tcg_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
+    tcg_tci_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
 }
 
 static const TCGOutOpUnary outop_extrh_i64_i32 = {
@@ -1112,7 +1190,7 @@ static void tgen_sar(TCGContext *s, TCGType type,
 {
     TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
-        tcg_out_ext32s(s, TCG_REG_TMP, a1);
+        tcg_tci_out_sextract(s, TCG_TYPE_I64, TCG_REG_TMP, a1, 0, 32);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
@@ -1142,7 +1220,7 @@ static void tgen_shr(TCGContext *s, TCGType type,
 {
     TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
-        tcg_out_ext32u(s, TCG_REG_TMP, a1);
+        tcg_tci_out_extract(s, TCG_TYPE_I64, TCG_REG_TMP, a1, 0, 32);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
@@ -1241,7 +1319,7 @@ static void tgen_bswap16(TCGContext *s, TCGType type,
 {
     tcg_out_op_rr(s, INDEX_op_bswap16, a0, a1);
     if (flags & TCG_BSWAP_OS) {
-        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
+        tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
     }
 }
 
@@ -1255,7 +1333,7 @@ static void tgen_bswap32(TCGContext *s, TCGType type,
 {
     tcg_out_op_rr(s, INDEX_op_bswap32, a0, a1);
     if (flags & TCG_BSWAP_OS) {
-        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
+        tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
     }
 }
 
-- 
2.43.0


