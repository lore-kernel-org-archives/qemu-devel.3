Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9304AC88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1l-0005Fx-JK; Sat, 12 Sep 2026 06:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1Z-0004uH-LH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1X-0007Kn-RV
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso1340725a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209114; x=1789813914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d/utpiSLJ4thZkKdY8TN0iwwCU19SmKE33ir59n4nlk=;
 b=ahuEQwtL3YelMN9zqHme7SiiUbUtqUYcYcoK/Kgm04pfoRCvAUcg9eGqXj5umg0qJ6
 zipfBvMklfb3wjof7BtWqF2M30wV56c/qjH1zy4d/4URUkWhHWUoXEh4eWWUz2XDImhR
 u7efZgXrtmo4ff8Bx4X4Y0HsSuq8stVjw7hrizKSKEiTSYc9Zu0u6APmjoKmc1sbkBxV
 DTwB1pOZuHLToUpEbSm3NhUOhSzBjTkRh/OkoygVj19DysLW9Xw9kWWT705i6Jiphg6z
 P1+q16zLQ1u6LNB+qOzzx48cBjufXTL4kk0goLWtofADUoI85QUWXnoiO3nXvPgKSXsu
 ea8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209114; x=1789813914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d/utpiSLJ4thZkKdY8TN0iwwCU19SmKE33ir59n4nlk=;
 b=f6BUGscicu99Rldnig26A7nHc/ojWFcULbL7T8zqarIGluOJIgWBV3L4aEs8fcrwcv
 940NOudjDIGiBoMroGHFlK3kPiTfW8wniY7ATYLOcKGRzr8yfPQqGiN7TD4HRnSg0FqD
 7ZU4GrwE+qMWt33TEGFP8SsIu+vJgPbYRao2gr8QTDY4zA/HkdGCkM+2NbWnRCmzC4Jq
 IgybbzMKc5yK4+GKafpXqsvUGlBiAb6yvKdZV0HiieeSnXQLNXMdJMPuyK5/IxDZUHJu
 g99AD2LZ7qW36QVrYtls8+AvSecgF1xUdCXwHICJ+CiAeasyU9WpC91/kaNo8nC3D/li
 Aw9A==
X-Gm-Message-State: AFuF++k0lFvuX8AHwc8HIeiECAsExBpy9YWhcwMvJgPhb+fSTlPKb0iX
 4ZnkdeblFzsk8cWPKaIfOuHG4rEu07pJ2kOh1/NOshPlhVz0+8wOnAQjxBCV/Qhx8aoQcj45VGM
 D5JbJjzU=
X-Gm-Gg: AYBFou3fZJaSUqB9d63qSs8GYdCzgMMpGauHnTTG+qGNHZAoZFSEB9dWJnJIoHHxfH0
 /EagUGt+jiLKCa8ueGjyy1AxG5Vq+48qbPBFdMz9o8Ynwz0Uvn7B17p9GEVeT0LvFqeIlZGmB3O
 XBq0WjjLt0ze1ysT7axGl1dBxwWbe/pzDt5vLzcTnywvG+wQO+e8atqWHYDGglrRF9dfZmT8aVW
 ydVRf2EnIDo0AoGqGOCfCOepQt/XJkGAfHBKVPy31M6Fkp3pDcT16JvM3KIYUH68y+xwUS/9Y3q
 ii5F2uNaaEi6Qv9t/oAcwtXKD6zRI2LFzERIdhU1hMZb6r61LBpn2hXe2phtqrrnrM+3txRsHZ5
 K4BiVoxJzUK18JjTJwZv/byOJrytSXnimtg53qYkeiOdxTaDuhAxCuloRb/X3s1Bd3rHq0ihjOC
 ZYxnGVza7w2qnSYpZRijvD+2urE3YOhe0ZQ1hlHBJQuQc8CZbsxNrbFFZw5Zg12o3KSCN0U9URp
 PEYJRzZ
X-Received: by 2002:a17:90b:2b50:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-39d9c1c199dmr14594181a91.14.1789209114120; 
 Sat, 12 Sep 2026 03:31:54 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/82] tcg: Drop division helpers
Date: Sat, 12 Sep 2026 00:30:31 -1000
Message-ID: <20260912103126.598030-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
index bf48db8b684..26e1d441661 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -652,7 +652,7 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_div_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -672,7 +672,7 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_rem_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -686,7 +686,7 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_divu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -706,7 +706,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_remu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1580,7 +1580,7 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_div_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1600,7 +1600,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_rem_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1614,7 +1614,7 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_divu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1634,7 +1634,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_remu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
-- 
2.53.0


