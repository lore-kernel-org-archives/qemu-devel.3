Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39969C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADmM-0002v8-UU; Thu, 23 May 2024 15:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlt-0002GX-Ng
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:38 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlp-0004KJ-Kq
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6E32040D;
 Thu, 23 May 2024 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sniV4ADiqxDqLReNOG6JjHF4fkYiKMuydvXvoREL6Bs=;
 b=zau8v39nBp01WAQq6alJ19sPqOuwXSnY7WnMEFruDqsiO9z+Vp9pXyjeekwsWq8xTg38I6
 bgmR1MXMjdExOYies9lcqIIhC6qTUerdxIS2FTlVPOSMtuR4OmK/SVA+XK12SNNc4p7RrJ
 CmttIeoVZbcfPc0TPs31i/PZ2jr1n1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sniV4ADiqxDqLReNOG6JjHF4fkYiKMuydvXvoREL6Bs=;
 b=l33cmH4A5PczwiVR3Bdo9C2vUFTimb2dVa9Ix1m2nWP3IhRk8BTIyt8p9K8T1sIeP4J3Sz
 4fcI2715YLvvvKCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sniV4ADiqxDqLReNOG6JjHF4fkYiKMuydvXvoREL6Bs=;
 b=zau8v39nBp01WAQq6alJ19sPqOuwXSnY7WnMEFruDqsiO9z+Vp9pXyjeekwsWq8xTg38I6
 bgmR1MXMjdExOYies9lcqIIhC6qTUerdxIS2FTlVPOSMtuR4OmK/SVA+XK12SNNc4p7RrJ
 CmttIeoVZbcfPc0TPs31i/PZ2jr1n1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sniV4ADiqxDqLReNOG6JjHF4fkYiKMuydvXvoREL6Bs=;
 b=l33cmH4A5PczwiVR3Bdo9C2vUFTimb2dVa9Ix1m2nWP3IhRk8BTIyt8p9K8T1sIeP4J3Sz
 4fcI2715YLvvvKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B658E13A6B;
 Thu, 23 May 2024 19:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJ8oH7STT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 15/18] tests/qtest/migration: Add a test for mapped-ram
 with passing of fds
Date: Thu, 23 May 2024 16:05:45 -0300
Message-Id: <20240523190548.23977-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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
 tests/qtest/migration-test.c | 101 +++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 37017ff2d5..5ced3b90c9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2047,11 +2047,18 @@ static void test_precopy_file(void)
 
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
 
@@ -2065,8 +2072,8 @@ static void *file_offset_fdset_start_hook(QTestState *from, QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
-    fdset_add_fds(from, file, O_WRONLY, 1);
-    fdset_add_fds(to, file, O_RDONLY, 1);
+    fdset_add_fds(from, file, O_WRONLY, 1, false);
+    fdset_add_fds(to, file, O_RDONLY, 1, false);
 
     return NULL;
 }
@@ -2238,6 +2245,87 @@ static void test_multifd_file_mapped_ram_dio(void)
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
@@ -3648,6 +3736,13 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/file/mapped-ram/dio",
                        test_multifd_file_mapped_ram_dio);
 
+#ifndef _WIN32
+    qtest_add_func("/migration/multifd/file/mapped-ram/fdset",
+                   test_multifd_file_mapped_ram_fdset);
+    qtest_add_func("/migration/multifd/file/mapped-ram/fdset/dio",
+                   test_multifd_file_mapped_ram_fdset_dio);
+#endif
+
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
-- 
2.35.3


