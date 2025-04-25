Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465C7C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBC-0004N3-UB; Fri, 25 Apr 2025 18:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAt-0003gP-1k
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:40 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAp-0001qW-Rd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:33 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so2355432b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618730; x=1746223530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbSVy3Es7yY894Px54QTOXJuGag8hqcwPgRRTGQnAbA=;
 b=goRO7ge/NQeGqwMxBA+e5hr8HLOrZN04Ino9OOA8HUTI/EG1E6gvieVJ5OOSreQdMW
 zScCPKf1lsZvPM+QnlleJv3OD7u0J6LD6mi0myTBw4alc/GLSSulwIvGpXTNfoU+w7Z7
 YvZV7OXIjanhr3tX43isbtYLPJ/7UCaydd6LnXCcmqSLOZaCz1NOWLyMsUZByagt7g4f
 4yZ/pOoDjQUfBn2OT8487/DP/v/UMr23Icnv+KnrqCCRL3mvjrTk0Y0Y9OrG/BlhSXpT
 Mk2HG71cusbT4LwnxhqoREvGwJ/arDRGPntWg/iXH8hWsPAq+czFaxaugd7+4TDcu+Tl
 XBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618730; x=1746223530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbSVy3Es7yY894Px54QTOXJuGag8hqcwPgRRTGQnAbA=;
 b=I/Kqqv+VjzPAFO0oYNqxjVv9zmzaBioVtevkunaZbcIsbRNqhnf9TfXdF68lYNC6Fc
 d43VxpbZUDo/2IXf3ng3XQKqnV2qCIZAaL1znRsa2sSE5GNBMvtkSA8ymCExGWoa5qeb
 J+3ELaEtkIL7Bea6RKJQVwZ+Ou8mEnibEEemlnZ5K0PPL3RdY52jOL2EBtEJsPegeNub
 HZsKIsB/lgaWpW0lg2tivQ6ZiHVklpuN33TNljzOxUVGi8CVQwYaR2TTDhHxmBRqavF2
 9WR46brIFm7L6BZQyzhm3uUYDkulMwixz7hHRdy3cGHMrROnRj/SFvXcfhX+KXmS/N5W
 NhHQ==
X-Gm-Message-State: AOJu0YzsnIaRDQjIuM2/KEtpl9HY2G++8vNWoAb8wjOmt2anQsw+o89w
 pflKbjDd1rGNy1V6YJ2g//mOPEc+TXHkPYY8ycFqfj9TlyvQIQyw6ZKzH2sTKjBb85O7hMzhKk4
 6
X-Gm-Gg: ASbGncsRnA19iXvoB+cNDRhw4N8oiT1WOl8cCZdjpIKS4O0J3iKEFc8fVdgEAo3kWlT
 f3qCCT91YfU4tbgQxY6/DvWQhftE6dRGgpMucsCVl/S0yP6rTXtW6lSXGUKWTYvEanEy2W965PW
 ABoFUZRm1q4QoGvqoeuLdjCptLRDfjc9d3HSXkJODH9YVdG9FZIWtnnjVI8/dN4wPbpxUAIaDTu
 a3GPS3bYmWFvHfMshepQRzet5uQRG0yaRMXR1MwQDP155k1QMH295HHdmC7vCTYnDhKnMxY4AsN
 RxdCLcznPLVGbSunnJoYWJ/LOzNQxrk+ZfYXFIJYlDc7i3ROrXsxWOTR9MpaEHaiPAguq9tzPHE
 =
X-Google-Smtp-Source: AGHT+IFSFapluGClI9yNQko/0OL/qUQJ7Z554GrKH2YKt7aICvTIqTw3ah0EpcgOnqIGAWDG4DTH7A==
X-Received: by 2002:a05:6a00:3a12:b0:73e:2dc8:94f3 with SMTP id
 d2e1a72fcca58-73ff725247amr1320768b3a.1.1745618730072; 
 Fri, 25 Apr 2025 15:05:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 128/159] target/hppa: Use tcg_gen_addcio_i64
Date: Fri, 25 Apr 2025 14:54:22 -0700
Message-ID: <20250425215454.886111-129-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 14f3833322..88a7d339eb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1209,10 +1209,10 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
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
@@ -1308,9 +1308,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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
@@ -3008,9 +3006,7 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     tcg_gen_xor_i64(add2, in2, addc);
     tcg_gen_andi_i64(addc, addc, 1);
 
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, ctx->zero, add2, ctx->zero);
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb,
-                     addc, ctx->zero);
+    tcg_gen_addcio_i64(dest, cpu_psw_cb_msb, add1, add2, addc);
 
     /* Write back the result register.  */
     save_gpr(ctx, a->t, dest);
@@ -3553,8 +3549,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
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


