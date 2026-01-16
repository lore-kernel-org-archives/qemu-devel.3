Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C2AD4A5FA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacS-0001wh-9l; Thu, 15 Jan 2026 22:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacQ-0001n2-Iy
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:26 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacO-0006Hu-IF
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:26 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso1387890b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534523; x=1769139323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmAp6PNa9duSslOM86Ejx4hWWn+4Ohddq0ga5kua76c=;
 b=TpW9ztJO/solssyoyb+xjMzSRnAeaY6jo/mkr30wB/IanhvmpEQMQ/QpJxpWwRjNAZ
 /Pr0iNpzY1BQI7tmbJlgYV8o+MiiKls25u9C7WKjyk3nFMEUaW8/8zYRhRZLJxFq4ijf
 la5NAzGZr1zW9sHreU3RfsYA7MG/xYemyIwIW4f04812I3hYYlCPx5HAp75pBiE/qg+V
 oMydXHzpknRPsMHkgxI4Xp59iZYM9w5uStdXx7JbKbRatwobo8WMQ9pmO4YzEFmV/PWR
 4ySFQZd7+JnTDAbORe7wEenTNCFyR1tV/THcoSCcy4pv5KkSFyYf/l7+pSG2bDNKTj5s
 Ywvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534523; x=1769139323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qmAp6PNa9duSslOM86Ejx4hWWn+4Ohddq0ga5kua76c=;
 b=ucKzcixNhnsvf8PhK+bTwARaLuE4VMe/v+28cIvOD/mPVtOzL/uKI3wOP7krarfWyZ
 WO0K6ftp5h3dsOybVikl9UIEYxtM9pnWd4VSfEIqiumwCMS6k0poKmZsYGBSek4AgIuJ
 1x/IusR0uycojWsm6kISXxoIe1IrmRaVYAZ+Aka81WtY0FV6p6h42TXabYcpyFQs4/4k
 KdTVHkh/8d6c7JySEWWtWhqeqKhDXU3Y+a2TWk11jfV6ZQPQA9RfdKvhqT56VxxfF4uC
 qjmQSVpntztNMe6M865zniBJxAbnc/YfdDq9Fd5iE0yGvM8vLU7kuaDU8RpBzwDDC9/D
 zS6g==
X-Gm-Message-State: AOJu0YwLCDGGrCiO5QocYiS0ErQmVMYGzbODIDEkgq3//+DpQjJ1I1i+
 WyLrxRqpHUYI9SXcUrSs5yJ+A5P6LMS45Xip8UNtbtCVgGdcvDkVJfgzftHrWMoh8XaBBL2/g6j
 7KV4dhgNNtw==
X-Gm-Gg: AY/fxX6RmnI4UhszfNj1nXZijskAeG7dEFUxCqIVbGOZtJFnBOcS1rfpvEqsO3C5Kzl
 rtgy6cUKj/mU4pBsgrxZLmHyq3L+vmDkv0wgSQ4duV0XHbjbGfB9mSW17ToGtPDIZRpEbS79HUd
 yzDOYPof+ZDYaE2RrWAS0tKLODqOT0XwPjBsoLygGW834NxBpxkpv0LBxkjmYL5sElWAI40FcOW
 p9NHJFvS7KZuOiYVRbsSX8tuEMizA5blq7JH1YiD8EJB4SM0uBtobhotsy9LpyUio9fur36C/8e
 MOsz4nwsL5cFgpLi93LVr/df/yyzwliTXE2JdL4Ki2FN5FME50Ph+WlYZ9aRHwxJFzxoHaUHgQO
 EgeHYOI7owd69ohKfckmu0UQ6gRHUlfv5ev4Zp/Va8GYUEDpb80uIz1r1d4IhUECt00M+rtPejG
 XAsEwJGgIhGtsZ+i642Q/DZuKQwKXk
X-Received: by 2002:a05:6a00:4c94:b0:81f:4dfe:dddc with SMTP id
 d2e1a72fcca58-81f9f7f65edmr1622709b3a.13.1768534523143; 
 Thu, 15 Jan 2026 19:35:23 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 33/58] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-gvec.c
Date: Fri, 16 Jan 2026 14:32:39 +1100
Message-ID: <20260116033305.51162-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2cfc7e9409..bc323e2500 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -586,12 +586,11 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
         }
     }
 
-    /* Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and no variable dup.
+    /*
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 with 64-bit variable dup.
      */
-    type = choose_vector_type(NULL, vece, oprsz,
-                              (TCG_TARGET_REG_BITS == 64 && in_32 == NULL
-                               && (in_64 == NULL || vece == MO_64)));
+    type = choose_vector_type(NULL, vece, oprsz, vece == MO_64 && in_64);
     if (type != 0) {
         TCGv_vec t_vec = tcg_temp_new_vec(type);
 
@@ -612,11 +611,11 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
         t_32 = NULL;
 
         if (in_32) {
-            /* We are given a 32-bit variable input.  For a 64-bit host,
-               use a 64-bit operation unless the 32-bit operation would
-               be simple enough.  */
-            if (TCG_TARGET_REG_BITS == 64
-                && (vece != MO_32 || !check_size_impl(oprsz, 4))) {
+            /*
+             * We are given a 32-bit variable input.  Use a 64-bit operation
+             * unless the 32-bit operation would be simple enough.
+             */
+            if (vece != MO_32 || !check_size_impl(oprsz, 4)) {
                 t_64 = tcg_temp_ebb_new_i64();
                 tcg_gen_extu_i32_i64(t_64, in_32);
                 tcg_gen_dup_i64(vece, t_64, t_64);
@@ -629,14 +628,16 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
             t_64 = tcg_temp_ebb_new_i64();
             tcg_gen_dup_i64(vece, t_64, in_64);
         } else {
-            /* We are given a constant input.  */
-            /* For 64-bit hosts, use 64-bit constants for "simple" constants
-               or when we'd need too many 32-bit stores, or when a 64-bit
-               constant is really required.  */
+            /*
+             * We are given a constant input.
+             * Use 64-bit constants for "simple" constants or when we'd
+             * need too many 32-bit stores, or when a 64-bit constant
+             * is really required.
+             */
             if (vece == MO_64
-                || (TCG_TARGET_REG_BITS == 64
-                    && (in_c == 0 || in_c == -1
-                        || !check_size_impl(oprsz, 4)))) {
+                || in_c == 0
+                || in_c == -1
+                || !check_size_impl(oprsz, 4)) {
                 t_64 = tcg_constant_i64(in_c);
             } else {
                 t_32 = tcg_constant_i32(in_c);
@@ -3872,12 +3873,11 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     /*
-     * Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and 64-bit comparison.
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 for a 64-bit comparison.
      */
     hold_list = tcg_swap_vecop_list(cmp_list);
-    type = choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    type = choose_vector_type(cmp_list, vece, oprsz, vece == MO_64);
     switch (type) {
     case TCG_TYPE_V256:
         /* Recall that ARM SVE allows vector sizes that are not a
@@ -3992,11 +3992,10 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     /*
-     * Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and 64-bit comparison.
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 for a 64-bit comparison.
      */
-    type = choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    type = choose_vector_type(cmp_list, vece, oprsz, vece == MO_64);
     if (type != 0) {
         const TCGOpcode *hold_list = tcg_swap_vecop_list(cmp_list);
         TCGv_vec t_vec = tcg_temp_new_vec(type);
-- 
2.43.0


