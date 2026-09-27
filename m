Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F521C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklQ-0003zv-EY; Sun, 27 Sep 2026 05:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkl-0002ZO-9T
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:03 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkka-0007Tf-Rt
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:53 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so989648a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499645; x=1791104445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KQ5+KlCyyX7cxbtRUoNeYqGLbOz5Tdr2kpZzmuS7CN8=;
 b=c7VCA6l6UHR61LCiqVve3h5Wq35wQTjlco+NyLtT9Him0f+MxiJyX63ZDKogFpwS8z
 Md6R/eEb1AsBiOFS+uP0C4/V8+gPmka8nWGhKU/5UBm/F1PDHOF9v1gJPeKbNodKXi7w
 LAv5aY2ximy8m02MxdXYnujLl3XRsdO2d8g+o9XJegtwqWfC8rGgcJtIgGxuQK6Ugzo7
 rfaihI+LA5ztKg8/lQnnV/HFFwARsTcgYg29ilLhZgPHlm2ihFX9a8SAqg1570KQHpAw
 uS3MkZ+M7YicjwT7CTIU+f0YvkX4RncRcqslskNnr2d6EFP9mS20swfiUX4JZex5kG9I
 FkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499645; x=1791104445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KQ5+KlCyyX7cxbtRUoNeYqGLbOz5Tdr2kpZzmuS7CN8=;
 b=qIDybWdTsF7bmUHCbprUdKHI4QJ2QGwW++x298hjvoLz8D880bcXOGBC/1n1AvLxJ7
 GJVsb/YprLRZiXakPbsT2jefiTLZMGGq3T6vq9EMlMhElRnVmY21OkIe75aB2aB/DkHx
 hOxMBKyH14GHxrq6r77JJI6gXdM3ODG9Z53aLYRcXgFEUI4cvKpffUXQeF4ykaxR9IKb
 +yLo7SCK5XLvqZ43MvZdpeq390cFx7VNJ4b1iV5RMtiaxsbqcV8sUFKgV3PhwegEBZDO
 vlcD9b8ZePySKoJO5Mzp4qLffYHwtbQFsprxMpSffmLRhH66+uUrmk2M+xFCDS/xsf7b
 72gg==
X-Gm-Message-State: AFq9FYJUpkn99AwOHpSP7JpIzYCU9IF3/Qe99P3aPTF1RLFneXu8ZiwO
 DBRYF/aOwv907BMxP90tCzxySscHBPsbhIV2wm20xkBp70WLUAtTl5UUAKBO4mM34YQ3oS44eQb
 9chWr
X-Gm-Gg: AYBFou0F/ss1I3IdACjNL0Or09IBLiUW3CTcaDz5nCb9uJ/X3m6ICw9RZnJ9mzlICuf
 lj909Q0yYsOJouS56HDinnZwMC5Af5coU/ZtojEGVcP4LEDk2rUdUhh8s9JymEmGVo3LQXtplfh
 RMAFWQqkeo+0cTJ0RE06RE8PYbRqbPzji6eSAAny1V53vgwvIWhtoS1Cu3deinLNYnS0gGjPLBE
 mbxEVzH2dPRs7C/rh6Y8DPrI+8cORxN62amoJi14Uom+pa+BNplif/GN2RBvv+pjoj8M0DUmUIu
 2yY50KaKgELzrFb9XIGers9LDYlwNuiJLj4p9+X1iRbiazmXElyeCyz+parVkbkMj4hAvslXuEz
 cChZgwoYx3HXxspurjBy96qACG12A/2+VvgCgvS5hAs39evoFWJ82kGR9HSIXM8Z9L74F7gZzOr
 kaZAmMQuao1wFebicTVWhWwbxMeOaChLhJrvdIRvNFxyOiAwQjL1sMBHeT0uIDhBYD5o4QcXo5V
 jacXs3yvUV3OsuiP3XJ36z6Znp4G34=
X-Received: by 2002:a17:90a:c88f:b0:3a0:d20e:e2f1 with SMTP id
 98e67ed59e1d1-3a0d20ef68bmr4179875a91.10.1790499644863; 
 Sun, 27 Sep 2026 02:00:44 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 033/101] tcg: Drop division helpers
Date: Sun, 27 Sep 2026 01:59:03 -0700
Message-ID: <20260927090011.10724-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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

All current tcg hosts support division, so the helpers
are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h | 10 ----------
 accel/tcg/tcg-runtime.c | 44 -----------------------------------------
 tcg/tcg-op.c            | 16 +++++++--------
 3 files changed, 8 insertions(+), 62 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0b832176b33..003c963bc7d 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -1,13 +1,3 @@
-DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(remu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-
-DEF_HELPER_FLAGS_2(div_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 7c0aab98a80..77c4024148f 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -32,50 +32,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-/* 32-bit helpers */
-
-int32_t HELPER(div_i32)(int32_t arg1, int32_t arg2)
-{
-    return arg1 / arg2;
-}
-
-int32_t HELPER(rem_i32)(int32_t arg1, int32_t arg2)
-{
-    return arg1 % arg2;
-}
-
-uint32_t HELPER(divu_i32)(uint32_t arg1, uint32_t arg2)
-{
-    return arg1 / arg2;
-}
-
-uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
-{
-    return arg1 % arg2;
-}
-
-/* 64-bit helpers */
-
-int64_t HELPER(div_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 / arg2;
-}
-
-int64_t HELPER(rem_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 % arg2;
-}
-
-uint64_t HELPER(divu_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 / arg2;
-}
-
-uint64_t HELPER(remu_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 % arg2;
-}
-
 uint64_t HELPER(muluh_i64)(uint64_t arg1, uint64_t arg2)
 {
     uint64_t l, h;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d1cf0a436ea..67ba4a0307a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -619,7 +619,7 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_div_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -639,7 +639,7 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_rem_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -653,7 +653,7 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_divu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -673,7 +673,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_remu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1547,7 +1547,7 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_div_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1567,7 +1567,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_rem_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1581,7 +1581,7 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_divu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1601,7 +1601,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_remu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
-- 
2.53.0


