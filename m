Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C89EE69EAE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQj9-0001hn-Sz; Tue, 03 Dec 2024 06:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQj5-0001hB-8L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:05:56 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQj2-0005yo-I8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:05:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a766b475so49454035e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733223950; x=1733828750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xo3zekWsRMbBmwQmVCNu408X16nyiPiArPS5MagL8II=;
 b=e1XBW1SXZMOYrXcXFHWlY1pbNXVRTlL01uPJDkQbJ4pUwLpOCUvd1fmefT9dWSR6rX
 YXDDY/mF5ijV2XNhtga1zFiSFxBptQJeSFDDUvl1Si1q8+7t2zwJ1R2B8G0X25dZVkF/
 MDlZiouvwfo/jQkUj2gz9v3DEoaHif/hmET2WINHq2yqDqdHILiDm2DMd88WiVxSvntl
 y+IZUUFRuyXW5f7L2WN0WxL44v6yMRZjYwFOp5iQAfjFWCMSzISmLyCSqREV0WEQiJ/p
 0H5uncGZXcdjj8ZahKM7OpnOrVS9ffPrbPmN24gAx7ESdYJ4QlLLbJh5aywn7F/9UpxR
 ZDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733223950; x=1733828750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xo3zekWsRMbBmwQmVCNu408X16nyiPiArPS5MagL8II=;
 b=aBOQWCXTzGth/4AEfEoCwNjYdG5sYQfCQAa2vtZ04DFJEoxfjixwg/ZKd6puzH8Skr
 vqSxYiRG5J2tRE0r1XVGQDhk2hgyz4vII+eqHsojDU5LTsGyFEr234j+Oi/vuwAEqMqB
 JGM6PRpj/ohwG1zIXDSR25qRIGEb9ix2O23G7ZkyZ09mIG+c7Y79xuIKm1S2Jst1HJ0e
 S1YWwCnAiX0Se65Ixnqp8rsCcTmlCjFCWqBngvLCewddimjAYzAtgQ4gkXcgd+VIRhoO
 aticzvakyTy7QrjRuEnI9iplHfQ3w7820ea774hX8o2UaaY1pL2Pu5dwK6f7f8f/0Zo4
 i6nQ==
X-Gm-Message-State: AOJu0YzQKBIz2QoHTWFfiM67rqlswbNMKRnzBZTT0J0MI2XTOt/o3dQO
 ivzkNViYhS3LGBtr24RBH9bZ9IS4oIOwY8c3wdHMqfBcMMaliO0DhRtepA==
X-Gm-Gg: ASbGncukEzy6eSxh9Nqf547/4eVOM7QZI47Bb0m3+juSEL7YQmxnqBiQF4SGbP8tdbq
 dkXa/Drb9YLVoKtVD7aPX/oxcdvy8XBi4qQMxQmdTiajtyJAu5S9aQ80SOZcZeOOw41wl4NDrb3
 0JuchLS87dtYLJ1WuR41sDFRte9elcO6QAZUJjZ9BIl+ACTVr0zA1aiRmDymWNwBboBdjlDJnqc
 S8TGrOnEKbhNBQ37ojtm9SHcgWD6biZNi/IyXe/bMAcIYzwLcFX3RNynJ4K9DcM8Jd1ouXJ8wVo
 bL7q9JaRLPX6bg==
X-Google-Smtp-Source: AGHT+IG890fkmtWmzAl18WQUj3eGdHgCxd6C5+7JMfRBxuBPw8yNdbgoHdWDSErnhty+RnTFocg3+A==
X-Received: by 2002:a05:600c:4fc9:b0:434:a0bf:98ea with SMTP id
 5b1f17b1804b1-434d09c0b88mr18054435e9.9.1733223950220; 
 Tue, 03 Dec 2024 03:05:50 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa76a981sm215097825e9.16.2024.12.03.03.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:05:49 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Joel Holdsworth <jholdsworth@nvidia.com>, Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 2/2] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Date: Tue,  3 Dec 2024 11:05:36 +0000
Message-ID: <20241203110536.402131-3-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203110536.402131-1-shorne@gmail.com>
References: <20241203110536.402131-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x335.google.com
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
Since v2:
 - Nothing
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


