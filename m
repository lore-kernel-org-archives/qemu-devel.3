Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8738CCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7T-0000lB-3D; Fri, 15 May 2026 06:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7J-0000dc-8p
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7H-0001Qb-GX
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso81019875e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842202; x=1779447002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lJdPzsovc1RF2E9JSUPkyz3oR5KshsBgZgAJ5TQAw8I=;
 b=QAlRk8Mq5nNxw2kFh8jBHX0/hMWJHVVUHUn25W6grqTqwoJwayA08gTOiCTcsgNUMp
 d5OKlN3P1uQlClcyCIlr+kZN1lJGNc95tcO3r9a1O4uAU6xsuypQHkANKLt1TdkAewaq
 zvpxEEC2AJpRRMwuxa2D4H0J+dCxNHv38Vclmjee8qZ2r7Lc4acQIuLbVoFah+fyUkn2
 r3+bb3Kf88jtaKBx59OwF87RU1C5XfuQqgRKZr9TWfl4rhYYWHKlw0vic0afTaptV/Sc
 m6mvRFpfVW8vUXniX/1MjEwpWMY1V0J3UlR0ngzEBCDheLMWLlSEJg/q5gVot704k0SU
 r43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842202; x=1779447002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lJdPzsovc1RF2E9JSUPkyz3oR5KshsBgZgAJ5TQAw8I=;
 b=OMgnSlcXkVmA4kp3UYrJe2UIgZyT9JDe7DeULYBLAJcyZRbhnwM+9dfZn6KkHCzers
 d1uU0npaSITrd8FsUZgWqfMUpXBQ5S8kfzQSd2PHyJszy8xnotptdUjBQjS1sBF4RbsN
 v8n3rmsZa43xOqTzcLgDfC6N49TFb3ALal1ft6DFqVX1Mp8WgNrIRITsiGHF77M7yMxL
 BPyabMVoZT7zcfiNPvg3dDT+Pg+EZJIePq6lXfK8IMWJVgm1tgE4FHge6QNK6vNlT1gQ
 rfI0mUn+7PAaA3YfaChwmVgAJ+Twg2R5t3Hi8ecPC564srU1H+NofDfMfu9quPwd36Kv
 jhdQ==
X-Gm-Message-State: AOJu0YwiNeHaYuro20MBIoeBjOJL6XtQosM0Od2TTtOlHMO1AywrC8Z6
 AnxoCwVUdWLti3R9mO5RsqSrdORrDSW5La9rLWg1Wr2mpIuat4YMQbBeizTq1XrtZaPNjMyT0TX
 Uc/1r
X-Gm-Gg: Acq92OF/tKbb2xjdwBRxKdRH5PQ0Q/cO0c8UUt+/n+gw4TvDOTRoKIeM+V87W8jLonR
 vICya/ZUbnq/cXChQ/gT8+8srcdhcLZEz6aY/CDbUvNIfrYHy+lVdVMreXhBYiclrVI59JM46Vi
 RImeXw6z+mUnyxxnKQWfTC+nGU9j2OhkEYSVE1jiWX7NbdIcrNOx+nJiVY6UiMrYNsCERqtgKrA
 vTQ0KwRjXbPp+2U5/S98jrLdXku6Oj5EkqXNbuC84GvtxpA4+qQYaSAL9HkHh0gY7aKwUdzLyBn
 Uy17QYQw5t3XYlHkKk+zV8HH0cQ74Jq7U30nFU4FArfXnj6iILWTXx5Azpn8eUHFpxHZaAWVYsb
 cFPFT9dIs/6yLj+9Hg6Ipi8L9BubVfCzQNScs30STuIyDf6Bkaz+t7ZQmDMSkWbtix7bTAP1Z0G
 DofQUHVEfzkhZZk/Q58itbedKwzKMVEOhx52UuoHX4iE3MHhXcArs0h7zmrC/5aFRLV6qk9OI7Y
 ho8jUA5Uk54YNAgaCUnULw/wu3tSG0=
X-Received: by 2002:a05:600c:5298:b0:48e:635a:18d2 with SMTP id
 5b1f17b1804b1-48fe60e51d1mr46926645e9.2.1778842202057; 
 Fri, 15 May 2026 03:50:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/23] hw/misc/bcm2835_control.c: Don't assert on local timer
 zero reload value
Date: Fri, 15 May 2026 11:49:34 +0100
Message-ID: <20260515104945.4145203-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260508162013.2751001-2-peter.maydell@linaro.org
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


