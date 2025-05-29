Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A4FC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW6M-000377-Ig; Thu, 29 May 2025 01:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW67-00032a-NP
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:36 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW66-0003DZ-1R
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:35 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-310cf8f7301so434180a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497592; x=1749102392;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4oYy3DOZjN8AesbwD4Qmt0S6RXrih5MYv8h9FL1wh/k=;
 b=kwsUH6zxLqllAsVU+4J8Hum4ZmYfajZH8M6YfE3Rj4yVcaR5X/Q9irllro68QUdaCt
 BG+K4R9y3jTot+i2JigcuTFqesjhzgdxg4TDVLwQEzCFIm9+SJFMSrORczzj4+o5BBgB
 11xhfT51QZX6X9IinvAxo4gygXAIoru9SyVXMU58KQbT7lsoTC3yCSB76kPTvesf8bP/
 HqYSdL/4nAdAktyEfPn9zBNGanY4WQDEH5uF9gtgYZRgV04XEiWke6nkbDjo6X4+Oq3u
 SoXlDMkVzczeHWuia0ulp5i1H1pBusUJaDmR6RV3Nih3WevCLVzeaQF8Baurl11BzyJh
 eXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497592; x=1749102392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4oYy3DOZjN8AesbwD4Qmt0S6RXrih5MYv8h9FL1wh/k=;
 b=FnuBTfyow8OAHoXJyhzMKfD+TwZtS6Qy0QlGHJ8oMb0GnWRb6ZWY5MdXt3es6YnE0y
 eIP8nuq6wWcgQHMoPCrz3IeOe8W8h5TAaCJ3eTShLPSWEw/cbSJuTqYiV3WU30t/krao
 INySEpjVGofvJb6/e4KAn1OMekkCWuv524Q1WJOzencVQEJakTRllZiN9AcCXxDGJ/Q4
 T1V4RzgZkbZIOKwznCjye9t1TypA5uPe0B+TmJ9xyPJk9320+J2Yq7ebbOMknncjrRZs
 NWZsoYaNHhh05Ai3ip00YsXBtCwUjKKg+KanEe6y2DFxPKww9nq1LVitVuhbDS+g/piB
 rYxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ5n0BnqC70sItEJXSaFaxNE6/4iDQhO0X+gIYUupHPS3v4u1kN4YWvbnDIsYOJHklsDhexBDUwYOS@nongnu.org
X-Gm-Message-State: AOJu0Yxh6Hv3nUJva7RU3kK8GAErb8u+wq11b2rSY769PO3FDmcbXiQc
 XMEFdQGNqSFpt7AtQzXJwZN93BFfHPbvP83e/bPUoFysi43JKL084oFj0unkcz9rLqc=
X-Gm-Gg: ASbGncv3+yIy3z48K9DUxZt7mzjt6rzUw2LuqgizMAgcShlLLEK3UfLfsFlS7iVr3ew
 A3SOrc61WNkkB0+4A78J9VPqprOGlYgOfCoPN0daX0qRcKTEvd2EDRpKGkmLhBE2xmSRNhcFhZm
 v2i18gJpO5xmy1WmQjra/Gml9qYoABom0w2abAisJdrlhWeE3HyHdwieOlFfED9aozvalAXbIXr
 CSB39KQm7ILrzjcUnJjhYKqBS4W52xcfdx97D+xHKpsaLbTSwg+8aYjeFtx4p7SO64XejljXUiX
 xbU5TXi1Zum2RfP9kkKgEjh0Hc4tUCEj+UMGUnfGAvgEQCOd/NxK
X-Google-Smtp-Source: AGHT+IGZS1Djwi1muVSMCzzXzHtan1LTG34n7CPjasQ1v1pzl9wt4AohuU+iZDGyux27r+rvRYTV+A==
X-Received: by 2002:a17:90b:264c:b0:311:1617:5bc4 with SMTP id
 98e67ed59e1d1-31214ecdacamr3276778a91.12.1748497592618; 
 Wed, 28 May 2025 22:46:32 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3121b202763sm602184a91.0.2025.05.28.22.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:46:00 +0900
Subject: [PATCH v5 11/13] qemu-thread: Remove qatomic_read() in
 qemu_event_set()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-event-v5-11-53b285203794@daynix.com>
References: <20250529-event-v5-0-53b285203794@daynix.com>
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The pair of smp_mb() and qatomic_read() sometimes allows skipping the
following qatomic_xchg() call, but it is unclear if it improves
performance so remove it.

Commit 374293ca6fb0 ("qemu-thread: use acquire/release to clarify
semantics of QemuEvent") replaced atomic_mb_read() in qemu_event_set()
with a pair of smp_mb() and atomic_read(). atomic_mb_read() was actually
cheaper than atomic_xchg(). include/qemu/atomic.h at that time had the
following comment:
/* atomic_mb_read/set semantics map Java volatile variables. They are
 * less expensive on some platforms (notably POWER & ARMv7) than fully
 * sequentially consistent operations.
 *
 * As long as they are used as paired operations they are safe to
 * use. See docs/atomic.txt for more discussion.
 */

However, smp_mb() enforces full sequential consistency, so we cannot
use the same reasoning to claim that the pair of it and qatomic_read()
is cheaper than qatomic_xchg(). Therefore remove the pair and simplify
the code instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/event.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/util/event.c b/util/event.c
index e937804a92a8..df6d60836041 100644
--- a/util/event.c
+++ b/util/event.c
@@ -55,18 +55,9 @@ void qemu_event_set(QemuEvent *ev)
     assert(ev->initialized);
 
 #ifdef HAVE_FUTEX
-    /*
-     * Pairs with both qemu_event_reset() and qemu_event_wait().
-     *
-     * qemu_event_set has release semantics, but because it *loads*
-     * ev->value we need a full memory barrier here.
-     */
-    smp_mb();
-    if (qatomic_read(&ev->value) != EV_SET) {
-        if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
-            /* There were waiters, wake them up.  */
-            qemu_futex_wake_all(ev);
-        }
+    if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
+        /* There were waiters, wake them up.  */
+        qemu_futex_wake_all(ev);
     }
 #else
     pthread_mutex_lock(&ev->lock);
@@ -88,7 +79,7 @@ void qemu_event_reset(QemuEvent *ev)
 
     /*
      * Order reset before checking the condition in the caller.
-     * Pairs with the first memory barrier in qemu_event_set().
+     * Pairs with the store-release in qemu_event_set().
      */
     smp_mb__after_rmw();
 }
@@ -102,7 +93,7 @@ void qemu_event_wait(QemuEvent *ev)
         /*
          * qemu_event_wait must synchronize with qemu_event_set even if it does
          * not go down the slow path, so this load-acquire is needed that
-         * synchronizes with the first memory barrier in qemu_event_set().
+         * synchronizes with the store-release in qemu_event_set().
          */
         unsigned value = qatomic_load_acquire(&ev->value);
         if (value == EV_SET) {

-- 
2.49.0


