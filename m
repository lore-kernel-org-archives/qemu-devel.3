Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E769AE92FF9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaM9W-0001ph-A8; Mon, 29 Dec 2025 17:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9E-0001mR-A8
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9C-0001Bs-IZ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:32 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so54801065e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048928; x=1767653728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Tgw+sYikt+iLprmV8aTKENGQCgYp02T9R5ti5jQ79o=;
 b=IHtGmS2PM/HOSkvzF4IoJTmA7WgSElc5O8MNyjBP2jVwEteVt7CJc7vBUmO3R77Oe9
 AyprAqarUqDZ4jMirfZDLEloDPgzuY7sYj+S4OEVrcjSwarscSeF+kkSk9uLME+L0diM
 P9qUTwL8PhN8dZrpplCmYW4DihoLWBQwPj2EefxhZvC7wjeJlYCfsz5OFZbbhGs8xhaD
 +sfVqje+040nKd9rPzkyP22hWrdriokq37R2AdNK472TB3uFGLE4wcQRiT3In666y8hT
 52rxxLEStYEyneo4G43rzRV1jG25lJCnD2MBVAmyVlcuCPs9M24lp7/XMuWk4UX1S7o8
 kmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048928; x=1767653728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Tgw+sYikt+iLprmV8aTKENGQCgYp02T9R5ti5jQ79o=;
 b=oPwNiXk0Brb9c9rHx91wv8d7wxgfE49qySDdyPpkrdyPWLcc6uIOQVo377/W3KcsgH
 LsX+4yIXU3n9sfin9AVwJgfCINEEy7v3MeAb2fj9QWCqFgbCSmYm0bbkWkgHLZmkpb8I
 4aP26p6yRl18cYP5jfd8qnv6mVhk5k05MvkavNG05Q+W9pS+nCc29q/dnKZ9sxgE6I2Z
 /Bn1olyoH16wD9cVi9iSbWzX5znveR0vTtPT7bh/PaKwzucO4+hSfQ1dVQFA6D4TNg5U
 3RI5BmoN1YAcdFDUrWrgHjTi9mwX48/oM2InOnGVLYweiMrabYrrIcI/FqSEnYB1Tr8k
 Vv+w==
X-Gm-Message-State: AOJu0Yzj++frbY86KiebPGAyVv4NxQHCd37fWZpuPF+VTneqHL7QYdjV
 udX9xlyYv5ZpRNjMqvvqNd20EkbunhObQQEHgI9f5boODOs1XfkrAZthtD0XfN6+54r4uHoPKr5
 gDEQcHbI=
X-Gm-Gg: AY/fxX4mOFh3TjRDZs8lNDFyfrJk+Wb15lcnF+Wsewd7jw6yxw8Q6oVMLJkjbsRSYj9
 Hc3jj4b3BQgKxBDMrH8bL98ufzchwScZxINGa7LJFhpPB5EHoSRG/ME8g7HNDkNNPLsws3CLHep
 oUGlhUqpU2zHKeLaozwVOBMGLBmLWzY+2ii/SClYpvMHliX1NmX4AWPOP84QIE1aOfFl6cT2Gr1
 s3/onT287tehrcLI87lQ2VG0Q6qVBgG5J6QQY3AZk3M5hJ5XaOwShtBDyC5cr0/wq7++u9N77wm
 ILmZUItYAzvVIbJc9N785f3gMnHE+qLOvGG0U7OIMW974S85CjnVbtUmx/IQISYT7JVkUm8Hde9
 BtDgQ8j5VGGEGpNPZTe6TS64Ob4gx3HXnsCRkIGLBb02ZLr/6KEKWZ8SNBvP6ODH+ww16V/u7yA
 HnrD9a408CVdoYodn+Zw0YE8HjpxIN20G8Uq/N7NNAS37WfLQgmMtNMTUqo6mG
X-Google-Smtp-Source: AGHT+IEPij4rh4Ta1KwGWDO9517X4SUzczra1GlD4VgBYIXYwa3MrU49SMIfOpf/bo+KwpOyMMSBMw==
X-Received: by 2002:a05:600c:1c28:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-47d1954586amr352654565e9.10.1767048927604; 
 Mon, 29 Dec 2025 14:55:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b749esm616237845e9.14.2025.12.29.14.55.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 14:55:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] target/hppa: Use big-endian variant of
 cpu_ld/st_data*()
Date: Mon, 29 Dec 2025 23:55:13 +0100
Message-ID: <20251229225517.45078-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229225517.45078-1-philmd@linaro.org>
References: <20251229225517.45078-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

We only build the HPPA target using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the big
endian declarations. Use the explicit big-endian variants.

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.52.0


