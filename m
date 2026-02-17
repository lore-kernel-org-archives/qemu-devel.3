Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E2EE909D4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkC-0002yh-M6; Tue, 17 Feb 2026 11:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNk8-0002kn-HI
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:08 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNk6-0003EF-4s
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:08 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC255BCE9;
 Tue, 17 Feb 2026 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecyzQFW+bvF4ZS7tAIDWyJAD7Cb1x9QE6A75KawzHrY=;
 b=W31zP6Dl4r7cgLH1HOU68Kczcp3iBfYEr25q+irmW51myJaa6wjMD7j/TP0oHYcD+HUwHr
 vB+vg+4geWJyUp0nzauglOj5bkj6g7FFV1MH32rDKSujHPGOUGRWW7aswpSb/0qU5mUkSJ
 PHRShfoxdMEwwOpSW2aId6I9asqns9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecyzQFW+bvF4ZS7tAIDWyJAD7Cb1x9QE6A75KawzHrY=;
 b=hg9Gp2eJ8DDPmw1/VH2ZR7r/jKqmUEWARIUh4aK7eRjpQpjVXdoXS3Pp3kO1GVE6Viaih/
 9nLbyYDz9x3QqADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecyzQFW+bvF4ZS7tAIDWyJAD7Cb1x9QE6A75KawzHrY=;
 b=W31zP6Dl4r7cgLH1HOU68Kczcp3iBfYEr25q+irmW51myJaa6wjMD7j/TP0oHYcD+HUwHr
 vB+vg+4geWJyUp0nzauglOj5bkj6g7FFV1MH32rDKSujHPGOUGRWW7aswpSb/0qU5mUkSJ
 PHRShfoxdMEwwOpSW2aId6I9asqns9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecyzQFW+bvF4ZS7tAIDWyJAD7Cb1x9QE6A75KawzHrY=;
 b=hg9Gp2eJ8DDPmw1/VH2ZR7r/jKqmUEWARIUh4aK7eRjpQpjVXdoXS3Pp3kO1GVE6Viaih/
 9nLbyYDz9x3QqADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26DE63EA66;
 Tue, 17 Feb 2026 16:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mCIxNxuUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 22/32] migration: Split
 qemu_savevm_state_complete_precopy_non_iterable()
Date: Tue, 17 Feb 2026 13:14:33 -0300
Message-ID: <20260217161443.12738-23-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Peter Xu <peterx@redhat.com>

Split the function, making itself to be the helper to dump all non-iterable
device states (early_vmsd excluded).  Move the precopy end logic out to the
two callers that need it.

With it, we can remove the in_postcopy parameter.  Meanwhile, renaming the
function to be qemu_savevm_state_non_iterable(): we don't need the keyword
"complete" because non-iterable doesn't iterate anyway, and we don't need
precopy because we moved precopy specialties out.

NOTE: this patch introduced one new migrate_get_current() user; will be
removed in follow up patch.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-17-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  7 +++++--
 migration/savevm.c    | 12 ++++--------
 migration/savevm.h    |  3 +--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b7a2eee25c..b1d421953f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2552,7 +2552,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    ret = qemu_savevm_state_complete_precopy_non_iterable(fb, true);
+    ret = qemu_savevm_state_non_iterable(fb);
     if (ret) {
         error_setg(errp, "Postcopy save non-iterable device states failed");
         goto fail_closefb;
@@ -3690,9 +3690,12 @@ static void *bg_migration_thread(void *opaque)
         goto fail;
     }
 
-    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false)) {
+    if (qemu_savevm_state_non_iterable(fb)) {
         goto fail;
     }
+
+    qemu_savevm_state_end_precopy(s, fb);
+
     /*
      * Since we are going to get non-iterable state data directly
      * from s->bioc->data, explicit flush is needed here.
diff --git a/migration/savevm.c b/migration/savevm.c
index 41560b97a4..e1918d4f38 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1691,8 +1691,7 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
     qemu_savevm_state_vm_desc(s, f);
 }
 
-int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-                                                    bool in_postcopy)
+int qemu_savevm_state_non_iterable(QEMUFile *f)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
@@ -1724,11 +1723,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                     end_ts_each - start_ts_each);
     }
 
-    if (!in_postcopy) {
-        /* Postcopy stream will still be going */
-        qemu_savevm_state_end_precopy(ms, f);
-    }
-
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
 
     return 0;
@@ -1743,11 +1737,13 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f)
         return ret;
     }
 
-    ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
+    ret = qemu_savevm_state_non_iterable(f);
     if (ret) {
         return ret;
     }
 
+    qemu_savevm_state_end_precopy(migrate_get_current(), f);
+
     return qemu_fflush(f);
 }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index f957f851ef..57b96133d5 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -74,8 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
-int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-        bool in_postcopy);
+int qemu_savevm_state_non_iterable(QEMUFile *f);
 
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp);
-- 
2.51.0


