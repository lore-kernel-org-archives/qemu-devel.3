Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B9BC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkf-0002V9-0r; Sun, 27 Sep 2026 05:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkG-0002R7-N5
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkE-0007Pu-OZ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0df0bb2d6so606732a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499625; x=1791104425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uxr4cxnUZw1Qi8GGvnQgxWaiwI+JjpPSesC8cHfIlmA=;
 b=DiQaCTGgQqBinp2S8jlPGi6EBve10vnnkoL+raWxhYEkNIJDeJCdxkoptynr8ftAZe
 pK4Sc+C9CKjuQQxuiDq4lT1kfnvyz2ZiLnrQZiNelD4WOUdOo+h20vTk3nPIJ+ARcKrK
 UFBdPFnn4ET/5g/3kGFrtF9CgGwtNdiUF81bM3LLzQY6E3RwKViQKYTN0lxGPXYPafuB
 9KyGcRWVRxkqeu9UC05Zcbu0Wn83XT7KXIfuXZIFVjqeP4CnS+MkuZ/XXp+fy8Ji6rJk
 w8GFQK/dyfRSRJyRJ7oOjCCsiskBVhaKJQUICzf3EZNvq3x67TzYjDCI9v7wbNAFj6Ox
 3ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499625; x=1791104425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uxr4cxnUZw1Qi8GGvnQgxWaiwI+JjpPSesC8cHfIlmA=;
 b=ulK9+JtG/GmW4OikDHZuEIM5QqsuRDYP+zP08RB3hpOjGp+avZI1j6PLBCwvTQMH1m
 oxwfw2/BmkOvAx7hUQx9h9a8SMwnCpewcytgaMZ4S+t5EDRQMCb/o2gykm8XxN7ugg9F
 zm7XfbcB/vaSEvE4rcBvfdS9SQXo62fThItXwab/Sc0KreRDp3nA8wFN0EJpAuKCsmkZ
 7NeFGiTqGXqdfxecTevsPLrflq9qej/MEAUfTCkl5fNcdRqdIvEEiAYUgaNJfucRzGqu
 qu/TtOFGxed+5GozyarRLtqdYoQSyWvXhRoD2oh2cHqARjtCHlav+2gnO5J0OWqIfmUe
 z8bg==
X-Gm-Message-State: AFq9FYJjqRj3LMI67XV8ZnE/vSaIUrh28i3d7LkJzvvQT8HR6TRR2U/V
 //MTOTFIfrhPU1SiIqMe/z7EmE25NxO5IAsDKBp6GqKLGp8nuSe053c4y16CKAHtwSAj+vWOZZE
 ZZpbc
X-Gm-Gg: AYBFou27oRdR2qcGkRpgFEb4nSOtoFnAY+qlEXMsFu/qxldoZhmBt2BBqEN5xSkbPi9
 8qEdICBOZ3OjI1U3v+JnFcaSg6an+ZH7RKKft93UpNwbdLmBuvKDRfQUgBUohojMUMsw1iuQIwU
 L1+uzoGvAlIFbf9L1ECmqY2f+kMb+RdX+98v0th5QdHoetNCUK4DzzS/uHc+iqVf6JguqqcPSrE
 P38xoENzH/Wjoba6A8xestdoF0eEq6985l26Po8RvRZMNCEO0zXY9ZFkaBKHsRZw3MBtjMVqPUh
 1D4HRbZ/iGxLPWBkDB6r5CFWj4TVAATLv2VEIDtWQTFwGpdOc9Uu0XMtIAkXwEF4mOrPuiR/UIQ
 NcboRE5uYVKlo2r2dZq2z+7oZNsThNwoTgFf0kK8Ft19q/nRIwElqXMGrDmc7PoJbnR/eNaFDX/
 CXtz9IRTkFg3iG7jzU0NImRZlZD/ohATU8yCAUnpuD13dQKvZNt0flASw18nFwSedUBeHvC7A6E
 c+nTBTGzKwMVxVehLhe4/pQYc0HUA==
X-Received: by 2002:a17:90a:e70e:b0:3a0:c401:53c7 with SMTP id
 98e67ed59e1d1-3a0c40156b0mr3891916a91.20.1790499625287; 
 Sun, 27 Sep 2026 02:00:25 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 014/101] tcg: Generic expansion of tcg_gen_sub_*
Date: Sun, 27 Sep 2026 01:58:44 -0700
Message-ID: <20260927090011.10724-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index db1405f9ebe..8444044ed57 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -212,7 +212,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,8 +314,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index faa83a09b2a..51d5ec6e06a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,3 +6,4 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 17fcc889906..2865de65d39 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -394,13 +394,13 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
-/* 32 bit ops */
-
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
+    tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+/* 32 bit ops */
+
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
     if (arg1 == 0) {
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-}
-
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-- 
2.53.0


