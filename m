Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3219BC61DB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaCi-0005xv-0t; Fri, 06 Jun 2025 12:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCR-0005XD-VZ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCP-0003Qd-NJ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so19365765e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228344; x=1749833144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIuklLgT7yxDr5xUfy1gGIRFVc8VIMyOClNRwci8w2E=;
 b=c/Xcs4xjeEG/V/CEggSm4wtZHaosVaCBDWRKYS/d5cN/BchFpR54Cfqo32eLcdtcH8
 Ocb7I35iciCwoz4X96aoYFLpXScMThPaXD8HSU9bFZkvU6/6NMFpImRxcSawNshGcl/k
 ORg8REzC6RFGWpn16hnTYNk0d6g26+DOgQFkIEdCPkK0RXp/U6mJqh6OJvBqFtiANWkg
 SeswCruf+1Lhi4jhUxCm0yke5lP21gxXsG/c0vRivQfeEGF1Rpb97Pzd9b+T64UOkg0N
 GrdrddTDU/YeyT9phq44g6sXCKjlkI8jWXw9jhGAI8BvIvK36l7Q9CrAS6V7eIbpOwS9
 TsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228344; x=1749833144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIuklLgT7yxDr5xUfy1gGIRFVc8VIMyOClNRwci8w2E=;
 b=Kl59q0+LM/yJjKJ5zg95z0L2GpaIK3oXFcWRXx3BqTq2+KZWLDValFkw60XwiPLcmO
 riEZ0MSPjm8ZhBrbEV1FAExn3JAT+sbTem3Kg4QStVNYZAxde60zpc4Gzt8Q/aAWFTi0
 gQF/BqRoQ7qnkx1Ksf+E5yKSz1Bbn4GJUHIghfGmj0f4GEvRKSOO1Kq/hSfAVsGctxla
 J9vJddwkQeeouNs/AfPP3tdL7erAB6/qawhBlR5RLk1OXWIE5mcmN1DVAt3wyKS9GQrQ
 hqJZ5qwDP37du0Pcy8wTMNC+DeVbEhtaVJEDk1mmCPwqKNG04gA8a/OWsBWGO4yr1HN+
 CP8g==
X-Gm-Message-State: AOJu0YzFlGsUDJFV0sznHXzCb0gJWCbgaXnQmZVwQPoAmGMP/gMJ5XH1
 2IFwj16RTYx5gFT5kcC5bJd+G9TAt902AqWPK4yMSz0Iku6QeJYeWnnFZ8NzZrif+UDDYK/3hcT
 bjUEhrvUalg==
X-Gm-Gg: ASbGncv0/hbvRk/KETXmBwtQzMhBX0IqBtf30/hr3+6n8Dum33rYaN5lQdR2rIbUMze
 yAeg9fFKq2u/Z6TzjPqPnLdAjI/DuOzU1SSWE/c9n5whPWgoqme+2npqBlXrNlVNJ5L4lLgQOBV
 doFeMwuikzpgCmp1EjNZ7SRy1gqwRQOPvqzzPgqK3vYLrdLK2NVr3WEgNv0VmJ/rWkamJYkH28F
 K0vwxNUImuDDkwH8UpLx56UtLTf1xz/a0gQJdTU5oUBizKXM/naFIKJWKTlCJcD6z2Z7TLFXm5x
 MRrjKbM+kgcW+aztD/C75MnubE2pyylMBkONyguXkrGa7CZvzIRzQLoziQ5r9gT460Vo3kt6VeV
 9xRNMAsAO70Ew9Yb/FI2Sb9fIr0pxu9eDvlMx5Q==
X-Google-Smtp-Source: AGHT+IGLJmLcQIfes6jY98XoA3SWPqVf0SmUqEsPF/BIH4sJgjnuAdD68huSFTHM9R6cOKbIJ3mLPw==
X-Received: by 2002:a05:600c:5492:b0:442:ccfa:1461 with SMTP id
 5b1f17b1804b1-45201357413mr44755445e9.13.1749228343874; 
 Fri, 06 Jun 2025 09:45:43 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e163113sm27660095e9.18.2025.06.06.09.45.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 11/19] accel/dummy: Factor tcg_vcpu_thread_precreate() out
Date: Fri,  6 Jun 2025 18:44:10 +0200
Message-ID: <20250606164418.98655-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Factor tcg_vcpu_thread_precreate() out for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 3 +--
 accel/tcg/tcg-accel-ops-rr.c    | 3 +--
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 6feeb3f3e9b..129af89c3e7 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,6 +14,7 @@
 
 #include "system/cpus.h"
 
+void tcg_vcpu_thread_precreate(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index dfcee30947e..462be7596b9 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -133,8 +133,7 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+    tcg_vcpu_thread_precreate(cpu);
 
     /* create a thread per vCPU with TCG (MTTCG) */
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee9..fc33a13e4e8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -311,8 +311,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, false);
+    tcg_vcpu_thread_precreate(cpu);
 
     if (!single_tcg_cpu_thread) {
         single_tcg_halt_cond = cpu->halt_cond;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index da2e22a7dff..e58e1c3738f 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -41,6 +41,7 @@
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
+#include "hw/boards.h"
 
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
@@ -68,6 +69,12 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
     tcg_cflags_set(cpu, cflags);
 }
 
+void tcg_vcpu_thread_precreate(CPUState *cpu)
+{
+    g_assert(tcg_enabled());
+    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+}
+
 void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.49.0


