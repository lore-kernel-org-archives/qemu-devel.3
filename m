Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A66C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7w-0000IA-RC; Sat, 12 Sep 2026 22:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7a-0008RZ-It
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:12 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7W-00011i-KP
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:09 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b350c6920so633354a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267144; x=1789871944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uCX/uEuCi9KjVvfcNpaznESNEjLu5077D4mYylq59Nc=;
 b=FeRdPwg2YFUwbNzqrcENjj6TFk9zx7L6KfpwXm9D3ZEuHWx5hxpTS846irA6fgCEeq
 lcl20W/cMXdsZGMzOLQYI6sB+fJXHP9akHcThO/qIl+6Fg14HGyI+xxLT3HL0hi/2dpm
 +NBiB8a6PAXK1Kw63RVGkCM2s+SVAZNlqa8dQhUJGRKN/I1cBJmFV7fU0pKBHBnUdYuV
 stC6hzqmVkZlppW64+ZhH19S0drr9qUe+bOMSFNuyXElU4c2LWXQPshgqWg7Umr5UEbP
 kSAyBfGFtTqBNv3GtwyVe3PdwyIAialX/96HOGfDALaAR7Ys+X41QacdkSQRIVJZBPIi
 5A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267144; x=1789871944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uCX/uEuCi9KjVvfcNpaznESNEjLu5077D4mYylq59Nc=;
 b=bl/8sGE0QGI1n/uZ4LByiPC3rmaplYxpZqbGGN21tZKIdnCXl1uaQSi75Jo9yEnH8F
 GuXr4FRBMoayjH/2IGOOh3/vTaJU5woCcdpsXHk38HF3Ip3Q4tw4kCa25QXroW2Tk0w7
 UJzmV3uoPjo4tXmwmlVKwdsNN4d73ZPh6fehYMNaO8h2djh1ISiyZUZLuzafSf5TgFj+
 gCpGv37cETe/MEVviYgS7dhTaNaGCQk0QjmKpFbLdgH0dkGpQbRELESiEinbpxsGUW/8
 YWdpwkCnt7l3eRMV6KIJZouwTaU1Vwgd37/TOD22BrRfSvbyYIN1gGXT8lmusPXUfZHH
 lcWQ==
X-Gm-Message-State: AFuF++nmdXoAcsxqhVb6O7BuuPaZdbWy7vsOq0RqubqTHjPkksvhoenX
 RNelNJTCrBWmqk5iPfJ30RBN5KQ3AwD4V7sFvTm6CfIuziciRrQCdVrXGoIhRziGcHhUMtXlMiA
 jO9Ar0Dc=
X-Gm-Gg: AYBFou3Dmr7BL/HFnzl/ePuCzqlRsBhQcZiQU3wHx3ZfPTNDvAd4uiIlozoEYifocNu
 PiLwlOKjiTPDZ07T/8HHHrmaxMNPbWSNpH6VTUe9JLjAe6Qf20GkNjP2bleSgzs0yNOylPXnAHc
 AfNVMx0teRQYcFI28EyspSJy9wETy99eH1HyYC4vh6mjxWgdrXlSa5HkLGNAAEq06ZAu7HegzTf
 cA8fJvR+Z/ruNIbU3DHeS+IE/BZSWUXuFKORQ1N9vnd8/U5wJqD6m/RPtAuhGYnyP8OaSOMESzD
 oCJbKDrvU+Dp1VB2sXhz2da3WqbCJgGXo0E220V868UeIl6A8QMecrhKW8zXF37l8nfjQRAckBU
 gqc6ztunuf97Y/H48U1DIK/5TvboVBFzWi0W2lbIbLjtGkpobZMb25worm1GboJS+Fz9drZ4SXl
 8LHVta07+g6UDjBb+16Wmfjot62tcZbhD9uLlFF2KEvCEXbM7wf7a1q0i3zqNITuUvDGIIEsDU9
 8rp5jA=
X-Received: by 2002:a17:90b:1c90:b0:398:d6f4:c61a with SMTP id
 98e67ed59e1d1-39dbc6c4eb6mr9190852a91.17.1789267143584; 
 Sat, 12 Sep 2026 19:39:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/86] tcg: Generic expansion of tcg_gen_sari_*
Date: Sat, 12 Sep 2026 16:37:32 -1000
Message-ID: <20260913023837.741866-22-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2500707614f..99f4109d865 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -215,7 +214,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b95e51a07dc..bfd2cd4b9c8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
+DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9ac9547f6cd..34b2ecb2c49 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -453,6 +453,16 @@ static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
 }
 
+static void gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_sar(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -574,16 +584,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


