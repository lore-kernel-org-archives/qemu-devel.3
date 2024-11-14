Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EE5D68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHz-0004xc-8g; Thu, 14 Nov 2024 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHt-0004va-V9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:42 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHs-0002C4-EJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:41 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7eab7622b61so600731a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600099; x=1732204899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BsbKOlO+09+V06ilkiETtavIcLFq0cApuQcSVOlh0Qs=;
 b=AvxE0pzeZrEsfZBXtJlQo7H5U0BUzJZnBTiSj6KhQGv2DLs1wWNxrzAtnbHE9oixJS
 RMKm+8zrDXtqtbsZyzZEDnpO+xtEHU06nrEuTECzkUXTwqoJw3pjr9boCX6468v/X/Qu
 aelmKQ28uDU49QddtuQr80yiGuKAtZ/hL0ZuoMcOh5mr7W7Xcp17Vi08I7VsnjbkyC5/
 erk5BANyqRvFrd7nDjmLy9466xG0Z04XKXxrAllT3hivQYtklFJ1Se76XtGov5QMhv5C
 Dkb28ogIE1TodYQs4Ijk6G0k8Cd5Cpd2/vkZiq0lPt80jbsnyDI5mxzxj7XGBxLSOcmc
 Ksjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600099; x=1732204899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsbKOlO+09+V06ilkiETtavIcLFq0cApuQcSVOlh0Qs=;
 b=jvad674pSrUdPxH6ZjIOqmFpyb3JXoTDSCOIGcrc+EvRDa9l9EH0/NGDpDabGgkC1G
 1tAi+jgbP02jp5IEIIrSKO1UVqX9FnkyhIpV1FMWeFvb04zD2uDqGJsX7X9IEjtYzufA
 ik2rl+93t/We9gygL1S3KYNbPIAypiMbupddigLFn8+5lwsRDY7b08IaezGbPuG6UBiV
 pZqsrJvP7DrzzllYRPR8zR3dClmro/U/9McA9E7RrKkq/EN2yC4Eod0yjm2hzMvY7q+X
 tjzdCuGBPClxZw7ULT+9RNE2Y8ta4383yfm6YOJSEzyQQ2EUJNc/YOtVqwLUXUWwijNA
 LOxQ==
X-Gm-Message-State: AOJu0Yx6j8gUkX/k3IeGAnyd9a6Vx8l5X0+p3w+cehQqGG1FzdBi7/NP
 MnkSyghpPHNbH+HGXcbj+AoZts+4KjfCq/RZIsURuwZztjqIA7ZGcbZ5B8kvbe4Bqx7r+JjGFzG
 w
X-Google-Smtp-Source: AGHT+IGt3AC5gHbE95Yv2CV8baHn/zHIl3zbHtIEsS9n2l/6g/fpoWhk2keiF6Le3MGl5XN08m9MAQ==
X-Received: by 2002:a17:90b:2248:b0:2cd:4593:2a8e with SMTP id
 98e67ed59e1d1-2e9b171ff77mr31886980a91.15.1731600098555; 
 Thu, 14 Nov 2024 08:01:38 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/54] accel/tcg: Flush entire tlb when a masked range wraps
Date: Thu, 14 Nov 2024 08:00:44 -0800
Message-ID: <20241114160131.48616-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

We expect masked address spaces to be quite large, e.g. 56 bits
for AArch64 top-byte-ignore mode.  We do not expect addr+len to
wrap around, but it is possible with AArch64 guest flush range
instructions.

Convert this unlikely case to a full tlb flush.  This can simplify
the subroutines actually performing the range flush.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5510f40333..31c45a6213 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -802,6 +802,11 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
+    /* If addr+len wraps in len bits, fall back to full flush. */
+    if (bits < TARGET_LONG_BITS && ((addr ^ (addr + len - 1)) >> bits)) {
+        tlb_flush_by_mmuidx(cpu, idxmap);
+        return;
+    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
@@ -838,6 +843,11 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
+    /* If addr+len wraps in len bits, fall back to full flush. */
+    if (bits < TARGET_LONG_BITS && ((addr ^ (addr + len - 1)) >> bits)) {
+        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
+        return;
+    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
-- 
2.43.0


