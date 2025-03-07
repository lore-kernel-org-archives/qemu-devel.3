Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3214EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcEz-0000iQ-Sh; Fri, 07 Mar 2025 13:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcEx-0000hj-Oj
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcEv-0004NI-6g
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:07 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD7F52118D;
 Fri,  7 Mar 2025 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCRIoHALaSzJJSqDE4A39LXrEmHIJBJiF0Llh+bdjrE=;
 b=CfaLtKmW8R+ZgyV9v/vRAPo785iS3SOUtZ+2TwcHGE39L94+7Fbd9gNpHRscAGXJgObxUV
 3eWFLvP5QsQSYlrKGCXHMOKkFbaZDLIRSSSnye+PVLBiBDbXhi6AQoc3Ewl6TNnuQ4sO4v
 AKetBLyzACZEr+ROamzdaFeTDUaU7/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCRIoHALaSzJJSqDE4A39LXrEmHIJBJiF0Llh+bdjrE=;
 b=MBT6YbnO69Bc5p4U1Cc6DfMSAap0+QFrU5C5jshnRd/1LdZd8UH35+VrOMZHauLsEaqP48
 l4eLV7RuCVv59FBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCRIoHALaSzJJSqDE4A39LXrEmHIJBJiF0Llh+bdjrE=;
 b=CfaLtKmW8R+ZgyV9v/vRAPo785iS3SOUtZ+2TwcHGE39L94+7Fbd9gNpHRscAGXJgObxUV
 3eWFLvP5QsQSYlrKGCXHMOKkFbaZDLIRSSSnye+PVLBiBDbXhi6AQoc3Ewl6TNnuQ4sO4v
 AKetBLyzACZEr+ROamzdaFeTDUaU7/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCRIoHALaSzJJSqDE4A39LXrEmHIJBJiF0Llh+bdjrE=;
 b=MBT6YbnO69Bc5p4U1Cc6DfMSAap0+QFrU5C5jshnRd/1LdZd8UH35+VrOMZHauLsEaqP48
 l4eLV7RuCVv59FBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5783313A22;
 Fri,  7 Mar 2025 18:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mC12Bdw3y2dNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 18:15:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Yan Fu <yafu@redhat.com>
Subject: [PULL 1/8] migration: Fix UAF for incoming migration on MigrationState
Date: Fri,  7 Mar 2025 15:15:44 -0300
Message-Id: <20250307181551.19887-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307181551.19887-1-farosas@suse.de>
References: <20250307181551.19887-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

On the incoming migration side, QEMU uses a coroutine to load all the VM
states.  Inside, it may reference MigrationState on global states like
migration capabilities, parameters, error state, shared mutexes and more.

However there's nothing yet to make sure MigrationState won't get
destroyed (e.g. after migration_shutdown()).  Meanwhile there's also no API
available to remove the incoming coroutine in migration_shutdown(),
avoiding it to access the freed elements.

There's a bug report showing this can happen and crash dest QEMU when
migration is cancelled on source.

When it happens, the dest main thread is trying to cleanup everything:

  #0  qemu_aio_coroutine_enter
  #1  aio_dispatch_handler
  #2  aio_poll
  #3  monitor_cleanup
  #4  qemu_cleanup
  #5  qemu_default_main

Then it found the migration incoming coroutine, schedule it (even after
migration_shutdown()), causing crash:

  #0  __pthread_kill_implementation
  #1  __pthread_kill_internal
  #2  __GI_raise
  #3  __GI_abort
  #4  __assert_fail_base
  #5  __assert_fail
  #6  qemu_mutex_lock_impl
  #7  qemu_lockable_mutex_lock
  #8  qemu_lockable_lock
  #9  qemu_lockable_auto_lock
  #10 migrate_set_error
  #11 process_incoming_migration_co
  #12 coroutine_trampoline

To fix it, take a refcount after an incoming setup is properly done when
qmp_migrate_incoming() succeeded the 1st time.  As it's during a QMP
handler which needs BQL, it means the main loop is still alive (without
going into cleanups, which also needs BQL).

Releasing the refcount now only until the incoming migration coroutine
finished or failed.  Hence the refcount is valid for both (1) setup phase
of incoming ports, mostly IO watches (e.g. qio_channel_add_watch_full()),
and (2) the incoming coroutine itself (process_incoming_migration_co()).

Note that we can't unref in migration_incoming_state_destroy(), because
both qmp_xen_load_devices_state() and load_snapshot() will use it without
an incoming migration.  Those hold BQL so they're not prone to this issue.

PS: I suspect nobody uses Xen's command at all, as it didn't register yank,
hence AFAIU the command should crash on master when trying to unregister
yank in migration_incoming_state_destroy()..  but that's another story.

Also note that in some incoming failure cases we may not always unref the
MigrationState refcount, which is a trade-off to keep things simple.  We
could make it accurate, but it can be an overkill.  Some examples:

  - Unlike most of the rest protocols, socket_start_incoming_migration()
    may create net listener after incoming port setup sucessfully.
    It means we can't unref in migration_channel_process_incoming() as a
    generic path because socket protocol might keep using MigrationState.

  - For either socket or file, multiple IO watches might be created, it
    means logically each IO watch needs to take one refcount for
    MigrationState so as to be 100% accurate on ownership of refcount taken.

In general, we at least need per-protocol handling to make it accurate,
which can be an overkill if we know incoming failed after all.  Add a short
comment to explain that when taking the refcount in qmp_migrate_incoming().

Bugzilla: https://issues.redhat.com/browse/RHEL-69775
Tested-by: Yan Fu <yafu@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250220132459.512610-1-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1833cfe358..d46e776e24 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -116,6 +116,27 @@ static void migration_downtime_start(MigrationState *s)
     s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 }
 
+/*
+ * This is unfortunate: incoming migration actually needs the outgoing
+ * migration state (MigrationState) to be there too, e.g. to query
+ * capabilities, parameters, using locks, setup errors, etc.
+ *
+ * NOTE: when calling this, making sure current_migration exists and not
+ * been freed yet!  Otherwise trying to access the refcount is already
+ * an use-after-free itself..
+ *
+ * TODO: Move shared part of incoming / outgoing out into separate object.
+ * Then this is not needed.
+ */
+static void migrate_incoming_ref_outgoing_state(void)
+{
+    object_ref(migrate_get_current());
+}
+static void migrate_incoming_unref_outgoing_state(void)
+{
+    object_unref(migrate_get_current());
+}
+
 static void migration_downtime_end(MigrationState *s)
 {
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
@@ -863,7 +884,7 @@ process_incoming_migration_co(void *opaque)
              * postcopy thread.
              */
             trace_process_incoming_migration_co_postcopy_end_main();
-            return;
+            goto out;
         }
         /* Else if something went wrong then just fall out of the normal exit */
     }
@@ -879,7 +900,8 @@ process_incoming_migration_co(void *opaque)
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
-    return;
+    goto out;
+
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
@@ -896,6 +918,9 @@ fail:
 
         exit(EXIT_FAILURE);
     }
+out:
+    /* Pairs with the refcount taken in qmp_migrate_incoming() */
+    migrate_incoming_unref_outgoing_state();
 }
 
 /**
@@ -1901,6 +1926,17 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    /*
+     * Making sure MigrationState is available until incoming migration
+     * completes.
+     *
+     * NOTE: QEMU _might_ leak this refcount in some failure paths, but
+     * that's OK.  This is the minimum change we need to at least making
+     * sure success case is clean on the refcount.  We can try harder to
+     * make it accurate for any kind of failures, but it might be an
+     * overkill and doesn't bring us much benefit.
+     */
+    migrate_incoming_ref_outgoing_state();
     once = false;
 }
 
-- 
2.35.3


