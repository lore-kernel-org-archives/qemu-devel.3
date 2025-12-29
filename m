Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8E2D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 12:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaC3r-0007vZ-SP; Mon, 29 Dec 2025 07:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC3p-0007un-QN
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:18 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC3o-0005Au-7K
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767010127; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WwWbg7x4ZhKPv7Drz9LTjL0hqnBstpOGnLXVtK2mNQCPdlsvS7nN/sLwC/mgcRwy4MlmzbuSBLb8cOFtFT7r6qawy3vwRFxpSxrJumxbHXSEeVs5LBPnaIaO0PmBPqritN2zaJY6iTpdWJlIEezZdCicaxa189ppPs8+jPqY58k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767010127;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KmL3yQU8cI+4O6Tqt+R8xR9IxD5kn1z34uVz/ZpIegU=; 
 b=OPVKRmS7nvZViCKM63a9Ie6BiV8V7UURqcajCDB/IJh5fsC+i81dOhgZVZPgEyxYsryAv5P3jF0jpnREv7Y0RBVCQ3rT1SRxcAVyTPRUuGY1tdNRN5DQQNuJniQ3OOtaRwliK+UlTVDAvtHso7AORC8JBYcKfH/PeNPxD4RqbyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767010127; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=KmL3yQU8cI+4O6Tqt+R8xR9IxD5kn1z34uVz/ZpIegU=;
 b=TcgcwRmVW893pKZIet0XESxGjbCEAhqtlqjE8jPQjuBRhmBfPb4quTWsnK6ompVV
 1h4x5RdhyE+uTVtXALpe7nuozkjQ1RClADexL60Wk1J5fXxw5cudu5/Bi+IwnwqrBHn
 89slAsbJAxCs/Zsdpr3D46lwGgJUQ/aHBgByqWOI=
Received: by mx.zohomail.com with SMTPS id 1767010126666353.00298807412594;
 Mon, 29 Dec 2025 04:08:46 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, qemu-devel@nongnu.org,
 Li Chen <me@linux.beauty>
Subject: [PATCH 1/3] system/physmem: allow /dev/fdset for file-backed RAM
Date: Mon, 29 Dec 2025 20:08:35 +0800
Message-ID: <20251229120839.89817-2-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229120839.89817-1-me@linux.beauty>
References: <20251229120839.89817-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112; envelope-from=me@linux.beauty;
 helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CPR with x-ignore-shared can skip migration of shared RAM pages, so only
vmstate is transferred. This relies on guest RAM being externally managed
and re-used in place.

Allow users to pass a pre-opened RAM backing FD via -add-fd and attach it
with memory-backend-file mem-path=/dev/fdset/<id>. File-backed RAM used
plain open()/creat(), so /dev/fdset/<id> could not be resolved through the
fdset mechanism. Switch to qemu_open()/qemu_create(), return -EINVAL when
creation is attempted, and add a hint for missing -add-fd. Add a qtest that
creates a memory-backend-file object from /dev/fdset/<id>.

Signed-off-by: Li Chen <me@linux.beauty>
---
 system/physmem.c                  | 17 ++++++++++++--
 tests/qtest/migration/cpr-tests.c | 38 ++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..7717de5e7b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1650,10 +1650,14 @@ static int file_ram_open(const char *path,
     char *sanitized_name;
     char *c;
     int fd = -1;
+    const char *tmp;
+    const bool is_fdset = strstart(path, "/dev/fdset/", &tmp);
 
     *created = false;
     for (;;) {
-        fd = open(path, readonly ? O_RDONLY : O_RDWR);
+        g_autoptr(Error) local_err = NULL;
+
+        fd = qemu_open(path, readonly ? O_RDONLY : O_RDWR, &local_err);
         if (fd >= 0) {
             /*
              * open(O_RDONLY) won't fail with EISDIR. Check manually if we
@@ -1682,8 +1686,13 @@ static int file_ram_open(const char *path,
                 /* Refuse to create new, readonly files. */
                 return -ENOENT;
             }
+            if (is_fdset) {
+                /* /dev/fdset/N is a QEMU fdset handle and cannot be created. */
+                return -EINVAL;
+            }
             /* @path names a file that doesn't exist, create it */
-            fd = open(path, O_RDWR | O_CREAT | O_EXCL, 0644);
+            local_err = NULL;
+            fd = qemu_create(path, O_RDWR | O_EXCL, 0644, &local_err);
             if (fd >= 0) {
                 *created = true;
                 break;
@@ -2410,6 +2419,10 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     if (fd < 0) {
         error_setg_errno(errp, -fd, "can't open backing store %s for guest RAM",
                          mem_path);
+        if (g_str_has_prefix(mem_path, "/dev/fdset/")) {
+            error_append_hint(errp, "Did you forget to pass the backing FD via"
+                              " '-add-fd fd=<n>,set=<id>'?\n");
+        }
         if (!(ram_flags & RAM_READONLY_FD) && !(ram_flags & RAM_SHARED) &&
             fd == -EACCES) {
             /*
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 2a186c6f35..5eafc4d678 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -19,6 +19,39 @@
 
 static char *tmpfs;
 
+#ifndef _WIN32
+static void test_mem_backend_file_fdset(void)
+{
+    const uint64_t size = 8 * 1024 * 1024;
+    g_autofree char *file = g_strdup_printf("%s/fdset-ram.bin", tmpfs);
+    QTestState *qts;
+    int fd;
+
+    fd = open(file, O_RDWR | O_CREAT | O_TRUNC, 0600);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, size), ==, 0);
+
+    qts = qtest_init("-machine none -nodefaults");
+    qtest_qmp_fds_assert_success(qts, &fd, 1,
+                                 "{'execute': 'add-fd',"
+                                 " 'arguments': { 'fdset-id': 1 } }");
+    close(fd);
+
+    qtest_qmp_assert_success(qts, "{ 'execute': 'object-add',"
+                             "  'arguments': {"
+                             "    'qom-type': 'memory-backend-file',"
+                             "    'id': 'ram0',"
+                             "    'mem-path': '/dev/fdset/1',"
+                             "    'size': %" PRIu64 " } }",
+                             size);
+    qtest_qmp_assert_success(qts, "{ 'execute': 'object-del',"
+                             "  'arguments': { 'id': 'ram0' } }");
+    qtest_quit(qts);
+
+    unlink(file);
+}
+#endif
+
 static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
 {
     migrate_set_parameter_str(from, "mode", "cpr-reboot");
@@ -247,7 +280,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
-    /* no tests in the smoke set for now */
+#ifndef _WIN32
+    migration_test_add("/migration/fdset/mem-backend-file",
+                       test_mem_backend_file_fdset);
+#endif
 
     if (!env->full_set) {
         return;
-- 
2.52.0


