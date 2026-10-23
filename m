Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BF606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlN-00032a-Tn; Fri, 23 Oct 2026 15:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKky-0002wy-Td
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:54 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkw-0001zu-55
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:48 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkk-00000007BEQ-3sMo; Fri, 23 Oct 2026 21:16:34 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 01/13] runstate: Rename VM change state handlers "priority"
 to "depth"
Date: Fri, 23 Oct 2026 21:16:12 +0200
Message-ID: <1eac2289128bda1df0e8fde970c11c7231b1d052.1792758435.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This frees the term "priority" for implementing an explicit multi-level
priority system of these handlers instead of the current two-level implicit
prepare_cb() vs cb() system.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/system/runstate.h | 12 ++++++------
 system/runstate.c         | 14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index 929379adae41..cceb88d2e3b0 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -30,8 +30,8 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
  * qemu_add_vm_change_state_handler_prio:
  * @cb: the callback to invoke
  * @opaque: user data passed to the callback
- * @priority: low priorities execute first when the vm runs and the reverse is
- *            true when the vm stops
+ * @depth: low depths execute first when the vm runs and the reverse is true
+ *         when the vm stops
  *
  * Register a callback function that is invoked when the vm starts or stops
  * running.
@@ -39,7 +39,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
  * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
  */
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-        VMChangeStateHandler *cb, void *opaque, int priority);
+        VMChangeStateHandler *cb, void *opaque, int depth);
 VMChangeStateEntry *
 /**
  * qemu_add_vm_change_state_handler_prio_full:
@@ -47,8 +47,8 @@ VMChangeStateEntry *
  * @prepare_cb: a callback to invoke before the main callback
  * @cb_ret: the main callback to invoke with return value
  * @opaque: user data passed to the callbacks
- * @priority: low priorities execute first when the vm runs and the reverse is
- *            true when the vm stops
+ * @depth: low depths execute first when the vm runs and the reverse is true
+ *         when the vm stops
  *
  * Register a main callback function and an optional prepare callback function
  * that are invoked when the vm starts or stops running. The main callback and
@@ -62,7 +62,7 @@ VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
                                            VMChangeStateHandlerWithRet *cb_ret,
-                                           void *opaque, int priority);
+                                           void *opaque, int depth);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      VMChangeStateHandlerWithRet *cb_ret,
diff --git a/system/runstate.c b/system/runstate.c
index 56bfc5b07da9..60eba9a63e93 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -304,24 +304,24 @@ struct VMChangeStateEntry {
     VMChangeStateHandlerWithRet *cb_ret;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
-    int priority;
+    int depth;
 };
 
 static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
     QTAILQ_HEAD_INITIALIZER(vm_change_state_head);
 
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-        VMChangeStateHandler *cb, void *opaque, int priority)
+        VMChangeStateHandler *cb, void *opaque, int depth)
 {
     return qemu_add_vm_change_state_handler_prio_full(cb, NULL, NULL,
-                                                      opaque, priority);
+                                                      opaque, depth);
 }
 
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
                                            VMChangeStateHandlerWithRet *cb_ret,
-                                           void *opaque, int priority)
+                                           void *opaque, int depth)
 {
     VMChangeStateEntry *e;
     VMChangeStateEntry *other;
@@ -331,11 +331,11 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
     e->prepare_cb = prepare_cb;
     e->cb_ret = cb_ret;
     e->opaque = opaque;
-    e->priority = priority;
+    e->depth = depth;
 
-    /* Keep list sorted in ascending priority order */
+    /* Keep list sorted in ascending depth order */
     QTAILQ_FOREACH(other, &vm_change_state_head, entries) {
-        if (priority < other->priority) {
+        if (depth < other->depth) {
             QTAILQ_INSERT_BEFORE(other, e, entries);
             return e;
         }

