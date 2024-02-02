Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A9BC48298
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVywx-000216-FD; Fri, 02 Feb 2024 14:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVyww-00020b-LG
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:42 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVywu-0001w6-Il
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64AF71F799;
 Fri,  2 Feb 2024 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at+EqeXQ1TVmnDh7OeIM9ZBOhhXdwvyEyD7BG2BPYhM=;
 b=ZN32PkQxoeEPF2gd2BSvhtitWxgJUyK2Q/PKyK7G2Fi2Yog/WgCXMGdahY9iij+rFUiw/I
 1uU5pEIF/I+Le6s6eGYp7AVA82wW8IHnp+EWWBQCNSQzvwl8kAO0S9xxQ2Hq0332N2QuBg
 orBgdtQ1ERv8m4dCtcSnfs2T6fEYynE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at+EqeXQ1TVmnDh7OeIM9ZBOhhXdwvyEyD7BG2BPYhM=;
 b=V1ckMp7nTn8A/RUpkRF0JLRkWX6pR4sHR957vOx0Cq9o0X36jnM5/4EayYOm2STLeOaqCM
 lZKmvG2+2eepCGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at+EqeXQ1TVmnDh7OeIM9ZBOhhXdwvyEyD7BG2BPYhM=;
 b=ZN32PkQxoeEPF2gd2BSvhtitWxgJUyK2Q/PKyK7G2Fi2Yog/WgCXMGdahY9iij+rFUiw/I
 1uU5pEIF/I+Le6s6eGYp7AVA82wW8IHnp+EWWBQCNSQzvwl8kAO0S9xxQ2Hq0332N2QuBg
 orBgdtQ1ERv8m4dCtcSnfs2T6fEYynE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=at+EqeXQ1TVmnDh7OeIM9ZBOhhXdwvyEyD7BG2BPYhM=;
 b=V1ckMp7nTn8A/RUpkRF0JLRkWX6pR4sHR957vOx0Cq9o0X36jnM5/4EayYOm2STLeOaqCM
 lZKmvG2+2eepCGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FDAB139AB;
 Fri,  2 Feb 2024 19:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yH0mAmo+vWWlZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:11:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 4/5] migration/multifd: Move multifd_save_setup into migration
 thread
Date: Fri,  2 Feb 2024 16:11:27 -0300
Message-Id: <20240202191128.1901-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240202191128.1901-1-farosas@suse.de>
References: <20240202191128.1901-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.65 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.05)[59.69%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

So at multifd_save_setup() we create the channels, but they will only
be actually usable after the whole multifd_save_setup() calling stack
returns back to the main loop. Which means that the migration thread
is already up and running without any possibility for the multifd
channels to be ready on time.

We currently rely on the channels-ready semaphore blocking
multifd_send_sync_main() until channels start to come up and release
it. However there have been bugs recently found when a channel's
creation fails and multifd_save_cleanup() is allowed to run while
other channels are still being created.

Let's start to organize this situation by moving the
multifd_save_setup() call into the migration thread. That way we
unblock the main-loop to dispatch the completion callbacks and
actually have a chance of getting the multifd channels ready for when
the migration thread needs them.

The next patches will deal with the synchronization aspects.

Note that this takes multifd_save_setup() out of the BQL.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 55abb175cc..c14d12497f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3315,6 +3315,10 @@ static void *migration_thread(void *opaque)
     object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
+    if (!multifd_save_setup()) {
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
 
-    if (!multifd_save_setup()) {
-        migrate_fd_cleanup(s);
-        return;
-    }
-
     if (migrate_background_snapshot()) {
         qemu_thread_create(&s->thread, "bg_snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
-- 
2.35.3


