Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104CFCD8CBF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 02:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJjI9-00038p-Fe; Thu, 13 Nov 2025 21:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhipeng@cestc.cn>)
 id 1vJjI0-0002v1-0v; Thu, 13 Nov 2025 21:11:52 -0500
Received: from smtp-pop-umt-2.cecloud.com ([1.203.97.240]
 helo=smtp.cecloud.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luzhipeng@cestc.cn>)
 id 1vJjHx-00039r-Bx; Thu, 13 Nov 2025 21:11:51 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id 55E7C900118;
 Fri, 14 Nov 2025 10:11:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.69.245])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P506955T281463492637040S1763086293564791_; 
 Fri, 14 Nov 2025 10:11:37 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: qemu-block@nongnu.org
X-RCPT-COUNT: 6
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.69.245
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <61d4e691a1dea9824cc0d174e6c03bdf>
X-System-Flag: 0
From: luzhipeng <luzhipeng@cestc.cn>
To: qemu-block@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH] block: add single-check guard in throttle_group_restart_queue
 to address race with schedule_next_request
Date: Fri, 14 Nov 2025 10:11:09 +0800
Message-ID: <20251114021110.1464-1-luzhipeng@cestc.cn>
X-Mailer: git-send-email 2.45.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=1.203.97.240;
 envelope-from=luzhipeng@cestc.cn; helo=smtp.cecloud.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.398,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

A race condition exists between throttle_group_restart_queue() and
schedule_next_request(): when multiple ThrottleGroupMembers in the same
throttle group are assigned to different IOThreads, concurrent execution
can cause schedule_next_request() to re-arm a throttle timer while
throttle_group_restart_queue() is being called (e.g., from a timer
callback or external restart). This violates the assumption that no
timer is pending upon entry to throttle_group_restart_queue(), triggering
an assertion failure and causing QEMU to abort.

This patch replaces the assert with a single early-return check:
if the timer for the given direction is already pending, the function
returns immediately. This prevents duplicate coroutine scheduling and
avoids crashes under race conditions, without altering the core
(non-thread-safe) throttle group logic.

For details, see: https://gitlab.com/qemu-project/qemu/-/issues/3194

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
---
 block/throttle-groups.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 66fdce9a90..9dcc6b4923 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -430,15 +430,14 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
                                         ThrottleDirection direction)
 {
     Coroutine *co;
+    if (timer_pending(tgm->throttle_timers.timers[direction])) {
+        return;
+    }
     RestartData *rd = g_new0(RestartData, 1);
 
     rd->tgm = tgm;
     rd->direction = direction;
 
-    /* This function is called when a timer is fired or when
-     * throttle_group_restart_tgm() is called. Either way, there can
-     * be no timer pending on this tgm at this point */
-    assert(!timer_pending(tgm->throttle_timers.timers[direction]));
 
     qatomic_inc(&tgm->restart_pending);
 
-- 
2.31.1




