Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D172E909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkE-0003Bk-Db; Tue, 17 Feb 2026 11:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkC-0002zI-K3
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkA-0003Ep-CU
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:12 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E1D23E725;
 Tue, 17 Feb 2026 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3VqrKrhdN5UPnNL8q16Ourr8Cn92niRQK+xWCs/D10=;
 b=A49DJAyCNnsOP7m7aht2B0NePSLNZt/TfUpWfNeXJPo6CmaZCHb6gQJ36Hz+ao+IGGQtg+
 WE6msDTSHXxHmpUr9g9QlSnANQE1o5KM8c/VgYz5H7ajJkPPGz8NLvKcqmTdkH83xpPsl+
 I9z3yplpuLySOuzEoGUCUdOGMju5quk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3VqrKrhdN5UPnNL8q16Ourr8Cn92niRQK+xWCs/D10=;
 b=9tgZ0aEObuQDHEu/w/vDLlBFlVnNpuQ0a0zeEAY1VFelaPyFd28Cks/50zRco52pyMP39a
 aMeI2P+w7q4wl8Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3VqrKrhdN5UPnNL8q16Ourr8Cn92niRQK+xWCs/D10=;
 b=A49DJAyCNnsOP7m7aht2B0NePSLNZt/TfUpWfNeXJPo6CmaZCHb6gQJ36Hz+ao+IGGQtg+
 WE6msDTSHXxHmpUr9g9QlSnANQE1o5KM8c/VgYz5H7ajJkPPGz8NLvKcqmTdkH83xpPsl+
 I9z3yplpuLySOuzEoGUCUdOGMju5quk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3VqrKrhdN5UPnNL8q16Ourr8Cn92niRQK+xWCs/D10=;
 b=9tgZ0aEObuQDHEu/w/vDLlBFlVnNpuQ0a0zeEAY1VFelaPyFd28Cks/50zRco52pyMP39a
 aMeI2P+w7q4wl8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 147323EA66;
 Tue, 17 Feb 2026 16:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cB6yMiCUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 25/32] migration: Refactor qemu_savevm_state_setup()
Date: Tue, 17 Feb 2026 13:14:36 -0300
Message-ID: <20260217161443.12738-26-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
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

Split it into two smaller chunks:

  - Dump of early_setup VMSDs
  - Dump of save_setup() sections

They're mutual exclusive, hence we can run two loops and do them
sequentially.  This will cause migration thread to loop one more time, but
it should be fine when migration just started and only do it once.  It's
needed because we will need to reuse the early_vmsd helper later to
deduplicate code elsewhere.

QEMU almost sticks with qemu_savevm_state_XXX() to represent the dump of
vmstates's section XXX.  With that in mind, this patch renamed the original
qemu_savevm_state_setup() to qemu_savevm_state_do_setup() instead.

So after this patch:

  - qemu_savevm_state_non_iterable_early() dumps early_vmsds only,
  - qemu_savevm_state_setup() dumps save_setup() sections only,
  - qemu_savevm_state_do_setup() does all things needed during setup
    phase (including migration SETUP notifies)

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-20-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  4 ++--
 migration/savevm.c    | 56 ++++++++++++++++++++++++++++++-------------
 migration/savevm.h    |  6 +++--
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 27e4456429..f81ac21d4e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3540,7 +3540,7 @@ static void *migration_thread(void *opaque)
     }
 
     bql_lock();
-    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
+    ret = qemu_savevm_state_do_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
@@ -3663,7 +3663,7 @@ static void *bg_migration_thread(void *opaque)
 
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
-    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
+    ret = qemu_savevm_state_do_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 0683a103c8..b04a21ffc9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1367,29 +1367,33 @@ int qemu_savevm_state_prepare(Error **errp)
     return 0;
 }
 
-int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
+int qemu_savevm_state_non_iterable_early(QEMUFile *f,
+                                         JSONWriter *vmdesc,
+                                         Error **errp)
 {
-    ERRP_GUARD();
-    MigrationState *ms = migrate_get_current();
-    JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
-    int ret = 0;
+    int ret;
 
-    if (vmdesc) {
-        json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
-        json_writer_start_array(vmdesc, "devices");
-    }
-
-    trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
-                break;
+                return ret;
             }
-            continue;
         }
+    }
 
+    return 0;
+}
+
+static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    trace_savevm_state_setup();
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
@@ -1399,14 +1403,34 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
             }
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
-
         ret = se->ops->save_setup(f, se->opaque, errp);
         save_section_footer(f, se);
         if (ret < 0) {
-            break;
+            return ret;
         }
     }
 
+    return 0;
+}
+
+int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp)
+{
+    ERRP_GUARD();
+    MigrationState *ms = migrate_get_current();
+    JSONWriter *vmdesc = ms->vmdesc;
+    int ret;
+
+    if (vmdesc) {
+        json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
+        json_writer_start_array(vmdesc, "devices");
+    }
+
+    ret = qemu_savevm_state_non_iterable_early(f, vmdesc, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ret = qemu_savevm_state_setup(f, errp);
     if (ret) {
         return ret;
     }
@@ -1826,7 +1850,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     ms->to_dst_file = f;
 
     qemu_savevm_state_header(f);
-    ret = qemu_savevm_state_setup(f, errp);
+    ret = qemu_savevm_state_do_setup(f, errp);
     if (ret) {
         goto cleanup;
     }
diff --git a/migration/savevm.h b/migration/savevm.h
index bded5e2a6c..f2750eca09 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -34,7 +34,7 @@
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
-int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
+int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_send_header(QEMUFile *f);
@@ -75,7 +75,9 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_non_iterable(QEMUFile *f);
-
+int qemu_savevm_state_non_iterable_early(QEMUFile *f,
+                                         JSONWriter *vmdesc,
+                                         Error **errp);
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp);
 
-- 
2.51.0


