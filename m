Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DE1C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pd-0002NR-LV; Mon, 17 Feb 2025 14:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ow-0001ut-JJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6os-0008Ji-Kw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f61b01630so88172355ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820616; x=1740425416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPVDesfkRpmTOWA3zfnP41neg542OwOsuYWNBsm3NxY=;
 b=jXFazzbZccK8wfoNoe1cAhHTW+HPCIE0qXGuZ1zKgu7drGKVKq4Ws1QbnwlS4Ag4Hm
 iGMhZ9Iko6+i9h46j6nDTQIhM0EHIkRk1nh39agQDqX3OMKzcHp1mV1zLSBeJ1ZanvTs
 21NbNIOh2dR1jZwf2hOPI6wIzL5Y4S7Ee1t9msbf5/HWovV7jet4MbeTquqDv6yVF6uy
 R8J2Q4MYrk2WY+2gpFQuLJlwIOUqiEg4+3GSTvkJH3WFZPHn5rkD5hgkbx4edhdp2vze
 nfO/TK7BPelS79r5aLaBTMUv5x9vGLqCrfPb674MsK+cxTpl7tMdngUQfYfzq4RUaM0R
 Rytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820616; x=1740425416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPVDesfkRpmTOWA3zfnP41neg542OwOsuYWNBsm3NxY=;
 b=bcJWF0f65QFb6FBb45ZFo0pzfbLKPhP55nniUIoxZHepzbDXwGfz7ibYnm8KD/+tJ4
 g/F73rimnRzPNwCeR6HzVRy9c4/VR9McJyTOtjF0wm8EwRyNjKa9OhX3d0TI/50oXbxs
 AzXL3Sk+8Upy6psyCUdl4iurKnQlaCfQJiT2WpIQrJxyxezR0XQ272t8qmsXy5RdKZRq
 T35Dfgrxd+l7Rgek96L60ZBYnu5qVqOy8dCcFxw233iJgSuHLjUSEpFHJkSQL2qbbMj8
 dT9MSRTTyAo752rnJ1mxwCkN2z/H4sxSxTKAWnzUSQGv/wvuc7N7i/raWJ2peW9TGqbq
 XVMQ==
X-Gm-Message-State: AOJu0YxeYT1vGvI73cKtFJ6aSe8V8zuTCVb8SVB9cy9EuIgcPaUgnxG0
 +VAywTkOFv5eyMyOwl4tokdsEFAoh2G+KSCtG1tenwkiWYiHyejXBocR/wjlnlVwJ36TnFtBZEI
 8
X-Gm-Gg: ASbGncvbheaR7BcDzbIavT47V83qnPdlNB1GvLa6hd1CPZ7Zb7woGuynwdF/ROMAUTS
 vFxnVsQ5BF5wXxKAoYCt9gLcJ6CQIGOgl8kON/uMvNEBztQVay1blfUdmmhP5fwZtzE+VrD5qc9
 3+XFOTXLMAFUephnDy5C8fKyUZQmB0BTsr2Mw/fI8Ky0PMdlFGdH1t3hKZJ0QRU7cbKqdxgOM8N
 ZU7DrX3T224E3Nez42vl1XsLT9uLHDQb6dQr5ZKdEM0U8tt3SC9MDQl0R7LzvewpTeYAvC3pzpd
 KsIiEXFj3ukvtJ0U9SvB0yDZu658xku5NiJI+bI3e7EVl6c=
X-Google-Smtp-Source: AGHT+IF9T96UW1RzaTH5UOvcNeogjX4Gm824llFjo2nEaG9W5n8mgz73s1EZGKUEm0/l2Je4MFziVw==
X-Received: by 2002:a05:6a00:3c84:b0:732:1ce5:4a4c with SMTP id
 d2e1a72fcca58-73262158d02mr16175151b3a.1.1739820616033; 
 Mon, 17 Feb 2025 11:30:16 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 07/27] tcg/mips: Drop addrhi from prepare_host_addr
Date: Mon, 17 Feb 2025 11:29:48 -0800
Message-ID: <20250217193009.2873875-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 tcg/mips/tcg-target.c.inc | 62 ++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index b1d512ca2a..153ce1f3c3 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1217,8 +1217,7 @@ bool tcg_target_has_memory_bswap(MemOp memop)
  * is required and fill in @h with the host address for the fast path.
  */
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
-                                           TCGReg addrlo, TCGReg addrhi,
-                                           MemOpIdx oi, bool is_ld)
+                                           TCGReg addr, MemOpIdx oi, bool is_ld)
 {
     TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
@@ -1245,8 +1244,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_AREG0, mask_off);
@@ -1254,11 +1252,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Extract the TLB index from the address into TMP3.  */
         if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
-            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addrlo,
+            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addr,
                            s->page_bits - CPU_TLB_ENTRY_BITS);
         } else {
-            tcg_out_dsrl(s, TCG_TMP3, addrlo,
-                         s->page_bits - CPU_TLB_ENTRY_BITS);
+            tcg_out_dsrl(s, TCG_TMP3, addr, s->page_bits - CPU_TLB_ENTRY_BITS);
         }
         tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
 
@@ -1288,48 +1285,35 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_opc_imm(s, (TCG_TARGET_REG_BITS == 32
                                 || addr_type == TCG_TYPE_I32
                                 ? OPC_ADDIU : OPC_DADDIU),
-                            TCG_TMP2, addrlo, s_mask - a_mask);
+                            TCG_TMP2, addr, s_mask - a_mask);
             tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP2);
         } else {
-            tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, addrlo);
+            tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, addr);
         }
 
         /* Zero extend a 32-bit guest address for a 64-bit host. */
         if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
-            tcg_out_ext32u(s, TCG_TMP2, addrlo);
-            addrlo = TCG_TMP2;
+            tcg_out_ext32u(s, TCG_TMP2, addr);
+            addr = TCG_TMP2;
         }
 
         ldst->label_ptr[0] = s->code_ptr;
         tcg_out_opc_br(s, OPC_BNE, TCG_TMP1, TCG_TMP0);
 
-        /* Load and test the high half tlb comparator.  */
-        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
-            /* delay slot */
-            tcg_out_ldst(s, OPC_LW, TCG_TMP0, TCG_TMP3, cmp_off + HI_OFF);
-
-            /* Load the tlb addend for the fast path.  */
-            tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
-
-            ldst->label_ptr[1] = s->code_ptr;
-            tcg_out_opc_br(s, OPC_BNE, addrhi, TCG_TMP0);
-        }
-
         /* delay slot */
         base = TCG_TMP3;
-        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP3, addrlo);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP3, addr);
     } else {
         if (a_mask && (use_mips32r6_instructions || a_bits != s_bits)) {
             ldst = new_ldst_label(s);
 
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addrlo;
-            ldst->addrhi_reg = addrhi;
+            ldst->addrlo_reg = addr;
 
             /* We are expecting a_bits to max out at 7, much lower than ANDI. */
             tcg_debug_assert(a_bits < 16);
-            tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, addrlo, a_mask);
+            tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, addr, a_mask);
 
             ldst->label_ptr[0] = s->code_ptr;
             if (use_mips32r6_instructions) {
@@ -1340,7 +1324,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             }
         }
 
-        base = addrlo;
+        base = addr;
         if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
             tcg_out_ext32u(s, TCG_REG_A0, base);
             base = TCG_REG_A0;
@@ -1460,14 +1444,13 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
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
 
     if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
         tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, data_type);
@@ -1547,14 +1530,13 @@ static void tcg_out_qemu_st_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
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
 
     if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
         tcg_out_qemu_st_direct(s, datalo, datahi, h.base, opc);
@@ -2096,24 +2078,24 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, 0, a1, 0, a2, TCG_TYPE_I32);
+        tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, a0, 0, a1, 0, a2, TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_ld(s, a0, a1, a2, 0, args[3], TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I64);
         }
         break;
 
     case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, a0, 0, a1, 0, a2, TCG_TYPE_I32);
+        tcg_out_qemu_st(s, a0, 0, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, a0, 0, a1, 0, a2, TCG_TYPE_I64);
+            tcg_out_qemu_st(s, a0, 0, a1, a2, TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_st(s, a0, a1, a2, 0, args[3], TCG_TYPE_I64);
+            tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I64);
         }
         break;
 
-- 
2.43.0


