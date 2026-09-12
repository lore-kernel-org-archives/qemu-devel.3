Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA5CC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1k-0005Ea-7i; Sat, 12 Sep 2026 06:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1U-0004q1-2R
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1S-0007JH-0Q
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:51 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d8fe517774so9430125ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209109; x=1789813909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SjZUO+5l3j/Se+oM71q7vJIu3PpFXRzVmyfd65WJaEA=;
 b=H9rMnTvwSDjll0yqq6ZW0coc5azHPE9PPtmBFB/yu+XyfPSiZeqU0UsYmWPgmY8GXG
 ta0ovQXf9A6O6dvBNB5dfgUoI6OccMxkMwg/17mVFUyqLuNc+JUCiFD3/pzmi90GKxMa
 gkWY463jvdAKWu1VETGJISxoTor51oK4/JB/DY8B8lJT/Skz1LLYLs4nSud3VXzEM1if
 oVEQzI4WMAt1spjn/2nEVrPbX4bxKpFW8cjow+AypYDynf9C6HFqH+VSj8KWzq5UQ38O
 mmQTtyAknB+qvLuEbn1Kx0P7WKiGSHB0qsZNDhZIdk/xDdd2ZYsUxvjDJfLHBd56jSMu
 fC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209109; x=1789813909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SjZUO+5l3j/Se+oM71q7vJIu3PpFXRzVmyfd65WJaEA=;
 b=NzvcL0vB/tialWXg385gBH5hf3ymadQsvHlYt3lzl8dxEsiQJUbRX65xrGXz2fvYBM
 6DQZ1iztShAOAVqiNaoy7LkCoAXmQ+xz6FzNuaeRSXSECu5T0Ck7aDOMSR2wmMjUFvAJ
 TW6a3ZR4BkLIm0nzQuX7B3DjBCKI7RXZa9vROPIXu44pcbZmgmQ/zEP/8KM80EyImnLk
 TG1qxwcklU69Z0cqqitk3zco1yooC4r59nOdWe7FpUB4iBoHzAkGD6h6otpGBBFYQawX
 9lRYkFTtWYsmQP9nEqpGWSZ9N97p/ApaRzrD31iIymEODm8QxHQyNNvDsfFGQfK6w8MX
 D2Ow==
X-Gm-Message-State: AFuF++nws6i0sLr29YfJ/h44OQi3FsCu+UKxiz+YCdr3iH2xPOHchhmH
 SdD2vUe0bhUymwCr6Csq4tat76FAfjMIcoYXztglqfH4c2QRXRSGhb4Ual7RHWfRJz0oNG52Tlq
 6IaXKQg4=
X-Gm-Gg: AYBFou24aepUL00on6OnOPXgGcC6AF41TmWofAARsmuJm64DgeZC5LGAJN4B9XcV0FX
 2pdVIHXqBqKVsDi1SYmNCzRL5o2FtCFlPJpsWX/GUQdt7hU1EP9oN4GbWLtu/mAsm8AT1Vuo7Vh
 gdpH2v2oQOxthS3BtC3d7COxxmB+4BB7Qi+7ACSy3+HImy5F2haRWDjqPCNBYKlulVD8tQNp0bJ
 UcvFzK01iQufCNDdp0xFXqs3kN9Z1VQjMNBtqiTwhOf3Fu15/TK9kI9pcTMMpCaW3zbO2haCacJ
 C++ft9ZUJ7+b7ChxFhDsFmfT9FiND26NORYRK2zWsdGG1gCAGLgPlL743Oo6nmPoxp11upeTHyx
 1kxV3Ss8bqQawp72V7vgRvd9N0bXeHFQi7z5Z5zAF4Ges/zsGN/u2/YKqIIwZEC2BXFbv4DJxFx
 UoGp+C1893QirL5XbwPfalfnIOU+iCCaACAYZreJTP/T8pPGkVekwODS/FEqPUzt3tPwemh46Y3
 H02M3g=
X-Received: by 2002:a17:90b:1f8e:b0:398:b88c:2b7b with SMTP id
 98e67ed59e1d1-39d9bd9917cmr16050374a91.8.1789209108553; 
 Sat, 12 Sep 2026 03:31:48 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/82] tcg: Generic expansion of tcg_gen_sari_*
Date: Sat, 12 Sep 2026 00:30:25 -1000
Message-ID: <20260912103126.598030-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a09d734e254..ebc0f1714f3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -213,7 +212,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 0b3f9c0067d..0a17ebf5030 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -6,6 +6,7 @@ DEF_RIR(subfi)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RRI(addi)
+DEF_RRI(sari)
 DEF_RRI(shli)
 DEF_RRI(shri)
 DEF_RRI(subi)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 011817d9f50..5936ac43afe 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,6 +409,16 @@ static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -567,16 +577,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1576,16 +1576,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
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


