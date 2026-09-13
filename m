Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6618FC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a85-00015l-Uy; Sat, 12 Sep 2026 22:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7a-0008RY-IF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:12 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7U-00011O-Ou
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:07 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so1563721a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267142; x=1789871942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IJjgBIXA9zcbQsVxJYYjfywSsSgw7dqOssFTKL2XGgE=;
 b=L+VEoVb6KDlBJkO2KLnH2xvGwvE/9VTfoizOWzG5VclYHO4B1oxtefl0h/uJplGDG/
 AKBSbcoW5C3YG3xuF5PSjLnFnChRTcRlvO7REkSzCcUGaoqUZjaDD5VyBPgYAyREtnvJ
 57Xgmli7y672oYoScl1J5sDM3UAN+8Y/9pgvQ5owIBva+RbmuBLQnx0e+Atr5GsIJtUR
 FJ0bhSPQXOu1kg2pxcxF9w4Ttmo9Fx6K0sMBTll+F8SgYspfOmwTht99guu6df/eHhAW
 /Cir2a65z9Er8ewoPTIFogyS7wP8g4oUVYbjT02yxpCcPwpJdCWQv107pLp48QBoHygL
 mbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267142; x=1789871942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IJjgBIXA9zcbQsVxJYYjfywSsSgw7dqOssFTKL2XGgE=;
 b=i7HdKLWQ1BJsUzfX0tempDjJkUdZ6unlWRFIqxTin5U98uvQXnaLYN5MuWoxEaeXTn
 wMOfRi6gaZaYwMvsHl2OoAPeeY8qAQs6GIET7iSYG7dHtrXckKleCGp2sW6ewKHLP6hC
 X15IqM3Us60GQWUPXwFJSn7McZy6CnCsTmka3FiARNQGAqRNk6qDnFAOk5T2fPTRhw3S
 1pODAMHlQh93cYQFM7cflK2lr+muLAGl63uhRVg5GN7UPog3eeqOKOywuBzS1l3uLCsh
 MkQ40wskR5o7eGFr31Az4fZAlzYUAQxU6sbCjOvqqU3iDHSBnHOLRPFbLG6oD45dXN3F
 +/dw==
X-Gm-Message-State: AFuF++n0lzcTWnVCXXSYlkmsgxVO5PauGh5ZZg4+oGCVQsuPq2Wnl30v
 bc8RYNgFDX9uHBPyih5NWXKvjLZi05Qv/4wUj3vhzAOnuRFoGKyBlDE+iVtKgHP3bXFbJGk32jP
 IFnMJVCA=
X-Gm-Gg: AYBFou12JcRpp+BqOqn2bFx58jQ1q+UtwQqT9jJgm74D3DUk4wFFHrT1N/x+7C4rw1Q
 Dw14zS8RMIjoJtnNoCCvU0/Xp6GcN+P+RKEkXkqDA8t51VBNNDsk+NILt7EOa1WoeUvVaoeGuYm
 fEBPsaLvl1v/P+HAayFrsi8ex6Kn/27HPdfORYcoFMM+kRLmsHsis5g/tLU7iIY2zMEuIWqU+8N
 FTv48d/yyfL8StsNmVHENnlu1Kx3MfYIoPzoJuCALD6tml0AVqjLJkbC7itfwwKiPS6DtD4koS8
 dJZfklHilODcTukWluaA80kDI+Y706RmxPE9nRUe7bHv/d0dqwDd2A8YG/f5FYzQUIQANDPjbBB
 nEN9djt30uk5RvUFsuSGsriUwAYqoC/NaYzQwr3lPRWdvtA0CcYA3vHiH6MIwFg4u51hyX2df4m
 3sbgiaTDM99+dSNx/eXENAXY+OzVArDV5xOUr+V+RsYMtVDsRm7yZ7QaxwpZTwpg6fD/ECcUIVs
 2UyBoISFRKpl+zeXA==
X-Received: by 2002:a05:6a21:3117:b0:3d3:adbf:777c with SMTP id
 adf61e73a8af0-3daed3e55aemr21556484637.24.1789267141731; 
 Sat, 12 Sep 2026 19:39:01 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/86] tcg: Generic expansion of tcg_gen_shli_*
Date: Sat, 12 Sep 2026 16:37:30 -1000
Message-ID: <20260913023837.741866-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 36f99dcad1c..103a7896312 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -217,7 +216,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b318ddd74e2..b98e5bd80e9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 50b43da4006..f856c641a79 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -458,6 +458,16 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
@@ -554,16 +564,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


