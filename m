Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC04AC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTMl-0000ku-AN; Tue, 06 Feb 2024 16:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLr-0008Af-6M
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLp-00089Y-8X
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E398C1FB96;
 Tue,  6 Feb 2024 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XXSXzkv0fuv18lvFrJtBY12rIGfCJeOpjEeoQl7stU=;
 b=CEIC2kVNlEzbgx42Gey5+YRhHZHBJGTIQkMdqSmMYYtsPBz/TmyKcRUq7a4Fr3loa2pXtL
 W4YA+eOEFt5cMIKmvfXV2qc5Hx8dSBbEAgJHNJYNCrIquiGw6G7oqw0WxU2Wac0bwCs9yW
 4EkZprW7Yj7hEfWNuGATm47ohaNSBiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XXSXzkv0fuv18lvFrJtBY12rIGfCJeOpjEeoQl7stU=;
 b=FUeNjuLaB9Do6IRBiwQTGBhJNdvmMWIrvgCc3iFky5UtMxbwPZO08Ip1Bmk33+pLjbNfL5
 3LrooXuzGigVWFBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XXSXzkv0fuv18lvFrJtBY12rIGfCJeOpjEeoQl7stU=;
 b=WMmFmHxV4LxV3YQY0P2etE+hjZmaT5hgoSXEmxvJMXOuXQF6xPIzCdiu6HdhhuLFvhrdF1
 hSjoJetUAAARmxjRLkSBDB5kFKmyAdxTUqAFHUApfElkTa5KZnPd7Z2zpDFyNot6QrUiKz
 oe0SR8hMJIYipSumdkYtuRDSeqUopCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XXSXzkv0fuv18lvFrJtBY12rIGfCJeOpjEeoQl7stU=;
 b=nFOKbZNrJP62pTlVnBpuZL8ia25RA5dZI6EPyVNx6MWzr1HKyblQKR3m/xvt9fstHEW7aQ
 eEDL9UfBjd71MSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 848C7132DD;
 Tue,  6 Feb 2024 21:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AKnaEuGpwmWzQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Feb 2024 21:51:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 4/6] migration/multifd: Move multifd_send_setup into
 migration thread
Date: Tue,  6 Feb 2024 18:51:16 -0300
Message-Id: <20240206215118.6171-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240206215118.6171-1-farosas@suse.de>
References: <20240206215118.6171-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WMmFmHxV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nFOKbZNr
X-Spamd-Result: default: False [1.50 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.19)[89.06%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E398C1FB96
X-Spamd-Bar: +
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We currently have an unfavorable situation around multifd channels
creation and the migration thread execution.

We create the multifd channels with qio_channel_socket_connect_async
-> qio_task_run_in_thread, but only connect them at the
multifd_new_send_channel_async callback, called from
qio_task_complete, which is registered as a glib event.

So at multifd_send_setup() we create the channels, but they will only
be actually usable after the whole multifd_send_setup() calling stack
returns back to the main loop. Which means that the migration thread
is already up and running without any possibility for the multifd
channels to be ready on time.

We currently rely on the channels-ready semaphore blocking
multifd_send_sync_main() until channels start to come up and release
it. However there have been bugs recently found when a channel's
creation fails and multifd_send_cleanup() is allowed to run while
other channels are still being created.

Let's start to organize this situation by moving the
multifd_send_setup() call into the migration thread. That way we
unblock the main-loop to dispatch the completion callbacks and
actually have a chance of getting the multifd channels ready for when
the migration thread needs them.

The next patches will deal with the synchronization aspects.

Note that this takes multifd_send_setup() out of the BQL.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2942f8cf42..0675e12c64 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3315,6 +3315,10 @@ static void *migration_thread(void *opaque)
     object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
+    if (!multifd_send_setup()) {
+        goto out;
+    }
+
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
     bql_unlock();
@@ -3386,6 +3390,7 @@ static void *migration_thread(void *opaque)
         urgent = migration_rate_limit();
     }
 
+out:
     trace_migration_thread_after_loop();
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
@@ -3623,11 +3628,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (!multifd_send_setup()) {
-        migrate_fd_cleanup(s);
-        return;
-    }
-
     if (migrate_background_snapshot()) {
         qemu_thread_create(&s->thread, "bg_snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
-- 
2.35.3


