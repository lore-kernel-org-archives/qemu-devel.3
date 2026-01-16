Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F7FD4A5FB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaca-0002mc-6S; Thu, 15 Jan 2026 22:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacY-0002Z9-PH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:34 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacW-0006Lc-2N
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:34 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81ed3e6b8e3so765915b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534530; x=1769139330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YL8K4w4eoq6ZQBe1dCSf/NVOvfZzKR+JbdvjX67X7dA=;
 b=vu7X/2MiOdteKJRdBGY/Jf7rEolReWyvFudrfypBbIzWUHpKSUGpkh0J11zY2du8UH
 6X34RfsjEnErhoRg07eIRB1eL0fA2twZ+RdjmhwGzctDoQx9niEF3g57nuheQsZlMaUX
 JJOSXvR72hK9m7Xa6SxT2fmyWIUi8xWmXs/0LMFZJSRW4qftEGhDEcJ2jrD8EycT7b/y
 n/yLxztGy2tapFic9a/Qy6Ipnj9XSsVRCHECGAAfR4rts3R2mqjIYp5t9Rps5kS8Otwz
 LxiRx9lg22IoPXAuXR53pV/yLVRZ4x2/iTIE1cYFivPNpuoIVVtI2N2svgaU7SdsY3xR
 TwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534530; x=1769139330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YL8K4w4eoq6ZQBe1dCSf/NVOvfZzKR+JbdvjX67X7dA=;
 b=MayzKenHw8OqB6GcZrD0ga1aAVVN3uRxTXT7XvqQ1zBCd8uSm8NvtXhE+HUZYvaA3k
 aG1Bre8NzdaAjiYmtDqQnYIuLNkAGq7RgL/fLU7gKR8Q5Q0vccpcToayPUd6LcKY4r+O
 KaZByJ90N5hWt89X3q/vfquc2ni+A2errCCx9gq5KuNJ9HDLpkIpVFd8pcLIN0OL8SFE
 Z5Et69uWkfwOqHDZlatyvpxJlt/bcJi4vte4oQfLo9f+fFgU0jMzH5ZBjq1WpndF1yN8
 Xjd8hLFQHWvy2GqoRy/VuXKp7IoBbHbVe+Nen0Cn1igYcdHA/t+Nsn+0zVA6EQYm6DNM
 PkEA==
X-Gm-Message-State: AOJu0YwwaDLW4Z1dFSALM58xCmti1NUcgfYx+owGIcNc2fZ3XRIt2BNs
 m79DGNIFs2X5vSCg4utdbQGVLw2VDmc9OZNYr4DG74ElFX/hmLW6fNOYQHTu1gKnDNN7+F+ZSSr
 uMyFKU1t03siE
X-Gm-Gg: AY/fxX7DSnU7VWMEFLj+KjV3v0biSiWmwR3txTMc7kK/h06QuSxIZ0EyD5aZ9hZdCXT
 krKVxUnGtE39mMkn0oenWUt0SwAwxmS6/JSHgWanp3S05M9p+fxzCAAICtRPUAL926GigpKf09J
 lqvE+X/Z27gyywoiy3nkADxxqIxdFRwGeufFR3sav5+qzYpRPgoW/FpZH2m3xLLCkRwhmr3usT8
 FzcNQNhYDjLSmdfyVDbqCPs+LxKsJn/sqqRTOUj46hBwF8q72mvE6wVgUefL+R49jjKFJWjvgTc
 kI1O0fzbguIxScm0gC0Rn0gnMGSYxXGlEZzlXfDdHEMXtlg+AlTUKIXiuGgtwuxm/yY3xHxWGDR
 GZfLG/4XcPUzTQ4vBDTWVXINz7pbvr31kLogNnjRWDgwTOhrm46w6Sd1Jb+75hVVitvovtfvERa
 Dh3ACegE+h047nI6tygg==
X-Received: by 2002:a05:6a00:c8d:b0:7e8:4471:8e2 with SMTP id
 d2e1a72fcca58-81fa1882721mr1175983b3a.67.1768534530328; 
 Thu, 15 Jan 2026 19:35:30 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 35/58] tcg: Drop TCG_TARGET_REG_BITS tests in tcg.c
Date: Fri, 16 Jan 2026 14:32:41 +1100
Message-ID: <20260116033305.51162-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 216 +++++++++---------------------------------------------
 1 file changed, 36 insertions(+), 180 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2b3bcbe750..e7bf4dad4e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -215,10 +215,8 @@ static void * const qemu_ld_helpers[MO_SSIZE + 1] __attribute__((unused)) = {
     [MO_SW] = helper_ldsw_mmu,
     [MO_UL] = helper_ldul_mmu,
     [MO_UQ] = helper_ldq_mmu,
-#if TCG_TARGET_REG_BITS == 64
     [MO_SL] = helper_ldsl_mmu,
     [MO_128] = helper_ld16_mmu,
-#endif
 };
 
 static void * const qemu_st_helpers[MO_SIZE + 1] __attribute__((unused)) = {
@@ -226,9 +224,7 @@ static void * const qemu_st_helpers[MO_SIZE + 1] __attribute__((unused)) = {
     [MO_16] = helper_stw_mmu,
     [MO_32] = helper_stl_mmu,
     [MO_64] = helper_stq_mmu,
-#if TCG_TARGET_REG_BITS == 64
     [MO_128] = helper_st16_mmu,
-#endif
 };
 
 typedef struct {
@@ -504,7 +500,6 @@ static void tcg_out_movext(TCGContext *s, TCGType dst_type, TCGReg dst,
         }
         break;
     case MO_UQ:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         if (dst_type == TCG_TYPE_I32) {
             tcg_out_extrl_i64_i32(s, dst, src);
         } else {
@@ -1113,7 +1108,6 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
-#if TCG_TARGET_REG_BITS == 64
 /*
  * We require these functions for slow-path function calls.
  * Adapt them generically for opcode output.
@@ -1148,7 +1142,6 @@ static const TCGOutOpUnary outop_extrl_i64_i32 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = TCG_TARGET_HAS_extr_i64_i32 ? tgen_extrl_i64_i32 : NULL,
 };
-#endif
 
 static const TCGOutOp outop_goto_ptr = {
     .static_constraint = C_O0_I1(r),
@@ -1360,11 +1353,7 @@ void tcg_pool_reset(TCGContext *s)
  * the helpers, with the end result that it's easier to build manually.
  */
 
-#if TCG_TARGET_REG_BITS == 32
-# define dh_typecode_ttl  dh_typecode_i32
-#else
-# define dh_typecode_ttl  dh_typecode_i64
-#endif
+#define dh_typecode_ttl  dh_typecode_i64
 
 static TCGHelperInfo info_helper_ld32_mmu = {
     .flags = TCG_CALL_NO_WG,
@@ -1615,17 +1604,12 @@ static void init_call_layout(TCGHelperInfo *info)
         break;
     case dh_typecode_i32:
     case dh_typecode_s32:
+    case dh_typecode_i64:
+    case dh_typecode_s64:
     case dh_typecode_ptr:
         info->nr_out = 1;
         info->out_kind = TCG_CALL_RET_NORMAL;
         break;
-    case dh_typecode_i64:
-    case dh_typecode_s64:
-        info->nr_out = 64 / TCG_TARGET_REG_BITS;
-        info->out_kind = TCG_CALL_RET_NORMAL;
-        /* Query the last register now to trigger any assert early. */
-        tcg_target_call_oarg_reg(info->out_kind, info->nr_out - 1);
-        break;
     case dh_typecode_i128:
         info->nr_out = 128 / TCG_TARGET_REG_BITS;
         info->out_kind = TCG_TARGET_CALL_RET_I128;
@@ -1705,11 +1689,7 @@ static void init_call_layout(TCGHelperInfo *info)
                 layout_arg_even(&cum);
                 /* fall through */
             case TCG_CALL_ARG_NORMAL:
-                if (TCG_TARGET_REG_BITS == 32) {
-                    layout_arg_normal_n(&cum, info, 2);
-                } else {
-                    layout_arg_1(&cum, info, TCG_CALL_ARG_NORMAL);
-                }
+                layout_arg_1(&cum, info, TCG_CALL_ARG_NORMAL);
                 break;
             default:
                 qemu_build_not_reached();
@@ -2002,11 +1982,8 @@ static TCGTemp *tcg_global_alloc(TCGContext *s)
 static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
                                             TCGReg reg, const char *name)
 {
-    TCGTemp *ts;
+    TCGTemp *ts = tcg_global_alloc(s);
 
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-
-    ts = tcg_global_alloc(s);
     ts->base_type = type;
     ts->type = type;
     ts->kind = TEMP_FIXED;
@@ -2040,48 +2017,20 @@ static TCGTemp *tcg_global_mem_new_internal(TCGv_ptr base, intptr_t offset,
         /* We do not support double-indirect registers.  */
         tcg_debug_assert(!base_ts->indirect_reg);
         base_ts->indirect_base = 1;
-        s->nb_indirects += (TCG_TARGET_REG_BITS == 32 && type == TCG_TYPE_I64
-                            ? 2 : 1);
+        s->nb_indirects += 1;
         indirect_reg = 1;
         break;
     default:
         g_assert_not_reached();
     }
 
-    if (TCG_TARGET_REG_BITS == 32 && type == TCG_TYPE_I64) {
-        TCGTemp *ts2 = tcg_global_alloc(s);
-        char buf[64];
-
-        ts->base_type = TCG_TYPE_I64;
-        ts->type = TCG_TYPE_I32;
-        ts->indirect_reg = indirect_reg;
-        ts->mem_allocated = 1;
-        ts->mem_base = base_ts;
-        ts->mem_offset = offset;
-        pstrcpy(buf, sizeof(buf), name);
-        pstrcat(buf, sizeof(buf), "_0");
-        ts->name = strdup(buf);
-
-        tcg_debug_assert(ts2 == ts + 1);
-        ts2->base_type = TCG_TYPE_I64;
-        ts2->type = TCG_TYPE_I32;
-        ts2->indirect_reg = indirect_reg;
-        ts2->mem_allocated = 1;
-        ts2->mem_base = base_ts;
-        ts2->mem_offset = offset + 4;
-        ts2->temp_subindex = 1;
-        pstrcpy(buf, sizeof(buf), name);
-        pstrcat(buf, sizeof(buf), "_1");
-        ts2->name = strdup(buf);
-    } else {
-        ts->base_type = type;
-        ts->type = type;
-        ts->indirect_reg = indirect_reg;
-        ts->mem_allocated = 1;
-        ts->mem_base = base_ts;
-        ts->mem_offset = offset;
-        ts->name = name;
-    }
+    ts->base_type = type;
+    ts->type = type;
+    ts->indirect_reg = indirect_reg;
+    ts->mem_allocated = 1;
+    ts->mem_base = base_ts;
+    ts->mem_offset = offset;
+    ts->name = name;
     return ts;
 }
 
@@ -2128,14 +2077,12 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
 
     switch (type) {
     case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
         n = 1;
         break;
-    case TCG_TYPE_I64:
-        n = 64 / TCG_TARGET_REG_BITS;
-        break;
     case TCG_TYPE_I128:
         n = 128 / TCG_TARGET_REG_BITS;
         break;
@@ -2300,43 +2247,13 @@ TCGTemp *tcg_constant_internal(TCGType type, int64_t val)
 
     ts = g_hash_table_lookup(h, &val);
     if (ts == NULL) {
-        int64_t *val_ptr;
-
         ts = tcg_temp_alloc(s);
-
-        if (TCG_TARGET_REG_BITS == 32 && type == TCG_TYPE_I64) {
-            TCGTemp *ts2 = tcg_temp_alloc(s);
-
-            tcg_debug_assert(ts2 == ts + 1);
-
-            ts->base_type = TCG_TYPE_I64;
-            ts->type = TCG_TYPE_I32;
-            ts->kind = TEMP_CONST;
-            ts->temp_allocated = 1;
-
-            ts2->base_type = TCG_TYPE_I64;
-            ts2->type = TCG_TYPE_I32;
-            ts2->kind = TEMP_CONST;
-            ts2->temp_allocated = 1;
-            ts2->temp_subindex = 1;
-
-            /*
-             * Retain the full value of the 64-bit constant in the low
-             * part, so that the hash table works.  Actual uses will
-             * truncate the value to the low part.
-             */
-            ts[HOST_BIG_ENDIAN].val = val;
-            ts[!HOST_BIG_ENDIAN].val = val >> 32;
-            val_ptr = &ts[HOST_BIG_ENDIAN].val;
-        } else {
-            ts->base_type = type;
-            ts->type = type;
-            ts->kind = TEMP_CONST;
-            ts->temp_allocated = 1;
-            ts->val = val;
-            val_ptr = &ts->val;
-        }
-        g_hash_table_insert(h, val_ptr, ts);
+        ts->base_type = type;
+        ts->type = type;
+        ts->kind = TEMP_CONST;
+        ts->temp_allocated = 1;
+        ts->val = val;
+        g_hash_table_insert(h, &ts->val, ts);
     }
 
     return ts;
@@ -2405,10 +2322,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     switch (type) {
     case TCG_TYPE_I32:
-        has_type = true;
-        break;
     case TCG_TYPE_I64:
-        has_type = TCG_TARGET_REG_BITS == 64;
+        has_type = true;
         break;
     case TCG_TYPE_V64:
         has_type = TCG_TARGET_HAS_v64;
@@ -2443,10 +2358,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_qemu_ld2:
     case INDEX_op_qemu_st2:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_debug_assert(type == TCG_TYPE_I64);
-            return true;
-        }
         tcg_debug_assert(type == TCG_TYPE_I128);
         goto do_lookup;
 
@@ -2479,7 +2390,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-        return TCG_TARGET_REG_BITS == 64;
+        return true;
 
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
@@ -2792,11 +2703,9 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
         case TCG_TYPE_I32:
             snprintf(buf, buf_size, "$0x%x", (int32_t)ts->val);
             break;
-#if TCG_TARGET_REG_BITS > 32
         case TCG_TYPE_I64:
             snprintf(buf, buf_size, "$0x%" PRIx64, ts->val);
             break;
-#endif
         case TCG_TYPE_V64:
         case TCG_TYPE_V128:
         case TCG_TYPE_V256:
@@ -5654,8 +5563,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-        assert(TCG_TARGET_REG_BITS == 64);
-        /* fall through */
     case INDEX_op_ctpop:
     case INDEX_op_neg:
     case INDEX_op_not:
@@ -6179,9 +6086,7 @@ static int tcg_out_helper_stk_ofs(TCGType type, unsigned slot)
      * Each stack slot is TCG_TARGET_LONG_BITS.  If the host does not
      * require extension to uint64_t, adjust the address for uint32_t.
      */
-    if (HOST_BIG_ENDIAN &&
-        TCG_TARGET_REG_BITS == 64 &&
-        type == TCG_TYPE_I32) {
+    if (HOST_BIG_ENDIAN && type == TCG_TYPE_I32) {
         ofs += 4;
     }
     return ofs;
@@ -6390,13 +6295,8 @@ static unsigned tcg_out_helper_add_mov(TCGMovExtend *mov,
         return 1;
     }
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        assert(dst_type == TCG_TYPE_I64);
-        reg_mo = MO_32;
-    } else {
-        assert(dst_type == TCG_TYPE_I128);
-        reg_mo = MO_64;
-    }
+    assert(dst_type == TCG_TYPE_I128);
+    reg_mo = MO_64;
 
     mov[0].dst = loc[HOST_BIG_ENDIAN].arg_slot;
     mov[0].src = lo;
@@ -6442,26 +6342,10 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     next_arg = 1;
 
     loc = &info->in[next_arg];
-    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I32) {
-        /*
-         * 32-bit host with 32-bit guest: zero-extend the guest address
-         * to 64-bits for the helper by storing the low part, then
-         * load a zero for the high part.
-         */
-        tcg_out_helper_add_mov(mov, loc + HOST_BIG_ENDIAN,
-                               TCG_TYPE_I32, TCG_TYPE_I32,
-                               ldst->addr_reg, -1);
-        tcg_out_helper_load_slots(s, 1, mov, parm);
-
-        tcg_out_helper_load_imm(s, loc[!HOST_BIG_ENDIAN].arg_slot,
-                                TCG_TYPE_I32, 0, parm);
-        next_arg += 2;
-    } else {
-        nmov = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
-                                      ldst->addr_reg, -1);
-        tcg_out_helper_load_slots(s, nmov, mov, parm);
-        next_arg += nmov;
-    }
+    nmov = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
+                                  ldst->addr_reg, -1);
+    tcg_out_helper_load_slots(s, nmov, mov, parm);
+    next_arg += nmov;
 
     switch (info->out_kind) {
     case TCG_CALL_RET_NORMAL:
@@ -6503,13 +6387,8 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
     int ofs_slot0;
 
     switch (ldst->type) {
-    case TCG_TYPE_I64:
-        if (TCG_TARGET_REG_BITS == 32) {
-            break;
-        }
-        /* fall through */
-
     case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
         mov[0].dst = ldst->datalo_reg;
         mov[0].src = tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, 0);
         mov[0].dst_type = ldst->type;
@@ -6526,7 +6405,7 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
          * helper functions.
          */
         if (load_sign || !(mop & MO_SIGN)) {
-            if (TCG_TARGET_REG_BITS == 32 || ldst->type == TCG_TYPE_I32) {
+            if (ldst->type == TCG_TYPE_I32) {
                 mov[0].src_ext = MO_32;
             } else {
                 mov[0].src_ext = MO_64;
@@ -6538,7 +6417,6 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
         return;
 
     case TCG_TYPE_I128:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         ofs_slot0 = TCG_TARGET_CALL_STACK_OFFSET;
         switch (TCG_TARGET_CALL_RET_I128) {
         case TCG_CALL_RET_NORMAL:
@@ -6568,14 +6446,14 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
         tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, HOST_BIG_ENDIAN);
     mov[0].dst_type = TCG_TYPE_REG;
     mov[0].src_type = TCG_TYPE_REG;
-    mov[0].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
+    mov[0].src_ext = MO_64;
 
     mov[1].dst = ldst->datahi_reg;
     mov[1].src =
         tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, !HOST_BIG_ENDIAN);
     mov[1].dst_type = TCG_TYPE_REG;
     mov[1].src_type = TCG_TYPE_REG;
-    mov[1].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
+    mov[1].src_ext = MO_64;
 
     tcg_out_movext2(s, mov, mov + 1, parm->ntmp ? parm->tmp[0] : -1);
 }
@@ -6616,24 +6494,10 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     /* Handle addr argument. */
     loc = &info->in[next_arg];
     tcg_debug_assert(s->addr_type <= TCG_TYPE_REG);
-    if (TCG_TARGET_REG_BITS == 32) {
-        /*
-         * 32-bit host (and thus 32-bit guest): zero-extend the guest address
-         * to 64-bits for the helper by storing the low part.  Later,
-         * after we have processed the register inputs, we will load a
-         * zero for the high part.
-         */
-        tcg_out_helper_add_mov(mov, loc + HOST_BIG_ENDIAN,
-                               TCG_TYPE_I32, TCG_TYPE_I32,
+    n = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
                                ldst->addr_reg, -1);
-        next_arg += 2;
-        nmov += 1;
-    } else {
-        n = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
-                                   ldst->addr_reg, -1);
-        next_arg += n;
-        nmov += n;
-    }
+    next_arg += n;
+    nmov += n;
 
     /* Handle data argument. */
     loc = &info->in[next_arg];
@@ -6649,7 +6513,6 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         break;
 
     case TCG_CALL_ARG_BY_REF:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         tcg_debug_assert(data_type == TCG_TYPE_I128);
         tcg_out_st(s, TCG_TYPE_I64,
                    HOST_BIG_ENDIAN ? ldst->datahi_reg : ldst->datalo_reg,
@@ -6678,12 +6541,6 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         g_assert_not_reached();
     }
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* Zero extend the address by loading a zero for the high part. */
-        loc = &info->in[1 + !HOST_BIG_ENDIAN];
-        tcg_out_helper_load_imm(s, loc->arg_slot, TCG_TYPE_I32, 0, parm);
-    }
-
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
 
@@ -6791,7 +6648,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 
         switch (opc) {
         case INDEX_op_extrl_i64_i32:
-            assert(TCG_TARGET_REG_BITS == 64);
             /*
              * If TCG_TYPE_I32 is represented in some canonical form,
              * e.g. zero or sign-extended, then emit as a unary op.
-- 
2.43.0


