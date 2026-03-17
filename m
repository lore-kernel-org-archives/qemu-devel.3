Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131DDFD8773
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ujy-0007nV-CM; Tue, 17 Mar 2026 09:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Ujv-0007lN-JX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Ujq-0002Ao-8J
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773755137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Pn5XlEm9Bn7b0QdwUqHqGL4YyqtI7Hz3+MDuG/pbFk=;
 b=BBCLsqW5lKtF+tq9MyHNjPIzMrkHcefaIA5pXGIVAJr7fzXbYrwQmPGEcv3eDlNBrmE4ce
 g0lEkQ02869ZFQUVywF6DvloTsB66sHEBXDx+76qSNJLcW8TAS7etWk9n1J6Ok7UOvyEFd
 ymvB9lUyaaAqLcWxN1XeiCpmnhZu9vM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-6xWL_jTrNPOzRVW6g8Xqag-1; Tue, 17 Mar 2026 09:45:36 -0400
X-MC-Unique: 6xWL_jTrNPOzRVW6g8Xqag-1
X-Mimecast-MFC-AGG-ID: 6xWL_jTrNPOzRVW6g8Xqag_1773755135
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4868e691614so4222475e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773755134; x=1774359934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Pn5XlEm9Bn7b0QdwUqHqGL4YyqtI7Hz3+MDuG/pbFk=;
 b=a1ZqqYJrpv4YpQYf/6QVVqFohf5+yusoBeTy3V7AQyXwZNXB09ABNnB8iUQfnZ/Q22
 PTuzrjN9EIWzxojtUftlM71dmqPFMWEvtnrql4bR78SRnKwj/80otz8pd8mpXVbj54yN
 C+rlc6FRs67wC8Ys3EjoEVQz5gnvtSxFGNxIFV/VB7EOMn3LRqjR1J1zDOYDOKlsLTpJ
 lwsYEPT+ZlpYkhpSrQTTBzsgZS6l7yADKMDPi8Ckb0/pbROFtw9qYA7yniJzM9BqaXQS
 TGoEY9dPWoTroJg8+seg79fzjOu8XvrUw9tPJkzphrFR3FuxF5IVRXPHn/831ogFMjxW
 QkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773755134; x=1774359934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Pn5XlEm9Bn7b0QdwUqHqGL4YyqtI7Hz3+MDuG/pbFk=;
 b=IlFG/wTQOyfDqfmmCC3QXAjVn76vZ0euN7nhDFoI+VB8Z3OLMtdMMEuq/YXVhBQqS/
 DRxfl1/UpGKFMcphJXvh39s61Jv58yVWidpS7MxTjSBltw0Glg1y0VbE4pfDAPlxfhrN
 sPBB28Ccb0a5FM1mmqwSXGFktoaPxPRKulQVBJLNnrarbBD2oOA0kOc5E6DSLpS8vD2J
 +LNGNC7WiwZ/CguNiFjgKT3RiYPl2h2ut3NxawlKPODiZWhpAqJPiGZF8ZUIR4eh9EAg
 /veaWqzvWJLJcLvPs2ehAD0uHNFUqZF7sMuNTAH/pWV8KRn1W/2W4E2dPHfxvFWLw+HN
 Oicw==
X-Gm-Message-State: AOJu0YyddZvMeq5ex69QS7tDmVMo5uUE9eaPkkJG6FhhWJfFD/gnOwIs
 oOhohP//cZALLoNNlgwaXZ0otkaqlMhhYH1WS/P0kN9hZZPOLDctncumd5wstmAY+IsAjTnTOjb
 bKM+PuCqQ4d8fXKuysFsdNx6Br5kyY9K8X1ARyVYsXA8l7HGUaN8LMZM4
X-Gm-Gg: ATEYQzz1p6xxCflm/MuOMA9WYVWSmiGOlnwHeqbcrOHjMwm28bijognGn7jsV8Sl53e
 sSupnL4vIGx3hib09/qwTeaaWfQ6HaExnpAFHTFzUUt0sGukh9HB65q+5aJe1vgzZappNVgaS89
 +DXkTfQKBuYXehT6pzNhu/wqphFwbdQKMheqcZk4S+pIJP89cMqj/rDqbDcvdOM5Xen4P7uULw1
 Fvq8I3unUKvLE8UDQ9gOSvWzJu0KvNToxev0ujb6aXyAjKVhmzg4jzxL9UC8ET9ul2Cm8NWGEer
 SE7BLrVpL0HNSoAoYArx6XN+nSKwEGK1UfrQ2UJWvRKaQ7eUSVugMFvpsBswXGD2xyGRPZGPIKI
 fGEJ05H7WrYb77pqtC51rIWehI/WvbG/8PF6TvtD4738JiEZ1knrbhw/4l1VIn+ywQD7QiikfCl
 zwi6U=
X-Received: by 2002:a05:600c:46d2:b0:485:3c66:e230 with SMTP id
 5b1f17b1804b1-48556728c71mr290417585e9.29.1773755134478; 
 Tue, 17 Mar 2026 06:45:34 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:3c66:e230 with SMTP id
 5b1f17b1804b1-48556728c71mr290417035e9.29.1773755133889; 
 Tue, 17 Mar 2026 06:45:33 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0a83481d97604204561.dip0.t-ipconnect.de.
 [2003:cf:d737:d0a8:3481:d976:420:4561])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43a03cfd18fsm40701746f8f.36.2026.03.17.06.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:45:33 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 1/2] throttle-group: Fix race condition in
 throttle_group_restart_queue()
Date: Tue, 17 Mar 2026 14:45:20 +0100
Message-ID: <20260317134521.112121-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317134521.112121-1-hreitz@redhat.com>
References: <20260317134521.112121-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alberto Garcia <berto@igalia.com>

When a timer is fired a pending I/O request is restarted and
tg->any_timer_armed is reset so other requests can be scheduled.

However we're resetting any_timer_armed first in timer_cb() before
the request is actually restarted, and there's a window between both
moments in which another thread can arm the same timer, hitting an
assertion in throttle_group_restart_queue().

This can be solved by deferring the reset of tg->any_timer_armed to
the moment when the queue is actually restarted, which is protected by
tg->lock, preventing other threads from arming the timer before that.

In addition to that, throttle_group_restart_tgm() is also updated to
hold tg->lock while the timer is being inspected. Here we consider
three different scenarios:

- If the tgm has a timer set, fire it immediately
- If another tgm has a timer set, restart the queue anyway
- If there is no timer set in this group then simulate a timer that
  fires immediately, by setting tg->any_timer_armed in order to
  prevent other threads from arming a timer in the meantime.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3194
Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <825598ef34ad384d936da19d634eda75598508f7.1773316842.git.berto@igalia.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/throttle-groups.c | 79 +++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 19 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 5329ff1fdb..4b1b1944c2 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -391,6 +391,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
 typedef struct {
     ThrottleGroupMember *tgm;
     ThrottleDirection direction;
+    bool reset_timer_armed;
 } RestartData;
 
 static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
@@ -403,6 +404,9 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
     bool empty_queue;
 
     qemu_mutex_lock(&tg->lock);
+    if (data->reset_timer_armed) {
+        tg->any_timer_armed[direction] = false;
+    }
     empty_queue = !throttle_group_co_restart_queue(tgm, direction);
 
     /* If the request queue was empty then we have to take care of
@@ -419,18 +423,23 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
 }
 
 static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
-                                        ThrottleDirection direction)
+                                         ThrottleDirection direction,
+                                         bool reset_timer_armed)
 {
     Coroutine *co;
     RestartData *rd = g_new0(RestartData, 1);
 
     rd->tgm = tgm;
     rd->direction = direction;
+    rd->reset_timer_armed = reset_timer_armed;
 
-    /* This function is called when a timer is fired or when
-     * throttle_group_restart_tgm() is called. Either way, there can
+    /* If reset_timer_armed is set then this means that this function
+     * was called when a timer was fired (either from timer_cb() or
+     * from throttle_group_restart_tgm()). In this case there can
      * be no timer pending on this tgm at this point */
-    assert(!timer_pending(tgm->throttle_timers.timers[direction]));
+    if (reset_timer_armed) {
+        assert(!timer_pending(tgm->throttle_timers.timers[direction]));
+    }
 
     qatomic_inc(&tgm->restart_pending);
 
@@ -444,15 +453,50 @@ void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 
     if (tgm->throttle_state) {
         for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
-            QEMUTimer *t = tgm->throttle_timers.timers[dir];
+            QEMUTimer *t;
+            ThrottleState *ts = tgm->throttle_state;
+            ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
+            bool reset_timer_armed;
+
+            /*
+             * This function restarts the tgm's queue immediately.
+             * This is used for example for callers to drain all requests.
+             * There are three different scenarios depending on whether
+             * a timer is armed for this tg and which tgm owns the timer.
+             */
+
+            qemu_mutex_lock(&tg->lock);
+
+            t = tgm->throttle_timers.timers[dir];
             if (timer_pending(t)) {
-                /* If there's a pending timer on this tgm, fire it now */
+                /*
+                 * Case 1: this tgm has a pending timer.
+                 * We can fire the timer immediately.
+                 */
                 timer_del(t);
-                timer_cb(tgm, dir);
+                reset_timer_armed = true;
+            } else if (tg->any_timer_armed[dir]) {
+                /*
+                 * Case 2: another tgm has a pending timer.
+                 * In this case we can still restart the queue but we
+                 * have to leave any_timer_armed untouched so the
+                 * other tgm's timer is not disrupted.
+                 */
+                reset_timer_armed = false;
             } else {
-                /* Else run the next request from the queue manually */
-                throttle_group_restart_queue(tgm, dir);
+                /*
+                 * Case 3: there is no timer set for this group.
+                 * Here we can simulate a timer that fires immediately,
+                 * so the queue is restarted but no other thread
+                 * can arm a timer in the meantime.
+                 */
+                tg->any_timer_armed[dir] = true;
+                reset_timer_armed = true;
             }
+
+            qemu_mutex_unlock(&tg->lock);
+
+            throttle_group_restart_queue(tgm, dir, reset_timer_armed);
         }
     }
 }
@@ -499,16 +543,13 @@ void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
  */
 static void timer_cb(ThrottleGroupMember *tgm, ThrottleDirection direction)
 {
-    ThrottleState *ts = tgm->throttle_state;
-    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
-
-    /* The timer has just been fired, so we can update the flag */
-    qemu_mutex_lock(&tg->lock);
-    tg->any_timer_armed[direction] = false;
-    qemu_mutex_unlock(&tg->lock);
-
-    /* Run the request that was waiting for this timer */
-    throttle_group_restart_queue(tgm, direction);
+    /*
+     * Run the request that was waiting for this timer.
+     * tg->any_timer_armed needs to be cleared, but we'll do it later
+     * when the queue is restarted in order to prevent another thread
+     * from arming the timer before that.
+     */
+    throttle_group_restart_queue(tgm, direction, true);
 }
 
 static void read_timer_cb(void *opaque)
-- 
2.53.0


