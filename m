Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB327C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWuA-0007jU-49; Thu, 15 Feb 2024 03:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtb-0007Cd-3y
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:07 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtZ-0001OY-8c
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:02 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c132695f1bso481388b6e.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984900; x=1708589700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEYj0I5Vz7Ix2So9xIua9K5UZDr6lKDlAW8K2SObdT4=;
 b=hklfNXwg1fcyK0do01I1ggFKQiV5W+zkjiAM/cdWkcEFjZ1D2vRtg7+OWYPBUcvrCu
 H84lYwspOEypdoqqPoF8limVeVwUIv9hpP0RHR+k7FxrGgfKgOE3cLNsyYeSvGOoBChV
 GwtHW8R/GiaeW4WDogl7naR+aKy+VzgFfFWbFGLRAh6M4+LqYjh/iNziY6v7wmjEUTZ1
 0lCG4h2E4HrbuWjbnTZdHaCcl0OukeHv8io2BqGOJDykMnxFcHH0CtEq7wy6ADxLT31J
 /mQAbc5AKyWSUFQv/X117tvVz9nACNccVqyWEMpRuIrlOCZXDGb+lXmFxKSzaGKrvb6T
 vQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984900; x=1708589700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEYj0I5Vz7Ix2So9xIua9K5UZDr6lKDlAW8K2SObdT4=;
 b=U+2Wt6ghFS7zcwBOPyDMJfYgiFgL5+wPNmNTzSV5o91ITH/S8XRisNuk8t4GANUJnU
 eGtlknRCUsyNjLbJsS5hg0vR1dyDaNc3TJ/0FgYDTIfBlYhM2BDflqnS6kYe/aGWVTP7
 UFj8Ken0CeFIMOZMr7rNvl+oHIzCreaDsgnN2oNV9Jr1Yhv1ZIToSbdl12iPwet/BSFA
 5PIkJ9cxLMMqkDaWvM+DHREctsjitgUsZwT/HWt20s84Acm1w/R9tqnNqkdVtQaGJyQW
 dpcLNF0RA75woMLGZFpfNwu4S42z6ZllqDFxrnCjus5AEZxPR4KYF1Rp7xKW0uNBccRY
 FHng==
X-Gm-Message-State: AOJu0YzWWuEerkF/QzDPCJCPhPXcBoFypEZ+0UfWP/2CP3bI2Nh1bbJB
 Dh7+YtzZJY+jdAlmgic/419vcUMOmuC6et6pvEdMIyIPdrV552imjn5iAGkflgGLCSv5ClxBfre
 0
X-Google-Smtp-Source: AGHT+IFOLM0FrUNRqqzDSgX28Sd59EqhEkhkYq4B3kVA5R4+ck7WlT+FhoeR6ocoQMzyHGhkdlRVcA==
X-Received: by 2002:a05:6358:885:b0:176:5d73:34ef with SMTP id
 m5-20020a056358088500b001765d7334efmr933588rwj.24.1707984899769; 
 Thu, 15 Feb 2024 00:14:59 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:14:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 06/10] util/bufferiszero: Improve scalar variant
Date: Wed, 14 Feb 2024 22:14:45 -1000
Message-Id: <20240215081449.848220-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Split less-than and greater-than 256 cases.
Use unaligned accesses for head and tail.
Avoid using out-of-bounds pointers in loop boundary conditions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 86 +++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 2822155c27..ce04642c67 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -28,40 +28,58 @@
 
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
+     * the beginning and end of the buffer, with a couple
+     * of loops handling the middle aligned section.
+     */
+    if (unlikely(len <= 8)) {
+        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
     }
+
+    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+    p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
+    e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
+
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
+     * the beginning and end of the buffer, with a couple
+     * of loops handling the middle aligned section.
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
@@ -173,7 +191,7 @@ select_accel_cpuinfo(unsigned info)
         { CPUINFO_AVX2,    buffer_zero_avx2 },
 #endif
         { CPUINFO_SSE2,    buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,  buffer_is_zero_integer },
+        { CPUINFO_ALWAYS,  buffer_is_zero_int_ge256 },
     };
 
     for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
@@ -211,7 +229,7 @@ bool test_buffer_is_zero_next_accel(void)
     return false;
 }
 
-#define INIT_ACCEL buffer_is_zero_integer
+#define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
 static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
@@ -237,7 +255,7 @@ bool buffer_is_zero_ool(const void *buf, size_t len)
     if (likely(len >= 256)) {
         return buffer_is_zero_accel(buf, len);
     }
-    return buffer_is_zero_integer(buf, len);
+    return buffer_is_zero_int_lt256(buf, len);
 }
 
 bool buffer_is_zero_ge256(const void *buf, size_t len)
-- 
2.34.1


