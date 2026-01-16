Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D708D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgags-0005Xv-Fk; Thu, 15 Jan 2026 22:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagq-0005X0-S8
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:40:00 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagp-0000Ej-7l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:40:00 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso11982245ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534798; x=1769139598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnCVV9AnEgawNA+fiIe+uEXCZKJSFhPJndsOefTu71g=;
 b=ARall/9EWYqhvumnxJPfpz7ymBU+J1h7j+JQObPDGiZ4KE4ClMGoE8Bxvc37Trd4/j
 HuxvYzY9Vp8j62TlGAU5FKJpUWtAW+hdmxahyvfILyFNl0p7nadto/1aHAenk6BhdkbO
 Qo89Kl0JyPuS92BVdvr2JMnFbUPgYzsZE6ivHtUUf/bmt10lPlX648P3XRm/6PhGASw/
 IVqpZWi1XvmuCCpbrJb6T9yGLKofbllSO75dMJg0SX2DSddRSgAILLOXuPDdGiCcnWWL
 b8wkbW2m+KfT8r1gNthwrOlyycHkMqpqibOgq0vfIvuvRQ/GobxB0IofW1iTZWbDsjXJ
 agRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534798; x=1769139598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnCVV9AnEgawNA+fiIe+uEXCZKJSFhPJndsOefTu71g=;
 b=fFE6Ush58oMEeW/zId3XKxC9KWHP2amdWbRrmkNPrSxndG0QVF7uWmrCW9Y+AdUUL1
 Xac8fuaauBt+5hJIATzXHNdcBe1KsEcq8zrl1bi3N49kl/V+oIz/s97vhhwxjfVyB/Bb
 SFULa+sAEFlTzBlqXva0AEow+YSRE6QSbyOVZBO8BiyVwFy+nObdzyGtTnJQzbeGYVtu
 zsCrSB/mK+NGn1vd47c37jQSChhr93MC7rOCJS29VZ9YKg6CLLbiV+fM6+p/ZiUkSL/r
 BWO1HDl/UziB5zE1X0zaaD0P8p/ouhKhd3GvpTdxvEsarIGpD4+6paOIx1MlAZd+T61A
 I7BA==
X-Gm-Message-State: AOJu0YzLpAP47UK2FKKuu4GguqaLS2Mc5S8q3WQVBPehpZugaxnXLCOQ
 4tYsxfP4mTwsJW+xapf0CzmUhvVyLIK8g9dvXKVXEGnCMVVQXirHc/yJnywbknxrciTk6z9aF7L
 4YLQbd4gpDg==
X-Gm-Gg: AY/fxX7EI15tjb3m4aBsLNoGe0tRMYe/JWM/2N4RSk3Zt8uDooxtKKRCReb8y9SaOoh
 ChUg9xqY/PPWB//mP0/bblXHX0kDF7sLt+rVh0SKE91fYK+KUNFi9GinbX2N8UNnMiW/64CWzSJ
 0+B+o5GD27wcjfA/THYoMKh4fd8sE/6cX0ueukbjrQV8vhF2Dc2D+JFhRXxbphHAvBOYkHQRNUm
 epqve5s3eiQTFIUUOqwnq6RvSH0MNTXosIGLfONZ3xaLZx/IsfIKQMx006WN/Ln36DF+fKCsQd/
 IxAbFBWEAXTU0TDE2FF1wlwrwGXmp6FQCae/MdzgFQp0LcGoQ90YCFAgMPJjp5clhKJJ/sj1jnf
 1gNUpX6wFN9ouzpGKDeX50xiO97f+pITX6qq0OrbXfXplqR3U4GxEhQ3CTJXXz/fdUXsZqW8ZGI
 77Eje7OXe4bi7ASNTh3Q==
X-Received: by 2002:a17:903:1105:b0:2a3:e6fa:4a06 with SMTP id
 d9443c01a7336-2a7189295edmr13757415ad.39.1768534797598; 
 Thu, 15 Jan 2026 19:39:57 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 58/58] include/qemu/atomic: Drop aligned_{u}int64_t
Date: Fri, 16 Jan 2026 14:33:04 +1100
Message-ID: <20260116033305.51162-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

As we no longer support i386 as a host architecture,
this abstraction is no longer required.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h          |  4 ++--
 include/qemu/atomic.h                | 13 -------------
 include/system/cpu-timers-internal.h |  2 +-
 linux-user/hppa/cpu_loop.c           |  2 +-
 util/qsp.c                           |  4 ++--
 5 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index ae5203b439..f7924078f7 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -27,8 +27,8 @@
 # define SHIFT      4
 #elif DATA_SIZE == 8
 # define SUFFIX     q
-# define DATA_TYPE  aligned_uint64_t
-# define SDATA_TYPE aligned_int64_t
+# define DATA_TYPE  uint64_t
+# define SDATA_TYPE int64_t
 # define BSWAP      bswap64
 # define SHIFT      3
 #elif DATA_SIZE == 4
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 27d98014d4..dc9290084b 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -234,17 +234,4 @@
     _oldn;                                                              \
 })
 
-/*
- * Abstractions to access atomically (i.e. "once") i64/u64 variables.
- *
- * The i386 abi is odd in that by default members are only aligned to
- * 4 bytes, which means that 8-byte types can wind up mis-aligned.
- * Clang will then warn about this, and emit a call into libatomic.
- *
- * Use of these types in structures when they will be used with atomic
- * operations can avoid this.
- */
-typedef int64_t aligned_int64_t __attribute__((aligned(8)));
-typedef uint64_t aligned_uint64_t __attribute__((aligned(8)));
-
 #endif /* QEMU_ATOMIC_H */
diff --git a/include/system/cpu-timers-internal.h b/include/system/cpu-timers-internal.h
index 94bb7394c5..8c262ce139 100644
--- a/include/system/cpu-timers-internal.h
+++ b/include/system/cpu-timers-internal.h
@@ -47,7 +47,7 @@ typedef struct TimersState {
     int64_t last_delta;
 
     /* Compensate for varying guest execution speed.  */
-    aligned_int64_t qemu_icount_bias;
+    int64_t qemu_icount_bias;
 
     int64_t vm_clock_warp_start;
     int64_t cpu_clock_offset;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index e5c0f52d94..972e85c487 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -83,7 +83,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
                 uint64_t o64, n64, r64;
                 o64 = *(uint64_t *)g2h(cs, old);
                 n64 = *(uint64_t *)g2h(cs, new);
-                r64 = qatomic_cmpxchg((aligned_uint64_t *)g2h(cs, addr), o64, n64);
+                r64 = qatomic_cmpxchg((uint64_t *)g2h(cs, addr), o64, n64);
                 ret = r64 != o64;
             }
             break;
diff --git a/util/qsp.c b/util/qsp.c
index 382e4397e2..55477ae025 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -83,8 +83,8 @@ typedef struct QSPCallSite QSPCallSite;
 struct QSPEntry {
     void *thread_ptr;
     const QSPCallSite *callsite;
-    aligned_uint64_t n_acqs;
-    aligned_uint64_t ns;
+    uint64_t n_acqs;
+    uint64_t ns;
     unsigned int n_objs; /* count of coalesced objs; only used for reporting */
 };
 typedef struct QSPEntry QSPEntry;
-- 
2.43.0


