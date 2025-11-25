Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15242D0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqiG-0004iE-SK; Tue, 25 Nov 2025 05:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqht-0004Qx-Qw
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqhn-0001gO-TG
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:36 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso52187675e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068129; x=1764672929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSMQofszP9d0Zf69Q3/r02u7/TYYXgRxG7oyvHr35Vw=;
 b=EOsotMNdt3miDTZ1EozAvDKABmyspJezY0Sw8W15ZuElLGEAuB3DiOSIebWbKqLRJ7
 epHFZ+PFZLne+wleJHaR9t8g7dUfR1Ul32atuwR4rxiy8bVHviucWGrUwGUBHvkWBqSl
 yr2Ddh+v/HZ/MwG8JjlYDQSovSAizbyXZN2hshLp7fKQ/55Jc2kxI7v2XLctEc8H1cKD
 1LxNoxL/BNs8b5/kqPfV+mBngFWIpzvhVk7OXU8wjoiN6d2i9QCz48UDH1JyuNxHYyAc
 bV+pDvYrP3J80FZaIclTZDoXdJYPJ4ye/UXUFoSehAwq77o+w/N5YLUjFtdu4LRopIWD
 wA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068129; x=1764672929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cSMQofszP9d0Zf69Q3/r02u7/TYYXgRxG7oyvHr35Vw=;
 b=MhaZCoye6hMsZk2psv3gq80PpylA09eYavPocQ1GA7pisxmcU9easyVWeBMSuXzpAA
 DoV/9HSgIDmcdPrEJQUoQCqEbblrljUVMskZuSiSo6fAwWxEdHmbo8TSltGQ5oZ9PZyO
 i2zverqSRbVdziQhWP/NUwiY6mJLHrAVULqnIjywWV4gOs2QQrWnkmVdLtrHa+8n2zyQ
 M7VbjQzd3By3TuHa5de8b+hVtkPKBNpDs0g3AniBaDNAaEYly6wtJsKH4P8n62oimu6p
 x6ubkvpID4YVK8TtqCmpKTBclgpYA7+bt7eaF74LFCIF3KbBpr1Ci1bfpS80BDc/urBq
 lj5w==
X-Gm-Message-State: AOJu0YxrPrRqdDJ5dNdoX+d3JpW+zPGXir4h4REKsNjnvSdILQeaxe+R
 lsRZcP+A2V7s1xwgM+zXUuu7WLQfQrCCCNpLOqVjeCsmS4O+PRQKA/netZtQlcI9I6LASjtKPy9
 +MMACPP56fA==
X-Gm-Gg: ASbGncvSfnOv/4AIHLQI3JSNL99gabBhN8bOXX4uouDqCWuIkTW9GmywNZCWmJZq6/q
 mw+dmS1Bl8cGSPusgA4AMr3mVq+R0sP6hBjQWKLkN+P+1mgbOvnuhFMZ11dm9lROe7bQY3OxwKP
 kmSkzvW7w5bASnpA4hvEks9ZIiXola4O8r7+I4XpWfYBxh/oEKeRjmCkhi6FqkxYmYL7WELmEat
 giYL65Ld1uj+dJCLsXb9XrQtj3QwmUfgoDugQfPLgMX1KLXpNdNmg8Sc7Cbg85ScnC6NMIJfAkU
 EQoc/G+sbVpKJb49mw1KWX0lnzKdi2l316WuvVlIC6HSQRCxlRRdRuoknBmqehkUA8bzbjTr6IP
 PI52ksmA89FQIa1x8r7rNyoRwdNcFSzuO3Tkj0mEPBXH8YBCqrl9HQZlBmOy6/o7VIsGoJYBLR0
 /PpiBAAffr1mJjdNvu3+eNO+7gpnp+xtnAssVXodn7e9/qq3JJfDoKG1G4EsIV
X-Google-Smtp-Source: AGHT+IHtlRX8AOLqO7+N9lyBnTd5D7LDcZquZ/ce/BTw9xDiDYDyTWzC1KjA2pXHQ8msvnqvKXISig==
X-Received: by 2002:a05:600c:1c02:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-477c01eed7cmr153573625e9.29.1764068128893; 
 Tue, 25 Nov 2025 02:55:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790530f0a4sm12914155e9.8.2025.11.25.02.55.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 02:55:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-11.0 07/12] target/i386: Use little-endian variant of
 cpu_ld/st_data*()
Date: Tue, 25 Nov 2025 11:54:28 +0100
Message-ID: <20251125105434.92355-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125105434.92355-1-philmd@linaro.org>
References: <20251125105434.92355-1-philmd@linaro.org>
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

We only build the X86 targets using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=i386; \
    end=le; \
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
 target/i386/ops_sse.h                | 12 +++----
 target/i386/tcg/seg_helper.h         | 12 +++----
 linux-user/vm86.c                    |  4 +--
 target/i386/tcg/mem_helper.c         |  8 ++---
 target/i386/tcg/mpx_helper.c         | 28 ++++++++--------
 target/i386/tcg/seg_helper.c         | 16 +++++-----
 target/i386/tcg/system/excp_helper.c |  8 ++---
 target/i386/tcg/system/svm_helper.c  | 48 ++++++++++++++--------------
 8 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index a2e4d480399..213db53382c 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2326,7 +2326,7 @@ void glue(helper_vpmaskmovd_st, SUFFIX)(CPUX86State *env,
 
     for (i = 0; i < (2 << SHIFT); i++) {
         if (v->L(i) >> 31) {
-            cpu_stl_data_ra(env, a0 + i * 4, s->L(i), GETPC());
+            cpu_stl_le_data_ra(env, a0 + i * 4, s->L(i), GETPC());
         }
     }
 }
@@ -2338,7 +2338,7 @@ void glue(helper_vpmaskmovq_st, SUFFIX)(CPUX86State *env,
 
     for (i = 0; i < (1 << SHIFT); i++) {
         if (v->Q(i) >> 63) {
-            cpu_stq_data_ra(env, a0 + i * 8, s->Q(i), GETPC());
+            cpu_stq_le_data_ra(env, a0 + i * 8, s->Q(i), GETPC());
         }
     }
 }
@@ -2369,7 +2369,7 @@ void glue(helper_vpgatherdd, SUFFIX)(CPUX86State *env,
         if (v->L(i) >> 31) {
             target_ulong addr = a0
                 + ((target_ulong)(int32_t)s->L(i) << scale);
-            d->L(i) = cpu_ldl_data_ra(env, addr, GETPC());
+            d->L(i) = cpu_ldl_le_data_ra(env, addr, GETPC());
         }
         v->L(i) = 0;
     }
@@ -2383,7 +2383,7 @@ void glue(helper_vpgatherdq, SUFFIX)(CPUX86State *env,
         if (v->Q(i) >> 63) {
             target_ulong addr = a0
                 + ((target_ulong)(int32_t)s->L(i) << scale);
-            d->Q(i) = cpu_ldq_data_ra(env, addr, GETPC());
+            d->Q(i) = cpu_ldq_le_data_ra(env, addr, GETPC());
         }
         v->Q(i) = 0;
     }
@@ -2397,7 +2397,7 @@ void glue(helper_vpgatherqd, SUFFIX)(CPUX86State *env,
         if (v->L(i) >> 31) {
             target_ulong addr = a0
                 + ((target_ulong)(int64_t)s->Q(i) << scale);
-            d->L(i) = cpu_ldl_data_ra(env, addr, GETPC());
+            d->L(i) = cpu_ldl_le_data_ra(env, addr, GETPC());
         }
         v->L(i) = 0;
     }
@@ -2415,7 +2415,7 @@ void glue(helper_vpgatherqq, SUFFIX)(CPUX86State *env,
         if (v->Q(i) >> 63) {
             target_ulong addr = a0
                 + ((target_ulong)(int64_t)s->Q(i) << scale);
-            d->Q(i) = cpu_ldq_data_ra(env, addr, GETPC());
+            d->Q(i) = cpu_ldq_le_data_ra(env, addr, GETPC());
         }
         v->Q(i) = 0;
     }
diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index ea98e1a98ed..20ce47d62d9 100644
--- a/target/i386/tcg/seg_helper.h
+++ b/target/i386/tcg/seg_helper.h
@@ -40,18 +40,18 @@ int cpu_mmu_index_kernel(CPUX86State *env);
  * and use *_mmuidx_ra directly.
  */
 #define cpu_lduw_kernel_ra(e, p, r) \
-    cpu_lduw_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
+    cpu_lduw_le_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_ldl_kernel_ra(e, p, r) \
-    cpu_ldl_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
+    cpu_ldl_le_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_ldq_kernel_ra(e, p, r) \
-    cpu_ldq_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
+    cpu_ldq_le_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 
 #define cpu_stw_kernel_ra(e, p, v, r) \
-    cpu_stw_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
+    cpu_stw_le_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stl_kernel_ra(e, p, v, r) \
-    cpu_stl_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
+    cpu_stl_le_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stq_kernel_ra(e, p, v, r) \
-    cpu_stq_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
+    cpu_stq_le_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 
 #define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
 #define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 5091d53fb84..4e120875a06 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -44,7 +44,7 @@ static inline int is_revectored(int nr, struct target_revectored_struct *bitmap)
 static inline void vm_putw(CPUX86State *env, uint32_t segptr,
                            unsigned int reg16, unsigned int val)
 {
-    cpu_stw_data(env, segptr + (reg16 & 0xffff), val);
+    cpu_stw_le_data(env, segptr + (reg16 & 0xffff), val);
 }
 
 void save_v86_state(CPUX86State *env)
@@ -157,7 +157,7 @@ static void do_int(CPUX86State *env, int intno)
                                        &ts->vm86plus.int21_revectored))
         goto cannot_handle;
     int_addr = (intno << 2);
-    segoffs = cpu_ldl_data(env, int_addr);
+    segoffs = cpu_ldl_le_data(env, int_addr);
     if ((segoffs >> 16) == TARGET_BIOSSEG)
         goto cannot_handle;
     LOG_VM86("VM86: emulating int 0x%x. CS:IP=%04x:%04x\n",
diff --git a/target/i386/tcg/mem_helper.c b/target/i386/tcg/mem_helper.c
index 9e7c2d80293..c15a32d60ad 100644
--- a/target/i386/tcg/mem_helper.c
+++ b/target/i386/tcg/mem_helper.c
@@ -30,8 +30,8 @@ void helper_boundw(CPUX86State *env, target_ulong a0, int v)
 {
     int low, high;
 
-    low = cpu_ldsw_data_ra(env, a0, GETPC());
-    high = cpu_ldsw_data_ra(env, a0 + 2, GETPC());
+    low = cpu_ldsw_le_data_ra(env, a0, GETPC());
+    high = cpu_ldsw_le_data_ra(env, a0 + 2, GETPC());
     v = (int16_t)v;
     if (v < low || v > high) {
         if (env->hflags & HF_MPX_EN_MASK) {
@@ -45,8 +45,8 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
 {
     int low, high;
 
-    low = cpu_ldl_data_ra(env, a0, GETPC());
-    high = cpu_ldl_data_ra(env, a0 + 4, GETPC());
+    low = cpu_ldl_le_data_ra(env, a0, GETPC());
+    high = cpu_ldl_le_data_ra(env, a0 + 4, GETPC());
     if (v < low || v > high) {
         if (env->hflags & HF_MPX_EN_MASK) {
             env->bndcs_regs.sts = 0;
diff --git a/target/i386/tcg/mpx_helper.c b/target/i386/tcg/mpx_helper.c
index fa8abcc4820..73d33bf5e4a 100644
--- a/target/i386/tcg/mpx_helper.c
+++ b/target/i386/tcg/mpx_helper.c
@@ -44,7 +44,7 @@ static uint64_t lookup_bte64(CPUX86State *env, uint64_t base, uintptr_t ra)
     }
 
     bde = (extract64(base, 20, 28) << 3) + (extract64(bndcsr, 20, 44) << 12);
-    bt = cpu_ldq_data_ra(env, bde, ra);
+    bt = cpu_ldq_le_data_ra(env, bde, ra);
     if ((bt & 1) == 0) {
         env->bndcs_regs.sts = bde | 2;
         raise_exception_ra(env, EXCP05_BOUND, ra);
@@ -64,7 +64,7 @@ static uint32_t lookup_bte32(CPUX86State *env, uint32_t base, uintptr_t ra)
     }
 
     bde = (extract32(base, 12, 20) << 2) + (bndcsr & TARGET_PAGE_MASK);
-    bt = cpu_ldl_data_ra(env, bde, ra);
+    bt = cpu_ldl_le_data_ra(env, bde, ra);
     if ((bt & 1) == 0) {
         env->bndcs_regs.sts = bde | 2;
         raise_exception_ra(env, EXCP05_BOUND, ra);
@@ -79,9 +79,9 @@ uint64_t helper_bndldx64(CPUX86State *env, target_ulong base, target_ulong ptr)
     uint64_t bte, lb, ub, pt;
 
     bte = lookup_bte64(env, base, ra);
-    lb = cpu_ldq_data_ra(env, bte, ra);
-    ub = cpu_ldq_data_ra(env, bte + 8, ra);
-    pt = cpu_ldq_data_ra(env, bte + 16, ra);
+    lb = cpu_ldq_le_data_ra(env, bte, ra);
+    ub = cpu_ldq_le_data_ra(env, bte + 8, ra);
+    pt = cpu_ldq_le_data_ra(env, bte + 16, ra);
 
     if (pt != ptr) {
         lb = ub = 0;
@@ -96,9 +96,9 @@ uint64_t helper_bndldx32(CPUX86State *env, target_ulong base, target_ulong ptr)
     uint32_t bte, lb, ub, pt;
 
     bte = lookup_bte32(env, base, ra);
-    lb = cpu_ldl_data_ra(env, bte, ra);
-    ub = cpu_ldl_data_ra(env, bte + 4, ra);
-    pt = cpu_ldl_data_ra(env, bte + 8, ra);
+    lb = cpu_ldl_le_data_ra(env, bte, ra);
+    ub = cpu_ldl_le_data_ra(env, bte + 4, ra);
+    pt = cpu_ldl_le_data_ra(env, bte + 8, ra);
 
     if (pt != ptr) {
         lb = ub = 0;
@@ -113,9 +113,9 @@ void helper_bndstx64(CPUX86State *env, target_ulong base, target_ulong ptr,
     uint64_t bte;
 
     bte = lookup_bte64(env, base, ra);
-    cpu_stq_data_ra(env, bte, lb, ra);
-    cpu_stq_data_ra(env, bte + 8, ub, ra);
-    cpu_stq_data_ra(env, bte + 16, ptr, ra);
+    cpu_stq_le_data_ra(env, bte, lb, ra);
+    cpu_stq_le_data_ra(env, bte + 8, ub, ra);
+    cpu_stq_le_data_ra(env, bte + 16, ptr, ra);
 }
 
 void helper_bndstx32(CPUX86State *env, target_ulong base, target_ulong ptr,
@@ -125,9 +125,9 @@ void helper_bndstx32(CPUX86State *env, target_ulong base, target_ulong ptr,
     uint32_t bte;
 
     bte = lookup_bte32(env, base, ra);
-    cpu_stl_data_ra(env, bte, lb, ra);
-    cpu_stl_data_ra(env, bte + 4, ub, ra);
-    cpu_stl_data_ra(env, bte + 8, ptr, ra);
+    cpu_stl_le_data_ra(env, bte, lb, ra);
+    cpu_stl_le_data_ra(env, bte + 4, ub, ra);
+    cpu_stl_le_data_ra(env, bte + 8, ptr, ra);
 }
 
 void helper_bnd_jmp(CPUX86State *env)
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 227336c4ef2..58aac720119 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -65,20 +65,20 @@ typedef struct StackAccess
 static void pushw(StackAccess *sa, uint16_t val)
 {
     sa->sp -= 2;
-    cpu_stw_mmuidx_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
+    cpu_stw_le_mmuidx_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
                       val, sa->mmu_index, sa->ra);
 }
 
 static void pushl(StackAccess *sa, uint32_t val)
 {
     sa->sp -= 4;
-    cpu_stl_mmuidx_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
+    cpu_stl_le_mmuidx_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
                       val, sa->mmu_index, sa->ra);
 }
 
 static uint16_t popw(StackAccess *sa)
 {
-    uint16_t ret = cpu_lduw_mmuidx_ra(sa->env,
+    uint16_t ret = cpu_lduw_le_mmuidx_ra(sa->env,
                                       sa->ss_base + (sa->sp & sa->sp_mask),
                                       sa->mmu_index, sa->ra);
     sa->sp += 2;
@@ -87,7 +87,7 @@ static uint16_t popw(StackAccess *sa)
 
 static uint32_t popl(StackAccess *sa)
 {
-    uint32_t ret = cpu_ldl_mmuidx_ra(sa->env,
+    uint32_t ret = cpu_ldl_le_mmuidx_ra(sa->env,
                                      sa->ss_base + (sa->sp & sa->sp_mask),
                                      sa->mmu_index, sa->ra);
     sa->sp += 4;
@@ -905,12 +905,12 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 static void pushq(StackAccess *sa, uint64_t val)
 {
     sa->sp -= 8;
-    cpu_stq_mmuidx_ra(sa->env, sa->sp, val, sa->mmu_index, sa->ra);
+    cpu_stq_le_mmuidx_ra(sa->env, sa->sp, val, sa->mmu_index, sa->ra);
 }
 
 static uint64_t popq(StackAccess *sa)
 {
-    uint64_t ret = cpu_ldq_mmuidx_ra(sa->env, sa->sp, sa->mmu_index, sa->ra);
+    uint64_t ret = cpu_ldq_le_mmuidx_ra(sa->env, sa->sp, sa->mmu_index, sa->ra);
     sa->sp += 8;
     return ret;
 }
@@ -1887,7 +1887,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                 pushl(&sa, env->segs[R_SS].selector);
                 pushl(&sa, env->regs[R_ESP]);
                 for (i = param_count - 1; i >= 0; i--) {
-                    val = cpu_ldl_data_ra(env,
+                    val = cpu_ldl_le_data_ra(env,
                                           old_ssp + ((env->regs[R_ESP] + i * 4) & old_sp_mask),
                                           GETPC());
                     pushl(&sa, val);
@@ -1896,7 +1896,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                 pushw(&sa, env->segs[R_SS].selector);
                 pushw(&sa, env->regs[R_ESP]);
                 for (i = param_count - 1; i >= 0; i--) {
-                    val = cpu_lduw_data_ra(env,
+                    val = cpu_lduw_le_data_ra(env,
                                            old_ssp + ((env->regs[R_ESP] + i * 2) & old_sp_mask),
                                            GETPC());
                     pushw(&sa, val);
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index f622b5d588e..d7ea77c8558 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -90,7 +90,7 @@ static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
     if (likely(in->haddr)) {
         return ldl_p(in->haddr);
     }
-    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
+    return cpu_ldl_le_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
 static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
@@ -98,7 +98,7 @@ static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
     if (likely(in->haddr)) {
         return ldq_p(in->haddr);
     }
-    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
+    return cpu_ldq_le_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
 /*
@@ -116,9 +116,9 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
     cpu_exec_end(cpu);
     /* Does x86 really perform a rmw cycle on mmio for ptw? */
     start_exclusive();
-    cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    cmp = cpu_ldl_le_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
     if (cmp == old) {
-        cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
+        cpu_stl_le_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
     }
     end_exclusive();
     cpu_exec_start(cpu);
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 4b86796518f..3f97a639aeb 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -30,13 +30,13 @@
 static void svm_save_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
                          const SegmentCache *sc)
 {
-    cpu_stw_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, selector),
+    cpu_stw_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, selector),
                       sc->selector, mmu_idx, 0);
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, base),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, base),
                       sc->base, mmu_idx, 0);
-    cpu_stl_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, limit),
+    cpu_stl_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, limit),
                       sc->limit, mmu_idx, 0);
-    cpu_stw_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, attrib),
+    cpu_stw_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, attrib),
                       ((sc->flags >> 8) & 0xff)
                       | ((sc->flags >> 12) & 0x0f00),
                       mmu_idx, 0);
@@ -58,16 +58,16 @@ static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
     unsigned int flags;
 
     sc->selector =
-        cpu_lduw_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, selector),
+        cpu_lduw_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, selector),
                            mmu_idx, 0);
     sc->base =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, base),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, base),
                           mmu_idx, 0);
     sc->limit =
-        cpu_ldl_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, limit),
+        cpu_ldl_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, limit),
                           mmu_idx, 0);
     flags =
-        cpu_lduw_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, attrib),
+        cpu_lduw_le_mmuidx_ra(env, addr + offsetof(struct vmcb_seg, attrib),
                            mmu_idx, 0);
     sc->flags = ((flags & 0xff) << 8) | ((flags & 0x0f00) << 12);
 
@@ -507,31 +507,31 @@ void helper_vmload(CPUX86State *env, int aflag)
 
 #ifdef TARGET_X86_64
     env->kernelgsbase =
-        cpu_ldq_mmuidx_ra(env,
+        cpu_ldq_le_mmuidx_ra(env,
                           addr + offsetof(struct vmcb, save.kernel_gs_base),
                           mmu_idx, 0);
     env->lstar =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.lstar),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.lstar),
                           mmu_idx, 0);
     env->cstar =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.cstar),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.cstar),
                           mmu_idx, 0);
     env->fmask =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sfmask),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sfmask),
                           mmu_idx, 0);
     svm_canonicalization(env, &env->kernelgsbase);
 #endif
     env->star =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.star),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.star),
                           mmu_idx, 0);
     env->sysenter_cs =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_cs),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_cs),
                           mmu_idx, 0);
     env->sysenter_esp =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_esp),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_esp),
                           mmu_idx, 0);
     env->sysenter_eip =
-        cpu_ldq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_eip),
+        cpu_ldq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_eip),
                           mmu_idx, 0);
 }
 
@@ -567,22 +567,22 @@ void helper_vmsave(CPUX86State *env, int aflag)
                  &env->ldt);
 
 #ifdef TARGET_X86_64
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.kernel_gs_base),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.kernel_gs_base),
                       env->kernelgsbase, mmu_idx, 0);
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.lstar),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.lstar),
                       env->lstar, mmu_idx, 0);
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.cstar),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.cstar),
                       env->cstar, mmu_idx, 0);
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sfmask),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sfmask),
                       env->fmask, mmu_idx, 0);
 #endif
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.star),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.star),
                       env->star, mmu_idx, 0);
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_cs),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_cs),
                       env->sysenter_cs, mmu_idx, 0);
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_esp),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_esp),
                       env->sysenter_esp, mmu_idx, 0);
-    cpu_stq_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_eip),
+    cpu_stq_le_mmuidx_ra(env, addr + offsetof(struct vmcb, save.sysenter_eip),
                       env->sysenter_eip, mmu_idx, 0);
 }
 
-- 
2.51.0


