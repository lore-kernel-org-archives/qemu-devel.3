Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A1EE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YL-0001TW-Cu; Fri, 13 Dec 2024 12:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xb-0007R0-1m
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XZ-0001dk-4U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-435004228c0so24464155e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111202; x=1734716002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WK+Z64alPo67E0gxwuqk0uYvI1XoxQYQ14C8cyJtCPA=;
 b=CGXq2vP/TXmmy0mjyzlIStGtzCj+dsmbZgd/vDQcYMiSMsrzrCcTqNqrPsyJtPCrde
 WuAmKgsq+wvg/FKLyHiGg/dIsdvee8aozpHShwEajVh6+x4aeaCfXSN++3+LYppE25/1
 8EWi3JpzYWZ4S2R5IvaKJChPX5sDhS+Qdu2jeYemKI5yTieR0W1iLwgysM7d25NDdTbX
 optK/U7deo6J7sjrMDpPqWBLps9j0mbX2AFq6x/ui9KEQkYqgHJDQpq+zmTdyx7duSXH
 P1EnLBCPJxS60ucT4OB4iSZ5Rserp0oKgg8k8Gi3rf+XJYmhQACHVCJ8tWPyf5DC8p9Q
 Q52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111202; x=1734716002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WK+Z64alPo67E0gxwuqk0uYvI1XoxQYQ14C8cyJtCPA=;
 b=QzZZ0EOZazZD6v/2e08rjFSyDO0gnEbxc5IdtEH62Hsog0gxswXC8n32Fje7MlWn4H
 JBq5o/QQA4HjULEfmJAR2vx9yq7HmUahNBOER/s8zZAi+5Qsidu9JJhsM9PcfyQ1K7KF
 59sb3hVDvOFO0AeROnJKxbKBQ4jLSRoB+KmyN3g/3QUWDuGOOWh4FvcBGQCkaRulga9v
 GQ/JjOeE/bHh2+T+Qjnqfq/XESonOxtxPEec3Vqh0OM4YjKyw2RExCKSo27pLW5WZRPk
 dOr2Q+W9cYsX39mlHqWiE/UNii5FKeHe6uJ93nFzGvJHSPJx8bfhqmDoi9KkQ/X/rHYg
 HVfw==
X-Gm-Message-State: AOJu0YwheO5daNt89hI06K37eQX/C7eZLG3XvJaKdJyretYyFXahx8YK
 Qp7q3e7lHnGZKxHmfDvOdpLp3qfiOvADiQsW86iM7e4KUT8btHNn4F62cV5SQn3oPhLiBpRGv+C
 R
X-Gm-Gg: ASbGncszsavereqayUzgXEnrQWHSPCXFLZFVF4tmE3oY/NVoIu0ff6NUtLcBXmAncax
 QC48aOCgOf6x0WhceURfap3XwbfG04MzfOyVlswaFsIGRLLTgSpcQwet+GtYIJHR85aDqsOcZ0O
 uIzLUinxyQNXHJQUFLW3vRtF6lyMYT5tPOE21jXRXeUbAFKd0QEpOAX7gmmy3Ye7+12fi/64OKF
 nwRTMGT3ouAJhyzY07X9cfJhYW6CsiuFf+WnpIO1y4VWVuD1m6oSWLWZ7sqZA==
X-Google-Smtp-Source: AGHT+IG4OucJUkoN/HEOAmO+9Arq2ci/luuhEvbIw8COrzSsAQDxVnxFswpc4XwGETQ6E4WI6FEgog==
X-Received: by 2002:a05:6000:4615:b0:386:605:77e with SMTP id
 ffacd0b85a97d-3888e0bfb19mr3227471f8f.49.1734111202617; 
 Fri, 13 Dec 2024 09:33:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/85] target/arm: Remove helper_neon_{add,sub}l_u{16,32}
Date: Fri, 13 Dec 2024 17:31:51 +0000
Message-Id: <20241213173229.3308926-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

These have generic equivalents: tcg_gen_vec_{add,sub}{16,32}_i64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-48-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  4 ----
 target/arm/tcg/neon_helper.c    | 36 ---------------------------------
 target/arm/tcg/translate-neon.c | 22 ++++++++++----------
 3 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6369d07d053..04e422ab081 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -395,12 +395,8 @@ DEF_HELPER_1(neon_widen_s8, i64, i32)
 DEF_HELPER_1(neon_widen_u16, i64, i32)
 DEF_HELPER_1(neon_widen_s16, i64, i32)
 
-DEF_HELPER_2(neon_addl_u16, i64, i64, i64)
-DEF_HELPER_2(neon_addl_u32, i64, i64, i64)
 DEF_HELPER_FLAGS_1(neon_addlp_s8, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(neon_addlp_s16, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_2(neon_subl_u16, i64, i64, i64)
-DEF_HELPER_2(neon_subl_u32, i64, i64, i64)
 DEF_HELPER_3(neon_addl_saturate_s32, i64, env, i64, i64)
 DEF_HELPER_3(neon_addl_saturate_s64, i64, env, i64, i64)
 DEF_HELPER_2(neon_abdl_u16, i64, i32, i32)
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 1a22857b5eb..c687e882ad9 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -826,24 +826,6 @@ uint64_t HELPER(neon_widen_s16)(uint32_t x)
     return ((uint32_t)(int16_t)x) | (high << 32);
 }
 
-uint64_t HELPER(neon_addl_u16)(uint64_t a, uint64_t b)
-{
-    uint64_t mask;
-    mask = (a ^ b) & 0x8000800080008000ull;
-    a &= ~0x8000800080008000ull;
-    b &= ~0x8000800080008000ull;
-    return (a + b) ^ mask;
-}
-
-uint64_t HELPER(neon_addl_u32)(uint64_t a, uint64_t b)
-{
-    uint64_t mask;
-    mask = (a ^ b) & 0x8000000080000000ull;
-    a &= ~0x8000000080000000ull;
-    b &= ~0x8000000080000000ull;
-    return (a + b) ^ mask;
-}
-
 /* Pairwise long add: add pairs of adjacent elements into
  * double-width elements in the result (eg _s8 is an 8x8->16 op)
  */
@@ -887,24 +869,6 @@ uint64_t HELPER(neon_addlp_s16)(uint64_t a)
     return (uint32_t)reslo | (((uint64_t)reshi) << 32);
 }
 
-uint64_t HELPER(neon_subl_u16)(uint64_t a, uint64_t b)
-{
-    uint64_t mask;
-    mask = (a ^ ~b) & 0x8000800080008000ull;
-    a |= 0x8000800080008000ull;
-    b &= ~0x8000800080008000ull;
-    return (a - b) ^ mask;
-}
-
-uint64_t HELPER(neon_subl_u32)(uint64_t a, uint64_t b)
-{
-    uint64_t mask;
-    mask = (a ^ ~b) & 0x8000000080000000ull;
-    a |= 0x8000000080000000ull;
-    b &= ~0x8000000080000000ull;
-    return (a - b) ^ mask;
-}
-
 uint64_t HELPER(neon_addl_saturate_s32)(CPUARMState *env, uint64_t a, uint64_t b)
 {
     uint32_t x, y;
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 19a18018f1a..0821f10fad5 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1560,8 +1560,8 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
             NULL, NULL,                                                 \
         };                                                              \
         static NeonGenTwo64OpFn * const addfn[] = {                     \
-            gen_helper_neon_##OP##l_u16,                                \
-            gen_helper_neon_##OP##l_u32,                                \
+            tcg_gen_vec_##OP##16_i64,                                   \
+            tcg_gen_vec_##OP##32_i64,                                   \
             tcg_gen_##OP##_i64,                                         \
             NULL,                                                       \
         };                                                              \
@@ -1639,8 +1639,8 @@ static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
     static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
     {                                                                   \
         static NeonGenTwo64OpFn * const addfn[] = {                     \
-            gen_helper_neon_##OP##l_u16,                                \
-            gen_helper_neon_##OP##l_u32,                                \
+            tcg_gen_vec_##OP##16_i64,                                   \
+            tcg_gen_vec_##OP##32_i64,                                   \
             tcg_gen_##OP##_i64,                                         \
             NULL,                                                       \
         };                                                              \
@@ -1761,8 +1761,8 @@ static bool trans_VABAL_S_3d(DisasContext *s, arg_3diff *a)
         NULL,
     };
     static NeonGenTwo64OpFn * const addfn[] = {
-        gen_helper_neon_addl_u16,
-        gen_helper_neon_addl_u32,
+        tcg_gen_vec_add16_i64,
+        tcg_gen_vec_add32_i64,
         tcg_gen_add_i64,
         NULL,
     };
@@ -1779,8 +1779,8 @@ static bool trans_VABAL_U_3d(DisasContext *s, arg_3diff *a)
         NULL,
     };
     static NeonGenTwo64OpFn * const addfn[] = {
-        gen_helper_neon_addl_u16,
-        gen_helper_neon_addl_u32,
+        tcg_gen_vec_add16_i64,
+        tcg_gen_vec_add32_i64,
         tcg_gen_add_i64,
         NULL,
     };
@@ -1840,8 +1840,8 @@ static bool trans_VMULL_U_3d(DisasContext *s, arg_3diff *a)
             NULL,                                                       \
         };                                                              \
         static NeonGenTwo64OpFn * const accfn[] = {                     \
-            gen_helper_neon_##ACC##l_u16,                               \
-            gen_helper_neon_##ACC##l_u32,                               \
+            tcg_gen_vec_##ACC##16_i64,                                  \
+            tcg_gen_vec_##ACC##32_i64,                                  \
             tcg_gen_##ACC##_i64,                                        \
             NULL,                                                       \
         };                                                              \
@@ -2371,7 +2371,7 @@ static bool trans_VMULL_U_2sc(DisasContext *s, arg_2scalar *a)
         };                                                              \
         static NeonGenTwo64OpFn * const accfn[] = {                     \
             NULL,                                                       \
-            gen_helper_neon_##ACC##l_u32,                               \
+            tcg_gen_vec_##ACC##32_i64,                                  \
             tcg_gen_##ACC##_i64,                                        \
             NULL,                                                       \
         };                                                              \
-- 
2.34.1


