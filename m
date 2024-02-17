Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A338C48BF5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8k0-00069Y-37; Fri, 16 Feb 2024 19:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jw-00068p-GA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:36 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8ju-0008Hf-N3
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:36 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d72f71f222so10656845ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130373; x=1708735173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm2M2ZI3+sRAHkQ9RNGmfsw8c3ap5NOHL92KrHqrl90=;
 b=kA48xw66PORKmXsTOCzNEriag+NXbpLyWYyRxlnGrFs7j3gQkhekaI+StgH8E6tedj
 SSaz3/rExDjdDybYQf5hP14UbFAuvAY6IHyzPSx3BdZhsNhbGgMwkLHARcd2EC896Kw4
 gEp7EeBMFWOokN8aiuqZr5nHAE/GiF2GM85W7Y200Nwi1OESSr90ebAM4lbkcHGgHoqT
 FhnSt0Iy5IZcACEAEedsT64Be2gG4wnjl20/D08Yn3OhZHoywKeo7+HOiB8viSdVH69p
 bHpIXVzmtMAyQgwHr72nqVG/bx/UEISRNg6f2UY50eaa4SGqnmAi7WPXWrax/TC36O6Y
 SO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130373; x=1708735173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mm2M2ZI3+sRAHkQ9RNGmfsw8c3ap5NOHL92KrHqrl90=;
 b=Q4iO0nOYCmnD81FhUuobDV8Gdo7otT1OEoHkC4YWZubYlGryrH9143YF3Cg8BT238u
 E8h51ewDdbCGY7AjoMTpckEPb/ZZn8Gt4dWq7AY8tvloz7a6tVyo/bLfoBKypsXyaTNh
 vG9DJnO+1JjyZGZW+pNr/j74NFigTH7J9U+cnAJyk62oSoPdj+aVjdBeOkrqB3enzFkC
 YHGCGpZx2QWB3PFtVzlL+e2MZXK//TeewXB3BRWEiPmdWYkN929aHKSpe/ACsFp1IIBI
 HjXmBpYAi6zCXTA9fiWNX2Sb8IVS8tbrNlDbkN4CrQvWLGIGCcTGoZnIgyBNWaEKVbOS
 Vuhg==
X-Gm-Message-State: AOJu0Yw9EYzw8XzGil1y+3VxgcV3J3TMPWpvvOjO5J2NXKs9IByKzuc+
 O3Z4G+ymz4SPvCyDoYbte3CT+9RkmWuPgQuZT4birCq0jCQz/bJwfrRiUbIW/GIfq0DfnOnIpIZ
 V
X-Google-Smtp-Source: AGHT+IH8uwpGuF/WTFpT9knSXYWt9W1ckHvRdJTxFVJSSLYygbK4DXoos7eTFBkLodxQUaEIQ29I3A==
X-Received: by 2002:a17:902:784b:b0:1db:4b29:9b21 with SMTP id
 e11-20020a170902784b00b001db4b299b21mr6122978pln.23.1708130373394; 
 Fri, 16 Feb 2024 16:39:33 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 09/10] util/bufferiszero: Add simd acceleration for aarch64
Date: Fri, 16 Feb 2024 14:39:17 -1000
Message-Id: <20240217003918.52229-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 util/bufferiszero.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 9b338f7be5..77db305bb0 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -214,7 +214,84 @@ bool test_buffer_is_zero_next_accel(void)
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


