Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94A2E69E97
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 22:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEUM-000769-P3; Mon, 02 Dec 2024 17:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUJ-00075Q-1w
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:51 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUG-0003cM-Gr
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 12E5D1F458;
 Mon,  2 Dec 2024 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1fOYI6uObo8w+HKEL4A4rk7nMa0YD8YUYkVRHOO2Bw=;
 b=Dh4mC0JmjSm5jREIrbpqie9V0U1f6Feorc+7e2lbBSdVJrxjKYfWZ7zA7+JK2e+4MIv6RI
 z2KrugK1Mlfwh7OXN1CeMeCkKqktjovEhRpMM5oB+KG5bIwmKz3p1wJ/uF+J7l1wgL0+1n
 rp4MSKWhHguL7F6wxenHuTqNy62r8eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1fOYI6uObo8w+HKEL4A4rk7nMa0YD8YUYkVRHOO2Bw=;
 b=r2x8GKnCRfGk4p8H/QJcZR1Dhoni18Gba0P3j7H2KWRuWxcE3gH+AGoCxEsqXrr+d9zLL0
 MDG8UpWi/S3mhyDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dh4mC0Jm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r2x8GKnC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1fOYI6uObo8w+HKEL4A4rk7nMa0YD8YUYkVRHOO2Bw=;
 b=Dh4mC0JmjSm5jREIrbpqie9V0U1f6Feorc+7e2lbBSdVJrxjKYfWZ7zA7+JK2e+4MIv6RI
 z2KrugK1Mlfwh7OXN1CeMeCkKqktjovEhRpMM5oB+KG5bIwmKz3p1wJ/uF+J7l1wgL0+1n
 rp4MSKWhHguL7F6wxenHuTqNy62r8eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1fOYI6uObo8w+HKEL4A4rk7nMa0YD8YUYkVRHOO2Bw=;
 b=r2x8GKnCRfGk4p8H/QJcZR1Dhoni18Gba0P3j7H2KWRuWxcE3gH+AGoCxEsqXrr+d9zLL0
 MDG8UpWi/S3mhyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D758F13A31;
 Mon,  2 Dec 2024 22:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4PGxJkkuTmdlIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Dec 2024 22:01:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/6] migration: Fix postcopy listen thread exit
Date: Mon,  2 Dec 2024 19:01:34 -0300
Message-Id: <20241202220137.32584-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202220137.32584-1-farosas@suse.de>
References: <20241202220137.32584-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12E5D1F458
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

There are a couple of problems with exiting the postcopy listen
thread. It does not honor the exit-on-error flag and always exits QEMU
upon error. It also does not behave well if a qmp_migrate_cancel() is
issued while postcopy is paused, it either hangs during retry or
crashes during access of a non-recovered QEMUFile (i.e. NULL).

Fix it by adding support for exit-on-error and avoiding accessing the
NULL file pointer.

While here, move the end tracepoint to a later part of the function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 60 +++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 98821c8120..44b7f883f7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2004,11 +2004,14 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * want a wrapper for the QEMUFile handle.
      */
     f = mis->from_src_file;
+    if (!f) {
+        /* postcopy pause never got recovered */
+        goto out;
+    }
 
     /* And non-blocking again so we don't block in any cleanup */
     qemu_file_set_blocking(f, false);
 
-    trace_postcopy_ram_listen_thread_exit();
     if (load_res < 0) {
         qemu_file_set_error(f, load_res);
         dirty_bitmap_mig_cancel_incoming();
@@ -2021,10 +2024,6 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          "bitmaps are correctly migrated and valid.",
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
-        } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
-            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                           MIGRATION_STATUS_FAILED);
         }
     }
     if (load_res >= 0) {
@@ -2034,31 +2033,40 @@ static void *postcopy_ram_listen_thread(void *opaque)
          * state yet; wait for the end of the main thread.
          */
         qemu_event_wait(&mis->main_thread_load_event);
-    }
-    postcopy_ram_incoming_cleanup(mis);
 
-    if (load_res < 0) {
+        postcopy_ram_incoming_cleanup(mis);
+
+        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                          MIGRATION_STATUS_COMPLETED);
+
         /*
-         * If something went wrong then we have a bad state so exit;
-         * depending how far we got it might be possible at this point
-         * to leave the guest running and fire MCEs for pages that never
-         * arrived as a desperate recovery step.
+         * If everything has worked fine, then the main thread has waited
+         * for us to start, and we're the last use of the mis.
          */
-        rcu_unregister_thread();
-        exit(EXIT_FAILURE);
+        migration_incoming_state_destroy();
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                   MIGRATION_STATUS_COMPLETED);
-    /*
-     * If everything has worked fine, then the main thread has waited
-     * for us to start, and we're the last use of the mis.
-     * (If something broke then qemu will have to exit anyway since it's
-     * got a bad migration state).
-     */
-    migration_incoming_state_destroy();
-
+out:
+    trace_postcopy_ram_listen_thread_exit();
     rcu_unregister_thread();
+
+    if (load_res < 0) {
+        postcopy_ram_incoming_cleanup(mis);
+
+        error_report("%s: loadvm failed: %d", __func__, load_res);
+        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        if (mis->exit_on_error) {
+            /*
+             * If something went wrong then we have a bad state so exit;
+             * depending how far we got it might be possible at this point
+             * to leave the guest running and fire MCEs for pages that never
+             * arrived as a desperate recovery step.
+             */
+            exit(EXIT_FAILURE);
+        }
+    }
+
     mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
@@ -2921,7 +2929,9 @@ out:
             migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
-            goto retry;
+            if (f) {
+                goto retry;
+            }
         }
     }
     return ret;
-- 
2.35.3


