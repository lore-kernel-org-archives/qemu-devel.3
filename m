Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C3BD26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFUs-0001bR-0c; Fri, 09 Jan 2026 11:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFUq-0001b1-54
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:37:56 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFUo-0005Da-L6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:37:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so25148725e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767976673; x=1768581473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXc5hcdRDOQRVV1w0BOluuYdMWqS1m8Oxjrrz11uXg4=;
 b=hUbMxIJdLb7STiGDhwRpUKrVowRULfEtxNqhWe3+CIv1I7CChObp/qaAU0ln+G1GBW
 pBGW4Nm63EvYRZvagsbCpWtJ0tynv3/othdIsfpoV1cMU1kuaFz1mAy2zOARmu2l1zma
 9VAQUib7jXwEoaZkE1CVqI8v1pjhKceqAZzvNLJBktq2p614KlmGGlta/oA1S0p+Hdi3
 EBArVHFxNm/PO4PJsTDiu8slo1BZHWfJxpzjvD00APKMbZkI1WofyZZyNxbkVTcn6ozh
 XflC4ti0Adr6wdBuxsZ26uBHZUzDsnoveAf3c8jq8sWaNXQXQrzFC5Ztmh0o9j/Gcgu0
 irPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767976673; x=1768581473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dXc5hcdRDOQRVV1w0BOluuYdMWqS1m8Oxjrrz11uXg4=;
 b=gYeRbjoy4m4KYxDBScd1VOPJa5W74WcdntbTsmhDrKCbcgam0P6gzOYY16iXqnJQlW
 UL3iAJB++Ki0QdOGbPjPeZ7yI/4H6s5pqtquUdg+zfKLBo816V4kacYMx5npgLRjIktg
 PCt6lnlOn62jlE7z0b5t8f8QLo/2PUVAE31KEq5mLYOI70kA3hidz8cCoDzN+hT/3XZ2
 80x01NstSElddhRoX+bxJFb5JjkXDTv2pnpsd4GsPe1XiRH4xLMIme+mRTxtMt5Ri5WN
 Mwl47mIoXpTZ5JvVC1MN3HxIZOebh5PDSwGCnistHhlWAviKlMzj1mEyE4Rbz+EaT0J7
 gkPg==
X-Gm-Message-State: AOJu0Yy5iPiwh+dPwyIg8ZPqzjW2PEL8ENHcOQcoK3cRyofHd5H5CGBp
 48UC2LGGRQEpNTbd7dcbwyGH8uELqp6qQbzgAMnEqEyMECiO6J+uVVC8lrmvuGq96J4dk/aexkb
 IeVBAm8U=
X-Gm-Gg: AY/fxX7tDtmM5J4OuAnUnk62aqIB0YW373nlyJY79WhopwNiLbtkzA0sP3cdwinMB8Q
 otxAtpLhct+B2w1/g5bf5fmlb0KrMSUGI5TUITtHJimnO8aJGYVvA/jOae5TMkg/UN+6Vxmbrld
 2CHpVZPN+kdo9W32jiTKCZHR3ic2soz3qvD9+9OIoWpjGHyDoqaG48aUJuBwo/9GHMvMBMTZqPG
 tckYW5DhbQpMiFgDJpcFMKvwqy2G0JcUaAwcVw+Jp+bK+r9csYUXAYe/Gp8qiVKx1CmB4suWYEC
 p2QbfVl/3Dzdz/ygGBsDMXLTaUWhzdAhhBCugSQV+ytUjP6nuUR+VAHTbI2H0956jxGIBLYvwYK
 e7mZg6KNnOwimKQqIsKubeI+Biku/JDLFTv6iya5sHMNxqD/pPz+fUt/dVaw+mVt5IK9tNX/45j
 g5EKWz0GgTUaPoS8BLysbrbGBbfjYDUVHucMdpoELTNb6np87A6i+5Zzmvygqp
X-Google-Smtp-Source: AGHT+IFagfr1y0cejcWJgHm1lLPZkWY2+xDWhq8/pDcwb/yIwXzm8laCY8/5L2XR7VsTi9mclp5J8Q==
X-Received: by 2002:a05:600c:6385:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d84b1a166mr125626785e9.12.1767976672747; 
 Fri, 09 Jan 2026 08:37:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm210899935e9.8.2026.01.09.08.37.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:37:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] bswap: Consistently use builtin bswap() functions
Date: Fri,  9 Jan 2026 17:37:30 +0100
Message-ID: <20260109163730.57087-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109163730.57087-1-philmd@linaro.org>
References: <20260109163730.57087-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Since these headers use some __builtin_bswap*(), use it
consistently in all the cases, allowing to remove the
"qemu/bswap.h" inclusion (which only defines bswap* to
the builtin equivalent).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/host-utils.h | 7 +++----
 include/qemu/int128.h     | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index dd558589cb5..181d026b6c7 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -30,7 +30,6 @@
 #ifndef HOST_UTILS_H
 #define HOST_UTILS_H
 
-#include "qemu/bswap.h"
 #include "qemu/int128.h"
 
 #ifdef CONFIG_INT128
@@ -380,7 +379,7 @@ static inline uint16_t revbit16(uint16_t x)
     return __builtin_bitreverse16(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap16(x);
+    x = __builtin_bswap16(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0) >> 4)
       | ((x & 0x0f0f) << 4);
@@ -403,7 +402,7 @@ static inline uint32_t revbit32(uint32_t x)
     return __builtin_bitreverse32(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap32(x);
+    x = __builtin_bswap32(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0f0f0u) >> 4)
       | ((x & 0x0f0f0f0fu) << 4);
@@ -426,7 +425,7 @@ static inline uint64_t revbit64(uint64_t x)
     return __builtin_bitreverse64(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap64(x);
+    x = __builtin_bswap64(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0f0f0f0f0f0f0ull) >> 4)
       | ((x & 0x0f0f0f0f0f0f0f0full) << 4);
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 174bd7dafb8..7b3b071c512 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -1,8 +1,6 @@
 #ifndef INT128_H
 #define INT128_H
 
-#include "qemu/bswap.h"
-
 /*
  * With TCI, we need to use libffi for interfacing with TCG helpers.
  * But libffi does not support __int128_t, and therefore cannot pass
@@ -189,7 +187,8 @@ static inline Int128 bswap128(Int128 a)
 #if __has_builtin(__builtin_bswap128)
     return __builtin_bswap128(a);
 #else
-    return int128_make128(bswap64(int128_gethi(a)), bswap64(int128_getlo(a)));
+    return int128_make128(__builtin_bswap64(int128_gethi(a)),
+                          __builtin_bswap64(int128_getlo(a)));
 #endif
 }
 
@@ -451,7 +450,7 @@ static inline void int128_subfrom(Int128 *a, Int128 b)
 
 static inline Int128 bswap128(Int128 a)
 {
-    return int128_make128(bswap64(a.hi), bswap64(a.lo));
+    return int128_make128(__builtin_bswap64(a.hi), __builtin_bswap64(a.lo));
 }
 
 static inline int clz128(Int128 a)
-- 
2.52.0


