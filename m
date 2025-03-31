Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB14C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL9j-00053X-H2; Mon, 31 Mar 2025 15:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL9I-0004Lf-LY
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL9F-0003i5-EV
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso31131065e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450615; x=1744055415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzKtyLe3+l5VVhvYpqfNmFw5xAG2MCpsoE8LLZO9QKE=;
 b=yjIDMHzccJp170X5Y/wgAszCTKGn+U9Iclr7lMbhWDYm/bXqS9UJtJZL1L6D3nsBWB
 oT5xXW9ebTrD90B66cfKstsiWai+gUEBbFXSvnSxWvNf8T2s7iOfzPBZ9HX1BG/hWKKC
 SAZ2va2n7yUmYpF+t3lmfnKLW5XAGlCpD1ZX81yrsyIEXChKgMMh/a+dxe9sic7QYYov
 GN6pGEPXhF9jnHuKmSIgrYmokYBkNOBvz55Ih9QuGJ3uDkbi0le6QPVa2KsUSXs7nEGU
 sg/RcFYgFsEqccMVWIJI42YN/Kwu7r0hj8woMa2G+8reUWAQYEySuazERxlU9eJv+7en
 LeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450615; x=1744055415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzKtyLe3+l5VVhvYpqfNmFw5xAG2MCpsoE8LLZO9QKE=;
 b=BZyP9RlCfJJQ8B4SlteXM7z5S7Km7kaLpY+0BpzG8f+dI5PCGs85bQaxGwcIZ+HIgc
 Q1ffkOCqdRv+/Y7J7N2ax5Jjmw1MdjlMnnmc16Yn9cr/laCunBEwFOzmvFNsXNWs2GgL
 2aNSPN83HGrO4D9CstRwxgAL8CvMLHxuUab7H94fHTbdQwseRV2Bl/Evya6ACXerf+1x
 Ovj3Q7AAJM3TCF2QzQ1Sa3TYeYa15ybUHbYwlu49cdc6RCNaa8rsI75nkKkSksrFVm2L
 KjRg5F59lOCsrmMyoxIP1P9pfxgCQn0LQUrqQvuEZpOGNM+QKTHFnPZNnDxlhTQ08u/V
 vdEg==
X-Gm-Message-State: AOJu0YzgrJt/I5LvJDfcwSu3UTTH/Zz909MtkamoRYBF+e7PFLUyo74W
 xY3Zjd07VMLXF5iBuHSQBI+S3lUbzssLiCYWnZXrtGoqNXMCs821BA2sKgr+jS/WKFizqx7lDko
 v
X-Gm-Gg: ASbGnctfORb9Fj3QJBm+fsVbG+53qdcc3v78TS6LL9hv9LfJCFBw0n1yVfq1+2hwDl9
 aATaBfknYMcNByokLWXuLUQAIu/Y+ziC2RdVT2CTOFhFnPbZYdfDdsn/quyOE0zOxHxyi1Ah2am
 6u5QBusGhGgckpysMyby/BY3hLQ0WF7a1vGO1ZKUk3SzHmLsDMhRDiVADUPtrmiAIyRu7D/zF6y
 drLUU/rqGWz1c6F9zUJqFduAsA+KVQEi+vFGnEIzXQKN42rUZKVjWmh6UULvmp64G6VMT5hIQfi
 d9NvBxTbwFX+IFqecrx/CMWLqj1bJ5bN9e9RrXRM0lv9zIBRbDLJfD/ZkG7+Nk92IDyALjsJw0L
 yPCn5DJaom/9lG3HI+Dw=
X-Google-Smtp-Source: AGHT+IFtdHoV4k9HS1QMvyY8QkctSHR13+vxKOKZHKPvSgFoUwD9DzGtAX1nbbgpr26XdcVOZ2RKvQ==
X-Received: by 2002:a05:600c:83cc:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-43db62bc26fmr79716895e9.20.1743450615415; 
 Mon, 31 Mar 2025 12:50:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6656a0sm12170928f8f.37.2025.03.31.12.50.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:50:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 22/23] target/mips: Require even maskbits in update_pagemask
Date: Mon, 31 Mar 2025 21:48:20 +0200
Message-ID: <20250331194822.77309-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The number of bits set in PageMask must be even.

Fixes: d40b55bc1b86 ("target/mips: Fix PageMask with variable page size")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250328175526.368121-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: qemu-stable@nongnu.org
---
 target/mips/tcg/system/cp0_helper.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 8c2114c58a6..5db8166d452 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -866,24 +866,17 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
 
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
 {
-    uint32_t mask;
-    int maskbits;
-
     /* Don't care MASKX as we don't support 1KB page */
-    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
-    maskbits = cto32(mask);
+    uint32_t mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    int maskbits = cto32(mask);
 
-    /* Ensure no more set bit after first zero */
-    if ((mask >> maskbits) != 0) {
-        goto invalid;
+    /* Ensure no more set bit after first zero, and maskbits even. */
+    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
+        env->CP0_PageMask = mask << CP0PM_MASK;
+    } else {
+        /* When invalid, set to default target page size. */
+        env->CP0_PageMask = 0;
     }
-    env->CP0_PageMask = mask << CP0PM_MASK;
-
-    return;
-
-invalid:
-    /* When invalid, set to default target page size. */
-    env->CP0_PageMask = 0;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
-- 
2.47.1


