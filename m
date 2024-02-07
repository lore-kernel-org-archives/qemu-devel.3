Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8667DC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4P-0006wU-Ph; Wed, 07 Feb 2024 08:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4N-0006qm-EN
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:31 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4L-0008U4-Od
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgl3qZQz4x1n;
 Thu,  8 Feb 2024 00:34:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgj5M1vz4x1m;
 Thu,  8 Feb 2024 00:34:25 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 13/14] migration: Use migrate_has_error() in
 close_return_path_on_source()
Date: Wed,  7 Feb 2024 14:33:46 +0100
Message-ID: <20240207133347.1115903-14-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

close_return_path_on_source() retrieves the migration error from the
the QEMUFile '->to_dst_file' to know if a shutdown is required. This
shutdown is required to exit the return-path thread. However, in
migrate_fd_cleanup(), '->to_dst_file' is cleaned up before calling
close_return_path_on_source() and the shutdown is never performed,
leaving the source and destination waiting for an event to occur.

Avoid relying on '->to_dst_file' and use migrate_has_error() instead.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d5f705ceef4c925589aa49335969672c0d761fa2..5f55af3d7624750ca416c4177781241b3e291e5d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(MigrationState *ms)
      * cause it to unblock if it's stuck waiting for the destination.
      */
     WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
-            qemu_file_get_error(ms->to_dst_file)) {
+        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
             qemu_file_shutdown(ms->rp_state.from_dst_file);
         }
     }
-- 
2.43.0


