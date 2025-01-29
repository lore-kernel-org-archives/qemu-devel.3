Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051C4C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXl-000771-3n; Wed, 29 Jan 2025 11:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVu-0003Qd-59
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:05 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVs-0005M3-9s
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F5211F387;
 Wed, 29 Jan 2025 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0E/r7R+Ct9F1RHUCd97bn7fFqlbryOsiepQ28ewzTs=;
 b=npdUZvcOxjAUTfOaXSaGSZBw1yiA4KbXGNwkZyRcmXmnB6a9Z/+3d+y4l0/lPW/DhMZgtO
 RsfDl++g1fSsdzECFrA7lTYQ5MX9sESJCZ5AJ3qeXiUYptCfjy1486CrJg0g4ZBqjXnCUl
 ySIGrf3rm9dmBZV3iggNeaRaFUTvVdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0E/r7R+Ct9F1RHUCd97bn7fFqlbryOsiepQ28ewzTs=;
 b=te4VDi3c1JvSR2PwJx+mO3LKqbu7Iztq+ULEfCcaJhej8cXdu+EMzSeGK+0NdkuTnTUdNM
 +P6GSm2Cw5m4avAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0E/r7R+Ct9F1RHUCd97bn7fFqlbryOsiepQ28ewzTs=;
 b=npdUZvcOxjAUTfOaXSaGSZBw1yiA4KbXGNwkZyRcmXmnB6a9Z/+3d+y4l0/lPW/DhMZgtO
 RsfDl++g1fSsdzECFrA7lTYQ5MX9sESJCZ5AJ3qeXiUYptCfjy1486CrJg0g4ZBqjXnCUl
 ySIGrf3rm9dmBZV3iggNeaRaFUTvVdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0E/r7R+Ct9F1RHUCd97bn7fFqlbryOsiepQ28ewzTs=;
 b=te4VDi3c1JvSR2PwJx+mO3LKqbu7Iztq+ULEfCcaJhej8cXdu+EMzSeGK+0NdkuTnTUdNM
 +P6GSm2Cw5m4avAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 932C8137DB;
 Wed, 29 Jan 2025 16:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EB7CFPVQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 27/42] migration: Do not construct JSON description if
 suppressed
Date: Wed, 29 Jan 2025 13:00:44 -0300
Message-Id: <20250129160059.6987-28-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

QEMU machine has a property "suppress-vmdesc". When it is enabled, QEMU
will stop attaching JSON VM description at the end of the precopy migration
stream (postcopy is never affected because postcopy never attach that).

However even if it's suppressed by the user, the source QEMU will still
construct the JSON descriptions, which is a complete waste of CPU and
memory resources.

To avoid it, only create the JSON writer object if suppress-vmdesc is not
specified.

Luckily, vmstate_save() already supports vmdesc==NULL, so only a few spots
that are left to be prepared that vmdesc can be NULL now.

When at it, move the init / destroy of the JSON writer object to start /
end of the migration - the JSON writer object is a sub-struct of migration
state, and that looks like the only object that was dynamically allocated /
destroyed within migration process.  Make it the same as the rest objects
that migration uses.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-3-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  9 +++++---
 migration/migration.h |  1 +
 migration/savevm.c    | 49 +++++++++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 88b09914ec..5c335cc30b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1431,8 +1431,8 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     g_free(s->hostname);
     s->hostname = NULL;
-    json_writer_free(s->vmdesc);
-    s->vmdesc = NULL;
+
+    g_clear_pointer(&s->vmdesc, json_writer_free);
 
     qemu_savevm_state_cleanup();
     cpr_state_close();
@@ -1722,7 +1722,10 @@ int migrate_init(MigrationState *s, Error **errp)
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
-    s->vmdesc = NULL;
+
+    if (should_send_vmdesc()) {
+        s->vmdesc = json_writer_new(false);
+    }
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/migration.h b/migration/migration.h
index fb1b8f99d3..4c1fafc2b5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -552,6 +552,7 @@ void migration_bitmap_sync_precopy(bool last_stage);
 
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
+bool should_send_vmdesc(void);
 
 /* migration/block-active.c */
 void migration_block_active_setup(bool active);
diff --git a/migration/savevm.c b/migration/savevm.c
index b8859d367f..cfe9dfaf5c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1231,8 +1231,7 @@ void qemu_savevm_non_migratable_list(strList **reasons)
 void qemu_savevm_state_header(QEMUFile *f)
 {
     MigrationState *s = migrate_get_current();
-
-    s->vmdesc = json_writer_new(false);
+    JSONWriter *vmdesc = s->vmdesc;
 
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
@@ -1241,16 +1240,21 @@ void qemu_savevm_state_header(QEMUFile *f)
     if (s->send_configuration) {
         qemu_put_byte(f, QEMU_VM_CONFIGURATION);
 
-        /*
-         * This starts the main json object and is paired with the
-         * json_writer_end_object in
-         * qemu_savevm_state_complete_precopy_non_iterable
-         */
-        json_writer_start_object(s->vmdesc, NULL);
+        if (vmdesc) {
+            /*
+             * This starts the main json object and is paired with the
+             * json_writer_end_object in
+             * qemu_savevm_state_complete_precopy_non_iterable
+             */
+            json_writer_start_object(vmdesc, NULL);
+            json_writer_start_object(vmdesc, "configuration");
+        }
 
-        json_writer_start_object(s->vmdesc, "configuration");
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state, s->vmdesc);
-        json_writer_end_object(s->vmdesc);
+        vmstate_save_state(f, &vmstate_configuration, &savevm_state, vmdesc);
+
+        if (vmdesc) {
+            json_writer_end_object(vmdesc);
+        }
     }
 }
 
@@ -1296,16 +1300,19 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
 {
     ERRP_GUARD();
     MigrationState *ms = migrate_get_current();
+    JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
     int ret = 0;
 
-    json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
-    json_writer_start_array(ms->vmdesc, "devices");
+    if (vmdesc) {
+        json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
+        json_writer_start_array(vmdesc, "devices");
+    }
 
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
-            ret = vmstate_save(f, se, ms->vmdesc, errp);
+            ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
                 migrate_set_error(ms, *errp);
                 qemu_file_set_error(f, ret);
@@ -1424,7 +1431,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
     return all_finished;
 }
 
-static bool should_send_vmdesc(void)
+bool should_send_vmdesc(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
 
@@ -1564,21 +1571,17 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
 
-        json_writer_end_array(vmdesc);
-        json_writer_end_object(vmdesc);
-        vmdesc_len = strlen(json_writer_get(vmdesc));
+        if (vmdesc) {
+            json_writer_end_array(vmdesc);
+            json_writer_end_object(vmdesc);
+            vmdesc_len = strlen(json_writer_get(vmdesc));
 
-        if (should_send_vmdesc()) {
             qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
             qemu_put_be32(f, vmdesc_len);
             qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
         }
     }
 
-    /* Free it now to detect any inconsistencies. */
-    json_writer_free(vmdesc);
-    ms->vmdesc = NULL;
-
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
 
     return 0;
-- 
2.35.3


