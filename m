Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF08104C00E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0HEl-00063x-8s; Wed, 11 Mar 2026 06:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0HEd-00063A-Rq; Wed, 11 Mar 2026 06:56:15 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0HEc-0002cv-31; Wed, 11 Mar 2026 06:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tw606xktnlQonOQ+Q59DMuzF29CovcBCRJO7VC+zYm0=; b=qMU8110EGLevmpNxDj9+/6e+Z/
 DY/v4PNEX2eWxqCGwbDgxvNP05dwXrAIkGdSUeXrM/mi4STN3maQz+XQwioufvvn5es8nRdfhL79A
 3snibmQAt270YL+tGwQsQUmqHR15oZV2gny9muHgXPvYZE1+I5E02j8ymowofMZ4LxBq8XyekTiX5
 mRedyjDknMbptESLC4GF5v+eiA6vkPYJAaslrQPpaHsekJf8rmyeGUmXLkEacHg6pLkj0Xq0dRDhd
 BMnM32pHYSBn0Kso81MIhABb3teSGhSBCjqG+zU3ahM2PBzFd4VLnpw8nlSTO4bgco4RILBZ/+LQ7
 dqqey4Tw==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0HEZ-00DR9Y-DP; Wed, 11 Mar 2026 11:56:11 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1w0HEZ-000000008t1-18Om;
 Wed, 11 Mar 2026 11:56:11 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>,
 Jorge Merlino <jorge.merlino@canonical.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH 1/1] throttle-group: Fix race condition in
 throttle_group_restart_queue()
Date: Wed, 11 Mar 2026 11:55:45 +0100
Message-ID: <c367d19a5c5a8f47b4137f7fb269eb47db6f7669.1773226379.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773226379.git.berto@igalia.com>
References: <cover.1773226379.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When a timer is fired a pending I/O request is restarted and
tg->any_timer_armed is reset so other requests can be scheduled.

However we're resetting any_timer_armed first in timer_cb() before
the request is actually restarted, and there's a window between both
moments in which another thread can arm the same timer, hitting an
assertion in throttle_group_restart_queue().

This can be solved by deferring the reset of tg->any_timer_armed to
the moment when the queue is actually restarted, which is protected by
tg->lock, preventing other threads from arming the timer before that.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3194
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/throttle-groups.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 5329ff1fdb..b3bfee5b76 100644
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
@@ -419,13 +423,15 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
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
 
     /* This function is called when a timer is fired or when
      * throttle_group_restart_tgm() is called. Either way, there can
@@ -451,7 +457,7 @@ void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
                 timer_cb(tgm, dir);
             } else {
                 /* Else run the next request from the queue manually */
-                throttle_group_restart_queue(tgm, dir);
+                throttle_group_restart_queue(tgm, dir, false);
             }
         }
     }
@@ -499,16 +505,13 @@ void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
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
2.47.3


