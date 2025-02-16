Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65C7C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnto-0003ZN-2h; Sun, 16 Feb 2025 18:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntE-0002Ul-M3
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:35 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntB-00062E-9m
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:32 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso76960235ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747847; x=1740352647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hjDYt4VjR+3BNoHgZQxKtHYfp9S1pCYd/9SNeEG9AA8=;
 b=XKVhGo0oLuFBWHGDf4sEUkXgHgVRpUiMyS/eGV3vOyd6ZTK6PcRZnG3u7biQdLi9yZ
 aYnPjmYDo6HPIDvIMddlu5dE3e0e5xhmGJ0CX2wBlLd7bM495ZarQ8fxPhO/cuwoB0E3
 b1vsA6Szr9CNbwXRMqU5QfiREsGwiGi7zsTTuCuPiRFIt4dlnQ4OIfRCzOcpuupVLqBl
 3CAQl+weajAmhv4emyTm5O187ONMZQevkbXgs8X2tsMB0CKq9NO0Aj42DkvKG4FeQbrE
 FDyTo+kcpg9DnoyibUz9fOuBlZ+3MNB6dtfzl9Y6gGEuaylaxcfg6+XkKOtiHBaq30mw
 Q0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747847; x=1740352647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjDYt4VjR+3BNoHgZQxKtHYfp9S1pCYd/9SNeEG9AA8=;
 b=fdGp8d3n4lB+ZYruPuqLw9LauPslmi93ovlv/S4+PCwprPXpjAols1mKdnEZcpjV7o
 oEL1qY6AX0z5a1Cq4xxcnRLlzr/20ReCUFMAsVACcoUN/zaSlo4XF5OhyJhoid7t4WQY
 a5p5oUiJNWfKgVYhJ/kRDlogGndMEphpnk20E05nqpRZLsVzgjC1VqY7UF5GOtZK4ZfP
 kKqqiRD1x+QJEZxkZBDXoK433hCGWf4rRf6VHUCaspLYzunbUQmX7mDmxC+Tl3OCO198
 A86OPg1suNN5TCT1rS0Wxf7sGhnjlCpE2rfUXijx1ArlUcm+FkBiPoLia0M+3rAHAhAh
 pjng==
X-Gm-Message-State: AOJu0YyYstlE9+sTm/AQ3AE1TSuFyCvCCdXEVJ0XHWWgWnbW4eatKT6z
 qkioWXDkuo3DrbOo/swT3yqTADuLSo5v6ZaH9DPD7BorVr+jXmm8VBhkKBLV8R9km4CHmbRTBa0
 M
X-Gm-Gg: ASbGncshtVMqVlx8/Y+Bk+IdVchZOe1BnR8Wdceab86LDhnnY+som7NZak73bfAjj6T
 +/NFa1j98v+xaHsEB1mdTxw3WKUxQ8Lho/YPTj39XH40JKphTeTJy/9qSiRfr29igqFV3xyXQi6
 4zNSYH5JJJtDZ7KvbMLFgINuVwi+lYShsZzhfHfPyyCmEsXGOoCCPbieFzcxt3PORzQkBi1HuNy
 BmQvDTwzr/ITUi8/czSZ3buSEJEu4125JRM2TPBdOy7nIlxOgcbRIcnoYC9GSV4NLX6VjFwpjkx
 hFTeEre3OLD8eXp2UoSrd5EtLhUbDP4KKSg+7/Y4H+E70i8=
X-Google-Smtp-Source: AGHT+IENHOvnBtNkGGJK2XHC5zlgI/COREjULT2SsCqp3KGYflooN8+fhn+1+yYbKdKvu2A6LV5b9A==
X-Received: by 2002:a17:903:2341:b0:21a:8d8c:450d with SMTP id
 d9443c01a7336-221040d11e4mr115727785ad.53.1739747847459; 
 Sun, 16 Feb 2025 15:17:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 097/162] tcg: Convert extu_i32_i64 to TCGOutOpUnary
Date: Sun, 16 Feb 2025 15:09:06 -0800
Message-ID: <20250216231012.2808572-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 15 ++++++++++++---
 tcg/aarch64/tcg-target.c.inc     |  2 --
 tcg/i386/tcg-target.c.inc        |  2 --
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  2 --
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  4 ----
 tcg/sparc64/tcg-target.c.inc     |  2 --
 tcg/tci/tcg-target.c.inc         |  2 --
 10 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index a0ee11d5fa..a247096582 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1083,6 +1083,16 @@ static const TCGOutOpUnary outop_exts_i32_i64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_exts_i32_i64,
 };
+
+static void tgen_extu_i32_i64(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_extu_i32_i64(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_extu_i32_i64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extu_i32_i64,
+};
 #endif
 
 /*
@@ -1140,6 +1150,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
 #else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
     OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
+    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
 #endif
 };
 
@@ -5424,9 +5435,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
-    case INDEX_op_extu_i32_i64:
-        tcg_out_extu_i32_i64(s, new_args[0], new_args[1]);
-        break;
     case INDEX_op_extrl_i64_i32:
         tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
         break;
@@ -5482,6 +5490,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 68f7a1cec2..44314f6a0f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -3176,7 +3175,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7bf677fdc3..ea43316121 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -4000,7 +3999,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
         return C_O1_I1(r, r);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e2dbd08e12..3a85b6f4ba 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1931,7 +1931,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2458,7 +2457,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 00d5bf6d43..2a2eab314e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2370,7 +2370,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2396,7 +2395,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index fea767573c..e1767f1d6c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -4269,7 +4268,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index e5fe15c338..48d4325097 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2873,7 +2872,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 5c5a38c2c8..d81b8fb8f4 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -3470,9 +3469,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_extu_i32_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e93ef8e7f2..d52907f7e3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1883,7 +1883,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     default:
         g_assert_not_reached();
     }
@@ -1908,7 +1907,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ecff90404f..3cf2913acd 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,7 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
@@ -1108,7 +1107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
-- 
2.43.0


