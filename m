Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F6DC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYN-0005Sb-9D; Wed, 24 Apr 2024 18:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYK-0005Pg-2X
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:24 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYH-0001oe-QB
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:23 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-60585faa69fso307995a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999440; x=1714604240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m6Ty8XllMR28noTCDsk0N/pyr7ynqbZ4X/2NsrzAk7g=;
 b=EIJF2JfFle4HshL+IB2q0BEng8M3pVv8dlpmDkzESnUYV9Xdw0mHZknY4Wtt28xBgB
 PMCL1SSlm4zJXxSCvaylY4neRB1pUidZRK0gTdp+O6bd6GGGm3hQlixzdvQMx1VQ27dm
 0oTkWnMosRiXacHJVvChmjv4Ydhn44mXgCXDGilCMESKDp8IhNUG5W4UeMuYHz1SY0+I
 n6ajMcNSlOOfmudFITevwxfh/q2G9Mu4MiTZy6eE9r7KpK+Sfp2kmgt/lj1rz0QnjO/T
 MSIy6dkvtDfifhfdj13yHeGsraNw6z/hpKuDGryA8NMs+OaBwbKtDH0vvBF0/EPQbJ8q
 5i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999440; x=1714604240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6Ty8XllMR28noTCDsk0N/pyr7ynqbZ4X/2NsrzAk7g=;
 b=jeXPeDvGmytZwrXMjufH3+i5CcQ+b+tin+SUuC4rj9lFkdJiaJQ4WfFhkrP47AH9Lt
 ELBWQi+FwotJBd66ACHR5nFAzLYPaAj2RkvetcAsi8EZp9QXtIJ9o2tDwF7HLiIIFe6/
 3QwevKKLr3hdAtB/FbVJsRV41ncdSDohLYHUlwbvHOhu5TpMekUJfbcw9j5wrX1LUgwP
 3QBrMvfbxVr7BHPYfkk0Pq2jMXySghzIuxcvXPFoiUtN1Hdsmkat6awFWWTPkFtcSgS+
 o4cgzxDPT25vPUgjb51rJMKxqWzQqKL1SlIlTZ6U3AjIs56OmUh1+TEzuJ2+tW4jBN9k
 7Xgw==
X-Gm-Message-State: AOJu0Yz80XXeCasE9nosdeiyeOTaVoEB44PCtXH0tuhiEnQPen8Q607+
 JD7CE29AQobkJkrKIbXEdFeLV75IYh99EaJr8rOWBO4bdy0zTnQowAgOfFyei+9brYKsf5TcYHM
 N
X-Google-Smtp-Source: AGHT+IFi3v3haAiVYAcS0Tq2YknEglq790m6wZExwKUTQRhXLSQ3+D27uE22H/jdfOxwFiT6kqpIug==
X-Received: by 2002:a05:6a21:3989:b0:1a7:9ed1:fc21 with SMTP id
 ad9-20020a056a21398900b001a79ed1fc21mr1899489pzc.22.1713999440407; 
 Wed, 24 Apr 2024 15:57:20 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/10] util/bufferiszero: Improve scalar variant
Date: Wed, 24 Apr 2024 15:57:01 -0700
Message-Id: <20240424225705.929812-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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


