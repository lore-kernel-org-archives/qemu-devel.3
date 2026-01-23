Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E0FD778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEu-0002Ck-W5; Fri, 23 Jan 2026 14:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEt-00029W-IX
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEr-0003X6-PE
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:39 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3F9933865;
 Fri, 23 Jan 2026 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdPVU7dy7nYLNsiolxyE299cuedhXP9PrZceedfWPn4=;
 b=XsD8t3ZIfZy3ECnTqJ1Mi9Oy0fuREhTlWVZv5xSJIjQ7RkQUXhAWXWuska1URitCHQJy48
 seEsor0un84fEzTUheOqaSeney5Gu/Z7su7uAKE2CDHV1jk4KM7T47DQs7vOHLN2R3WZdQ
 w0i/EoLJuWoN8bGnlgdn7XdRtOjrTT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdPVU7dy7nYLNsiolxyE299cuedhXP9PrZceedfWPn4=;
 b=yd/zT56wxJ2ztDo0VaYnykZuAUHnO8mH8vZqcLG9lSnXmxOWu++PmkoDOesw9iQt5oEGhw
 kVrZufghpmyey5Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdPVU7dy7nYLNsiolxyE299cuedhXP9PrZceedfWPn4=;
 b=XsD8t3ZIfZy3ECnTqJ1Mi9Oy0fuREhTlWVZv5xSJIjQ7RkQUXhAWXWuska1URitCHQJy48
 seEsor0un84fEzTUheOqaSeney5Gu/Z7su7uAKE2CDHV1jk4KM7T47DQs7vOHLN2R3WZdQ
 w0i/EoLJuWoN8bGnlgdn7XdRtOjrTT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdPVU7dy7nYLNsiolxyE299cuedhXP9PrZceedfWPn4=;
 b=yd/zT56wxJ2ztDo0VaYnykZuAUHnO8mH8vZqcLG9lSnXmxOWu++PmkoDOesw9iQt5oEGhw
 kVrZufghpmyey5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90B1F1395E;
 Fri, 23 Jan 2026 19:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mHokFObRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 11/36] migration: Remove fd: support on files
Date: Fri, 23 Jan 2026 16:53:26 -0300
Message-ID: <20260123195352.12850-12-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

This feature was deprecated in 9.1.  Remove it in this release (11.0).

We also need to remove one unit test (/migration/precopy/fd/file) that
covers the fd: file migration, because it'll stop working now.

Reviewed-by: Prasad Pandit <ppandit@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260115225503.3083355-3-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst             | 14 ---------
 docs/about/removed-features.rst       |  9 ++++++
 migration/fd.c                        | 11 ++++---
 tests/qtest/migration/precopy-tests.c | 41 ---------------------------
 4 files changed, 16 insertions(+), 59 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ae9a3b8aea..1d5c4f3707 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -518,17 +518,3 @@ If the user requests a modern x86 CPU model (i.e. not one of ``486``,
 ``athlon``, ``kvm32``, ``pentium``, ``pentium2``, ``pentium3``or ``qemu32``)
 a warning will be displayed until a future QEMU version when such CPUs will
 be rejected.
-
-Migration
----------
-
-``fd:`` URI when used for file migration (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``fd:`` URI can currently provide a file descriptor that
-references either a socket or a plain file. These are two different
-types of migration. In order to reduce ambiguity, the ``fd:`` URI
-usage of providing a file descriptor to a plain file has been
-deprecated in favor of explicitly using the ``file:`` URI with the
-file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
-command documentation for details on the ``fdset`` usage.
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 92f80a32e4..41bec8b8e3 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -716,6 +716,15 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
 storage migration with ``blockdev-mirror`` + NBD" in
 docs/interop/live-block-operations.rst for a detailed explanation.
 
+``migrate`` command with file-based ``fd:`` URI (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+In order to reduce ambiguity, the ``fd:`` URI usage of providing a
+file descriptor to a plain file has been removed in favor of
+explicitly using the ``file:`` URI with the file descriptor being
+passed as an ``fdset``. Refer to the ``add-fd`` command documentation
+for details on the ``fdset`` usage.
+
 ``migrate-set-capabilities`` ``block`` option (removed in 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/migration/fd.c b/migration/fd.c
index 9bf9be6acb..fdeece2101 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -24,6 +24,7 @@
 #include "qemu/sockets.h"
 #include "io/channel-util.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 static bool fd_is_pipe(int fd)
 {
@@ -58,8 +59,9 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     if (!migration_fd_valid(fd)) {
-        warn_report("fd: migration to a file is deprecated."
-                    " Use file: instead.");
+        error_setg(errp, "fd: migration to a file is not supported."
+                   " Use file: instead.");
+        return;
     }
 
     trace_migration_fd_outgoing(fd);
@@ -92,8 +94,9 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
     }
 
     if (!migration_fd_valid(fd)) {
-        warn_report("fd: migration to a file is deprecated."
-                    " Use file: instead.");
+        error_setg(errp, "fd: migration to a file is not supported."
+                   " Use file: instead.");
+        return;
     }
 
     trace_migration_fd_incoming(fd);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 0283da43e3..a5423ca33c 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -289,45 +289,6 @@ static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 
     test_precopy_common(args);
 }
-
-static void *migrate_hook_start_precopy_fd_file(QTestState *from,
-                                                QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-    int src_flags = O_CREAT | O_RDWR;
-    int dst_flags = O_CREAT | O_RDWR;
-    int fds[2];
-
-    fds[0] = open(file, src_flags, 0660);
-    assert(fds[0] != -1);
-
-    fds[1] = open(file, dst_flags, 0660);
-    assert(fds[1] != -1);
-
-
-    qtest_qmp_fds_assert_success(to, &fds[0], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-
-    qtest_qmp_fds_assert_success(from, &fds[1], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-
-    close(fds[0]);
-    close(fds[1]);
-
-    return NULL;
-}
-
-static void test_precopy_fd_file(char *name, MigrateCommon *args)
-{
-    args->listen_uri = "defer";
-    args->connect_uri = "fd:fd-mig";
-    args->start_hook = migrate_hook_start_precopy_fd_file;
-    args->end_hook = migrate_hook_end_fd;
-
-    test_file_common(args, true);
-}
 #endif /* _WIN32 */
 
 /*
@@ -1255,8 +1216,6 @@ void migration_test_add_precopy(MigrationTestEnv *env)
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
                        test_precopy_fd_socket);
-    migration_test_add("/migration/precopy/fd/file",
-                       test_precopy_fd_file);
 #endif
 
     /*
-- 
2.51.0


