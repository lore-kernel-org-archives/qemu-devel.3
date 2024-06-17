Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD32C2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYQ-0003uG-IN; Mon, 17 Jun 2024 14:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYP-0003ty-IU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:09 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYN-0004uQ-Nv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90C251F443;
 Mon, 17 Jun 2024 18:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2RXA+Fyk511u+QU1eiu5Q2LRU6vzATiXBtyBQ4Exfs=;
 b=E9y+K++JJ7B48C6O27icUIRQXnY36v6UQkRfK7lCpjZqy1K0CUOMNiHzmXd45O/DT7dBp7
 SPxrzlThGiqYqbyDayQrt+4UIAvfCugQYYiE1HLv7fWzI56rVD5E1NKUfkE3uCdi2sUgXl
 bGswwdDmFbYFQiPdS768Yc0XBXHaTww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2RXA+Fyk511u+QU1eiu5Q2LRU6vzATiXBtyBQ4Exfs=;
 b=GfogCzxy+WS9OfRNkJcDzASKb+7Hehzo7a4hxE4dvtMqG5yvh2kqsNTOJ42/G22voqSsg/
 xn+T5SwKTnxpGfBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E9y+K++J;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GfogCzxy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2RXA+Fyk511u+QU1eiu5Q2LRU6vzATiXBtyBQ4Exfs=;
 b=E9y+K++JJ7B48C6O27icUIRQXnY36v6UQkRfK7lCpjZqy1K0CUOMNiHzmXd45O/DT7dBp7
 SPxrzlThGiqYqbyDayQrt+4UIAvfCugQYYiE1HLv7fWzI56rVD5E1NKUfkE3uCdi2sUgXl
 bGswwdDmFbYFQiPdS768Yc0XBXHaTww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2RXA+Fyk511u+QU1eiu5Q2LRU6vzATiXBtyBQ4Exfs=;
 b=GfogCzxy+WS9OfRNkJcDzASKb+7Hehzo7a4hxE4dvtMqG5yvh2kqsNTOJ42/G22voqSsg/
 xn+T5SwKTnxpGfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B735B139AB;
 Mon, 17 Jun 2024 18:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oIxAHzyHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:58:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v3 12/16] migration/multifd: Add direct-io support
Date: Mon, 17 Jun 2024 15:57:27 -0300
Message-Id: <20240617185731.9725-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617185731.9725-1-farosas@suse.de>
References: <20240617185731.9725-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 90C251F443
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When multifd is used along with mapped-ram, we can take benefit of a
filesystem that supports the O_DIRECT flag and perform direct I/O in
the multifd threads. This brings a significant performance improvement
because direct-io writes bypass the page cache which would otherwise
be thrashed by the multifd data which is unlikely to be needed again
in a short period of time.

To be able to use a multifd channel opened with O_DIRECT, we must
ensure that a certain aligment is used. Filesystems usually require a
block-size alignment for direct I/O. The way to achieve this is by
enabling the mapped-ram feature, which already aligns its I/O properly
(see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).

By setting O_DIRECT on the multifd channels, all writes to the same
file descriptor need to be aligned as well, even the ones that come
from outside multifd, such as the QEMUFile I/O from the main migration
code. This makes it impossible to use the same file descriptor for the
QEMUFile and for the multifd channels. The various flags and metadata
written by the main migration code will always be unaligned by virtue
of their small size. To workaround this issue, we'll require a second
file descriptor to be used exclusively for direct I/O.

The second file descriptor can be obtained by QEMU by re-opening the
migration file (already possible), or by being provided by the user or
management application (support to be added in future patches).

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 33 ++++++++++++++++++++++++++++-----
 migration/file.h      |  1 -
 migration/migration.c | 23 +++++++++++++++++++++++
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index a903710f06..db870f2cf0 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -50,12 +50,31 @@ void file_cleanup_outgoing_migration(void)
     outgoing_args.fname = NULL;
 }
 
+static void file_enable_direct_io(int *flags)
+{
+#ifdef O_DIRECT
+    *flags |= O_DIRECT;
+#else
+    /* it should have been rejected when setting the parameter */
+    g_assert_not_reached();
+#endif
+}
+
 bool file_send_channel_create(gpointer opaque, Error **errp)
 {
     QIOChannelFile *ioc;
     int flags = O_WRONLY;
     bool ret = true;
 
+    if (migrate_direct_io()) {
+        /*
+         * Enable O_DIRECT for the secondary channels. These are used
+         * for sending ram pages and writes should be guaranteed to be
+         * aligned to at least page size.
+         */
+        file_enable_direct_io(&flags);
+    }
+
     ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
     if (!ioc) {
         ret = false;
@@ -117,21 +136,25 @@ static gboolean file_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void file_create_incoming_channels(QIOChannel *ioc, Error **errp)
+static void file_create_incoming_channels(QIOChannel *ioc, char *filename,
+                                          Error **errp)
 {
-    int i, fd, channels = 1;
+    int i, channels = 1;
     g_autofree QIOChannel **iocs = NULL;
+    int flags = O_RDONLY;
 
     if (migrate_multifd()) {
         channels += migrate_multifd_channels();
+        if (migrate_direct_io()) {
+            file_enable_direct_io(&flags);
+        }
     }
 
     iocs = g_new0(QIOChannel *, channels);
-    fd = QIO_CHANNEL_FILE(ioc)->fd;
     iocs[0] = ioc;
 
     for (i = 1; i < channels; i++) {
-        QIOChannelFile *fioc = qio_channel_file_new_dupfd(fd, errp);
+        QIOChannelFile *fioc = qio_channel_file_new_path(filename, flags, 0, errp);
 
         if (!fioc) {
             while (i) {
@@ -171,7 +194,7 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
         return;
     }
 
-    file_create_incoming_channels(QIO_CHANNEL(fioc), errp);
+    file_create_incoming_channels(QIO_CHANNEL(fioc), filename, errp);
 }
 
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
diff --git a/migration/file.h b/migration/file.h
index 7699c04677..9f71e87f74 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -20,7 +20,6 @@ void file_start_outgoing_migration(MigrationState *s,
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
-void file_create_incoming_channels(QIOChannel *ioc, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp);
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index e1b269624c..e03c80b3aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -155,6 +155,16 @@ static bool migration_needs_seekable_channel(void)
     return migrate_mapped_ram();
 }
 
+static bool migration_needs_extra_fds(void)
+{
+    /*
+     * When doing direct-io, multifd requires two different,
+     * non-duplicated file descriptors so we can use one of them for
+     * unaligned IO.
+     */
+    return migrate_multifd() && migrate_direct_io();
+}
+
 static bool transport_supports_seeking(MigrationAddress *addr)
 {
     if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
@@ -164,6 +174,12 @@ static bool transport_supports_seeking(MigrationAddress *addr)
     return false;
 }
 
+static bool transport_supports_extra_fds(MigrationAddress *addr)
+{
+    /* file: works because QEMU can open it multiple times */
+    return addr->transport == MIGRATION_ADDRESS_TYPE_FILE;
+}
+
 static bool
 migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
@@ -180,6 +196,13 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
         return false;
     }
 
+    if (migration_needs_extra_fds() &&
+        !transport_supports_extra_fds(addr)) {
+        error_setg(errp,
+                   "Migration requires a transport that allows for extra fds (e.g. file)");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.35.3


