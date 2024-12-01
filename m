Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E50D70E0E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 07:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHe5r-0004Qx-Q2; Sun, 01 Dec 2024 02:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tHe5q-0004QG-F7
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 02:10:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tHe5o-0002za-Gj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 02:10:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434ab114753so26647165e9.0
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 23:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733037006; x=1733641806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYrZpNTyILTlKRcefPsWa8A//uZIaXEoVJ02mmHyJF4=;
 b=RLqYoqGW4uxgJKaF3FXlFNxzaHL2j/vcQLggWsViJEjYHNKu2afZLy77pw81dHxRL8
 4TE+Gcms9i15MfyDfuYUkxbJ9eK41VrvVmaPfrTl6/iHzp9+r5I2PtModaFeBwH4jiwj
 vlk+2HPyD8InOVuyE7i4dnpF133lUzJYXW4NxT+VcxdhiEssgT8Wm7oKVFoIVySJ0SGT
 vt3iDUjWfxTwc/5JCeO7C7j0S0yHnFxTOUpBRvOk7htAHjotOXHtLQK+1qhllppKFNtZ
 jWWN73b8UdbA2BBgYU4w/i4YRG9tbHM7il0YAwb0mJC7jeCbKrRGhzy6OeLTnftqzptB
 VVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733037006; x=1733641806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYrZpNTyILTlKRcefPsWa8A//uZIaXEoVJ02mmHyJF4=;
 b=uVZALsGn05rewXKGPNNbnOogPmVeGIBlIOXgCNJEePg/SfMUQKH0Zt9dEq7ftZE8+M
 FjmKxDLrPsny1JKbFaLP98IrNrqVyCHOD0ppdehPSIZxNDnjxkMxLZtv5RRBi3WGJHSS
 AJpFanf3Z+k/OzBGf/C0k5xU0B51xwwnj+J6CiRhNzZFXx831X83AuWbhvp8G50aL6+8
 tgYyXzFpiohbk1i8wT8L1sChTEDRcxXiKlDeYq2+1j5Fn7b9s/uyZx6NcoxvJsVyB2p+
 TvMH5Gx5fN2gesQ6SFxYSseILvtBFQTqlMt3SaFQXjoKfqQaIK3uDS6k2g466rYwhMr2
 7FrA==
X-Gm-Message-State: AOJu0Ywqyx+fr0VwrbofiLttMthJ5UygWC8iD+gkuMDBnls+8T993IGR
 /CATFMx66GLFCMdi3qTwgqShJsp50RHzM6QV2J6U/MHrrFwF5qsqvZYObA==
X-Gm-Gg: ASbGncvLyHLHB0/bFM0/ER7LarRR+fioW59iroV8VhaTHcbIFE1Z837maFwki6WS8h4
 TrSrq8xAhrctT5IO9cvWtrgQUkGUbh1aBHXJLD3LWQzjoOUbvx39cJUPKX5iQeA855uwBo+z7wb
 NDRS456BUK4BYKGiNALnFihD9gJHAIKAJRXGQUAfNo64ICDQD+3rZElamgYWBAfDXf3MCOZWVGD
 dvalbZzuNOD/pBGx6d44hBFmeu4OKvLX9socwzQi3lNAyrWj7sDq+k+l1p2ArfzBjAvx+z+m74y
 aG5lL99tmH/1/A==
X-Google-Smtp-Source: AGHT+IElu2/LS2M4tVJlPbqW8mwiugBZfLsn62lh8qpK172LQqu5NGgf9+DfnvhzTayCk+UjaToWqw==
X-Received: by 2002:a05:600c:4fc9:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-434a9dbc455mr182832355e9.3.1733037005888; 
 Sat, 30 Nov 2024 23:10:05 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7805aesm141974305e9.23.2024.11.30.23.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 23:10:04 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Joel Holdsworth <jholdsworth@nvidia.com>, Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 2/2] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Date: Sun,  1 Dec 2024 07:09:54 +0000
Message-ID: <20241201070955.223360-3-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201070955.223360-1-shorne@gmail.com>
References: <20241201070955.223360-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32b.google.com
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
Since v1:
 - Use DIVIDE_ROUND_UP instead of open coding as pointed out by Richard
 - Fix off-by-1 bug in TTCR patch pointed out by Richard

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


