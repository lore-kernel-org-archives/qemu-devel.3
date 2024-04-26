Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77302C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MRy-0007Jt-PJ; Fri, 26 Apr 2024 10:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRw-0007FO-M6
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:16 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRi-0001xe-Ih
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3A9534E8F;
 Fri, 26 Apr 2024 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqQbG+3aTKLy7AA7zqRDf4iFroAaNZ18tQCzSkYhB0k=;
 b=Whtd0i1bZ2iwTkl/xqbvamBrzfoIs0CZomrjEyPyJobMuwlMg5u+Mx9oo5S5Js/BkJLG+P
 4j4eL5wPB78yM4OyBhozdMFBoreN5xXihrBJ0SN5aPM7diyaSYY84joqL2i8yXASTpeQEs
 vrl1nOjUR5E/2fFAcPn48AGJIu1lqyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqQbG+3aTKLy7AA7zqRDf4iFroAaNZ18tQCzSkYhB0k=;
 b=l4AKAjCJWgaV706zcSX091DaHxSx0H7BGeGHg+5Q62N/IOUsCGtqw33Rz3/UsLuUuYGW+j
 520iLmA/maT3hcAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Whtd0i1b;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l4AKAjCJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqQbG+3aTKLy7AA7zqRDf4iFroAaNZ18tQCzSkYhB0k=;
 b=Whtd0i1bZ2iwTkl/xqbvamBrzfoIs0CZomrjEyPyJobMuwlMg5u+Mx9oo5S5Js/BkJLG+P
 4j4eL5wPB78yM4OyBhozdMFBoreN5xXihrBJ0SN5aPM7diyaSYY84joqL2i8yXASTpeQEs
 vrl1nOjUR5E/2fFAcPn48AGJIu1lqyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqQbG+3aTKLy7AA7zqRDf4iFroAaNZ18tQCzSkYhB0k=;
 b=l4AKAjCJWgaV706zcSX091DaHxSx0H7BGeGHg+5Q62N/IOUsCGtqw33Rz3/UsLuUuYGW+j
 520iLmA/maT3hcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD25E136DB;
 Fri, 26 Apr 2024 14:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uIG1JEm4K2YWcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:20:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH 5/9] migration/multifd: Add direct-io support
Date: Fri, 26 Apr 2024 11:20:38 -0300
Message-Id: <20240426142042.14573-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426142042.14573-1-farosas@suse.de>
References: <20240426142042.14573-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A3A9534E8F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
 migration/file.c      | 22 +++++++++++++++++++---
 migration/migration.c | 23 +++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 8f30999400..b9265b14dd 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -83,17 +83,33 @@ void file_cleanup_outgoing_migration(void)
 
 bool file_send_channel_create(gpointer opaque, Error **errp)
 {
-    QIOChannelFile *ioc;
+    QIOChannelFile *ioc = NULL;
     int flags = O_WRONLY;
-    bool ret = true;
+    bool ret = false;
+
+    if (migrate_direct_io()) {
+#ifdef O_DIRECT
+        /*
+         * Enable O_DIRECT for the secondary channels. These are used
+         * for sending ram pages and writes should be guaranteed to be
+         * aligned to at least page size.
+         */
+        flags |= O_DIRECT;
+#else
+        error_setg(errp, "System does not support O_DIRECT");
+        error_append_hint(errp,
+                          "Try disabling direct-io migration capability\n");
+        goto out;
+#endif
+    }
 
     ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
     if (!ioc) {
-        ret = false;
         goto out;
     }
 
     multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
+    ret = true;
 
 out:
     /*
diff --git a/migration/migration.c b/migration/migration.c
index b5af6b5105..cb923a3f62 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -155,6 +155,16 @@ static bool migration_needs_seekable_channel(void)
     return migrate_mapped_ram();
 }
 
+static bool migration_needs_multiple_fds(void)
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
 
+static bool transport_supports_multiple_fds(MigrationAddress *addr)
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
 
+    if (migration_needs_multiple_fds() &&
+        !transport_supports_multiple_fds(addr)) {
+        error_setg(errp,
+                   "Migration requires a transport that allows for multiple fds (e.g. file)");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.35.3


