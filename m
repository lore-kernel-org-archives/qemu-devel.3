Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE0EEB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuav-000737-Ms; Tue, 10 Mar 2026 06:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuau-00072y-5T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuas-0005ni-90
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439c9bdc1eeso3216410f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139540; x=1773744340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f2cs4P4TlpSelIffNIKB/PcbqXUE1cGZjo1hKrHbVqQ=;
 b=L5ACfr8R+fNF8w9q/JL5EUypNUlEvdeZOsCXE4x4MKtrTYMfnSsi1xGzJhXLyoDqzy
 31QQL2XGm3FE4Ho3rAApbCQtXG7IPq2j3+DrTInNwqvRhkSLAnPvCo4ITwDDXb/9WbhH
 GtOePWztGpE1kCgsMF2xz56RK0tt82Q6zYgvyi734EWlQ664P3DXODAD5CC3IuRejh95
 ZUytf8Z/btbd0pJJj/vad5/DFW2ctMsbm4+iePrvdjSNC5CTXyF9dErKKtsz6+mt4P6Q
 W9YsvUfDKZiHMSxkkaD7oWzp3KAXJtbAm+YxLOc0UTsYQchjW7MvD4I2VrT3TTDhZq0x
 Cfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139540; x=1773744340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f2cs4P4TlpSelIffNIKB/PcbqXUE1cGZjo1hKrHbVqQ=;
 b=v/fjmBgrkP4JV227eJRWbvywDhcQGTqyZ4OXdPa242IT8NUbRC/NAoJuFv3en/DjhP
 LY9u9f1FjKumJpWmG82cEpjqNbibKXuJm2YZvfCDTrNTA3YcJnvpYiz6wL0TF12jF5tR
 YTpJmUW7Lw+IIMhmGpRtzY6hDQNupcm6xREWAiA6EGmAdF1jhLEDn7hIcCAlMDIL+P69
 w0lSvuSWPMml59cykuvRRQt964AAnEmUGLtzgoJ2JNJAmug1P2q4246MlePg56yK35YR
 gochJcCd605Pvr8Y1dnhOaN9CuthF4agGF9+Bs8CAx75KQdsQPIVk/c5fOevhEn/vWtu
 n12Q==
X-Gm-Message-State: AOJu0Yz0LFYp7hntQWTLzh0S6hL1d+4Skrl/k/jExWOCY1p5qMVhrzVJ
 Y4uDvJLaBafnLeVrMboVwNq+6GDpRCQkZUuQI5uAqhhjrgf5jXP/NR4y3gkVmLda94bFFBcQcwp
 /94xyzVE=
X-Gm-Gg: ATEYQzzw8jaNtJvIJgBDzXs2Zm5bWoZfOk3RBMz7LAiJLs0PZO76yMqBEyXV3FfzC+R
 /qxbSrhS5wNsYOffixr6+A6ynZZavUE3GM/Qjz4fDwG2Jeo+gOHRCfTG1z3a0qYf6jOpzWdBuin
 H9J1lQv6duhQk0m+Dlzvkaatw4idX8do8iSPJkKDdpFalAvsNxtaoWAAvJt3+JZ17++irREVsPX
 5bVRqcuNVohhVUfET6lh7CFrgrQdprGvd34oP+aJJLUaRom52PVS+K36GBVi6yIdfl9vYYgNAZK
 KNOfQ6JGbpgYT9jbQkEoE8Ay9Noj3FybCqX0rXD94rBcLWjx94xknkLLKmv3RL0CEYlGytBPRnk
 Xxu83as2QIypcqAV584T4RxL7r3bggUDwqQOvUOavIhOeuNGdIf5L5GNUJAh0uzPSyA8hPgrenS
 76TqRODWvCojhIyIM5mbpARl9A9o563tafPMOvV7wcOwrbStJ5YAB2Jh1/3w6S9w4CI4pUi0Aa
X-Received: by 2002:a05:6000:2506:b0:439:ae2a:755e with SMTP id
 ffacd0b85a97d-439da35fa91mr25974000f8f.23.1773139540444; 
 Tue, 10 Mar 2026 03:45:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm33927411f8f.35.2026.03.10.03.45.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] tcg: Expand missing rotri with extract2
Date: Tue, 10 Mar 2026 11:44:59 +0100
Message-ID: <20260310104511.12670-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use extract2 to implement rotri.  To make this easier,
redefine rotli in terms of rotri, rather than the reverse.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260303010833.1115741-5-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fc2254f54a7..13a56d89fa1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -826,23 +826,12 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shli_i32(t0, arg1, arg2);
-        tcg_gen_shri_i32(t1, arg1, 32 - arg2);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
     }
 }
 
@@ -870,7 +859,16 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
+    if (arg2 == 0) {
+        tcg_gen_mov_i32(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
@@ -2042,23 +2040,12 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shli_i64(t0, arg1, arg2);
-        tcg_gen_shri_i64(t1, arg1, 64 - arg2);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
     }
 }
 
@@ -2086,7 +2073,16 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
+    if (arg2 == 0) {
+        tcg_gen_mov_i64(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-- 
2.53.0


