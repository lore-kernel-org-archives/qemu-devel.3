Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FBEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCK7-0003XY-Qy; Wed, 28 Feb 2024 00:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJi-00023t-7B
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJg-0008GW-Aj
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5XcBZWtNNgoUe5c3H0PbKnfzkeO/NiM+2qwR9WJckM=;
 b=M4pcTafr6vRqC44J072c9atQSDdwKMGeLHsqa9BVLkQHpiUXqcfgjyV3WriO9rhltv6W+k
 zzAonBUA+s1VM/kbgNOHP+kcbqHEloZ3BdgfnKTgQ2L+kN+IXzuHKzXlRnqI36kNjLUDtT
 YTG0oSJEojQUAHNtwdAyVoDgGm7Lclk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-M93zfFqSOsmsCrxRnEWUYg-1; Wed,
 28 Feb 2024 00:17:13 -0500
X-MC-Unique: M93zfFqSOsmsCrxRnEWUYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBAF43C02B9F;
 Wed, 28 Feb 2024 05:17:12 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA7E1C060B1;
 Wed, 28 Feb 2024 05:17:03 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 24/25] migration: Join the return path thread before releasing
 to_dst_file
Date: Wed, 28 Feb 2024 13:13:14 +0800
Message-ID: <20240228051315.400759-25-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The return path thread might hang at a blocking system call. Before
joining the thread we might need to issue a shutdown() on the socket
file descriptor to release it. To determine whether the shutdown() is
necessary we look at the QEMUFile error.

Make sure we only clean up the QEMUFile after the return path has been
waited for.

This fixes a hang when qemu_savevm_state_setup() produced an error
that was detected by migration_detect_error(). That skips
migration_completion() so close_return_path_on_source() would get
stuck waiting for the RP thread to terminate.

Reported-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240226203122.22894-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ccb13fa94a..7ba2b60e46 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1342,6 +1342,8 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     qemu_savevm_state_cleanup();
 
+    close_return_path_on_source(s);
+
     if (s->to_dst_file) {
         QEMUFile *tmp;
 
@@ -1366,12 +1368,6 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
-    /*
-     * We already cleaned up to_dst_file, so errors from the return
-     * path might be due to that, ignore them.
-     */
-    close_return_path_on_source(s);
-
     assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -2914,6 +2910,13 @@ static MigThrError postcopy_pause(MigrationState *s)
     while (true) {
         QEMUFile *file;
 
+        /*
+         * We're already pausing, so ignore any errors on the return
+         * path and just wait for the thread to finish. It will be
+         * re-created when we resume.
+         */
+        close_return_path_on_source(s);
+
         /*
          * Current channel is possibly broken. Release it.  Note that this is
          * guaranteed even without lock because to_dst_file should only be
@@ -2933,13 +2936,6 @@ static MigThrError postcopy_pause(MigrationState *s)
         qemu_file_shutdown(file);
         qemu_fclose(file);
 
-        /*
-         * We're already pausing, so ignore any errors on the return
-         * path and just wait for the thread to finish. It will be
-         * re-created when we resume.
-         */
-        close_return_path_on_source(s);
-
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);
 
-- 
2.43.0


