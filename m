Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F76C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTe-0003UF-Jg; Fri, 21 Jun 2024 13:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTd-0003Tf-AS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTb-0003Mw-Ho
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 559BF21B40;
 Fri, 21 Jun 2024 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQMSO1PwgZ5E3haVbmGS8ZvQsHMK98RmZZ5KCSDiAQk=;
 b=zBil1pyc6TFNn9IYWrrlJYId3FHP1i1l1oI6CnwalKUOzbqLUEg6FBj/frdyBuCRPf7Oei
 SAK21W2KwPT8ks7+OFTMz+tXEZlEGoPWp9DZKR/WVqx3DRlDZOb5pp4WWNYyL1rcjd8jVA
 Kk0Leg1wy9QXo4Qo7FwYpjzW9BjycEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQMSO1PwgZ5E3haVbmGS8ZvQsHMK98RmZZ5KCSDiAQk=;
 b=7GVISZFnhrIhX28wNyOvsl+cAl470JZx7nstS9OnvWNIizXqDlu0yhCXdkHiH4e7Xpwf73
 SfsEfi9xY/hEFcAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zBil1pyc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7GVISZFn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQMSO1PwgZ5E3haVbmGS8ZvQsHMK98RmZZ5KCSDiAQk=;
 b=zBil1pyc6TFNn9IYWrrlJYId3FHP1i1l1oI6CnwalKUOzbqLUEg6FBj/frdyBuCRPf7Oei
 SAK21W2KwPT8ks7+OFTMz+tXEZlEGoPWp9DZKR/WVqx3DRlDZOb5pp4WWNYyL1rcjd8jVA
 Kk0Leg1wy9QXo4Qo7FwYpjzW9BjycEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQMSO1PwgZ5E3haVbmGS8ZvQsHMK98RmZZ5KCSDiAQk=;
 b=7GVISZFnhrIhX28wNyOvsl+cAl470JZx7nstS9OnvWNIizXqDlu0yhCXdkHiH4e7Xpwf73
 SfsEfi9xY/hEFcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29D0313AAA;
 Fri, 21 Jun 2024 17:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kDYaOHi+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/28] tests/qtest/migration: Add a test for mapped-ram with
 passing of fds
Date: Fri, 21 Jun 2024 14:54:22 -0300
Message-Id: <20240621175434.31180-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 559BF21B40
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Add a multifd test for mapped-ram with passing of fds into QEMU. This
is how libvirt will consume the feature.

There are a couple of details to the fdset mechanism:

- multifd needs two distinct file descriptors (not duplicated with
  dup()) so it can enable O_DIRECT only on the channels that do
  aligned IO. The dup() system call creates file descriptors that
  share status flags, of which O_DIRECT is one.

- the open() access mode flags used for the fds passed into QEMU need
  to match the flags QEMU uses to open the file. Currently O_WRONLY
  for src and O_RDONLY for dst.

Note that fdset code goes under _WIN32 because fd passing is not
supported on Windows.

Reviewed-by: Peter Xu <peterx@redhat.com>
[brought back the qmp_remove_fd() call at the end of the tests]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 105 ++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5c41d1b70e..6207305ff8 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2104,11 +2104,18 @@ static void test_precopy_file(void)
 
 #ifndef _WIN32
 static void fdset_add_fds(QTestState *qts, const char *file, int flags,
-                          int num_fds)
+                          int num_fds, bool direct_io)
 {
     for (int i = 0; i < num_fds; i++) {
         int fd;
 
+#ifdef O_DIRECT
+        /* only secondary channels can use direct-io */
+        if (direct_io && i != 0) {
+            flags |= O_DIRECT;
+        }
+#endif
+
         fd = open(file, flags, 0660);
         assert(fd != -1);
 
@@ -2122,8 +2129,8 @@ static void *file_offset_fdset_start_hook(QTestState *from, QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
-    fdset_add_fds(from, file, O_WRONLY, 1);
-    fdset_add_fds(to, file, O_RDONLY, 1);
+    fdset_add_fds(from, file, O_WRONLY, 1, false);
+    fdset_add_fds(to, file, O_RDONLY, 1, false);
 
     return NULL;
 }
@@ -2295,6 +2302,91 @@ static void test_multifd_file_mapped_ram_dio(void)
     test_file_common(&args, true);
 }
 
+#ifndef _WIN32
+static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
+                                         void *opaque)
+{
+    QDict *resp;
+    QList *fdsets;
+
+    /*
+     * Remove the fdsets after migration, otherwise a second migration
+     * would fail due fdset reuse.
+     */
+    qtest_qmp_assert_success(from, "{'execute': 'remove-fd', "
+                             "'arguments': { 'fdset-id': 1}}");
+
+    /*
+     * Make sure no fdsets are left after migration, otherwise a
+     * second migration would fail due fdset reuse.
+     */
+    resp = qtest_qmp(from, "{'execute': 'query-fdsets', "
+                     "'arguments': {}}");
+    g_assert(qdict_haskey(resp, "return"));
+    fdsets = qdict_get_qlist(resp, "return");
+    g_assert(fdsets && qlist_empty(fdsets));
+}
+
+static void *multifd_mapped_ram_fdset_dio(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 2, true);
+    fdset_add_fds(to, file, O_RDONLY, 2, true);
+
+    migrate_multifd_mapped_ram_start(from, to);
+    migrate_set_parameter_bool(from, "direct-io", true);
+    migrate_set_parameter_bool(to, "direct-io", true);
+
+    return NULL;
+}
+
+static void *multifd_mapped_ram_fdset(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 2, false);
+    fdset_add_fds(to, file, O_RDONLY, 2, false);
+
+    migrate_multifd_mapped_ram_start(from, to);
+
+    return NULL;
+}
+
+static void test_multifd_file_mapped_ram_fdset(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = multifd_mapped_ram_fdset,
+        .finish_hook = multifd_mapped_ram_fdset_end,
+    };
+
+    test_file_common(&args, true);
+}
+
+static void test_multifd_file_mapped_ram_fdset_dio(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = multifd_mapped_ram_fdset_dio,
+        .finish_hook = multifd_mapped_ram_fdset_end,
+    };
+
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+
+    test_file_common(&args, true);
+}
+#endif /* !_WIN32 */
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -3736,6 +3828,13 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/file/mapped-ram/dio",
                        test_multifd_file_mapped_ram_dio);
 
+#ifndef _WIN32
+    migration_test_add("/migration/multifd/file/mapped-ram/fdset",
+                       test_multifd_file_mapped_ram_fdset);
+    migration_test_add("/migration/multifd/file/mapped-ram/fdset/dio",
+                       test_multifd_file_mapped_ram_fdset_dio);
+#endif
+
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
-- 
2.35.3


