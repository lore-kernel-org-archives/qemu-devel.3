Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1302C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWu8-0007cZ-5w; Thu, 15 Feb 2024 03:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWte-0007DT-Rs
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:08 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtc-0001aA-Vn
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:06 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso512868a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984903; x=1708589703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcHS8hoi1egiJUTZk4E4y/djhNgaSWqSASRO2zuVQnQ=;
 b=nl58qaCR9J7WIXMixV12jPnvQKM3Ubuh2eMGbMGT/qbvYSFqvSmUaW6C6/PsL92jN1
 2/nOgMfihxlLLu/0XWjrn4tioz46du1BqfXhV0tfRDkoEtBjD3HJlxQFVcu9sGsHPeAJ
 Q+/6mbybfb0TiYQUI6tS/MuK2w6sgOxLkwHOct4OcyDHVHOsR23ZBDNk5Nzal2Hw36Jo
 C2IeuRCXa82RnrHmBxnArO0wQll713nBcu/4iOy3+gKDZ/lXm1KAcurQJHox3fOiSJlM
 xyPLjSBDuUBIDGxeCy2dcKqOePiGVL7Cjy8sDE47Zx8Rs7aM4DNnjnR+lLHynww7ukhK
 ZfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984903; x=1708589703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcHS8hoi1egiJUTZk4E4y/djhNgaSWqSASRO2zuVQnQ=;
 b=JdneTIrRGPLb/nkv/nEChhFPJbf6jBdbqt5AFpu98qvrSNq/MuVfesGM0oj3c1Yulf
 O78a5RXg4MS3B4Zne88CpFSZB9duONmekHtlVuVTcrMXHQ9HAaRZa243moOtckjEX8RL
 MVZ7hJwu2002HqHop19kJOdLOT22IRDz6e/y+dsfXRRoAAV5RoesPXQLJFQa/TOOEa9M
 3w9UwYAVBBtL2agYXWDp6Y+fHRoM5lPd7nlppMrYJStpOZDrBk5TmShmFS5Qs9qk43jG
 LClWyK2+rT4Y37Q+KJFZUJUAcgJM7BldgrX2BlrXkW9T5pebfGV7WbhHSGeDQ5qpfDi7
 sJSQ==
X-Gm-Message-State: AOJu0YzueWXD0mN1QoKtG6ezbmBA8OMIWyPlbfilDn59MtQcb58yXlgk
 wlpPZF0En3kAlmM5IrDrP80wWGI4BuaHPSjqJ9JGq5eF9GZ442dbxZEfJ5J6Z/d4QO8BJsbWpou
 i
X-Google-Smtp-Source: AGHT+IFu6R4mEqQO92Y8u5pn3OeNLkZw1YBCa/57uEnzHK4ZYR1rdiPHxiZQXAeKvZTOWoOmQzrSMw==
X-Received: by 2002:a17:90a:c587:b0:298:c2a8:4ade with SMTP id
 l7-20020a17090ac58700b00298c2a84ademr953288pjt.28.1707984903549; 
 Thu, 15 Feb 2024 00:15:03 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:15:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 09/10] util/bufferiszero: Add simd acceleration for aarch64
Date: Wed, 14 Feb 2024 22:14:48 -1000
Message-Id: <20240215081449.848220-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
double-check with the compiler flags for __ARM_NEON and don't bother with
a runtime check.  Otherwise, model the loop after the x86 SSE2 function,
and use VADDV to reduce the four vector comparisons.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 4eef6d47bc..2809b09225 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -214,7 +214,81 @@ bool test_buffer_is_zero_next_accel(void)
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
+        /* Each comparison is [-1,0], so reduction is in [-4..0]. */
+        if (unlikely(vaddvq_u32(vceqzq_u32(t0)) != -4)) {
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
+    return vaddvq_u32(vceqzq_u32(t0)) == -4;
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


