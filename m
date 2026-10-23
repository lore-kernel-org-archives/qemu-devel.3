Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlh-00037v-KB; Fri, 23 Oct 2026 15:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKla-00037E-25
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:26 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlY-000267-5R
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:25 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlV-00000007BGA-00ii; Fri, 23 Oct 2026 21:17:21 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 10/13] net: Split VM state change handler into start and
 stop parts
Date: Fri, 23 Oct 2026 21:16:21 +0200
Message-ID: <6cd059494816e5553620b3bee99b6a422b47d098.1792758436.git.maciej.szmigiero@oracle.com>
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

This will allow moving the VM stop part of this handler into
VM_CHANGE_STATE_PRI_HIGH.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 net/net.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/net/net.c b/net/net.c
index d7fa637ce51a..9fc62e19b36e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -64,7 +64,8 @@
 # define CONFIG_NET_BRIDGE
 #endif
 
-static VMChangeStateEntry *net_change_state_entry;
+static VMChangeStateEntry *net_change_state_start_entry;
+static VMChangeStateEntry *net_change_state_stop_entry;
 NetClientStateList net_clients;
 
 typedef struct NetdevQueueEntry {
@@ -1729,27 +1730,43 @@ void qmp_set_link(const char *name, bool up, Error **errp)
     net_client_set_link(ncs, queues, up);
 }
 
-static void net_vm_change_state_handler(void *opaque, bool running,
-                                        RunState state)
+static void net_vm_change_state_start(void *opaque, bool running,
+                                      RunState state)
 {
     NetClientState *nc;
     NetClientState *tmp;
 
+    if (!running) {
+        return;
+    }
+
     QTAILQ_FOREACH_SAFE(nc, &net_clients, next, tmp) {
-        if (running) {
-            /* Flush queued packets and wake up backends. */
-            if (nc->peer && qemu_can_send_packet(nc)) {
-                qemu_flush_queued_packets(nc->peer);
-            }
-        } else {
-            /* Complete all queued packets, to guarantee we don't modify
-             * state later when VM is not running.
-             */
-            qemu_flush_or_purge_queued_packets(nc, true);
+        /* Flush queued packets and wake up backends. */
+        if (nc->peer && qemu_can_send_packet(nc)) {
+            qemu_flush_queued_packets(nc->peer);
         }
     }
 }
 
+static void net_vm_change_state_stop(void *opaque, bool running,
+                                     RunState state)
+{
+    NetClientState *nc;
+    NetClientState *tmp;
+
+    if (running) {
+        return;
+    }
+
+    QTAILQ_FOREACH_SAFE(nc, &net_clients, next, tmp) {
+        /*
+         * Complete all queued packets, to guarantee we don't modify
+         * state later when VM is not running.
+         */
+        qemu_flush_or_purge_queued_packets(nc, true);
+    }
+}
+
 void net_cleanup(void)
 {
     NetClientState *nc, **p = &QTAILQ_FIRST(&net_clients);
@@ -1799,7 +1816,8 @@ void net_cleanup(void)
         }
     }
 
-    qemu_del_vm_change_state_handler(net_change_state_entry);
+    qemu_del_vm_change_state_handler(net_change_state_start_entry);
+    qemu_del_vm_change_state_handler(net_change_state_stop_entry);
 }
 
 void net_check_clients(void)
@@ -1957,8 +1975,10 @@ static void netdev_init_modern(void)
 
 void net_init_clients(void)
 {
-    net_change_state_entry =
-        qemu_add_vm_change_state_handler(net_vm_change_state_handler, NULL);
+    net_change_state_start_entry =
+        qemu_add_vm_change_state_handler(net_vm_change_state_start, NULL);
+    net_change_state_stop_entry =
+        qemu_add_vm_change_state_handler(net_vm_change_state_stop, NULL);
 
     QTAILQ_INIT(&net_clients);
 

