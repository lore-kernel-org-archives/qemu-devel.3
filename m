Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D92C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNa-00073I-0Q; Tue, 30 Apr 2024 15:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNY-00072q-1R
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:04 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNW-0006ku-7B
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f3f6aa1437so2738054b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506181; x=1715110981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Qmmrii1MrzzFxsfdpzzNrItPzYs13dw3hkqKeZdH+k=;
 b=cy4zmznJAcao1kBq08IuJhK25cncXnPZWLj/14XHPtz/YO1J8pP4rNt5JQ5FalpaWp
 1Xh15Ru4N/ZT9bSd4AnX2gOknlthWo3kdqpBs9dRaxl0IZ1oXmXYg1DNS8VUylT1oV3i
 TknEjBvmemhaEGEnoVwo3J6kbuS8RryUy4yY3CCRFUBCn9jds9dDxOJUU+vUkJ5p3sNl
 ftVfbMKSPmx5eP/3A13hVMWNGU+TM15ik4giuZTJ1iTDIus8KnK6m4jKcMZcwBLanfwy
 qgtfhVbpo0u1x7e52XIWlpoc+/SxFtHNvl4akNQsqTyNnAduH1B0O9vBxy/0or1iT9gZ
 9byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506181; x=1715110981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Qmmrii1MrzzFxsfdpzzNrItPzYs13dw3hkqKeZdH+k=;
 b=FgojV91O4PaH87xGPapPeS0dMsk05g64Wx8mE6bn3BJaVF2kUonLl08SiWx0t4AXxn
 NVp7H5Asrivg446dRSqjY3aKyCeNvr04em1BnyTm9x7D11zlayXMsvDzAnXwSrxaZbFv
 eRIWPyYNGrtjsmm+dfCOZ2SYnRPd6QvsnpfLD7ZIH0oI9smaZ2j3IhDYMn26LjTOo+bq
 kcdowNxS7F2THUe7UN9MApPZ9SxbRsfnbkBb8VmpEfMI0E3iPWhm3SO97tsj6sLppzy2
 okiRV9Gt92mNxHKMGTerLC1g1GUl6GpPt92f2tZ/Szso+LEAsFD0qGhOBogH17kbEKkB
 QISA==
X-Gm-Message-State: AOJu0YztbZnbfZ0dEe/X2gGtLH643pSRIpU7GxnLFqNIWUSqTC5keFC7
 DefN8jMvHJ3A7Z6By1SwRh9vLbfSBsLeDuHtnMVN80jHTKrtvf+cJ2BBIqlwGGAXD9L7Al3Szhn
 h
X-Google-Smtp-Source: AGHT+IFDx1D68BAjev7yaSLnYEc1wkBF3u+3O3Wu0gIeMFsKA2CN/fUEOUzPkwyy4hS4lVGLYrA+3A==
X-Received: by 2002:a05:6a00:3d41:b0:6f3:ea4b:d24d with SMTP id
 lp1-20020a056a003d4100b006f3ea4bd24dmr710186pfb.9.1714506180658; 
 Tue, 30 Apr 2024 12:43:00 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:43:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v7 06/10] util/bufferiszero: Improve scalar variant
Date: Tue, 30 Apr 2024 12:42:49 -0700
Message-Id: <20240430194253.904768-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430194253.904768-1-richard.henderson@linaro.org>
References: <20240430194253.904768-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


