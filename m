Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CF4C77B7F
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 00:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVJN8-0006LX-6D; Fri, 27 Jun 2025 20:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVJN6-0006Kw-34
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 20:24:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVJN4-0000qi-1p
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 20:24:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7490cb9a892so2251255b3a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751070280; x=1751675080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZZyfIWWTCUW5B+tWLq1OrTS8PV+HjtfL+6A4Tz8SxQ=;
 b=OIqghFCV5XmrAPyA39VgLGGJK4P30LojQjXyNaPQr1iK+y7kdkoKLDjVuq97GCpeN4
 EQ6eqhSNkp3ruyQF64/9zuXd7716n9Ebk+Sn4XJe1qa7m+mmfrJczkIh64k3iGBe7pmb
 Ja8g259YDrVnxURJLTURWlSLl/eYBxJPl2nplnViMneTAEkFwUuoCem1hnaCaSw4YAUM
 YZusjiz3gGRU9JhcIJT4YUa26ZWAih3OfIJ/Gta4iuHqS+ElJa1OytWh4iiHMSwBOX6H
 9xlVA/RmdOpdU85ZczBju0sWtXHDenYmS0rZps6ry/KGy8foIAw1Lo66YFLQMUxs3xZk
 fT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751070280; x=1751675080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZZyfIWWTCUW5B+tWLq1OrTS8PV+HjtfL+6A4Tz8SxQ=;
 b=geon2Cos6fQIy4EcbVV868FLDy2XX0vl3/QeUqgwRasgJZ1+ra3ROPChBJcwCoaZyH
 ULn25EPc4QXnrG2/ia6PnMgMklVx15umX8GxJ7GfbWkjF4hbKv5ukT6VNdlVIrI6112E
 k+r10+F9eZXyNg6wShqCAGC/ikm7CdOwj4aXcs/9gDHTHPtQLgYAKbzdMdK2wpn1zHLG
 bWggSq3yPCi6yhKQTEcG4myY6X/Voexby3rIkmsRMdQKysAtfpkDGwBG83ruq64BBDLU
 rlTO0uxAFuHfML0cP+/29Z+eeFhdY1hUykt6zU+FUcsBQ7mP1HDlgbGXfoKCG8ENDxdP
 5rrQ==
X-Gm-Message-State: AOJu0YxWUDw7nhphJtRN/juZQ0sDKubiSf/R8ii/GqT0z9EuSj4kEd42
 YtRi2TKB4p0kfKl2sOMho9Yuxyktc9eJNdRKMZEWE+i8Dl9iTDrs9WoU7O1ILWYd8EaRpqHw1nQ
 q5NLR
X-Gm-Gg: ASbGncs3YYeWpb98mDNN4vh9RYxQdvR22JqT21+bR0Ue+p7rKDqR+gq+cBJwOx45O7N
 e18Gih16eQ9CBqlVPsEMnQSdjXR7F8TD1ps34uODJWzKcgoaBXMtdIOjIMZLlgV1RiyLzi/jVDA
 /tBfwXBsl2OTuxTvqpxZPYUqaPrBdHdxI5GXJKTQ2n0tQHgnTFj1h5cLPEAl/iU/Mg49bdk47fn
 J3i/Rq2vHgGHbSbLtLkpfcey3S5nv1hb0PNYIvWuJCUJJTjW/m9R9zf8b5Ae3S0P/PPEK+wRN61
 Lg2Z92XmpY9ijdFmDYhhdTSnatQWJGDcMxinUSL216FAKtBbMNt0tmChOhHeBQ==
X-Google-Smtp-Source: AGHT+IHV1zrka7Vt4QgDDD1O9uHbzIpUhz1EsKQx8N+Y64bT7qaMSe7hsWuO7PzXjD18wE9Ke6XP0g==
X-Received: by 2002:a05:6a00:a87:b0:748:fcfa:8bd5 with SMTP id
 d2e1a72fcca58-74af6e2f4f3mr8007283b3a.3.1751070280528; 
 Fri, 27 Jun 2025 17:24:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5579d37sm3025751b3a.81.2025.06.27.17.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 17:24:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/2] qemu/timer: introduce time dilation factor
Date: Fri, 27 Jun 2025 17:24:30 -0700
Message-ID: <20250628002431.41823-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
References: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

This factor is applied to time spent since we initialized clocks.
It impacts value returned by get_clock(), get_clock_realtime() and
get_cpu_host_ticks();

< 1: time goes slower.
> 1: time goes faster.
1 by default.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/timer.h     | 60 ++++++++++++++++++++++++++++------------
 util/qemu-timer-common.c |  7 +++++
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index abd2204f3be..ee1877d5cd9 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -801,6 +801,23 @@ static inline int64_t get_max_clock_jump(void)
     return 60 * NANOSECONDS_PER_SECOND;
 }
 
+extern int64_t clock_start;
+extern int64_t clock_realtime_start;
+extern int64_t host_ticks_start;
+extern double clock_time_dilation;
+
+static inline int64_t dilate_time(int64_t start, int64_t now)
+{
+    if (start == 0) {
+        /* start value is getting fetched */
+        return now;
+    }
+    g_assert(now >= start);
+    int64_t elapsed = now - start;
+    int64_t elapsed_dilated = elapsed * clock_time_dilation;
+    return start + elapsed_dilated;
+}
+
 /*
  * Low level clock functions
  */
@@ -811,11 +828,10 @@ static inline int64_t get_clock_realtime(void)
     struct timeval tv;
 
     gettimeofday(&tv, NULL);
-    return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
+    int64_t now = tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
+    return dilate_time(clock_realtime_start, now);
 }
 
-extern int64_t clock_start;
-
 /* Warning: don't insert tracepoints into these functions, they are
    also used by simpletrace backend and tracepoints would cause
    an infinite recursion! */
@@ -826,7 +842,8 @@ static inline int64_t get_clock(void)
 {
     LARGE_INTEGER ti;
     QueryPerformanceCounter(&ti);
-    return muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, clock_freq);
+    int64_t now = muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, clock_freq);
+    return dilate_time(clock_start, now);
 }
 
 #else
@@ -838,10 +855,11 @@ static inline int64_t get_clock(void)
     if (use_rt_clock) {
         struct timespec ts;
         clock_gettime(CLOCK_MONOTONIC, &ts);
-        return ts.tv_sec * 1000000000LL + ts.tv_nsec;
+        int64_t now = ts.tv_sec * 1000000000LL + ts.tv_nsec;
+        return dilate_time(clock_start, now);
     } else {
         /* XXX: using gettimeofday leads to problems if the date
-           changes, so it should be avoided. */
+           changes, so it should be avoided. Time is already dilated. */
         return get_clock_realtime();
     }
 }
@@ -852,7 +870,7 @@ static inline int64_t get_clock(void)
 
 #if defined(_ARCH_PPC)
 
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     int64_t retval;
 #ifdef _ARCH_PPC64
@@ -878,7 +896,7 @@ static inline int64_t cpu_get_host_ticks(void)
 
 #elif defined(__i386__)
 
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     int64_t val;
     asm volatile ("rdtsc" : "=A" (val));
@@ -887,7 +905,7 @@ static inline int64_t cpu_get_host_ticks(void)
 
 #elif defined(__x86_64__)
 
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     uint32_t low,high;
     int64_t val;
@@ -900,7 +918,7 @@ static inline int64_t cpu_get_host_ticks(void)
 
 #elif defined(__hppa__)
 
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     int val;
     asm volatile ("mfctl %%cr16, %0" : "=r"(val));
@@ -909,7 +927,7 @@ static inline int64_t cpu_get_host_ticks(void)
 
 #elif defined(__s390__)
 
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     int64_t val;
     asm volatile("stck 0(%1)" : "=m" (val) : "a" (&val) : "cc");
@@ -918,7 +936,7 @@ static inline int64_t cpu_get_host_ticks(void)
 
 #elif defined(__sparc__)
 
-static inline int64_t cpu_get_host_ticks (void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
 #if defined(_LP64)
     uint64_t        rval;
@@ -956,7 +974,7 @@ static inline int64_t cpu_get_host_ticks (void)
                               : "=r" (value));          \
     }
 
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     /* On kernels >= 2.6.25 rdhwr <reg>, $2 and $3 are emulated */
     uint32_t count;
@@ -972,7 +990,7 @@ static inline int64_t cpu_get_host_ticks(void)
 
 #elif defined(__alpha__)
 
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     uint64_t cc;
     uint32_t cur, ofs;
@@ -984,7 +1002,7 @@ static inline int64_t cpu_get_host_ticks(void)
 }
 
 #elif defined(__riscv) && __riscv_xlen == 32
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     uint32_t lo, hi, tmph;
     do {
@@ -997,7 +1015,7 @@ static inline int64_t cpu_get_host_ticks(void)
 }
 
 #elif defined(__riscv) && __riscv_xlen > 32
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     int64_t val;
 
@@ -1006,7 +1024,7 @@ static inline int64_t cpu_get_host_ticks(void)
 }
 
 #elif defined(__loongarch64)
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     uint64_t val;
 
@@ -1018,10 +1036,16 @@ static inline int64_t cpu_get_host_ticks(void)
 /* The host CPU doesn't have an easily accessible cycle counter.
    Just return a monotonically increasing value.  This will be
    totally wrong, but hopefully better than nothing.  */
-static inline int64_t cpu_get_host_ticks(void)
+static inline int64_t _cpu_get_host_ticks(void)
 {
     return get_clock();
 }
 #endif
 
+static inline int64_t cpu_get_host_ticks(void)
+{
+    int64_t now = _cpu_get_host_ticks();
+    return dilate_time(host_ticks_start, now);
+}
+
 #endif
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
index cc1326f7264..5cb36032bc8 100644
--- a/util/qemu-timer-common.c
+++ b/util/qemu-timer-common.c
@@ -28,6 +28,9 @@
 /* real time host monotonic timer */
 
 int64_t clock_start;
+int64_t clock_realtime_start;
+int64_t host_ticks_start;
+double clock_time_dilation = 1.0f;
 
 #ifdef _WIN32
 
@@ -44,6 +47,8 @@ static void __attribute__((constructor)) init_get_clock(void)
     }
     clock_freq = freq.QuadPart;
     clock_start = get_clock();
+    clock_realtime_start = get_clock_realtime();
+    host_ticks_start = cpu_get_host_ticks();
 }
 
 #else
@@ -59,5 +64,7 @@ static void __attribute__((constructor)) init_get_clock(void)
         use_rt_clock = 1;
     }
     clock_start = get_clock();
+    clock_realtime_start = get_clock_realtime();
+    host_ticks_start = cpu_get_host_ticks();
 }
 #endif
-- 
2.47.2


