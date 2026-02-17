Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D515AE909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjB-00017q-5C; Tue, 17 Feb 2026 11:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNj9-00017Y-GR
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:07 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNj7-000369-LV
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 487285BD25;
 Tue, 17 Feb 2026 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXS3qPLaaXZTCH90dpwD2LMixcjitYHHrgCtwvXeX1M=;
 b=slWUp8qc2/LdKG/VYXlMo4E1TuJ0H1/zl+EBX4ezaZW+AmcO6DVLiFF8sICMXJWxxN0hLn
 Bbt4e318zYru0uahbwnCiX4mg3HYV9E/SNA8dCMpyZvujQzgkkJXmoou2qYq0LNbGZ2zS2
 ZS8Wy6LRZ8456tOOb05KxFSG8gr7Or0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXS3qPLaaXZTCH90dpwD2LMixcjitYHHrgCtwvXeX1M=;
 b=7DKaFzuqEkS1fFvWd/Y0KHrx3b4njF2gCXBjAP5Jmf6bZGLHBXrVziOLQs3qr1RBy3/QVk
 JgMUdHYbIqIIJdDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=slWUp8qc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7DKaFzuq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXS3qPLaaXZTCH90dpwD2LMixcjitYHHrgCtwvXeX1M=;
 b=slWUp8qc2/LdKG/VYXlMo4E1TuJ0H1/zl+EBX4ezaZW+AmcO6DVLiFF8sICMXJWxxN0hLn
 Bbt4e318zYru0uahbwnCiX4mg3HYV9E/SNA8dCMpyZvujQzgkkJXmoou2qYq0LNbGZ2zS2
 ZS8Wy6LRZ8456tOOb05KxFSG8gr7Or0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXS3qPLaaXZTCH90dpwD2LMixcjitYHHrgCtwvXeX1M=;
 b=7DKaFzuqEkS1fFvWd/Y0KHrx3b4njF2gCXBjAP5Jmf6bZGLHBXrVziOLQs3qr1RBy3/QVk
 JgMUdHYbIqIIJdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 917053EA66;
 Tue, 17 Feb 2026 16:14:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SC6cFfuTlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:14:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 03/32] migration: Notify migration FAILED before starting VM
Date: Tue, 17 Feb 2026 13:14:14 -0300
Message-ID: <20260217161443.12738-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 487285BD25
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

Devices may opt-in migration FAILED notifiers to be invoked when migration
fails.  Currently, the notifications happen in migration_cleanup().  It is
normally fine, but maybe not ideal if there's dependency of the fallback
v.s. VM starts.

This patch moves the FAILED notification earlier, so that if the failure
happened during switchover, it'll notify before VM restart.

After walking over all existing FAILED notifier users, I got the conclusion
that this should also be a cleaner approach at least from design POV.

We have these notifier users, where the first two do not need to trap
FAILED:

|----------------------------+-------------------------------------+---------------------|
| device                     | handler                             | events needed       |
|----------------------------+-------------------------------------+---------------------|
| gicv3                      | kvm_arm_gicv3_notifier              | DONE                |
| vfio_iommufd / vfio_legacy | vfio_cpr_reboot_notifier            | SETUP               |
| cpr-exec                   | cpr_exec_notifier                   | FAILED, DONE        |
| virtio-net                 | virtio_net_migration_state_notifier | SETUP, FAILED       |
| vfio                       | vfio_migration_state_notifier       | FAILED              |
| vdpa                       | vdpa_net_migration_state_notifier   | SETUP, FAILED       |
| spice [*]                  | migration_state_notifier            | SETUP, FAILED, DONE |
|----------------------------+-------------------------------------+---------------------|

For cpr-exec, it tries to cleanup some cpr-exec specific fd or env
variables.  This should be fine either way, as long as before
migration_cleanup().

For virtio-net, we need to re-plug the primary device back to guest in the
failover mode.  Likely benign.

VFIO needs to re-start the device if FAILED.  IIUC it should do it before
vm_start(), if the VFIO device can be put into a STOPed state due to
migration, we should logically make it running again before vCPUs run.

VDPA will disable SVQ when migration is FAILED.  Likely benign too, but
looks better if we can do it before resuming vCPUs.

For spice, we should rely on "spice_server_migrate_end(false)" to retake
the ownership.  Benign, but looks more reasonable if the spice client does
it before VM runs again.

Note that this change may introduce slightly more downtime, if the
migration failed exactly at the switchover phase.  But that's very rare,
and even if it happens, none of above expects a long delay, but a short
one, likely will be buried in the total downtime even if failed.

Cc: Cédric Le Goater <clg@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260126213614.3815900-4-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bd24006c1a..8d1c294b47 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1283,7 +1283,6 @@ static void migration_cleanup_json_writer(MigrationState *s)
 
 static void migration_cleanup(MigrationState *s)
 {
-    MigrationEventType type;
     QEMUFile *tmp = NULL;
 
     trace_migration_cleanup();
@@ -1333,9 +1332,14 @@ static void migration_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
-    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
-                                     MIG_EVENT_PRECOPY_DONE;
-    migration_call_notifiers(type, NULL);
+    /*
+     * FAILED notification should have already happened.  Notify DONE if
+     * migration completed successfully.
+     */
+    if (!migration_has_failed(s)) {
+        migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
+    }
+
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -3323,6 +3327,13 @@ static void migration_iteration_finish(MigrationState *s)
             error_free(local_err);
             break;
         }
+
+        /*
+         * Notify FAILED before starting VM, so that devices can invoke
+         * necessary fallbacks before vCPUs run again.
+         */
+        migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
+
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
-- 
2.51.0


