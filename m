Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F0DC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kJ-0003Hp-DN; Thu, 17 Sep 2026 00:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kB-0003Ee-Ft
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:09 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k7-0006qM-Ot
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:06 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4cacd3409so389040a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619342; x=1790224142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wUOB4nTcF/QLG/rH/OOsYp6gOqeOoGHFogDGd5ZRpt4=;
 b=RADSg0/uN7BQiemQJ1FPPmCqP6Pvx9W+YmxR5KNUWmDi+NdzoUUpIHmMk5eq/3FZ/K
 CAWopbkEjIHA2t8A/X2ZrstB+MQWRLWCDKVKgeTL7dyo+1z2VQDptL9FTjmh2+XhDTOV
 9m/gRL282c9VcscxefIXqiPJ+jYb5l8ckXGdTEXNOyvylA9Llw5LJPil4RU2lPFE4rCt
 g0OjgcEB2fswiq4Du6Yw5hY2iZlybrVMvfOXCTTiA2UzInAdirg9d4hfQpdQsX4C6y0S
 pWgmwdM58dxaz8ahfKfAH0QtGg5qsgU7TB4uQgGmU+zoXnKS6CB3xSwDl7NNSTmMXTC7
 VI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619342; x=1790224142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wUOB4nTcF/QLG/rH/OOsYp6gOqeOoGHFogDGd5ZRpt4=;
 b=oEs1oVfvcUTysMbumkLcxEcQyprZKI9qWmAGL68usHgTcv80qTWFIsJRxnvX+q1JI4
 W9Nz/sSBlSyLCVtjYAPGdz5MVT2yudLU6On7Fa6TTmt3L94xedBnWUOyrEEu+gf3Tj71
 +W8GGO2ZnCaCE3dZ1JZ+/W5DW3MttbAgLMRHbwhiXw3vnatWaJQzFlhNyBxvaWWkgB49
 OusvKvnwhkkFx89WMvN2GhuWfrrXHhCTZFo2oT1DtmxOIgglsS3DaVMK6aH0Xs2elwTA
 5hDZAl81HXlfYFUcy3OReTKIA2BZaOJCzhiWZhNUsrs5uwAR9AP2gs2Xi+I4zIPqSbfm
 IATg==
X-Gm-Message-State: AFuF++m/P2RakdFk253FXDg9nZau9C0nJ96BOu/GRKzgDTwaOZrsjWcV
 e1EUCJv4dzuUwg7La6KJsrcrb+QWmFlJHzqHmoi9mMduDC9EPLbETC54pNlvdW451p3AaSP8JmY
 RhkCMyk0=
X-Gm-Gg: AYBFou2u8CHfozCbliZM6yBj4QS3soUJh6sV/81I+FxvJIznQYEkGwa98R/xG/MKUCy
 DxlKY8vJwAyPNJ0M2FssuskvO1WnQA/yL2kst6ZMOJrA7SMRo4kPIjS4pn9HjN+g/dvOLC9uo6d
 JcohDiAcZAHSGCdbxouOY+Ero4vd90eMSPq3g6Ea3w+Xy2HbVN0DCpxfg22z74+jTvJUQUGltca
 sLrZxl2JmnFjaS8BPyg2PYcDUZDLhwlRHVUagLt3Pg0mpMlnTxlhdYkW4za6MLrL40Rbdo9JkEY
 qjDy5gRTdxBfvFPWh70Emn6kYSzgLxzHNHlwNeNZzw3jVp48uwui9jb+I637ksx6ghEN9lz3R+X
 txn+xwRKdycuK87jMGZzZ3L7wdkqb4cOVj8FLmX5s4YIWE/VonIJ9RQihLB3jWPgPvsc/uU56ar
 +RdQcAeo/6Tbb+Q+RAArxgBuuGcNMj+Zu8V7u86J2aW0KByP4+Lp0Ugdu0hZs61+Buh5HnFQcAb
 9GVNGPg4zjP9+lkLw==
X-Received: by 2002:a05:6a20:6a03:b0:3d3:ae50:97c8 with SMTP id
 adf61e73a8af0-3dd5f7a9bf4mr12779508637.21.1789619342219; 
 Wed, 16 Sep 2026 21:29:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.29.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:29:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 034/101] tcg: Generic expansion of tcg_gen_div_*
Date: Wed, 16 Sep 2026 18:27:16 -1000
Message-ID: <20260917042823.542588-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 tcg/tcg-op.c                 | 51 ++++++++++++++++--------------------
 3 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a8dffa7c5cb..2f8a9f48eda 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -205,7 +204,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 20007c90680..473d472823c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,6 +5,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
+DEF3(div, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5577f14ef62..ebacffead4a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,6 +121,14 @@ static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
+                           TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                           TCGTemp *t3, TCGTemp *t4)
+{
+    return tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                       temp_arg(t3), temp_arg(t4));
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -451,6 +459,21 @@ static void gen_discard(TCGType type, TCGTemp *src)
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
 }
 
+static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+        gen_op_ttt(INDEX_op_divs, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, tmp, src1, width - 1);
+        gen_op_ttttt(INDEX_op_divs2, type, dst, tmp, src1, tmp, src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -649,20 +672,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
@@ -1577,20 +1586,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-- 
2.53.0


