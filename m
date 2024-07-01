Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75282C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGw0-0000IA-Dc; Mon, 01 Jul 2024 09:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvr-0000Bo-PO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:19:01 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvc-0007ug-SU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=eLWf5lVhYi1sa2TPFSGa67dLAt0BU3i5V6yFCd2EQj4=; b=FF6yf+d7ftRuksNEJETH6r6XxR
 18UPO4LdR/fiIH07sq1YK7VyvXxW1PqKFLUZ3gF7EJUVjSDu9oUkoi8H+oZb8h+ceoDiRsbbT0Qtp
 rjxs5rDhDq48QnAhJ8T/hGGBeP+v7O1p0LjEhpeyIFbwN98noTx8HLpRbjTgAzfFhDeI=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGvb-0006no-FK; Mon, 01 Jul 2024 13:18:43 +0000
Received: from lfbn-lyo-1-451-148.w2-7.abo.wanadoo.fr ([2.7.43.148]
 helo=l14.home) by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGvb-0000WF-6O; Mon, 01 Jul 2024 13:18:43 +0000
From: anthony@xenproject.org
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PULL 3/3] xen-hvm: Avoid livelock while handling buffered ioreqs
Date: Mon,  1 Jul 2024 15:18:33 +0200
Message-Id: <20240701131833.29486-4-anthony@xenproject.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701131833.29486-1-anthony@xenproject.org>
References: <20240701131833.29486-1-anthony@xenproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

A malicious or buggy guest may generated buffered ioreqs faster than
QEMU can process them in handle_buffered_iopage(). The result is a
livelock - QEMU continuously processes ioreqs on the main thread without
iterating through the main loop which prevents handling other events,
processing timers, etc. Without QEMU handling other events, it often
results in the guest becoming unsable and makes it difficult to stop the
source of buffered ioreqs.

To avoid this, if we process a full page of buffered ioreqs, stop and
reschedule an immediate timer to continue processing them. This lets
QEMU go back to the main loop and catch up.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
Signed-off-by: Anthony PERARD <anthony@xenproject.org>
---
 hw/xen/xen-hvm-common.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index b8ace1c368..3a9d6f981b 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -475,11 +475,11 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
     }
 }
 
-static bool handle_buffered_iopage(XenIOState *state)
+static unsigned int handle_buffered_iopage(XenIOState *state)
 {
     buffered_iopage_t *buf_page = state->buffered_io_page;
     buf_ioreq_t *buf_req = NULL;
-    bool handled_ioreq = false;
+    unsigned int handled = 0;
     ioreq_t req;
     int qw;
 
@@ -492,7 +492,7 @@ static bool handle_buffered_iopage(XenIOState *state)
     req.count = 1;
     req.dir = IOREQ_WRITE;
 
-    for (;;) {
+    do {
         uint32_t rdptr = buf_page->read_pointer, wrptr;
 
         xen_rmb();
@@ -533,22 +533,30 @@ static bool handle_buffered_iopage(XenIOState *state)
         assert(!req.data_is_ptr);
 
         qatomic_add(&buf_page->read_pointer, qw + 1);
-        handled_ioreq = true;
-    }
+        handled += qw + 1;
+    } while (handled < IOREQ_BUFFER_SLOT_NUM);
 
-    return handled_ioreq;
+    return handled;
 }
 
 static void handle_buffered_io(void *opaque)
 {
+    unsigned int handled;
     XenIOState *state = opaque;
 
-    if (handle_buffered_iopage(state)) {
+    handled = handle_buffered_iopage(state);
+    if (handled >= IOREQ_BUFFER_SLOT_NUM) {
+        /* We handled a full page of ioreqs. Schedule a timer to continue
+         * processing while giving other stuff a chance to run.
+         */
         timer_mod(state->buffered_io_timer,
-                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
-    } else {
+                qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
+    } else if (handled == 0) {
         timer_del(state->buffered_io_timer);
         qemu_xen_evtchn_unmask(state->xce_handle, state->bufioreq_local_port);
+    } else {
+        timer_mod(state->buffered_io_timer,
+                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
     }
 }
 
-- 
Anthony PERARD


