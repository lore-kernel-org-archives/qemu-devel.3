Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D79ED49776
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbB-0002xn-Mi; Sun, 01 Dec 2024 10:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaN-00083F-Th
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:14 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaF-000594-IE
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:06 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5f1e560d973so1729640eaf.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065801; x=1733670601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbLSyGvq6Xdzsweczp5bGUGluv6ionY9P6abLAmHhGU=;
 b=wwhVsB1bvdgeK60hm2uYXdgDbT4r8ecOJGx6kHZU/iUh0U1fjXrhGwnY1FyuZ9L82z
 zyeTHVEKTzzt6Eth+c4hIVi1S+kGrJf/E/XsOcWcBB2JzwBy9dWuM73twq6Qx+y/9z8l
 6H2sf9BSUg4g4k7d7xPZtnhIhhV9WQmNpsocuZ6cAVwYKsW4sG/dtZC9goAHxC0LIJMH
 yadL8WLOC9gSNkIoKuDG5xvanophi62YBfRXXHfXMYE6OvOboEErJJ0dmc1/D0ufr27M
 +fN4+s3kPTCLMyXpagLph1EnSN6R0sbqSiQMo8CyV89vw9R7uorAtqWdxCl1oxzqLUMc
 sneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065801; x=1733670601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbLSyGvq6Xdzsweczp5bGUGluv6ionY9P6abLAmHhGU=;
 b=uSwtFw6bQAhAkr/TnW4dZ48whNAUsoEgHULhWXAXmuEYudNMjuJlFGY8HfC2EEUvF5
 CKv/9fMAv9E345OcWZ+HjNC1HyW3tQQgrAY/omXUYSlybEcFRoZyqQ44mBE0K6t/cXCS
 D35aauE01R/0V2Q5uHLah0bATpZ3U4aVlGzu3loe+/eHaRhannWKnsg/nj+YAvfF8XnL
 ZnncQLqC8k9pe/+NkMcNugm1p+/YkYW/KQceRrICFEAG8+j2eb3rCxi6jbxTloBMjulq
 YXXAKczHu23CdSS8BzwK/w1on0EmzO7RwNUDV9nT54VmgOxZ28K4Q6/yjAGai6g3jNOI
 0a0w==
X-Gm-Message-State: AOJu0YwEqHSQQajnDLAjLBRu4vlX/bklfRv+ZrcO3AL1gFYyrTdUQ2MD
 FL+0HuowcAYXJk/cXTS6cpMAu8hYnDYvH4GipSjatVyQIkpw11Tv42gxNTKWCISzRn6LYrPNX7n
 5OkM=
X-Gm-Gg: ASbGncuVJj2yNQaC9MHvztK/mIIb0ldLdWl7t3brM3FJuXJyG+hLuQi14aL5xpyEsUn
 yCqsTKQX4ILf8QDk9twrX2ZT3ivFDhJPghQlhlecY8DbrzZIkijJTzhdczuIzw86arYPqlWREER
 wtfMSmm/XIKi+lVx84YHQ7cp333hqXoT/HNbrSyAPyGj9LRTY5vCDDUSoI+kCLc5VDfu5eSnrjZ
 B+8LJb8jGP3JW8CtMrPkYok0f8F7VfWlEE4bHEzX/yTkpHqgzKUzP6WnMNl1wzfVM/saJaFXpAY
 w7PXiP8qdRZCc2i7KBb41IOM2mkeCwCswXuP
X-Google-Smtp-Source: AGHT+IH2vnc0SNZF58FqDvgsOq16e8YkyFXSn60UbR7rc6NUO5m/BE3aunq0GioXcrGgMG8oSkvspQ==
X-Received: by 2002:a05:6820:20c:b0:5f1:ed20:b7b2 with SMTP id
 006d021491bc7-5f217a1ad3fmr8672041eaf.4.1733065801422; 
 Sun, 01 Dec 2024 07:10:01 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 46/67] target/arm: Remove helper_neon_{add,sub}l_u{16,32}
Date: Sun,  1 Dec 2024 09:05:45 -0600
Message-ID: <20241201150607.12812-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

These have generic equivalents: tcg_gen_vec_{add,sub}{16,32}_i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  4 ----
 target/arm/tcg/neon_helper.c    | 36 ---------------------------------
 target/arm/tcg/translate-neon.c | 22 ++++++++++----------
 3 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6369d07d05..04e422ab08 100644
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
index 1a22857b5e..c687e882ad 100644
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
index 19a18018f1..0821f10fad 100644
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
2.43.0


