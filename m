Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5D1C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thtFJ-0000nL-N4; Tue, 11 Feb 2025 11:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thtFF-0000Y8-Nw
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:36:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thtFD-0008Lv-Hz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:36:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 723BE37B72;
 Tue, 11 Feb 2025 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf66cg+jPkUcRQ4h+cKG6FLdQ8Fwkh3TnkYNoinjRRU=;
 b=coVxwO/oL2DjRfhIRgl4YYzc9w4bvXa7vq8Jkq8vQhJqw/tU3+dEggpPouPo1+6z6ImCXh
 UBjkGUw/TghRsjgjw1SZF6cCm2PNwEc7ALMyuuvhd0AvDVrrOSh6JLcFL+fFUz/b1hyhtl
 98H/5vkFpNl+cp/jy2LEvLnTk3N6G2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf66cg+jPkUcRQ4h+cKG6FLdQ8Fwkh3TnkYNoinjRRU=;
 b=HKtsDPb+veIJaMbQ6bmNIZ8PvQsuLDxNKIRegj+MNP0/vr4ITlb55avFY7l97AfediCgC6
 EeaALym/UvEU3oAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="coVxwO/o";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HKtsDPb+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf66cg+jPkUcRQ4h+cKG6FLdQ8Fwkh3TnkYNoinjRRU=;
 b=coVxwO/oL2DjRfhIRgl4YYzc9w4bvXa7vq8Jkq8vQhJqw/tU3+dEggpPouPo1+6z6ImCXh
 UBjkGUw/TghRsjgjw1SZF6cCm2PNwEc7ALMyuuvhd0AvDVrrOSh6JLcFL+fFUz/b1hyhtl
 98H/5vkFpNl+cp/jy2LEvLnTk3N6G2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf66cg+jPkUcRQ4h+cKG6FLdQ8Fwkh3TnkYNoinjRRU=;
 b=HKtsDPb+veIJaMbQ6bmNIZ8PvQsuLDxNKIRegj+MNP0/vr4ITlb55avFY7l97AfediCgC6
 EeaALym/UvEU3oAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8DE913715;
 Tue, 11 Feb 2025 15:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EQIKlhmq2c8WwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 11 Feb 2025 15:01:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 3/9] migration: Change migrate_fd_ to migration_
Date: Tue, 11 Feb 2025 12:01:30 -0300
Message-Id: <20250211150136.6781-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250211150136.6781-1-farosas@suse.de>
References: <20250211150136.6781-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 723BE37B72
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Remove all instances of _fd_ from the migration generic code. These
functions have grown over time and the _fd_ part is now just
confusing.

migration_fd_error() -> migration_error() makes it a little vague, so
change it to migration_set_error_state().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c    |  4 ++--
 migration/migration.c  | 30 +++++++++++++++---------------
 migration/migration.h  |  2 +-
 migration/multifd.c    |  2 +-
 migration/rdma.c       |  2 +-
 migration/trace-events |  2 +-
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index f9de064f3b..24a91ef911 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -74,7 +74,7 @@ void migration_channel_connect(MigrationState *s,
             if (!error) {
                 /* tls_channel_connect will call back to this
                  * function after the TLS handshake,
-                 * so we mustn't call migrate_fd_connect until then
+                 * so we mustn't call migration_connect until then
                  */
 
                 return;
@@ -89,7 +89,7 @@ void migration_channel_connect(MigrationState *s,
             qemu_mutex_unlock(&s->qemu_file_lock);
         }
     }
-    migrate_fd_connect(s, error);
+    migration_connect(s, error);
     error_free(error);
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index e37842fdd2..db8d6e8ea7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1423,12 +1423,12 @@ static void migration_cleanup_json_writer(MigrationState *s)
     g_clear_pointer(&s->vmdesc, json_writer_free);
 }
 
-static void migrate_fd_cleanup(MigrationState *s)
+static void migration_cleanup(MigrationState *s)
 {
     MigrationEventType type;
     QEMUFile *tmp = NULL;
 
-    trace_migrate_fd_cleanup();
+    trace_migration_cleanup();
 
     migration_cleanup_json_writer(s);
 
@@ -1485,9 +1485,9 @@ static void migrate_fd_cleanup(MigrationState *s)
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
-static void migrate_fd_cleanup_bh(void *opaque)
+static void migration_cleanup_bh(void *opaque)
 {
-    migrate_fd_cleanup(opaque);
+    migration_cleanup(opaque);
 }
 
 void migrate_set_error(MigrationState *s, const Error *error)
@@ -1517,7 +1517,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-static void migrate_fd_error(MigrationState *s, const Error *error)
+static void migration_set_error_state(MigrationState *s, const Error *error)
 {
     MigrationStatus current = s->state;
     MigrationStatus next;
@@ -2198,7 +2198,7 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        migrate_fd_error(s, local_err);
+        migration_set_error_state(s, local_err);
         error_propagate(errp, local_err);
     }
 }
@@ -2243,7 +2243,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migrate_fd_error(s, local_err);
+        migration_set_error_state(s, local_err);
         error_propagate(errp, local_err);
         return;
     }
@@ -3427,7 +3427,7 @@ static void migration_iteration_finish(MigrationState *s)
         break;
     }
 
-    migration_bh_schedule(migrate_fd_cleanup_bh, s);
+    migration_bh_schedule(migration_cleanup_bh, s);
     bql_unlock();
 }
 
@@ -3455,7 +3455,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
         break;
     }
 
-    migration_bh_schedule(migrate_fd_cleanup_bh, s);
+    migration_bh_schedule(migration_cleanup_bh, s);
     bql_unlock();
 }
 
@@ -3837,7 +3837,7 @@ fail_setup:
     return NULL;
 }
 
-void migrate_fd_connect(MigrationState *s, Error *error_in)
+void migration_connect(MigrationState *s, Error *error_in)
 {
     Error *local_err = NULL;
     uint64_t rate_limit;
@@ -3847,24 +3847,24 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     /*
      * If there's a previous error, free it and prepare for another one.
      * Meanwhile if migration completes successfully, there won't have an error
-     * dumped when calling migrate_fd_cleanup().
+     * dumped when calling migration_cleanup().
      */
     migrate_error_free(s);
 
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
-        migrate_fd_error(s, error_in);
+        migration_set_error_state(s, error_in);
         if (resume) {
             /*
              * Don't do cleanup for resume if channel is invalid, but only dump
              * the error.  We wait for another channel connect from the user.
              * The error_report still gives HMP user a hint on what failed.
-             * It's normally done in migrate_fd_cleanup(), but call it here
+             * It's normally done in migration_cleanup(), but call it here
              * explicitly.
              */
             error_report_err(error_copy(s->error));
         } else {
-            migrate_fd_cleanup(s);
+            migration_cleanup(s);
         }
         return;
     }
@@ -3944,7 +3944,7 @@ fail:
     migrate_set_error(s, local_err);
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     error_report_err(local_err);
-    migrate_fd_cleanup(s);
+    migration_cleanup(s);
 }
 
 static void migration_class_init(ObjectClass *klass, void *data)
diff --git a/migration/migration.h b/migration/migration.h
index 3547420c52..76afef34c4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -484,7 +484,7 @@ bool  migration_has_all_channels(void);
 void migrate_set_error(MigrationState *s, const Error *error);
 bool migrate_has_error(MigrationState *s);
 
-void migrate_fd_connect(MigrationState *s, Error *error_in);
+void migration_connect(MigrationState *s, Error *error_in);
 
 int migration_call_notifiers(MigrationState *s, MigrationEventType type,
                              Error **errp);
diff --git a/migration/multifd.c b/migration/multifd.c
index ab73d6d984..d7ea8668ad 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -444,7 +444,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
          * channels have no I/O handler callback registered when reaching
          * here, because migration thread will wait for all multifd channel
          * establishments to complete during setup.  Since
-         * migrate_fd_cleanup() will be scheduled in main thread too, all
+         * migration_cleanup() will be scheduled in main thread too, all
          * previous callbacks should guarantee to be completed when
          * reaching here.  See multifd_send_state.channels_created and its
          * usage.  In the future, we could replace this with an assert
diff --git a/migration/rdma.c b/migration/rdma.c
index 855753c671..76fb034923 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4174,7 +4174,7 @@ void rdma_start_outgoing_migration(void *opaque,
 
     s->to_dst_file = rdma_new_output(rdma);
     s->rdma_migration = true;
-    migrate_fd_connect(s, NULL);
+    migration_connect(s, NULL);
     return;
 return_path_err:
     qemu_rdma_cleanup(rdma);
diff --git a/migration/trace-events b/migration/trace-events
index d22600abe6..58c0f07f5b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -154,7 +154,7 @@ multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostnam
 
 # migration.c
 migrate_set_state(const char *new_state) "new state %s"
-migrate_fd_cleanup(void) ""
+migration_cleanup(void) ""
 migrate_error(const char *error_desc) "error=%s"
 migration_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
-- 
2.35.3


