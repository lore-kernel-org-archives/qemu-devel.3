Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0511DC54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMT5-0000vT-I7; Tue, 20 May 2025 08:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMT3-0000v9-Q1; Tue, 20 May 2025 08:53:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMT0-0000nT-JT; Tue, 20 May 2025 08:53:13 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so4408541a12.1; 
 Tue, 20 May 2025 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745587; x=1748350387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOF0U/wy86P4v/Jfdj/dCcLnbz7PDbEdix7I3iArBFY=;
 b=OqlzmJ/1Z6j2qq/wkatKi56wkp73813eiYEcfGvf9DL1r8mlQaXuEh+uOhYZsbGGji
 wvOP7Lm2RJGulHsxU9xCNxoNb9f7NF2oxGZcoXtmM0qd3dVD3CQBwCNJZ/HSMpHp6R10
 Lr9tXx+38cpDKgkqHbta4XkvmUG5cchcxTcvql1iXrfunJiUROSD6YBahh0Up/1DcB5/
 aycFdA/yMc52KMSo3SOOPLGOXScaGz7Kf9ijbXcAj3ySv2nBssAO8Tkpl+X7v65PpGjm
 4a5ciVZfydfDXBgv17PRH3WRc4KD53jg7OkTzcr/g8T/WGA9kc1WIv/YRtbOGVCQ3qFo
 3LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745587; x=1748350387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOF0U/wy86P4v/Jfdj/dCcLnbz7PDbEdix7I3iArBFY=;
 b=Rf8IzjahmQHByEGidYN68ZM/vbB8V9CtolgPhdRhtuxBysMonLdC8Nu3RTnRGiigpa
 76kSZldsRBq6pSJtGbla5ygdPj7KmhGWuZLPy6AAizd0sJe1XDM12EVsUzSeeTH2OQb2
 Uc6DPFGE1VHT4Nbx++No5f5Y+uKx+Ye737FySJSS5jAecMOWBBrHOKpGm8HH4/q52YpI
 NFMd2yrgsfQisVvfo5c5JaorTPDNifyGPD/o0/7WnUVeGPcdsdlUbE2YWwI3eco8jrmH
 nc4TatIm6V36JwxZIbElD+F6V3Q0bcZ6Jac8A7yud3CpWAbTBDKma2pVMWjYgp/8aHPS
 Epug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmyfOR7oFw38tN11y2VovewXhjDtv5W6NPdkOG7hSgF9MCXXo41NMPgvoCiL0WCZy68Z/HGDH63yOSXw==@nongnu.org,
 AJvYcCVcQ/oTazgJ/tFbEGGP8enuOKkopYZRDXw8bb5CEg0qD89jmEzpGY0zluRQyoEIPvd9V8BMFP1e7Q==@nongnu.org
X-Gm-Message-State: AOJu0Yyt6Ejl9gvVdkZBqNtovJ0lwsQf1vRC2BH8G0dGOLgFAoKa23pE
 KE6xMQ07WAeOLILz/y7hMAlhhfyJKq0ygYuxMjzbQPXwLNP/sI1knX+ISc5bJSzq
X-Gm-Gg: ASbGncty52Wsv9l4jw1dUbEWsu8k9Y1Is7xVaFMs5UhNhy0c7TU/Jg+gw9VY137N60P
 Y2CTIUV2F2THg658Gy22PM7eJYAUng49awp6zgpfvnAWsxTQ8dRPAgCWLbxjmUjRDacDSaY9zLg
 VQVWLl/oBIAnO7TCcSQRbj5jzAewQjOUx1mSlxVn+iyIOaoKhfD6bp0zaZWqRuwhHIjlfkFDNmb
 hqlbmrT4SyL3UO3fQCMm1Mp59NIXKZUjE6mXO+RLqw7LXyH72eLdaUMmVivvU1y6a4/XXPiTzBz
 vOWkdCC4+t3HVDf56y8XkoyXlK+f33W5gYnX6z5xga6x4Qq7mAE=
X-Google-Smtp-Source: AGHT+IF2IdPC31h39sXeDasbK/cNnL9bKcljFz/XsOKGHNbEKDiHJj1SNgrvTkhpjoGGDiOzqccXsQ==
X-Received: by 2002:a17:90b:570d:b0:309:fe2b:306f with SMTP id
 98e67ed59e1d1-30e7d5a8b14mr21480941a91.26.1747745586726; 
 Tue, 20 May 2025 05:53:06 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:06 -0700 (PDT)
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
Subject: [PATCH 09/33] tcg/wasm32: Add deposit/sextract/extract instrcutions
Date: Tue, 20 May 2025 21:51:11 +0900
Message-ID: <aa5ce80ac6e711f9bdcfc08b75842ad6f4ffcf80.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x532.google.com
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

This implements deposit, sextract and extract operations. The
tcg_out_[s]extract functions are used by several other functions
(e.g. tcg_out_ext*) and are intended to emit TCI code. So they have been
renamed to tcg_tci_out_[s]extract.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 122 ++++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 13 deletions(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index b1ed16ad7a..d732d2f3c0 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -231,6 +231,20 @@ static void tcg_wasm_out_op_i64_extend_i32_u(TCGContext *s)
 {
     tcg_wasm_out8(s, 0xad);
 }
+
+static void tcg_wasm_out_op_i32_and(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x71);
+}
+static void tcg_wasm_out_op_i32_or(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x72);
+}
+static void tcg_wasm_out_op_i32_shl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x74);
+}
+
 static void tcg_wasm_out_op_if_ret_i64(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x04);
@@ -318,6 +332,23 @@ static void tcg_wasm_out_op_cond_i32(
     tcg_wasm_out8(s, op);
 }
 
+static void tcg_wasm_out_leb128_sint32_t(TCGContext *s, int32_t v)
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
 static void tcg_wasm_out_leb128_sint64_t(TCGContext *s, int64_t v)
 {
     bool more = true;
@@ -335,6 +366,12 @@ static void tcg_wasm_out_leb128_sint64_t(TCGContext *s, int64_t v)
     }
 }
 
+static void tcg_wasm_out_op_i32_const(TCGContext *s, int32_t v)
+{
+    tcg_wasm_out8(s, 0x41);
+    tcg_wasm_out_leb128_sint32_t(s, v);
+}
+
 static void tcg_wasm_out_op_i64_const(TCGContext *s, int64_t v)
 {
     tcg_wasm_out8(s, 0x42);
@@ -466,6 +503,50 @@ static void tcg_wasm_out_movcond(TCGContext *s, TCGType type, TCGReg ret,
     tcg_wasm_out_op_global_set_r(s, ret);
 }
 
+static void tcg_wasm_out_deposit(TCGContext *s,
+                                 TCGReg dest, TCGReg arg1, TCGReg arg2,
+                                 int pos, int len)
+{
+    int64_t mask = (((int64_t)1 << len) - 1) << pos;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_const(s, ~mask);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_const(s, pos);
+    tcg_wasm_out_op_i64_shl(s);
+    tcg_wasm_out_op_i64_const(s, mask);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_or(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_extract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                 int pos, int len)
+{
+    int64_t mask = ~0ULL >> (64 - len);
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_const(s, pos);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_i64_const(s, mask);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                  int pos, int len)
+{
+    int rs = 64 - len;
+    int sl = rs - pos;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    if (sl > 0) {
+        tcg_wasm_out_op_i64_const(s, sl);
+        tcg_wasm_out_op_i64_shl(s);
+    }
+    tcg_wasm_out_op_i64_const(s, rs);
+    tcg_wasm_out_op_i64_shr_s(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -677,6 +758,12 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
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
@@ -737,7 +824,8 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
                             TCGReg rs, unsigned pos, unsigned len)
 {
-    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, pos, len);
+    tcg_tci_out_extract(s, type, rd, rs, pos, len);
+    tcg_wasm_out_extract(s, rd, rs, pos, len);
 }
 
 static const TCGOutOpExtract outop_extract = {
@@ -745,10 +833,17 @@ static const TCGOutOpExtract outop_extract = {
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
@@ -762,34 +857,34 @@ static const TCGOutOpExtract2 outop_extract2 = {
 
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
@@ -977,6 +1072,7 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
     tcg_out_op_rrrbb(s, INDEX_op_deposit, a0, a1, a2, ofs, len);
+    tcg_wasm_out_deposit(s, a0, a1, a2, ofs, len);
 }
 
 static const TCGOutOpDeposit outop_deposit = {
@@ -1034,7 +1130,7 @@ static const TCGOutOpBinary outop_eqv = {
 #if TCG_TARGET_REG_BITS == 64
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
-    tcg_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
+    tcg_tci_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
 }
 
 static const TCGOutOpUnary outop_extrh_i64_i32 = {
@@ -1198,7 +1294,7 @@ static void tgen_sar(TCGContext *s, TCGType type,
 {
     TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
-        tcg_out_ext32s(s, TCG_REG_TMP, a1);
+        tcg_tci_out_sextract(s, TCG_TYPE_I64, TCG_REG_TMP, a1, 0, 32);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
@@ -1227,7 +1323,7 @@ static void tgen_shr(TCGContext *s, TCGType type,
 {
     TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
-        tcg_out_ext32u(s, TCG_REG_TMP, a1);
+        tcg_tci_out_extract(s, TCG_TYPE_I64, TCG_REG_TMP, a1, 0, 32);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
@@ -1325,7 +1421,7 @@ static void tgen_bswap16(TCGContext *s, TCGType type,
 {
     tcg_out_op_rr(s, INDEX_op_bswap16, a0, a1);
     if (flags & TCG_BSWAP_OS) {
-        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
+        tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
     }
 }
 
@@ -1339,7 +1435,7 @@ static void tgen_bswap32(TCGContext *s, TCGType type,
 {
     tcg_out_op_rr(s, INDEX_op_bswap32, a0, a1);
     if (flags & TCG_BSWAP_OS) {
-        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
+        tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
     }
 }
 
-- 
2.43.0


