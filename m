Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40900C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNV-0006zR-4K; Tue, 30 Apr 2024 15:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNT-0006vw-UW
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:42:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNS-0006k4-0p
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:42:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ee0642f718so156252b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506176; x=1715110976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=jyrlgSxyJz4WA3y0n8yczB1a1uw4UoXPRQKHoOAnOf08P2rE73TqGRS+pETOAc7uDu
 Qt/Ei9UYr1XdeA5hiVKFbslLaHG3oPk+MjwxBN9DBv9oeg6UtPGBYWGw2gcKk+dHE7Gb
 e+YIRgJ4qNnNLHXvOx/FR1pWwlNAwYEN86Hp9XW4srF4XwUhk40S8veQL8QkDBhdo3rp
 SaDB/YSlxVCOH24ljqKjets5R2lkD3ypzZN7jpOu683KL1eyXGbPTs8I0XeB3+P4bq4p
 yoa1rgPPD32pkOnsofGjQrwhG0cUmc57JUeB6ghDpgXdg8ZL6jtjKPY2OlRvIO7CRYDp
 lcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506176; x=1715110976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=k39JDDmRGdAo5ITxMPeQOiKexHZCEIcMrcjP/g478ZE4wEJl6fb8yIEJFtLB1oyyA5
 plYoKckonBTpPZE7fHLIow91UKPz4+rF8NU4+heemsDkIt36SBnrtDMDdAwhhculR11l
 h1dzV7JVzdmCWYVCkXcUpX82nSqQRkKGoNkKhOLY2li/TL5ZVrPsuPw4msWfANLMAhAO
 dUvOXM+4UlOToEvCmlj76o4/6HLQklHy7gaWAd0S1qA+5Yv+09dzuOYdz5op7totagnL
 T/rcbK3o7reRQXFPRHTiyKrUMHp/aDSQ7OqV97XMmaNgmHBVJzErLuPRY6lRcMd03t5Y
 N3IQ==
X-Gm-Message-State: AOJu0YzYf1otlUtoHc6NtbYs2alpwPaLAkeCmU2/hpbUpNM+kELU0BNC
 XT8WNbINZLGhm2vywhIpchqEG4M58/iL0T3uVsIyDimzNK4PFOgKYxwszMKfZQkQ+ZcvAIP0rBf
 l
X-Google-Smtp-Source: AGHT+IFEI62dj90nSR4ObKwfMFT8hluPpIYlQNhS+Oi6PZ784OBf+esmXv7MvzqaNh+R/cSgCPaazQ==
X-Received: by 2002:a05:6a20:7f99:b0:1af:37bf:d7de with SMTP id
 d25-20020a056a207f9900b001af37bfd7demr1320087pzj.7.1714506176156; 
 Tue, 30 Apr 2024 12:42:56 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:42:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PATCH v7 01/10] util/bufferiszero: Remove SSE4.1 variant
Date: Tue, 30 Apr 2024 12:42:44 -0700
Message-Id: <20240430194253.904768-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430194253.904768-1-richard.henderson@linaro.org>
References: <20240430194253.904768-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

From: Alexander Monakov <amonakov@ispras.ru>

The SSE4.1 variant is virtually identical to the SSE2 variant, except
for using 'PTEST+JNZ' in place of 'PCMPEQB+PMOVMSKB+CMP+JNE' for testing
if an SSE register is all zeroes. The PTEST instruction decodes to two
uops, so it can be handled only by the complex decoder, and since
CMP+JNE are macro-fused, both sequences decode to three uops. The uops
comprising the PTEST instruction dispatch to p0 and p5 on Intel CPUs, so
PCMPEQB+PMOVMSKB is comparatively more flexible from dispatch
standpoint.

Hence, the use of PTEST brings no benefit from throughput standpoint.
Its latency is not important, since it feeds only a conditional jump,
which terminates the dependency chain.

I never observed PTEST variants to be faster on real hardware.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-2-amonakov@ispras.ru>
---
 util/bufferiszero.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 3e6a5dfd63..f5a3634f9a 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -100,34 +100,6 @@ buffer_zero_sse2(const void *buf, size_t len)
 }
 
 #ifdef CONFIG_AVX2_OPT
-static bool __attribute__((target("sse4")))
-buffer_zero_sse4(const void *buf, size_t len)
-{
-    __m128i t = _mm_loadu_si128(buf);
-    __m128i *p = (__m128i *)(((uintptr_t)buf + 5 * 16) & -16);
-    __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
-
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        __builtin_prefetch(p);
-        if (unlikely(!_mm_testz_si128(t, t))) {
-            return false;
-        }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
-
-    /* Finish the aligned tail.  */
-    t |= e[-3];
-    t |= e[-2];
-    t |= e[-1];
-
-    /* Finish the unaligned tail.  */
-    t |= _mm_loadu_si128(buf + len - 16);
-
-    return _mm_testz_si128(t, t);
-}
-
 static bool __attribute__((target("avx2")))
 buffer_zero_avx2(const void *buf, size_t len)
 {
@@ -221,7 +193,6 @@ select_accel_cpuinfo(unsigned info)
 #endif
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    128, buffer_zero_avx2 },
-        { CPUINFO_SSE4,     64, buffer_zero_sse4 },
 #endif
         { CPUINFO_SSE2,     64, buffer_zero_sse2 },
         { CPUINFO_ALWAYS,    0, buffer_zero_int },
-- 
2.34.1


