Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3BDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubL-0005pn-3g; Fri, 03 May 2024 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubH-0005mq-1z
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubF-00076k-Fp
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ec92e355bfso30523395ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749204; x=1715354004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFUk4wDI0aciOtV8kFy/BP1LluK4qErzNDWj4G5aLoM=;
 b=kReMUPPRgvFQzo7EhT8Um2sWNn506XqghEa1T+zqmXmqb9U/9HKPG14/jk47HH/Ty6
 tMGNW/9LxnUGv1fzow/TKPujS8lbOoNPmjVzxVpa+UdsXlf33MT5kRG4pYskI8A4CGLE
 AbYa4+bvbfP/g2R7zFB5j2ucXa92x2GHE/+q80u55TmjWmmmytKBFFlzqyvQBueanYJ4
 SbJAJ4EgFW5jSeY6jbAItvkylbh+9TS+BM2KijR3ep1y5hdN0XXrCgxrpTq15fdmCtsK
 hFDQRMFcVayfbtrmsOjODSTxZ9Qa43/wPduWbTVT0vrjpbR2YHtrTAPVkuHvJGd7Yoxq
 59Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749204; x=1715354004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFUk4wDI0aciOtV8kFy/BP1LluK4qErzNDWj4G5aLoM=;
 b=horHJc/vkRnmqLtBLNHYr1WbceUvHShPS1K8G4q32uifTQJOOysQCfB2D+wdUDkDiw
 rmAgWYKLKffO17xbQWJ/W+YcwYhMsB4B0rQRBz1AP+N06xYJaZ1CMeU4Pj1veXGYyKfu
 St/zUO8mBj3iTFlYIBk2zT7Dc07OnOs3frp7oe821+gLPB0nxI76mBLXSIf2aJ2O8Yb5
 gjmGh91SWIjE47gChyNu7fsvClSVuLgA/d9/wStlk3GoiAEidcOLfLWnBmciLscRYQo5
 0Ec5xBSE44unZq/wGIuMnNRT6OlbVyDimY+KYEDQ8IEXNz0jcBud2va7ZIttOVut3mo2
 ITvg==
X-Gm-Message-State: AOJu0YwUwHnPVe6aDg/TFjf7f9nER0850hqji2cfwftg0mtbR9A8ZxAG
 tGV42gm5pwenq02pgNGmJdO8FHNQ3HA+q1j+PvQdhbwghPzw7DedFSo9A/bS3cCkrFzX6MiiyDz
 c
X-Google-Smtp-Source: AGHT+IGWMGNLk/sVFqK0SI9o+KHo5uyZiFgKLUUIq3pUIJVe8lrkFUzKj59RrTINNhLS2RwAit9SHA==
X-Received: by 2002:a17:902:a617:b0:1eb:d914:64e4 with SMTP id
 u23-20020a170902a61700b001ebd91464e4mr2576353plq.32.1714749204282; 
 Fri, 03 May 2024 08:13:24 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] util/bufferiszero: Add simd acceleration for aarch64
Date: Fri,  3 May 2024 08:13:13 -0700
Message-Id: <20240503151314.336357-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 7218154a13..74864f7b78 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -198,6 +198,73 @@ static unsigned best_accel(void)
     return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
+#elif defined(__aarch64__) && defined(__ARM_NEON)
+#include <arm_neon.h>
+
+/*
+ * Helper for preventing the compiler from reassociating
+ * chains of binary vector operations.
+ */
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
+#define best_accel() 1
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_is_zero_simd,
+};
 #else
 #define best_accel() 0
 static biz_accel_fn const accel_table[1] = {
-- 
2.34.1


