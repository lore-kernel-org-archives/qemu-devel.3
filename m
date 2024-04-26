Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C08C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MRw-0007FM-M5; Fri, 26 Apr 2024 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRt-0007CW-D0
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRp-000245-BP
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 472A922DF8;
 Fri, 26 Apr 2024 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eMGgmiQ5JFvoP97b8KdNqSKLJOCLLrmNvHFvzlrZEc=;
 b=DReSgi2quHvJIGDkjhDq7bXYAiPX5b/MC37ca4vx/RL4neTKoRiip3pEfF7VrsIoNi+Bb2
 xNPZW/+qGnlhkC3nx0/AsqlHm0RifCARlAN8p/vcTQXrn8HLRfYbmafE3QT3lJ2j7tWGTb
 3bIHv0hy1NDhAbjv8eYlcciHw70C3A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eMGgmiQ5JFvoP97b8KdNqSKLJOCLLrmNvHFvzlrZEc=;
 b=8mHonLPVENdjOJeBO3sKUbU3SXD8ISghZ2IDqUPP6xhJ6ROaUTMWQfnVI9EuIbl9yP52I7
 D1L1XNNYh1UndiAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DReSgi2q;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8mHonLPV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eMGgmiQ5JFvoP97b8KdNqSKLJOCLLrmNvHFvzlrZEc=;
 b=DReSgi2quHvJIGDkjhDq7bXYAiPX5b/MC37ca4vx/RL4neTKoRiip3pEfF7VrsIoNi+Bb2
 xNPZW/+qGnlhkC3nx0/AsqlHm0RifCARlAN8p/vcTQXrn8HLRfYbmafE3QT3lJ2j7tWGTb
 3bIHv0hy1NDhAbjv8eYlcciHw70C3A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eMGgmiQ5JFvoP97b8KdNqSKLJOCLLrmNvHFvzlrZEc=;
 b=8mHonLPVENdjOJeBO3sKUbU3SXD8ISghZ2IDqUPP6xhJ6ROaUTMWQfnVI9EuIbl9yP52I7
 D1L1XNNYh1UndiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DFF4136DB;
 Fri, 26 Apr 2024 14:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iAEyDVG4K2YWcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:21:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH 8/9] migration: Add support for fdset with multifd + file
Date: Fri, 26 Apr 2024 11:20:41 -0300
Message-Id: <20240426142042.14573-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426142042.14573-1-farosas@suse.de>
References: <20240426142042.14573-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 472A922DF8
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Allow multifd to use an fdset when migrating to a file. This is useful
for the scenario where the management layer wants to have control over
the migration file.

By receiving the file descriptors directly, QEMU can delegate some
high level operating system operations to the management layer (such
as mandatory access control). The management layer might also want to
add its own headers before the migration stream.

Enable the "file:/dev/fdset/#" syntax for the multifd migration with
mapped-ram. The requirements for the fdset mechanism are:

On the migration source side:

- the fdset must contain two fds that are not duplicates between
  themselves;
- if direct-io is to be used, exactly one of the fds must have the
  O_DIRECT flag set;
- the file must be opened with WRONLY both times.

On the migration destination side:

- the fdset must contain one fd;
- the file must be opened with RDONLY.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/main.rst       | 18 ++++++++++++++
 docs/devel/migration/mapped-ram.rst |  6 ++++-
 migration/file.c                    | 38 ++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 54385a23e5..50f6096470 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -47,6 +47,24 @@ over any transport.
   QEMU interference. Note that QEMU does not flush cached file
   data/metadata at the end of migration.
 
+  The file migration also supports using a file that has already been
+  opened. A set of file descriptors is passed to QEMU via an "fdset"
+  (see add-fd QMP command documentation). This method allows a
+  management application to have control over the migration file
+  opening operation. There are, however, strict requirements to this
+  interface:
+
+  On the migration source side:
+    - if the multifd capability is to be used, the fdset must contain
+      two file descriptors that are not duplicates between themselves;
+    - if the direct-io capability is to be used, exactly one of the
+      file descriptors must have the O_DIRECT flag set;
+    - the file must be opened with WRONLY.
+
+  On the migration destination side:
+    - the fdset must contain one file descriptor;
+    - the file must be opened with RDONLY.
+
 In addition, support is included for migration using RDMA, which
 transports the page data using ``RDMA``, where the hardware takes care of
 transporting the pages, and the load on the CPU is much lower.  While the
diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migration/mapped-ram.rst
index fa4cefd9fc..e6505511f0 100644
--- a/docs/devel/migration/mapped-ram.rst
+++ b/docs/devel/migration/mapped-ram.rst
@@ -16,7 +16,7 @@ location in the file, rather than constantly being added to a
 sequential stream. Having the pages at fixed offsets also allows the
 usage of O_DIRECT for save/restore of the migration stream as the
 pages are ensured to be written respecting O_DIRECT alignment
-restrictions (direct-io support not yet implemented).
+restrictions.
 
 Usage
 -----
@@ -35,6 +35,10 @@ Use a ``file:`` URL for migration:
 Mapped-ram migration is best done non-live, i.e. by stopping the VM on
 the source side before migrating.
 
+For best performance enable the ``direct-io`` capability as well:
+
+    ``migrate_set_capability direct-io on``
+
 Use-cases
 ---------
 
diff --git a/migration/file.c b/migration/file.c
index b9265b14dd..3bc8bc7463 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -17,6 +17,7 @@
 #include "io/channel-file.h"
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
+#include "monitor/monitor.h"
 #include "options.h"
 #include "trace.h"
 
@@ -54,10 +55,18 @@ static void file_remove_fdset(void)
     }
 }
 
+/*
+ * With multifd, due to the behavior of the dup() system call, we need
+ * the fdset to have two non-duplicate fds so we can enable direct IO
+ * in the secondary channels without affecting the main channel.
+ */
 static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
                              Error **errp)
 {
+    FdsetInfoList *fds_info;
+    FdsetFdInfoList *fd_info;
     const char *fdset_id_str;
+    int nfds = 0;
 
     *fdset_id = -1;
 
@@ -71,6 +80,32 @@ static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
         return false;
     }
 
+    if (!migrate_multifd() || !migrate_direct_io()) {
+        return true;
+    }
+
+    for (fds_info = qmp_query_fdsets(NULL); fds_info;
+         fds_info = fds_info->next) {
+
+        if (*fdset_id != fds_info->value->fdset_id) {
+            continue;
+        }
+
+        for (fd_info = fds_info->value->fds; fd_info; fd_info = fd_info->next) {
+            if (nfds++ > 2) {
+                break;
+            }
+        }
+    }
+
+    if (nfds != 2) {
+        error_setg(errp, "Outgoing migration needs two fds in the fdset, "
+                   "got %d", nfds);
+        qmp_remove_fd(*fdset_id, false, -1, NULL);
+        *fdset_id = -1;
+        return false;
+    }
+
     return true;
 }
 
@@ -209,10 +244,11 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
     g_autofree char *filename = g_strdup(file_args->filename);
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
+    int flags = O_RDONLY;
 
     trace_migration_file_incoming(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
+    fioc = qio_channel_file_new_path(filename, flags, 0, errp);
     if (!fioc) {
         return;
     }
-- 
2.35.3


