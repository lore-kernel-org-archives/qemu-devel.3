Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9709DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlL-00020h-D4; Thu, 23 May 2024 15:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlJ-0001xv-93
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:01 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlH-0004Fl-CH
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF08B22B73;
 Thu, 23 May 2024 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmpEEye7ycGf1aJ3oDklUvl3X7zM1pah4teZ4b0oRJc=;
 b=MZ+soJFuM7c3j5XrZba9z7IU5eUADY08N3XtPQaES7tfkoGXTlPKuowtBMMbnfouXXCgxf
 FavwHlKwfBrnfYs/eStN7mlzTc4VW3CjVBRbKRHBLhIzAA/bBSEEQKRcCM/CTFKPt01XB1
 0WIVxhKvR7Gdu6lwk1z99b2G5RaS2Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmpEEye7ycGf1aJ3oDklUvl3X7zM1pah4teZ4b0oRJc=;
 b=gcsHvmaDU9HySVd456A3VwIzHyDZWroloQTy/JutGFIAapSTR+bWztm9LLLatNKjh4Cx7Q
 Xtnwa5NZA4ll+pCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OlEPem0r;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RPVpaMpQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmpEEye7ycGf1aJ3oDklUvl3X7zM1pah4teZ4b0oRJc=;
 b=OlEPem0r2UOVAodlgajALjtwDrfgVXPm/mdVWyARZtJUmQ1e8xgCEPBFrW6GeR1n5IHjo4
 SpKXa6nmKlG8tpJAZcg+Tr8ymnqu+I2XD4/jJdNVPUE3FiFxBGjKs6fNmLUaCrfNakjxtp
 GKEgEW6jJh1WBFQ178609F3BYQFAgHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmpEEye7ycGf1aJ3oDklUvl3X7zM1pah4teZ4b0oRJc=;
 b=RPVpaMpQpuom+LTLSsEgID1JKFS56fPAqqqluEE5Kx42AkfYN8EHFuhPYkwh+VFKx1fkib
 5R9mPQDFYysKCyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 500F513A6B;
 Thu, 23 May 2024 19:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SDc5BpOTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:05:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 02/18] tests/qtest/migration: Fix file migration offset
 check
Date: Thu, 23 May 2024 16:05:32 -0300
Message-Id: <20240523190548.23977-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CF08B22B73
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

While here, switch to using g_get_file_contents() which is more
portable than mmap().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 79 ++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7e3406471..ec905543cf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -67,6 +67,7 @@ static QTestMigrationState dst_state;
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define FILE_TEST_FILENAME "migfile"
 #define FILE_TEST_OFFSET 0x1000
+#define FILE_TEST_MARKER 'X'
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 
@@ -1716,10 +1717,43 @@ finish:
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
+static void file_dirty_offset_region(void)
+{
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    size_t size = FILE_TEST_OFFSET;
+    g_autofree char *data = g_new0(char, size);
+
+    memset(data, FILE_TEST_MARKER, size);
+    g_assert(g_file_set_contents(path, data, size, NULL));
+}
+
+static void file_check_offset_region(void)
+{
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    size_t size = FILE_TEST_OFFSET;
+    g_autofree char *expected = g_new0(char, size);
+    g_autofree char *actual = NULL;
+    uint64_t *stream_start;
+
+    /*
+     * Ensure the skipped offset region's data has not been touched
+     * and the migration stream starts at the right place.
+     */
+
+    memset(expected, FILE_TEST_MARKER, size);
+
+    g_assert(g_file_get_contents(path, &actual, NULL, NULL));
+    g_assert(!memcmp(actual, expected, size));
+
+    stream_start = (uint64_t *)(actual + size);
+    g_assert_cmpint(cpu_to_be64(*stream_start) >> 32, ==, QEMU_VM_FILE_MAGIC);
+}
+
 static void test_file_common(MigrateCommon *args, bool stop_src)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    bool check_offset = false;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1732,6 +1766,16 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
      */
     g_assert_false(args->live);
 
+    if (g_strrstr(args->connect_uri, "offset=")) {
+        check_offset = true;
+        /*
+         * This comes before the start_hook because it's equivalent to
+         * a management application creating the file and writing to
+         * it so hooks should expect the file to be already present.
+         */
+        file_dirty_offset_region();
+    }
+
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
     }
@@ -1766,6 +1810,10 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
 
     wait_for_serial("dest_serial");
 
+    if (check_offset) {
+        file_check_offset_region();
+    }
+
 finish:
     if (args->finish_hook) {
         args->finish_hook(from, to, data_hook);
@@ -1965,36 +2013,6 @@ static void test_precopy_file(void)
     test_file_common(&args, true);
 }
 
-static void file_offset_finish_hook(QTestState *from, QTestState *to,
-                                    void *opaque)
-{
-#if defined(__linux__)
-    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
-    uintptr_t *addr, *p;
-    int fd;
-
-    fd = open(path, O_RDONLY);
-    g_assert(fd != -1);
-    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
-    g_assert(addr != MAP_FAILED);
-
-    /*
-     * Ensure the skipped offset contains zeros and the migration
-     * stream starts at the right place.
-     */
-    p = addr;
-    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
-        g_assert(*p == 0);
-        p++;
-    }
-    g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
-
-    munmap(addr, size);
-    close(fd);
-#endif
-}
-
 static void test_precopy_file_offset(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
@@ -2003,7 +2021,6 @@ static void test_precopy_file_offset(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .finish_hook = file_offset_finish_hook,
     };
 
     test_file_common(&args, false);
-- 
2.35.3


