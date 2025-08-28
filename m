Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9D5C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauJ-0003cz-Cg; Thu, 28 Aug 2025 07:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauH-0003Z9-87
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauE-0005ss-U4
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c7ba0f6983so570362f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380901; x=1756985701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q260xObDFBnDUN8dnnYug1vSW1AKbW6lpt6JSmCuOfk=;
 b=YFYpGVdB95Xr8/WcTyOaBAmK5iZb5PwelBPLlEhgjpt7FWJKxvunyJOFJ008iJ0QPZ
 Waf7m3pWs5p0U5uO+tj1BP6RcEZ6bXGXt41b3kncakEYrhLzc+aMczB+GiTh8T0pHoFD
 S6pg2HGQUMNviOKIhrQyOl2scwzdsItGlZEUvPPBpkUgHbpbm13CXico+ICok6Xn4/DE
 SDCXSBA/5jq86SwL+AVbyF3yh3Zb9xv4NRRMm3auDGv/0ppCtAQgF3PYELEfcHxKTdPg
 G31/2dKnPTQHSdz46BOhGJXYAY1MJ1mwd3XA/OXsC5wv11Si9kXhCqDRP2GqxPGukXKb
 tx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380901; x=1756985701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q260xObDFBnDUN8dnnYug1vSW1AKbW6lpt6JSmCuOfk=;
 b=jIQ0SVwduUKkGIaxyh7lRdO9Rq7t4XKXYY4AWKDBUTz3Ft3AIg/i0PqRkXlId2CtiC
 2lVUHli3MlOuF4ggTLBpV/iabEL7lvITP515fvlwLGuoivRx5T40R7BnO8mcgMej1kWb
 IJessi7C5vV/iSE5Gwx6Z5RWJ6TKyOpgYdut8aTcl+Cc/BNyeXUX3YKIhsSQb1IIBqLS
 9SVYJvG8X9kNp7VGULmAroe98O3CsenUFXaC9pRlUz9A6Oz2xQWT/QD5xoCZTR2YCHXJ
 lvNu9GDkVA+mGdeCoCd8zv7sjgXIakv+mCLmZ4ikPFzpxTpLeVUg5lfjN4t8y2K8/ms/
 /0sQ==
X-Gm-Message-State: AOJu0YziCQZNro/2Lz6dzdi6EMAHd/mG86DH9dlPW7fgRcHf+WjfQT+Q
 mxJ9qqe1HdD4DZAeonk6G53O/gaLIusZ8Ck3/H+ZDVenVArwDdZMtddwoHIUUgK/uySs9439U8p
 FVaA1
X-Gm-Gg: ASbGncv/De4xHrZ0YQGOXS5P/d5G7nVKSmxHPU13WgJGfXkP4p+oHYAdvVFryDB36g3
 4l1U5P5AJ/hay0J1e3LTlPHEU3j0e5MPt3XgCEJBdf2I1HOnJHgeSPt/zrv5qymhtuKUGtYGaZw
 TVH0ZZBwPzntoGgvqMxw5n7CM0Noeaasp3X0vpB/mZbSuBPaTINHYj+ddqaURQsel6pnMaOfgVN
 TaXvHGS6UPGDt7pb+DRr7gGUsykcaYWQrGWk1pu6IQm3hewFrA1BVf626/b7wYJZIPQdu7B+FLS
 3XYLH4bDnx/bUtyYr2gvwK9ogJaC9JQxcLm0MDgHlgZbfl2XM9crTHrXWJ3mAnjnF1skITTp9Uv
 ZBKggioYMbKpHkEp8fcVaod51pqaCAthuh6K2x3o=
X-Google-Smtp-Source: AGHT+IFunqEnqpff7N+h/SgbjIf5DnVfZQhMk5axTZH9ij2WYv3AYaQ+ev/pIa1h4Vi6SB5k56KQ9w==
X-Received: by 2002:a05:6000:4007:b0:3ce:47a3:4675 with SMTP id
 ffacd0b85a97d-3ce47a34700mr1250989f8f.18.1756380901264; 
 Thu, 28 Aug 2025 04:35:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.35.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:35:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] qemu/atomic: Add atomic16 primitives for xchg, fetch_and,
 fetch_or
Date: Thu, 28 Aug 2025 12:34:23 +0100
Message-ID: <20250828113430.3214314-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h.inc | 57 +++++++++++
 host/include/generic/host/atomic128-cas.h.inc | 96 +++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/host/include/aarch64/host/atomic128-cas.h.inc b/host/include/aarch64/host/atomic128-cas.h.inc
index 991da4ef543..aec27df1820 100644
--- a/host/include/aarch64/host/atomic128-cas.h.inc
+++ b/host/include/aarch64/host/atomic128-cas.h.inc
@@ -38,6 +38,63 @@ static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
     return int128_make128(oldl, oldh);
 }
 
+static inline Int128 atomic16_xchg(Int128 *ptr, Int128 new)
+{
+    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
+    uint64_t oldl, oldh;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
+        "cbnz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
+        : [newl] "r"(newl), [newh] "r"(newh)
+        : "memory");
+
+    return int128_make128(oldl, oldh);
+}
+
+static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
+{
+    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
+    uint64_t oldl, oldh, tmpl, tmph;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "and %[tmpl], %[oldl], %[newl]\n\t"
+        "and %[tmph], %[oldh], %[newh]\n\t"
+        "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
+        "cbnz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
+        : [newl] "r"(newl), [newh] "r"(newh),
+          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+        : "memory");
+
+    return int128_make128(oldl, oldh);
+}
+
+static inline Int128 atomic16_fetch_or(Int128 *ptr, Int128 new)
+{
+    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
+    uint64_t oldl, oldh, tmpl, tmph;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "orr %[tmpl], %[oldl], %[newl]\n\t"
+        "orr %[tmph], %[oldh], %[newh]\n\t"
+        "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
+        "cbnz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
+        : [newl] "r"(newl), [newh] "r"(newh),
+          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+        : "memory");
+
+    return int128_make128(oldl, oldh);
+}
+
 # define CONFIG_CMPXCHG128 1
 # define HAVE_CMPXCHG128 1
 #endif
diff --git a/host/include/generic/host/atomic128-cas.h.inc b/host/include/generic/host/atomic128-cas.h.inc
index 6b40cc22710..990162c56fe 100644
--- a/host/include/generic/host/atomic128-cas.h.inc
+++ b/host/include/generic/host/atomic128-cas.h.inc
@@ -23,6 +23,51 @@ atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
     return r.s;
 }
+
+/*
+ * Since we're looping anyway, use weak compare and swap.
+ * If the host supports weak, this will eliminate a second loop hidden
+ * within the atomic operation itself; otherwise the weak parameter is
+ * ignored.
+ */
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_xchg(Int128 *ptr, Int128 new)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128 old = *ptr_align;
+
+    while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
+                                        __ATOMIC_SEQ_CST, 0)) {
+        continue;
+    }
+    return old;
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_and(Int128 *ptr, Int128 val)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128 old = *ptr_align;
+
+    while (!__atomic_compare_exchange_n(ptr_align, &old, old & val, true,
+                                        __ATOMIC_SEQ_CST, 0)) {
+        continue;
+    }
+    return old;
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_or(Int128 *ptr, Int128 val)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128 old = *ptr_align;
+
+    while (!__atomic_compare_exchange_n(ptr_align, &old, old | val, true,
+                                        __ATOMIC_SEQ_CST, 0)) {
+        continue;
+    }
+    return old;
+}
 # define HAVE_CMPXCHG128 1
 #elif defined(CONFIG_CMPXCHG128)
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
@@ -36,6 +81,57 @@ atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
     r.i = __sync_val_compare_and_swap_16(ptr_align, c.i, n.i);
     return r.s;
 }
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_xchg(Int128 *ptr, Int128 new)
+{
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias o, n;
+
+    n.s = new;
+    o.s = *ptr_align;
+    while (1) {
+        __int128 c = __sync_val_compare_and_swap_16(ptr_align, o.i, n.i);
+        if (c == o.i) {
+            return o.s;
+        }
+        o.i = c;
+    }
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_and(Int128 *ptr, Int128 val)
+{
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias o, v;
+
+    v.s = val;
+    o.s = *ptr_align;
+    while (1) {
+        __int128 c = __sync_val_compare_and_swap_16(ptr_align, o.i, o.i & v.i);
+        if (c == o.i) {
+            return o.s;
+        }
+        o.i = c;
+    }
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_or(Int128 *ptr, Int128 val)
+{
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias o, v;
+
+    v.s = val;
+    o.s = *ptr_align;
+    while (1) {
+        __int128 c = __sync_val_compare_and_swap_16(ptr_align, o.i, o.i | v.i);
+        if (c == o.i) {
+            return o.s;
+        }
+        o.i = c;
+    }
+}
 # define HAVE_CMPXCHG128 1
 #else
 /* Fallback definition that must be optimized away, or error.  */
-- 
2.43.0


