Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57595C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ1K-00081b-Ur; Mon, 27 Jan 2025 09:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1G-0007kV-Vo; Mon, 27 Jan 2025 09:23:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1F-0002uf-7G; Mon, 27 Jan 2025 09:23:18 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id E6D3BE0F53;
 Mon, 27 Jan 2025 17:22:47 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 8338D51D87; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 17/41] migration/multifd: Fix compat with QEMU < 9.0
Date: Mon, 27 Jan 2025 17:17:31 +0300
Message-Id: <20250127141803.3514882-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fabiano Rosas <farosas@suse.de>

Commit f5f48a7891 ("migration/multifd: Separate SYNC request with
normal jobs") changed the multifd source side to stop sending data
along with the MULTIFD_FLAG_SYNC, effectively introducing the concept
of a SYNC-only packet. Relying on that, commit d7e58f412c
("migration/multifd: Don't send ram data during SYNC") later came
along and skipped reading data from SYNC packets.

In a versions timeline like this:

  8.2 f5f48a7 9.0 9.1 d7e58f41 9.2

The issue arises that QEMUs < 9.0 still send data along with SYNC, but
QEMUs > 9.1 don't gather that data anymore. This leads to various
kinds of migration failures due to desync/missing data.

Stop checking for a SYNC packet on the destination and unconditionally
unfill the packet.

>From now on:

old -> new:
the source sends data + sync, destination reads normally

new -> new:
source sends only sync, destination reads zeros

new -> old:
source sends only sync, destination reads zeros

CC: qemu-stable@nongnu.org
Fixes: d7e58f412c ("migration/multifd: Don't send ram data during SYNC")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2720
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241213160120.23880-2-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit b93d897ea2f0abbe7fc341a9ac176b5ecd0f3c93)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd10..8d0a763a72 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -252,9 +252,8 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
 
-    if (!(p->flags & MULTIFD_FLAG_SYNC)) {
-        ret = multifd_ram_unfill_packet(p, errp);
-    }
+    /* Always unfill, old QEMUs (<9.0) send data along with SYNC */
+    ret = multifd_ram_unfill_packet(p, errp);
 
     trace_multifd_recv_unfill(p->id, p->packet_num, p->flags,
                               p->next_packet_size);
@@ -1151,9 +1150,13 @@ static void *multifd_recv_thread(void *opaque)
             flags = p->flags;
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
-            if (!(flags & MULTIFD_FLAG_SYNC)) {
-                has_data = p->normal_num || p->zero_num;
-            }
+
+            /*
+             * Even if it's a SYNC packet, this needs to be set
+             * because older QEMUs (<9.0) still send data along with
+             * the SYNC packet.
+             */
+            has_data = p->normal_num || p->zero_num;
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*
-- 
2.39.5


