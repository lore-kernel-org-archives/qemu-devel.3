Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92516D12D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpVY-0004ES-10; Wed, 03 Dec 2025 11:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVV-0004Az-Mc
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:09 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVU-0006Z4-3K
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:09 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6592f1f55a8so1549445eaf.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764778507; x=1765383307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umT5Z14AhC/R+eDB/nFLqwC+LDiOvYbjL0xjqvp99eo=;
 b=eJW5/pw/Lc0pCbK5PL7T9sivS+l99TfMdAWconEOT+xXNvR9Hm5haLYrKB1R+GYeaX
 BdyZYpxFKDNh/7EP3W9HDq6FR0s7C8S3LmqQASBrITNiGTjOz6JI5tGuijHcjoTiGPxd
 qBWNkR4z7jkPAlHix7yRsHmE/IyINNc8DvIHr7s+lKDobjoJ+q//lfz/rM4GhvkLKrDy
 k7U2OWY3Cu/xOEY8tQMJPZ25IY/L8zlWQ3pb3DYXWesjc+oVjS/oF63oQXVVkBgxFhXL
 w+2uy3gS5mjw8AeOfkXxfbwidBCWgQKeabRxJAKoraAt4bsK3zzfRTEkoUuyhRa8GBke
 sTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778507; x=1765383307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=umT5Z14AhC/R+eDB/nFLqwC+LDiOvYbjL0xjqvp99eo=;
 b=lxGDJFYX/L2ARnaHlHqivChtV0oasLAcfc8xdSpb1/fOKi6LZujOJoAPL2lFOI11WR
 4gZ7X+QgiETocQ+edS8xzxnHtHustGXhmnp15heEuQxdYYNlCHk7jzDqVGXXtFq6BMIe
 8M+K9642sg4+z+4jkAtc4Yr3wIUThwT8mob7yrmM/9IgctbdDY3n51HbIjcuzat3XLHl
 UE/7x1mz/lVq46rYQrzEYvNoDzlvCh2Fm4VPtX/cr4QTRXrmwMsRwnMyyxw+7SZl/gbl
 VLUgRFLrV7xy5JNTMh5k+u43CFDGTW3R0kfC2IFAqBJGDkT7nL+/7L/j4TM9rFa49gnV
 /5QQ==
X-Gm-Message-State: AOJu0YzvL16VnkUKA5bPC2SIw3cVskbb1LVuAL9w9/4oJcGSlrzNwdMi
 RKHJSoKD0nD2nJRkxlJ9i9b4kswKQlUepV4QbdNgKhW58ZVrV0FR+xoArSSvcs+TPlGGZlSprXF
 zaOgq9sM=
X-Gm-Gg: ASbGncsuMUFq3IyPizt5qe45Y/e3i9UoI2W1V6+cyPOYV9GYTF3BENdWQA+gL4jkG4w
 m4hvgQZSq8ZPkfm5Gbz6Lwm33rgRvlcoua9RUppGncgFTW9fXYoN8hZ1hgAanrwuQgkURMOxCZH
 R6+fFavqfhRLIVAVDBrsjUI1VIiKUJl6e31lT0svGu0uyfgt45jYraf7L+dFMcWwLWU9olBJOFI
 Hs6rXFgKDUXLPX59qOxiuPlbMixZ76sZTL6zCQ0QUkl0GVn8aMb30/mTeFaRomWLl6KMFl/s+Aw
 NK+fX+WMbsRX5qM68izNxru2X6f5EposBYJbjpV4ciLbGQTst/tp54190bIDIVgd3CHSZxnievC
 Ew391OlUK48DNoDeDxTxX4Ht2WGUomN53iug8eaNAekdsyq6lV0ucIxMb589+DShcHNxHrc1m/A
 zmq5FvFIkMwDHAGy6Cmg==
X-Google-Smtp-Source: AGHT+IH3a4q63OEu0NQL+DmhoqYlJ6AdSKiTKm5+J38YvoEwFDinabdhoRmw0eA1VUlfEJVGrMjj1g==
X-Received: by 2002:a05:6808:3099:b0:442:e596:1189 with SMTP id
 5614622812f47-4536e56ead8mr1342129b6e.45.1764778506732; 
 Wed, 03 Dec 2025 08:15:06 -0800 (PST)
Received: from stoup.. ([187.210.107.189]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca40d4dsm10141625fac.9.2025.12.03.08.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:15:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v3 5/6] include/generic/host: Fix atomic128-cas.h.inc for
 Int128 structure
Date: Wed,  3 Dec 2025 08:14:58 -0800
Message-ID: <20251203161500.501084-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203161500.501084-1-richard.henderson@linaro.org>
References: <20251203161500.501084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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


