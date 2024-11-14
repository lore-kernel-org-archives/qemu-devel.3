Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC5DD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIf-0005FD-C7; Thu, 14 Nov 2024 11:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcID-00050p-Rs
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:05 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI4-0002FH-Qk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:54 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2fb304e7dso729060a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600110; x=1732204910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lJHKnfJ9AOt1s0DhksJDYAiN+sOc9T9tuOMIGs7rfV8=;
 b=eHGfoqH87XZL3ZHbSDaWpDHHsUIg9j75KUYhfgnMO6a94XefjKiHjxxismqoUh30dI
 7ypbwKhnJrwqcg3/slu982nntlvqpBebIE0EaJiMywfdETCO8/285ijCzDTD1SXfKdU7
 AW9iGiPAYb5+GRuNCV0BSuJIcE9EsUBL6+l+4f0x9LXPd719ZLA8od3TGxo1JPI5wkTC
 4UhRO8ChTWSORpjDQ2iigaVh97CHqvNiHuejG+pcuh6JMwBwBfuN2GsEAdnKxmvDJ93f
 89pco8hHWafazJrcV/bO/mjR0cm0CNo/fQ7yciyCFuw9dlqmO/7XnRXb2RqWQE8UXSsX
 opyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600110; x=1732204910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJHKnfJ9AOt1s0DhksJDYAiN+sOc9T9tuOMIGs7rfV8=;
 b=b5hxAgIri/DRzhiY0knkYNVSNnn/GV+46Y0feyGY67JGCWsxrZwBerBOKA547zJ8QY
 73cLKz0vc2h1fRfZFQ4q6A6gXWPD0xZKA2W74ZdJQag1gXSozib/QPDL11Ke7HNnh7Gk
 J0zZtPaWci56nOlERYRUHXZQ+J7mXiYI4GRSXmDmIf3hfyNF3fXnyyO5mp64PfdjoXkX
 rnW/PcmlFzRXYTnK4wemVZaxt8XB2Rl5RcXu2PgQasGa5zAS/ocS2lUbZdQSRMkQb/Ae
 w3j5Uu0mKgmaiNDmAToKWGymZhZinyhwkN2bS2Ypoat2aaC+bYBA8Cosnee17qEKw7uc
 2Gow==
X-Gm-Message-State: AOJu0Yz9fGpgvq9rB8lGIdV+m0gZgbskYF/m696zjhfHXb5RTfMahUlH
 G+Na3/zbBOTiVy0ZSx7MUsshXzI77jQOrkpZohvCCjPzZeVRDaLLZDetXF6ev/Gl3xGWTyzePGw
 1
X-Google-Smtp-Source: AGHT+IGsHqXaMfO75Hr/xzzH8lYuJMrFbtExhGPHDG+/XpX/lNz4Zg95GZ2tSIZmtwzMf4aX6NejRg==
X-Received: by 2002:a17:90b:4a87:b0:2e2:aef9:8f60 with SMTP id
 98e67ed59e1d1-2e9b14ddb3bmr32406854a91.0.1731600110051; 
 Thu, 14 Nov 2024 08:01:50 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/54] accel/tcg: Delay plugin adjustment in
 probe_access_internal
Date: Thu, 14 Nov 2024 08:00:57 -0800
Message-ID: <20241114160131.48616-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
index 3e24529f4f..a4c69bcbf1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1373,7 +1373,6 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
-    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
     CPUTLBEntryFull *full;
 
     if (!tlb_hit(tlb_addr, addr)) {
@@ -1404,9 +1403,14 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
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


