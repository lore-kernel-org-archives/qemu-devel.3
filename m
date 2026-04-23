Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1240FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcJ-0002rS-CD; Thu, 23 Apr 2026 15:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzc0-0002IJ-4q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:27 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbw-0001ve-G5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2BD575BD80;
 Thu, 23 Apr 2026 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+dWxIjEbtZWJM6lJ1p1SMQ30hrcIj1G1U4aBy3qzDI=;
 b=Ku/6DBjMRxNiD9US9YvoKTBQBhk4U3F5gF2346lfP+wLOSmAS5KX2f5Yv4LWsgpru+rrh+
 u6vhAZffKBSh3ntJdpQHFiD0VroJIb/1rCMkeH11ycEHTiDzQ3GHBYQNUFEI/67zz/jVl8
 JMTdycS49gTRm0dFMuBeV8BBa7Tv99w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+dWxIjEbtZWJM6lJ1p1SMQ30hrcIj1G1U4aBy3qzDI=;
 b=trog1vFoWLnLJRghEK47xStnTzIrsQqMU1G6xOHRUWAnshA50vnHlpy7jkw6YbM/w5ZWle
 bF3DEZlSzK9pYKDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+dWxIjEbtZWJM6lJ1p1SMQ30hrcIj1G1U4aBy3qzDI=;
 b=Ku/6DBjMRxNiD9US9YvoKTBQBhk4U3F5gF2346lfP+wLOSmAS5KX2f5Yv4LWsgpru+rrh+
 u6vhAZffKBSh3ntJdpQHFiD0VroJIb/1rCMkeH11ycEHTiDzQ3GHBYQNUFEI/67zz/jVl8
 JMTdycS49gTRm0dFMuBeV8BBa7Tv99w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+dWxIjEbtZWJM6lJ1p1SMQ30hrcIj1G1U4aBy3qzDI=;
 b=trog1vFoWLnLJRghEK47xStnTzIrsQqMU1G6xOHRUWAnshA50vnHlpy7jkw6YbM/w5ZWle
 bF3DEZlSzK9pYKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26249593A3;
 Thu, 23 Apr 2026 19:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uBP2OAFx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Trieu Huynh <vikingtc4@gmail.com>
Subject: [PULL 23/43] migration: fix QIOChannelFile leak on error in
 file_connect_outgoing
Date: Thu, 23 Apr 2026 16:19:37 -0300
Message-ID: <20260423191958.1440-24-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Trieu Huynh <vikingtc4@gmail.com>

Commit 03a680c978 changed g_autoptr(QIOChannelFile) to a plain pointer
but failed to restore the necessary object_unref() calls on error paths.
Previously, these were handled implicitly by the g_autoptr cleanup
mechanism.

Two error paths currently leak the QIOChannelFile object and its
underlying file descriptor:

  1. When ftruncate() fails (e.g., on character or block devices).
  2. When qio_channel_io_seek() fails after the channel is created.

In environments that retry migration automatically (e.g., libvirt),
these FDs accumulate until QEMU hits RLIMIT_NOFILE and fails with
EMFILE (Too many open files).

Add the missing object_unref() calls to both error paths to ensure
resources are properly released.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260328121215.159532-1-vikingtc4@gmail.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c                   |  2 ++
 tests/qtest/migration/file-tests.c | 48 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/migration/file.c b/migration/file.c
index 5618aced49..962b4b3a1b 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -112,6 +112,7 @@ QIOChannel *file_connect_outgoing(MigrationState *s,
         error_setg_errno(errp, errno,
                          "failed to truncate migration file to offset %" PRIx64,
                          offset);
+        object_unref(OBJECT(fioc));
         goto out;
     }
 
@@ -119,6 +120,7 @@ QIOChannel *file_connect_outgoing(MigrationState *s,
 
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+        object_unref(OBJECT(fioc));
         ioc = NULL;
         goto out;
     }
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 5d1b861cf6..fef172068f 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -20,6 +20,51 @@
 
 static char *tmpfs;
 
+static int count_proc_fds(pid_t pid)
+{
+    g_autofree char *fddir = g_strdup_printf("/proc/%d/fd", (int)pid);
+    GDir *dir = g_dir_open(fddir, 0, NULL);
+    int count = 0;
+
+    if (!dir) {
+        return -1;
+    }
+    while (g_dir_read_name(dir)) {
+        count++;
+    }
+    g_dir_close(dir);
+    return count;
+}
+
+static void test_file_connect_outgoing_fd_leak(char *name, MigrateCommon *args)
+{
+    QTestState *from, *to;
+    int fd_before, fd_after;
+    const int retries = 5;
+    int i;
+    if (!g_file_test("/dev/full", G_FILE_TEST_EXISTS)) {
+        g_test_skip("/dev/full not available");
+        return;
+    }
+
+    args->listen_uri = "defer";
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    fd_before = count_proc_fds(qtest_pid(from));
+    g_assert_cmpint(fd_before, >, 0);
+    for (i = 0; i < retries; i++) {
+        migrate_qmp_fail(from, "file:/dev/full", NULL, "{}");
+        migration_event_wait(from, "failed");
+    }
+
+    fd_after = count_proc_fds(qtest_pid(from));
+    g_assert_cmpint(fd_after, >, 0);
+    g_assert_cmpint(fd_after, ==, fd_before);
+    migrate_end(from, to, false);
+}
+
 static void test_precopy_file(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -314,6 +359,9 @@ void migration_test_add_file(MigrationTestEnv *env)
     migration_test_add("/migration/precopy/file/offset/bad",
                        test_precopy_file_offset_bad);
 
+    migration_test_add("/migration/precopy/file/connect-outgoing-fd-leak",
+                       test_file_connect_outgoing_fd_leak);
+
     migration_test_add("/migration/precopy/file/mapped-ram",
                        test_precopy_file_mapped_ram);
     migration_test_add("/migration/precopy/file/mapped-ram/live",
-- 
2.51.0


