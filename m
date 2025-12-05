Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17822D3398C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXj-0004AK-Db; Fri, 05 Dec 2025 11:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXh-0004A0-3p
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:25 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXf-0001a9-HL
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:24 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-88267973e5cso12514756d6.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951622; x=1765556422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxTx6y/mG1lezUhEJHbhJmruSwFmmn0DwrC8QzGpVjk=;
 b=RWG4xY6oDkOV4+i6kHa18dB4bFJg0njzs0jxTCdMiUfpN7iL1Qz/zCz5k7DwV64Zhv
 kbOh+Eu4q+Dh7rkZgwf7hfBWOVgOzbbR9QJdm1wH56LNgKsi+7szFYYA6h8WBHkFX/rH
 idHo0Zp6W35cUOFu4QP2phVm7k5nBgopBn3KDpCtXWy50fuE/DKyoretTRHKSmFMlUSH
 gyHlycng2SttKrfEn0iJvb+LgmHhR15evy+9uNHKBhuST2UrZUI49hGE20rsVSbLKBDx
 3t6IGVcntPbeLtrhgKmqcD8Re1cmCEOelRno+JffSJoSrHfdmfI+VzgMkR7vf4ge9+7K
 k/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951622; x=1765556422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxTx6y/mG1lezUhEJHbhJmruSwFmmn0DwrC8QzGpVjk=;
 b=SbIiULwOPJyjsoyb1+ybx3ndVy04k1zNcuk1gPIin7/dh8yG2IuDy4yWdDzJ95BTRE
 KEdIQcW8CiWfTpOGkixnD2FfDNrVl/RnAuwgE1snvnSNNak9TDBb2PVNqo8Ykv10L55n
 Qj7EkjB+TlwPcvFyj/V0TbZhxxmmVScWwh7VREqvXIeOycvfuTLj3XJeljb0l/cXJCMQ
 DO/VjulhSK6aiROHwVcdsMTAcCNhYNUkJauTRpwHqd06K5T7NAedzTwUNB9+umnMiYq0
 wEwhjpz1HC8YdRfaw14WD2L1XkRhUeJBjigJt0Gk5Cn/929vDsAi3pRFE9XQU04y+6J8
 Ovcg==
X-Gm-Message-State: AOJu0YxB+isuHwxctGjUK6YQIBJ+Onk/e5gRhJZ9pO50WtxoKfMcpgUA
 vEAHl7twY+c7C2ONo7lhGSx/j7o1E8JRZ9CEw4g3ab5M8PGewr5zCz8xeV3tFUz3xT/Fy9D4X9t
 3N3SSvQo=
X-Gm-Gg: ASbGncsR9DxNvidhOEolbo9NN3BI/6HnUtZEXMHZrtc6PL6bzbb8lnEHaHl2VOLw+LN
 euNhFSn3Ku71d54bPydT8kSa5YJcEjg8iXPUd6tj1Z5fbGHXbdq5fC+ZFXxrb38tzZ5EWOM38j1
 UuDKnSqXS9umoyLlcJypaz3QvjcDMRGNYeda2NOnQ/bNsypsIBAGGYmTv+3VSKN/PIPzHk56nnk
 8lp29FQLAIqpRzQzpDlHbEb5q5Kr8rFRzhcyXKhfaN3GEqhwPLgee0/7F14qwYb142YvIKs5thr
 JJXEVw/q0bhrzV4vJbufmrY8x1S9gUBwdX7peEZ+RJd9tv1b7g8l+NoMQ27z+RH8p2k/cavckWv
 SoK69Ee4TAId9/3/k5Yqig3qqk/R3Mvvz8TwMVVcScNPeOhSgVxsMrr11Zxyf2GmjWflwaSThIJ
 oIIW4u+FrYhoI2eX3Qqu0SVKC9xQMSsS9XIsDkmkMd3ACaPyXNMHcbPl928Y8OnG1BHwX3GZzMA
 YvNlw==
X-Google-Smtp-Source: AGHT+IGgVrjcQXp4Z7KD1gH3r4lzIBgEJbmkk46fM4b2PrPLMnXoovFFBpcrk7egCBSL4DH7EBJ0NQ==
X-Received: by 2002:a05:6214:3d0c:b0:880:621e:3b4a with SMTP id
 6a1803df08f44-8882481d4edmr98073136d6.11.1764951621612; 
 Fri, 05 Dec 2025 08:20:21 -0800 (PST)
Received: from stoup.. ([172.56.17.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88830bfc22dsm21591636d6.43.2025.12.05.08.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:20:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/6] include/generic/host: Fix atomic128-cas.h.inc for Int128
 structure
Date: Fri,  5 Dec 2025 10:20:06 -0600
Message-ID: <20251205162007.26405-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205162007.26405-1-richard.henderson@linaro.org>
References: <20251205162007.26405-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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

Use the Int128Alias structure more when we need to convert
between Int128 and __int128_t, when Int128 is a struct.

Fixes the build on aarch64 host with TCI, which forces
the use of the struct.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/atomic128-cas.h.inc | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/host/include/generic/host/atomic128-cas.h.inc b/host/include/generic/host/atomic128-cas.h.inc
index 990162c56f..8bf5f47768 100644
--- a/host/include/generic/host/atomic128-cas.h.inc
+++ b/host/include/generic/host/atomic128-cas.h.inc
@@ -34,39 +34,45 @@ static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_xchg(Int128 *ptr, Int128 new)
 {
     __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
-    Int128 old = *ptr_align;
+    Int128Alias o, n;
 
-    while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
+    n.s = new;
+    o.i = *ptr_align;
+    while (!__atomic_compare_exchange_n(ptr_align, &o.i, n.i, true,
                                         __ATOMIC_SEQ_CST, 0)) {
         continue;
     }
-    return old;
+    return o.s;
 }
 
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_fetch_and(Int128 *ptr, Int128 val)
 {
     __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
-    Int128 old = *ptr_align;
+    Int128Alias o, v;
 
-    while (!__atomic_compare_exchange_n(ptr_align, &old, old & val, true,
+    v.s = val;
+    o.i = *ptr_align;
+    while (!__atomic_compare_exchange_n(ptr_align, &o.i, o.i & v.i, true,
                                         __ATOMIC_SEQ_CST, 0)) {
         continue;
     }
-    return old;
+    return o.s;
 }
 
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_fetch_or(Int128 *ptr, Int128 val)
 {
     __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
-    Int128 old = *ptr_align;
+    Int128Alias o, v;
 
-    while (!__atomic_compare_exchange_n(ptr_align, &old, old | val, true,
+    v.s = val;
+    o.i = *ptr_align;
+    while (!__atomic_compare_exchange_n(ptr_align, &o.i, o.i | v.i, true,
                                         __ATOMIC_SEQ_CST, 0)) {
         continue;
     }
-    return old;
+    return o.s;
 }
 # define HAVE_CMPXCHG128 1
 #elif defined(CONFIG_CMPXCHG128)
-- 
2.43.0


