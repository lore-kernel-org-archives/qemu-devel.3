Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3237DC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpH-0002db-Sr; Wed, 08 May 2024 19:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpE-0002cW-B9
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpC-0002IT-EJ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98D0D22D9F;
 Wed,  8 May 2024 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+6ohOs8r7Uea7SyKPjqTFtiY9Ar+9l4fF6rc6w5alA=;
 b=uZK7klXroTm9w+Q3XVnb23JLfivlde178sS4HfDblYHS7FjaexEO2+3hYDAsmi4dSZl560
 STb3LzCA6Wy6ej1L5HAUTMbqX0KMLRC6/i5pOdbcHMPqXEswWtY1gE8Elib9PXh4kMbm2N
 +ya7BVTze1nf8TQv4UycP4T/XA4hsNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+6ohOs8r7Uea7SyKPjqTFtiY9Ar+9l4fF6rc6w5alA=;
 b=tNEeotUerlv1VniUekcxh6VGp/FE1bLzqF8zSeht0Q38UqzneDzVmyOnGXasLSeSZe/ovF
 AouPg3EnQ+Thk7BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uZK7klXr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tNEeotUe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+6ohOs8r7Uea7SyKPjqTFtiY9Ar+9l4fF6rc6w5alA=;
 b=uZK7klXroTm9w+Q3XVnb23JLfivlde178sS4HfDblYHS7FjaexEO2+3hYDAsmi4dSZl560
 STb3LzCA6Wy6ej1L5HAUTMbqX0KMLRC6/i5pOdbcHMPqXEswWtY1gE8Elib9PXh4kMbm2N
 +ya7BVTze1nf8TQv4UycP4T/XA4hsNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+6ohOs8r7Uea7SyKPjqTFtiY9Ar+9l4fF6rc6w5alA=;
 b=tNEeotUerlv1VniUekcxh6VGp/FE1bLzqF8zSeht0Q38UqzneDzVmyOnGXasLSeSZe/ovF
 AouPg3EnQ+Thk7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B07813A27;
 Wed,  8 May 2024 23:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iCX3AFMMPGZ7FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 23:35:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL v2 02/13] migration: move trace-point from migrate_fd_error to
 migrate_set_error
Date: Wed,  8 May 2024 20:35:30 -0300
Message-Id: <20240508233541.2403-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508233541.2403-1-farosas@suse.de>
References: <20240508233541.2403-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 98D0D22D9F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Cover more cases by trace-point.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  | 4 +++-
 migration/trace-events | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b5af6b5105..2dc6a063e9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1421,6 +1421,9 @@ static void migrate_fd_cleanup_bh(void *opaque)
 void migrate_set_error(MigrationState *s, const Error *error)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
+
+    trace_migrate_error(error_get_pretty(error));
+
     if (!s->error) {
         s->error = error_copy(error);
     }
@@ -1444,7 +1447,6 @@ static void migrate_error_free(MigrationState *s)
 
 static void migrate_fd_error(MigrationState *s, const Error *error)
 {
-    trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_FAILED);
diff --git a/migration/trace-events b/migration/trace-events
index f0e1cb80c7..d0c44c3853 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -152,7 +152,7 @@ multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostnam
 # migration.c
 migrate_set_state(const char *new_state) "new state %s"
 migrate_fd_cleanup(void) ""
-migrate_fd_error(const char *error_desc) "error=%s"
+migrate_error(const char *error_desc) "error=%s"
 migrate_fd_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
 migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
-- 
2.35.3


