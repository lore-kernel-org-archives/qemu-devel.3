Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5314E909D4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkP-0003rL-O9; Tue, 17 Feb 2026 11:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkN-0003iw-TL
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:24 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkM-0003Ft-3o
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E7B73E74C;
 Tue, 17 Feb 2026 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zbWgwvK+X0BrdGhOjGF5ANg1JjNKZQQa6mQiQvFaE=;
 b=cvH97DpwE+WNHQtTocmeGeexoOueWneRLUldUcm3rgp+ZrwPVd46Xz7Wp1IkL2/Dxcp8y/
 iXPrdia7ZyNFnRmg5EP9LU1OwaeBH7xgkI+pxAFMRDWOI1Ju7LdG8kH/ZJTz8Jb0Whmle8
 f3XSuHriDLMCi7FT0PkmsoUS1wO7LXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zbWgwvK+X0BrdGhOjGF5ANg1JjNKZQQa6mQiQvFaE=;
 b=CPYLc4mj3fogkk/CZmphvEwNT0Lc1A7KjOWEC+Caj08AMIF92j/9TgntTPZ+KAb2x1A255
 v1viDJDPFcTjycAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cvH97Dpw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CPYLc4mj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zbWgwvK+X0BrdGhOjGF5ANg1JjNKZQQa6mQiQvFaE=;
 b=cvH97DpwE+WNHQtTocmeGeexoOueWneRLUldUcm3rgp+ZrwPVd46Xz7Wp1IkL2/Dxcp8y/
 iXPrdia7ZyNFnRmg5EP9LU1OwaeBH7xgkI+pxAFMRDWOI1Ju7LdG8kH/ZJTz8Jb0Whmle8
 f3XSuHriDLMCi7FT0PkmsoUS1wO7LXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zbWgwvK+X0BrdGhOjGF5ANg1JjNKZQQa6mQiQvFaE=;
 b=CPYLc4mj3fogkk/CZmphvEwNT0Lc1A7KjOWEC+Caj08AMIF92j/9TgntTPZ+KAb2x1A255
 v1viDJDPFcTjycAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04EAD3EA66;
 Tue, 17 Feb 2026 16:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6PHiLiWUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 28/32] migration: Make qemu_savevm_state_non_iterable() take
 errp
Date: Tue, 17 Feb 2026 13:14:39 -0300
Message-ID: <20260217161443.12738-29-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3E7B73E74C
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

Let the function report errors to upper layers.  Out of three current
users, two of them already process the errors, except one outlier,
qemu_savevm_state_complete_precopy(), where we do it manually for now with
a comment for TODO.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-23-peterx@redhat.com
[add space in error_prepend string]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  8 ++++----
 migration/savevm.c    | 13 +++++++------
 migration/savevm.h    |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f9eec4b25a..a5b0465ed3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2552,9 +2552,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    ret = qemu_savevm_state_non_iterable(fb);
+    ret = qemu_savevm_state_non_iterable(fb, errp);
     if (ret) {
-        error_setg(errp, "Postcopy save non-iterable device states failed");
+        error_prepend(errp, "Postcopy save non-iterable states failed: ");
         goto fail_closefb;
     }
 
@@ -3687,8 +3687,8 @@ static void *bg_migration_thread(void *opaque)
         goto fail_with_bql;
     }
 
-    if (qemu_savevm_state_non_iterable(fb)) {
-        error_setg(&local_err, "Failed to save non-iterable devices");
+    if (qemu_savevm_state_non_iterable(fb, &local_err)) {
+        error_prepend(&local_err, "Failed to save non-iterable devices ");
         goto fail_with_bql;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index c16951b532..130b9764a7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1710,13 +1710,12 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
     qemu_savevm_state_vm_desc(s, f);
 }
 
-int qemu_savevm_state_non_iterable(QEMUFile *f)
+int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
-    Error *local_err = NULL;
     int ret;
 
     /* Making sure cpu states are synchronized before saving non-iterable */
@@ -1730,10 +1729,8 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
-        ret = vmstate_save(f, se, vmdesc, &local_err);
+        ret = vmstate_save(f, se, vmdesc, errp);
         if (ret) {
-            migrate_error_propagate(ms, error_copy(local_err));
-            error_report_err(local_err);
             return ret;
         }
 
@@ -1750,6 +1747,7 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
 int qemu_savevm_state_complete_precopy(MigrationState *s)
 {
     QEMUFile *f = s->to_dst_file;
+    Error *local_err = NULL;
     int ret;
 
     ret = qemu_savevm_state_complete_precopy_iterable(f, false);
@@ -1757,8 +1755,11 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
         return ret;
     }
 
-    ret = qemu_savevm_state_non_iterable(f);
+    /* TODO: pass error upper */
+    ret = qemu_savevm_state_non_iterable(f, &local_err);
     if (ret) {
+        migrate_error_propagate(s, error_copy(local_err));
+        error_report_err(local_err);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index f2750eca09..6a589b2990 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -74,7 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
-int qemu_savevm_state_non_iterable(QEMUFile *f);
+int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
                                          Error **errp);
-- 
2.51.0


