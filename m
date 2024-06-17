Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCBAC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYd-0003x3-B7; Mon, 17 Jun 2024 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYb-0003we-Lh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYZ-0004vU-M6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 440F221AD5;
 Mon, 17 Jun 2024 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7+I+YqymBBSdik7DLw05Z9r+gdDjzbBZ4qUANuFuc8=;
 b=h/s4ngmtgY/9LFJ5qjM98BzFAfntmpDzIsjgkKkJVOw1psvQ43rir+1/kUP6czdKmZURAc
 vhE3cllxhY4gF0WH+aI9Ut0j1erxqr77f2E+PhIFhgg025DuKO68EnDYMfSl2r9XJGThxL
 oc6NNuIM7eOUKee5tUW3dUe2gjM+UyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7+I+YqymBBSdik7DLw05Z9r+gdDjzbBZ4qUANuFuc8=;
 b=u5E1C5d4userhCuDN9EQBn2k+9/Q+HHH/88ZwpS4C+eFYH4kCdQO/7dZT0dD1NQkC0XYcK
 +WAqKlpWI/x5u6Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kE6bkKjq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rg4xYjx3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7+I+YqymBBSdik7DLw05Z9r+gdDjzbBZ4qUANuFuc8=;
 b=kE6bkKjqQs14gvkH8qMuiT2jv7nMM23O9LcbKHYHiBilRzkrh7akaePCY34C3b8Uv5q8Ym
 2nHnkGyTqSiHkJSbg3kBYQXqqsjSGGelN/pipMe8w1XHBD0bF9c0p6yTbd0j0NrPihVMNe
 VX6+oDaC5jUihleFqBPV/x5k6vEklBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7+I+YqymBBSdik7DLw05Z9r+gdDjzbBZ4qUANuFuc8=;
 b=rg4xYjx395vnElNDVIpzE27TilBEbCvnRMdXtLnwJwcukbNdEF27l8ImWSgrSidY+uT8iQ
 29KbXl5VgaS6mpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B400F139AB;
 Mon, 17 Jun 2024 18:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QIleHkaHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:58:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 16/16] tests/qtest/migration: Add a test for mapped-ram
 with passing of fds
Date: Mon, 17 Jun 2024 15:57:31 -0300
Message-Id: <20240617185731.9725-17-farosas@suse.de>
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
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[9];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 440F221AD5
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- dropped Peter's r-b

- stopped removing the fdset at the end of the tests. The migration
code should always cleanup after itself.
---
 tests/qtest/migration-test.c | 98 ++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 928f0ca6ce..85a21ff5e9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2024,11 +2024,18 @@ static void test_precopy_file(void)
 
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
 
@@ -2042,8 +2049,8 @@ static void *file_offset_fdset_start_hook(QTestState *from, QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
-    fdset_add_fds(from, file, O_WRONLY, 1);
-    fdset_add_fds(to, file, O_RDONLY, 1);
+    fdset_add_fds(from, file, O_WRONLY, 1, false);
+    fdset_add_fds(to, file, O_RDONLY, 1, false);
 
     return NULL;
 }
@@ -2215,6 +2222,84 @@ static void test_multifd_file_mapped_ram_dio(void)
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
@@ -3654,6 +3739,13 @@ int main(int argc, char **argv)
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


