Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7960C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtF2-0002qQ-E0; Fri, 02 Aug 2024 10:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sZtF0-0002hR-5h; Fri, 02 Aug 2024 10:26:46 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sZtEy-000735-Fk; Fri, 02 Aug 2024 10:26:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA01C219B0;
 Fri,  2 Aug 2024 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722608802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5peLPVnPJdFKgWkLmCkRk/7aqMYafpu+BVohwSAu31s=;
 b=MaMffkvPb3LVgkfZ8X+m3TZQ5i16jbkI5mlposk+A8H3xZ4qo/h5veJN3NDDcoG2/EbBjQ
 lemYjkkbRzSmLuw/yZiwlHVi84rrITIUFQHxOgDWQHGYUYCXNPmVYqHTaBWOpbpwFiTrim
 N1hF6qwaewoasenJQ1slE3tfrjOiB+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722608802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5peLPVnPJdFKgWkLmCkRk/7aqMYafpu+BVohwSAu31s=;
 b=GUNwV7gEKmEoSwN+e5pyhXw8dgSn9gJdjHfKKuaRNXNZtfYKPn8T28QPqKzvmwDCgwNf4t
 +VElzl8Prt51dqCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MaMffkvP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GUNwV7gE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722608802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5peLPVnPJdFKgWkLmCkRk/7aqMYafpu+BVohwSAu31s=;
 b=MaMffkvPb3LVgkfZ8X+m3TZQ5i16jbkI5mlposk+A8H3xZ4qo/h5veJN3NDDcoG2/EbBjQ
 lemYjkkbRzSmLuw/yZiwlHVi84rrITIUFQHxOgDWQHGYUYCXNPmVYqHTaBWOpbpwFiTrim
 N1hF6qwaewoasenJQ1slE3tfrjOiB+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722608802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5peLPVnPJdFKgWkLmCkRk/7aqMYafpu+BVohwSAu31s=;
 b=GUNwV7gEKmEoSwN+e5pyhXw8dgSn9gJdjHfKKuaRNXNZtfYKPn8T28QPqKzvmwDCgwNf4t
 +VElzl8Prt51dqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24B6513999;
 Fri,  2 Aug 2024 14:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id INkBN6DsrGZ2AQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Aug 2024 14:26:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Jim Fehlig <jfehlig@suse.com>
Subject: [PULL 3/3] migration/multifd: Fix multifd_send_setup cleanup when
 channel creation fails
Date: Fri,  2 Aug 2024 11:26:33 -0300
Message-Id: <20240802142633.19249-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802142633.19249-1-farosas@suse.de>
References: <20240802142633.19249-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BA01C219B0
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

When a channel fails to create, the code currently just returns. This
is wrong for two reasons:

1) Channel n+1 will not get to initialize it's semaphores, leading to
   an assert when terminate_threads tries to post to it:

 qemu-system-x86_64: ../util/qemu-thread-posix.c:92:
 qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.

2) (theoretical) If channel n-1 already started creation it will
   defeat the purpose of the channels_created logic which is in place
   to avoid migrate_fd_cleanup() to run while channels are still being
   created.

   This cannot really happen today because the current failure cases
   for multifd_new_send_channel_create() are all synchronous,
   resulting from qio_channel_file_new_path() getting a bad
   filename. This would hit all channels equally.

   But I don't want to set a trap for future people, so have all
   channels try to create (even if failing), and only fail after the
   channels_created semaphore has been posted.

While here, remove the error_report_err call. There's one already at
migrate_fd_cleanup later on.

Cc: qemu-stable@nongnu.org
Reported-by: Jim Fehlig <jfehlig@suse.com>
Fixes: b7b03eb614 ("migration/multifd: Add outgoing QIOChannelFile support")
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0b4cbaddfe..552f9723c8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1156,7 +1156,6 @@ static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
 bool multifd_send_setup(void)
 {
     MigrationState *s = migrate_get_current();
-    Error *local_err = NULL;
     int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
@@ -1177,6 +1176,7 @@ bool multifd_send_setup(void)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
+        Error *local_err = NULL;
 
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1196,7 +1196,8 @@ bool multifd_send_setup(void)
         p->write_flags = 0;
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
-            return false;
+            migrate_set_error(s, local_err);
+            ret = -1;
         }
     }
 
@@ -1209,24 +1210,27 @@ bool multifd_send_setup(void)
         qemu_sem_wait(&multifd_send_state->channels_created);
     }
 
+    if (ret) {
+        goto err;
+    }
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
+        Error *local_err = NULL;
 
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
-            break;
+            migrate_set_error(s, local_err);
+            goto err;
         }
     }
 
-    if (ret) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
-        return false;
-    }
-
     return true;
+
+err:
+    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_FAILED);
+    return false;
 }
 
 bool multifd_recv(void)
-- 
2.35.3


