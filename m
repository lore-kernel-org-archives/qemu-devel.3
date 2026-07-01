Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ECAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welG4-0005pq-BV; Tue, 30 Jun 2026 23:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFx-0005if-29
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFt-0002pd-2c
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c979d03538so1018525ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875092; x=1783479892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2tedjt9ue/IHEM2C2VR1yTQ8onosX/0AIW1UgXuO/Y=;
 b=DCfaK1Xa20knHf2JbdvNrKe0CynwbDll02Cf6ldBnZSAMWzvxptHTnDTP30OLJIVek
 nGmDeLFCtq0xPaDTJFr+n08kSqjP0trlY98dNTD2EK3wiMikJW6oI2EIFuDzuYFq/mB4
 uS3PT+7S1LtYkZWENfp7Yw7vZWpnmO3xPZu04Ml/FRRaV5P7AvfALguuEpZVh/oG7klS
 AgpYRO2s1uX59kqDwWip0hcjWsS797f+GwLDncRrVBI5ISxXu8lrTQpPTNCe1ZtiD2Xk
 vzZTxkmraofWFTE4NmlOO6en47FFVX3F49P1S0tStW1QuQTzOrb/HY1gjSd6wOWaa1iE
 M1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875092; x=1783479892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m2tedjt9ue/IHEM2C2VR1yTQ8onosX/0AIW1UgXuO/Y=;
 b=mmclhuKklwdZMIi/7M305bxGEmqsFZ9FbNoTuAeMlFjhsFpGJsUnPcHvQB7I36TGY5
 /JgrTqhcPUgnn1KmDHLubsFwj1+x2a4W2awKmQWLn7HgPNwPBh8mWXgckv1ku7+gV1gK
 3JSsnR+E39uf0/f3HYffZIq6UnCgZgGEpYzDJzt0znXfxHPtUDBrbRV8BfQW1pW7WiCl
 DBCWw41ol5OQ2gfnegkjUXfZiPdIdp9B3wkM1zFuO0KvicJfQ85If2Sgq3DKQVemqU1Q
 /ELialxQN0EAhenqHC/uZBlHo/mwyCbZgYIKrxPu49xpAICScwJJNj5cz2fk0LG4bK9P
 7pgQ==
X-Gm-Message-State: AOJu0YyqNr819IXW8lI6Ev5KPzlibc+wTttKd4bg/sdRg5xrpK6Vjc0L
 BtxYAC5nvi+O3JKLo5ztYx6kndCLfdCaaT+t77Ce+3X/cqFvDqdhzJ6Owl+v2IlbMruVJ3EE6oE
 N6hk5
X-Gm-Gg: AfdE7cl90tQsSdUBJjAi8wmGmAN5/jaHvdpSXuwD8SsCxLU1KwOOjzVbH6Ir5xwXRzt
 wmLWvQdAAiSpP9kzJ3NNTaBaGBb72Q4+BmL633iEP95lp6vZKTE7SWfXaE68rYNHbHOGHEAeQo3
 iSmvKgysQjHv6dlqrib/319BnZM6mrT/P1dPZuTZnNXF9Rvi3soW0vw/I21n34qaGGGB6H3Us6R
 4OFcTLhiGglMoKdHd0FHbdrOh2xOgl6vqHVFx6qP4cXw7na5k3DC4uW+d1vZF/D1TWXmmVsiPMG
 thrfrY3tZwV+YsvM/y1/GKESJMn4Vi9QuncNpA8YKJHqHf4/Tmw0s1DPsJ32PNN9pXBbsP3vWLs
 Uwsh0v1Ypr1/ymQzTZUbUe+2v3OmwsQmAdLDukR++Uh3iWwRPC1yv6kRKDo+kmEWafba3Azs3Ou
 hzr5r9MCTIe80pi/UyqUOLXKYBIK1Va9ai8JzZJl3aj+40RjXoJA==
X-Received: by 2002:a17:902:fdaf:b0:2c2:50c7:58a4 with SMTP id
 d9443c01a7336-2ca2e718309mr54601625ad.22.1782875091568; 
 Tue, 30 Jun 2026 20:04:51 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 08/17] exec/breakpoint: Introduce BP_CPU_ID_SHIFT
Date: Tue, 30 Jun 2026 20:04:34 -0700
Message-ID: <20260701030443.1382447-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Allow the target to store an identifier with
breakpoints and watchpoints.  Change "flags" to
use uint32_t instead of "int".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 10 ++++++----
 cpu-common.c              |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index fc91343875..93876f3304 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -25,10 +25,12 @@
 #define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
 #define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
 #define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
+/* Bits [31:16] are reserved as an identifier for BP_CPU. */
+#define BP_CPU_ID_SHIFT       16
 
 struct CPUBreakpoint {
     vaddr pc;
-    int flags; /* BP_* */
+    uint32_t flags; /* BP_* */
     QTAILQ_ENTRY(CPUBreakpoint) entry;
 };
 
@@ -37,13 +39,13 @@ struct CPUWatchpoint {
     vaddr len;
     vaddr hitaddr;
     MemTxAttrs hitattrs;
-    int flags; /* BP_* */
+    uint32_t flags; /* BP_* */
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, uint32_t flags,
                           CPUBreakpoint **breakpoint);
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, uint32_t flags);
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask);
diff --git a/cpu-common.c b/cpu-common.c
index 11ab32d64d..0b54e8a497 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -405,7 +405,7 @@ bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
 }
 
 /* Add a breakpoint.  */
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, uint32_t flags,
                           CPUBreakpoint **breakpoint)
 {
     CPUBreakpoint *bp;
@@ -435,7 +435,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 }
 
 /* Remove a specific breakpoint.  */
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, uint32_t flags)
 {
     CPUBreakpoint *bp;
 
-- 
2.43.0


