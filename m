Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D8AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdg-0003wr-9Z; Mon, 03 Feb 2025 09:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdP-0003ge-FL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:12 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdD-0002Pk-0O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:10 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so8281007a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593657; x=1739198457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdEyfb2ARjEb4j0/bYd/22LdLj+HvII9zUuxIjGCbvU=;
 b=SRBmj/RxOfqz8oPg8EUiw1ZAgFWS4JNfdbkZGAUoYF6lqxH6Rwn7aAUFiVjspVd4fN
 CDcsF8KgBHnPbLxe3CIDhHmn+tNOO7BtwEQ1Vf8D4gVzeE3y8fDCHbVLjMNjaVz0udbI
 rh3p5gUcUCBRwrlCB+v9RmI0jiwnfJRRlpiCEOsniIwqIJfe0rerD4G24TOgbWh/s7Ec
 EEbKcMLufKX4AHBOy1j/t3eKD4u/MKREHqInqF5MrHQDjV6xQuyND5LfWOXo+TLR2rNt
 vmnH5edcg+1bFzheT1zri/omD6fhTv8mgvp+3lxOx7SaNz1ycFSAbw8+f/lUGFPdyQbo
 upUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593657; x=1739198457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdEyfb2ARjEb4j0/bYd/22LdLj+HvII9zUuxIjGCbvU=;
 b=Kz9xImlIMJE5Vmx0NK8QebKTAcZbJiK+bRF40AFzXBm4s/pWAPMV5sRaZ5Bkht+20Q
 GqzQO0dwrLv+PP1d00cqSs1p2xOvnn1w+XkkC/asqYpEjNq9re72YXyMEy6KZgT3qFuF
 CJv7sPTF7Cu3v7iXE5fizQbIsi7AtrMAxZOOBKm5vGbkZOwKyImZMm7Y45joI72yan9p
 gWZq2ap1CmYfYRiFkD3EdIGPJccELK2mZjxruienY7jzwdwFvVnsWfLhwzJg6d1D8/zd
 MPnQao7k4qlwL6AGCNF+D24NWywQT/p+5msw4SHt0QkurRFv+IZbOMBuYpBiJaCa3Ahq
 tCYg==
X-Gm-Message-State: AOJu0Yx4psWP/dU376aM1zGlHvKF48Pm92f6BUuwCGKQoisYM90GosaS
 xOQbnAjEJ5WLCDiyfhPTV2NeOez+uR0BTwUHkl7kRgdfkMaGTpZfkfV0/UbFTT8=
X-Gm-Gg: ASbGnctrBq8xs7bK+0m1FdAnmBvu1qeHgfR2umYT5o8Fdli291xplYxCDR+KWkh+iL2
 tQWcoFIJbXl0jBKFrgLIPA1VeZA2vGYGnf7v/etXfiDEcbh/uQf59wLYTq1ABm3GCWG52DCrkGA
 bhwKAMH0SPRHeAfWn2kbKcJ5NrrnN/6t1pQJNjncRrUCLRN7Eb424N1Hi76W/qSGf2LMxKGy45U
 xhV7pqLWd/NWKW86Fm55GAIV9xzzd0rNNcQLMGQ7X4q1bx7lDZJbPS0s6iCzEzTNavan0x6uvbV
 j0iw84lMbxqm7Y3wWA==
X-Google-Smtp-Source: AGHT+IGWR8d4DI0bOTpt9mK5dktCyya0EOEgqnxIxZI6WD5ySvslKGOe+hbROZIhyOtAFeq4BkoE9Q==
X-Received: by 2002:a17:907:9452:b0:ab6:f99f:45e0 with SMTP id
 a640c23a62f3a-ab6f99f5410mr1861971866b.37.1738593657466; 
 Mon, 03 Feb 2025 06:40:57 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723d0021sm7829264a12.5.2025.02.03.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 438F15FB14;
 Mon,  3 Feb 2025 14:40:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 07/18] Revert "util/timer: avoid deadlock when shutting down"
Date: Mon,  3 Feb 2025 14:40:37 +0000
Message-Id: <20250203144048.2131117-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

This reverts commit bc02be4508d8753d1f6071b77d10f4661587df6f.

Now we catch attempts to clock_step to the next timer when none are
enabled we can revert the previous attempt to prevent deadlock. As
long as a new target time is given we will move time forward even if
no timers will fire. This is desirable for tests which are checking
that nothing changes when things are disabled.

Previously most tests got away with it because --enable-slirp always
has a timer running while the test is active.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 util/qemu-timer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 0e8a453eaa..3243d2c515 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -675,17 +675,10 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
 {
     int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     AioContext *aio_context;
-    int64_t deadline;
-
     aio_context = qemu_get_aio_context();
-
-    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                          QEMU_TIMER_ATTR_ALL);
-    /*
-     * A deadline of < 0 indicates this timer is not enabled, so we
-     * won't get far trying to run it forward.
-     */
-    while (deadline >= 0 && clock < dest) {
+    while (clock < dest) {
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
         qemu_virtual_clock_set_ns(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + warp);
@@ -693,9 +686,6 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
         clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                              QEMU_TIMER_ATTR_ALL);
     }
     qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
 
-- 
2.39.5


