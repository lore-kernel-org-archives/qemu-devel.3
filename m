Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8815CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mzj-0006tb-Ad; Thu, 16 Oct 2025 08:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyT-00055Q-HL
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyG-0000PZ-0Z
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so6143715e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617231; x=1761222031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BFIquFA1x9p7j057522NTBLcVfTrQz67mOeo2Cy2J/U=;
 b=gHCMmL0cky9S2IVYcjeCMvkfaf674g1z5I3f6K1IpbCIcIsxZUex3oUCSQ6QJie1EI
 UWRKsBUg4wZAQ5g5s7bYAa7LW90u3f91mczX6i8whiwuVTtnPL9BnvYzV84AebkFUnIv
 SIZeTg348ofCLvdwy20X60YczYYr8ZAJCL5bBZAApjGxiW/Ss7DoXbAWvZc1f/dt/8E6
 dKAiCS8mC+x/8LboP/9gDARvJ9u5eQzc8Hjrueq/z/iACiLqwM11s2AQUxBFUNQJeQxl
 EA/Bjkrv1O0fGxMvZeZvXUZIBsmPrDdVZWDvioYWl1Zw1bZs8tzCe5UjTmFUynPVje1z
 byYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617231; x=1761222031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFIquFA1x9p7j057522NTBLcVfTrQz67mOeo2Cy2J/U=;
 b=gQzaW6dPPd9ui82pfAJPLa9+vr7jArYA1CLYjTPaWNyNBCa8yELwDElluYx6WlCmyB
 0HEcHDOEvOvOSgYCuG0+WYcVQQQUqm/IKE8UFaGD0IJEE4Se+szuZtFyIW26/anDLu0r
 FDfoN3FAfPJKP77j0oRf0m6grSmrRr+JQ60SXVV4aDXnLApcuU6mcOE+DZzzSY135fy7
 DakJtMW/9RE0VFLUy3YVoCX7Ni6KUznflqwzKn19qo7ogrb6xt5S3UznQL/ksVzW3Kg1
 ogAGUJ5dTWJPuMqETGn0THNroFierFLtZL8qgBxKOjb4ZoewT+QuxOvkP1H1Z+O4dgdG
 CwSQ==
X-Gm-Message-State: AOJu0YwA8ggY8w1icGQYGZrmaSl3AJHVW9kyNs5uVz0OabXYQP81Nlx0
 czCUCHc5IpFDydL1tzzyQOWkJlSt1a/N3WVfxwXGYVwDD9+yp1slaQajUVfaXypJWcemUj2TFdC
 +Yyzc6eQ=
X-Gm-Gg: ASbGncvfh1JiB+EAIZ+nnMK6E8yJRua9uMTrcezj+i+RXjqZ4+ZkLPfMltyIg2XY3rv
 l5yPeQy00YKn+pOIx0RD0r/1s5WhzcZJ42L/mIebxdoTB1MJR1BlEvTfR5jHFItZPd8iPWKYiys
 BnGKYUbiEANtuLCGJy3UbdXgfxymbYETrWEH2deURwif5scHECtP7Et9KRaHri8SHDUjsbTLrlb
 5RWt6RZ0Z2j0N/p9p3y+cKHHbZw2liJFtgzSWl9aCqGcQ/PNi6uJ4MmPGHnpgQLe4kT/48YfuKd
 g8xz6O83DAeQvyqnbHNFV5liT3OrKbZWkNvbMiW3/8rgVRC/f7Wp8UD8LAzi5NQF5AG4xKA7YZO
 9llTes55jnJ7lDMyu/N5tGtaxakzbzFK/LkMG1b2jKhmlulnnUK2eCFNIDJPVfi3QSTvHK+rCp0
 +xZeCzIw4vuytIKAgtl30NZums2R2+capx2IPnljaYCYYkDRvPD57GCg==
X-Google-Smtp-Source: AGHT+IEshdAiLRtPm35Tp+tUyDH2P5qJQBmL7bkNqi5mtHufjOCU/Rvw3JpXt8qw02/vJgFFPaRPfQ==
X-Received: by 2002:a05:600c:8b76:b0:471:989:9d85 with SMTP id
 5b1f17b1804b1-4710989a0dbmr29880805e9.19.1760617230850; 
 Thu, 16 Oct 2025 05:20:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e13b6sm34763545f8f.44.2025.10.16.05.20.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/75] target/tricore: Replace target_ulong -> uint32_t in
 op_helper.c
Date: Thu, 16 Oct 2025 14:15:20 +0200
Message-ID: <20251016121532.14042-65-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The TriCore target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/tricore-*
  configs/targets/tricore-softmmu.mak:2:TARGET_LONG_BITS=32

Therefore target_ulong type always expands to uint32_t.

This is a mechanical replacement.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-7-philmd@linaro.org>
---
 target/tricore/op_helper.c | 219 +++++++++++++++++--------------------
 1 file changed, 103 insertions(+), 116 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 9910c13f4b5..610f148a237 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -149,15 +149,15 @@ static uint32_t ssov32(CPUTriCoreState *env, int64_t arg)
     if (arg > max_pos) {
         env->PSW_USB_V = (1 << 31);
         env->PSW_USB_SV = (1 << 31);
-        ret = (target_ulong)max_pos;
+        ret = (uint32_t)max_pos;
     } else {
         if (arg < max_neg) {
             env->PSW_USB_V = (1 << 31);
             env->PSW_USB_SV = (1 << 31);
-            ret = (target_ulong)max_neg;
+            ret = (uint32_t)max_neg;
         } else {
             env->PSW_USB_V = 0;
-            ret = (target_ulong)arg;
+            ret = (uint32_t)arg;
         }
     }
     env->PSW_USB_AV = arg ^ arg * 2u;
@@ -172,10 +172,10 @@ static uint32_t suov32_pos(CPUTriCoreState *env, uint64_t arg)
     if (arg > max_pos) {
         env->PSW_USB_V = (1 << 31);
         env->PSW_USB_SV = (1 << 31);
-        ret = (target_ulong)max_pos;
+        ret = (uint32_t)max_pos;
     } else {
         env->PSW_USB_V = 0;
-        ret = (target_ulong)arg;
+        ret = (uint32_t)arg;
      }
     env->PSW_USB_AV = arg ^ arg * 2u;
     env->PSW_USB_SAV |= env->PSW_USB_AV;
@@ -192,7 +192,7 @@ static uint32_t suov32_neg(CPUTriCoreState *env, int64_t arg)
         ret = 0;
     } else {
         env->PSW_USB_V = 0;
-        ret = (target_ulong)arg;
+        ret = (uint32_t)arg;
     }
     env->PSW_USB_AV = arg ^ arg * 2u;
     env->PSW_USB_SAV |= env->PSW_USB_AV;
@@ -260,8 +260,7 @@ static uint32_t suov16(CPUTriCoreState *env, int32_t hw0, int32_t hw1)
     return (hw0 & 0xffff) | (hw1 << 16);
 }
 
-target_ulong helper_add_ssov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_add_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -294,8 +293,7 @@ uint64_t helper_add64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return result;
 }
 
-target_ulong helper_add_h_ssov(CPUTriCoreState *env, target_ulong r1,
-                               target_ulong r2)
+uint32_t helper_add_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -397,8 +395,7 @@ uint32_t helper_addsur_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
 }
 
 
-target_ulong helper_add_suov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_add_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -406,8 +403,7 @@ target_ulong helper_add_suov(CPUTriCoreState *env, target_ulong r1,
     return suov32_pos(env, result);
 }
 
-target_ulong helper_add_h_suov(CPUTriCoreState *env, target_ulong r1,
-                               target_ulong r2)
+uint32_t helper_add_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -416,8 +412,7 @@ target_ulong helper_add_h_suov(CPUTriCoreState *env, target_ulong r1,
     return suov16(env, ret_hw0, ret_hw1);
 }
 
-target_ulong helper_sub_ssov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_sub_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -450,8 +445,7 @@ uint64_t helper_sub64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return result;
 }
 
-target_ulong helper_sub_h_ssov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_sub_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -552,8 +546,7 @@ uint32_t helper_subadr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-target_ulong helper_sub_suov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_sub_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -561,8 +554,7 @@ target_ulong helper_sub_suov(CPUTriCoreState *env, target_ulong r1,
     return suov32_neg(env, result);
 }
 
-target_ulong helper_sub_h_suov(CPUTriCoreState *env, target_ulong r1,
-                               target_ulong r2)
+uint32_t helper_sub_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -571,8 +563,7 @@ target_ulong helper_sub_h_suov(CPUTriCoreState *env, target_ulong r1,
     return suov16(env, ret_hw0, ret_hw1);
 }
 
-target_ulong helper_mul_ssov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_mul_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -580,8 +571,7 @@ target_ulong helper_mul_ssov(CPUTriCoreState *env, target_ulong r1,
     return ssov32(env, result);
 }
 
-target_ulong helper_mul_suov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_mul_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -590,8 +580,7 @@ target_ulong helper_mul_suov(CPUTriCoreState *env, target_ulong r1,
     return suov32_pos(env, result);
 }
 
-target_ulong helper_sha_ssov(CPUTriCoreState *env, target_ulong r1,
-                             target_ulong r2)
+uint32_t helper_sha_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int32_t t2 = sextract64(r2, 0, 6);
@@ -606,14 +595,14 @@ target_ulong helper_sha_ssov(CPUTriCoreState *env, target_ulong r1,
     return ssov32(env, result);
 }
 
-uint32_t helper_abs_ssov(CPUTriCoreState *env, target_ulong r1)
+uint32_t helper_abs_ssov(CPUTriCoreState *env, uint32_t r1)
 {
-    target_ulong result;
+    uint32_t result;
     result = ((int32_t)r1 >= 0) ? r1 : (0 - r1);
     return ssov32(env, result);
 }
 
-uint32_t helper_abs_h_ssov(CPUTriCoreState *env, target_ulong r1)
+uint32_t helper_abs_h_ssov(CPUTriCoreState *env, uint32_t r1)
 {
     int32_t ret_h0, ret_h1;
 
@@ -626,8 +615,7 @@ uint32_t helper_abs_h_ssov(CPUTriCoreState *env, target_ulong r1)
     return ssov16(env, ret_h0, ret_h1);
 }
 
-target_ulong helper_absdif_ssov(CPUTriCoreState *env, target_ulong r1,
-                                target_ulong r2)
+uint32_t helper_absdif_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -641,8 +629,7 @@ target_ulong helper_absdif_ssov(CPUTriCoreState *env, target_ulong r1,
     return ssov32(env, result);
 }
 
-uint32_t helper_absdif_h_ssov(CPUTriCoreState *env, target_ulong r1,
-                              target_ulong r2)
+uint32_t helper_absdif_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t t1, t2;
     int32_t ret_h0, ret_h1;
@@ -666,8 +653,8 @@ uint32_t helper_absdif_h_ssov(CPUTriCoreState *env, target_ulong r1,
     return ssov16(env, ret_h0, ret_h1);
 }
 
-target_ulong helper_madd32_ssov(CPUTriCoreState *env, target_ulong r1,
-                                target_ulong r2, target_ulong r3)
+uint32_t helper_madd32_ssov(CPUTriCoreState *env, uint32_t r1,
+                            uint32_t r2, uint32_t r3)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -678,8 +665,8 @@ target_ulong helper_madd32_ssov(CPUTriCoreState *env, target_ulong r1,
     return ssov32(env, result);
 }
 
-target_ulong helper_madd32_suov(CPUTriCoreState *env, target_ulong r1,
-                                target_ulong r2, target_ulong r3)
+uint32_t helper_madd32_suov(CPUTriCoreState *env, uint32_t r1,
+                            uint32_t r2, uint32_t r3)
 {
     uint64_t t1 = extract64(r1, 0, 32);
     uint64_t t2 = extract64(r2, 0, 32);
@@ -690,8 +677,8 @@ target_ulong helper_madd32_suov(CPUTriCoreState *env, target_ulong r1,
     return suov32_pos(env, result);
 }
 
-uint64_t helper_madd64_ssov(CPUTriCoreState *env, target_ulong r1,
-                            uint64_t r2, target_ulong r3)
+uint64_t helper_madd64_ssov(CPUTriCoreState *env, uint32_t r1,
+                            uint64_t r2, uint32_t r3)
 {
     uint64_t ret, ovf;
     int64_t t1 = sextract64(r1, 0, 32);
@@ -848,8 +835,8 @@ uint32_t helper_maddr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint64_t helper_madd64_suov(CPUTriCoreState *env, target_ulong r1,
-                            uint64_t r2, target_ulong r3)
+uint64_t helper_madd64_suov(CPUTriCoreState *env, uint32_t r1,
+                            uint64_t r2, uint32_t r3)
 {
     uint64_t ret, mul;
     uint64_t t1 = extract64(r1, 0, 32);
@@ -873,8 +860,8 @@ uint64_t helper_madd64_suov(CPUTriCoreState *env, target_ulong r1,
     return ret;
 }
 
-target_ulong helper_msub32_ssov(CPUTriCoreState *env, target_ulong r1,
-                                target_ulong r2, target_ulong r3)
+uint32_t helper_msub32_ssov(CPUTriCoreState *env, uint32_t r1,
+                            uint32_t r2, uint32_t r3)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -885,8 +872,8 @@ target_ulong helper_msub32_ssov(CPUTriCoreState *env, target_ulong r1,
     return ssov32(env, result);
 }
 
-target_ulong helper_msub32_suov(CPUTriCoreState *env, target_ulong r1,
-                                target_ulong r2, target_ulong r3)
+uint32_t helper_msub32_suov(CPUTriCoreState *env, uint32_t r1,
+                            uint32_t r2, uint32_t r3)
 {
     uint64_t t1 = extract64(r1, 0, 32);
     uint64_t t2 = extract64(r2, 0, 32);
@@ -912,8 +899,8 @@ target_ulong helper_msub32_suov(CPUTriCoreState *env, target_ulong r1,
     return result;
 }
 
-uint64_t helper_msub64_ssov(CPUTriCoreState *env, target_ulong r1,
-                            uint64_t r2, target_ulong r3)
+uint64_t helper_msub64_ssov(CPUTriCoreState *env, uint32_t r1,
+                            uint64_t r2, uint32_t r3)
 {
     uint64_t ret, ovf;
     int64_t t1 = sextract64(r1, 0, 32);
@@ -944,8 +931,8 @@ uint64_t helper_msub64_ssov(CPUTriCoreState *env, target_ulong r1,
     return ret;
 }
 
-uint64_t helper_msub64_suov(CPUTriCoreState *env, target_ulong r1,
-                            uint64_t r2, target_ulong r3)
+uint64_t helper_msub64_suov(CPUTriCoreState *env, uint32_t r1,
+                            uint64_t r2, uint32_t r3)
 {
     uint64_t ret, mul;
     uint64_t t1 = extract64(r1, 0, 32);
@@ -1097,7 +1084,7 @@ uint32_t helper_msubr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_abs_b(CPUTriCoreState *env, target_ulong arg)
+uint32_t helper_abs_b(CPUTriCoreState *env, uint32_t arg)
 {
     int32_t b, i;
     int32_t ovf = 0;
@@ -1120,7 +1107,7 @@ uint32_t helper_abs_b(CPUTriCoreState *env, target_ulong arg)
     return ret;
 }
 
-uint32_t helper_abs_h(CPUTriCoreState *env, target_ulong arg)
+uint32_t helper_abs_h(CPUTriCoreState *env, uint32_t arg)
 {
     int32_t h, i;
     int32_t ovf = 0;
@@ -1143,7 +1130,7 @@ uint32_t helper_abs_h(CPUTriCoreState *env, target_ulong arg)
     return ret;
 }
 
-uint32_t helper_absdif_b(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
+uint32_t helper_absdif_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r2;
@@ -1167,7 +1154,7 @@ uint32_t helper_absdif_b(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_absdif_h(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
+uint32_t helper_absdif_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r2;
@@ -1296,7 +1283,7 @@ uint32_t helper_maddr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_add_b(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
+uint32_t helper_add_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r1, extr_r2;
@@ -1322,7 +1309,7 @@ uint32_t helper_add_b(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_add_h(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
+uint32_t helper_add_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r1, extr_r2;
@@ -1451,7 +1438,7 @@ uint32_t helper_msubr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_sub_b(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
+uint32_t helper_sub_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r1, extr_r2;
@@ -1477,7 +1464,7 @@ uint32_t helper_sub_b(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_sub_h(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
+uint32_t helper_sub_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r1, extr_r2;
@@ -1502,7 +1489,7 @@ uint32_t helper_sub_h(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_eq_b(target_ulong r1, target_ulong r2)
+uint32_t helper_eq_b(uint32_t r1, uint32_t r2)
 {
     uint32_t ret, msk;
     int32_t i;
@@ -1519,7 +1506,7 @@ uint32_t helper_eq_b(target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_eq_h(target_ulong r1, target_ulong r2)
+uint32_t helper_eq_h(uint32_t r1, uint32_t r2)
 {
     int32_t ret = 0;
 
@@ -1534,7 +1521,7 @@ uint32_t helper_eq_h(target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_eqany_b(target_ulong r1, target_ulong r2)
+uint32_t helper_eqany_b(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1546,7 +1533,7 @@ uint32_t helper_eqany_b(target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_eqany_h(target_ulong r1, target_ulong r2)
+uint32_t helper_eqany_h(uint32_t r1, uint32_t r2)
 {
     uint32_t ret;
 
@@ -1556,7 +1543,7 @@ uint32_t helper_eqany_h(target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_lt_b(target_ulong r1, target_ulong r2)
+uint32_t helper_lt_b(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1570,7 +1557,7 @@ uint32_t helper_lt_b(target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_lt_bu(target_ulong r1, target_ulong r2)
+uint32_t helper_lt_bu(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1584,7 +1571,7 @@ uint32_t helper_lt_bu(target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_lt_h(target_ulong r1, target_ulong r2)
+uint32_t helper_lt_h(uint32_t r1, uint32_t r2)
 {
     uint32_t ret = 0;
 
@@ -1599,7 +1586,7 @@ uint32_t helper_lt_h(target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_lt_hu(target_ulong r1, target_ulong r2)
+uint32_t helper_lt_hu(uint32_t r1, uint32_t r2)
 {
     uint32_t ret = 0;
 
@@ -1615,7 +1602,7 @@ uint32_t helper_lt_hu(target_ulong r1, target_ulong r2)
 }
 
 #define EXTREMA_H_B(name, op)                                 \
-uint32_t helper_##name ##_b(target_ulong r1, target_ulong r2) \
+uint32_t helper_##name ##_b(uint32_t r1, uint32_t r2)         \
 {                                                             \
     int32_t i, extr_r1, extr_r2;                              \
     uint32_t ret = 0;                                         \
@@ -1629,7 +1616,7 @@ uint32_t helper_##name ##_b(target_ulong r1, target_ulong r2) \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_bu(target_ulong r1, target_ulong r2)\
+uint32_t helper_##name ##_bu(uint32_t r1, uint32_t r2)        \
 {                                                             \
     int32_t i;                                                \
     uint32_t extr_r1, extr_r2;                                \
@@ -1644,7 +1631,7 @@ uint32_t helper_##name ##_bu(target_ulong r1, target_ulong r2)\
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_h(target_ulong r1, target_ulong r2) \
+uint32_t helper_##name ##_h(uint32_t r1, uint32_t r2)         \
 {                                                             \
     int32_t extr_r1, extr_r2;                                 \
     uint32_t ret = 0;                                         \
@@ -1662,7 +1649,7 @@ uint32_t helper_##name ##_h(target_ulong r1, target_ulong r2) \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_hu(target_ulong r1, target_ulong r2)\
+uint32_t helper_##name ##_hu(uint32_t r1, uint32_t r2)        \
 {                                                             \
     uint32_t extr_r1, extr_r2;                                \
     uint32_t ret = 0;                                         \
@@ -1729,7 +1716,7 @@ EXTREMA_H_B(min, <)
 
 #undef EXTREMA_H_B
 
-uint32_t helper_clo_h(target_ulong r1)
+uint32_t helper_clo_h(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1747,7 +1734,7 @@ uint32_t helper_clo_h(target_ulong r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_clz_h(target_ulong r1)
+uint32_t helper_clz_h(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1765,7 +1752,7 @@ uint32_t helper_clz_h(target_ulong r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_cls_h(target_ulong r1)
+uint32_t helper_cls_h(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1783,7 +1770,7 @@ uint32_t helper_cls_h(target_ulong r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_sh(target_ulong r1, target_ulong r2)
+uint32_t helper_sh(uint32_t r1, uint32_t r2)
 {
     int32_t shift_count = sextract32(r2, 0, 6);
 
@@ -1796,7 +1783,7 @@ uint32_t helper_sh(target_ulong r1, target_ulong r2)
     }
 }
 
-uint32_t helper_sh_h(target_ulong r1, target_ulong r2)
+uint32_t helper_sh_h(uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
     int32_t shift_count;
@@ -1816,7 +1803,7 @@ uint32_t helper_sh_h(target_ulong r1, target_ulong r2)
     }
 }
 
-uint32_t helper_sha(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
+uint32_t helper_sha(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t shift_count;
     int64_t result, t1;
@@ -1854,7 +1841,7 @@ uint32_t helper_sha(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
     return ret;
 }
 
-uint32_t helper_sha_h(target_ulong r1, target_ulong r2)
+uint32_t helper_sha_h(uint32_t r1, uint32_t r2)
 {
     int32_t shift_count;
     int32_t ret_hw0, ret_hw1;
@@ -1874,7 +1861,7 @@ uint32_t helper_sha_h(target_ulong r1, target_ulong r2)
     }
 }
 
-uint32_t helper_bmerge(target_ulong r1, target_ulong r2)
+uint32_t helper_bmerge(uint32_t r1, uint32_t r2)
 {
     uint32_t i, ret;
 
@@ -1905,7 +1892,7 @@ uint64_t helper_bsplit(uint32_t r1)
     return ret;
 }
 
-uint32_t helper_parity(target_ulong r1)
+uint32_t helper_parity(uint32_t r1)
 {
     uint32_t ret;
     uint32_t nOnes, i;
@@ -1942,7 +1929,7 @@ uint32_t helper_parity(target_ulong r1)
 }
 
 uint32_t helper_pack(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
-                     target_ulong r2)
+                     uint32_t r2)
 {
     uint32_t ret;
     int32_t fp_exp, fp_frac, temp_exp, fp_exp_frac;
@@ -1983,7 +1970,7 @@ uint32_t helper_pack(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
     return ret;
 }
 
-uint64_t helper_unpack(target_ulong arg1)
+uint64_t helper_unpack(uint32_t arg1)
 {
     int32_t fp_exp  = extract32(arg1, 23, 8);
     int32_t fp_frac = extract32(arg1, 0, 23);
@@ -2408,7 +2395,7 @@ uint32_t helper_shuffle(uint32_t arg0, uint32_t arg1)
 
 /* context save area (CSA) related helpers */
 
-static int cdc_increment(target_ulong *psw)
+static int cdc_increment(uint32_t *psw)
 {
     if ((*psw & MASK_PSW_CDC) == 0x7f) {
         return 0;
@@ -2426,7 +2413,7 @@ static int cdc_increment(target_ulong *psw)
     return 0;
 }
 
-static int cdc_decrement(target_ulong *psw)
+static int cdc_decrement(uint32_t *psw)
 {
     if ((*psw & MASK_PSW_CDC) == 0x7f) {
         return 0;
@@ -2442,7 +2429,7 @@ static int cdc_decrement(target_ulong *psw)
     return 0;
 }
 
-static bool cdc_zero(target_ulong *psw)
+static bool cdc_zero(uint32_t *psw)
 {
     int cdc = *psw & MASK_PSW_CDC;
     /* Returns TRUE if PSW.CDC.COUNT == 0 or if PSW.CDC ==
@@ -2457,7 +2444,7 @@ static bool cdc_zero(target_ulong *psw)
     return count == 0;
 }
 
-static void save_context_upper(CPUTriCoreState *env, target_ulong ea)
+static void save_context_upper(CPUTriCoreState *env, uint32_t ea)
 {
     cpu_stl_data(env, ea, env->PCXI);
     cpu_stl_data(env, ea+4, psw_read(env));
@@ -2477,7 +2464,7 @@ static void save_context_upper(CPUTriCoreState *env, target_ulong ea)
     cpu_stl_data(env, ea+60, env->gpr_d[15]);
 }
 
-static void save_context_lower(CPUTriCoreState *env, target_ulong ea)
+static void save_context_lower(CPUTriCoreState *env, uint32_t ea)
 {
     cpu_stl_data(env, ea, env->PCXI);
     cpu_stl_data(env, ea+4, env->gpr_a[11]);
@@ -2497,8 +2484,8 @@ static void save_context_lower(CPUTriCoreState *env, target_ulong ea)
     cpu_stl_data(env, ea+60, env->gpr_d[7]);
 }
 
-static void restore_context_upper(CPUTriCoreState *env, target_ulong ea,
-                                  target_ulong *new_PCXI, target_ulong *new_PSW)
+static void restore_context_upper(CPUTriCoreState *env, uint32_t ea,
+                                  uint32_t *new_PCXI, uint32_t *new_PSW)
 {
     *new_PCXI = cpu_ldl_data(env, ea);
     *new_PSW = cpu_ldl_data(env, ea+4);
@@ -2518,8 +2505,8 @@ static void restore_context_upper(CPUTriCoreState *env, target_ulong ea,
     env->gpr_d[15] = cpu_ldl_data(env, ea+60);
 }
 
-static void restore_context_lower(CPUTriCoreState *env, target_ulong ea,
-                                  target_ulong *ra, target_ulong *pcxi)
+static void restore_context_lower(CPUTriCoreState *env, uint32_t ea,
+                                  uint32_t *ra, uint32_t *pcxi)
 {
     *pcxi = cpu_ldl_data(env, ea);
     *ra = cpu_ldl_data(env, ea+4);
@@ -2541,10 +2528,10 @@ static void restore_context_lower(CPUTriCoreState *env, target_ulong ea,
 
 void helper_call(CPUTriCoreState *env, uint32_t next_pc)
 {
-    target_ulong tmp_FCX;
-    target_ulong ea;
-    target_ulong new_FCX;
-    target_ulong psw;
+    uint32_t tmp_FCX;
+    uint32_t ea;
+    uint32_t new_FCX;
+    uint32_t psw;
 
     psw = psw_read(env);
     /* if (FCX == 0) trap(FCU); */
@@ -2604,9 +2591,9 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
 
 void helper_ret(CPUTriCoreState *env)
 {
-    target_ulong ea;
-    target_ulong new_PCXI;
-    target_ulong new_PSW, psw;
+    uint32_t ea;
+    uint32_t new_PCXI;
+    uint32_t new_PSW, psw;
 
     psw = psw_read(env);
      /* if (PSW.CDE) then if (cdc_decrement()) then trap(CDU);*/
@@ -2657,9 +2644,9 @@ void helper_ret(CPUTriCoreState *env)
 
 void helper_bisr(CPUTriCoreState *env, uint32_t const9)
 {
-    target_ulong tmp_FCX;
-    target_ulong ea;
-    target_ulong new_FCX;
+    uint32_t tmp_FCX;
+    uint32_t ea;
+    uint32_t new_FCX;
 
     if (env->FCX == 0) {
         /* FCU trap */
@@ -2701,9 +2688,9 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
 
 void helper_rfe(CPUTriCoreState *env)
 {
-    target_ulong ea;
-    target_ulong new_PCXI;
-    target_ulong new_PSW;
+    uint32_t ea;
+    uint32_t new_PCXI;
+    uint32_t new_PSW;
     /* if (PCXI[19: 0] == 0) then trap(CSU); */
     if ((env->PCXI & 0xfffff) == 0) {
         /* raise csu trap */
@@ -2762,35 +2749,35 @@ void helper_rfm(CPUTriCoreState *env)
     }
 }
 
-void helper_ldlcx(CPUTriCoreState *env, target_ulong ea)
+void helper_ldlcx(CPUTriCoreState *env, uint32_t ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and RA */
     restore_context_lower(env, ea, &dummy, &dummy);
 }
 
-void helper_lducx(CPUTriCoreState *env, target_ulong ea)
+void helper_lducx(CPUTriCoreState *env, uint32_t ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and PSW */
     restore_context_upper(env, ea, &dummy, &dummy);
 }
 
-void helper_stlcx(CPUTriCoreState *env, target_ulong ea)
+void helper_stlcx(CPUTriCoreState *env, uint32_t ea)
 {
     save_context_lower(env, ea);
 }
 
-void helper_stucx(CPUTriCoreState *env, target_ulong ea)
+void helper_stucx(CPUTriCoreState *env, uint32_t ea)
 {
     save_context_upper(env, ea);
 }
 
 void helper_svlcx(CPUTriCoreState *env)
 {
-    target_ulong tmp_FCX;
-    target_ulong ea;
-    target_ulong new_FCX;
+    uint32_t tmp_FCX;
+    uint32_t ea;
+    uint32_t new_FCX;
 
     if (env->FCX == 0) {
         /* FCU trap */
@@ -2831,9 +2818,9 @@ void helper_svlcx(CPUTriCoreState *env)
 
 void helper_svucx(CPUTriCoreState *env)
 {
-    target_ulong tmp_FCX;
-    target_ulong ea;
-    target_ulong new_FCX;
+    uint32_t tmp_FCX;
+    uint32_t ea;
+    uint32_t new_FCX;
 
     if (env->FCX == 0) {
         /* FCU trap */
@@ -2874,8 +2861,8 @@ void helper_svucx(CPUTriCoreState *env)
 
 void helper_rslcx(CPUTriCoreState *env)
 {
-    target_ulong ea;
-    target_ulong new_PCXI;
+    uint32_t ea;
+    uint32_t new_PCXI;
     /*   if (PCXI[19: 0] == 0) then trap(CSU); */
     if ((env->PCXI & 0xfffff) == 0) {
         /* CSU trap */
-- 
2.51.0


