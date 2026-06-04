Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58471CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoN-0006wA-7D; Thu, 04 Jun 2026 19:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoG-0006pQ-IJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoD-0007y1-SE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c0b944f6edso13619445ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616948; x=1781221748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyZd4Axcmi17hT9uRHYw5WxR8cxng914FVY4xY+poHg=;
 b=U+k2ZDT6eS2l/G//mMcUW+he53jk7GbVp32dz+VPXDBBi4X8zpbl3ByyYoUVD29vST
 BF/pJSB46arOvbxIUO+wskDz3lGxgYGtt5StyoGrLPKTjjlA5/HLwknAbWNRzKOKEQ86
 hDu2Z2rO16yKaoHpn5WdXqnRpmgRdMf2JkuSfYgfk+14x4ZCve3izvs9nOUg3giO67Ib
 b4FRiEvAHCBi5Ov3KAgU90HqS2D7p1rVQxEJik0KIu6nkGdRJo6LoJUwVjC/nKigUDmh
 n+SN9Wn5/0g9aGTT4gzVp8UzU8uZkaIUVqI5EJdFJRxG8wODfPF64oact/6BbibBKba4
 EPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616948; x=1781221748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YyZd4Axcmi17hT9uRHYw5WxR8cxng914FVY4xY+poHg=;
 b=TjUtaOq2tM56MvGI0TutO97bjHRBJzyQTH0+40qfG1jwf3Fna+S1WMpMvfts84SQaN
 AHmd5iuzK78bOwcz7o0kStNmOw3dH3UejUpsHwVEWjwZOLewiBEhW6Uur/XNeqll+mdv
 P7x6TbSN2DanYBw4sqcud95QdyC8lJf+JgD/Od4dDrdBqIS6jG4MfiUPzxngBbd5NB4K
 4pEuqgm5l+7JS303VG9eLv7X+aj0bgeYHOpD5hF4INeCECrddKRx8zlFVArgeHcDqR3m
 ZAF48s15yLYSsDuJqPkM4Ojejw6ySY56rkzk2Tf+TWtFnpJz7LL5J2cAKA2sXM7D0jqy
 Wb8g==
X-Gm-Message-State: AOJu0YywYEZCGVoNfAfrMBycNnhPmHSuYbzNGMwfZQNmYvJpGCVNK6Ii
 KgNFP5JSRBtl479pA/tUFy7R0+EeLxUkXVM9v6TBiAw0X22hzHaU0zVHc66JG9ONXvvjTsjfxgv
 7Gs5f+6c=
X-Gm-Gg: Acq92OFkOgE7Z/9TvXH5nj0cSTWfjf8+cCnh3j229YnEaV3mZaZmdCLZOCT1NoohqID
 sF3F5DVlZ68i+KpZY97TSAMT3dnv91v3Ene1l8IbA3NqvZn7ao67411Eh6IvGNeKaFpU1yr6alT
 dcqKoX1KUr6pIgJo7oHrWW8vjKoUHzqeW3N40Ygc+taVuEquWwGW6f4SSorzNEN7yz9oi2aX8bm
 uSyGVwuIbVabVCWwrn9N8amMs9vwL0E89zHMXCyX+dWtYE+W9mCBguwgNpI9ubpbeMNycSeqkWA
 yh/NJFLo1jW9xk/mC7+M+fTo2nIS2GzjOz+JRxzu7KduNgLAH3aJrgQRy/kLKmnxjmn5xc3C7jG
 UGDTJn6uAriBT4beX14LpKj8Mg0FRCy7rAH4nyxuAvzZtQo4YJh350aB4JUdjWrG8VPCNd/4//a
 5OQ8ttH/bC7tFUdEUxKp/FcAvnuAr1xnZFMGp4Bd/P0/e0wWUb+w==
X-Received: by 2002:a17:902:e5ce:b0:2bd:5ab:af95 with SMTP id
 d9443c01a7336-2c1e77d145fmr7615235ad.0.1780616948316; 
 Thu, 04 Jun 2026 16:49:08 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 20/25] target/arm: Generalize sve_compact_[sd]
Date: Thu,  4 Jun 2026 16:48:47 -0700
Message-ID: <20260604234852.573178-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement with a DO_COMPACT macro and general purpose
predicate handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 51 +++++++++++++++----------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a13ccf4b85..40cf567b0d 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3637,39 +3637,30 @@ DO_TRN(sve2_trn_q, Int128, )
 #undef DO_UZP
 #undef DO_TRN
 
-void HELPER(sve_compact_s)(void *vd, void *vn, void *vg, uint32_t desc)
-{
-    intptr_t i, j, opr_sz = simd_oprsz(desc) / 4;
-    uint32_t *d = vd, *n = vn;
-    uint8_t *pg = vg;
-
-    for (i = j = 0; i < opr_sz; i++) {
-        if (pg[H1(i / 2)] & (i & 1 ? 0x10 : 0x01)) {
-            d[H4(j)] = n[H4(i)];
-            j++;
-        }
-    }
-    for (; j < opr_sz; j++) {
-        d[H4(j)] = 0;
-    }
+#define DO_COMPACT(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
+{                                                                     \
+    intptr_t i = 0, j = 0, oprsz = simd_oprsz(desc);                  \
+    do {                                                              \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
+        do {                                                          \
+            if (pg & 1) {                                             \
+                *(TYPE *)(vd + H(j)) = *(TYPE *)(vn + H(i));          \
+                j += sizeof(TYPE);                                    \
+            }                                                         \
+            i += sizeof(TYPE);                                        \
+            pg >>= sizeof(TYPE);                                      \
+        } while (i & 15);                                             \
+    } while (i < oprsz);                                              \
+    for (; j < oprsz; j += sizeof(TYPE)) {                            \
+        *(TYPE *)(vd + H(j)) = 0;                                     \
+    }                                                                 \
 }
 
-void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
-{
-    intptr_t i, j, opr_sz = simd_oprsz(desc) / 8;
-    uint64_t *d = vd, *n = vn;
-    uint8_t *pg = vg;
+DO_COMPACT(sve_compact_s, uint32_t, H1_4)
+DO_COMPACT(sve_compact_d, uint64_t, H1_8)
 
-    for (i = j = 0; i < opr_sz; i++) {
-        if (pg[H1(i)] & 1) {
-            d[j] = n[i];
-            j++;
-        }
-    }
-    for (; j < opr_sz; j++) {
-        d[j] = 0;
-    }
-}
+#undef DO_COMPACT
 
 /* Similar to the ARM LastActiveElement pseudocode function, except the
  * result is multiplied by the element size.  This includes the not found
-- 
2.43.0


