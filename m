Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BCBE6ADF1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 10:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEnXP-0003xu-BJ; Sat, 23 Nov 2024 05:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEnXN-0003xX-Ls
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 05:38:49 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEnXL-0001Y7-W3
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 05:38:49 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38231f84dccso2071830f8f.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 02:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732358326; x=1732963126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7sa4WnkD19vIhgLdanCBDNOHZb6rMAj72QyGrMMNhU=;
 b=SYVWzhYplDN7rnhH78yYosQuVwTnUrwLSGW1izjdeDWVD8CnFF9BqkMfRBLp2mRbFX
 6EYo633BqtFhK7j3vaNIQESYJ0UGpniUoUxwvlQc6/n+TBvFn3ShEJ8q2QcVjw5hrlHn
 DZlS9/76jTDuv0NN9+FQljEaZ0juzWh+XeiOyLcpVJpyueX1yOAbxLOSWYhcCCaAn7ao
 WA1GI77hVjVH8OuJjZWH+okW1wiMXg0UpEuvrlxOkr9PRLn0TYwKcwgHzYIlr0vynQvt
 vbyY4p6oD/t0kaiWlt/BLssrClG29rZHEuUt/qglFZRq1kGt7zPtv8VAqojeXAz7zniI
 tuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732358326; x=1732963126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7sa4WnkD19vIhgLdanCBDNOHZb6rMAj72QyGrMMNhU=;
 b=mRaZBUDBDwPn6uPdg9KehfDERyAiuiemIOoQCtCvZUnxueUDRZacxY6rRtFQX+bYzT
 A3/0ygo1NRba8znghVYtrq2LD+pTRqdIjvj8X5oe+6fQ9y2bZS5yM5lrUmdd41cLt4wc
 lMpDXVso6RJhuFf/NmmNRnlFlb7K9273/jHE6MsyRoW+pJGjNZJEdXEubWJhbFD0CEjp
 ijLtvXSmHqVCXXgGQjqy2M8Iz/L2oVcWsda95moEyMSXQv7FJjajMnQVF57Z4uie3tH6
 8P5Y/AxaFavzGmaxuGY6xbMxmpM8nU04OPPrf2MBYRz/yyTLyr8ba9ZW+i1OPOgQnTO7
 17AQ==
X-Gm-Message-State: AOJu0Yw7UpCLD190P7Iyv5YIXnJjWui/0T+8h0bEUobLYMBsdvSGOvoG
 vwt3h7gp9d1uiC/ZZxMYLnTVzH38IWScHynG/K68+CY8YkhCRRU4spoRDQ==
X-Gm-Gg: ASbGncvEL1LMHFoMczyAMI4I9HR++lO+m3Jj1/VDBpxZTpk9ulq0ZEzFjfEvnMLTEbt
 ThXoC6YLY3b7fSddyzDiphxT0EX91qRzgTHi1h6p1RJ/1Kxt7vRSauHdGZEASYGbCuO0cZ++qF/
 tTJdvf5aAuIkiZc7nLEFwW/szhW573suszgB7u4ItqD/dEkLqcCPcLZ4kvvwOX0HNIPg2ExOhC5
 oI1nyVuZKnu42ziy2HDELHfTcrDv+xNRBKBPFJ9yATvUbplzjCoRm3H6bssB7ae8NUjUnoSkTHF
 ZaM9jIr5hQIemQ==
X-Google-Smtp-Source: AGHT+IFIjUabn+3nrWKgecbDd8dH6FHRQGS2a2bd8wPRvZR0h677+9MGw5hWjm12aODweq8MGU2uyg==
X-Received: by 2002:a5d:59a6:0:b0:382:383e:850e with SMTP id
 ffacd0b85a97d-38260b58a50mr5722085f8f.13.1732358325662; 
 Sat, 23 Nov 2024 02:38:45 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe338sm4857406f8f.33.2024.11.23.02.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 02:38:44 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Joel Holdsworth <jholdsworth@nvidia.com>, Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/2] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Date: Sat, 23 Nov 2024 10:38:27 +0000
Message-ID: <20241123103828.3157128-3-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123103828.3157128-1-shorne@gmail.com>
References: <20241123103828.3157128-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x42e.google.com
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
index 835986c4db..7fb97ce2b0 100644
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
+        (now - or1k_timer->clk_offset + TIMER_PERIOD - 1) / TIMER_PERIOD;
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
+        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);
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


