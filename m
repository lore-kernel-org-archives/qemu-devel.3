Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B51CEDDA7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJS-0001XS-4J; Wed, 09 Oct 2024 11:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJP-0001W8-Ua
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:15 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJN-0007yz-CG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e10ae746aso1878744b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486552; x=1729091352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rKX+Uzl8zZj3fHPXUUEHmyyX8BaoKsC5BBsSMNrfsOM=;
 b=paP5+PKbA4FWmN7jHX5fF33gXjWnCW63PFFOebVE13I00cgcHjTHEcrIAyPyPoIsm1
 aMWuRllsvW6OvQaLiRVsap5QxVbgHgCWp4FlgaMv5I9maR//zqU7ysgBuYEsDhS6HW0A
 qMdoIx2wz3uNkLxkiBV1ttTque8RQ2TtN03zisMvqVnCzUkmu0F/eIRhz6qOwOFk5OK6
 tgg3LM9zZeWNUGO6qehBES+6hkogNzg8moEPX1HMTDdPwmCdWw1hEFjfpI6jMW2sv5hO
 K6jPgbGol9roYRVm8caCIf6dC7FUyW+yNQHcq60b8tz8pbUwbbQBZTIYar+hphA3g8Pg
 Z11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486552; x=1729091352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKX+Uzl8zZj3fHPXUUEHmyyX8BaoKsC5BBsSMNrfsOM=;
 b=qWOQ7AZ/jn6O2EqJ5q0dRgGlczBU/TzrQHulg9PpYfwwBaIhz5Fe79gEQRV9xEzMcB
 IwztgPeUF0TfoQDz21hP+SNWRwRrg5E2BgGfq1l/8xYUbpFrkm6wQ9eP+JjJmYIP4sLJ
 JXnK97VgsnRV1VvRsiX/DvJbC7GJOxgW6zCePQbSVCYcw8WQTHuAke4l6GJ2JRFZ/uIU
 44Cg6n1rWdr/yOTALCvd6CymSu0hzggEh91JefzmqGxFERAl07FGHGGfUHpLMEoTM/K2
 KgRYy2aOPnzVrDvL5bQvevTKfAKn+fI0HRMtCQMWIE/XyJ3JH9zYC3Mkfb2Abp2g4Z2l
 RKUA==
X-Gm-Message-State: AOJu0YziROVeTLuyYtGNdljhPVn8lZ6D3fJuag/kNQqsRjSjSX6e1y+7
 aKBEhxaQj286MLdk22lfGNJFrubo489HgvizSWM5wJOhFJK/Efq645azFY/HWSzxbEMlZu7COEg
 +
X-Google-Smtp-Source: AGHT+IF224HVTw84qqiJH9J7Iy/0z93p44eJdMmmj9qg5+y4ahKiyiITV3r4Zb14T0cxtYh+xYQiFQ==
X-Received: by 2002:a05:6a21:398:b0:1d8:adea:6598 with SMTP id
 adf61e73a8af0-1d8adea65d6mr9429637.38.1728486551776; 
 Wed, 09 Oct 2024 08:09:11 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/23] accel/tcg: Delay plugin adjustment in
 probe_access_internal
Date: Wed,  9 Oct 2024 08:08:49 -0700
Message-ID: <20241009150855.804605-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
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

Remove force_mmio and place the expression into the IF
expression, behind the short-circuit logic expressions
that might eliminate its computation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 561f66c723..59ee766d51 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1403,7 +1403,6 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
-    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
@@ -1434,9 +1433,14 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags |= full->slow_flags[access_type];
 
-    /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
-        || (access_type != MMU_INST_FETCH && force_mmio)) {
+    /*
+     * Fold all "mmio-like" bits, and required plugin callbacks, to TLB_MMIO.
+     * These cannot be treated as RAM.
+     */
+    if ((flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
+        || (access_type != MMU_INST_FETCH
+            && check_mem_cbs
+            && cpu_plugin_mem_cbs_enabled(cpu))) {
         *phost = NULL;
         return TLB_MMIO;
     }
-- 
2.43.0


