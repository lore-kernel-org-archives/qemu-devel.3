Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594F4C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kI-0003Hi-5t; Thu, 17 Sep 2026 00:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kB-0003Eo-Tb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:10 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k9-0006r9-Np
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:07 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so323974a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619344; x=1790224144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+Z8XRA5TTDfutp2SRTCbuug1pU8X6pmV724bFSBJdJ4=;
 b=g0gPWYwtoQvOixYQ4hdLxa5p4VOdM44VBExRLJ21iK58mISyeKOuGxc1vA7UUl9RQN
 ERcuenIVggsdxT3r0ARNxmBpXUB1DsTc/lClOzx8+UpWtOH/xBy7MAZt5s5oY48jDp0H
 9tXZCI6CISytXyFtnIkK51Q4cmJSRSK4UAXBZdoX9P5qDw3py4t658NajL3IrxVAEWPZ
 ufrIcwRbh8NX097UsROEZPI3IALpdp/X8aYiXcAuJsWqwPK/EPMPZ0IuMwv8s1g2uFlP
 7B5rzOYRTPL2zVgkR/eLVEjUaervgeR4RXhjXkOVXApOOOlZ8m8jIySB/Dqwh8M44rnI
 F4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619344; x=1790224144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+Z8XRA5TTDfutp2SRTCbuug1pU8X6pmV724bFSBJdJ4=;
 b=2PaBXzoCvAdIoooa4Zq0+lOxGccKBSQQiTRasGUTlpe2KwaYHm9Mday/ZpTN3eXWWt
 w7s/bU6ubVmBxqbA6rsEVNctMO0ANZSEJLpoc4uv5em3R910/E9HUr6IywB82gMFUX6a
 d6L1WDy4g0vjAMN9rFLnIxK6JlOGROem4QKLREU/87flVrAv/u5atCvPH4yR3A9FI2KE
 ImUnWMLr95dkCJ46DfS4S8d6gpecmY0D8veaWbOFr7hAww2lXEiQGbq064nJOpQg04oQ
 0sUozbUVCs/fN0G3Z4Q7mOk4pOJpyhdDsAOFQ11bxnyXh3hje+mDMk3FsbTouBcEkk7i
 WbxQ==
X-Gm-Message-State: AFuF++lzDHcqLq5CzLut8+Gy1s9NA/t8OFbnWEGPv6f0zmBplfGuhmjl
 Z7DNLoRfqtS7VoGggF+NbBdwJdHhPMLOTa9dzdE2sCV3iawn/IbMuWFXtUwemmx+1M+bstINnEC
 inHX4sd8=
X-Gm-Gg: AYBFou1G9oZt2KKmY2EOcgogQdmNmO1WZ39usHqizsx7HnUzhCGIXtsWJF7QFG6SSDU
 EfnX3vp2Phmuz4WAkPvaNrf7MAiinUMdR0O6QkL0cLwfg0GXksF42mce/bDlX5pUyWTI3F+tec4
 t42IOhhO8iuegiYX7h3T+OdVsO6ktTGchxc64bXzEliI+6v2DGmUWO5VeaOZde4q9LedAP08KjA
 EbdgRaN0j8m3aG7rkF4M13z+eXFJ8M0F827ymedL8wwvLNz6g6u624PEkEuuHruyKpy6eIMTcjZ
 KNpWVLCjO2EndJYarD6zoTXanbhxbEp6J7JtOuRA/5diAtNYGzJMrUi+nLIYN8ulFC+e9oRGNuY
 biV/XHxhLdrRBVi9r05Hr1VJHqex/f7KuIJwgF5o7UG/ZggZtwL2/YUESlUwtBt6W01kDRC7xOP
 MTXpqCEhZImiXQ5MY9heZoffAVgvMoNF2/MXIp8qNImmk5pa4nQr2ccmW0Bp6sVIx4TLgHzx7o1
 J6lCuk=
X-Received: by 2002:a17:90a:290:b0:39e:2f57:67ca with SMTP id
 98e67ed59e1d1-39e2f5848c2mr4729416a91.0.1789619344098; 
 Wed, 16 Sep 2026 21:29:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.29.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:29:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 036/101] tcg: Generic expansion of tcg_gen_divu_*
Date: Wed, 16 Sep 2026 18:27:18 -1000
Message-ID: <20260917042823.542588-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++------------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6223d46b199..05b4bee34ce 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 67261d12741..e67f11176d8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
+DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8ec4e38fae2..9bc7446915b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -474,6 +474,20 @@ static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+        gen_op_ttt(INDEX_op_divu, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        gen_op_ttttt(INDEX_op_divu2, type, dst, tmp, src1,
+                     tcg_constant_internal(type, 0), src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -693,20 +707,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
@@ -1587,20 +1587,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


