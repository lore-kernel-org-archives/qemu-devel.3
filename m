Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215D3F3C24A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaLt-0007XR-4J; Mon, 09 Mar 2026 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLk-0007LX-2N
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:45 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLh-0008Fz-Dp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69CF34D21F;
 Mon,  9 Mar 2026 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70zwbdfRBpO2Ij6TFJP4Y52oBVySwONpFxrtcgTAyVo=;
 b=OCRDIjIHPd4AhEjg8doz0YdFAdWR4foJ72aY95JXQGQ+/v9pWSdQmHqXNU6Ei5twml4tcS
 2WaaQ1Fctf5p/8ICHrUtXPK2C7VXQHJjv/O9fwRDIMV1yp54Kgc8aOmrRp0aUlmqep8EjJ
 EZcrZVzVCFjHLWYFfLRRZKKoUUZ0XFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70zwbdfRBpO2Ij6TFJP4Y52oBVySwONpFxrtcgTAyVo=;
 b=hisp3/Tdsww4xZ0B6P6w7wYm6544O14GoeP2egAVe4w6qCRfwSt4eQL+GiG16SGns6tQ6l
 6nNscxoxhSbAugAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OCRDIjIH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="hisp3/Td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70zwbdfRBpO2Ij6TFJP4Y52oBVySwONpFxrtcgTAyVo=;
 b=OCRDIjIHPd4AhEjg8doz0YdFAdWR4foJ72aY95JXQGQ+/v9pWSdQmHqXNU6Ei5twml4tcS
 2WaaQ1Fctf5p/8ICHrUtXPK2C7VXQHJjv/O9fwRDIMV1yp54Kgc8aOmrRp0aUlmqep8EjJ
 EZcrZVzVCFjHLWYFfLRRZKKoUUZ0XFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70zwbdfRBpO2Ij6TFJP4Y52oBVySwONpFxrtcgTAyVo=;
 b=hisp3/Tdsww4xZ0B6P6w7wYm6544O14GoeP2egAVe4w6qCRfwSt4eQL+GiG16SGns6tQ6l
 6nNscxoxhSbAugAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A5453EEF2;
 Mon,  9 Mar 2026 13:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +P1FADnGrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:08:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 21/22] migration: Keep s->rp_state.from_dst_file open until
 migration ends
Date: Mon,  9 Mar 2026 10:07:26 -0300
Message-ID: <20260309130730.20526-22-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
References: <20260309130730.20526-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Queue-Id: 69CF34D21F
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Lukas Straub <lukasstraub2@web.de>

This will be used in the next patch to allow COLO to reuse the return path.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260302-colo_unit_test_multifd-v11-20-d653fb3b1d80@web.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 53bf87c3fc..f949708629 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -97,7 +97,8 @@ static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static bool migration_switchover_start(MigrationState *s, Error **errp);
-static bool close_return_path_on_source(MigrationState *s);
+static bool stop_return_path_thread_on_source(MigrationState *s);
+static void migration_release_dst_files(MigrationState *ms);
 static void migration_completion_end(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
@@ -1281,7 +1282,8 @@ static void migration_cleanup(MigrationState *s)
     cpr_state_close();
     cpr_transfer_source_destroy(s);
 
-    close_return_path_on_source(s);
+    stop_return_path_thread_on_source(s);
+    migration_release_dst_files(s);
 
     if (s->migration_thread_running) {
         bql_unlock();
@@ -2217,6 +2219,7 @@ static void migration_release_dst_files(MigrationState *ms)
      * locking needed because this qemufile should only be managed by
      * return path thread.
      */
+    assert(!ms->rp_state.rp_thread_created);
     if (ms->postcopy_qemufile_src) {
         migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
         qemu_file_shutdown(ms->postcopy_qemufile_src);
@@ -2224,7 +2227,9 @@ static void migration_release_dst_files(MigrationState *ms)
         ms->postcopy_qemufile_src = NULL;
     }
 
-    qemu_fclose(file);
+    if (file) {
+        qemu_fclose(file);
+    }
 }
 
 /*
@@ -2410,7 +2415,7 @@ static void open_return_path_on_source(MigrationState *ms)
 }
 
 /* Return true if error detected, or false otherwise */
-static bool close_return_path_on_source(MigrationState *ms)
+static bool stop_return_path_thread_on_source(MigrationState *ms)
 {
     if (!ms->rp_state.rp_thread_created) {
         return false;
@@ -2432,7 +2437,6 @@ static bool close_return_path_on_source(MigrationState *ms)
 
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
-    migration_release_dst_files(ms);
     trace_migration_return_path_end_after();
 
     /* Return path will persist the error in MigrationState when quit */
@@ -2795,7 +2799,7 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
-    if (close_return_path_on_source(s)) {
+    if (stop_return_path_thread_on_source(s)) {
         goto fail;
     }
 
@@ -2949,7 +2953,8 @@ static MigThrError postcopy_pause(MigrationState *s)
          * path and just wait for the thread to finish. It will be
          * re-created when we resume.
          */
-        close_return_path_on_source(s);
+        stop_return_path_thread_on_source(s);
+        migration_release_dst_files(s);
 
         /*
          * Current channel is possibly broken. Release it.  Note that this is
-- 
2.51.0


