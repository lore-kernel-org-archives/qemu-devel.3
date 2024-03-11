Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AA6C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 23:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjpA0-0007z1-Ih; Mon, 11 Mar 2024 19:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjp9y-0007yU-5c
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 19:34:22 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjp9o-0003MW-AU
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 19:34:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E54273522C;
 Mon, 11 Mar 2024 23:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710200051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er41pGyz1IwFMf/FUJBaemtek5iR34JneUySqbtflJ0=;
 b=e9XyixDdxC6Uf1qQAGUTwNyodGCspQCrgUteRObcYVDIY34yesjEMk4gdJVtTBUg6QBGqW
 oAIwVbzLewOJiZdDlrEbC3X/ee/GTMgBoqR2B2PfvNRRj80x0JVeOc+AAaI48wbD2pYRJ4
 aYIeG/PnWoq4M0vvps2CwNmMca4gT18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710200051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er41pGyz1IwFMf/FUJBaemtek5iR34JneUySqbtflJ0=;
 b=4FubYQ4x8y/E2FuEkA7Wa5pLzwBBtYEt3uRgksMgfmA2ip2wVG9urQlbyqQlJBYT4ijIVj
 AqqkkwwCrvkD2wCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710200050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er41pGyz1IwFMf/FUJBaemtek5iR34JneUySqbtflJ0=;
 b=Cqer7Zx+HuravaplAZffjecjsoWihwSzl9S2Cwl6cExA42uujQIbys9gzon/jpx0EBSkS2
 okciuwrMZTAR++NHFEQDjNkLbmKQSpFcvyAIED7puZ9eIAliLeBy1QfT6YiISW/595V+MG
 +Cytd7cQQWRYHsVzV79cDyWFpX4rcTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710200050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er41pGyz1IwFMf/FUJBaemtek5iR34JneUySqbtflJ0=;
 b=INia22yjAIj7HZBPWt5lpGL8AimeEd4XJ6pmexeY8EnCjMCskm1d1B7bk7UkTUKV8pU7Og
 WRdAqpR5E3yKZJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48FB213695;
 Mon, 11 Mar 2024 23:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EA4TAfGU72VSEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 23:34:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] migration: Fix error handling after dup in file migration
Date: Mon, 11 Mar 2024 20:33:35 -0300
Message-Id: <20240311233335.17299-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240311233335.17299-1-farosas@suse.de>
References: <20240311233335.17299-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cqer7Zx+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=INia22yj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: E54273522C
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The file migration code was allowing a possible -1 from a failed call
to dup() to propagate into the new QIOFileChannel::fd before checking
for validity. Coverity doesn't like that, possibly due to the the
lseek(-1, ...) call that would ensue before returning from the channel
creation routine.

Use the newly introduced qio_channel_file_dupfd() to properly check
the return of dup() before proceeding.

Fixes: CID 1539961
Fixes: CID 1539965
Fixes: CID 1539960
Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/fd.c   |  9 ++++-----
 migration/file.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index d4ae72d132..4e2a63a73d 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -80,6 +80,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 void fd_start_incoming_migration(const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
+    QIOChannelFile *fioc;
     int fd = monitor_fd_param(monitor_cur(), fdname, errp);
     if (fd == -1) {
         return;
@@ -103,15 +104,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         int channels = migrate_multifd_channels();
 
         while (channels--) {
-            ioc = QIO_CHANNEL(qio_channel_file_new_fd(dup(fd)));
-
-            if (QIO_CHANNEL_FILE(ioc)->fd == -1) {
-                error_setg(errp, "Failed to duplicate fd %d", fd);
+            fioc = qio_channel_file_new_dupfd(fd, errp);
+            if (!fioc) {
                 return;
             }
 
             qio_channel_set_name(ioc, "migration-fd-incoming");
-            qio_channel_add_watch_full(ioc, G_IO_IN,
+            qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
                                        fd_accept_incoming_migration,
                                        NULL, NULL,
                                        g_main_context_get_thread_default());
diff --git a/migration/file.c b/migration/file.c
index 164b079966..d458f48269 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -58,12 +58,13 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
     int fd = fd_args_get_fd();
 
     if (fd && fd != -1) {
-        ioc = qio_channel_file_new_fd(dup(fd));
+        ioc = qio_channel_file_new_dupfd(fd, errp);
     } else {
         ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
-        if (!ioc) {
-            goto out;
-        }
+    }
+
+    if (!ioc) {
+        goto out;
     }
 
     multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
@@ -147,10 +148,9 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
                                    NULL, NULL,
                                    g_main_context_get_thread_default());
 
-        fioc = qio_channel_file_new_fd(dup(fioc->fd));
+        fioc = qio_channel_file_new_dupfd(fioc->fd, errp);
 
-        if (!fioc || fioc->fd == -1) {
-            error_setg(errp, "Error creating migration incoming channel");
+        if (!fioc) {
             break;
         }
     } while (++i < channels);
-- 
2.35.3


