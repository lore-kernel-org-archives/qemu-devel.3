Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F51CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNw6-0001LK-9I; Fri, 08 May 2026 12:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw4-0001Kh-Dj
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw2-0000wr-JT
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so1583975f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778257217; x=1778862017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHeQ0RvfaPoCSBPza9VvcReWRUsEKtq1mtgPNpsP4iY=;
 b=NYw2bYXcgJY91FHw2170YC3WXihz6tI/AhHejIGCchsojN2K1KhOYoLKpdKSONmlc6
 rDRmOS8WhMgln8o2hU/GjWULUzEqiUk7xolA9qJhDT+hyyS0cMfEEYcImQDz/x5/AEkO
 b8EaNbX7AmsKEl4KSVE3DeeVYj2+a1yS2ffnAqvoaAuHc18HVKHw49+pxmeczSNTzv/x
 mT93zScdqYZ2P5fwbznN08mY+FVYou41RjXSvsaPfULufY7Ll4+zqtBkjiSZvf55ID5O
 4c0KrSHCf/LG3Xfhr8dS3M6vHw52zqZyPLnzPUGG5gT69cC/ELEOmRLfRulTDaihoSI7
 9Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257217; x=1778862017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tHeQ0RvfaPoCSBPza9VvcReWRUsEKtq1mtgPNpsP4iY=;
 b=MiLpE7EwmtaAoYgOiTqBPE09ikiEk4XRyC6kuKm9p6E27V1YMFPbNTj7qhX6wQIn/W
 jkXk4XeKHolIPtC+P0iyqKhBdMTpcZ7FyNMWbomuUaO1v1CpVDZN2zqgnpHaecqgwsx5
 HSQPUNqdSNHC70hV50PvAQfeA8U5clFtHfHPtLfVIlp1qXWG/MBAiUx4ySxdSCwuX+7t
 bEOXme+zbVCyodAR+E1NQ6FAkEwo84/lclf555T66ujbTwvGsujmJOp6bYmnRshOTr6A
 9I1eYxGv+9DIaiwhJqsZasYX9ncD5uOVjzcpEDjMxVIKynEroPmk4thLvp4Bp76gGiTt
 a2qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Na/eSf//Ztz3o0jQjmz4G/pz0xQ5hufnk7y2eu9CrdOqC2X/MxyQ1OC7K6qRiP3YcEMMA7IrwloQp@nongnu.org
X-Gm-Message-State: AOJu0Ywvq8EVH1jXhy7xG26W1e9/0XXmqanOTOAhX/4uYatUCdGPVLsq
 wCXUwkYOu7QSpIbBXEGvk9xANL+jKqjhoLOE0Bob8mVMNbeUaY8CDI9LBWrWx72h3Rs=
X-Gm-Gg: Acq92OHVVsnf3+THeh+t5ciAYe9n6sZ4gAhAVDLRlrre8p3ISEX5DUh/6eyWHjaNHpL
 jDn3KIPher5txlNRXvTm02cj8f3Hp4dyXUQ0mE/wJnbdFOJK9W5QLEpC1d1Uf2+2hzO4X3yQ7F6
 MAZYKOFApI49wyZLQCwF0LenStROwb6VGBYyWihBl9e2iyvi8uKiIaKUiibWu0z64UT8+e2X5X3
 QE+uln4utocxv+5qa1rTbJLqSqfGTUGze2xcvJlRMye5XgfPIYWKJviY4Jwi4NpUtHaeKehHIGY
 UqD7a8viYCr1T9pziMEN16J0bkMnMdpd5P7BGuIYvn37eW1RxKpr4oheJJmDGvQFZs/vTGJyxCY
 BSMreXb+OvrVg2zjIIYDexgo+oY4HrtHFJr14JhaVnBbR1g8mwP4suiIfvJ+P6ZRgmi/4JeH1J3
 ISgGQjcGS1lmBHKMIXNU5hnBeXLzKuDi16VI9V0nKZtyDot9Qa/MzDzgjmRAv2Q+aPUX5iWXu3j
 JBhyPDoAMWIS32GJ5cNqcq49hYodJI=
X-Received: by 2002:a5d:5d03:0:b0:441:1c95:17e7 with SMTP id
 ffacd0b85a97d-4515b5243efmr20254181f8f.15.1778257216862; 
 Fri, 08 May 2026 09:20:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6aea4sm6226998f8f.10.2026.05.08.09.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:20:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/misc/bcm2835_control.c: Don't assert on local timer
 zero reload value
Date: Fri,  8 May 2026 17:20:10 +0100
Message-ID: <20260508162013.2751001-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508162013.2751001-1-peter.maydell@linaro.org>
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The bcm2836 local timer has a basic "counts down, fires at zero,
and reloads to programmed value to count down again" functionality,
as documented in
https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf

The documentation is very sparse and doesn't say what actually
happens if the guest programs the reload value to zero.  Currently we
trip an assert in this case.

Instead, log this as a guest error and disable the timer (which seems
a reasonable guess -- effectively the timer will stop counting).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3395
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/bcm2836_control.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index f1deafaf7a..d6c6057cd2 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -197,12 +197,21 @@ static void bcm2836_control_local_timer_set_next(void *opaque)
 {
     BCM2836ControlState *s = opaque;
     uint64_t next_event;
+    uint64_t reload_value = LOCALTIMER_VALUE(s->local_timer_control);
 
-    assert(LOCALTIMER_VALUE(s->local_timer_control) > 0);
+    if (reload_value == 0) {
+        /*
+         * Spec doesn't say what happens in this case; treat as a
+         * guest error and stop the timer running.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: local timer reload value is 0\n",
+                      __func__);
+        timer_del(&s->timer);
+        return;
+    }
 
     next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-        muldiv64(LOCALTIMER_VALUE(s->local_timer_control),
-            NANOSECONDS_PER_SECOND, LOCALTIMER_FREQ);
+        muldiv64(reload_value, NANOSECONDS_PER_SECOND, LOCALTIMER_FREQ);
     timer_mod(&s->timer, next_event);
 }
 
-- 
2.43.0


