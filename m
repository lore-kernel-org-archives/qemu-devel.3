Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DABC05024
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk4M-0007FH-Kj; Tue, 16 Apr 2024 10:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3o-0006J0-0P
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:26 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3m-0002cs-5N
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:23 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3Y-0002jI-Lw; Tue, 16 Apr 2024 16:45:08 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 22/26] migration/multifd: Convert
 multifd_send_pages::next_channel to atomic
Date: Tue, 16 Apr 2024 16:43:01 +0200
Message-ID: <e519ae20524b4cecb50b3dc29d1b1614f737cb10.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This is necessary for multifd_send_pages() to be able to be called
from multiple threads.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a26418d87485..878ff7d9f9f0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -622,8 +622,8 @@ static bool multifd_send_pages(void)
      * using more channels, so ensure it doesn't overflow if the
      * limit is lower now.
      */
-    next_channel %= migrate_multifd_channels();
-    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
+    i = qatomic_load_acquire(&next_channel) % migrate_multifd_channels();
+    for (;; i = (i + 1) % migrate_multifd_channels()) {
         if (multifd_send_should_exit()) {
             return false;
         }
@@ -633,7 +633,8 @@ static bool multifd_send_pages(void)
          * sender thread can clear it.
          */
         if (qatomic_read(&p->pending_job) == false) {
-            next_channel = (i + 1) % migrate_multifd_channels();
+            qatomic_store_release(&next_channel,
+                                  (i + 1) % migrate_multifd_channels());
             break;
         }
     }

