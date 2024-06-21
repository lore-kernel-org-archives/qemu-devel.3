Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E91C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTj-0003W4-Qd; Fri, 21 Jun 2024 13:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTi-0003Vg-65
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:14 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTg-0003Nz-57
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C84BE1F835;
 Fri, 21 Jun 2024 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXccEqG4nwir6SVIx8qPQJaBfujHLJvf+SwMbJY2WM0=;
 b=HCCgPD0BuxO0uAwsLnKLfEgKt+B0lJS63l3iUOrbBW4eNvr6rLq2AVcqXVio77RJvwTpz9
 ODGteGRDjj4TzZDsOWjmI1ICu6mw6Q3EN0KFZrNWMNbocmyOws2bFMldkAzHFkHbHGsb9g
 EmemGL0sFuPqR7JS0wsZsPqMWX0PDjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXccEqG4nwir6SVIx8qPQJaBfujHLJvf+SwMbJY2WM0=;
 b=fUVZlS7wy1xDhGwQrl1SK9QUIIAAWiiQtBeMKHMj+FpW4inKSpXb9QpDKIVx7qtF9ubtCi
 UCcZs1/7IPBKuDDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ITnmQNcT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JP+0o4zM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXccEqG4nwir6SVIx8qPQJaBfujHLJvf+SwMbJY2WM0=;
 b=ITnmQNcTKP4JxxQyvi2+AKz8AIFQFZJAARwtfvN/rbTezWWCDyFlXNzNVzJTCGHppuo92r
 G3G0sZpEq/RtDrMTq7WfakW8jXVIFv8HB+aLt6cw0dHxhSgigkEIwcytQAlRwNugctV6fz
 CAb185PhuN141w/7VrhQTMCQDk0Wy1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXccEqG4nwir6SVIx8qPQJaBfujHLJvf+SwMbJY2WM0=;
 b=JP+0o4zMCHtzR+gh9qID1+Cs8z9B3kCiSu8woaawq5SyJcyWXHh9Em+zp4CKER4B6zsXDy
 cDSM+cla4B51sEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63D4213AAA;
 Fri, 21 Jun 2024 17:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ANevCny+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhijian Li <lizhijian@fujitsu.com>
Subject: [PULL 18/28] migration: Rename thread debug names
Date: Fri, 21 Jun 2024 14:54:24 -0300
Message-Id: <20240621175434.31180-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C84BE1F835
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The postcopy thread names on dest QEMU are slightly confusing, partly I'll
need to blame myself on 36f62f11e4 ("migration: Postcopy preemption
preparation on channel creation").  E.g., "fault-fast" reads like a fast
version of "fault-default", but it's actually the fast version of
"postcopy/listen".

Taking this chance, rename all the migration threads with proper rules.
Considering we only have 15 chars usable, prefix all threads with "mig/",
meanwhile identify src/dst threads properly this time.  So now most thread
names will look like "mig/DIR/xxx", where DIR will be "src"/"dst", except
the bg-snapshot thread which doesn't have a direction.

For multifd threads, making them "mig/{src|dst}/{send|recv}_%d".

We used to have "live_migration" thread for a very long time, now it's
called "mig/src/main".  We may hope to have "mig/dst/main" soon but not
yet.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/colo.c         | 2 +-
 migration/migration.c    | 6 +++---
 migration/multifd.c      | 6 +++---
 migration/postcopy-ram.c | 4 ++--
 migration/savevm.c       | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index f96c2ee069..6449490221 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -935,7 +935,7 @@ void coroutine_fn colo_incoming_co(void)
     assert(bql_locked());
     assert(migration_incoming_colo_enabled());
 
-    qemu_thread_create(&th, "COLO incoming", colo_process_incoming_thread,
+    qemu_thread_create(&th, "mig/dst/colo", colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
 
     mis->colo_incoming_co = qemu_coroutine_self();
diff --git a/migration/migration.c b/migration/migration.c
index e03c80b3aa..f9b69af62f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2431,7 +2431,7 @@ static int open_return_path_on_source(MigrationState *ms)
 
     trace_open_return_path_on_source();
 
-    qemu_thread_create(&ms->rp_state.rp_thread, "return path",
+    qemu_thread_create(&ms->rp_state.rp_thread, "mig/src/rp-thr",
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
 
@@ -3770,10 +3770,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (migrate_background_snapshot()) {
-        qemu_thread_create(&s->thread, "bg_snapshot",
+        qemu_thread_create(&s->thread, "mig/snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
     } else {
-        qemu_thread_create(&s->thread, "live_migration",
+        qemu_thread_create(&s->thread, "mig/src/main",
                 migration_thread, s, QEMU_THREAD_JOINABLE);
     }
     s->migration_thread_running = true;
diff --git a/migration/multifd.c b/migration/multifd.c
index d82885fdbb..0b4cbaddfe 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1069,7 +1069,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     args->p = p;
 
     p->tls_thread_created = true;
-    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
+    qemu_thread_create(&p->tls_thread, "mig/src/tls",
                        multifd_tls_handshake_thread, args,
                        QEMU_THREAD_JOINABLE);
     return true;
@@ -1190,7 +1190,7 @@ bool multifd_send_setup(void)
             p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
             p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         }
-        p->name = g_strdup_printf("multifdsend_%d", i);
+        p->name = g_strdup_printf("mig/src/send_%d", i);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
         p->write_flags = 0;
@@ -1604,7 +1604,7 @@ int multifd_recv_setup(Error **errp)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
         }
-        p->name = g_strdup_printf("multifdrecv_%d", i);
+        p->name = g_strdup_printf("mig/dst/recv_%d", i);
         p->normal = g_new0(ram_addr_t, page_count);
         p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3419779548..97701e6bb2 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1238,7 +1238,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
-    postcopy_thread_create(mis, &mis->fault_thread, "fault-default",
+    postcopy_thread_create(mis, &mis->fault_thread, "mig/dst/fault",
                            postcopy_ram_fault_thread, QEMU_THREAD_JOINABLE);
     mis->have_fault_thread = true;
 
@@ -1258,7 +1258,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
          * This thread needs to be created after the temp pages because
          * it'll fetch RAM_CHANNEL_POSTCOPY PostcopyTmpPage immediately.
          */
-        postcopy_thread_create(mis, &mis->postcopy_prio_thread, "fault-fast",
+        postcopy_thread_create(mis, &mis->postcopy_prio_thread, "mig/dst/preempt",
                                postcopy_preempt_thread, QEMU_THREAD_JOINABLE);
         mis->preempt_thread_status = PREEMPT_THREAD_CREATED;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index c621f2359b..e71410d8c1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2129,7 +2129,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     }
 
     mis->have_listen_thread = true;
-    postcopy_thread_create(mis, &mis->listen_thread, "postcopy/listen",
+    postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
                            postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
     trace_loadvm_postcopy_handle_listen("return");
 
-- 
2.35.3


