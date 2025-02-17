Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9A7C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pg-0002UR-0q; Mon, 17 Feb 2025 14:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ox-0001uv-5b
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:26 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6oq-0008IU-Rc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2210d92292eso55110035ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820614; x=1740425414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wj993E3ZZf03MKcBtMhEA9Clo7QI2t/6YKu10ngaiXc=;
 b=TGh7fUsBiK/udDfYDHdxl2NWopRX0G4pU7fumYAuZeiNHVcqNcyQYMhFk9nSwdcMsC
 dxWXPPcf4ETW6U+txKuHWrebxwJLKxTF0RoDcmEywt/m6h23tLPLn9jeUNXaI5glGJfX
 wU+XmJqWiWKJSMQctSMmyPFXhduxB8kpdnpIkSVCmNmPzAABExjVONj5B0TsT0tWcIJZ
 tTt5ov+sTl/5mOKTzajOtXhG1MbInLIONo+LhJluohPjdbfTs1RDwZGmpv6QsqCV0+HX
 +6uLqO+FOtfvcB60buxaes3bTlpe6RzQ3vtoCf4m9IWHvdoYbkq2SeiJwJsENnocOQ31
 vUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820614; x=1740425414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wj993E3ZZf03MKcBtMhEA9Clo7QI2t/6YKu10ngaiXc=;
 b=ZEybxgKUuC9EepwQIN9e+CJXB5iLwpuRNCF4Nn92V4r8T005uy5jZ/iL3L71RJNiJW
 U9ik4RcgKbTJ5nFyFJStRRgWWtqeYKBpq0tlzaIwnG9ChXsA61kCmELpm+OagDRAGoFe
 qzppo5pqgyki0YU+dvJTmmdnopeFXSd/uC5uM7dhoZkA/yOKrPxBEcy56DTXMrOoz6bd
 S4zl9p6abiQPc8DNH84uLfDyObSjsxGrlvxd6Nc/DcOC4gsrjCPV5mTguR8rx48N/LkR
 oIm22EUpy7yElUfdQgQBT2ja9RdZxOzPPl+Jl0Xe9OJPh7EdCpKqllHV+yGGXEh/GLwN
 Tdfw==
X-Gm-Message-State: AOJu0YzSnpIntYaVqlFio6+T4GWqK/r5BWrWXX3noO9oMdh3hzrybv6F
 czGoBewHqH4Y7nxtafQHv62SaYQenPhxIcVoOgvB6c3KaDisuVWqhECxB0uHUn4rI8H/Y5UnFed
 1
X-Gm-Gg: ASbGncupxeSIs1EB4BrREmd9Hyu49F7iDJRnw9hSrLg9bkLU7EfUZRS9l6T91T9inyz
 zfxoYO5zVIyRJiaqUzINeJNFGikBq+Ae9EI77riyHAxRgn8qq82pPwk4/HS8qo8bRGEWIYKSNIN
 TBjK0Q0O8VItzBoTHH/6Ta71hqnNLk7ipFXfVeuwXJmcsqfas3vh6Y+onUCdMLkppENTTXdki//
 0EBg2fEp3xAuGKBWgj9MfXBnjS4ycEe+ATqbAZny3tZ6leAl4voXQqbTDkGuQnTc4aZSxbpOLuX
 l7Nq1PaunXmUqRp/dY+vw8oYFkavVksK/d7FUE17cxwy7A0=
X-Google-Smtp-Source: AGHT+IG/8g0nbUQ7fkfsA7XrSoOIy0Qc/KqWEefZ+5yY7mTMsxNgfSYi3hZwZKJiE5FXTewadhFkVw==
X-Received: by 2002:a05:6a00:438d:b0:732:6480:2bed with SMTP id
 d2e1a72fcca58-73264802c51mr15131013b3a.13.1739820613864; 
 Mon, 17 Feb 2025 11:30:13 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 04/27] tcg: Merge INDEX_op_qemu_*_{a32,a64}_*
Date: Mon, 17 Feb 2025 11:29:45 -0800
Message-ID: <20250217193009.2873875-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since 64-on-32 is now unsupported, guest addresses always
fit in one host register.  Drop the replication of opcodes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  28 ++------
 tcg/optimize.c                   |  21 ++----
 tcg/tcg-op-ldst.c                |  82 +++++----------------
 tcg/tcg.c                        |  42 ++++-------
 tcg/tci.c                        | 119 ++++++-------------------------
 tcg/aarch64/tcg-target.c.inc     |  36 ++++------
 tcg/arm/tcg-target.c.inc         |  40 +++--------
 tcg/i386/tcg-target.c.inc        |  69 ++++--------------
 tcg/loongarch64/tcg-target.c.inc |  36 ++++------
 tcg/mips/tcg-target.c.inc        |  51 +++----------
 tcg/ppc/tcg-target.c.inc         |  68 ++++--------------
 tcg/riscv/tcg-target.c.inc       |  24 +++----
 tcg/s390x/tcg-target.c.inc       |  36 ++++------
 tcg/sparc64/tcg-target.c.inc     |  24 +++----
 tcg/tci/tcg-target.c.inc         |  60 ++++------------
 15 files changed, 177 insertions(+), 559 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9383e295f4..5bf78b0764 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -188,36 +188,22 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
 
-/* Replicate ld/st ops for 32 and 64-bit guest addresses. */
-DEF(qemu_ld_a32_i32, 1, 1, 1,
+DEF(qemu_ld_i32, 1, 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_a32_i32, 0, 1 + 1, 1,
+DEF(qemu_st_i32, 0, 1 + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_ld_a32_i64, DATA64_ARGS, 1, 1,
+DEF(qemu_ld_i64, DATA64_ARGS, 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_a32_i64, 0, DATA64_ARGS + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-
-DEF(qemu_ld_a64_i32, 1, DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_a64_i32, 0, 1 + DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_ld_a64_i64, DATA64_ARGS, DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_a64_i64, 0, DATA64_ARGS + DATA64_ARGS, 1,
+DEF(qemu_st_i64, 0, DATA64_ARGS + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Only used by i386 to cope with stupid register constraints. */
-DEF(qemu_st8_a32_i32, 0, 1 + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st8_a64_i32, 0, 1 + DATA64_ARGS, 1,
+DEF(qemu_st8_i32, 0, 1 + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Only for 64-bit hosts at the moment. */
-DEF(qemu_ld_a32_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_ld_a64_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_a32_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_a64_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
+DEF(qemu_ld_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
+DEF(qemu_st_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Host vector support.  */
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index bca11cc427..f922f86a1d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3011,29 +3011,22 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(orc):
             done = fold_orc(&ctx, op);
             break;
-        case INDEX_op_qemu_ld_a32_i32:
-        case INDEX_op_qemu_ld_a64_i32:
+        case INDEX_op_qemu_ld_i32:
             done = fold_qemu_ld_1reg(&ctx, op);
             break;
-        case INDEX_op_qemu_ld_a32_i64:
-        case INDEX_op_qemu_ld_a64_i64:
+        case INDEX_op_qemu_ld_i64:
             if (TCG_TARGET_REG_BITS == 64) {
                 done = fold_qemu_ld_1reg(&ctx, op);
                 break;
             }
             QEMU_FALLTHROUGH;
-        case INDEX_op_qemu_ld_a32_i128:
-        case INDEX_op_qemu_ld_a64_i128:
+        case INDEX_op_qemu_ld_i128:
             done = fold_qemu_ld_2reg(&ctx, op);
             break;
-        case INDEX_op_qemu_st8_a32_i32:
-        case INDEX_op_qemu_st8_a64_i32:
-        case INDEX_op_qemu_st_a32_i32:
-        case INDEX_op_qemu_st_a64_i32:
-        case INDEX_op_qemu_st_a32_i64:
-        case INDEX_op_qemu_st_a64_i64:
-        case INDEX_op_qemu_st_a32_i128:
-        case INDEX_op_qemu_st_a64_i128:
+        case INDEX_op_qemu_st8_i32:
+        case INDEX_op_qemu_st_i32:
+        case INDEX_op_qemu_st_i64:
+        case INDEX_op_qemu_st_i128:
             done = fold_qemu_st(&ctx, op);
             break;
         CASE_OP_32_64(rem):
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 7ba9a3ef7e..73838e2701 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -217,7 +217,6 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
-    TCGOpcode opc;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -233,12 +232,8 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     }
 
     copy_addr = plugin_maybe_preserve_addr(addr);
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        opc = INDEX_op_qemu_ld_a32_i32;
-    } else {
-        opc = INDEX_op_qemu_ld_a64_i32;
-    }
-    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst(INDEX_op_qemu_ld_i32, TCG_TYPE_I32,
+             tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
 
@@ -295,17 +290,9 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
     }
 
     if (TCG_TARGET_HAS_qemu_st8_i32 && (memop & MO_SIZE) == MO_8) {
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_st8_a32_i32;
-        } else {
-            opc = INDEX_op_qemu_st8_a64_i32;
-        }
+        opc = INDEX_op_qemu_st8_i32;
     } else {
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_st_a32_i32;
-        } else {
-            opc = INDEX_op_qemu_st_a64_i32;
-        }
+        opc = INDEX_op_qemu_st_i32;
     }
     gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
@@ -329,7 +316,6 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
-    TCGOpcode opc;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -355,12 +341,7 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     }
 
     copy_addr = plugin_maybe_preserve_addr(addr);
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        opc = INDEX_op_qemu_ld_a32_i64;
-    } else {
-        opc = INDEX_op_qemu_ld_a64_i64;
-    }
-    gen_ldst_i64(opc, val, addr, oi);
+    gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, oi);
     plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
 
@@ -397,7 +378,6 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
 {
     TCGv_i64 swap = NULL;
     MemOpIdx orig_oi, oi;
-    TCGOpcode opc;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -428,12 +408,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        opc = INDEX_op_qemu_st_a32_i64;
-    } else {
-        opc = INDEX_op_qemu_st_a64_i64;
-    }
-    gen_ldst_i64(opc, val, addr, oi);
+    gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, oi);
     plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
@@ -545,7 +520,6 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
 {
     MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
-    TCGOpcode opc;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
@@ -573,12 +547,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_ld_a32_i128;
-        } else {
-            opc = INDEX_op_qemu_ld_a64_i128;
-        }
-        gen_ldst(opc, TCG_TYPE_I128, tcgv_i64_temp(lo),
+        gen_ldst(INDEX_op_qemu_ld_i128, TCG_TYPE_I128, tcgv_i64_temp(lo),
                  tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
@@ -594,12 +563,6 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
         canonicalize_memop_i128_as_i64(mop, memop);
         need_bswap = (mop[0] ^ memop) & MO_BSWAP;
 
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_ld_a32_i64;
-        } else {
-            opc = INDEX_op_qemu_ld_a64_i64;
-        }
-
         /*
          * Since there are no global TCGv_i128, there is no visible state
          * changed if the second load faults.  Load directly into the two
@@ -613,7 +576,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             y = TCGV128_LOW(val);
         }
 
-        gen_ldst_i64(opc, x, addr, make_memop_idx(mop[0], idx));
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr,
+                     make_memop_idx(mop[0], idx));
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(x, x);
@@ -629,7 +593,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             addr_p8 = tcgv_i64_temp(t);
         }
 
-        gen_ldst_i64(opc, y, addr_p8, make_memop_idx(mop[1], idx));
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_p8,
+                     make_memop_idx(mop[1], idx));
         tcg_temp_free_internal(addr_p8);
 
         if (need_bswap) {
@@ -663,7 +628,6 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
 {
     MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
-    TCGOpcode opc;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
@@ -694,13 +658,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_st_a32_i128;
-        } else {
-            opc = INDEX_op_qemu_st_a64_i128;
-        }
-        gen_ldst(opc, TCG_TYPE_I128, tcgv_i64_temp(lo),
-                 tcgv_i64_temp(hi), addr, oi);
+        gen_ldst(INDEX_op_qemu_st_i128, TCG_TYPE_I128,
+                 tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
@@ -713,12 +672,6 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
 
         canonicalize_memop_i128_as_i64(mop, memop);
 
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_st_a32_i64;
-        } else {
-            opc = INDEX_op_qemu_st_a64_i64;
-        }
-
         if ((memop & MO_BSWAP) == MO_LE) {
             x = TCGV128_LOW(val);
             y = TCGV128_HIGH(val);
@@ -733,7 +686,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             x = b;
         }
 
-        gen_ldst_i64(opc, x, addr, make_memop_idx(mop[0], idx));
+        gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr,
+                     make_memop_idx(mop[0], idx));
 
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
             TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -747,10 +701,12 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
 
         if (b) {
             tcg_gen_bswap64_i64(b, y);
-            gen_ldst_i64(opc, b, addr_p8, make_memop_idx(mop[1], idx));
+            gen_ldst_i64(INDEX_op_qemu_st_i64, b, addr_p8,
+                         make_memop_idx(mop[1], idx));
             tcg_temp_free_i64(b);
         } else {
-            gen_ldst_i64(opc, y, addr_p8, make_memop_idx(mop[1], idx));
+            gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_p8,
+                         make_memop_idx(mop[1], idx));
         }
         tcg_temp_free_internal(addr_p8);
     } else {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 14c2d38160..fef93b25ff 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2147,24 +2147,17 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_exit_tb:
     case INDEX_op_goto_tb:
     case INDEX_op_goto_ptr:
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_st_i64:
         return true;
 
-    case INDEX_op_qemu_st8_a32_i32:
-    case INDEX_op_qemu_st8_a64_i32:
+    case INDEX_op_qemu_st8_i32:
         return TCG_TARGET_HAS_qemu_st8_i32;
 
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_ld_i128:
+    case INDEX_op_qemu_st_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
     case INDEX_op_mov_i32:
@@ -2862,20 +2855,13 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 }
                 i = 1;
                 break;
-            case INDEX_op_qemu_ld_a32_i32:
-            case INDEX_op_qemu_ld_a64_i32:
-            case INDEX_op_qemu_st_a32_i32:
-            case INDEX_op_qemu_st_a64_i32:
-            case INDEX_op_qemu_st8_a32_i32:
-            case INDEX_op_qemu_st8_a64_i32:
-            case INDEX_op_qemu_ld_a32_i64:
-            case INDEX_op_qemu_ld_a64_i64:
-            case INDEX_op_qemu_st_a32_i64:
-            case INDEX_op_qemu_st_a64_i64:
-            case INDEX_op_qemu_ld_a32_i128:
-            case INDEX_op_qemu_ld_a64_i128:
-            case INDEX_op_qemu_st_a32_i128:
-            case INDEX_op_qemu_st_a64_i128:
+            case INDEX_op_qemu_ld_i32:
+            case INDEX_op_qemu_st_i32:
+            case INDEX_op_qemu_st8_i32:
+            case INDEX_op_qemu_ld_i64:
+            case INDEX_op_qemu_st_i64:
+            case INDEX_op_qemu_ld_i128:
+            case INDEX_op_qemu_st_i128:
                 {
                     const char *s_al, *s_op, *s_at;
                     MemOpIdx oi = op->args[k++];
diff --git a/tcg/tci.c b/tcg/tci.c
index 8c1c53424d..d223258efe 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -154,16 +154,6 @@ static void tci_args_rrrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
     *i4 = extract32(insn, 26, 6);
 }
 
-static void tci_args_rrrrr(uint32_t insn, TCGReg *r0, TCGReg *r1,
-                           TCGReg *r2, TCGReg *r3, TCGReg *r4)
-{
-    *r0 = extract32(insn, 8, 4);
-    *r1 = extract32(insn, 12, 4);
-    *r2 = extract32(insn, 16, 4);
-    *r3 = extract32(insn, 20, 4);
-    *r4 = extract32(insn, 24, 4);
-}
-
 static void tci_args_rrrr(uint32_t insn,
                           TCGReg *r0, TCGReg *r1, TCGReg *r2, TCGReg *r3)
 {
@@ -912,43 +902,21 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tb_ptr = ptr;
             break;
 
-        case INDEX_op_qemu_ld_a32_i32:
+        case INDEX_op_qemu_ld_i32:
             tci_args_rrm(insn, &r0, &r1, &oi);
-            taddr = (uint32_t)regs[r1];
-            goto do_ld_i32;
-        case INDEX_op_qemu_ld_a64_i32:
-            if (TCG_TARGET_REG_BITS == 64) {
-                tci_args_rrm(insn, &r0, &r1, &oi);
-                taddr = regs[r1];
-            } else {
-                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-                taddr = tci_uint64(regs[r2], regs[r1]);
-                oi = regs[r3];
-            }
-        do_ld_i32:
+            taddr = regs[r1];
             regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
             break;
 
-        case INDEX_op_qemu_ld_a32_i64:
-            if (TCG_TARGET_REG_BITS == 64) {
-                tci_args_rrm(insn, &r0, &r1, &oi);
-                taddr = (uint32_t)regs[r1];
-            } else {
-                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-                taddr = (uint32_t)regs[r2];
-                oi = regs[r3];
-            }
-            goto do_ld_i64;
-        case INDEX_op_qemu_ld_a64_i64:
+        case INDEX_op_qemu_ld_i64:
             if (TCG_TARGET_REG_BITS == 64) {
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 taddr = regs[r1];
             } else {
-                tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
-                taddr = tci_uint64(regs[r3], regs[r2]);
-                oi = regs[r4];
+                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+                taddr = regs[r2];
+                oi = regs[r3];
             }
-        do_ld_i64:
             tmp64 = tci_qemu_ld(env, taddr, oi, tb_ptr);
             if (TCG_TARGET_REG_BITS == 32) {
                 tci_write_reg64(regs, r1, r0, tmp64);
@@ -957,47 +925,23 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             }
             break;
 
-        case INDEX_op_qemu_st_a32_i32:
+        case INDEX_op_qemu_st_i32:
             tci_args_rrm(insn, &r0, &r1, &oi);
-            taddr = (uint32_t)regs[r1];
-            goto do_st_i32;
-        case INDEX_op_qemu_st_a64_i32:
-            if (TCG_TARGET_REG_BITS == 64) {
-                tci_args_rrm(insn, &r0, &r1, &oi);
-                taddr = regs[r1];
-            } else {
-                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-                taddr = tci_uint64(regs[r2], regs[r1]);
-                oi = regs[r3];
-            }
-        do_st_i32:
+            taddr = regs[r1];
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
 
-        case INDEX_op_qemu_st_a32_i64:
-            if (TCG_TARGET_REG_BITS == 64) {
-                tci_args_rrm(insn, &r0, &r1, &oi);
-                tmp64 = regs[r0];
-                taddr = (uint32_t)regs[r1];
-            } else {
-                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-                tmp64 = tci_uint64(regs[r1], regs[r0]);
-                taddr = (uint32_t)regs[r2];
-                oi = regs[r3];
-            }
-            goto do_st_i64;
-        case INDEX_op_qemu_st_a64_i64:
+        case INDEX_op_qemu_st_i64:
             if (TCG_TARGET_REG_BITS == 64) {
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 tmp64 = regs[r0];
                 taddr = regs[r1];
             } else {
-                tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
+                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
                 tmp64 = tci_uint64(regs[r1], regs[r0]);
-                taddr = tci_uint64(regs[r3], regs[r2]);
-                oi = regs[r4];
+                taddr = regs[r2];
+                oi = regs[r3];
             }
-        do_st_i64:
             tci_qemu_st(env, taddr, tmp64, oi, tb_ptr);
             break;
 
@@ -1269,42 +1213,21 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r3), str_r(r4), str_r(r5));
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_st_a32_i32:
-        len = 1 + 1;
-        goto do_qemu_ldst;
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_st_a64_i32:
-        len = 1 + DIV_ROUND_UP(64, TCG_TARGET_REG_BITS);
-        goto do_qemu_ldst;
-    case INDEX_op_qemu_ld_a64_i64:
-    case INDEX_op_qemu_st_a64_i64:
-        len = 2 * DIV_ROUND_UP(64, TCG_TARGET_REG_BITS);
-        goto do_qemu_ldst;
-    do_qemu_ldst:
-        switch (len) {
-        case 2:
-            tci_args_rrm(insn, &r0, &r1, &oi);
-            info->fprintf_func(info->stream, "%-12s  %s, %s, %x",
-                               op_name, str_r(r0), str_r(r1), oi);
-            break;
-        case 3:
+    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_st_i64:
+        if (TCG_TARGET_REG_BITS == 32) {
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                                op_name, str_r(r0), str_r(r1),
                                str_r(r2), str_r(r3));
             break;
-        case 4:
-            tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
-            info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s",
-                               op_name, str_r(r0), str_r(r1),
-                               str_r(r2), str_r(r3), str_r(r4));
-            break;
-        default:
-            g_assert_not_reached();
         }
+        /* fall through */
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_st_i32:
+        tci_args_rrm(insn, &r0, &r1, &oi);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %x",
+                           op_name, str_r(r0), str_r(r1), oi);
         break;
 
     case 0:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 66eb4b73b5..45dc2c649b 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2398,24 +2398,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3506, CSEL, ext, a0, REG0(3), REG0(4), args[5]);
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, ext);
         break;
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, REG0(0), a1, a2, ext);
         break;
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], true);
         break;
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         tcg_out_qemu_ldst_i128(s, REG0(0), REG0(1), a2, args[3], false);
         break;
 
@@ -3084,21 +3078,15 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rZ, rZ);
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         return C_O2_I1(r, r, r);
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
         return C_O0_I2(rZ, r);
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         return C_O0_I3(rZ, rZ, r);
 
     case INDEX_op_deposit_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 12dad7307f..05bb367a39 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2071,37 +2071,21 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         ARITH_MOV, args[0], 0, 0);
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a64_i32:
-        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2],
-                        args[3], TCG_TYPE_I32);
-        break;
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, args[0], args[1], args[2], -1,
                         args[3], TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_ld_a64_i64:
-        tcg_out_qemu_ld(s, args[0], args[1], args[2], args[3],
-                        args[4], TCG_TYPE_I64);
-        break;
 
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a64_i32:
-        tcg_out_qemu_st(s, args[0], -1, args[1], args[2],
-                        args[3], TCG_TYPE_I32);
-        break;
-    case INDEX_op_qemu_st_a32_i64:
+    case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, args[0], args[1], args[2], -1,
                         args[3], TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_st_a64_i64:
-        tcg_out_qemu_st(s, args[0], args[1], args[2], args[3],
-                        args[4], TCG_TYPE_I64);
-        break;
 
     case INDEX_op_bswap16_i32:
         tcg_out_bswap16(s, COND_AL, args[0], args[1], args[2]);
@@ -2243,22 +2227,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, rI, rI);
 
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, q);
-    case INDEX_op_qemu_ld_a64_i32:
-        return C_O1_I2(r, q, q);
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         return C_O2_I1(e, p, q);
-    case INDEX_op_qemu_ld_a64_i64:
-        return C_O2_I2(e, p, q, q);
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         return C_O0_I2(q, q);
-    case INDEX_op_qemu_st_a64_i32:
-        return C_O0_I3(q, q, q);
-    case INDEX_op_qemu_st_a32_i64:
+    case INDEX_op_qemu_st_i64:
         return C_O0_I3(Q, p, q);
-    case INDEX_op_qemu_st_a64_i64:
-        return C_O0_I4(Q, p, q, q);
 
     case INDEX_op_st_vec:
         return C_O0_I2(w, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2cac151331..ca6e8abc57 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2879,62 +2879,33 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
         break;
 
-    case INDEX_op_qemu_ld_a64_i32:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_ld(s, a0, -1, a1, a2, args[3], TCG_TYPE_I32);
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, -1, a1, -1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_qemu_ld(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
         } else {
             tcg_out_qemu_ld(s, a0, a1, a2, -1, args[3], TCG_TYPE_I64);
         }
         break;
-    case INDEX_op_qemu_ld_a64_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_ld(s, a0, a1, a2, args[3], args[4], TCG_TYPE_I64);
-        }
-        break;
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         tcg_out_qemu_ld(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
         break;
 
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_st8_a64_i32:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_st(s, a0, -1, a1, a2, args[3], TCG_TYPE_I32);
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st8_a32_i32:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st8_i32:
         tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a32_i64:
+    case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
         } else {
             tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I64);
         }
         break;
-    case INDEX_op_qemu_st_a64_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_st(s, a0, a1, a2, args[3], args[4], TCG_TYPE_I64);
-        }
-        break;
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
         break;
@@ -3824,36 +3795,24 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_clz_i64:
         return have_lzcnt ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
 
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, L);
-    case INDEX_op_qemu_ld_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O1_I2(r, L, L);
 
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         return C_O0_I2(L, L);
-    case INDEX_op_qemu_st_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(L, L) : C_O0_I3(L, L, L);
-    case INDEX_op_qemu_st8_a32_i32:
+    case INDEX_op_qemu_st8_i32:
         return C_O0_I2(s, L);
-    case INDEX_op_qemu_st8_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(s, L) : C_O0_I3(s, L, L);
 
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O2_I1(r, r, L);
-    case INDEX_op_qemu_ld_a64_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O2_I2(r, r, L, L);
 
-    case INDEX_op_qemu_st_a32_i64:
+    case INDEX_op_qemu_st_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(L, L) : C_O0_I3(L, L, L);
-    case INDEX_op_qemu_st_a64_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(L, L) : C_O0_I4(L, L, L, L);
 
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         return C_O2_I1(r, r, L);
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         return C_O0_I3(L, L, L);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cebe8dd354..4f32bf3e97 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1675,28 +1675,22 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_ST_D, a0, a1, a2);
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, true);
         break;
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
+    case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
         break;
 
@@ -2233,18 +2227,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st32_i64:
     case INDEX_op_st_i32:
     case INDEX_op_st_i64:
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         return C_N2_I1(r, r, r);
 
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
     case INDEX_op_brcond_i32:
@@ -2290,10 +2280,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i32:
     case INDEX_op_ld_i64:
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_andc_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 99f6ef6c76..b1d512ca2a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2095,53 +2095,27 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
 
-    case INDEX_op_qemu_ld_a64_i32:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_ld(s, a0, 0, a1, a2, args[3], TCG_TYPE_I32);
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, 0, a1, 0, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_qemu_ld(s, a0, 0, a1, 0, a2, TCG_TYPE_I64);
         } else {
             tcg_out_qemu_ld(s, a0, a1, a2, 0, args[3], TCG_TYPE_I64);
         }
         break;
-    case INDEX_op_qemu_ld_a64_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, a0, 0, a1, 0, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_ld(s, a0, a1, a2, args[3], args[4], TCG_TYPE_I64);
-        }
-        break;
 
-    case INDEX_op_qemu_st_a64_i32:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_st(s, a0, 0, a1, a2, args[3], TCG_TYPE_I32);
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, a0, 0, a1, 0, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a32_i64:
+    case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_qemu_st(s, a0, 0, a1, 0, a2, TCG_TYPE_I64);
         } else {
             tcg_out_qemu_st(s, a0, a1, a2, 0, args[3], TCG_TYPE_I64);
         }
         break;
-    case INDEX_op_qemu_st_a64_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, a0, 0, a1, 0, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_st(s, a0, a1, a2, args[3], args[4], TCG_TYPE_I64);
-        }
-        break;
 
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
@@ -2301,23 +2275,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_brcond2_i32:
         return C_O0_I4(rZ, rZ, rZ, rZ);
 
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O1_I2(r, r, r);
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         return C_O0_I2(rZ, r);
-    case INDEX_op_qemu_st_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rZ, r) : C_O0_I3(rZ, r, r);
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
-    case INDEX_op_qemu_ld_a64_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I2(r, r, r, r);
-    case INDEX_op_qemu_st_a32_i64:
+    case INDEX_op_qemu_st_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rZ, r) : C_O0_I3(rZ, rZ, r);
-    case INDEX_op_qemu_st_a64_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rZ, r)
-                : C_O0_I4(rZ, rZ, r, r));
 
     default:
         return C_NotImplemented;
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6e711cd53f..801cb6f3cb 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3308,17 +3308,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, MODUD | TAB(args[0], args[1], args[2]));
         break;
 
-    case INDEX_op_qemu_ld_a64_i32:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_ld(s, args[0], -1, args[1], args[2],
-                            args[3], TCG_TYPE_I32);
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_qemu_ld(s, args[0], -1, args[1], -1,
                             args[2], TCG_TYPE_I64);
@@ -3327,32 +3320,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[3], TCG_TYPE_I64);
         }
         break;
-    case INDEX_op_qemu_ld_a64_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, args[0], -1, args[1], -1,
-                            args[2], TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_ld(s, args[0], args[1], args[2], args[3],
-                            args[4], TCG_TYPE_I64);
-        }
-        break;
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
         break;
 
-    case INDEX_op_qemu_st_a64_i32:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_st(s, args[0], -1, args[1], args[2],
-                            args[3], TCG_TYPE_I32);
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a32_i64:
+    case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_qemu_st(s, args[0], -1, args[1], -1,
                             args[2], TCG_TYPE_I64);
@@ -3361,17 +3337,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[3], TCG_TYPE_I64);
         }
         break;
-    case INDEX_op_qemu_st_a64_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, args[0], -1, args[1], -1,
-                            args[2], TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_st(s, args[0], args[1], args[2], args[3],
-                            args[4], TCG_TYPE_I64);
-        }
-        break;
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
@@ -4306,29 +4272,19 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub2_i32:
         return C_O2_I4(r, r, rI, rZM, r, r);
 
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O1_I2(r, r, r);
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
-    case INDEX_op_qemu_ld_a64_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I2(r, r, r, r);
 
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_st_a64_i32:
+    case INDEX_op_qemu_st_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I3(r, r, r);
-    case INDEX_op_qemu_st_a32_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I3(r, r, r);
-    case INDEX_op_qemu_st_a64_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I4(r, r, r, r);
 
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         return C_N1O1_I1(o, m, r);
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         return C_O0_I3(o, m, r);
 
     case INDEX_op_add_vec:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 61dc310c1a..55a3398712 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2309,20 +2309,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         args[3], const_args[3], args[4], const_args[4]);
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
+    case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
@@ -2761,15 +2757,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub2_i64:
         return C_O2_I4(r, r, rZ, rZ, rM, rM);
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
         return C_O0_I2(rZ, r);
 
     case INDEX_op_st_vec:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index dc7722dc31..6786e7b316 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2455,28 +2455,22 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                      args[2], const_args[2], args[3], const_args[3], args[4]);
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
+    case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, args[0], args[1], args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, args[0], args[1], args[2], TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
         break;
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
@@ -3366,21 +3360,15 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
+    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st_i32:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_ld_a32_i128:
-    case INDEX_op_qemu_ld_a64_i128:
+    case INDEX_op_qemu_ld_i128:
         return C_O2_I1(o, m, r);
-    case INDEX_op_qemu_st_a32_i128:
-    case INDEX_op_qemu_st_a64_i128:
+    case INDEX_op_qemu_st_i128:
         return C_O0_I3(o, m, r);
 
     case INDEX_op_deposit_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 733cb51651..ea0a3b8692 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1426,20 +1426,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithi(s, a1, a0, 32, SHIFT_SRLX);
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
+    case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
         break;
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
+    case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
@@ -1570,10 +1566,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_ld_a64_i64:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
@@ -1583,10 +1577,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_st_a32_i64:
-    case INDEX_op_qemu_st_a64_i64:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
         return C_O0_I2(rZ, r);
 
     case INDEX_op_add_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d6c77325a3..36e018dd19 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -169,22 +169,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, r, r);
 
-    case INDEX_op_qemu_ld_a32_i32:
+    case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O1_I2(r, r, r);
-    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
-    case INDEX_op_qemu_ld_a64_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I2(r, r, r, r);
-    case INDEX_op_qemu_st_a32_i32:
+    case INDEX_op_qemu_st_i32:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_st_a64_i32:
+    case INDEX_op_qemu_st_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I3(r, r, r);
-    case INDEX_op_qemu_st_a32_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I3(r, r, r);
-    case INDEX_op_qemu_st_a64_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I4(r, r, r, r);
 
     default:
         return C_NotImplemented;
@@ -422,20 +414,6 @@ static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
     tcg_out32(s, insn);
 }
 
-static void tcg_out_op_rrrrr(TCGContext *s, TCGOpcode op, TCGReg r0,
-                             TCGReg r1, TCGReg r2, TCGReg r3, TCGReg r4)
-{
-    tcg_insn_unit insn = 0;
-
-    insn = deposit32(insn, 0, 8, op);
-    insn = deposit32(insn, 8, 4, r0);
-    insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 16, 4, r2);
-    insn = deposit32(insn, 20, 4, r3);
-    insn = deposit32(insn, 24, 4, r4);
-    tcg_out32(s, insn);
-}
-
 static void tcg_out_op_rrrr(TCGContext *s, TCGOpcode op,
                             TCGReg r0, TCGReg r1, TCGReg r2, TCGReg r3)
 {
@@ -833,29 +811,21 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_st_a32_i32:
-        tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_qemu_ld_a64_i32:
-    case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_ld_a32_i64:
-    case INDEX_op_qemu_st_a32_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
-        } else {
+    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_st_i64:
+        if (TCG_TARGET_REG_BITS == 32) {
             tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
             tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
+            break;
         }
-        break;
-    case INDEX_op_qemu_ld_a64_i64:
-    case INDEX_op_qemu_st_a64_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
+        /* fall through */
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_st_i32:
+        if (TCG_TARGET_REG_BITS == 64 && s->addr_type == TCG_TYPE_I32) {
+            tcg_out_ext32u(s, TCG_REG_TMP, args[1]);
+            tcg_out_op_rrm(s, opc, args[0], TCG_REG_TMP, args[2]);
         } else {
-            tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[4]);
-            tcg_out_op_rrrrr(s, opc, args[0], args[1],
-                             args[2], args[3], TCG_REG_TMP);
+            tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
         }
         break;
 
-- 
2.43.0


