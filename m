Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACD4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMTl-0001La-M6; Tue, 20 May 2025 08:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTH-0000zx-Rh; Tue, 20 May 2025 08:53:33 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTE-0000or-LK; Tue, 20 May 2025 08:53:27 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30e8f4dbb72so4422473a91.1; 
 Tue, 20 May 2025 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745598; x=1748350398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlI3ADKsZrHAbqgaoSffPjMOx8QCa6ijCQD0G6eY21w=;
 b=Xqg0FTZdBrTI6mDt8QOa8iDFqurk3Yz++hhM/kQNTuKppo8ZhRL93mx23lHTvRpjJq
 ih44RmWN35S+MgEzH7/FPQVpblxeZherByFw53aqj8FHtBDq7a+jiR5oTqTA0jseX84H
 BNi2cTxSvKtpxuuAI8Mdi97oP6rVCbr/41jdD2j08MJ7amZqkyC+a4O7bJct2UwPnE3A
 0l/GhnlKRrjcDB2Gm6G3N9vxeZn0rT7zuYNqfnOFjJfavUiGAI7Ssg2vkRDm51IpBMbw
 alvBTAbShp4ZMofb3d38Oib6xMHzFTVtskOr1xEQAedh+4omANqLw0M33Ac/6oWklvn+
 fWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745598; x=1748350398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlI3ADKsZrHAbqgaoSffPjMOx8QCa6ijCQD0G6eY21w=;
 b=XLh+wJit/bM09Bf15F4M49m/Tv+F3W8YioUEhqYMAnMiZBdiWuul3rFYgE0qqqUawR
 GAABWZV/Ad2XXOTT1cyPEmxonMHpyQmPfBymXoEnsQ1aFJheDDNsd+dpaz5tZj83X+/4
 wLvV8dT913dqT9a0pTrMLpbzHKeIbE0DDQsH/tW2V3ZnuyZIuJ6niuCNQxxI4sRDeX+C
 yNU6TOUS5N6zExDLzhebvDHlz4M21e/PNkKmpHhFrdSb64Rhfy0rnClKfkY06Fw5zWVE
 BaXE0SmDG6Q79vsdmusBOVo0I2DGioOMf0P/RyvfdRVYgvS/Hg2FieKrDCz3G/I9kJn/
 byiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbzWej7dKdsRro3MFCHekzH7kCZ8FHNSBu/PyZnswA9uuHb2kfCnzkPq4jpGGX6HAzkp9kIW5rdg==@nongnu.org,
 AJvYcCWYmEJXUzXxM2wb9LIAsEClykpMxAqCoLY+OXGGDT7bJ9ZC4RC6FpoWFZVzkRBOTIEU+YrcnUwd3jFGww==@nongnu.org
X-Gm-Message-State: AOJu0Yw+znrONYMEwNOZBRvZhfN3agtfkd5TAtO9IcRjQpzG9MT80Kh8
 DCjViRuxnUNXujhW6P//E0xRfbdswjczIJYFPmF6V7bqq9QIzBDw8yzFnu3fONy8
X-Gm-Gg: ASbGnct11BqkNUer29wCDSeR07YgHpdGPqkJgtiYgcNqDZoexBbXo8K0em+o0VQ3NYy
 BHVyLOfICVVFgc3x5s5RyMd0hJHACUrotrPjXj/d2Vsmz7eosoCGX5kUTvgW0MaVOUQ4x7flIUT
 /iK2U4p1syDhz1EDvsO/r5nOUzJyswyRBdoc1zUBiHC0zw9JDsmL6pfh5MZKQzV0RF5vq30vI0o
 7mYhDZRs2cTMDK8AO9usheRfKko+ngZyh+1WZ5ZRDRhbAYM9idMGcesHpOpCDZ9VKr4MJg/fvak
 W6thxdsa72Q8FpAlE2+PERLGlI7WUvKear8VER5CJxGvwvGWlu6QPb2Bm7ztKg==
X-Google-Smtp-Source: AGHT+IHCRPMEIPAOztUBdUPNL63cIBCPrltzc/+WoGIQ2txQn80tKWzqSX2p8oCJQMC86V6TS7yRxg==
X-Received: by 2002:a17:90b:5603:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-30e8323cd14mr22649462a91.30.1747745597888; 
 Tue, 20 May 2025 05:53:17 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:17 -0700 (PDT)
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
Subject: [PATCH 11/33] tcg/wasm32: Add mov/movi instructions
Date: Tue, 20 May 2025 21:51:13 +0900
Message-ID: <6e482a0b2d32d06f7877f1f310a0e7a81e85f88f.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1036.google.com
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

This commit implements mov/movi instructions. The tcg_out_mov[i] functions
are used by several other functions and are intended to emit TCI code. So
they have been renamed to tcg_tci_out_mov[i].

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 85 ++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 25 deletions(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 9b024b03b9..90a5705442 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -779,6 +779,28 @@ static void tcg_wasm_out_st16(TCGContext *s, TCGReg val,
     tcg_wasm_out_op_i64_store16(s, 0, offset);
 }
 
+static void tcg_wasm_out_mov(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_global_get_r(s, arg);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
+                              TCGReg ret, tcg_target_long arg)
+{
+   switch (type) {
+   case TCG_TYPE_I32:
+       tcg_wasm_out_op_i64_const(s, (int32_t)arg);
+       break;
+   case TCG_TYPE_I64:
+       tcg_wasm_out_op_i64_const(s, arg);
+       break;
+   default:
+       g_assert_not_reached();
+   }
+   tcg_wasm_out_op_global_set_r(s, ret);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -990,6 +1012,33 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
+static void tcg_tci_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+#if TCG_TARGET_REG_BITS == 64
+        arg = (int32_t)arg;
+        /* fall through */
+    case TCG_TYPE_I64:
+#endif
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (arg == sextract32(arg, 0, 20)) {
+        tcg_out_op_ri(s, INDEX_op_tci_movi, ret, arg);
+    } else {
+        tcg_insn_unit_tci insn = 0;
+
+        new_pool_label(s, arg, 20, s->code_ptr, 0);
+        insn = deposit32(insn, 0, 8, INDEX_op_tci_movl);
+        insn = deposit32(insn, 8, 4, ret);
+        tcg_out32(s, insn);
+    }
+}
+
 static void tcg_tci_out_extract(TCGContext *s, TCGType type, TCGReg rd,
                                 TCGReg rs, unsigned pos, unsigned len)
 {
@@ -1001,7 +1050,7 @@ static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
 {
     stack_bounds_check(base, offset);
     if (offset != sextract32(offset, 0, 16)) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
+        tcg_tci_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
         tcg_out_op_rrr(s, INDEX_op_add, TCG_REG_TMP, TCG_REG_TMP, base);
         base = TCG_REG_TMP;
         offset = 0;
@@ -1021,37 +1070,23 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
     tcg_wasm_out_ld(s, type, val, base, offset);
 }
 
-static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+static void tcg_tci_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     tcg_out_op_rr(s, INDEX_op_mov, ret, arg);
+}
+
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_mov(s, type, ret, arg);
+    tcg_wasm_out_mov(s, ret, arg);
     return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-#if TCG_TARGET_REG_BITS == 64
-        arg = (int32_t)arg;
-        /* fall through */
-    case TCG_TYPE_I64:
-#endif
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (arg == sextract32(arg, 0, 20)) {
-        tcg_out_op_ri(s, INDEX_op_tci_movi, ret, arg);
-    } else {
-        tcg_insn_unit insn = 0;
-
-        new_pool_label(s, arg, 20, s->code_ptr, 0);
-        insn = deposit32(insn, 0, 8, INDEX_op_tci_movl);
-        insn = deposit32(insn, 8, 4, ret);
-        tcg_out32(s, insn);
-    }
+    tcg_tci_out_movi(s, type, ret, arg);
+    tcg_wasm_out_movi(s, type, ret, arg);
 }
 
 static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
@@ -1133,7 +1168,7 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
 static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_out_mov(s, TCG_TYPE_I32, rd, rs);
+    tcg_tci_out_mov(s, TCG_TYPE_I32, rd, rs);
 }
 
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
-- 
2.43.0


