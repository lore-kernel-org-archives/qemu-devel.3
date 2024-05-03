Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48AAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubK-0005p7-Et; Fri, 03 May 2024 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubF-0005k3-JC
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:25 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubD-00075t-F0
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e4266673bbso83928555ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749202; x=1715354002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Qmmrii1MrzzFxsfdpzzNrItPzYs13dw3hkqKeZdH+k=;
 b=m5CVamULNL0Iq0zx3tSiMVyDhEbrlQOmY+VTXVlQCFgM1wzefXWNDycNlbEmOhDzWk
 cvmT2yWUdEvlfxAu1CNH+kg/SU6jISxI4bbhHYLWWV2NjtU1B8BVZlUeii4jbhGGYmc5
 L127PivDbugFrfFykK32L2U2CxumYkQj9vSWEnwYpZjUtQS9blkS5OKlElzoGJaVZkri
 PNf09XpLAynaePqgbFisF1rYP+45GYm5nH+WGHxj+QSFk5U8R/PdTJxJnnSrA3ArdNPy
 9jDoclts6U354Vi2wE8qj66exl1Smms7bF5aiFk8GdF4RY90WoJ5yX4BA6LQI3rDTz5Q
 YD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749202; x=1715354002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Qmmrii1MrzzFxsfdpzzNrItPzYs13dw3hkqKeZdH+k=;
 b=k8DbXCRZpAHBUH72SEw7LXRPlMkHIZcUvym2Mnzc/Wyd0xpIB3AW/PuOb66Tj91bdZ
 M+XKJIfG3h2Xr/udV/5i4nkthGi9QfSHsNkGCLssaI9qk1SUE7Pxke+tclX17yYQEfTb
 StCo2OsAgjaOFS5ZPH4ZOOsW9+AD26g4oKSeqp4Y/QXyzEUDLCgAA/N45ZiVYjuaFPU0
 qyDBgkOuM6ZHv5Rc5rUzWL1W3eVyb0zkmQMCapEnYX//3SQm0BPnAwSR729hcVwazxgg
 +jRUIokPan2DclDZAIS9XXFt3J9N/gYQZl1hZmJ0NxBFftQqEKawZ+8RKM1bgikxoovW
 yviQ==
X-Gm-Message-State: AOJu0YzXksEo51GwTNdCxZnHkuvq34ZkM/x3l2P3qiabrc3bH9PJnhTf
 66OAWiP1VHBjJIKZf/xJiD3BgtUohdb9MGoX914tD2j1vucvS9Zalm2/OYc1YIB3dvwoMnsV1Ae
 d
X-Google-Smtp-Source: AGHT+IEy5mUV/CbXffYyjZyMckLhexUX8K31bNUq87gnz98An02aZwqSoPXyNGTl/JKztH79fs/T5w==
X-Received: by 2002:a17:903:2282:b0:1e0:c0dd:c5eb with SMTP id
 b2-20020a170903228200b001e0c0ddc5ebmr3482945plh.9.1714749201813; 
 Fri, 03 May 2024 08:13:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/10] util/bufferiszero: Improve scalar variant
Date: Fri,  3 May 2024 08:13:10 -0700
Message-Id: <20240503151314.336357-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Split less-than and greater-than 256 cases.
Use unaligned accesses for head and tail.
Avoid using out-of-bounds pointers in loop boundary conditions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 85 +++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 02df82b4ff..c9a7ded016 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -28,40 +28,57 @@
 
 static bool (*buffer_is_zero_accel)(const void *, size_t);
 
-static bool buffer_is_zero_integer(const void *buf, size_t len)
+static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
-    if (unlikely(len < 8)) {
-        /* For a very small buffer, simply accumulate all the bytes.  */
-        const unsigned char *p = buf;
-        const unsigned char *e = buf + len;
-        unsigned char t = 0;
+    uint64_t t;
+    const uint64_t *p, *e;
 
-        do {
-            t |= *p++;
-        } while (p < e);
-
-        return t == 0;
-    } else {
-        /* Otherwise, use the unaligned memory access functions to
-           handle the beginning and end of the buffer, with a couple
-           of loops handling the middle aligned section.  */
-        uint64_t t = ldq_he_p(buf);
-        const uint64_t *p = (uint64_t *)(((uintptr_t)buf + 8) & -8);
-        const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
-
-        for (; p + 8 <= e; p += 8) {
-            if (t) {
-                return false;
-            }
-            t = p[0] | p[1] | p[2] | p[3] | p[4] | p[5] | p[6] | p[7];
-        }
-        while (p < e) {
-            t |= *p++;
-        }
-        t |= ldq_he_p(buf + len - 8);
-
-        return t == 0;
+    /*
+     * Use unaligned memory access functions to handle
+     * the beginning and end of the buffer.
+     */
+    if (unlikely(len <= 8)) {
+        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
     }
+
+    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+    p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
+    e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
+
+    /* Read 0 to 31 aligned words from the middle. */
+    while (p < e) {
+        t |= *p++;
+    }
+    return t == 0;
+}
+
+static bool buffer_is_zero_int_ge256(const void *buf, size_t len)
+{
+    /*
+     * Use unaligned memory access functions to handle
+     * the beginning and end of the buffer.
+     */
+    uint64_t t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+    const uint64_t *p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
+    const uint64_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
+
+    /* Collect a partial block at the tail end. */
+    t |= e[-7] | e[-6] | e[-5] | e[-4] | e[-3] | e[-2] | e[-1];
+
+    /*
+     * Loop over 64 byte blocks.
+     * With the head and tail removed, e - p >= 30,
+     * so the loop must iterate at least 3 times.
+     */
+    do {
+        if (t) {
+            return false;
+        }
+        t = p[0] | p[1] | p[2] | p[3] | p[4] | p[5] | p[6] | p[7];
+        p += 8;
+    } while (p < e - 7);
+
+    return t == 0;
 }
 
 #if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
@@ -173,7 +190,7 @@ select_accel_cpuinfo(unsigned info)
         { CPUINFO_AVX2,    buffer_zero_avx2 },
 #endif
         { CPUINFO_SSE2,    buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,  buffer_is_zero_integer },
+        { CPUINFO_ALWAYS,  buffer_is_zero_int_ge256 },
     };
 
     for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
@@ -211,7 +228,7 @@ bool test_buffer_is_zero_next_accel(void)
     return false;
 }
 
-#define INIT_ACCEL buffer_is_zero_integer
+#define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
 static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
@@ -232,7 +249,7 @@ bool buffer_is_zero_ool(const void *buf, size_t len)
     if (likely(len >= 256)) {
         return buffer_is_zero_accel(buf, len);
     }
-    return buffer_is_zero_integer(buf, len);
+    return buffer_is_zero_int_lt256(buf, len);
 }
 
 bool buffer_is_zero_ge256(const void *buf, size_t len)
-- 
2.34.1


