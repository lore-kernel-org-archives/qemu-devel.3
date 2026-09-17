Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF39CC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kJ-0003Hw-PH; Thu, 17 Sep 2026 00:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kE-0003FA-Ha
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:10 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kC-0006sI-Qb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:10 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso333330a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619347; x=1790224147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5YEY9qk956Hy3+jdNRXDUZWYX8AsPshUstXhFW4DTSY=;
 b=lQOxS8D05i6NCTLB3jtvAjYgC8ZX3EdFEaPes65s+/sin5Onwb2LJKVayeDy8pr+tf
 HUFgYoeP+8K43Rl3b/Q0vBY+zXLnw10LBGzlaHHTv3QMm7ubgpfiRLsZab14YqOg+T2R
 LDcid0vTnJGROeh6HLkgO6Lux//Nn59wL16yYy6jVbdlr2t1MxMAZFA2OtVvLVWV2Gh6
 hebl+j858sqMDZFX7NWpiofXU639LYLaQ1FQSIApP1Xl+TEyC59XFBpwhI3ENW7WClbB
 AzRfWvf2w7iPQdwT1mFePc7P7Yb7OKIx6KHc8fDIhWaZYGmFXadajjqwa14cyk2za5pj
 ln3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619347; x=1790224147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5YEY9qk956Hy3+jdNRXDUZWYX8AsPshUstXhFW4DTSY=;
 b=a6anzWpyJV4wlDdqgmWVjcvXFrRrwp9Mi4i552ruwk+1yADNTYnH89IxMv+ImpEOY/
 rQAd2o24PlUMHOXM674zcr/nQTGfCPVMp6cd3Vgg+kJ5IF5CWBYHBOzMHf79Tqm6mNCK
 3OsG+to9+K5ozWXi4tb6qnJaeHho6FxcuiSakJMy3ML4oLBk3P1uAxggOSrhSDbBXPTr
 +VutgPD3JJ9YLAzdDfr+ynbdTPXMZp21gn5luMFgeG2japE9J7r40pl7PzPKaRNxh0gT
 +aMtNu7qeEQ9Q+vO/8XSxmcbmZOzzGMkVLr2/ZhECEpN7QptmHxibodARIoI3TQb/Fj2
 OKbA==
X-Gm-Message-State: AFuF++kkO+g7sdu90jjLHqeggdMhW+Uyt7YJ5rd0H3IlosA9n7Yj4K7S
 OuXMrtW+b2z6EaUJS7X++oPH3Of4JpLriFvuZPt3xMvAwHPpb1DIoUdXI7sYWsW5ftuNOjwAzWh
 Npi6yg2k=
X-Gm-Gg: AYBFou3apsU3uTVb0aOAtlqEBLEG6FnYcV8nA1/rNHz0QP1YKUZYGGRYul3/+o5/YhV
 J6F/ZVGmIy7/WcZ+1S/By1NsVfk+sz+gydAKqAAYIBBZ+Vdc/e/xrtmL09HHFWEBeztdEwAfIgV
 Pj/tkmR6mS0R8dM6Dy+Rv1dWNA3wKXWhvy+rUkuXR0RNXpOYN3nHFRi/6kRmken47LfDtZftglc
 XTUabNAKFv6wzCtcoVspb6K6Ya1bZon15HtbllTSTRTP6AZdSBNCmdjvDRfxddPT2hUO828kM4b
 G1xFBqSAS0WLjWZ3V4b8Lv6btCKFpBZf+FOQfymjrO5hq7HiDOv3Ac/D+lXZvRPwW3Jnm+pZayv
 N21IKaBhCt+OGGhtZzCo3cfK+hu5fWiOHxFvE6pIAtkh6M6pFR+ncZy/qgM7TqkbdTY/jalQUpm
 4+P+NpuZqMKQcE8lUF5uLa5aCfolfDZ9RBeE8/Gn3vJw1ucHB5J4Rtel9wjPR+4I5LKQXuyWMpy
 mFWZd4=
X-Received: by 2002:a05:6a21:4598:b0:3d7:b90:acba with SMTP id
 adf61e73a8af0-3dd5f3b80b5mr12375830637.6.1789619347249; 
 Wed, 16 Sep 2026 21:29:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.29.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 039/101] tcg: Generic expansion of tcg_gen_eqv_*
Date: Wed, 16 Sep 2026 18:27:21 -1000
Message-ID: <20260917042823.542588-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7517e8d9d9e..fbbc3acad83 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -200,7 +199,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b05a1782513..c1b99a280ac 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 262d2cbe2c1..4a3622692c9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -486,6 +486,16 @@ static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
+        gen_op_ttt(INDEX_op_eqv, type, dst, src1, src2);
+    } else {
+        gen_xor(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -725,16 +735,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
@@ -1772,16 +1772,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-- 
2.53.0


