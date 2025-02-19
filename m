Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288F6C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqmj-0000xA-Mx; Wed, 19 Feb 2025 15:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqmg-0000pq-Mu
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:35:06 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqme-0004b8-TZ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:35:06 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqma-00000007VSV-2wOD; Wed, 19 Feb 2025 21:35:00 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 07/36] migration: postcopy_ram_listen_thread() should take
 BQL for some calls
Date: Wed, 19 Feb 2025 21:33:49 +0100
Message-ID: <c331cfc5c87a33df856e58c203d3c1d7e39fc1c1.1739994627.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739994627.git.maciej.szmigiero@oracle.com>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

All callers to migration_incoming_state_destroy() other than
postcopy_ram_listen_thread() do this call with BQL held.

Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
to always call that function under BQL rather than to have it deal with
both cases (with BQL and without BQL).
Add the necessary bql_lock() and bql_unlock() to
postcopy_ram_listen_thread().

qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
"load_state" SaveVMHandlers that are expecting BQL to be held.

In principle, the only devices that should be arriving on migration
channel serviced by postcopy_ram_listen_thread() are those that are
postcopiable and whose load handlers are safe to be called without BQL
being held.

But nothing currently prevents the source from sending data for "unsafe"
devices which would cause trouble there.
Add a TODO comment there so it's clear that it would be good to improve
handling of such (erroneous) case in the future.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/savevm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7c1aa8ad7b9d..3e86b572cfa8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1986,6 +1986,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * in qemu_file, and thus we must be blocking now.
      */
     qemu_file_set_blocking(f, true);
+
+    /* TODO: sanity check that only postcopiable data will be loaded here */
     load_res = qemu_loadvm_state_main(f, mis);
 
     /*
@@ -2046,7 +2048,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * (If something broke then qemu will have to exit anyway since it's
      * got a bad migration state).
      */
+    bql_lock();
     migration_incoming_state_destroy();
+    bql_unlock();
 
     rcu_unregister_thread();
     mis->have_listen_thread = false;

