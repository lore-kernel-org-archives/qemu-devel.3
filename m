Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787B6C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0QK-0006h9-CJ; Tue, 27 Aug 2024 13:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QD-0006Nv-GC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:02 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QB-0001cG-Tc
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:01 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Px-0002O7-TR; Tue, 27 Aug 2024 19:55:45 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 10/17] migration/multifd: Convert
 multifd_send()::next_channel to atomic
Date: Tue, 27 Aug 2024 19:54:29 +0200
Message-ID: <76dc3ad69fa457fd1e358ad3de874474f9f64716.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This is necessary for multifd_send() to be able to be called
from multiple threads.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d5a8e5a9c9b5..b25789dde0b3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -343,26 +343,38 @@ bool multifd_send(MultiFDSendData **send_data)
         return false;
     }
 
-    /* We wait here, until at least one channel is ready */
-    qemu_sem_wait(&multifd_send_state->channels_ready);
-
     /*
      * next_channel can remain from a previous migration that was
      * using more channels, so ensure it doesn't overflow if the
      * limit is lower now.
      */
-    next_channel %= migrate_multifd_channels();
-    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
+    i = qatomic_load_acquire(&next_channel);
+    if (unlikely(i >= migrate_multifd_channels())) {
+        qatomic_cmpxchg(&next_channel, i, 0);
+    }
+
+    /* We wait here, until at least one channel is ready */
+    qemu_sem_wait(&multifd_send_state->channels_ready);
+
+    while (true) {
+        int i_next;
+
         if (multifd_send_should_exit()) {
             return false;
         }
+
+        i = qatomic_load_acquire(&next_channel);
+        i_next = (i + 1) % migrate_multifd_channels();
+        if (qatomic_cmpxchg(&next_channel, i, i_next) != i) {
+            continue;
+        }
+
         p = &multifd_send_state->params[i];
         /*
          * Lockless read to p->pending_job is safe, because only multifd
          * sender thread can clear it.
          */
         if (qatomic_read(&p->pending_job) == false) {
-            next_channel = (i + 1) % migrate_multifd_channels();
             break;
         }
     }

