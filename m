Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC334C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1o-0005L5-QX; Sat, 12 Sep 2026 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1d-00057Q-Dc
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:02 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1b-0007M0-FH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:01 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so261468a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209118; x=1789813918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ygf2Zl0g6BnbyO67LPnE21FKGV2zc/L2pXRnAcrgPwg=;
 b=R/wX0BdZHOguKqVkrmylqywqAFeVj0h6og8YrLZ4lF+kiwGroSFS7jsCmdAUN/qFxh
 ZLD8E7YM1rDVJgKxzAkmOnfaDgIVcg/rYW9lF/Aeh8XDCSV0AHAYazqIbF15ytZ5BlZ2
 iDlZvZi593wnggLiqc15bNPckYxZzDuDHzJGtQ6x08VlWLoB4gWCM/8BEFogfC5dvUhV
 BcEXwodPs+vRvvYmhTPdCYVb2Is9THWpBFXbzZNM4fC0OEjTd3JBUaUHSGbW3pU2R67w
 jerSjD5+QyXc2Ydh+OWFWWBj0zk8KroOmmelbpJyLqi1p2Eoc9wO2ilhKRsabRkQ0R6p
 q1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209118; x=1789813918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ygf2Zl0g6BnbyO67LPnE21FKGV2zc/L2pXRnAcrgPwg=;
 b=OYmAAkgcEUFrawQ+GKjZUOQQEZMY/aVEc4sCjX1myRWUnt+jqwQh61L74bFGQNv5Bl
 zxdDrdB0iLOn9G4FgE+IRC2p6dG0btZo464yz/FF9u+4sLd94+WO4EIFk/UZen6swu1e
 xDnHKCr9EjnoQUvJrFG2dHla/3sTmsV8VhQtM2EGkqOx0zH3xuCNDs5OJUKFwYbB/xFZ
 LoqVuc/74/oSsySGUPN1l5TOmSe8C94ZpeiTR8gytS9ujws5L205s3P5wK4yuYRAHTnz
 V2EoATkeyxn/dNpT2igWDOtizXSOb5K6drO0jklgpIlwUsxcWWRu3n68hsRGxRjYMNV9
 35fQ==
X-Gm-Message-State: AFuF++ks9FG3mVy5zjEwG0/q4m3P0oRrd3HVB6XIqqrHZwwXByLlbzkb
 VWw5viMPeVMTXNajcyvLy7aGt8Ksu7g+3xTrssf1SyBFy+49vn+mxTog84M7llwk2DNCkAb/EzN
 rbfqbmnE=
X-Gm-Gg: AYBFou1cuJslP6irYU52C39yRG4KdfU3IZ5JXAqAUYGsmoIdVrTJZsHEBKtdaT3Tj4c
 /joeEPtBu3NQmvMGT38gNQINrSbJDEXzS/1kBJHp9me8CE1d0bA5Pn/SAXAk5fhVkVIVDrWOBLJ
 8etGbXNVuS4IvE6hyk5yWums0qQDhkGDDKmGFbHpT0yEy0VwShmc4i5EsanMweYoHOgZiB9kxz7
 C31lyWJby4xGvfCg3fD1iwKuBMZcx0NKXpVLzwo2grgjDzzf7o+XEiK4+MXYnEiumF3xnlzTQtb
 iv3nuDqBEyKTt9iZBbXoV7szHXyuwyS6VS7BL2CUiEaD/i5HFygeIJf1HaStDN4joeNvyyzpQkY
 vbtnttH+31UDwZy9tGaFDgQXqwqyXVDC44CQo8m3bRbAG9ZdUKp7jIXiVM9mYBy0n9aaWGYB1Jm
 Rt4K3rgl3HTQBUg0ZRDk/bfs5h7D+Cyyb8ZKgHph4d06LdG6ILPPw3JvTMUF6fylpE3nN1kpxN8
 fQL6SI=
X-Received: by 2002:a05:6300:6684:b0:3bf:9b3d:61bb with SMTP id
 adf61e73a8af0-3db0e1f7d7bmr4160977637.16.1789209118069; 
 Sat, 12 Sep 2026 03:31:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/82] tcg: Generic expansion of tcg_gen_remu_*
Date: Sat, 12 Sep 2026 00:30:35 -1000
Message-ID: <20260912103126.598030-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  2 -
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 75 ++++++++++-------------------------
 3 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cd9d6f17003..15c24010828 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -200,7 +199,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index d7fca267eea..b92fdc8126a 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -22,6 +22,7 @@ DEF_RRR(divu)
 DEF_RRR(mul)
 DEF_RRR(or)
 DEF_RRR(rem)
+DEF_RRR(remu)
 DEF_RRR(sar)
 DEF_RRR(shl)
 DEF_RRR(shr)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a01056fe3a7..4253e3eaaec 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -236,20 +236,6 @@ static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                        tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
-static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
-}
-
-static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -527,6 +513,27 @@ static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_remu, type, 0)) {
+        gen_op_ttt(INDEX_op_remu, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+            gen_op_ttt(INDEX_op_divu, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+            TCGTemp *zero = tcg_constant_internal(type, 0);
+            gen_op_ttttt(INDEX_op_divu2, type, tmp, dst, src1, zero, src2);
+        } else {
+            g_assert_not_reached();
+        }
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -703,26 +710,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
@@ -1583,26 +1570,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


