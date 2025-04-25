Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFA8C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R8m-00072d-Vi; Fri, 25 Apr 2025 18:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7i-0005HS-Mi
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:19 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7d-0001MM-Oe
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:18 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301c4850194so2291720a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618532; x=1746223332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+pz6yxa81gfLFrwBQxKDMPpsteNfJlM4WV6rcsK/aw=;
 b=Ay6FpXzhLYBw7uhfI/jBzje5e7IJk7dT4Nn6orbywJda4311U+f7W3oLPnlNt+ag/a
 TEYxAlYyP30Qq9pZZWnmMmveWsZ8WKepAim05EYCfmwaYj+OywmwUelWw1YgEqLN96ZP
 UrEuAePsiVw2qnX9z9PdQJCdvIlm1rupgCaXRwokyuZH77feYJ8R+QRhR/FOInwcBdlm
 iB1XCnYZitUiFXAavwQgr+kBR55zNukIqOQ5k2PK9Xgvu4yX8mbZDKgZT4b9q1bHExgV
 KrdLNbntSwhU/aiC/eQknKbQeK1djTDOa4/NlDmMWcCIRSVD3sy+ectZ4yE5Lj6AmrLr
 xMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618532; x=1746223332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+pz6yxa81gfLFrwBQxKDMPpsteNfJlM4WV6rcsK/aw=;
 b=iwVCS4WZYxybwXe7ry1tmoWM6JwcCwVIoIDNXObRHKGyWPwWAcRoftvSqn+yc4I+l6
 ULSJLFbwytaVx6Nze5gqZYszhkvNtP2cW9CQP71QA2TTAg7LumhtUqmgSiZ1CSVCRhSr
 3mjDgY0AXgjqf0Q66UGcwyvelesKaY0AeCW8UG5aX8PcGBsMe17DiTLoRz6jjP8U1bT4
 EUDxGn22oMYfSZtIPmcffbFv5MVzURLKMmC7RQig34KOxEQ2fgbTSfBXHcBUeklE2yQQ
 gnT8hAa2rFDZpD22bJ1EuDUiKilmLhHWIDUwtZuSx04nAU/R6Gsk52u5e9j75ywNCLe4
 Rx8g==
X-Gm-Message-State: AOJu0Ywg52G8j8/QrFfX95XxPr8BLTSCusRB7CGebbPWiTYwv9H2lkSz
 FW1PymaZPUOZXyBGBhSYJDPL/inrmucyFMavb7sT9Y5cBxsOPphmhPtQV8RBNIZJJKF0YcXg11O
 I
X-Gm-Gg: ASbGncvYlvbu34ifa8aOKkY1kkTCLup6W2KZbghbhW2emOH1mYM9YguDg3tXKRgzxVB
 iNtKGOwoFEQa6zBVT5pA91kgsooOnvGoasK6rINXnmILWCBmPHdYa/amC/NNCODxZPFr++STGpT
 fweAZTi4JgWhAyA/lq6HNJNpeaXnreqi+SH8HKQr466W/LNy7GqU8ieOi02htWiZPeb9xHZrhqO
 7jCoauA3nslNhYU5pKiRAw1Ph6WHhSMT8/itEHx88MB89rQgLmMHiEd90kPjyBdACvgMDonp3Aq
 JK7DTL4z/kAiFx5kqc854Xd1peiaZJbaHgfittV4X6hWLrrMBmBr3AQvNkONg6V+sG85tesp8sQ
 =
X-Google-Smtp-Source: AGHT+IE876rw1wYGaJeT1QUOVTCPg3M31sfpiYkTLATd03zFUhqKodlvNOyxPDKQafsVQHL1+7AVUQ==
X-Received: by 2002:a17:90b:2dc9:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-30a012ed068mr1614461a91.2.1745618531780; 
 Fri, 25 Apr 2025 15:02:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 101/159] tcg: Convert ext_i32_i64 to TCGOutOpUnary
Date: Fri, 25 Apr 2025 14:53:55 -0700
Message-ID: <20250425215454.886111-102-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 22 +++++++++++++++++++---
 tcg/aarch64/tcg-target.c.inc     |  2 --
 tcg/i386/tcg-target.c.inc        |  2 --
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  2 --
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  2 --
 tcg/sparc64/tcg-target.c.inc     |  2 --
 tcg/tci/tcg-target.c.inc         |  2 --
 10 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c7ce13cda0..6bce097eac 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1068,6 +1068,23 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
+#if TCG_TARGET_REG_BITS == 64
+/*
+ * We require these functions for slow-path function calls.
+ * Adapt them generically for opcode output.
+ */
+
+static void tgen_exts_i32_i64(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_exts_i32_i64(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_exts_i32_i64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_exts_i32_i64,
+};
+#endif
+
 /*
  * Register V as the TCGOutOp for O.
  * This verifies that V is of type T, otherwise give a nice compiler error.
@@ -1122,6 +1139,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
 #else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
+    OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
 #endif
 };
 
@@ -5412,9 +5430,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
-    case INDEX_op_ext_i32_i64:
-        tcg_out_exts_i32_i64(s, new_args[0], new_args[1]);
-        break;
     case INDEX_op_extu_i32_i64:
         tcg_out_extu_i32_i64(s, new_args[0], new_args[1]);
         break;
@@ -5477,6 +5492,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_bswap64:
+    case INDEX_op_ext_i32_i64:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 00400f6ea7..68f7a1cec2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3177,7 +3176,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6a5414ab3a..14b912beb7 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -4001,7 +4000,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2ea5234097..2a9c7fc10a 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1943,7 +1943,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2468,7 +2467,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld8u_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 56c58bf82d..e992a468eb 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2364,7 +2364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2391,7 +2390,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3d1ffa9130..fea767573c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -4270,7 +4269,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index dc2b487844..e5fe15c338 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2877,7 +2876,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_ext_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ab178bebc8..5c5a38c2c8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3471,7 +3470,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 0f2bec21e9..e93ef8e7f2 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1883,7 +1883,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     default:
         g_assert_not_reached();
@@ -1909,7 +1908,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 9ba108ef8d..ecff90404f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,7 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
@@ -1109,7 +1108,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
-- 
2.43.0


