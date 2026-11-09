Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ibr.cs.tu-bs.de header.i=@ibr.cs.tu-bs.de header.a=rsa-sha256 header.s=key2 header.b=DUlf+TQ9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1W-0003pH-4i; Mon, 09 Nov 2026 15:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gollenstede@ibr.cs.tu-bs.de>)
 id 1xQRiy-00032r-7z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:56:00 -0500
Received: from mail.ibr.cs.tu-bs.de ([134.169.34.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gollenstede@ibr.cs.tu-bs.de>)
 id 1xQRiu-0004cZ-P7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ibr.cs.tu-bs.de;
 s=key2; t=1794239755;
 bh=p0bDgaPVOZFsYpYl1c0Sj4Iq0iIVE1QaqJ51pxBquOY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DUlf+TQ9vR60H9NLV8vGjTdi02SU8BKgNx0FrFaaLBUYUxIRIvYF9NZ5huNwMb2f7
 tQxaapmHUWqqf/cZEXJQ+7wCTrywOV4izJ7bw2NC+7iuCnH4yUjEoXZXNHl/F8eI25
 rIAVVjMmw/RwBYDKcRcGmq0HA8EabE+W9MsxVozY=
X-Virus-Scanned: Debian amavisd-new at ibr.cs.tu-bs.de
Received: from work (unknown [IPv6:2001:638:602:d023:bb5a:b7cc:7fd8:120f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: gollenst)
 by mail.ibr.cs.tu-bs.de (Postfix) with ESMTPSA id 972DE7CBF195;
 Mon,  9 Nov 2026 16:55:55 +0100 (CET)
From: Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
Subject: [PATCH 2/2] tests/qtest/virtio-9p: test non-readable but traversable
 directories
Date: Mon,  9 Nov 2026 16:55:03 +0100
Message-ID: <20261109155503.2530430-3-gollenstede@ibr.cs.tu-bs.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109155503.2530430-1-gollenstede@ibr.cs.tu-bs.de>
References: <20261109155503.2530430-1-gollenstede@ibr.cs.tu-bs.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.169.34.14;
 envelope-from=gollenstede@ibr.cs.tu-bs.de; helo=mail.ibr.cs.tu-bs.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:03 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Claude <noreply@anthropic.com>

Add two 'local' driver tests for directories that the user running QEMU
may traverse (x) but not read (r), e.g. a host's /nix/store with mode
1771 that is shared with a VM:

- local/walk/unreadable_dir: such a directory inside the export
- local/attach/unreadable_root: the export root itself is such a directory

In both cases, walking to, stat'ing and reading a known file inside the
directory must work, while listing the directory must fail with EACCES.
The tests are skipped if directory permissions are not enforced (e.g.
when running as root).

Without the previous commit, both tests fail: the walk through the
non-readable directory stops at it, and with a non-readable export root
QEMU does not even start.

Also make the test dir cleanup restore permissions before 'rm -fr', so
that it can remove such directories.

AI-used-for: code (Claude Opus 5.5)
Signed-off-by: Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
---
 tests/qtest/libqos/virtio-9p.c |   4 +-
 tests/qtest/virtio-9p-test.c   | 134 +++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 823756de8c..ddb5c5030b 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -64,7 +64,9 @@ void virtio_9p_create_local_test_dir(void)
 void virtio_9p_remove_local_test_dir(void)
 {
     g_assert(local_test_path != NULL);
-    g_autofree char *cmd = g_strdup_printf("rm -fr '%s'\n", local_test_path);
+    /* tests may have removed permissions that 'rm' needs */
+    g_autofree char *cmd = g_strdup_printf("chmod -R u+rwx '%s'; rm -fr '%s'\n",
+                                           local_test_path, local_test_path);
     int res = system(cmd);
     if (res < 0) {
         /* ignore error, dummy check to prevent compiler error */
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 22302bd2f8..390b3cc0a3 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1009,6 +1009,123 @@ static void fs_deep_absolute_path(void *obj, void *data,
     g_string_free(path, TRUE);
 }

+/*
+ * Tests for directories that are traversable (x) but not readable (r) by the
+ * user running QEMU, like a Nix store directory with mode 0751 or 1771 shared
+ * with a VM by a user that is not in its group: listing such a directory
+ * must fail, but all entries with known names must still be accessible.
+ */
+#define UNREADABLE_DIR_MODE 0111
+#define UNREADABLE_DIR_FILE_CONTENT "known file content\n"
+
+/* creates "<dir>/known/file", then removes read permission from <dir> */
+static void create_unreadable_dir(const char *dir)
+{
+    g_autofree char *known = g_build_filename(dir, "known", NULL);
+    g_autofree char *file = g_build_filename(known, "file", NULL);
+
+    g_assert(g_mkdir_with_parents(known, 0755) == 0);
+    g_assert(g_file_set_contents(file, UNREADABLE_DIR_FILE_CONTENT, -1, NULL));
+    g_assert(chmod(dir, UNREADABLE_DIR_MODE) == 0);
+}
+
+/* true if the permission setup is ineffective, e.g. because we are root */
+static bool unreadable_dir_is_readable(const char *dir)
+{
+    DIR *d = opendir(dir);
+
+    if (d) {
+        closedir(d);
+        return true;
+    }
+    g_assert_cmpint(errno, ==, EACCES);
+    return false;
+}
+
+/*
+ * Walk to and read "known/file" in the unreadable directory @dir_path (NULL
+ * for the export root), and check that the unreadable directory can't be
+ * listed.
+ */
+static void do_unreadable_dir_checks(QVirtio9P *v9p, const char *dir_path)
+{
+    const uint32_t len = strlen(UNREADABLE_DIR_FILE_CONTENT);
+    g_autofree char *buf = g_malloc0(len + 1);
+    g_autofree char *file_path =
+        g_build_filename(dir_path ? dir_path : "", "known/file", NULL);
+    struct v9fs_attr attr;
+    uint32_t fid_dir, fid_file, count;
+    uint16_t nwqid;
+
+    /* the unreadable dir itself can be walked to and stat'ed ... */
+    fid_dir = twalk({ .client = v9p, .fid = 0, .path = dir_path }).newfid;
+    tgetattr({
+        .client = v9p, .fid = fid_dir, .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
+    g_assert_cmpint(attr.mode & 07777, ==, UNREADABLE_DIR_MODE);
+    /* ... but not opened for listing */
+    tlopen({
+        .client = v9p, .fid = fid_dir, .flags = O_RDONLY | O_DIRECTORY,
+        .expectErr = EACCES
+    });
+
+    /* entries with known names in it are fully accessible */
+    /* (a partial walk is not an error on protocol level, so check nwqid) */
+    fid_file = twalk({
+        .client = v9p, .fid = 0, .path = file_path,
+        .rwalk = { .nwqid = &nwqid }
+    }).newfid;
+    g_assert_cmpint(nwqid, ==, dir_path ? 3 : 2);
+    tgetattr({
+        .client = v9p, .fid = fid_file, .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
+    g_assert_cmpint(attr.size, ==, len);
+    tlopen({ .client = v9p, .fid = fid_file, .flags = O_RDONLY });
+    count = tread({
+        .client = v9p, .fid = fid_file, .offset = 0, .count = len,
+        .rread = { .count = &count, .data = buf }
+    }).count;
+    g_assert_cmpint(count, ==, len);
+    g_assert_cmpstr(buf, ==, UNREADABLE_DIR_FILE_CONTENT);
+}
+
+/* non-readable but traversable directory within the export root */
+static void fs_walk_unreadable_dir(void *obj, void *data,
+                                   QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    v9fs_set_allocator(t_alloc);
+    g_autofree char *dir = virtio_9p_test_path("unreadable_dir");
+
+    create_unreadable_dir(dir);
+    if (unreadable_dir_is_readable(dir)) {
+        g_test_skip("Directory permissions are not enforced (root?)");
+        return;
+    }
+
+    tattach({ .client = v9p });
+    do_unreadable_dir_checks(v9p, "unreadable_dir");
+}
+
+/* the export root itself is non-readable but traversable */
+static void fs_attach_unreadable_root(void *obj, void *data,
+                                      QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    v9fs_set_allocator(t_alloc);
+    g_autofree char *root = virtio_9p_test_path("");
+
+    if (unreadable_dir_is_readable(root)) {
+        g_test_skip("Directory permissions are not enforced (root?)");
+        return;
+    }
+
+    tattach({ .client = v9p });
+    do_unreadable_dir_checks(v9p, NULL);
+}
+
 static void fs_local_xattr_limit_default(void *obj, void *data,
                                          QGuestAllocator *t_alloc)
 {
@@ -1070,6 +1187,18 @@ static void *assign_9p_local_driver(GString *cmd_line, void *arg)
     return arg;
 }

+static void *assign_9p_local_driver_unreadable_root(GString *cmd_line,
+                                                   void *arg)
+{
+    g_autofree char *root = NULL;
+
+    assign_9p_local_driver_with_args(cmd_line, NULL);
+    /* must be set up before QEMU opens the export root */
+    root = virtio_9p_test_path("");
+    create_unreadable_dir(root);
+    return arg;
+}
+
 static void *local_max_xattr_custom_opt(GString *cmd_line, void *arg)
 {
     assign_9p_local_driver_with_args(cmd_line, "max_xattr=100");
@@ -1140,6 +1269,8 @@ static void register_virtio_9p_test(void)
                  &opts);
     qos_add_test("local/deep_absolute_path", "virtio-9p",
                  fs_deep_absolute_path, &opts);
+    qos_add_test("local/walk/unreadable_dir", "virtio-9p",
+                 fs_walk_unreadable_dir, &opts);
     qos_add_test("local/xattr_limit/default", "virtio-9p",
                  fs_local_xattr_limit_default, &opts);
     opts.before = local_max_xattr_custom_opt;
@@ -1148,6 +1279,9 @@ static void register_virtio_9p_test(void)
     opts.before = local_max_xattr_unlimited_opt;
     qos_add_test("local/xattr_limit/unlimited", "virtio-9p",
                  fs_local_xattr_limit_unlimited, &opts);
+    opts.before = assign_9p_local_driver_unreadable_root;
+    qos_add_test("local/attach/unreadable_root", "virtio-9p",
+                 fs_attach_unreadable_root, &opts);
 }

 libqos_init(register_virtio_9p_test);
--
2.54.0


