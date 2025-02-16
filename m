Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0B7C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyq-0000QC-Qq; Sun, 16 Feb 2025 18:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnx2-00051T-V5
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:31 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwv-0006WT-8p
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:28 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc3db58932so2316573a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748077; x=1740352877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ivMgVyuisPQ/5eugUcd2HPAEShPBEJVuSep+mnUK+bo=;
 b=XglaOzSTb4ZR9R5Y2ItZQzt6aosfm7o6/6AC0gM98OLpQ1W5eXPPvQb/6zfTN13cFl
 LCLI/IHwXdRtWPTguZvt1YY2Sc4Lypc6SkusaxMPtLZjerFwoNq2MplLOz76m1RmQ8LR
 DBzV5I1ywxnJyT4IFlAhfqc6/wczSCWmEvpz/noJRUHOu1ujMtr4whKEfGt1rRxee53K
 3oiWC5rNe/VLFJCvrauNJ7v1xGG/4jSY2ipwugEAfp09SXYkn6Tg4X8b6k6oajRnkSWn
 f7QbbTI8EBtCDFMOVjBP8aElNYhYKFBJPciC/4dn/cizEV3s+DhFbKbpqa9WBMQaOtZw
 I4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748077; x=1740352877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivMgVyuisPQ/5eugUcd2HPAEShPBEJVuSep+mnUK+bo=;
 b=mOcbSeUMcHYA5Yzn+eRoVWYGcB0h5T3zDZxJvVRJymu0bwCQPFjrn9yxW4lLRLhfgq
 jFeyG2VIyiguMUe07jE8ejPGy9LXUVtMyl2jPquaks28VH91teLnXGjL61nK5+fnEAL9
 D4XQYpcDfxTlAws2s81d4xZfBX0AcL3Y/w2FteRLRyrDDrpCjnwxSEJSg0VFZHfHrDiI
 4hBY8kKx7Oh64h/D23v+q1WbIY9V833wxRbU5F2CtGS/x/3nTvF8N9EOU5RXYwxd4zS6
 UpCkk2TuK4t7y6jBguPB7wE7yzt8PO88LfwzREJNICPxwdCj8GDi+nRgDatr+T9vt4ya
 UfKQ==
X-Gm-Message-State: AOJu0Yzjwlxw+imYiseaM5cRD12AFoFPLsp2aXDIStq5oTQ8vOg9Ivip
 bBj6H8XgPi75ZuQ+T5IfPAnUwUf2XilieZi0Oh12rzdCPHful4gj2qAUNwu8lWSc2eby0zBQ/Aw
 /
X-Gm-Gg: ASbGncvcilc6uv6E7QfD1N5tOT1nsP0vmMmey3i+y6UlwbSN9tAS1UWWrU8WjYfRICP
 i69YtiApfjMGYudv6Q1NELnTNFJ73pkvOUZQ9JdrGBHGFsTj9QaY3dmCIvVgizHSbEEdH7bCf3m
 zMCG6SQDzcVJtXJEEHgTBL529SwqKcPZ3xEwUgQ8AoQuJ/yWR0z3NOhZXEJT4OR32PmUdaTL4V1
 wW3oLTpQm/bSIv1k4nSdQinX/MmAGpr4E378+wNfVzo6LPX/N0GeG2M/e/M6qtT7HHxZ/yc8mK6
 jpVl1Vjl3YsM4r/O2gWso4NE9XgqMLUC/Fs0rJyH1bq9Jpo=
X-Google-Smtp-Source: AGHT+IEdzeub8SEDsfHpK05LEKWbZuj4aDXwbjpRUekigECQzyqyrq9SyY9jP/N7XewpJJ7UbPJ20Q==
X-Received: by 2002:a17:90b:3812:b0:2ee:ead6:6213 with SMTP id
 98e67ed59e1d1-2fc40f22e0dmr10690148a91.19.1739748076636; 
 Sun, 16 Feb 2025 15:21:16 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 159/162] tcg: Merge INDEX_op_{ld,st}_{i32,i64,i128}
Date: Sun, 16 Feb 2025 15:10:08 -0800
Message-ID: <20250216231012.2808572-160-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Merge into INDEX_op_{ld,st,ld2,st2}, where "2" indicates that two
inputs or outputs are required. This simplifies the processing of
i64/i128 depending on host word size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 16 ++-----
 tcg/optimize.c                   | 15 ++-----
 tcg/tcg-op-ldst.c                | 75 +++++++++++++++++---------------
 tcg/tcg.c                        | 28 +++++++-----
 tcg/tci.c                        | 69 ++++++++++++-----------------
 tcg/aarch64/tcg-target.c.inc     | 20 ++++-----
 tcg/arm/tcg-target.c.inc         | 16 +++----
 tcg/i386/tcg-target.c.inc        | 50 ++++++---------------
 tcg/loongarch64/tcg-target.c.inc | 28 +++++-------
 tcg/mips/tcg-target.c.inc        | 38 +++++++---------
 tcg/ppc/tcg-target.c.inc         | 47 ++++++++------------
 tcg/riscv/tcg-target.c.inc       | 20 +++------
 tcg/s390x/tcg-target.c.inc       | 28 +++++-------
 tcg/sparc64/tcg-target.c.inc     | 20 +++------
 tcg/tci/tcg-target.c.inc         | 36 ++++++---------
 15 files changed, 200 insertions(+), 306 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 0ce8332aab..995b79383e 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -124,18 +124,10 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
 
-DEF(qemu_ld_i32, 1, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_i32, 0, 1 + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_ld_i64, DATA64_ARGS, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_i64, 0, DATA64_ARGS + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-
-/* Only for 64-bit hosts at the moment. */
-DEF(qemu_ld_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
+DEF(qemu_ld, 1, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
+DEF(qemu_st, 0, 2, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
+DEF(qemu_ld2, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
+DEF(qemu_st2, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
 
 /* Host vector support.  */
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index ba52a5de68..e24e1f419c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3168,21 +3168,14 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_orc_vec:
             done = fold_orc(&ctx, op);
             break;
-        case INDEX_op_qemu_ld_i32:
+        case INDEX_op_qemu_ld:
             done = fold_qemu_ld_1reg(&ctx, op);
             break;
-        case INDEX_op_qemu_ld_i64:
-            if (TCG_TARGET_REG_BITS == 64) {
-                done = fold_qemu_ld_1reg(&ctx, op);
-                break;
-            }
-            QEMU_FALLTHROUGH;
-        case INDEX_op_qemu_ld_i128:
+        case INDEX_op_qemu_ld2:
             done = fold_qemu_ld_2reg(&ctx, op);
             break;
-        case INDEX_op_qemu_st_i32:
-        case INDEX_op_qemu_st_i64:
-        case INDEX_op_qemu_st_i128:
+        case INDEX_op_qemu_st:
+        case INDEX_op_qemu_st2:
             done = fold_qemu_st(&ctx, op);
             break;
         case INDEX_op_rems:
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 0df8da7365..58d52edb32 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -88,28 +88,40 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
     return op;
 }
 
-static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
-                     TCGTemp *addr, MemOpIdx oi)
+static void gen_ldst1(TCGOpcode opc, TCGType type, TCGTemp *v,
+                      TCGTemp *addr, MemOpIdx oi)
 {
-    TCGOp *op;
-
-    if (vh) {
-        op = tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
-                         temp_arg(addr), oi);
-    } else {
-        op = tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
-    }
+    TCGOp *op = tcg_gen_op3(opc, type, temp_arg(v), temp_arg(addr), oi);
     TCGOP_FLAGS(op) = get_memop(oi) & MO_SIZE;
 }
 
-static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
+static void gen_ldst2(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
+                      TCGTemp *addr, MemOpIdx oi)
+{
+    TCGOp *op = tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
+                            temp_arg(addr), oi);
+    TCGOP_FLAGS(op) = get_memop(oi) & MO_SIZE;
+}
+
+static void gen_ld_i64(TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
 {
     if (TCG_TARGET_REG_BITS == 32) {
-        TCGTemp *vl = tcgv_i32_temp(TCGV_LOW(v));
-        TCGTemp *vh = tcgv_i32_temp(TCGV_HIGH(v));
-        gen_ldst(opc, TCG_TYPE_I64, vl, vh, addr, oi);
+        gen_ldst2(INDEX_op_qemu_ld2, TCG_TYPE_I64,
+                  tcgv_i32_temp(TCGV_LOW(v)), tcgv_i32_temp(TCGV_HIGH(v)),
+                  addr, oi);
     } else {
-        gen_ldst(opc, TCG_TYPE_I64, tcgv_i64_temp(v), NULL, addr, oi);
+        gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I64, tcgv_i64_temp(v), addr, oi);
+    }
+}
+
+static void gen_st_i64(TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        gen_ldst2(INDEX_op_qemu_st2, TCG_TYPE_I64,
+                  tcgv_i32_temp(TCGV_LOW(v)), tcgv_i32_temp(TCGV_HIGH(v)),
+                  addr, oi);
+    } else {
+        gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I64, tcgv_i64_temp(v), addr, oi);
     }
 }
 
@@ -236,8 +248,7 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     }
 
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst(INDEX_op_qemu_ld_i32, TCG_TYPE_I32,
-             tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr, oi);
     plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
 
@@ -292,8 +303,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    gen_ldst(INDEX_op_qemu_st_i32, TCG_TYPE_I32,
-             tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
@@ -340,7 +350,7 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     }
 
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, oi);
+    gen_ld_i64(val, addr, oi);
     plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
 
@@ -407,7 +417,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, oi);
+    gen_st_i64(val, addr, oi);
     plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
@@ -546,8 +556,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
-        gen_ldst(INDEX_op_qemu_ld_i128, TCG_TYPE_I128, tcgv_i64_temp(lo),
-                 tcgv_i64_temp(hi), addr, oi);
+        gen_ldst2(INDEX_op_qemu_ld2, TCG_TYPE_I128, tcgv_i64_temp(lo),
+                  tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(lo, lo);
@@ -575,8 +585,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             y = TCGV128_LOW(val);
         }
 
-        gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr,
-                     make_memop_idx(mop[0], idx));
+        gen_ld_i64(x, addr, make_memop_idx(mop[0], idx));
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(x, x);
@@ -592,8 +601,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             addr_p8 = tcgv_i64_temp(t);
         }
 
-        gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_p8,
-                     make_memop_idx(mop[1], idx));
+        gen_ld_i64(y, addr_p8, make_memop_idx(mop[1], idx));
         tcg_temp_free_internal(addr_p8);
 
         if (need_bswap) {
@@ -657,8 +665,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
-        gen_ldst(INDEX_op_qemu_st_i128, TCG_TYPE_I128,
-                 tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+        gen_ldst2(INDEX_op_qemu_st2, TCG_TYPE_I128,
+                  tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
@@ -685,8 +693,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             x = b;
         }
 
-        gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr,
-                     make_memop_idx(mop[0], idx));
+        gen_st_i64(x, addr, make_memop_idx(mop[0], idx));
 
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
             TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -700,12 +707,10 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
 
         if (b) {
             tcg_gen_bswap64_i64(b, y);
-            gen_ldst_i64(INDEX_op_qemu_st_i64, b, addr_p8,
-                         make_memop_idx(mop[1], idx));
+            gen_st_i64(b, addr_p8, make_memop_idx(mop[1], idx));
             tcg_temp_free_i64(b);
         } else {
-            gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_p8,
-                         make_memop_idx(mop[1], idx));
+            gen_st_i64(y, addr_p8, make_memop_idx(mop[1], idx));
         }
         tcg_temp_free_internal(addr_p8);
     } else {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 640efff4ba..e42a718e8c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2432,14 +2432,20 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_exit_tb:
     case INDEX_op_goto_tb:
     case INDEX_op_goto_ptr:
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_ld_i64:
-    case INDEX_op_qemu_st_i64:
         return true;
 
-    case INDEX_op_qemu_ld_i128:
-    case INDEX_op_qemu_st_i128:
+    case INDEX_op_qemu_ld:
+    case INDEX_op_qemu_st:
+        tcg_debug_assert(type <= TCG_TYPE_REG);
+        return true;
+
+    case INDEX_op_qemu_ld2:
+    case INDEX_op_qemu_st2:
+        if (TCG_TARGET_REG_BITS == 32) {
+            tcg_debug_assert(type == TCG_TYPE_I64);
+            return true;
+        }
+        tcg_debug_assert(type == TCG_TYPE_I128);
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
     case INDEX_op_add:
@@ -3007,12 +3013,10 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 }
                 i = 1;
                 break;
-            case INDEX_op_qemu_ld_i32:
-            case INDEX_op_qemu_st_i32:
-            case INDEX_op_qemu_ld_i64:
-            case INDEX_op_qemu_st_i64:
-            case INDEX_op_qemu_ld_i128:
-            case INDEX_op_qemu_st_i128:
+            case INDEX_op_qemu_ld:
+            case INDEX_op_qemu_st:
+            case INDEX_op_qemu_ld2:
+            case INDEX_op_qemu_st2:
                 {
                     const char *s_al, *s_op, *s_at;
                     MemOpIdx oi = op->args[k++];
diff --git a/tcg/tci.c b/tcg/tci.c
index b08288e7d3..700e672616 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -789,46 +789,33 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tb_ptr = ptr;
             break;
 
-        case INDEX_op_qemu_ld_i32:
+        case INDEX_op_qemu_ld:
             tci_args_rrm(insn, &r0, &r1, &oi);
             taddr = regs[r1];
             regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
             break;
 
-        case INDEX_op_qemu_ld_i64:
-            if (TCG_TARGET_REG_BITS == 64) {
-                tci_args_rrm(insn, &r0, &r1, &oi);
-                taddr = regs[r1];
-            } else {
-                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-                taddr = regs[r2];
-                oi = regs[r3];
-            }
-            tmp64 = tci_qemu_ld(env, taddr, oi, tb_ptr);
-            if (TCG_TARGET_REG_BITS == 32) {
-                tci_write_reg64(regs, r1, r0, tmp64);
-            } else {
-                regs[r0] = tmp64;
-            }
-            break;
-
-        case INDEX_op_qemu_st_i32:
+        case INDEX_op_qemu_st:
             tci_args_rrm(insn, &r0, &r1, &oi);
             taddr = regs[r1];
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
 
-        case INDEX_op_qemu_st_i64:
-            if (TCG_TARGET_REG_BITS == 64) {
-                tci_args_rrm(insn, &r0, &r1, &oi);
-                tmp64 = regs[r0];
-                taddr = regs[r1];
-            } else {
-                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-                tmp64 = tci_uint64(regs[r1], regs[r0]);
-                taddr = regs[r2];
-                oi = regs[r3];
-            }
+        case INDEX_op_qemu_ld2:
+            tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            taddr = regs[r2];
+            oi = regs[r3];
+            tmp64 = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            tci_write_reg64(regs, r1, r0, tmp64);
+            break;
+
+        case INDEX_op_qemu_st2:
+            tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            tmp64 = tci_uint64(regs[r1], regs[r0]);
+            taddr = regs[r2];
+            oi = regs[r3];
             tci_qemu_st(env, taddr, tmp64, oi, tb_ptr);
             break;
 
@@ -1056,23 +1043,21 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r2), str_r(r3));
         break;
 
-    case INDEX_op_qemu_ld_i64:
-    case INDEX_op_qemu_st_i64:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-            info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
-                               op_name, str_r(r0), str_r(r1),
-                               str_r(r2), str_r(r3));
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_ld:
+    case INDEX_op_qemu_st:
         tci_args_rrm(insn, &r0, &r1, &oi);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %x",
                            op_name, str_r(r0), str_r(r1), oi);
         break;
 
+    case INDEX_op_qemu_ld2:
+    case INDEX_op_qemu_st2:
+        tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1),
+                           str_r(r2), str_r(r3));
+        break;
+
     case 0:
         /* tcg_out_nop_fill uses zeros */
         if (insn == 0) {
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index efdc315a0d..f4a0b0e720 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2875,18 +2875,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld:
         tcg_out_qemu_ld(s, a0, a1, a2, ext);
         break;
-    case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, a0, a1, a2, ext);
         break;
-    case INDEX_op_qemu_ld_i128:
+    case INDEX_op_qemu_ld2:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], true);
         break;
-    case INDEX_op_qemu_st_i128:
+    case INDEX_op_qemu_st2:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
 
@@ -3342,15 +3340,13 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld_i128:
+    case INDEX_op_qemu_ld2:
         return C_O2_I1(r, r, r);
-    case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
-    case INDEX_op_qemu_st_i128:
+    case INDEX_op_qemu_st2:
         return C_O0_I3(rz, rz, r);
 
     case INDEX_op_add_vec:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 9540604d9f..6a7667113d 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2576,17 +2576,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld2:
         tcg_out_qemu_ld(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st:
         tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
-    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st2:
         tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
@@ -2602,13 +2602,13 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, q);
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld2:
         return C_O2_I1(e, p, q);
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st:
         return C_O0_I2(q, q);
-    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st2:
         return C_O0_I3(Q, p, q);
 
     case INDEX_op_st_vec:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7e896505ec..ad8bb40ecc 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2457,7 +2457,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     switch (memop & MO_SIZE) {
     case MO_8:
-        /* This is handled with constraints on INDEX_op_qemu_st_*_i32. */
+        /* This is handled with constraints on INDEX_op_qemu_st. */
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || datalo < 4);
         tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + h.seg,
                                  datalo, h.base, h.index, 0, h.ofs);
@@ -3552,34 +3552,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_ld:
+        tcg_out_qemu_ld(s, a0, -1, a1, a2, type);
         break;
-    case INDEX_op_qemu_ld_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I64);
-        }
-        break;
-    case INDEX_op_qemu_ld_i128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-        tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I128);
+    case INDEX_op_qemu_ld2:
+        tcg_out_qemu_ld(s, a0, a1, a2, args[3], type);
         break;
 
-    case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_st:
+        tcg_out_qemu_st(s, a0, -1, a1, a2, type);
         break;
-    case INDEX_op_qemu_st_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I64);
-        }
-        break;
-    case INDEX_op_qemu_st_i128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-        tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
+    case INDEX_op_qemu_st2:
+        tcg_out_qemu_st(s, a0, a1, a2, args[3], type);
         break;
 
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -4135,25 +4119,17 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, L);
 
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st:
         return (TCG_TARGET_REG_BITS == 32 && flags == MO_8
                 ? C_O0_I2(s, L)
                 : C_O0_I2(L, L));
 
-    case INDEX_op_qemu_ld_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O2_I1(r, r, L);
-
-    case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(L, L) : C_O0_I3(L, L, L);
-
-    case INDEX_op_qemu_ld_i128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    case INDEX_op_qemu_ld2:
         return C_O2_I1(r, r, L);
-    case INDEX_op_qemu_st_i128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    case INDEX_op_qemu_st2:
         return C_O0_I3(L, L, L);
 
     case INDEX_op_ld_vec:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 69b2a7660b..d4f65692dd 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2008,22 +2008,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a3 = args[3];
 
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_ld:
+        tcg_out_qemu_ld(s, a0, a1, a2, type);
         break;
-    case INDEX_op_qemu_ld_i64:
-        tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
-        break;
-    case INDEX_op_qemu_ld_i128:
+    case INDEX_op_qemu_ld2:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, true);
         break;
-    case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_st:
+        tcg_out_qemu_st(s, a0, a1, a2, type);
         break;
-    case INDEX_op_qemu_st_i64:
-        tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
-        break;
-    case INDEX_op_qemu_st_i128:
+    case INDEX_op_qemu_st2:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
         break;
 
@@ -2535,18 +2529,16 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_qemu_ld_i128:
+    case INDEX_op_qemu_ld2:
         return C_N2_I1(r, r, r);
 
-    case INDEX_op_qemu_st_i128:
+    case INDEX_op_qemu_st2:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
 
     case INDEX_op_ld_vec:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index b49fc955a6..e61cab814f 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2387,26 +2387,20 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_ld:
+        tcg_out_qemu_ld(s, a0, 0, a1, a2, type);
         break;
-    case INDEX_op_qemu_ld_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I64);
-        }
+    case INDEX_op_qemu_ld2:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+        tcg_out_qemu_ld(s, a0, a1, a2, args[3], type);
         break;
 
-    case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, a0, 0, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_st:
+        tcg_out_qemu_st(s, a0, 0, a1, a2, type);
         break;
-    case INDEX_op_qemu_st_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, a0, 0, a1, a2, TCG_TYPE_I64);
-        } else {
-            tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I64);
-        }
+    case INDEX_op_qemu_st2:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+        tcg_out_qemu_st(s, a0, a1, a2, args[3], type);
         break;
 
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -2421,14 +2415,14 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
-    case INDEX_op_qemu_ld_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
-    case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rz, r) : C_O0_I3(rz, rz, r);
+    case INDEX_op_qemu_ld2:
+        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r);
+    case INDEX_op_qemu_st2:
+        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(rz, rz, r);
 
     default:
         return C_NotImplemented;
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9cf24831df..bb26769d53 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3779,35 +3779,27 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
+    case INDEX_op_qemu_ld:
+        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], type);
         break;
-    case INDEX_op_qemu_ld_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I64);
-        } else {
+    case INDEX_op_qemu_ld2:
+        if (TCG_TARGET_REG_BITS == 32) {
             tcg_out_qemu_ld(s, args[0], args[1], args[2],
                             args[3], TCG_TYPE_I64);
+            break;
         }
-        break;
-    case INDEX_op_qemu_ld_i128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
         break;
 
-    case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
+    case INDEX_op_qemu_st:
+        tcg_out_qemu_st(s, args[0], -1, args[1], args[2], type);
         break;
-    case INDEX_op_qemu_st_i64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I64);
-        } else {
+    case INDEX_op_qemu_st2:
+        if (TCG_TARGET_REG_BITS == 32) {
             tcg_out_qemu_st(s, args[0], args[1], args[2],
                             args[3], TCG_TYPE_I64);
+            break;
         }
-        break;
-    case INDEX_op_qemu_st_i128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
@@ -4426,20 +4418,17 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
+    case INDEX_op_qemu_ld2:
+        return TCG_TARGET_REG_BITS == 64
+               ? C_N1O1_I1(o, m, r) : C_O2_I1(r, r, r);
 
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I3(r, r, r);
-
-    case INDEX_op_qemu_ld_i128:
-        return C_N1O1_I1(o, m, r);
-    case INDEX_op_qemu_st_i128:
-        return C_O0_I3(o, m, r);
+    case INDEX_op_qemu_st2:
+        return TCG_TARGET_REG_BITS == 64
+               ? C_O0_I3(o, m, r) : C_O0_I3(r, r, r);
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index bcfdb6c545..89c7736f9a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2633,17 +2633,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_ld:
+        tcg_out_qemu_ld(s, a0, a1, a2, type);
         break;
-    case INDEX_op_qemu_ld_i64:
-        tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
-        break;
-    case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
-        break;
-    case INDEX_op_qemu_st_i64:
-        tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
+    case INDEX_op_qemu_st:
+        tcg_out_qemu_st(s, a0, a1, a2, type);
         break;
 
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -2875,11 +2869,9 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
 
     case INDEX_op_st_vec:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e266c19829..652ce9023e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3133,22 +3133,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I32);
+    case INDEX_op_qemu_ld:
+        tcg_out_qemu_ld(s, args[0], args[1], args[2], type);
         break;
-    case INDEX_op_qemu_ld_i64:
-        tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I64);
+    case INDEX_op_qemu_st:
+        tcg_out_qemu_st(s, args[0], args[1], args[2], type);
         break;
-    case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, args[0], args[1], args[2], TCG_TYPE_I32);
-        break;
-    case INDEX_op_qemu_st_i64:
-        tcg_out_qemu_st(s, args[0], args[1], args[2], TCG_TYPE_I64);
-        break;
-    case INDEX_op_qemu_ld_i128:
+    case INDEX_op_qemu_ld2:
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
         break;
-    case INDEX_op_qemu_st_i128:
+    case INDEX_op_qemu_st2:
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
@@ -3600,15 +3594,13 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_st_i64:
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_ld_i128:
+    case INDEX_op_qemu_ld2:
         return C_O2_I1(o, m, r);
-    case INDEX_op_qemu_st_i128:
+    case INDEX_op_qemu_st2:
         return C_O0_I3(o, m, r);
 
     case INDEX_op_st_vec:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 37371019b4..2f23d713b7 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2063,17 +2063,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
+    case INDEX_op_qemu_ld:
+        tcg_out_qemu_ld(s, a0, a1, a2, type);
         break;
-    case INDEX_op_qemu_ld_i64:
-        tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
-        break;
-    case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
-        break;
-    case INDEX_op_qemu_st_i64:
-        tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
+    case INDEX_op_qemu_st:
+        tcg_out_qemu_st(s, a0, a1, a2, type);
         break;
 
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -2088,12 +2082,10 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
 
-    case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st:
         return C_O0_I2(rz, r);
 
     default:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1fb7575061..6b8f71f49e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -40,14 +40,14 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld:
         return C_O1_I1(r, r);
-    case INDEX_op_qemu_ld_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
-    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st:
         return C_O0_I2(r, r);
-    case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I3(r, r, r);
+    case INDEX_op_qemu_ld2:
+        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r);
+    case INDEX_op_qemu_st2:
+        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r);
 
     default:
         return C_NotImplemented;
@@ -1203,22 +1203,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_qemu_ld_i64:
-    case INDEX_op_qemu_st_i64:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
-            tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
-            break;
-        }
-        /* fall through */
-    case INDEX_op_qemu_ld_i32:
-    case INDEX_op_qemu_st_i32:
-        if (TCG_TARGET_REG_BITS == 64 && s->addr_type == TCG_TYPE_I32) {
-            tcg_out_ext32u(s, TCG_REG_TMP, args[1]);
-            tcg_out_op_rrm(s, opc, args[0], TCG_REG_TMP, args[2]);
-        } else {
-            tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
-        }
+    case INDEX_op_qemu_ld:
+    case INDEX_op_qemu_st:
+        tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_qemu_ld2:
+    case INDEX_op_qemu_st2:
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
+        tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
         break;
 
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-- 
2.43.0


