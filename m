Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61911E64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8D-00005i-NV; Tue, 03 Dec 2024 06:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8B-00005N-NK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:31:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8A-0000Yc-4U
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:31:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e96a285eso1511468f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225508; x=1733830308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEQJbcE86qikHlXktFZRneXT4XN3T75O47zRCAyenRc=;
 b=QxGJW/xc0/2s4tmVFtFyDJN7GzksIcO8UH4libWr3hGOsv/5EbisYtL5TsTZwZotdY
 X30mtPshnXfH6BOHKR4gIcNboyj51w4O8ylmvcZjhrvOqL2WpDeDBoul5lbnw7A/riDf
 fXCINM70TGFeUyHFbwBCBykOUeezWDO1ZvFTWLN9k+YwgTACvitAJufRPFDCJAJayDSZ
 u16+K09wKPLZLDkA81Zr7LopSJ8g1kqK34iVK0nbE7i3o5N6Mkn9s8bgjAuTJNdmK9yk
 s8mWS3LHWG32vgT9mc9Ep4S1wbveVO+6mVr2If98oMUz5DYR9fVGxJ21BFsVGlRkjeNq
 LAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225508; x=1733830308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEQJbcE86qikHlXktFZRneXT4XN3T75O47zRCAyenRc=;
 b=J2K7W8JS64olVB3gHDnSZr2i2Zcayf9E3b+iqt6yoATboeYLYl1VHSsXDuKYXtJSTZ
 zVHdw+JGOqmp1/nUuRCr1gdJ6bJygSlWpeaVtQLK3L8wycbFZaSpM3syzq9Uf3a2ueq1
 V6D3Qkuy1kbdt8xufhP9cEv4vDOylL3e9YpibGUG516yxPNOFphNp6oKZB57ubdoMesb
 NYEZLmhF5F7IHTLGLguLyu5t4fPPTURhoBFZsUvYVg1ww5OpKJCtPczMAvFLiPKjXhWQ
 fHPo7Nakw7XJmNdJz7cIbS/YxEJbhifDGrJlFEXX9oGVe4NQ0vbYL84+yCy4m37yZk17
 UeWA==
X-Gm-Message-State: AOJu0Yw+8dICTxugskcgaQkc/00cUFCOziyNH7SJbd+ZbwOlU5hwNo8A
 OZYUTxiaTK5LRjNa98xfKge9NEYTi99zEU096adWz+aGtCrYQO3E20dEW64CKc/mHfGET7fwCch
 7R0I=
X-Gm-Gg: ASbGnctakigovJpIt9PwnOSixiZwCJ+SfxXt0cQ0MIZ7kj1CO66lhH4isOeuhN1ip1n
 m6OyMpI3E1sDoAdYMrv9dh3q5RokgeH6N/8pC7WUi6S8FbKhJriqq9QmYYv5t7HwNDlLX51b++o
 hd7eIRllp7reZiiEe88pJyCiRUIyRFhv1VMAKe/ZRI0MvwRzHKN4UJF00elCP9Ep5vRRUhooHvH
 8upYLNnkj6LEjae6J69ye7x0YheAZE4dk2C1v0rdBw+i8MsRL0x8gs8aAVLx5KTV712dE0w
X-Google-Smtp-Source: AGHT+IHNJgQIZ6HsSqWeIi/FHFZ/lL//XyJvuN5mYC3QJaMQsuSrXgfqt5X6MJbkZMhCQx2qIuzq/A==
X-Received: by 2002:a05:6000:1f8a:b0:385:f0d2:c34 with SMTP id
 ffacd0b85a97d-385fd423f8dmr1694907f8f.49.1733225508290; 
 Tue, 03 Dec 2024 03:31:48 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e1bba97esm10618562f8f.91.2024.12.03.03.31.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:31:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Holdsworth <jholdsworth@nvidia.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/13] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Date: Tue,  3 Dec 2024 12:31:28 +0100
Message-ID: <20241203113140.63513-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Message-ID: <20241203110536.402131-3-shorne@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/openrisc/cputimer.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 835986c4dbe..87aa3533237 100644
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
2.45.2


