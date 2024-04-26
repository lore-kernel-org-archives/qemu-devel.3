Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C05C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MRp-0007A7-6k; Fri, 26 Apr 2024 10:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRf-00075A-9K
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:00 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRb-0001qn-VK
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:20:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7CB95D1B3;
 Fri, 26 Apr 2024 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPWq7CqMuVlecbO8p1Wu+OhDjoi7ZLLNh5mPmBy6qzQ=;
 b=PRhlSdxjlGZHepYnXTO3LQ1d3H2TpWgNIIfpR/ebCSjSiu9AgPGO4hxQ23luyY9SGSlrep
 612BRl3Ks5Sg4NLqBDGZVY5zHy/TTFPZ3EkZHJX8geDivyNkqry24/g1a29tCxdTKbR18V
 bN0xtjTCLZrOU+FzMuguZvOS8Fv70H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPWq7CqMuVlecbO8p1Wu+OhDjoi7ZLLNh5mPmBy6qzQ=;
 b=1E9HJKkziKB9913fmFmvGqmH3GWFbM2Ri0zGZsUdMoH4tEslCXzRrXZ8vmQbCU4yINPD60
 DTl+VVPAb/r7drAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPWq7CqMuVlecbO8p1Wu+OhDjoi7ZLLNh5mPmBy6qzQ=;
 b=PRhlSdxjlGZHepYnXTO3LQ1d3H2TpWgNIIfpR/ebCSjSiu9AgPGO4hxQ23luyY9SGSlrep
 612BRl3Ks5Sg4NLqBDGZVY5zHy/TTFPZ3EkZHJX8geDivyNkqry24/g1a29tCxdTKbR18V
 bN0xtjTCLZrOU+FzMuguZvOS8Fv70H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPWq7CqMuVlecbO8p1Wu+OhDjoi7ZLLNh5mPmBy6qzQ=;
 b=1E9HJKkziKB9913fmFmvGqmH3GWFbM2Ri0zGZsUdMoH4tEslCXzRrXZ8vmQbCU4yINPD60
 DTl+VVPAb/r7drAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4270A136DB;
 Fri, 26 Apr 2024 14:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aPbQAkS4K2YWcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:20:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/9] tests/qtest/migration: Fix file migration offset check
Date: Fri, 26 Apr 2024 11:20:36 -0300
Message-Id: <20240426142042.14573-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426142042.14573-1-farosas@suse.de>
References: <20240426142042.14573-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

When doing file migration, QEMU accepts an offset that should be
skipped when writing the migration stream to the file. The purpose of
the offset is to allow the management layer to put its own metadata at
the start of the file.

We have tests for this in migration-test, but only testing that the
migration stream starts at the correct offset and not that it actually
leaves the data intact. Unsurprisingly, there's been a bug in that
area that the tests didn't catch.

Fix the tests to write some data to the offset region and check that
it's actually there after the migration.

Fixes: 3dc35470c8 ("tests/qtest: migration-test: Add tests for file-based migration")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 70 +++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5d6d8cd634..7b177686b4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2081,6 +2081,63 @@ static void test_precopy_file(void)
     test_file_common(&args, true);
 }
 
+#ifndef _WIN32
+static void file_dirty_offset_region(void)
+{
+#if defined(__linux__)
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    size_t size = FILE_TEST_OFFSET;
+    uintptr_t *addr, *p;
+    int fd;
+
+    fd = open(path, O_CREAT | O_RDWR, 0660);
+    g_assert(fd != -1);
+
+    g_assert(!ftruncate(fd, size));
+
+    addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
+    g_assert(addr != MAP_FAILED);
+
+    /* ensure the skipped offset contains some data */
+    p = addr;
+    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
+        *p = (unsigned long) FILE_TEST_FILENAME;
+        p++;
+    }
+
+    munmap(addr, size);
+    fsync(fd);
+    close(fd);
+#endif
+}
+
+static void *file_offset_start_hook(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    int src_flags = O_WRONLY;
+    int dst_flags = O_RDONLY;
+    int fds[2];
+
+    file_dirty_offset_region();
+
+    fds[0] = open(file, src_flags, 0660);
+    assert(fds[0] != -1);
+
+    fds[1] = open(file, dst_flags, 0660);
+    assert(fds[1] != -1);
+
+    qtest_qmp_fds_assert_success(from, &fds[0], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+    qtest_qmp_fds_assert_success(to, &fds[1], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+    close(fds[0]);
+    close(fds[1]);
+
+    return NULL;
+}
+
 static void file_offset_finish_hook(QTestState *from, QTestState *to,
                                     void *opaque)
 {
@@ -2096,12 +2153,12 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
     g_assert(addr != MAP_FAILED);
 
     /*
-     * Ensure the skipped offset contains zeros and the migration
-     * stream starts at the right place.
+     * Ensure the skipped offset region's data has not been touched
+     * and the migration stream starts at the right place.
      */
     p = addr;
     while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
-        g_assert(*p == 0);
+        g_assert_cmpstr((char *) *p, ==, FILE_TEST_FILENAME);
         p++;
     }
     g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
@@ -2113,17 +2170,18 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
 
 static void test_precopy_file_offset(void)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
-                                           FILE_TEST_FILENAME,
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
+        .start_hook = file_offset_start_hook,
         .finish_hook = file_offset_finish_hook,
     };
 
     test_file_common(&args, false);
 }
+#endif
 
 static void test_precopy_file_offset_bad(void)
 {
@@ -3636,8 +3694,10 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
+#ifndef _WIN32
     migration_test_add("/migration/precopy/file/offset",
                        test_precopy_file_offset);
+#endif
     migration_test_add("/migration/precopy/file/offset/bad",
                        test_precopy_file_offset_bad);
 
-- 
2.35.3


