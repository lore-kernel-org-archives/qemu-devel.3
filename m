Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA24E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaUf-0000Cd-L7; Fri, 20 Dec 2024 05:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUd-0008VK-Eq; Fri, 20 Dec 2024 05:44:27 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUa-0005SS-R3; Fri, 20 Dec 2024 05:44:27 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163dc5155fso15854415ad.0; 
 Fri, 20 Dec 2024 02:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691462; x=1735296262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wu+GL4+vvCQpuAOpV7VcZuV6PKMa6EXzctMojFuS3jU=;
 b=g8nmJoopduObIxSCzsD1/+ag+d1xNQlQj9VY16XOOSqu5uPa2g3CgUXAAVSRvKtNmH
 DqJ4kG/rDNm+InpiSHqGKktpvzNy0EU/sWgghJ48j9D2bqfxGT5/rzs48mNWPetI2HHM
 0Z7l/VuLb3/npq+3v6R5FfqePX8cSJz/QuNqfOfbrW0XssNmbN3JTpFobnPdOZ9ikwyE
 33SJke5ZkjdbxzKVywdp817SzKNqHIW8EkjdAdbCvQaiM6PmQJSJrMdt1eyoCKP2QV23
 MGm20yDEh6lR9le0w0nKg46ItBHrsv6MXnypNihUHAc+Pa3cHuzivulSRdA9TLhGcVJc
 yR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691462; x=1735296262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wu+GL4+vvCQpuAOpV7VcZuV6PKMa6EXzctMojFuS3jU=;
 b=p+3DnTFC0c+6G4O/f4SYCqoCEZYU3IMNmFxDxkGyLi2vtHGpXt2b7VX+pKMnjqR+4R
 mcDvSHLIFLx6IRr/6Vm3LycxDdJHCI4/mSUYwDwJjKOLiawooAdSEYHxE8hBcPyRsYgf
 FuG1LHwEnFOmLR1AmT4N7ILYD3g5ON8YrgEjVm5KrI9cOdtAF1vcvpRGETBAi1lDhPhc
 pYZRLT/cl5Vy+7qh0L3FD5z38S29hlMESOU2iXr3mjvhtZGWV4kzK3JBSt9Kk7NPNWpr
 a7reB4tkuU/0m98i7ykan6zypJjjG6r4fEhvwZ9ulqPB5aCmkoOdQ9r7TEhTEeIHddpp
 F94g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoy4EloHvCbLiu8E46LU3g1QzBuok0nTgARK2o87gi1OinEJ1dJKak6P3MfTtHiDjtXImxl4Ki4WOi@nongnu.org
X-Gm-Message-State: AOJu0YxubPC7pfiejFxK4YEd4pjMythhLGgJWEuMnNWsOCU39cYXScAR
 qU63FQINAJPGgZdEosrJjK1rFJ0AJm1Lxfr/2PlTUloY4N8MKuCXffucug==
X-Gm-Gg: ASbGnctO4+TWsi6mlwKTp5Q57dt842qm8Bzl34RCYw4ktg+CK7zXd0xBF1JzAZPm/iB
 YIYNMPQhG+KhCudmYkdpglWYdIJPi+H8wM7uldSels0BxFXUW2AXcrcoW6oMCLrukP9PsBN/HDY
 CCoXxleBIbUzks42BBzxEvXk2oBdnFZ2osZbjdX/VHkjrMBVX6HUg/nm05hLI/EB4SIQabGFhJI
 kuyMgFwVc0OVl3Zhek/nc7fAxTM5h3jmF6E3++QvyIcFb+PwLW2g8f2Di2ALuPWsKU8SQFsopti
 krAHOjIkiw==
X-Google-Smtp-Source: AGHT+IH8c/AWBwB0fOu47PM6NedBBLoYnyCAzWnEUS+m31wqpGtz3tPAybi9eDUQLAzIWKxjcC8uuw==
X-Received: by 2002:a17:90b:53c5:b0:2ee:74a1:fb92 with SMTP id
 98e67ed59e1d1-2f452dfd236mr3611190a91.6.1734691462603; 
 Fri, 20 Dec 2024 02:44:22 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:44:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 14/17] async: add debugging assertions for record/replay in bh
 APIs
Date: Fri, 20 Dec 2024 20:42:16 +1000
Message-ID: <20241220104220.2007786-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

Code using old bh APIs must be updated to account for whether the
bh is related to the target machine model or host QEMU operation,
in order for record/replay to work properly.

Add some assertions in the old APIs to catch unconverted code when
record/replay is active.

This caught the IDE bug when running replay_linux.py avocado test
with the x86-64 q35 non-virtio machine.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/block/aio.h    |  2 +-
 replay/replay-events.c | 20 ++++++++------------
 util/async.c           | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 26859bd0b93..991aaae707d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -309,7 +309,7 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
  */
 #define aio_bh_schedule_oneshot(ctx, cb, opaque) \
     aio_bh_schedule_oneshot_full((ctx), (cb), (opaque), (stringify(cb)), \
-                                 QEMU_CLOCK_REALTIME)
+                                 QEMU_CLOCK_MAX)
 
 /**
  * aio_bh_new_full: Allocate a new bottom half structure.
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 6a7c27cac1e..0b3dbfd46b9 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -123,23 +123,19 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 
 void replay_bh_schedule_event(QEMUBH *bh)
 {
-    if (events_enabled) {
-        uint64_t id = replay_get_current_icount();
-        replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
-    } else {
-        qemu_bh_schedule(bh);
-    }
+    uint64_t id;
+    g_assert(events_enabled);
+    id = replay_get_current_icount();
+    replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
 }
 
 void replay_bh_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque)
 {
-    if (events_enabled) {
-        uint64_t id = replay_get_current_icount();
-        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
-    } else {
-        aio_bh_schedule_oneshot(ctx, cb, opaque);
-    }
+    uint64_t id;
+    g_assert(events_enabled);
+    id = replay_get_current_icount();
+    replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
 }
 
 void replay_add_input_event(struct InputEvent *event)
diff --git a/util/async.c b/util/async.c
index 5d2c76dec08..72a9eccffbe 100644
--- a/util/async.c
+++ b/util/async.c
@@ -58,6 +58,9 @@ enum {
 
     /* Schedule periodically when the event loop is idle */
     BH_IDLE      = (1 << 4),
+
+    /* BH being handled by replay machinery */
+    BH_REPLAY    = (1 << 4),
 };
 
 struct QEMUBH {
@@ -145,6 +148,17 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
                                   void *opaque, const char *name,
                                   QEMUClockType clock_type)
 {
+    if (clock_type == QEMU_CLOCK_MAX) {
+        /*
+         * aio_bh_schedule_oneshot() uses QEMU_CLOCK_MAX to say it does not
+         * know about clock context to use. It will not work in record/replay.
+         * Callers should be converted to aio_bh_schedule_oneshot_event()
+         * then this can be removed when the old API goes away.
+         */
+        g_assert(replay_mode == REPLAY_MODE_NONE);
+        clock_type = QEMU_CLOCK_REALTIME;
+    }
+
     switch (clock_type) {
     case QEMU_CLOCK_VIRTUAL:
     case QEMU_CLOCK_VIRTUAL_RT:
@@ -178,6 +192,12 @@ void aio_bh_call(QEMUBH *bh)
 {
     bool last_engaged_in_io = false;
 
+    if (bh->flags & BH_REPLAY) {
+        g_assert(!(bh->flags & BH_SCHEDULED));
+        g_assert(!(bh->flags & BH_DELETED));
+        g_assert(!(bh->flags & BH_PENDING));
+        bh->flags &= ~BH_REPLAY;
+    }
     /* Make a copy of the guard-pointer as cb may free the bh */
     MemReentrancyGuard *reentrancy_guard = bh->reentrancy_guard;
     if (reentrancy_guard) {
@@ -252,6 +272,7 @@ void qemu_bh_schedule_event(QEMUBH *bh, QEMUClockType clock_type)
     case QEMU_CLOCK_VIRTUAL_RT:
         if (replay_mode != REPLAY_MODE_NONE) {
             /* Record/replay must intercept bh events */
+            qatomic_fetch_or(&bh->flags, BH_REPLAY);
             replay_bh_schedule_event(bh);
             break;
         }
@@ -268,11 +289,15 @@ void qemu_bh_schedule_event_noreplay(QEMUBH *bh)
 
 void qemu_bh_schedule_idle(QEMUBH *bh)
 {
+    /* No mechanism for scheduling idle replay-scheduled bh at the moment */
+    g_assert(replay_mode == REPLAY_MODE_NONE);
     aio_bh_enqueue(bh, BH_SCHEDULED | BH_IDLE);
 }
 
 void qemu_bh_schedule(QEMUBH *bh)
 {
+    /* Callers should be converted to use qemu_bh_schedule_event */
+    g_assert(replay_mode == REPLAY_MODE_NONE);
     aio_bh_enqueue(bh, BH_SCHEDULED);
 }
 
@@ -280,6 +305,8 @@ void qemu_bh_schedule(QEMUBH *bh)
  */
 void qemu_bh_cancel(QEMUBH *bh)
 {
+    /* No mechanism for canceling replay-scheduled bh at the moment */
+    g_assert(!(bh->flags & BH_REPLAY));
     qatomic_and(&bh->flags, ~BH_SCHEDULED);
 }
 
@@ -288,6 +315,8 @@ void qemu_bh_cancel(QEMUBH *bh)
  */
 void qemu_bh_delete(QEMUBH *bh)
 {
+    /* No mechanism for deleting replay-scheduled bh at the moment */
+    g_assert(!(bh->flags & BH_REPLAY));
     aio_bh_enqueue(bh, BH_DELETED);
 }
 
-- 
2.45.2


