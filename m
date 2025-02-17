Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB6C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pP-00025O-OW; Mon, 17 Feb 2025 14:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ov-0001uK-0P
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6os-0008Jv-KJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:20 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22101839807so53310785ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820617; x=1740425417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q42Wl93XZQ8l+eIAXYd7qQ+kbojGHP8GopxWhwXIvfQ=;
 b=m29ZHx+Xfa62h3dRnxVOGRH4y6qea6FBcREgNfD2mI/cfQGF0RlNd8/GW+4id6+WVv
 7YCAvATVZ1dSKHxuHH1nbszyllvpAjkt4w6PUHCAnQQVy2UaYSHI5lBbzZtoUXd+db/Z
 50Qahjc0eRI4rGMg0+2H3DyR+iYsc5inAAqKMJrArrR/BcavCKxDZiTiE2YxV+BcYwJH
 xZ7LCu6QGcpZ2YnOO8JMga2iBLhzHAdI73g25ddIcuxTM4VVRNHS0Cw4BeKEBWKda0eW
 XEGQ8bfPI/bY/UIbrF2E7s9Myx56NI3hWlV6WWgIw0F7XVCISY8c4u976zp/8+CoyMrX
 SPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820617; x=1740425417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q42Wl93XZQ8l+eIAXYd7qQ+kbojGHP8GopxWhwXIvfQ=;
 b=I2ermArEsSQc0zZuGW+93fEEpaoF5qWrpxeeB/TQ1mQLJ3gt/Kx/Rrqe+CBzX/5L6o
 h9rVnenNYoWcN8108q2DsiaWnzmBTUcgA+1KCCQd/HTj+J2vRuQPXDgwfCDHGUN38v1d
 x1klAg+2U15CVpF7KbZ+KZYfZdb0wDkOhh2Aq0P6HEioEgxW+whSIeJHv2LTeowN4y7g
 jqIhuktWSVL/5r2vcUV2jYFL590qy2X6yG6AUw9b2QgcY1pSj4/eLQOuo281KSeJxWMv
 cmtMsj9YYP/Kq7mXxI5tod1aOY/ySvNE4V9YJMQLikJGY/GP7eoz+6A3Smr1N9jS2NDq
 4P6w==
X-Gm-Message-State: AOJu0Yzb8dKjiIzFnkS7A8BbIQjAbE2wuMNYLi+qRhL8fl9dzbWH+YQ+
 YnGOoCyxDvEPWDWmnQUW45fYhncacnIulYzN84a3bgpDYfpGr+/tTpGo1y1nehVn841+WR8U8Mv
 P
X-Gm-Gg: ASbGncvH0UsF/eOAGUB3w0rOVDO08xoOAYIX78UPECKOutrnkKjTkrnirb8HO+lThtY
 Eh9sB8GizK6r2XNRoPw2ywmFu5z0MofDQpp/MaJ78Ox/rvijluc/Sh+bU1q/2HFS50AR7jIH3F6
 J6mrRgZvyTSGM7SL3R6sIzPkJHOM2J+EoOGe+QXLdNp91v10i1uFP70PiyvjQHGaEJ55PHPXafN
 8+9y5n3Az49Yo8mYERjSHL+10WchU0RDNOADzUvylgaMJ6L3Z5OhtTbT401VKvhj1wtc1GWENxd
 ySOTt71L14T+4KazWrOB6klm+4qXoyB/D2oI4J0y9FO2SjM=
X-Google-Smtp-Source: AGHT+IFW/v2Sl4QRhVNWxjL4C27dtFe2gm9Ef0AAHinopOv7LLp8c0qup7L2g+i8YBXsqiKjvx5JzQ==
X-Received: by 2002:a05:6a20:6a05:b0:1ee:68e3:ff45 with SMTP id
 adf61e73a8af0-1ee8cbe4f98mr21908213637.35.1739820616717; 
 Mon, 17 Feb 2025 11:30:16 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 08/27] tcg/ppc: Drop addrhi from prepare_host_addr
Date: Mon, 17 Feb 2025 11:29:49 -0800
Message-ID: <20250217193009.2873875-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The guest address will now always fit in one register.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 75 ++++++++++++----------------------------
 1 file changed, 23 insertions(+), 52 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 801cb6f3cb..74b93f4b57 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2438,8 +2438,7 @@ bool tcg_target_has_memory_bswap(MemOp memop)
  * is required and fill in @h with the host address for the fast path.
  */
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
-                                           TCGReg addrlo, TCGReg addrhi,
-                                           MemOpIdx oi, bool is_ld)
+                                           TCGReg addr, MemOpIdx oi, bool is_ld)
 {
     TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
@@ -2474,8 +2473,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, mask_off);
@@ -2483,10 +2481,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Extract the page index, shifted into place for tlb index.  */
         if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_shri32(s, TCG_REG_R0, addrlo,
+            tcg_out_shri32(s, TCG_REG_R0, addr,
                            s->page_bits - CPU_TLB_ENTRY_BITS);
         } else {
-            tcg_out_shri64(s, TCG_REG_R0, addrlo,
+            tcg_out_shri64(s, TCG_REG_R0, addr,
                            s->page_bits - CPU_TLB_ENTRY_BITS);
         }
         tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
@@ -2534,10 +2532,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             if (a_bits < s_bits) {
                 a_bits = s_bits;
             }
-            tcg_out_rlw(s, RLWINM, TCG_REG_R0, addrlo, 0,
+            tcg_out_rlw(s, RLWINM, TCG_REG_R0, addr, 0,
                         (32 - a_bits) & 31, 31 - s->page_bits);
         } else {
-            TCGReg t = addrlo;
+            TCGReg t = addr;
 
             /*
              * If the access is unaligned, we need to make sure we fail if we
@@ -2566,30 +2564,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             }
         }
 
-        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
-            /* Low part comparison into cr7. */
-            tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                        0, 7, TCG_TYPE_I32);
-
-            /* Load the high part TLB comparator into TMP2.  */
-            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
-                       cmp_off + 4 * !HOST_BIG_ENDIAN);
-
-            /* Load addend, deferred for this case. */
-            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
-                       offsetof(CPUTLBEntry, addend));
-
-            /* High part comparison into cr6. */
-            tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_TMP2,
-                        0, 6, TCG_TYPE_I32);
-
-            /* Combine comparisons into cr0. */
-            tcg_out32(s, CRAND | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
-        } else {
-            /* Full comparison into cr0. */
-            tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                        0, 0, addr_type);
-        }
+        /* Full comparison into cr0. */
+        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2, 0, 0, addr_type);
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
         ldst->label_ptr[0] = s->code_ptr;
@@ -2601,12 +2577,11 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             ldst = new_ldst_label(s);
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addrlo;
-            ldst->addrhi_reg = addrhi;
+            ldst->addrlo_reg = addr;
 
             /* We are expecting a_bits to max out at 7, much lower than ANDI. */
             tcg_debug_assert(a_bits < 16);
-            tcg_out32(s, ANDI | SAI(addrlo, TCG_REG_R0, (1 << a_bits) - 1));
+            tcg_out32(s, ANDI | SAI(addr, TCG_REG_R0, (1 << a_bits) - 1));
 
             ldst->label_ptr[0] = s->code_ptr;
             tcg_out32(s, BC | BI(0, CR_EQ) | BO_COND_FALSE | LK);
@@ -2617,24 +2592,23 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
-        tcg_out_ext32u(s, TCG_REG_TMP2, addrlo);
+        tcg_out_ext32u(s, TCG_REG_TMP2, addr);
         h->index = TCG_REG_TMP2;
     } else {
-        h->index = addrlo;
+        h->index = addr;
     }
 
     return ldst;
 }
 
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, true);
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
 
     if (TCG_TARGET_REG_BITS == 32 && (opc & MO_SIZE) == MO_64) {
         if (opc & MO_BSWAP) {
@@ -2678,14 +2652,13 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
 }
 
 static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, false);
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
 
     if (TCG_TARGET_REG_BITS == 32 && (opc & MO_SIZE) == MO_64) {
         if (opc & MO_BSWAP) {
@@ -2729,7 +2702,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
     uint32_t insn;
     TCGReg index;
 
-    ldst = prepare_host_addr(s, &h, addr_reg, -1, oi, is_ld);
+    ldst = prepare_host_addr(s, &h, addr_reg, oi, is_ld);
 
     /* Compose the final address, as LQ/STQ have no indexing. */
     index = h.index;
@@ -3309,14 +3282,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
+        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, args[0], -1, args[1], -1,
-                            args[2], TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_ld(s, args[0], args[1], args[2], -1,
+            tcg_out_qemu_ld(s, args[0], args[1], args[2],
                             args[3], TCG_TYPE_I64);
         }
         break;
@@ -3326,14 +3298,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
+        tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, args[0], -1, args[1], -1,
-                            args[2], TCG_TYPE_I64);
+            tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_st(s, args[0], args[1], args[2], -1,
+            tcg_out_qemu_st(s, args[0], args[1], args[2],
                             args[3], TCG_TYPE_I64);
         }
         break;
-- 
2.43.0


