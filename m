Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D34C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYW-0005ck-PN; Wed, 24 Apr 2024 18:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYL-0005Py-8G
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:25 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYJ-0001p5-KV
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:25 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-22ed075a629so211118fac.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999442; x=1714604242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DA4w6vWBcl/o/fCPqKs/e8JAcC2+x8OTjBrtE2E7+xQ=;
 b=kwDdxqO3dwbHcyqBo43kRllE23TQcpEJyqFw8JemDE5txYhXaZjr5WgsBgcTiU7Ejm
 oPepvBkr+bBnN/0hkqyAlcVobmN58khHUdPfJczQI0/7C5o+MNqpRkRyjFIlamDwvpKU
 tApVYVfuCq9BYWEm5OXybUvs8IEfLWpfcJsMgEKA9geYq6lI+pnsi8B844h2GHR9ZXSw
 z5h9tUzhYwbDn13d0SS4qoIp3JmMZThXE5CDzf7G/SarOiQ6QvxZTWx6LEE2SFb5Tq2t
 fZBk2bjZtot+kRPNWg21LZ8auV/QHVhJtc0JIhzNYYnyOoTGpl6DAWKgYk83SS2WRNF6
 K8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999442; x=1714604242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DA4w6vWBcl/o/fCPqKs/e8JAcC2+x8OTjBrtE2E7+xQ=;
 b=acAzHLS3v1oiBDndWd9ICYdvvpzewzCa6qcHkhRXyqTJlsV8aMaQlZArsgS7mv3Bre
 Rj6pEsgn3Gj6T3Ol7OwJnjFO1z0u1zRbgwrSmhh6wDCGzrV25L88vcZO9lR2BOMGrYBQ
 KXA2SITLRu2Uj6qF5kHv8MhSkcFVWL6L4OEAnAPrqUWPKMPNue/MVjuFWhQUvzyeJBtY
 sejZRpv4TB45NAa/VJ9w0upDeGq4NN8Dw4Q3GENtp1uPhoeBjUwf7P70xAugDbKvVWhP
 ggwVwnjPYf49YEC0EIO0O4Kv1clita1BGLf1882O55/DFx6IJUIFGWetJ+mKOMwcpQTM
 ATHA==
X-Gm-Message-State: AOJu0Yy1kWlDpHUXWIuTmRDv2tHKFSiJL+/Wik5Bb/bbjs0iXCsXjFPF
 5XLhlK+z6o5vNAr5G2y55c8f/cZ0UvS41LwP3TrHwvPUcbhxxFui/kgWXMF7pzNVmKFQ1E5a2vD
 T
X-Google-Smtp-Source: AGHT+IG3bT5ySJwUgYz37tDn+bAp8HU2yyWNKmX6roqcrz/95PLeYrJDjA+e7OoxEWrMCt3uybSb2g==
X-Received: by 2002:a05:6870:a345:b0:238:b140:1ab with SMTP id
 y5-20020a056870a34500b00238b14001abmr4443648oak.48.1713999442267; 
 Wed, 24 Apr 2024 15:57:22 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
Date: Wed, 24 Apr 2024 15:57:03 -0700
Message-Id: <20240424225705.929812-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Because the three alternatives are monotonic, we don't
need to keep a couple of bitmasks, just identify the
strongest alternative at startup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 56 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index eb8030a3f0..ff003dc40e 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -179,51 +179,39 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
-
-
-static unsigned __attribute__((noinline))
-select_accel_cpuinfo(unsigned info)
-{
-    /* Array is sorted in order of algorithm preference. */
-    static const struct {
-        unsigned bit;
-        biz_accel_fn fn;
-    } all[] = {
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_zero_sse2,
 #ifdef CONFIG_AVX2_OPT
-        { CPUINFO_AVX2,    buffer_zero_avx2 },
+    buffer_zero_avx2,
 #endif
-        { CPUINFO_SSE2,    buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,  buffer_is_zero_int_ge256 },
-    };
-
-    for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
-        if (info & all[i].bit) {
-            buffer_is_zero_accel = all[i].fn;
-            return all[i].bit;
-        }
-    }
-    return 0;
-}
-
-static unsigned used_accel;
+};
+static unsigned accel_index;
 
 static void __attribute__((constructor)) init_accel(void)
 {
-    used_accel = select_accel_cpuinfo(cpuinfo_init());
+    unsigned info = cpuinfo_init();
+    unsigned index = (info & CPUINFO_SSE2 ? 1 : 0);
+
+#ifdef CONFIG_AVX2_OPT
+    if (info & CPUINFO_AVX2) {
+        index = 2;
+    }
+#endif
+
+    accel_index = index;
+    buffer_is_zero_accel = accel_table[index];
 }
 
 #define INIT_ACCEL NULL
 
 bool test_buffer_is_zero_next_accel(void)
 {
-    /*
-     * Accumulate the accelerators that we've already tested, and
-     * remove them from the set to test this round.  We'll get back
-     * a zero from select_accel_cpuinfo when there are no more.
-     */
-    unsigned used = select_accel_cpuinfo(cpuinfo & ~used_accel);
-    used_accel |= used;
-    return used;
+    if (accel_index != 0) {
+        buffer_is_zero_accel = accel_table[--accel_index];
+        return true;
+    }
+    return false;
 }
 #else
 bool test_buffer_is_zero_next_accel(void)
-- 
2.34.1


