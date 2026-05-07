Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F32ECD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1Ed-0004gB-TY; Thu, 07 May 2026 12:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ec-0004fM-JP
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:58 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EZ-00072k-A5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:58 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dea20cf21aso971029a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169953; x=1778774753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bNnzqtZZ2cVv22AUkUvkDYFz+muAIN/ZlkkhwHbAbo=;
 b=D5AwQ+0z48QUASF3ali/NHBNEkWRxsrE3cgAggfd4fRAQrVshrCc15ZwVH/B02UD2z
 6TT5cM2eDGGU1wHCd9zRM+PBypEX+VR2zQq4OygNhbDtBIqor++51SQnO9LH7WdJFOet
 JToa39E8bqn/2bAsJ2AT4WE+a9VAjHc2YPS7RYKwuhsYpJiaBv3ZtBWLQDYezbfdLyLs
 DLmODF09Qi7wqkufPMo4IzZHIwTgE8cK/a4tYG0qR01NPy5E3pxKMk1C0DUZfwxeRTpb
 sDHijm7TW9S0AKBk4uF+G9gyX7VbO53e7x/N10sLq1xqaM+cMgvLi6mAbPe1aHLovnTo
 NUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169953; x=1778774753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9bNnzqtZZ2cVv22AUkUvkDYFz+muAIN/ZlkkhwHbAbo=;
 b=p4nGNV8Y5ocepDYudqsT1EHbw7uERzxVOaqvHq4tOiEFachDwnhK7wFewQqJ+Q9Nbe
 NHTpirPbQx2mf0aIjV7vzRr5CXoz2wRctg94HUD5qWrOiIxkppb6deuG7tgADpId93CC
 CDAgYJPoYUw0zbvETkuaQgk86PYu6OfysaiUxXtUOHi9otmwFz4H2ro3ETIaNrQrADrH
 pV4M3PVZp5Ji8Sn6yjDunOgC+iH/EZdqR5yU8wpROViwYxo2qQwFNebjzqeagZKKOsFR
 l0CGXuUA2k5Yv4AQ+rfGo0PuXBm3XvnoWpMBiNfxKJdC5XbWIhS96E8Szsj0BkYmUrJP
 kXFQ==
X-Gm-Message-State: AOJu0Yx3oc3/1KbdaAM3PUdUs8Jhv/tam8PAh4HTsxKxi0p2zr9UF7Wx
 xIlPjmH/lcRmtHxs8OeJew5a8SeB7plw/yZa1uYSJv6dcHXforVnqBIS5tOYPzzjek5WyQocqfv
 OJTsh
X-Gm-Gg: AeBDieuHOb+uNCDmG6uWquZ4cfoiqLFP6FuFDk2nYNBskgP0Cg/mHQyd84HH9OqNcwb
 e3etNruBxT3nrZtTPoull9ZzQiT9UEpdZW2TZlT9k+uzbwpDYZRrqb/mm8vWr9kW1b5vQdjd5A3
 GUXEzxUxPc1ELcKi8DYksOoE/YYe+d5QyHVOGM3cZAXy8vLUQQkFaBRxhU6ifbzShR4I8z+y2Oq
 GteanggkyoNGVtlLhvOZeu1mOs20iiiHUhfa4DIohPnWCAh5dy8ev1SieukWNGAr3qYmmM5R+al
 ozP03jKv1J6VIgwWHlAaXwbfaZ/BfDLz0vv0uyZ9VOWF4rAgu8HjmFxAlIraRQN0lriB4tRDmHQ
 ceOY6vw01FBjJ0Z74bp1Eyv3nOeEGsVRTDnQM/jLja3N+4R4XJZ+h0e1pNsN8KfisbpFfIzschO
 9AUW5V1D95AmL+z9tAjra4gw0VsbvMawZux8USXsal7vemmg==
X-Received: by 2002:a05:6830:3696:b0:7d7:fbe5:e9b3 with SMTP id
 46e09a7af769-7e1deec4f0emr5662690a34.3.1778169952806; 
 Thu, 07 May 2026 09:05:52 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/29] host-utils: Introduce signed saturation primitives
Date: Thu,  7 May 2026 11:05:17 -0500
Message-ID: <20260507160518.444797-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


