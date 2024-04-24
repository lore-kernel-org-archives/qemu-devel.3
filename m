Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D715C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYR-0005UW-Ea; Wed, 24 Apr 2024 18:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYL-0005Q1-Pc
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYK-0001pD-A3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6effe9c852eso372618b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999443; x=1714604243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fwoFN6B2qbFkqUCTGf1HoUgZR053rQ1g2covN+0RlE8=;
 b=jaqRTVAyHV/qeNkMG4M2udOLBqLZpP33d1JgmFJVbkS6G9tUIYAV+W7TWA3h16qSXK
 D5/w6Qn3bdwLFcRg2eCBWHtwqTRY8tD0i6uMpqrdy5mvF/ve++a6VhSnxWvxL4Qqv6NZ
 EKZBv2qDMededM//hgPOSvQhlO5cOYG4+XqKUeHAYI1wvB6KW8c34h8HhhptWks7ARO5
 6htFN6megQYgq2+WBCcj0Ju3OEzKODF1d1CLLXjLMOU0bTybuz5mRZpQcS1p+M5Vb2kk
 7DSPUfTIubofzce/CuPR+63NkIeyU7LJKzuESI2wm/+OCTUoLQ3Sm3AOfSiYHZMLV7o6
 xbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999443; x=1714604243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwoFN6B2qbFkqUCTGf1HoUgZR053rQ1g2covN+0RlE8=;
 b=Ssa0twqbbzFbRwTPpnHmK8QG5qwB/xKXil6LulE7xGIzZAY5jekrayTuz9jA4Y/XYc
 JEk4LP56T6GrH8Uhv472qLnLwuMjE3PaUbhzKtTm2XI+95SWBkOSMdeZKmjMt+iOJwHJ
 Iq8v2sVRXenJT+8YNqxLQEI4OKFzIqaVz8dvKnI3s5vKmxd5RlvYyQmYMSjrzinrhH8J
 heu7FnMf+GcdVgYTqt+ZXBVlfRuFSQjiuJ2v7P8X/crQfGHneJ5d+knX6iM5vWtXgW8W
 Lk8SkYLcAN6tGqZziZmHhHMp1JxNeoHuqc+VNgmeALVI19N2bRRJyPm7kTjoDsL9XUwg
 rMZg==
X-Gm-Message-State: AOJu0Yw0hFmrCIege40BzVP2BsVsCm33NdxZM5FFvXTVJNFPNVmz/oO4
 HUtHrpmKOxHpQu3S6vCxIn+MNu7khMnPt8lEZyuVapZJYhhyJ4257CemP3zGn8aYHsbHaXwJ4QF
 i
X-Google-Smtp-Source: AGHT+IFamRqhDaRYK8RcUfPmPKyvWx8+95ilLjX4iflBV1yoHZOVn0Fm0nytRkETNFd5gENQ1I7hrQ==
X-Received: by 2002:a05:6a20:c901:b0:1a7:a3cb:7901 with SMTP id
 gx1-20020a056a20c90100b001a7a3cb7901mr4050098pzb.61.1713999443062; 
 Wed, 24 Apr 2024 15:57:23 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/10] util/bufferiszero: Add simd acceleration for aarch64
Date: Wed, 24 Apr 2024 15:57:04 -0700
Message-Id: <20240424225705.929812-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
double-check with the compiler flags for __ARM_NEON and don't bother with
a runtime check.  Otherwise, model the loop after the x86 SSE2 function.

Use UMAXV for the vector reduction.  This is 3 cycles on cortex-a76 and
2 cycles on neoverse-n1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index ff003dc40e..38477a3eac 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -213,7 +213,84 @@ bool test_buffer_is_zero_next_accel(void)
     }
     return false;
 }
+
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
+static unsigned accel_index = 1;
+#define INIT_ACCEL buffer_is_zero_simd
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
 #else
+
 bool test_buffer_is_zero_next_accel(void)
 {
     return false;
-- 
2.34.1


