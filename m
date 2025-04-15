Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB859C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mKJ-0001T0-Fk; Tue, 15 Apr 2025 15:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mDq-0005Tl-BU
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:45:31 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mCk-0000Nn-8N
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:45:28 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6041e84715eso4131824eaf.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746253; x=1745351053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ddHX6akhLp9JHQTuFkW60luOpa0PgBDkTp/Z4DcS/C8=;
 b=WeLM0sslT/rqAu2UP/zbzvTTJf+lps9erEy5XPvw/o35r8g8o3fRUscp4j5wEurBqn
 gBOY+gssbbthQ8Ncuy4c6C08yHXl/fGsPaACfA1wwCWSYhf8jXD9YNLnfnfDlcGzJB80
 80ysViNec+vwvRjdJaOMHMuM/K9FJEJ/J70TSOhPKibAXWGvUfSpbbTWZF2Vs4L9fXdG
 X6/72PTNyOxhNHKiUa8rpU5drUUPZxrGYnFrQhY4MNtDi4H15EYNFwf1QaOAnYxW/CgK
 XQjXO8GldpuhGQg/vTe9fDT0JyYD1GRC3T14FVA2dONkzu5LMssVidMftdB0tiPhsNBV
 rzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746253; x=1745351053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddHX6akhLp9JHQTuFkW60luOpa0PgBDkTp/Z4DcS/C8=;
 b=u4IiLLFbytugVRTlSuCges55ZbxDbQ+I50bXIa4ngQibjnF1/rG+X8/wkfBvSRNRuj
 ssLbkyJWpoPg8irXxu9vdatn/m5ce8sYC7I6zZ6K/v34XyvVMEIDTNOAEBmPrRlZxzQw
 cIHY38XJBbbxXX4ov+WorRsnB97nLWNFwqhXlimNZWngN2UsL7jmPPqYfi2UyMRoLwcl
 UHPvM+hBhOK4GxuhxmVOr/VPW5rzHzKdkUcCoSy0HA3D1gOsVwcpnuwAe4M/kGEjRjM5
 98KogXbeOqNpPM0jcV8mZmfT7Yo+lPR4KuFgeiUKklEFwP1jNV1UkAL9iIoQ5bbCLlkz
 /cjw==
X-Gm-Message-State: AOJu0YwhpRduNNXYoebaLIZAtvc/T4fcA6XU8x3abgaxPnbmz2m0UYvx
 BTUAfGzVs0p+Vvhb2rByT3iLrIVlxrkAZ07VDNsoBxdJ7n+SahmzZMSuGjWtpiUnTwW4b1d4anW
 Z
X-Gm-Gg: ASbGnctVbDwgZNENxPnhPk3HomV5/zg8HU4oe5VZIgiuIiEB3WalGXB9Hku2UFfDWgf
 qZFQdoxa1lpxjPivHWXeNI7XaLstMiajCk3fareKILqLWZPZkzSgOnZhFMUHmLuio8/hA8tuU40
 3jcb4hnHHCqeJtJ+Mi2WctTd/fLEDcSrW2p40fVuuJBe4S4U6cEcMwLjgw0NDuhklBfKSHqKqaq
 U97rr4DH2UWCR8N6P8nZieZ9XdeSyEzNDObwBGmzioGq+SigjF7hoaeZkQSk7DRsG0LI6D4pkP8
 dVPc0t0iiEvKw3kgj6lF71/F5J+6FM82770fAp9T8gk8KpQq0jc0pIkUHXwr1tjvB1i2WXP7a2f
 Ryugj3lRZog==
X-Google-Smtp-Source: AGHT+IFg5FLRrkeVMM5hb4m0Q4OK10c3Cu5VHmphBemh5e2Xuf+FjoPJ3UcL0ZJBRvD4BQJ2ehvBkw==
X-Received: by 2002:a05:6a00:1911:b0:736:4704:d5da with SMTP id
 d2e1a72fcca58-73c1fb24d85mr969959b3a.22.1744745761900; 
 Tue, 15 Apr 2025 12:36:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 125/163] target/hppa: Use tcg_gen_addcio_i64
Date: Tue, 15 Apr 2025 12:24:36 -0700
Message-ID: <20250415192515.232910-126-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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


