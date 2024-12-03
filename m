Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2825AE64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQsX-00057H-9d; Tue, 03 Dec 2024 06:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQsR-00056N-Om
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:15:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQsO-0006yF-Su
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:15:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so49662965e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733224531; x=1733829331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ueGEIVx4VIbjpBkuIdZlmykbUK212zjYufrTQEJTBTY=;
 b=WhrUyFn6sTb1sWvMOXuYtlxFKkSr7SgQ5cLifpngsBrwvKpLxbGEawlgOUpQMU899f
 Ny4kgxaF0JvaSgvk6g+gUBZsZo3TeWjOC3r9U+x7Q2fNg2vhwN2IS4VzrCLbuZ+hDciB
 0mvIVURbqFACwnmRKZi/cQnIPBOhrk+1GS/ErUeQ3yrU/UxwBleDG8I2Dyxw9xwSbxg7
 6YWNwC6RSS0pOPF7u1AeUq2OANw8McoBQt/Zebjf9ccT7/W3M1iqAMSsLn+MOemRzQs8
 YmJavYJaRG3oou3HnpAIw6Z+Nwyj38bD573IbJsjvpfuUAfcJdpQJqsDils8p5F2tNj5
 28Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733224531; x=1733829331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ueGEIVx4VIbjpBkuIdZlmykbUK212zjYufrTQEJTBTY=;
 b=tE4kPHyVKxDMiIBBT2WuyJQF8EpS4H8F2hNRbfPXAe2+J2k6P61zPQDuDEPqjIoXA3
 x94vViTd3dpOvyAFh6xqd4Aia/5CbY4WSl+1c/KgfGkVd2pUBUe6OdKDFdXRCxNiZxCL
 Xt8XC2pKol0HDg4P9MoKFS2BHi62nETp4flMkrxXlX2OyJdyX+9+2qnRk96ZpGIO4BTP
 C0EFd8ya567Ff9Iy/3P8smOm4/dkSiRzEe0S1vwdOArutGazlwRcTbFN5xfKwTHhJ4Q6
 VQamZ30qWvNpCOVw+VPZwLKBQafyxkNN83VyDU3zaPr5TThrOcUD6YRzYgwCYdK6fAur
 zIMA==
X-Gm-Message-State: AOJu0Ywx/+LBCaAVohkDmtqcaqtEVF5g6lqY0CKa8XeCN42+gizjYobl
 pBSvG/bue/ry0r0whiSFPQEDUI1u1ZU99RlXUIOPtOYrgXPZFt/1cDJkyA==
X-Gm-Gg: ASbGncvBLlc6KLHM5tz4b6qK/2UYb6H4EQ4gtvj+oCAv0eOZC93XOYUCuI7qYF986D9
 yHbwU8ACdIpz3uskQt5uJaXGZYGcoXvAROkPsK6k6WQD0R/mWByb7euh0je2pA7gfqudfQcdBCg
 ErhLLhMuozYF+lAjw6dFQCs1CHvIktZuUhDGNUmVE9/KJd3D2CEmmXJTjg44viZXYW0/h7Ycvu/
 0TocoPFMol58CWu4Ng7JdTm+jRJ/Xf+8ECzwUTPUiqdENfkVMfUrgZdggOpTuv9NbjvGQPY1upI
 XYPeAFx8xUBA9g==
X-Google-Smtp-Source: AGHT+IFabsoe2JHYDEjx6R7KlVIkg8R5ybVM7wd17I+fMbBs7yJh5l3RMaAKBg85yWs0OfHirgHgGQ==
X-Received: by 2002:a05:600c:600f:b0:434:a902:4168 with SMTP id
 5b1f17b1804b1-434d1116eb0mr17566625e9.18.1733224530618; 
 Tue, 03 Dec 2024 03:15:30 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd3a5f7sm15166887f8f.54.2024.12.03.03.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:15:29 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Joel Holdsworth <jholdsworth@nvidia.com>, Stafford Horne <shorne@gmail.com>
Subject: [PULL 2/2] hw/openrisc: Fixed undercounting of TTCR in continuous mode
Date: Tue,  3 Dec 2024 11:15:13 +0000
Message-ID: <20241203111513.402641-3-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203111513.402641-1-shorne@gmail.com>
References: <20241203111513.402641-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Joel Holdsworth <jholdsworth@nvidia.com>

In the existing design, TTCR is prone to undercounting when running in
continuous mode. This manifests as a timer interrupt appearing to
trigger a few cycles prior to the deadline set in SPR_TTMR_TP.

When the timer triggers, the virtual time delta in nanoseconds between
the time when the timer was set, and when it triggers is calculated.
This nanoseconds value is then divided by TIMER_PERIOD (50) to compute
an increment of cycles to apply to TTCR.

However, this calculation rounds down the number of cycles causing the
undercounting.

A simplistic solution would be to instead round up the number of cycles,
however this will result in the accumulation of timing error over time.

This patch corrects the issue by calculating the time delta in
nanoseconds between when the timer was last reset and the timer event.
This approach allows the TTCR value to be rounded up, but without
accumulating error over time.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
[stafford: Incremented version in vmstate_or1k_timer, checkpatch fixes]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/cputimer.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 835986c4db..87aa353323 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -29,7 +29,8 @@
 /* Tick Timer global state to allow all cores to be in sync */
 typedef struct OR1KTimerState {
     uint32_t ttcr;
-    uint64_t last_clk;
+    uint32_t ttcr_offset;
+    uint64_t clk_offset;
 } OR1KTimerState;
 
 static OR1KTimerState *or1k_timer;
@@ -37,6 +38,8 @@ static OR1KTimerState *or1k_timer;
 void cpu_openrisc_count_set(OpenRISCCPU *cpu, uint32_t val)
 {
     or1k_timer->ttcr = val;
+    or1k_timer->ttcr_offset = val;
+    or1k_timer->clk_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 }
 
 uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu)
@@ -53,9 +56,8 @@ void cpu_openrisc_count_update(OpenRISCCPU *cpu)
         return;
     }
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    or1k_timer->ttcr += (uint32_t)((now - or1k_timer->last_clk)
-                                    / TIMER_PERIOD);
-    or1k_timer->last_clk = now;
+    or1k_timer->ttcr = or1k_timer->ttcr_offset +
+        DIV_ROUND_UP(now - or1k_timer->clk_offset, TIMER_PERIOD);
 }
 
 /* Update the next timeout time as difference between ttmr and ttcr */
@@ -69,7 +71,7 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
     }
 
     cpu_openrisc_count_update(cpu);
-    now = or1k_timer->last_clk;
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     if ((cpu->env.ttmr & TTMR_TP) <= (or1k_timer->ttcr & TTMR_TP)) {
         wait = TTMR_TP - (or1k_timer->ttcr & TTMR_TP) + 1;
@@ -110,7 +112,8 @@ static void openrisc_timer_cb(void *opaque)
     case TIMER_NONE:
         break;
     case TIMER_INTR:
-        or1k_timer->ttcr = 0;
+        /* Zero the count by applying a negative offset to the counter */
+        or1k_timer->ttcr_offset -= (cpu->env.ttmr & TTMR_TP);
         break;
     case TIMER_SHOT:
         cpu_openrisc_count_stop(cpu);
@@ -137,17 +140,18 @@ static void openrisc_count_reset(void *opaque)
 /* Reset the global timer state. */
 static void openrisc_timer_reset(void *opaque)
 {
-    or1k_timer->ttcr = 0x00000000;
-    or1k_timer->last_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    OpenRISCCPU *cpu = opaque;
+    cpu_openrisc_count_set(cpu, 0);
 }
 
 static const VMStateDescription vmstate_or1k_timer = {
     .name = "or1k_timer",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ttcr, OR1KTimerState),
-        VMSTATE_UINT64(last_clk, OR1KTimerState),
+        VMSTATE_UINT32(ttcr_offset, OR1KTimerState),
+        VMSTATE_UINT64(clk_offset, OR1KTimerState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.47.0


