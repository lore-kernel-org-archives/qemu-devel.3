Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86425C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEcA-0004w3-4Z; Sun, 05 Jul 2026 00:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbr-0004jw-Mf
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbk-00041v-Ls
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cae134bdc8so8703225ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226251; x=1783831051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aDmvLx7tFb72uym/SedzgMtxN4MKiCwduhbZZrMhn/8=;
 b=rY8iPn6olfLVS01wUWpJKWrHxAjSu4v8XQcW8qmWfWXOKe7Gp+RZqWXyvC2wUc9pjO
 03+IH3Lre8Sm3S5A58mr4YzzKPrhZMdXTXf/WNkjFQXuT3R3LWXX9sAe0W4MUK4JKYNI
 C0M6jdh8PxX7YKwY6LRtefqTX1Lf+Mqt8ifzuO/AfFGJf6g3o0S7SVVb0zmba8rl3V70
 QwNRKKfjXUhTi1xt4PO4ILXN9Y/a1G8H31CbETyiiOi1sfrVtI2o5igfLUIZLilBVITl
 lw8J9ipeJGcJsk2rhu9mze0aqYgUr2Eu7nNGm/FW6OE0H3d4jeJMzPsMpp2cfa0xtOst
 LgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226251; x=1783831051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aDmvLx7tFb72uym/SedzgMtxN4MKiCwduhbZZrMhn/8=;
 b=KpHaRPYngTpfXPWDdBWF96uxV9LwikLhtVqbFk4eXbQsl1lBkxh9ULZxH9vd9RUy0o
 RKOy7lSyv8VqTynWeww9u35078DnOFejXab9x7aR4XfgMOM6mfatLHxspPUldslYq8FG
 Q5dFxLiMJSNeexyom3U+SVykZi5sVVv3trPRRwKFQ2dJc5E08tCpBdOKUoIrujriXvEb
 bO6xZpOX68jYlTINhqqZOIvTPePc0fexA7QLstVpUFW7L3a6P5Rx8C3vNh0+1aVilpKK
 0ECMYWGxAzSqqHs+PiOoHzc0ojkDhVn/XTlDvCU8/TyQYO5mFg4hPRcAfplGipgjYAOU
 +Sxw==
X-Gm-Message-State: AOJu0YwGDe+3z0xNlSXMbjdGqaiIKAsjM9Dg01VqcTJQY+Fqimk9VHXX
 kRo/5/uCdtIPf6DKSFUjmx1UzZ7DSC9wZRlrRzzVPXSQlPcz9U2gshuLGGhOsUpk6z7PXlfpPIU
 DaJCJ
X-Gm-Gg: AfdE7cnMJVMVPSZY/IE+RqAJahO7+ovMpP4EBkxiGuBK9cWw9VBoTkXiOk6NcAi5e0b
 2MSziO0eUFIFrk2aIYS5aj1IQu+l8wyJZdmtGbvonbQZDdF9gRiRAYiaqPxodKDMgvokGh8hiHj
 s2wA0rB28mrS7WyxjeCTqdAZLDtN/5zjSgme6HhlFrbFNIJvI8iAy8A1NgVzF78OTEmggZsDVF1
 VBGhbaHiFTfKpZ4DKqAl+O6SMlMWJDkxpwBevv8URyBbUKv2JSE36QZVehdXAnqURNacffIeuc4
 1iHNpZg8F4fuoubU6mFpsHsjP/6FwCtLveOc1P5ciBgWGo7j2TwuVDtM4e2uVRUHlSR8IqFUjHh
 oIXE8uQcfFsL89y2v+RFqY8hG0b3JLdg2MYlx0VRjm5IGMdMCNYwj0zy1S5O9odA9FO3qGKAXqq
 m91bnQ21IFzq6wLBBbwQeBxzNOiU8N3TkdGt7Xaqqhj9OXV4c=
X-Received: by 2002:a17:902:db0b:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2cbb8de936emr47138855ad.14.1783226251158; 
 Sat, 04 Jul 2026 21:37:31 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 05/46] cpu: Move cpu_breakpoint_test out of line
Date: Sat,  4 Jul 2026 21:36:44 -0700
Message-ID: <20260705043725.1373137-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Move the function to cpu-common.c, with the other breakpoint functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 17 +----------------
 cpu-common.c          | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2c58ea5e4c..71ed1f17a4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1143,22 +1143,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags);
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
-
-/* Return true if PC matches an installed breakpoint.  */
-static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc,
-                                       BreakpointFlags mask)
-{
-    CPUBreakpoint *bp;
-
-    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (bp->pc == pc && (bp->flags & mask)) {
-                return true;
-            }
-        }
-    }
-    return false;
-}
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
 
 /**
  * cpu_get_address_space:
diff --git a/cpu-common.c b/cpu-common.c
index bc77835aea..ba2676cbad 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -388,6 +388,21 @@ void process_queued_cpu_work(CPUState *cpu)
     qemu_cond_broadcast(&qemu_work_cond);
 }
 
+/* Return true if PC matches an installed breakpoint.  */
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask)
+{
+    CPUBreakpoint *bp;
+
+    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+            if (bp->pc == pc && (bp->flags & mask)) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
 /* Add a breakpoint.  */
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
                           CPUBreakpoint **breakpoint)
-- 
2.43.0


