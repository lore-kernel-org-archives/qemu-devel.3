Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0957C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidUz-00060N-1q; Thu, 13 Feb 2025 12:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidUx-0005z8-Fh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidUv-00066F-Br
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:38 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A809225C5;
 Thu, 13 Feb 2025 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rV7u9vHAbuVUpAFKRRlUog8JMp6DRzLAlE82EVJVPTI=;
 b=iOwhqcYvdPZy+jxigtTLZOhFEjrj6ZTflj6m+EDt11n9+XBKTwsuJaiZTxFHwugmhO3E6t
 G7pQ6tn2g5m7B+VJaHMkYCOzn7N2fsFs7Cv6nYcHVt3uWonaS+9FHgo/YCc5HGoUPd8ok8
 pEQPnTNntjgXgy3fDvly3SIx7fsg4Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rV7u9vHAbuVUpAFKRRlUog8JMp6DRzLAlE82EVJVPTI=;
 b=9OZdCsSU5KVu0QNodhnlY8CZCNn3Tvm8CcmVvmHUEXJezIzN7veoHDwFLTKLlW5TxSXU3q
 ctP/RtTUR9lQ9BCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rV7u9vHAbuVUpAFKRRlUog8JMp6DRzLAlE82EVJVPTI=;
 b=iOwhqcYvdPZy+jxigtTLZOhFEjrj6ZTflj6m+EDt11n9+XBKTwsuJaiZTxFHwugmhO3E6t
 G7pQ6tn2g5m7B+VJaHMkYCOzn7N2fsFs7Cv6nYcHVt3uWonaS+9FHgo/YCc5HGoUPd8ok8
 pEQPnTNntjgXgy3fDvly3SIx7fsg4Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rV7u9vHAbuVUpAFKRRlUog8JMp6DRzLAlE82EVJVPTI=;
 b=9OZdCsSU5KVu0QNodhnlY8CZCNn3Tvm8CcmVvmHUEXJezIzN7veoHDwFLTKLlW5TxSXU3q
 ctP/RtTUR9lQ9BCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E11B13874;
 Thu, 13 Feb 2025 17:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2M9zLwUzrmfqMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 17:59:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 2/9] migration: Unify migration_cancel and migrate_fd_cancel
Date: Thu, 13 Feb 2025 14:59:20 -0300
Message-Id: <20250213175927.19642-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250213175927.19642-1-farosas@suse.de>
References: <20250213175927.19642-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

There's no need for two separate functions and this _fd_ is a historic
artifact that makes little sense nowadays.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  | 18 +++++++-----------
 migration/trace-events |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7728f52aef..e37842fdd2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -106,7 +106,6 @@ static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static bool migration_switchover_start(MigrationState *s, Error **errp);
-static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
 static void migrate_hup_delete(MigrationState *s);
@@ -342,14 +341,6 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
     qemu_bh_schedule(bh);
 }
 
-void migration_cancel()
-{
-    if (migrate_dirty_limit()) {
-        qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
-    }
-    migrate_fd_cancel(current_migration);
-}
-
 void migration_shutdown(void)
 {
     /*
@@ -1555,12 +1546,17 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
     migrate_set_error(s, error);
 }
 
-static void migrate_fd_cancel(MigrationState *s)
+void migration_cancel(void)
 {
+    MigrationState *s = migrate_get_current();
     int old_state ;
     bool setup = (s->state == MIGRATION_STATUS_SETUP);
 
-    trace_migrate_fd_cancel();
+    trace_migration_cancel();
+
+    if (migrate_dirty_limit()) {
+        qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
+    }
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->rp_state.from_dst_file) {
diff --git a/migration/trace-events b/migration/trace-events
index 12b262f8ee..d22600abe6 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -156,7 +156,7 @@ multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostnam
 migrate_set_state(const char *new_state) "new state %s"
 migrate_fd_cleanup(void) ""
 migrate_error(const char *error_desc) "error=%s"
-migrate_fd_cancel(void) ""
+migration_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
 migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
 migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
-- 
2.35.3


