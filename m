Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D01CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0I-0006LE-My; Tue, 19 Aug 2025 14:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0G-0006D4-1b; Tue, 19 Aug 2025 14:24:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0C-0003uU-Tv; Tue, 19 Aug 2025 14:24:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e2e88c6a6so5244847b3a.1; 
 Tue, 19 Aug 2025 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627845; x=1756232645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lk2Yx8bK7zSWcPnckyiRTc9Ulm/rb4Y7KbbWAMUJAus=;
 b=FF72qoAS0qTksH4THuaAqGFKnYM62anplzRCUWpp2VXp8NQPWUpkIdBTsCez4LujTY
 HsV9AR2Pr7k4qNtg1LlwcWBlHHgFP+qpoQn8CzGjJY6l5llPDJKTAItVl56g0Ope2ZLk
 ikdFtxNZrpi8tyGficB0jB8myZWCCP4bWBxUgWrfmAaLwGdm8RDMkkxynfiwpwOAukkZ
 0dUHWBhxuW5FWSil40YXpYAapzGAeWHLimmSFMaqJY9U65Fdc5m75/xi5h5k4lqbyIUj
 JZnTIbplNiOyt2XSqo2pX71zV2GbYkKZVicVMxoIgOlcFcrrF6E9jIfDIV6MEkxcPy+x
 Epog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627845; x=1756232645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lk2Yx8bK7zSWcPnckyiRTc9Ulm/rb4Y7KbbWAMUJAus=;
 b=jrEVLNC9J8GdWuizJb0C6sq9DjoF2h0v9IxwnBTEDWOMLskyRub527FLCRFAIjSgP/
 BKNXy62BuaJlS/OXiDo07T1Asmm5pwFD1cCxMMq80vUeJ+jXlUdnjP5gU2sh5n5UaSxP
 oi2Ilck0BKFJZz+uWo9D4jb4r71qBEiEp3JxahbYxPSsQje/yEQV9MFv5NxlDNJP4Oq6
 St0uhW8fEnGWP7hBFHit9SyyrT3WTiDSIBn9dgu02y5QxoeLV6LTpJE0DXQClTMlvhzQ
 HnpRnvDutDSbtyi+pYBOhmSXtvQ53kAYE8KFJqjXBHOGZE8Bm/QmWlUjhaqP0NNH18XJ
 kGYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvzjdK32PVqI8Ky30BNef/G1I9Mj+rFI4cH4CG/g1q3/oQLf6cry+DRKcZWy0fUnQdDRZWH6g4j+7W0g==@nongnu.org,
 AJvYcCWxUU1VpMru2eZUWj94kef9hMU8lchu1yPKKW/upHrmV5rX6s0FeorFEwZVls2EhmDId+oUyTifew==@nongnu.org
X-Gm-Message-State: AOJu0YwHMdWMdeZlMcZERHs4pzNPUODt3hlRkcXGGjq/A9Fa7XfEYjoj
 B+jteSLr3ZMLc0qtlQWf5bHERZh8CuNBIr5ykT7WuaAbF+zIepk3jGAWos6NCH6R
X-Gm-Gg: ASbGncsUx/TEEyoE4hKJUeYUEMTU4EIxe7ANdX6WSt2Z8d/MvzGDT8NBttGaxCXblj3
 gvpdXj+vv7jtcZlKKJcFfnfeWdFfcRIglRmlnpWpt+J7L5tkN41FkfR0EUO1HZp8ZU7+ZKCKrNg
 nlrr87fu3Fv5GsQfY0H7cOAWtrYSDoIa6GyS2gTbTGfETACpHXC3rLXhG22ejmELnW9AcHL6zjo
 VuqiXpainbB5nxWMifD3h/fu9cIz4caxme3g75dPwh6k4/ZHUz1ARv1hbRUc32LZ0/KKaXHeZVi
 RQOk96w8ZAOVwwM1dcke0ty9gP2nSJByK5FjM7sgqRwqbWB/v/BsZG3b+yN12jTnOOZkDZQE6Z5
 Yc73P+62kPpJuIHQhPpclnm5aCicBReIwVS7SmvCACAk=
X-Google-Smtp-Source: AGHT+IFo0O9d6lUvgk6SML1wwE+NBqP30D9IhObZ+SO91sE8A93CRPYQIshu9HJQmCe7WqNtxOBqcA==
X-Received: by 2002:a17:902:cecd:b0:242:a1ee:6c3f with SMTP id
 d9443c01a7336-245e02db248mr42235245ad.4.1755627845057; 
 Tue, 19 Aug 2025 11:24:05 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:04 -0700 (PDT)
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
Subject: [PATCH 16/35] tcg/wasm: Add mov/movi instructions
Date: Wed, 20 Aug 2025 03:21:45 +0900
Message-ID: <be9a625eb77e2110f69981c39150ed2a6698172a.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42d.google.com
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

The tcg_out_mov and tcg_out_movi functions were used by several other
functions and intended to emit TCI code. So they have been renamed to
tcg_tci_out_mov and tcg_tci_out_movi.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 85 +++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 25 deletions(-)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index c7da6ae055..ec5c45c69e 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -524,6 +524,28 @@ static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
 }
 
+static void tcg_wasm_out_mov(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
+                              TCGReg ret, tcg_target_long arg)
+{
+   switch (type) {
+   case TCG_TYPE_I32:
+       tcg_wasm_out_op_const(s, OPC_I64_CONST, (int32_t)arg);
+       break;
+   case TCG_TYPE_I64:
+       tcg_wasm_out_op_const(s, OPC_I64_CONST, arg);
+       break;
+   default:
+       g_assert_not_reached();
+   }
+   tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -735,6 +757,33 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
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
@@ -746,7 +795,7 @@ static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
 {
     stack_bounds_check(base, offset);
     if (offset != sextract32(offset, 0, 16)) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
+        tcg_tci_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
         tcg_out_op_rrr(s, INDEX_op_add, TCG_REG_TMP, TCG_REG_TMP, base);
         base = TCG_REG_TMP;
         offset = 0;
@@ -768,37 +817,23 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
     tcg_wasm_out_ld(s, wasm_opc, val, base, offset);
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
@@ -880,7 +915,7 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
 static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_out_mov(s, TCG_TYPE_I32, rd, rs);
+    tcg_tci_out_mov(s, TCG_TYPE_I32, rd, rs);
 }
 
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
-- 
2.43.0


