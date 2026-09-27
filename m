Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDECC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklS-0004La-QQ; Sun, 27 Sep 2026 05:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkl-0002ZQ-F0
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:03 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkd-0007U3-7O
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:53 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0b6200eb0so1601490a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499649; x=1791104449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DtQYx3dsQ5ys5QZOCQ1b0rVnlyu98rfrUFFqBCqNXgo=;
 b=eLZ7LCZVSHdP5mHpuIIufQd5+pbve4V8S23g0ri+gfr9StdEN1xCRgvclNOQRmzshG
 8ACUBwOE3T8o0SVPv9PJfTqw1SeH2onkrRHY2rny+V0Nnd8rqEgb+dtde9CrSSuj6YzO
 N/FSB5vQpdN30pJxckh1z3sfjRUKVI0f3dkwYBlwuWSt7fTF1XBbqLvwNxT1M9Ys1iUl
 MPZu17hN7yvYnrKG4sIYGPXMvmxjDKwBt8dPLYPgebVjdKubO4EDhHjZp0EUjnQsOooA
 fGXkuYJqGpmJUnWHrcIbZVYLe/csvQkDkJdUcNMRoLHIpTpNYDJ6mcnYgh48Wz4oDw1i
 vZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499649; x=1791104449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DtQYx3dsQ5ys5QZOCQ1b0rVnlyu98rfrUFFqBCqNXgo=;
 b=WuEgmZOVULcx7FJFMZO4s+FKNFUHMxFdD5c65F8ozQHaTpyrDRKWO5EWJeUvg1v4MP
 4q8CUAdPy5GtwOsnpkbWdVnTQz/D9lbu192CD4sxTY9cw0d7eKBsFc5QZ/TuWLGiUab/
 ci4pFEQz+CSXkVYttACyNPMyuIZYMn3tMzwpE5z0J8En5k0llK4UIPIxuJ+Z57kM9BQz
 j/LhO/+/9ytOej8fhRYxUayh9ktNg1lk6GfdmHsa4yDhRXW1h7RyfYgLYsLCBfLy7lUO
 qNjYJw+6YQXeKBInpLrv7lyAcWkmNQ2YmYHCvLcDyz6unV0zSA/PHzvs+keP0x9CeGXW
 Rjqw==
X-Gm-Message-State: AFq9FYLoYroUZsAi0neSVWkEhnbppEugSKWVw7Z3TxVkZcuHHzzYRRJm
 ikqPhfWzIdxPJb+GqiHa2VWAAqFbhNCuLsau6fdMOiAu2yD8DlRSFTIaXjhdvxqKU+4Gb7PjWSg
 kUTSo
X-Gm-Gg: AYBFou0qbElFdK6Hylxz+oVamJVNOqRdbaHtVtAcph6A4nGq510MvVwfgbl2SqORiyZ
 VeU8zS8DVuyTcw2blm4ymLP6PIQGCJLH9jeBNH7COTQ2MyrU5FRE4FIXA64d/U/BYAwdbzxqvot
 l2cPKWXUjCbSRCD4pKNgskZWkvsf3LY+5CTOgdVxz0FMy3WV/zfKKxTipUziwQsTfQaIo/k+iyV
 G9mRvxCaOUgUKLx+tz6RW49cXPDz++pdlR0teTVmaZMKkLr0CGTAPlYwlQ075yRaPAIIIfJXhVB
 pRc/y1AiIW23oJYdPpGWqbcExUxTjrM1ZGcexdt1A4CW/XC4bYV13eFkvCt2CSUvs7AdeewSCJF
 JGrKjHU1bBsXcwS744iZo46tiSDjCrJv/6d0rDiG3lNxiTLyg/mpcVmPQhGOTFw04thAuJm1gIN
 47Skqnydo2EqZwp8ZBcljm8CTBREtop7AkmZzkjgFChtocLFHB0AyPFDXzDrRwDmGqWyNWKPkwE
 xNGNGQmBrkTD4qjA9DmWaSTJKUxOQ==
X-Received: by 2002:a17:90b:5110:b0:39e:6c6a:6579 with SMTP id
 98e67ed59e1d1-3a0bb6596a7mr5443301a91.60.1790499648951; 
 Sun, 27 Sep 2026 02:00:48 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 037/101] tcg: Generic expansion of tcg_gen_remu_*
Date: Sun, 27 Sep 2026 01:59:07 -0700
Message-ID: <20260927090011.10724-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 74 ++++++++++--------------------------
 3 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ce31b0d971d..0fa534f24d0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -202,7 +201,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1b108d9f147..cfa19a0a815 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(rem, TCGV, TCGV, TCGV)
+DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a4bdf1143e6..39b4bbb659e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -211,20 +211,6 @@ static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
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
@@ -520,6 +506,26 @@ void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_remu, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_remu, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+            tcg_gen_op_ttt(INDEX_op_divu, type, tmp, src1, src2);
+            tcg_gen_mul(type, tmp, tmp, src2);
+            tcg_gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+            tcg_gen_op_ttttt(INDEX_op_divu2, type, tmp, dst, src1,
+                             tcg_constant_internal(type, 0), src2);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -659,26 +665,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1539,26 +1525,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
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


