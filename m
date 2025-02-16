Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7177C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyI-0007TZ-1P; Sun, 16 Feb 2025 18:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwV-00045a-8A
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:58 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwO-0006QO-OY
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:54 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so5406221a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748047; x=1740352847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ddHX6akhLp9JHQTuFkW60luOpa0PgBDkTp/Z4DcS/C8=;
 b=tq3MwwXhX1huasDInLHGLVesdP/xCe8q5EUuhaw4gGl3lbMhuXusLSZsHjD2C/tHgo
 wWGQlfVmyWCTAMcXTaBd0je3xIUMyMyBSLKasJbwTXtPANoKWRrZvVIWA3LITZ/FI16A
 t40RxYUi3pafOzhf+Opp7SFSKlETF6w86YVzTrvqLHGnGpEcY/9oMYvM8fM9+Lz+RW4U
 ehGjRT9SPQEiXY6sWfU+VBpAnf0Ao3+U9iAJsc8/ErF0+NyuNQ/1INAnLUS1UinJKIK0
 IgsA4H9A8wK1b/VOnvaCgaBLPglycsh6jz3Y1LbuMOtMDKlZri7cCv5YRNBcvbBqi+Us
 hnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748047; x=1740352847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddHX6akhLp9JHQTuFkW60luOpa0PgBDkTp/Z4DcS/C8=;
 b=W824HNWdiKwyzYoxnkB+gkrxeIteBQoW/z5LR4yCWS4GY28BfEvU9qDUmWNAHstJH9
 zttvFGx4P9dSUEjyf252Cc5O3GsUCJMOMzoOmBWXGD10qnnYZ1RayIlbZIjoVeNYk54t
 MR3L2lF+3K6XcRbRIwIBuxuZ96c5Z8HwA/rPTHkqHlQZ+XAkfHr16f4PoppZEy2iU0x5
 Dfzp5AncHpODEwKmZ6H7Ug/3JoRoaKA2/QaGy89HAGTKAhMhh0fehOVf2iz5peJWpkb0
 cqQ5ig/UdQK9iHJBg9tRrZ4zCgsuXj5vl0XauIHy8Tx+koqQ9xsPBT7+M5lFswFEwxes
 oUqw==
X-Gm-Message-State: AOJu0YyvtcqwPLXb5U/ECk3LV+T0prZwpzT/SY55L3c2JKfncBn2yElm
 9wyvzuAYfNEKDQzDvs8g3anylNMGa2u+eUaPTcqkDYtVt7MPDr7HOkXxhACVL9QnvJpMxzwzD1V
 G
X-Gm-Gg: ASbGncsk5h0PqZgA4q1QWDPteXgoRqIf36DmMs5XDhoLwI5fid8C9+VQi+ZMyCl6hkc
 g42djJWLvoIOyQqYv10kf8WnfeXrX+sjvNpGLU5VEGT2OVIIgf7xN7WOKfghDtY1H9x1yJs2dzy
 BbUzxhkAwIYjU9ElIjBNpvfNpCr3TEDBsch8/3eaaey5jzeDhWxivD99eTU5QHtD6uRnskaxQwD
 xez0PBHpAy2GSFeSj45bb5WlZ96xA2QCgdZ3QtL2DQGp+MhKVxmnZFeOTJN56yQd9aSEXMDVCDh
 K10viGdnuG+uFkdvB3L4lIys2UpM7VcHXMGBvNb9R8IKQjI=
X-Google-Smtp-Source: AGHT+IH/A0IEl1uoUTkhiuE0bacqmEbhI00OsQ0wgDXFJsYrY3Q35Xd9DKsBLECXAYv6dYfGGyLKIg==
X-Received: by 2002:a17:90b:510c:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-2fc407909a0mr14394854a91.0.1739748047307; 
 Sun, 16 Feb 2025 15:20:47 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 124/162] target/hppa: Use tcg_gen_addcio_i64
Date: Sun, 16 Feb 2025 15:09:33 -0800
Message-ID: <20250216231012.2808572-125-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Use this in do_add, do_sub, and do_ds, all of which need
add with carry-in and carry-out.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0d0d1bc99b..c92b09bae2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1208,10 +1208,10 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
         cb_msb = tcg_temp_new_i64();
         cb = tcg_temp_new_i64();
 
-        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
         if (is_c) {
-            tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb,
-                             get_psw_carry(ctx, d), ctx->zero);
+            tcg_gen_addcio_i64(dest, cb_msb, in1, in2, get_psw_carry(ctx, d));
+        } else {
+            tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
         }
         tcg_gen_xor_i64(cb, in1, in2);
         tcg_gen_xor_i64(cb, cb, dest);
@@ -1307,9 +1307,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_b) {
         /* DEST,C = IN1 + ~IN2 + C.  */
         tcg_gen_not_i64(cb, in2);
-        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero,
-                         get_psw_carry(ctx, d), ctx->zero);
-        tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb, cb, ctx->zero);
+        tcg_gen_addcio_i64(dest, cb_msb, in1, cb, get_psw_carry(ctx, d));
         tcg_gen_xor_i64(cb, cb, in1);
         tcg_gen_xor_i64(cb, cb, dest);
     } else {
@@ -3007,9 +3005,7 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     tcg_gen_xor_i64(add2, in2, addc);
     tcg_gen_andi_i64(addc, addc, 1);
 
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, ctx->zero, add2, ctx->zero);
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb,
-                     addc, ctx->zero);
+    tcg_gen_addcio_i64(dest, cpu_psw_cb_msb, add1, add2, addc);
 
     /* Write back the result register.  */
     save_gpr(ctx, a->t, dest);
@@ -3552,8 +3548,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
         TCGv_i64 cb = tcg_temp_new_i64();
         TCGv_i64 cb_msb = tcg_temp_new_i64();
 
-        tcg_gen_movi_i64(cb_msb, 0);
-        tcg_gen_add2_i64(dest, cb_msb, in1, cb_msb, in2, cb_msb);
+        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
         tcg_gen_xor_i64(cb, in1, in2);
         tcg_gen_xor_i64(cb, cb, dest);
         cb_cond = get_carry(ctx, d, cb, cb_msb);
-- 
2.43.0


