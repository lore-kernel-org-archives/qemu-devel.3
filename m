Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E984C021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj759-0004RM-Ie; Fri, 14 Feb 2025 20:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2N4-0006fn-Nv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2My-0002Fm-3x
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD06F21183;
 Fri, 14 Feb 2025 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xdmOVwEfRUQTZUGLfmBpKaelqOYaisFx/30xx8tRag=;
 b=MGnlELpBac+onkjQXQqdblyjqzv8EKy4Yvmw+fcD78PCLPmD/u5R8zg1lAR7/U63esWgT+
 9gy3qmFlhbamE+0RDVL7SJa4SgOtcIoxa+wUor8QLP2Ib+g4Z5rAWHd700N95tudekIuP/
 KqI0GOAcgFN66f5jcFdqS3n8kpzRDrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xdmOVwEfRUQTZUGLfmBpKaelqOYaisFx/30xx8tRag=;
 b=GcafPsLw64ccvnNQ2Az1j0gxlB2TRmtVMQ63n4OZrOgZJgymlbDfxWS9flfpicM3sRPWKf
 AaZx3UV6ky+Xz4Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xdmOVwEfRUQTZUGLfmBpKaelqOYaisFx/30xx8tRag=;
 b=MGnlELpBac+onkjQXQqdblyjqzv8EKy4Yvmw+fcD78PCLPmD/u5R8zg1lAR7/U63esWgT+
 9gy3qmFlhbamE+0RDVL7SJa4SgOtcIoxa+wUor8QLP2Ib+g4Z5rAWHd700N95tudekIuP/
 KqI0GOAcgFN66f5jcFdqS3n8kpzRDrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xdmOVwEfRUQTZUGLfmBpKaelqOYaisFx/30xx8tRag=;
 b=GcafPsLw64ccvnNQ2Az1j0gxlB2TRmtVMQ63n4OZrOgZJgymlbDfxWS9flfpicM3sRPWKf
 AaZx3UV6ky+Xz4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D279E13B02;
 Fri, 14 Feb 2025 20:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EPiXI1qor2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 14/22] migration: Don't set FAILED state when cancelling
Date: Fri, 14 Feb 2025 17:31:51 -0300
Message-Id: <20250214203159.30168-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

The expected outcome from qmp_migrate_cancel() is that the source
migration goes to the terminal state
MIGRATION_STATUS_CANCELLED. Anything different from this is a bug when
cancelling.

Make sure there is never a state transition from an unspecified state
into FAILED. Code that sets FAILED, should always either make sure
that the old state is not CANCELLING or specify the old state.

Note that the destination is allowed to go into FAILED, so there's no
issue there.

(I don't think this is relevant as a backport because cancelling does
work, it just doesn't show the right state at the end)

Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
Fixes: d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")
Fixes: 8518278a6a ("migration: implementation of background snapshot thread")
Fixes: bf78a046b9 ("migration: refactor migrate_fd_connect failures")
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20250213175927.19642-7-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 48c9ad3c96..c597aa707e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2648,7 +2648,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_preempt()) {
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
-            migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+            if (ms->state != MIGRATION_STATUS_CANCELLING) {
+                migrate_set_state(&ms->state, ms->state,
+                                  MIGRATION_STATUS_FAILED);
+            }
             error_setg(errp, "%s: Failed to establish preempt channel",
                        __func__);
             return -1;
@@ -2986,7 +2989,9 @@ fail:
         error_free(local_err);
     }
 
-    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    if (s->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    }
 }
 
 /**
@@ -3009,7 +3014,7 @@ static void bg_migration_completion(MigrationState *s)
         qemu_put_buffer(s->to_dst_file, s->bioc->data, s->bioc->usage);
         qemu_fflush(s->to_dst_file);
     } else if (s->state == MIGRATION_STATUS_CANCELLING) {
-        goto fail;
+        return;
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
@@ -3953,7 +3958,9 @@ void migration_connect(MigrationState *s, Error *error_in)
 
 fail:
     migrate_set_error(s, local_err);
-    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    if (s->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    }
     error_report_err(local_err);
     migration_cleanup(s);
 }
-- 
2.35.3


