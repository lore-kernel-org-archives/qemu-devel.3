Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DECC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkl8-0002ke-6d; Sun, 27 Sep 2026 05:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkS-0002UZ-EN
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:41 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkQ-0007SS-KJ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:40 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc78d45f78fso1199337a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499637; x=1791104437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uFdaP5GypB7d/PwNuDyM8jJ3ehWUkVlCPZZw3lXbIoE=;
 b=Uq8aFrzILegArUwzY/lnF+D08u0vGBaVI+V2X7bmPOTM7FDcXkJWc+MpEue5sE2dB7
 tA9Q8kfR472SXzW+wMmNOownBraAFkCdiGM7Ku0GlRreoBCoVYp241RZl4OCGrOhNlfw
 vlBuHuGVin32WK6Ph/ZurZq/ELETt0yebll0DnENSSkNRnLXFr5+yhzPTL860vJpNm6j
 S9LvB+/wm32fiRbh+0sDMOEadnwrg77IDN4akuwrxOXPlKR69PzUxab3w4wjZUT0qoBC
 T1RLoOQHW3Eg7mShh3J1T7Dv9/KHURlAwro5f8wRfz+f5jrZmGA5zEdsxzV66VtCHZpl
 e8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499637; x=1791104437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uFdaP5GypB7d/PwNuDyM8jJ3ehWUkVlCPZZw3lXbIoE=;
 b=OOX6Sb454zkXq7/V8GloB5562wuHxo8Md2UknFnxeprwVMcmJhylAt9TiRXdBUJ/rS
 25XZMlBrJil8rUq/SeTL8biNLvwyNAZRKiMKJzorpcBFORM7PBB+GLZFhgCYc6emUttK
 FvePDENuhLBJNXDpXb7ivnRy+O0v4wcmA/1ycSbpP2qg7so4GRuaGWTdA4s+PQpQmRM+
 WU/2sbgcvHZ9iaAl8KAErK5vLiXl8ucg/LYAny0VyfI122hdzAO7opke/k9HifXN7uqB
 SPGT0HhQcfZy8FzVwW91jB1ooDFNAvm9hl2EDK9kgrD8ZILkm4oM77mz3fLDRdi+ZNji
 bsmg==
X-Gm-Message-State: AFq9FYJRjlLnvzpoiE+wFeZqxVIt4fUsuN/RE4PbdRW4pRDujjnsU1YT
 X8li31qH+1wNOOE1h1QsQktW2VZnYGUa1j+75nWw1Ril9GoVVxCi0dB/EJ0HH5tfNrn6lEIyeNa
 T2hda
X-Gm-Gg: AYBFou1syFBXOrftUxZZNhMtEpxctCT3vfinKdK4dwvVSTiV77AGa9JkOOdW0vkX46u
 w/PZZmw9mncL7+0zlVkEsrU/jfS+ExnKcyySlvvHu0kIpUcGpuI9DHUvhJqsSvxEfeEgyT0kUNP
 Mkh/eVuB/4FIh54+kr2nYyUNRQ1Vy9YrbVfjOS4pC0VLAKw+vqSzEKF8oJqZ7ZwGyvTEDRZsDie
 R6QbzQeR1jG+9XRjeX3lBsyhNIMjxkW8G4pRQjQJNbPZXkJQpNuZjxSQH0lfXcny/lhCFCKnLZ3
 3kUr3LQ83i60A4clIzWMnJvn4HkYMhndcJPDLrFu6aAMK5vVAZCJ/Tr3cgToPRlOWoKrh3phVGw
 HKEOpUHnsp92eUAj474Hb2N5I73zdpb9pdcKaqfnvrJGgdAFIJULkP2tIyU5Uahdi5V7I1nMoVp
 NIMpPXn2GRx56uZMqPBUBKnk6XenwWtipfLhNV20pkSp6GWIC6E6qK3Nl+qQqrF6A7SFDfDfKVR
 eXXYH7AKWDXq6pabzK8rVaBEZDW6w==
X-Received: by 2002:a17:90b:5283:b0:3a0:e22b:1b14 with SMTP id
 98e67ed59e1d1-3a0e22b1d5emr3081079a91.32.1790499637079; 
 Sun, 27 Sep 2026 02:00:37 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 024/101] tcg: Generic expansion of tcg_gen_mul_*
Date: Sun, 27 Sep 2026 01:58:54 -0700
Message-ID: <20260927090011.10724-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a78752e0427..fd35307a848 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -311,7 +310,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 96bd6abd74d..c1273a10197 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 065e37b34f7..70591ba503c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -601,11 +606,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


