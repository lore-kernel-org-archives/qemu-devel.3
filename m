Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36424C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jn-000646-UP; Fri, 16 Feb 2024 19:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jm-00063l-B2
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jk-0008FB-JP
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:25 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so27591215ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130362; x=1708735162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=XvDDbv4qQrIQj7MG9zVeMlVChMd0+JgPo9jXjdSOZCgwgMfPWGI7hjpSEsnwE1vtbf
 Fbs/wU38AJ8HT148xV8fNLiFdS4TC2SSVYP9sI4KxtPnZIfaXWlmj2XEvOXYRUHTHC9M
 M/r1nEryzHPiFbS6Xen+upVb7Qa4z0jiEeFkyKjFlGKRNW8nyIGtVhjem0Mcbt3DzsJp
 aDJj0YatcNJOJyNtyo1oj8BwQUpmrMpa+1IWGMrnIrUGkS4vXO9H3m096qC/g71ttrNI
 9T+rLhzfQdF5ywtSCi9iSTaqVW0G/DvG/0wK2F97SVktgkV74H9uOrRBBGKoMQjuu78U
 XhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130362; x=1708735162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=ny597UNYM3sAnQerPUNMlw/yx4TTT7/b7BwiEjrSFXgOAVOpuWahNHgTE27jk8k6hM
 maj62NIVW7f6beONZv99JA4MXGtsr4cWNGNuprf4dlJ3m/NqXc3v3qao0GdV3aMhEUEt
 iXRiH1fnBDizE9EabxYYTA8cgqjfcIkqbh8FQZw0k5eUnm0YjJwIOizdvDlPLa53a7sH
 Rc6tjl2kEUgqEhcvOYmRuSQvoOdbLZ/fctu8gUJReA3GF2PKQERMDliWjStaJmSS0lEc
 dDZGhQKxjcL4pWlb+yEH1Gm0hASk2sZDbmlS0TQ5TCf+dbZO6WCRT5C93x0VFTt9ed0R
 tyjg==
X-Gm-Message-State: AOJu0YyFqv0tXV3xRqrPRJ1ydDM1baryAkHLejmAjvVT/7wLaQROfp35
 6oPRlwyqtDmzzVM9gIkJFo2JQBIKWeUufH2j3daDTnlkUbRlvFQxgwZgDU8XC6USoZTlXWQfLtL
 i
X-Google-Smtp-Source: AGHT+IEJLF5Nk2KGjvWbBSvAaIjfIacxkpabyBzKNJzrxjdcsrXd1qZ1sLrRvxs/ApTZDgkOso//iQ==
X-Received: by 2002:a17:902:e806:b0:1db:c6a0:d023 with SMTP id
 u6-20020a170902e80600b001dbc6a0d023mr368588plg.8.1708130362643; 
 Fri, 16 Feb 2024 16:39:22 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 01/10] util/bufferiszero: Remove SSE4.1 variant
Date: Fri, 16 Feb 2024 14:39:09 -1000
Message-Id: <20240217003918.52229-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


