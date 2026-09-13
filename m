Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7703FC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB6-0002s9-Qm; Sat, 12 Sep 2026 22:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB2-0002Tj-Sw
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:44 -0400
Received: from mail-pz2-x17.google.com ([2607:f8b0:4864:3b::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB1-0001vG-00
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:44 -0400
Received: by mail-pz2-x17.google.com with SMTP id
 41be03b00d2f7-cc1cea48edcso556030a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267361; x=1789872161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aN1TaxFZ7PbSOPaTNRA9Gaq8KFcGoLld38ZZcOncNME=;
 b=FgHotrMQvybRcUBx8Cwu+/vwl6tiEIv6wG4s8IxIFHOGr92qphPz7+an7FXUvMmIqH
 kztcXMerxktFu6lE7B+G/TF91zBr7wNEHLivgrV3ITtJE3iGDQf3lPLSlYi/CnbAFr5a
 8cgFRSmCXk3IdOuUow80aqYhCgFwunteV68J+WqK9cWJejO39Mdn/WAZs1WDPZKRROhv
 yiNHThEUKymWJM+0CU7UonNCUQoB+FEk+G7Vd6M6S6Kd83eQCxoD8gAZzOvZVMtgG9UU
 K7QGOA+PlTGyIzcDqCC/Dd39wLE1P3J7OaOPffFWi9wo1tsk6kKvOUp8NYIdzYT9bb+1
 NARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267361; x=1789872161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aN1TaxFZ7PbSOPaTNRA9Gaq8KFcGoLld38ZZcOncNME=;
 b=GKVavVl/GowJrJ09ULgA8OVmWwNI+4Uu1HR6wv/onCP5jRWiWY8X3muO5DxJCtoCKN
 5fMFOSSUYBr4VY1EL0R/+7cbKhjZVKmmoDvRAnc9sT9Miq9z3FSUl1MIC2m6q6NO9rBV
 HXUDQSE0e0EdzC/XTTZgWLSXR/fhoJdmh5KekgUQR8ckfGxLJZEw8bl5PmW+SMCFRHQv
 4FF0gqbwFP8Zw8CC9wVvxWG62ub2q4w9HjTRy8MlxtG5PwT6j957Sb8dMhG4uM3sp7CU
 zxT/J0wX+B7tgs6BiUkHS8mmnMROLI/rXPlbOU/OsOISa5p2p3nXFmUYVA4U/1QNKikJ
 G7nQ==
X-Gm-Message-State: AFuF++mdmcKOoCstLhAdZEMe8h3BYtdYyEIPzHSI+uJokDwjevKCWk2h
 T/2bkHHEPyPtVtpLBCzTtuqh1a/jUnW2lUTy980R8HbogxxvUktvzeQmNWN9fVJgUH5DXyvnjuu
 9qFc0emk=
X-Gm-Gg: AYBFou3oM/bWZJXrVS7Fzm1tM5G/n42Vt2nOmUY5Y1PsKEspRQRmRXncKmrzFNUMEwv
 3g3HIoX2pYnN/B/fHBMLCvMI+nxGlZ3igaqam8BpRgkZY3V1Uo6ZmdTfGl425QBCJci5E4GS+Hc
 hr8phj4OVHoIaug5gX8sJu23dLzTCH3yF2u4K9zCYtM/pLEYoRc+ixwvPBOBz9+J9UwUmTPijTt
 3elZPph/75WMwLmCDYWACTLeGJYgNLyukVXDrfBIMyJLXFhw3di4ejmThT7xs7j+ruEmnfSqrao
 yKnlNr/r5sr67e4yrg1Wki53uvsVNUxnq81k7zVT+uqkc0I3v4gKnOppUV3M+eFtmrH4BhNhIA7
 AbOE7pQ2qdK07lS31Q4rSmlbRMZ4MxqC+nWFVpYiD0+SlJH2vUNp1NE6jrQLgNpGA3n99yle+eV
 gl+rtgJO6sbmuoZY8OiAe1WF//lOpQrf2P5wcUAw700fciQHrsaMODwkt8VzvUebsICJbfCpKka
 V9WqAJq
X-Received: by 2002:a05:6a20:7348:b0:3da:b8b4:91d7 with SMTP id
 adf61e73a8af0-3db0e0a9ea3mr8892503637.2.1789267361424; 
 Sat, 12 Sep 2026 19:42:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 55/86] tcg: Generic expansion of tcg_gen_rotl_*
Date: Sat, 12 Sep 2026 16:38:06 -1000
Message-ID: <20260913023837.741866-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::17;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x17.google.com
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
 tcg/tcg-op.c                 | 63 ++++++++++++------------------------
 3 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 579699f5939..91faccf568b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1bdf9876067..3b2b0b76454 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -33,6 +33,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 723168aae5a..1a9e05775f8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -851,6 +851,27 @@ static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_neg(type, tmp, src2);
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_shl(type, t0, src1, src2);
+        gen_neg(type, t1, src2);
+        gen_shr(type, t1, src1, t1);
+        gen_or(type, dst, t0, t1);
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -952,27 +973,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shl_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shr_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1783,27 +1783,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shl_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shr_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


