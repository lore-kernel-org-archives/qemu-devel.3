Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72537C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMTR-00017L-Ac; Tue, 20 May 2025 08:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMT8-0000wF-ME; Tue, 20 May 2025 08:53:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMT5-0000o6-IS; Tue, 20 May 2025 08:53:18 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso5534037b3a.2; 
 Tue, 20 May 2025 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745592; x=1748350392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd5mjjrQF9ATa0gHuVt6j9q1L70Kmu641JXtCbaxJks=;
 b=VTi/mBScmuU8R6Od4yLF959BDd5iLT2/HNAK6TIG5LHdd9AiBVUke48MBdbhT2SEGO
 /vDEULP6YFWDBGTUuW63CHdtwM/1Uj42wLZzTlq6rDl47U0KPJF1gamWCfrgFIqD2u77
 JbbT3ORDJeCAhYs3cA5ZSej4P5/2YOPLyqvGtuoNH3TUVv2DhnwU7h4oqo4S3CV/VqAr
 llXw4f7PvLD0Sb5zRgC0vQalhof1vHadszXeQ5QBxIYdgvIFx0Ykr8WBbNgEPloZ7F2Y
 FA+7is2STVFPlhX+Ohf+uRzCL/RcjUB3HAUw6SM6PkTJWKN2iIQeuclbENyaiIdDH99C
 c5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745592; x=1748350392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rd5mjjrQF9ATa0gHuVt6j9q1L70Kmu641JXtCbaxJks=;
 b=Y0W+RDU6KG4iBok9uf2p5yftBcAyF9Q0K+3E2qPwKdbaVzYIUzR1CTMlh3Ne1w8nK7
 5WoycHt1ykrN43BMg9CR3zR9nkSFAw+hNDPRRWAkC194jDEB/orHFuJ3YgKVeb2K34Zb
 uaHTQV2lPFtgY0EQDDFothIUbuH7uo9+axgRMZ7j+Sd7OTajl9zwU61WxM+NwUpZHuJQ
 csbOBm1z1jYM36myC+XKf2ciy3RUnhohKsPWoJ+OpUZTIpe5h5eXvsrA2NuAoa2FjCby
 VdukOs5zPe3gld8JMF2nLq5VUPDAy4ioFazPXqnGpXclErAQ52v5HhMNNa7KKcd7V3Jd
 JJCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSGRu9b7KwPC6FUxP5kYq5R/mpi24YFY9Fk+t+GHgmVc4hbgzZsNsY0Sthcc2KxklaU3TGj6ECKYutQw==@nongnu.org,
 AJvYcCWVQiYFVDvsx0PEq320KLauqwF/1GXPn6bgBetCXJPT+EkAvrJg3RBxlpFEcng3hoNJK95Z7iCDUw==@nongnu.org
X-Gm-Message-State: AOJu0YxJ4G3CoYWVj1QU6vIAre88qv8V7trxIK6MKbHx/H7tlWS4M1TS
 tZpzf/TqMWCevHW+hHVzpGgBDKH5WW0CT9JPo6UmaxqXcvaL1PDw4+QNb93IOqta
X-Gm-Gg: ASbGncvn87Yv6FA8x1QOVdUi5eR+glq1MzQkG3oPNmSO551YM/05f76NCzY7ZaCaKD4
 A6LuVtIaANm54mGDuc/8Tf5NiFv++0q4NNDHthawZwG0ujFducQgt2nsmmQIzh3yGMlcGbQc+Tl
 siGbknvvuoYi059+3hTZ5Jw4S3ttsnQxabOLkh9DHr92L4NUGrbwSjXvzquBsbKZ+sM1SCiXfyV
 Vz+SHYpkG7CpWZE5yprEVi3sHaeaj8CO5PKjKshoQPPyO/g4DBRB3GUc4uoftbtNRbeA/zqhMCP
 IQI+fz+XhHtO29zO7qvKBILvAAaA9QhTqn94SAXpvxxIAOLfVoI=
X-Google-Smtp-Source: AGHT+IF2FW3kjy4TuydJk2c6oRxPAshlC6eugRri80AQsOEYEwiyFGuQRsLOkSsx4VXlAPW/OPcUHw==
X-Received: by 2002:a17:90b:3c8f:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-30e7d51fa7cmr25863329a91.10.1747745592411; 
 Tue, 20 May 2025 05:53:12 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:11 -0700 (PDT)
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
Subject: [PATCH 10/33] tcg/wasm32: Add load and store instructions
Date: Tue, 20 May 2025 21:51:12 +0900
Message-ID: <aacc0ad78d1fff04fa22b14e129bb6f5a4e0862e.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x434.google.com
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

This commit implements load and store operations using Wasm memory
instructions. Since Wasm's load/store instructions don't support negative
offset, address calculations are performed separately before the memory
access.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 242 ++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index d732d2f3c0..9b024b03b9 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -232,6 +232,10 @@ static void tcg_wasm_out_op_i64_extend_i32_u(TCGContext *s)
     tcg_wasm_out8(s, 0xad);
 }
 
+static void tcg_wasm_out_op_i32_add(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x6a);
+}
 static void tcg_wasm_out_op_i32_and(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x71);
@@ -279,6 +283,11 @@ static void tcg_wasm_out_op_global_set_r(TCGContext *s, TCGReg r0)
 {
     tcg_wasm_out_op_global_set(s, tcg_target_reg_index[r0]);
 }
+static void tcg_wasm_out_op_global_get_r_i32(TCGContext *s, TCGReg r0)
+{
+    tcg_wasm_out_op_global_get(s, tcg_target_reg_index[r0]);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+}
 
 #define tcg_wasm_out_i64_calc(op)                                       \
     static void tcg_wasm_out_i64_calc_##op(                             \
@@ -366,6 +375,19 @@ static void tcg_wasm_out_leb128_sint64_t(TCGContext *s, int64_t v)
     }
 }
 
+static void tcg_wasm_out_leb128_uint32_t(TCGContext *s, uint32_t v)
+{
+    uint8_t b;
+    do {
+        b = v & 0x7f;
+        v >>= 7;
+        if (v != 0) {
+            b |= 0x80;
+        }
+        tcg_wasm_out8(s, b);
+    } while (v != 0);
+}
+
 static void tcg_wasm_out_op_i32_const(TCGContext *s, int32_t v)
 {
     tcg_wasm_out8(s, 0x41);
@@ -378,6 +400,68 @@ static void tcg_wasm_out_op_i64_const(TCGContext *s, int64_t v)
     tcg_wasm_out_leb128_sint64_t(s, v);
 }
 
+static void tcg_wasm_out_op_loadstore(
+    TCGContext *s, uint8_t instr, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out8(s, instr);
+    tcg_wasm_out_leb128_uint32_t(s, a);
+    tcg_wasm_out_leb128_uint32_t(s, o);
+}
+
+static void tcg_wasm_out_op_i64_store(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x37, a, o);
+}
+static void tcg_wasm_out_op_i64_store8(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x3c, a, o);
+}
+
+static void tcg_wasm_out_op_i64_store16(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x3d, a, o);
+}
+
+static void tcg_wasm_out_op_i64_store32(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x3e, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x29, a, o);
+}
+
+ static void tcg_wasm_out_op_i64_load8_s(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x30, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load8_u(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x31, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load16_s(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x32, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load16_u(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x33, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load32_s(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x34, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load32_u(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x35, a, o);
+}
+
 static void tcg_wasm_out_op_not(TCGContext *s)
 {
     tcg_wasm_out_op_i64_const(s, -1);
@@ -547,6 +631,154 @@ static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
     tcg_wasm_out_op_global_set_r(s, dest);
 }
 
+static void tcg_wasm_out_ld(
+    TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_i64_load32_u(s, 0, offset);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_i64_load(s, 0, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_op_global_set_r(s, val);
+}
+
+static void tcg_wasm_out_ld8s(TCGContext *s, TCGReg val,
+                              TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_i64_load8_s(s, 0, offset);
+    tcg_wasm_out_op_global_set_r(s, val);
+}
+
+static void tcg_wasm_out_ld8u(TCGContext *s, TCGReg val,
+                              TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_i64_load8_u(s, 0, offset);
+    tcg_wasm_out_op_global_set_r(s, val);
+}
+
+static void tcg_wasm_out_ld16s(TCGContext *s, TCGReg val,
+                               TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_i64_load16_s(s, 0, offset);
+    tcg_wasm_out_op_global_set_r(s, val);
+}
+
+static void tcg_wasm_out_ld16u(TCGContext *s, TCGReg val,
+                               TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_i64_load16_u(s, 0, offset);
+    tcg_wasm_out_op_global_set_r(s, val);
+}
+
+static void tcg_wasm_out_ld32s(TCGContext *s, TCGReg val,
+                               TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_i64_load32_s(s, 0, offset);
+    tcg_wasm_out_op_global_set_r(s, val);
+}
+
+static void tcg_wasm_out_ld32u(TCGContext *s, TCGReg val,
+                               TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_i64_load32_u(s, 0, offset);
+    tcg_wasm_out_op_global_set_r(s, val);
+}
+
+static void tcg_wasm_out_st(TCGContext *s, TCGType type, TCGReg val,
+                            TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_global_get_r(s, val);
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_i64_store32(s, 0, offset);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_i64_store(s, 0, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_st8(TCGContext *s, TCGReg val,
+                             TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_global_get_r(s, val);
+    tcg_wasm_out_op_i64_store8(s, 0, offset);
+}
+
+static void tcg_wasm_out_st16(TCGContext *s, TCGReg val,
+                              TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if (offset < 0) {
+        tcg_wasm_out_op_i32_const(s, offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_global_get_r(s, val);
+    tcg_wasm_out_op_i64_store16(s, 0, offset);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -786,6 +1018,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
         op = INDEX_op_ld32u;
     }
     tcg_out_ldst(s, op, val, base, offset);
+    tcg_wasm_out_ld(s, type, val, base, offset);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1585,6 +1818,7 @@ static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld8u, dest, base, offset);
+    tcg_wasm_out_ld8u(s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld8u = {
@@ -1596,6 +1830,7 @@ static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld8s, dest, base, offset);
+    tcg_wasm_out_ld8s(s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld8s = {
@@ -1607,6 +1842,7 @@ static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld16u, dest, base, offset);
+    tcg_wasm_out_ld16u(s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld16u = {
@@ -1618,6 +1854,7 @@ static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld16s, dest, base, offset);
+    tcg_wasm_out_ld16s(s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld16s = {
@@ -1630,6 +1867,7 @@ static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld32u, dest, base, offset);
+    tcg_wasm_out_ld32u(s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld32u = {
@@ -1641,6 +1879,7 @@ static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld32s, dest, base, offset);
+    tcg_wasm_out_ld32s(s, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld32s = {
@@ -1653,6 +1892,7 @@ static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
                      TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_st8, data, base, offset);
+    tcg_wasm_out_st8(s, data, base, offset);
 }
 
 static const TCGOutOpStore outop_st8 = {
@@ -1664,6 +1904,7 @@ static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
                       TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_st16, data, base, offset);
+    tcg_wasm_out_st16(s, data, base, offset);
 }
 
 static const TCGOutOpStore outop_st16 = {
@@ -1735,6 +1976,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
         op = INDEX_op_st32;
     }
     tcg_out_ldst(s, op, val, base, offset);
+    tcg_wasm_out_st(s, type, val, base, offset);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
-- 
2.43.0


