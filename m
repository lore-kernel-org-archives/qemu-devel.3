Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A451ACEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJK-0001O4-Us; Wed, 09 Oct 2024 11:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJI-0001NU-TZ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJH-0007xY-EC
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e03be0d92so2584089b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486546; x=1729091346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hD+DjoYV5P1tXKFKBbM2Tkd9vX+VPhej9oLFeKYabEE=;
 b=HTSBOaUGyTm7IBmfGXolzCLS/6vHWFJfF5h9NvwUMifvLZfqne0fVqzGI0vr8IrK0V
 GIB3Hapmw/DQxmpSPUpneO0kbAvqlf0vqOUOeSqoUUumucywIfaskjZyOyEKma+qxsHt
 G7yH4oZjoj4fQ9v5W4mwBY8JqSpSf0LfzGyHdc4s17sw8Trt7Ehgy0LdYvZjOOf1gRiC
 MSrqCKAUoT4Ro7izlBrGjsvzTUInp134EIdRwjZIesFtqj8ZtXjSzYueHLrOcLoyGWOT
 c6FoGCDfQ5+VEWdNxyGx+nllV1h3swy3KcEi9DKLZw6D2epUZQmosGCKrRtXIQeGLez3
 qCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486546; x=1729091346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD+DjoYV5P1tXKFKBbM2Tkd9vX+VPhej9oLFeKYabEE=;
 b=sbqbQ/SFdDDyWLHaA2RU2aBOq7G2TyDaC7qbz3YFhtYlA2oSiCOEmAvwxCAK3GFhvS
 0anwEV+sjYF6isZmbbV8L7D11EnkVvDzd++55oL9V92yBtxHz2q1CwaYYZAnY7mVrgoo
 vWGTGyvCrI6VWvCJAwISZOnGJhPeodB3Eo3zvB0WKOzUNlbVQd1iTXNiYSBy0uGPS/Qs
 ZlyvIN4HbuaKBpCwjOqfD9C2y/JZkDCs9uTLZQX8k4fjo2mmfUVZsmalVsSw9rOYRbbq
 M7R8qEWKpKTR2d9n29/SWIroOLE7KZxuqnwQQX8zkuR82W9nUEc5qDg40w6xrNbu/DwF
 1bwg==
X-Gm-Message-State: AOJu0Yw1c35cqT920rOipANT4kjTRFqmly70Jz5lgLZj7XHhGrLtsZDA
 gbJ0EZjj5lBgOSKQRBMCpgzIu912UABfHAZlLEzT1q63HmmiagzarxOJhv9ZPleJtRhFwDCScqH
 b
X-Google-Smtp-Source: AGHT+IGznn5NFu1ov12QDaHBn/DbuHMcFgfmMTEVF8QFJ6IJRdxF2j4BRodhlAtGYWds07VmD6IQfQ==
X-Received: by 2002:a05:6a00:990:b0:714:2198:26b9 with SMTP id
 d2e1a72fcca58-71e1db854b6mr4514431b3a.13.1728486545937; 
 Wed, 09 Oct 2024 08:09:05 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/23] accel/tcg: Remove IntervalTree entry in
 tlb_flush_page_locked
Date: Wed,  9 Oct 2024 08:08:42 -0700
Message-ID: <20241009150855.804605-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Flush a page from the IntervalTree cache.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d964e1b2e8..772656c7f8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -573,6 +573,7 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
     CPUTLBDesc *desc = &cpu->neg.tlb.d[midx];
     vaddr lp_addr = desc->large_page_addr;
     vaddr lp_mask = desc->large_page_mask;
+    CPUTLBEntryTree *node;
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
@@ -580,10 +581,17 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
                   VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-    } else {
-        tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
-                                   page, TARGET_PAGE_SIZE, -1);
-        tlb_flush_vtlb_page_locked(cpu, midx, page);
+        return;
+    }
+
+    tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
+                               page, TARGET_PAGE_SIZE, -1);
+    tlb_flush_vtlb_page_locked(cpu, midx, page);
+
+    node = tlbtree_lookup_addr(desc, page);
+    if (node) {
+        interval_tree_remove(&node->itree, &desc->iroot);
+        g_free(node);
     }
 }
 
-- 
2.43.0


