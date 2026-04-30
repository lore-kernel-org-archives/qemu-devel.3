Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07923FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEwL-0001Hh-1V; Wed, 29 Apr 2026 20:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvj-0008Ot-UP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:07:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvg-00020T-Vq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82f1f6103afso165109b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507616; x=1778112416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ+2mrZj2pb/FuoZHFmN0VWVvULjnuLwIvCT2CXO/do=;
 b=NohtZ3QVqvMCjVMiZNbw2CfFfrQv/l9+zbOY8fONak6atC7dpAImr8DvSIZCBjxALT
 VyS/Em7qb4kte7ctC2BOgzxOqCR5biKrZOokTLyjaOGoPALvBk6o+5Y3uFB0iEX2c7Z4
 9E9CW9mUUmnrMz0C9y4K/GPf4VBoovXY/yoboSAQdqmy4TT7Vps+j5F9nG4yFw/xA0N+
 xC8jF26YUAmZm04F1N/BPApzSgYz/bFlY8IZdSW66LZjt/pkElDtpAYdd8kRxTsly6Xg
 MVmY8o2WW6T4dQgpuoaRde4un73JdnqaF2F8uA1Xw6JvtG/MQeI1gglSPrfg+G/1jqs1
 ev4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507616; x=1778112416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJ+2mrZj2pb/FuoZHFmN0VWVvULjnuLwIvCT2CXO/do=;
 b=LQEMKVEnvd77/WHaWGyywMG8RwQnFsUg2iC2qQH8zZAWl4ClNX7E8e5NeV2jAexgYO
 oTkg8VFQRGFAXZ2xgxeI5tICBSuSyfBaSN0yS9q6ltnnysD7EY0rsRSH+urCOyiRBEwR
 eaHOHcgLQDsnxeXmwKxjPbTPo0SDLarkGMtr1g5GOWP6e2KNaS+nFMom39dyYZFnL3Xl
 Xaccejtcapfnn2SalfCxBsyzI4qOzNZsD9MIrMrSRXhIzmxMLNcf5Z3A9v7X49ZrizST
 ODqkMFXJt6PlAwWwaD9H41tLLmvZBJ37VrYxgCiOI5FWha1R3VgDoJJTLRWaoxmBAYnc
 4rgw==
X-Gm-Message-State: AOJu0Yz40cp72x9A3P72AE73GwOMi0U7BI/to9wJbHESCy5mxazDEZrT
 B+pH8OKYH9Xm4LFXnAhxlVf4/Sv4yfFwMUk3JaMverIeYZwAFdB17HN9l5+0/qtlrRaY0+/h+N5
 qQamIZ+E=
X-Gm-Gg: AeBDievJghXq2ViNhVk54RIGIxUPCL6CWlMUIUU8CHbjPbJLV5a74ZvPnKGbmEOEWpp
 /W+JgJ6baDs0QwIvUSX9TqoZdeumt2LdmFZV+fU/FBCmQ/alnPyciPURSBKLTcEok6tAgiQHlRC
 jXfJJxK3zniXvBi8XaLbCg5PAxuKqfYfgQfGDMdnnGjGiH0eHowVxHNSpl+rAOGDqGEMIRsBc5S
 +TFxEbVt7tVXZ7lN3hULw5sD6eV3uhMkY376K/zt1If8DXQ8rjf1dpcf/162jj7l5wT+FBCkRfa
 psUzmS7/+kFmFMq/9xYTA/zLs8WUeKT+IImAslY8qrwHtW3xIsMV7K1C6khwQ5+7tUnSEvVlGR6
 h/rNY3QUHgfuYVWWWrGcPkAIPHCGYuObThnde/9ICa/sms/X8H2LDXv/LP5h6X/pfGO7IBm+82M
 iL7Povep7blA0+Wr3VgDeuN8gmTh0F//D2fiMvr6ZU
X-Received: by 2002:a05:6a00:4fcc:b0:82c:db50:ef77 with SMTP id
 d2e1a72fcca58-834fdca283cmr754958b3a.49.1777507615540; 
 Wed, 29 Apr 2026 17:06:55 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 38/40] host-utils: Introduce signed saturation primitives
Date: Thu, 30 Apr 2026 10:05:21 +1000
Message-ID: <20260430000524.56046-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/host-utils.h    | 60 ++++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime-gvec.c | 20 +++---------
 2 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 181d026b6c..2e8da7fb3d 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -606,6 +606,66 @@ static inline bool umul64_overflow(uint64_t x, uint64_t y, uint64_t *ret)
     return __builtin_mul_overflow(x, y, ret);
 }
 
+/**
+ * sadd32_saturate - addition with saturation
+ * @x, @y: addends
+ *
+ * Computes @x + @y, and saturates rathern than truncating the result.
+ */
+static inline int32_t sadd32_saturate(int32_t x, int32_t y)
+{
+    int32_t ret;
+    if (sadd32_overflow(x, y, &ret)) {
+        ret = y < 0 ? INT32_MIN : INT32_MAX;
+    }
+    return ret;
+}
+
+/**
+ * sadd64_saturate - addition with saturation
+ * @x, @y: addends
+ *
+ * Computes @x + @y, and saturates rathern than truncating the result.
+ */
+static inline int64_t sadd64_saturate(int64_t x, int64_t y)
+{
+    int64_t ret;
+    if (sadd64_overflow(x, y, &ret)) {
+        ret = y < 0 ? INT64_MIN : INT64_MAX;
+    }
+    return ret;
+}
+
+/**
+ * ssub32_saturate - subtraction with saturation
+ * @x, @y: addends
+ *
+ * Computes @x + @y, and saturates rathern than truncating the result.
+ */
+static inline bool ssub32_saturate(int32_t x, int32_t y)
+{
+    int32_t ret;
+    if (ssub32_overflow(x, y, &ret)) {
+        ret = x < 0 ? INT32_MAX : INT32_MIN;
+    }
+    return ret;
+}
+
+/**
+ * ssub64_saturate - subtraction with saturation
+ * @x, @y: addends
+ *
+ * Computes @x + @y, and saturates rathern than truncating the result.
+ */
+static inline bool ssub64_saturate(int64_t x, int64_t y)
+{
+    int64_t ret;
+    if (ssub64_overflow(x, y, &ret)) {
+        ret = x < 0 ? INT64_MAX : INT64_MIN;
+    }
+    return ret;
+}
+
 /*
  * Unsigned 128x64 multiplication.
  * Returns true if the result got truncated to 128 bits.
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index ff927c5dd8..67a741e45e 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -1109,10 +1109,7 @@ void HELPER(gvec_ssadd32)(void *d, void *a, void *b, uint32_t desc)
     for (i = 0; i < oprsz; i += sizeof(int32_t)) {
         int32_t ai = *(int32_t *)(a + i);
         int32_t bi = *(int32_t *)(b + i);
-        int32_t di;
-        if (sadd32_overflow(ai, bi, &di)) {
-            di = (di < 0 ? INT32_MAX : INT32_MIN);
-        }
+        int32_t di = sadd32_saturate(ai, bi);
         *(int32_t *)(d + i) = di;
     }
     clear_high(d, oprsz, desc);
@@ -1126,10 +1123,7 @@ void HELPER(gvec_ssadd64)(void *d, void *a, void *b, uint32_t desc)
     for (i = 0; i < oprsz; i += sizeof(int64_t)) {
         int64_t ai = *(int64_t *)(a + i);
         int64_t bi = *(int64_t *)(b + i);
-        int64_t di;
-        if (sadd64_overflow(ai, bi, &di)) {
-            di = (di < 0 ? INT64_MAX : INT64_MIN);
-        }
+        int64_t di = sadd64_saturate(ai, bi);
         *(int64_t *)(d + i) = di;
     }
     clear_high(d, oprsz, desc);
@@ -1177,10 +1171,7 @@ void HELPER(gvec_sssub32)(void *d, void *a, void *b, uint32_t desc)
     for (i = 0; i < oprsz; i += sizeof(int32_t)) {
         int32_t ai = *(int32_t *)(a + i);
         int32_t bi = *(int32_t *)(b + i);
-        int32_t di;
-        if (ssub32_overflow(ai, bi, &di)) {
-            di = (di < 0 ? INT32_MAX : INT32_MIN);
-        }
+        int32_t di = ssub32_saturate(ai, bi);
         *(int32_t *)(d + i) = di;
     }
     clear_high(d, oprsz, desc);
@@ -1194,10 +1185,7 @@ void HELPER(gvec_sssub64)(void *d, void *a, void *b, uint32_t desc)
     for (i = 0; i < oprsz; i += sizeof(int64_t)) {
         int64_t ai = *(int64_t *)(a + i);
         int64_t bi = *(int64_t *)(b + i);
-        int64_t di;
-        if (ssub64_overflow(ai, bi, &di)) {
-            di = (di < 0 ? INT64_MAX : INT64_MIN);
-        }
+        int64_t di = ssub64_saturate(ai, bi);
         *(int64_t *)(d + i) = di;
     }
     clear_high(d, oprsz, desc);
-- 
2.43.0


