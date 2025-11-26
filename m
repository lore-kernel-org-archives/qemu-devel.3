Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38229D11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM2M-0002lx-TG; Wed, 26 Nov 2025 15:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2L-0002gy-Ed
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2I-0002NO-BK
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so444175e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188565; x=1764793365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZSAUqnvuevQAefUrk8Hx13fLywfY4qytxjtSoxjWic=;
 b=NkzwJIm33/0ea68RlSRNVftGlFvzt0DAAKTspihIEMzKD1dqz50SYcBwChpjo4GUCs
 IGLz3/UsIuqjhNNAKIasN4vlTjBttJukiCE3wDpgVxA4avrnPiZ6rKo5i6ya8MGsw0eu
 GNf96SoVwogG+bSB1fB0Q/f/IvXLQWtwfGTIna3RmQUFbFX4x88XQ6JpAbMJJ1M+nAu2
 YBlWVwYWP0yx/UVxpxDnnS63xe9N37eaTKeUmmPzWolTSdIk7uOIArBs6vpGQvEr7o1a
 MKOTP9Qoqg0oORoJCqqNVtpCyic8tmVjslr4kXqF+haVIPyAwR6FZE5GBfIKsMuWKKa0
 VrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188565; x=1764793365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZSAUqnvuevQAefUrk8Hx13fLywfY4qytxjtSoxjWic=;
 b=b5b8M8uoG1oCsRgQoZWPytF6JtUN1mwq9dLyZusfNReb3SOZcaywbOKmq9vb2J/tO7
 f0FtCpFNfS7oSVPCol0y/GXpBmcHqunzcgCKiZw1n6uj7GNHcP8pOqzTo/9MKRkRttJ6
 c715+TyhDS2os0M11cQ6f9sPoHYv2Ag/EjqSxE4qH6hBh/4yW6WVK9urRVwPSIwH7uDN
 itdxh4lT/Xnj61KVR16GczA8aovfhnPH0YK7nGT2qvrbaCoVNOlGPSn/bmLrOg/kHrVw
 vXNXboySH/0ht48Rlr5jBHgxQ3SFJ1rFl+5PNIfGLuYOieZlFJUbkfQU7AiBjvryg6VC
 ke9g==
X-Gm-Message-State: AOJu0YxMz9rjgn+FrK97pYfYiAdibXhmChLLYuCucjXifI7eOZTCFmnN
 ATWk79ssn2BsBKGpWXpsSkoF6pwuAcBSNCcLqf5MVv3hdv3s0f0t2inykNS0torkonwsQAbh/J/
 Wl1lhWsSOxvyr
X-Gm-Gg: ASbGncuE91SciKIwhk5DLTcQYGl7OQvBmiUmqzUMl5NYireeHLk4kjLvPIhgII+2Uoi
 8HkIsAsaUzSu/8fTatiTxOxiPWu1ruuAAy3y29QRV6EAMvzYbey1wqRPrREOksDHRvt2/KB0phi
 WScn1P7vAove3fymRhwCN5Esrsvdlur9CO0B9Metvu+nqEnMKqGpYqRsIT2l+mLHc95s1NX4y3/
 0aB0aovfQdh8Z2ZN+6PR710hkp7AC6epFtqw8rEBVoGKXRKZKFXjPIzd74+511jwUtShtKwy9p/
 eLc7R+3ZzpIGvlioXkCi1Tb0zLzlK/lfTn0VLRzAkyGul2Th8yAhe7FCS9IoMLY9lT35MdUiGk9
 0fio0XLB6z3TWNUKVAVTLxudnw5YSNGv4mP1CalLIGNQ5l59bJioMS1wJ/T4Pv+D++FiOV1d8mt
 VHhhFgPqvDJVFiTJE1HCRITLvNi0CgaViSrP92iS2DLb/YpbQR3xo+6DVV7+7a
X-Google-Smtp-Source: AGHT+IEqH5PPtlsz2rKIuhlqRdsiyW4YoqoaweVHL31FbSDBUnQh67Tt+Ddr20q/xiOiGZcfBHC9Lw==
X-Received: by 2002:a05:600c:4691:b0:477:8a2a:1244 with SMTP id
 5b1f17b1804b1-477c110e521mr211171625e9.11.1764188564570; 
 Wed, 26 Nov 2025 12:22:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a81sm43302273f8f.26.2025.11.26.12.22.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:22:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH-for-11.0 v3 06/22] target/hppa: Use big-endian variant of
 cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 21:21:42 +0100
Message-ID: <20251126202200.23100-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.51.0


