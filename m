Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864F8C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXr-0007mI-9s; Wed, 29 Jan 2025 11:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWC-00040r-IA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:20 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWA-0005Pf-FX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BC07210F3;
 Wed, 29 Jan 2025 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+jNODwaydQfziVnBX/QJ79md5AANhz63mgLGphz4sw=;
 b=y6EysCrOcT1GtZ96yEcqvs3z4r48laCjrzErRVS91X49vcZpbakfr4tQatKc3ZIw55PKEg
 cWDiKRZY6gkBEUOSHi0KA7aS3sFXzv1UWU+bJGrP5QGan0u2nZKZrhZPBp8WDcSqEQHI7r
 MurguizjYIhWxRQhI3fdpHTBr3noJGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+jNODwaydQfziVnBX/QJ79md5AANhz63mgLGphz4sw=;
 b=GmAnmbocxDpIItibOWOUnzOJjJ3EbSWuIIxzF9XhRBxtMdDNUt0kKjC7it8xFRBWpeUB8Y
 i9mf+L/PffdtGFAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+jNODwaydQfziVnBX/QJ79md5AANhz63mgLGphz4sw=;
 b=y6EysCrOcT1GtZ96yEcqvs3z4r48laCjrzErRVS91X49vcZpbakfr4tQatKc3ZIw55PKEg
 cWDiKRZY6gkBEUOSHi0KA7aS3sFXzv1UWU+bJGrP5QGan0u2nZKZrhZPBp8WDcSqEQHI7r
 MurguizjYIhWxRQhI3fdpHTBr3noJGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+jNODwaydQfziVnBX/QJ79md5AANhz63mgLGphz4sw=;
 b=GmAnmbocxDpIItibOWOUnzOJjJ3EbSWuIIxzF9XhRBxtMdDNUt0kKjC7it8xFRBWpeUB8Y
 i9mf+L/PffdtGFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA42137DB;
 Wed, 29 Jan 2025 16:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4DCTHwdRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 36/42] migration: Notify COMPLETE once for postcopy
Date: Wed, 29 Jan 2025 13:00:53 -0300
Message-Id: <20250129160059.6987-37-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
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

Postcopy invokes qemu_savevm_state_complete_precopy() twice, that means
it'll invoke COMPLETE notify twice.. also twice the tracepoints that
marking precopy complete.

Move that notification (along with the tracepoint) out to the caller, so
that postcopy will only notify once right at the start of switchover phase
from precopy.  When at it, rename it to suite the file now it locates.

For precopy, there should have no functional change except the tracepoint
has a name change.

For the other two users of qemu_savevm_state_complete_precopy(), namely:
qemu_savevm_state() and qemu_savevm_live_state(): the notifier shouldn't
matter because they're not precopy at all.  Now in these two contexts (aka,
"savevm", and "colo") sometimes the precopy notifiers will still be
invoked, but that's outside the scope of this patch.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-12-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  | 15 +++++++++++++++
 migration/savevm.c     |  7 -------
 migration/trace-events |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4ba6c8912a..72802d6133 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -131,6 +131,17 @@ static void migration_downtime_end(MigrationState *s)
     }
 }
 
+static void precopy_notify_complete(void)
+{
+    Error *local_err = NULL;
+
+    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
+        error_report_err(local_err);
+    }
+
+    trace_migration_precopy_complete();
+}
+
 static bool migration_needs_multiple_sockets(void)
 {
     return migrate_multifd() || migrate_postcopy_preempt();
@@ -2676,6 +2687,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     /* Switchover phase, switch to unlimited */
     migration_rate_set(RATE_LIMIT_DISABLED);
 
+    precopy_notify_complete();
+
     /*
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
@@ -2865,6 +2878,8 @@ static int migration_completion_precopy(MigrationState *s)
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
+    precopy_notify_complete();
+
     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
 out_unlock:
     bql_unlock();
diff --git a/migration/savevm.c b/migration/savevm.c
index 92e77ca92b..9aef2fa3c9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1578,15 +1578,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 {
     int ret;
-    Error *local_err = NULL;
     bool in_postcopy = migration_in_postcopy();
 
-    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
-        error_report_err(local_err);
-    }
-
-    trace_savevm_state_complete_precopy();
-
     if (!in_postcopy || iterable_only) {
         ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy);
         if (ret) {
diff --git a/migration/trace-events b/migration/trace-events
index e03a914afb..12b262f8ee 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -44,7 +44,6 @@ savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
 savevm_state_cleanup(void) ""
-savevm_state_complete_precopy(void) ""
 vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_downtime_save(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
@@ -195,6 +194,7 @@ migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidt
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
+migration_precopy_complete(void) ""
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.35.3


