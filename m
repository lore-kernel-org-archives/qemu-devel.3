Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4D5C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8F-0001d2-Hw; Sat, 12 Sep 2026 22:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7j-0008UX-Pf
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:21 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7d-00014C-Uo
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:18 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso1153469a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267152; x=1789871952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yDGfwANPGeWP8+pcedkwOVaGUXT9kuovRQB2nw2DqHk=;
 b=eULzNN2dO9byyDG/zE/tXYvaMBj8N8HaZw7tK0wkw60W0xuHOtc4NmB4o9E7PHJDvP
 dOtFrDqC1V9DbMx+PxXgqxi4Mk3YKZym2XUcUAl+OcbQ0qXx2O5e0RfAgq6sOtiOqorK
 wQ544e11haJr+DH7Wvyj05AUpzv3pwmDUPaTWhn8WyMvs5DQTfPSxDNSfABpd2CspPeJ
 N/CnYDeVRBqLOB/meV60i+MSAvcxdhqi9lXAi6tWLRCKcAz9b7wybeJsm/1nPZjaBk/T
 jVH/7Nla0bsT8t0yfyC/tOCQd5KNtEBtSzl21rDdu+F0w3pbKjyWsdG/LiiGKgXK7lkl
 oWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267152; x=1789871952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yDGfwANPGeWP8+pcedkwOVaGUXT9kuovRQB2nw2DqHk=;
 b=qFGo/v4iZhaGseux2SidUbuEyA8e9jX/z43lkBL6uLh4lwigMNzsNYNQCE11BqPL6G
 o2D4IxDzbILEfkUBqjH487gWfg1h9htX74tvqt5fOk/GHkyyWJhDmC9jmejNyFuctPwT
 lg/Q3UWpqKL/geokiVtc64upbGQmISszWzjZADIfrf6QxbWuFRmfD3VJOd/RvQo8+0S0
 VkL5MNUo9b80znXaayc2CP40iu89zP0JgcOY725IwlKXG1ESrVpiHNob7X0xHWobbM2X
 Hhes+JujECXbLkGAuZ/4VO77Jw+3JFq7TMJghbpibKeyjSEuLrgosX1pCPrkVQMll9Cf
 74lg==
X-Gm-Message-State: AFuF++kplKrzFeO+7b5ZRmjRPKL6ObeLDfiSmKK9oZF9RatRoqyhlNRp
 XRQ23j21SZrPX6tlEBh48NqCd2ll5LvdSsoe/qqFqevOyaIMExQaXA/PZS7QR3idb6EtY/o5HPp
 7lrhApFw=
X-Gm-Gg: AYBFou2SGMIEneIwNtl1R87g8gCWtLyBzqGdgy8gfzHfWYs4L1H9TrEB/Y8bhqHF8Ez
 xLVqPBiBKuyRKDLdMgH5FN7aqQ1hXZVvEXO+44nyYduaY4r4PXAY+/6xY43xmQcmSuzNjQI4Je4
 jsD1EyzGkfMFzPzsBSQMeIqohgwrIsLBVZgj9VoEYBldfa6rHs6sJGrWqFK0+AGi9/AIeYKMQyl
 vD43lbiHDIFxOs1mSDGJtvdCGNN98U8yrOW9bXyE0t/TIn4uX4/LVfHVr0nKlSvotEzat6dmYDr
 F+jDQw8nZDGd1shmDCzge3ashWzWXDUJIkubW0JGMUnE7MfmYtV8Pn62CGeKrm+HAJN+XAEANf1
 YOZhkVPfxCCUbeKCLIPkDV7gcylzM9n6Hw0bORgsIRqXCjtkg2EEkxAbrZ5Nliaa8n/G+6TJAOm
 J85ltZkU3CVP6xJxURSiwI6Y/RGxUgpG0PL8HxadivzDJMVE/UC+eyJcgXXfh3Pgx2DivWUX6JA
 siqAY8=
X-Received: by 2002:a05:6a20:6a1c:b0:3cc:faf3:331a with SMTP id
 adf61e73a8af0-3daed1a0776mr19140012637.10.1789267152186; 
 Sat, 12 Sep 2026 19:39:12 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/86] tcg: Generic expansion of tcg_gen_div_*
Date: Sat, 12 Sep 2026 16:37:39 -1000
Message-ID: <20260913023837.741866-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 52 +++++++++++++++++-------------------
 3 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f01d30f18ab..7ab4cbac632 100644
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
index 0cc1274543b..b71c76de375 100644
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
@@ -451,6 +459,22 @@ static void gen_discard(TCGType type, TCGTemp *src)
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
 }
 
+static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+        gen_op_ttt(INDEX_op_divs, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, tmp, src1, width - 1);
+        gen_op_ttttt(INDEX_op_divs2, type, dst, tmp, src1, tmp, src2);
+        tcg_temp_free_internal(tmp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -649,20 +673,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1577,20 +1587,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
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


