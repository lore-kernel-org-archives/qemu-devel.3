Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42984C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QOK-0005uL-0Q; Mon, 29 Apr 2024 08:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1QNu-0005p5-GD
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:45:31 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1QNi-0005To-GO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:45:30 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso69994641fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714394716; x=1714999516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4eiya8siX0oHTjaQ0vqttSRYHx0jPgD3TE0e5lvk9YE=;
 b=yB5rN8Du4NjbUaBK/5RcAQL2oUSVuGeUXsxTKosufbsB5GXzspNOH/9QbN05/19zZe
 Z0sSIXWs+6VOKv/S1sCoZ6tjuLSXd03ql+SejV8G6Ibzc3cJspq/g9O+qnuh/F12SYdZ
 oExb6OqVr1UsxCl6cSh+lqahTCqQrohog9BtGJeDi+hmi1Y5z+0L2dsaHFINPwbZnDP7
 70lFzCJt/7jqp++h1af+wewVeLM5G0R10Pvd/4PdGqwZDsrATvUcQkk2yUsa4qgZllP0
 7GUTWviT5HAW+vNqhbmu8ua7c71MoYX6couRkLDBp5C5sxy9j5Lofexrvl8pX4r/94Nt
 s15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714394716; x=1714999516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4eiya8siX0oHTjaQ0vqttSRYHx0jPgD3TE0e5lvk9YE=;
 b=cdyxSMUkHiufSVKtdQR5N4TiNyXKf78dEgY8izc5f7bfoy9ag7n9YkHXeJw2oOlg0Z
 pDU1ardSwsTt1VDdybilGQq99jCn9s30fsTi5Bm0/+i/EZmXG9D+v2vn9YZERfYuSe0k
 J/D6/4kFZLBhyHyjlW0SSIkY9ywh97Hvv14JGbdYHhrGdfdKLwmAG67Tdq50FRzMk1I5
 E1y+BHUbDZA218Dr5by6nCYMbrhrnKMGvCNYKOYvYOFXBESFDVelCtMQXAVJyi6V1+E9
 Sfv5raTLatruL0pC1XRo4O1r0rgVX6CTubVr8xcfoGyF3uV5DlkLCceA8m2um0q0iWJz
 3jSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF3lu2k/OUtfQ9YY1ERQYOUSq9AfAjJl5WWOxRI7V4cztN/VMSAZo5VjLPJQQ84xv3Dn9CRZyrEPyvYWZFtQc7p06Ta5U=
X-Gm-Message-State: AOJu0YxXmGwCeA9h8s5QkcdivWxLhu1ww2ADH/KEHaFwJKJtfYusx+wq
 hA3W43fCdaVDLtE89PDhIZc5+vpJ4RfSh/7iwbiyM56XGSLtGtd6xmy+F0OF6Jc=
X-Google-Smtp-Source: AGHT+IFaBM7lYXrMwo0WJETvpYiNqB0OfBKrdukHcCD5MG0UyH3jv75neVs9eHUgL6iSGdN4n9AeKw==
X-Received: by 2002:a2e:9b0d:0:b0:2de:b987:e010 with SMTP id
 u13-20020a2e9b0d000000b002deb987e010mr7927156lji.0.1714394716153; 
 Mon, 29 Apr 2024 05:45:16 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 gc24-20020a170906c8d800b00a58f3983635sm2204109ejb.50.2024.04.29.05.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:45:15 -0700 (PDT)
Message-ID: <87468cc8-312a-4fec-90d7-3794aaec19f6@linaro.org>
Date: Mon, 29 Apr 2024 14:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424225705.929812-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 25/4/24 00:57, Richard Henderson wrote:
> Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
> double-check with the compiler flags for __ARM_NEON and don't bother with
> a runtime check.  Otherwise, model the loop after the x86 SSE2 function.
> 
> Use UMAXV for the vector reduction.  This is 3 cycles on cortex-a76 and
> 2 cycles on neoverse-n1.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index ff003dc40e..38477a3eac 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -213,7 +213,84 @@ bool test_buffer_is_zero_next_accel(void)
>       }
>       return false;
>   }
> +
> +#elif defined(__aarch64__) && defined(__ARM_NEON)
> +#include <arm_neon.h>
> +

Maybe use the same SSE comment:

/*
  * Helper for preventing the compiler from reassociating
  * chains of binary vector operations.
  */

> +#define REASSOC_BARRIER(vec0, vec1) asm("" : "+w"(vec0), "+w"(vec1))


> +static unsigned accel_index = 1;
> +#define INIT_ACCEL buffer_is_zero_simd
> +
> +bool test_buffer_is_zero_next_accel(void)
> +{
> +    if (accel_index != 0) {
> +        buffer_is_zero_accel = accel_table[--accel_index];
> +        return true;
> +    }
> +    return false;
> +}

Alternatively we could initialize accel_index in
__attribute__((constructor)) init_accel(void) and keep
a single test_buffer_is_zero_next_accel(), squashing:

-- >8 --
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 38477a3eac..afb3822251 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -82,6 +82,17 @@ static bool buffer_is_zero_int_ge256(const void *buf, 
size_t len)
      return t == 0;
  }

+static unsigned accel_index;
+
+bool test_buffer_is_zero_next_accel(void)
+{
+    if (accel_index != 0) {
+        buffer_is_zero_accel = accel_table[--accel_index];
+        return true;
+    }
+    return false;
+}
+
  #if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
  #include <immintrin.h>

@@ -186,7 +197,6 @@ static biz_accel_fn const accel_table[] = {
      buffer_zero_avx2,
  #endif
  };
-static unsigned accel_index;

  static void __attribute__((constructor)) init_accel(void)
  {
@@ -205,15 +215,6 @@ static void __attribute__((constructor)) 
init_accel(void)

  #define INIT_ACCEL NULL

-bool test_buffer_is_zero_next_accel(void)
-{
-    if (accel_index != 0) {
-        buffer_is_zero_accel = accel_table[--accel_index];
-        return true;
-    }
-    return false;
-}
-
  #elif defined(__aarch64__) && defined(__ARM_NEON)
  #include <arm_neon.h>

@@ -277,25 +278,15 @@ static biz_accel_fn const accel_table[] = {
      buffer_is_zero_simd,
  };

-static unsigned accel_index = 1;
  #define INIT_ACCEL buffer_is_zero_simd

-bool test_buffer_is_zero_next_accel(void)
+static void __attribute__((constructor)) init_accel(void)
  {
-    if (accel_index != 0) {
-        buffer_is_zero_accel = accel_table[--accel_index];
-        return true;
-    }
-    return false;
+    accel_index = 1;
  }

  #else

-bool test_buffer_is_zero_next_accel(void)
-{
-    return false;
-}
-
  #define INIT_ACCEL buffer_is_zero_int_ge256
  #endif

---

Or clearer in 2 patches, unifying test_buffer_is_zero_next_accel()
first:

-- >8 --
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index ff003dc40e..b4da9d5297 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -82,6 +82,17 @@ static bool buffer_is_zero_int_ge256(const void *buf, 
size_t len)
      return t == 0;
  }

+static unsigned accel_index;
+
+bool test_buffer_is_zero_next_accel(void)
+{
+    if (accel_index != 0) {
+        buffer_is_zero_accel = accel_table[--accel_index];
+        return true;
+    }
+    return false;
+}
+
  #if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
  #include <immintrin.h>

@@ -186,7 +197,6 @@ static biz_accel_fn const accel_table[] = {
      buffer_zero_avx2,
  #endif
  };
-static unsigned accel_index;

  static void __attribute__((constructor)) init_accel(void)
  {
@@ -205,19 +215,7 @@ static void __attribute__((constructor)) 
init_accel(void)

  #define INIT_ACCEL NULL

-bool test_buffer_is_zero_next_accel(void)
-{
-    if (accel_index != 0) {
-        buffer_is_zero_accel = accel_table[--accel_index];
-        return true;
-    }
-    return false;
-}
  #else
-bool test_buffer_is_zero_next_accel(void)
-{
-    return false;
-}

  #define INIT_ACCEL buffer_is_zero_int_ge256
  #endif

---

Then this patch becomes:

-- >8 --
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index b4da9d5297..afb3822251 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -215,6 +215,76 @@ static void __attribute__((constructor)) 
init_accel(void)

  #define INIT_ACCEL NULL

+#elif defined(__aarch64__) && defined(__ARM_NEON)
+#include <arm_neon.h>
+
+#define REASSOC_BARRIER(vec0, vec1) asm("" : "+w"(vec0), "+w"(vec1))
+
+static bool buffer_is_zero_simd(const void *buf, size_t len)
+{
+    uint32x4_t t0, t1, t2, t3;
+
+    /* Align head/tail to 16-byte boundaries.  */
+    const uint32x4_t *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
+    const uint32x4_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
+
+    /* Unaligned loads at head/tail.  */
+    t0 = vld1q_u32(buf) | vld1q_u32(buf + len - 16);
+
+    /* Collect a partial block at tail end.  */
+    t1 = e[-7] | e[-6];
+    t2 = e[-5] | e[-4];
+    t3 = e[-3] | e[-2];
+    t0 |= e[-1];
+    REASSOC_BARRIER(t0, t1);
+    REASSOC_BARRIER(t2, t3);
+    t0 |= t1;
+    t2 |= t3;
+    REASSOC_BARRIER(t0, t2);
+    t0 |= t2;
+
+    /*
+     * Loop over complete 128-byte blocks.
+     * With the head and tail removed, e - p >= 14, so the loop
+     * must iterate at least once.
+     */
+    do {
+        /*
+         * Reduce via UMAXV.  Whatever the actual result,
+         * it will only be zero if all input bytes are zero.
+         */
+        if (unlikely(vmaxvq_u32(t0) != 0)) {
+            return false;
+        }
+
+        t0 = p[0] | p[1];
+        t1 = p[2] | p[3];
+        t2 = p[4] | p[5];
+        t3 = p[6] | p[7];
+        REASSOC_BARRIER(t0, t1);
+        REASSOC_BARRIER(t2, t3);
+        t0 |= t1;
+        t2 |= t3;
+        REASSOC_BARRIER(t0, t2);
+        t0 |= t2;
+        p += 8;
+    } while (p < e - 7);
+
+    return vmaxvq_u32(t0) == 0;
+}
+
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_is_zero_simd,
+};
+
+#define INIT_ACCEL buffer_is_zero_simd
+
+static void __attribute__((constructor)) init_accel(void)
+{
+    accel_index = 1;
+}
+
  #else

  #define INIT_ACCEL buffer_is_zero_int_ge256

---

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


