Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8E6E69E95
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 22:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEUP-00076z-Pr; Mon, 02 Dec 2024 17:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUM-000761-06
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:54 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUJ-0003cw-OB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:53 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A053D1F45F;
 Mon,  2 Dec 2024 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ervb2K7sqVuvepYZrDqX+K0WK8EkwpeLtzoNV7Q9jlQ=;
 b=N9Hi3P4I88AcP1PSIe/VQfClR0IL2OUYZ8qgyDHmm2pIZ+xdqu9Bq0uvGBwTns5g2W53Yb
 SBOOM/+SaBjOBwYtTxMZrpzKc0EclWS0H76P8DYNSZ7SpnUZdpsCfFQ/MtV3BrExeDgfZS
 wEkQfmFGy62S/DxmJslg+ZRWzLOVmNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ervb2K7sqVuvepYZrDqX+K0WK8EkwpeLtzoNV7Q9jlQ=;
 b=0zzRahitHBdg1T5xEgkH973A9OOSJNmFE1+n1wogkCpwK+As6I7uoMrVIfGSPTbtLqmZb9
 lGNtzwB2S68KFXAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ervb2K7sqVuvepYZrDqX+K0WK8EkwpeLtzoNV7Q9jlQ=;
 b=N9Hi3P4I88AcP1PSIe/VQfClR0IL2OUYZ8qgyDHmm2pIZ+xdqu9Bq0uvGBwTns5g2W53Yb
 SBOOM/+SaBjOBwYtTxMZrpzKc0EclWS0H76P8DYNSZ7SpnUZdpsCfFQ/MtV3BrExeDgfZS
 wEkQfmFGy62S/DxmJslg+ZRWzLOVmNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ervb2K7sqVuvepYZrDqX+K0WK8EkwpeLtzoNV7Q9jlQ=;
 b=0zzRahitHBdg1T5xEgkH973A9OOSJNmFE1+n1wogkCpwK+As6I7uoMrVIfGSPTbtLqmZb9
 lGNtzwB2S68KFXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4007113A31;
 Mon,  2 Dec 2024 22:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0KWwAU0uTmdlIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Dec 2024 22:01:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 5/6] migration: Fix hang after error in destination setup phase
Date: Mon,  2 Dec 2024 19:01:36 -0300
Message-Id: <20241202220137.32584-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202220137.32584-1-farosas@suse.de>
References: <20241202220137.32584-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

If the destination side fails at migration_ioc_process_incoming()
before starting the coroutine, it will report the error but QEMU will
not exit.

Set the migration state to FAILED and exit the process if
exit-on-error allows.

CC: Thomas Huth <thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2633
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 11 ++++++-----
 migration/migration.c | 31 ++++++++++++++++++-------------
 migration/migration.h |  2 +-
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index f9de064f3b..6d7f9172d8 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -40,13 +40,14 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         migration_tls_channel_process_incoming(s, ioc, &local_err);
+
+        if (local_err) {
+            error_report_err(local_err);
+        }
+
     } else {
         migration_ioc_register_yank(ioc);
-        migration_ioc_process_incoming(ioc, &local_err);
-    }
-
-    if (local_err) {
-        error_report_err(local_err);
+        migration_ioc_process_incoming(ioc);
     }
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 8a61cc26d7..cd88ebc875 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -943,7 +943,7 @@ static bool migration_should_start_incoming(bool main_channel)
     return true;
 }
 
-void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
+void migration_ioc_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
@@ -966,10 +966,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
          * issue is not possible.
          */
         ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                          sizeof(channel_magic), errp);
-
+                                          sizeof(channel_magic), &local_err);
         if (ret != 0) {
-            return;
+            goto err;
         }
 
         default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
@@ -977,8 +976,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         default_channel = !mis->from_src_file;
     }
 
-    if (multifd_recv_setup(errp) != 0) {
-        return;
+    if (multifd_recv_setup(&local_err) != 0) {
+        goto err;
     }
 
     if (default_channel) {
@@ -995,18 +994,24 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
             postcopy_preempt_new_channel(mis, f);
         }
         if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+            goto err;
         }
     }
 
-    if (migration_should_start_incoming(default_channel)) {
-        /* If it's a recovery, we're done */
-        if (postcopy_try_recover()) {
-            return;
-        }
+    if (migration_should_start_incoming(default_channel) &&
+        !postcopy_try_recover()) {
         migration_incoming_process();
     }
+
+    return;
+
+err:
+    error_report_err(local_err);
+    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_FAILED);
+    if (mis->exit_on_error) {
+        exit(EXIT_FAILURE);
+    }
 }
 
 /**
diff --git a/migration/migration.h b/migration/migration.h
index 0956e9274b..c367e5ea40 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -477,7 +477,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
                        MigrationStatus new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
-void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
+void migration_ioc_process_incoming(QIOChannel *ioc);
 void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
-- 
2.35.3


