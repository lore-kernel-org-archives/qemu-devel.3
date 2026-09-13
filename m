Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94663C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8N-0002Aa-9L; Sat, 12 Sep 2026 22:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7v-0000H4-0G
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:32 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7q-000179-5T
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:29 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso462873a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267164; x=1789871964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hLB7zLv8IjtaBaWsoO6VA0SYXO4V1y46Wy/uN86veqU=;
 b=hWX82xKmrpLLyfucBBvrm3IocEa8+ysdyoGKID5AJ52WLf3LcZqD44mHsWZEqIDGge
 AVhQ4+sZpKO0Imge37edBZJwE90kBO0Xxc6dN45A2Z3ardVgRKC34N4efzcG6FFV7xBH
 3spGb12lLdCFX2OJY5CS8dDZFsUpDmIFEmrhcFXBW7US9zaIoFAcQzlK65Fn9oVlCxUn
 4Jm5xiQ86IkwoLX3WNZTUe29+yxZfVdywNpnySf6t5hCRf5+KFQtKXmVQ53TUXWfP8Ts
 NWS14HMkRvY6sBJdyP68o0SMCOasdMBbM44gtCQ62bbRmsmPX2OWMeP7dDRmZzw/efEL
 89kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267164; x=1789871964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hLB7zLv8IjtaBaWsoO6VA0SYXO4V1y46Wy/uN86veqU=;
 b=TBRleEPXuv9QkBMpve/b/MsMOKFJlOrW7qJea1azLA4lGqpm7Vg+9nmnqenkSrFrbh
 w3Ssg5WQ08gIIrM3Rru0dutX4QE3mYQ096ySlsdiXd9eI2DLlpxICUL5obUXItnvqQ/9
 Wq3rf9DxunSC/GMjNys5laDePu6CWASlhgFsTEwalwsjlajhU/7VF2ls+6cXQDVelgHi
 QU9G5RXPIgBrPCpYhsMyPdZ4dgWRR3F6NIMkEMc7TkOUpbu/PwL1x3kEFcwKsGNcmoDi
 gu2OF6PGlL7ATv2fJ7pvWuG+5TFx1PmycPkNauF4TQpQGHfAIb/x/Cda7sE5L2I2xLVZ
 /YNA==
X-Gm-Message-State: AFuF++lce6fbVt36534lh5Frz3hYRJoLdFoRwHJy/3xkyfQZNMA7x3gr
 sTlrQRI3DQbqv1dwLCbZmT42HyQa0UhlQHDm8Sa/cXoJAzEoPL55dtnJkQVuIHyD0bOc8MPtROL
 EJNN/
X-Gm-Gg: AYBFou1gWud34jvCtOrZ7Gh/Xdz2OAp4fZzpBpjxohxFs5/SLkVN2hN89quXHmKuCEo
 hRHn3qBe/LNHEEUENXhB903OtFAlllwNecj/Yup/iB5hFtzPexCwXX11AiK6Q0FWF7icE41J6Tt
 azr4qMohAjxYtdgnWqsQyLBcmoAh2SM+ghzClIzQ0omxtSm/ixcUs2J11Gns7tqE0mMD1VqlimZ
 IM0Zjx7EIf8prWDVCZ+BN3hUpGAw26YVwChKRkbG7MBpMPlrkUY7w/KtomtZn6cZOLJBMp6+CJ8
 wWSZw982t8Z3FRMf8u/rnq1IsUR06UZiZivMzhYnvG4bicH8TbARf6MoD9mbu4b8I3Mn41Tp2E5
 tbl6hW2eJ7vr4pDJ0NGOGEkHgCg4G3iAvb0ANDRpfmSAoUNH4QJaLAB9wTGeSei1P3pAunlPBNu
 /J+u2vB/VrGo4uqioUAmjry5zlQH0RiiWQ+Nbi7ok8d2m+93WA6SwL6Xq5SpVjM7cDPchSgbfjO
 K0vzNc=
X-Received: by 2002:a17:90b:53cf:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-39dbbeb3c67mr9049949a91.6.1789267164000; 
 Sat, 12 Sep 2026 19:39:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 39/86] tcg: Generic expansion of tcg_gen_setcond_*
Date: Sat, 12 Sep 2026 16:37:50 -1000
Message-ID: <20260913023837.741866-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++++++--------------------
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 68bcb297b33..4e8f1473c4f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -217,8 +215,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 63e87c8313b..6ce86d2005a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -26,6 +26,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
+DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2bb5427f668..f79722a2b84 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,6 +121,12 @@ static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static TCGOp *gen_op_ttti(TCGOpcode opc, TCGType type,
+                          TCGTemp *t0, TCGTemp *t1, TCGTemp *t2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -679,6 +685,18 @@ static void gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_movi(type, dst, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_movi(type, dst, 0);
+    } else {
+        gen_op_ttti(INDEX_op_setcond, type, dst, src1, src2, cond);
+    }
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -747,18 +765,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
@@ -1537,18 +1543,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


