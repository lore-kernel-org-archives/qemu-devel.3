Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B78ACFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcyz-00040e-5r; Fri, 21 Nov 2025 21:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMc96-00067H-Oj
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:10:36 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMc8v-0004O2-7Z
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:10:33 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640c6577120so4506686a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763773803; x=1764378603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idPfVbwdmuwP3E4rOS4isKmneb6eqTi31QSmeF+nOd0=;
 b=bGNkdO0uXS3PeVL8/SDei1gP1ERmThgkM7k2ADs5AzY1nfkHfIq76pXunWq8US09vb
 l142eDQyX4qvlWzv/yZtZ1d/hd48qbrBaE7a51AoNS74ae0+BMpNDGeLpYN0LrIqu3vm
 JAVTXz+ijitAvLwYEtRODIxlrYNVx2VDA2nBhCh85xV/SJIC1j+nsfGuVGujDDGZVkPb
 PLrFQLg6qlmP2w8F9TMkXmjzIeRvyb9bRkjwsWHfAjcOA5h9YWPliEAYEUgKAEkrsJeP
 4s/K2PeNkuUNd692Mx9yHCgJ6vzPSGJDIQv+il1HAoyLBsYDoS/sSKR/SrPktfE1/vFT
 ZFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763773803; x=1764378603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=idPfVbwdmuwP3E4rOS4isKmneb6eqTi31QSmeF+nOd0=;
 b=cY69+NbS2zyr5Kpe4M4LdJIyNzzj7/Utu6UglfaDuu1jfW2pHcSsGnNTJWv7LAMh/G
 ZijmvfmHKVikPmvw130JvIgM0reDMn1CptlnlxbJmPoCcXPUtOPexIDjzlpIIOkwvG0S
 pL/Pu1bXI6jKwdnm6zVA4/pAqgoWi02TgNme4J4Jum56DBL9qqfl0J/5qtCZo5eKGzCy
 u9vsuhIRYoc5WHEzpxsDnwY0n5r6IMukrsAp4zqLaY4dbOz7UgmNyYNyq/F66cYDEM8s
 9q7oBrGS2Gqipi2aeSXvMFrXEl7sySgTRW1agLLGgI8PoRqD6beF/gzYQQ85Tme5lVAM
 akRA==
X-Gm-Message-State: AOJu0YzlQ/jXacF5MpQQhHDJI07S5ELzJ2CZsdHHCCJde9UjXo8X1zMV
 oipOmTRy+blkokV2LjM88pGXOUsPqylMvcHxOSTB1Zg4lKD9AT6ErhNY/oETS589KekJ6/doQSQ
 D6SkwAibNmA==
X-Gm-Gg: ASbGncuBolYqjWk7H3p1hq5c2kWY197NGzPS4JaPZzX9ZRQA/maYES4luy/IwNJpBiK
 VHmBMetXiMQQXwROcph6YpaTua/mC4ItDUQvSJZ7/Ll/BTb6+m+5t9l2XoGTU6mkgG8T1zHFJVG
 /9rXUzFvkkBj12jCejjBABPM664PPd/0OkNWdXDMFqFfDD3ieQfKUsBYDR8alEidIPMY1m9mMYm
 LJ/esFI06VeCk3fA0ik9+AoyG4lNnLbcJVW7sl/IV6V6m5SueL1LGjupWMKBPv7Df6sXYJncMTw
 8eBXLuD7MsU32qs2lHgPBS77SOFzgW0aHpIJe0daegkOywP97p6pjFwcVKA2f3s3r4Ynl0anUbo
 zFJ1gbYaRMvUeXdenRqFXNb0/VQOdX4jvsQnWur/wgACRBWSaCLTpF31qe541Yv+nkerXu3ip8Y
 2YV+AenNcWFV2Zl0qpAxmnqExRbvdbMpMCnnzIY9UC5Ga7YMRxNKGCb9paZkMK
X-Google-Smtp-Source: AGHT+IH+uEE+/4R1zJ5ztiI6Pff08c5Gs3ZGj74tnpiLS+8MRfOsoHT0hEwp923OtZbxPABO7cZTFA==
X-Received: by 2002:a05:600c:3baa:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-477c01ecc7cmr24811975e9.34.1763732818671; 
 Fri, 21 Nov 2025 05:46:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9d198a0sm89777255e9.1.2025.11.21.05.46.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 17/21] target/hppa: Use little-endian variant
 of cpu_ld/st_data*()
Date: Fri, 21 Nov 2025 14:44:59 +0100
Message-ID: <20251121134503.30914-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

We only build the HPPA target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=hppa; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/op_helper.c | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 0458378abb2..65faf03cd0a 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -107,7 +107,7 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
         cpu_stb_data_ra(env, addr, val, ra);
         break;
     case 2:
-        cpu_stw_data_ra(env, addr, val, ra);
+        cpu_stw_be_data_ra(env, addr, val, ra);
         break;
     case 1:
         /* The 3 byte store must appear atomic.  */
@@ -115,11 +115,11 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
             atomic_store_mask32(env, addr, val, 0x00ffffffu, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 16, ra);
-            cpu_stw_data_ra(env, addr + 1, val, ra);
+            cpu_stw_be_data_ra(env, addr + 1, val, ra);
         }
         break;
     default:
-        cpu_stl_data_ra(env, addr, val, ra);
+        cpu_stl_be_data_ra(env, addr, val, ra);
         break;
     }
 }
@@ -132,7 +132,7 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
         cpu_stb_data_ra(env, addr, val, ra);
         break;
     case 6:
-        cpu_stw_data_ra(env, addr, val, ra);
+        cpu_stw_be_data_ra(env, addr, val, ra);
         break;
     case 5:
         /* The 3 byte store must appear atomic.  */
@@ -140,11 +140,11 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask32(env, addr, val, 0x00ffffffu, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 16, ra);
-            cpu_stw_data_ra(env, addr + 1, val, ra);
+            cpu_stw_be_data_ra(env, addr + 1, val, ra);
         }
         break;
     case 4:
-        cpu_stl_data_ra(env, addr, val, ra);
+        cpu_stl_be_data_ra(env, addr, val, ra);
         break;
     case 3:
         /* The 5 byte store must appear atomic.  */
@@ -152,7 +152,7 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr, val, 0x000000ffffffffffull, 5, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 32, ra);
-            cpu_stl_data_ra(env, addr + 1, val, ra);
+            cpu_stl_be_data_ra(env, addr + 1, val, ra);
         }
         break;
     case 2:
@@ -160,8 +160,8 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
         if (parallel) {
             atomic_store_mask64(env, addr, val, 0x0000ffffffffffffull, 6, ra);
         } else {
-            cpu_stw_data_ra(env, addr, val >> 32, ra);
-            cpu_stl_data_ra(env, addr + 2, val, ra);
+            cpu_stw_be_data_ra(env, addr, val >> 32, ra);
+            cpu_stl_be_data_ra(env, addr + 2, val, ra);
         }
         break;
     case 1:
@@ -170,12 +170,12 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr, val, 0x00ffffffffffffffull, 7, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 48, ra);
-            cpu_stw_data_ra(env, addr + 1, val >> 32, ra);
-            cpu_stl_data_ra(env, addr + 3, val, ra);
+            cpu_stw_be_data_ra(env, addr + 1, val >> 32, ra);
+            cpu_stl_be_data_ra(env, addr + 3, val, ra);
         }
         break;
     default:
-        cpu_stq_data_ra(env, addr, val, ra);
+        cpu_stq_be_data_ra(env, addr, val, ra);
         break;
     }
 }
@@ -211,12 +211,12 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
         if (parallel) {
             atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
+            cpu_stw_be_data_ra(env, addr - 3, val >> 16, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        cpu_stw_be_data_ra(env, addr - 2, val >> 16, ra);
         break;
     case 1:
         cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
@@ -239,8 +239,8 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr - 7, val,
                                 0xffffffffffffff00ull, 7, ra);
         } else {
-            cpu_stl_data_ra(env, addr - 7, val >> 32, ra);
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
+            cpu_stl_be_data_ra(env, addr - 7, val >> 32, ra);
+            cpu_stw_be_data_ra(env, addr - 3, val >> 16, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
         }
         break;
@@ -250,8 +250,8 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr - 6, val,
                                 0xffffffffffff0000ull, 6, ra);
         } else {
-            cpu_stl_data_ra(env, addr - 6, val >> 32, ra);
-            cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+            cpu_stl_be_data_ra(env, addr - 6, val >> 32, ra);
+            cpu_stw_be_data_ra(env, addr - 2, val >> 16, ra);
         }
         break;
     case 5:
@@ -260,24 +260,24 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr - 5, val,
                                 0xffffffffff000000ull, 5, ra);
         } else {
-            cpu_stl_data_ra(env, addr - 5, val >> 32, ra);
+            cpu_stl_be_data_ra(env, addr - 5, val >> 32, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
         }
         break;
     case 4:
-        cpu_stl_data_ra(env, addr - 4, val >> 32, ra);
+        cpu_stl_be_data_ra(env, addr - 4, val >> 32, ra);
         break;
     case 3:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
             atomic_store_mask32(env, addr - 3, val >> 32, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 48, ra);
+            cpu_stw_be_data_ra(env, addr - 3, val >> 48, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 40, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 48, ra);
+        cpu_stw_be_data_ra(env, addr - 2, val >> 48, ra);
         break;
     case 1:
         cpu_stb_data_ra(env, addr - 1, val >> 56, ra);
-- 
2.51.0


