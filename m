Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DF7C2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHY7-0003mf-E8; Mon, 17 Jun 2024 14:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHY5-0003m0-Pz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHY3-0004nk-QT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E16A1F443;
 Mon, 17 Jun 2024 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHDDc9Txz5UoWG2oPka59YLq/Od6MbDAayJ9RVr1JIo=;
 b=vhrDImY3EzLhjx1PnQb/hyyj7YQTeQfdgv0YwEEjd06v45wVJPkCe3+yASNjPMn9rtPFAb
 0YFNVXmUw62dEY8d0BnWuSd8/Z2kyGkDgFsUJZVQtKu4mYtXNh5nDmbwHAiRFKl3s0wBFO
 mDkbXHopyrC6vXW9fxxC4LmWLhiZXaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHDDc9Txz5UoWG2oPka59YLq/Od6MbDAayJ9RVr1JIo=;
 b=2iK+MnZ7/hZdVMEPBRHCsV7Xafs7z1HXVsnfwDJxBeGhgC9PY4l9QfAXpbbuJ2r7sAPxrL
 Xodn9ECFq0du9aBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vhrDImY3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2iK+MnZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHDDc9Txz5UoWG2oPka59YLq/Od6MbDAayJ9RVr1JIo=;
 b=vhrDImY3EzLhjx1PnQb/hyyj7YQTeQfdgv0YwEEjd06v45wVJPkCe3+yASNjPMn9rtPFAb
 0YFNVXmUw62dEY8d0BnWuSd8/Z2kyGkDgFsUJZVQtKu4mYtXNh5nDmbwHAiRFKl3s0wBFO
 mDkbXHopyrC6vXW9fxxC4LmWLhiZXaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHDDc9Txz5UoWG2oPka59YLq/Od6MbDAayJ9RVr1JIo=;
 b=2iK+MnZ7/hZdVMEPBRHCsV7Xafs7z1HXVsnfwDJxBeGhgC9PY4l9QfAXpbbuJ2r7sAPxrL
 Xodn9ECFq0du9aBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFDF6139AB;
 Mon, 17 Jun 2024 18:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJ/ULCeHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:57:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/16] tests/qtest/migration: Add a precopy file test with
 fdset
Date: Mon, 17 Jun 2024 15:57:19 -0300
Message-Id: <20240617185731.9725-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617185731.9725-1-farosas@suse.de>
References: <20240617185731.9725-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E16A1F443
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Add a test for file migration using fdset. The passing of fds is more
complex than using a file path. This is also the scenario where it's
most important we ensure that the initial migration stream offset is
respected because the fdset interface is the one used by the
management layer when providing a non empty migration file.

Note that fd passing is not available on Windows, so anything that
uses add-fd needs to exclude that platform.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0a529a527b..22b07bc0ec 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1990,6 +1990,46 @@ static void test_precopy_file(void)
     test_file_common(&args, true);
 }
 
+#ifndef _WIN32
+static void fdset_add_fds(QTestState *qts, const char *file, int flags,
+                          int num_fds)
+{
+    for (int i = 0; i < num_fds; i++) {
+        int fd;
+
+        fd = open(file, flags, 0660);
+        assert(fd != -1);
+
+        qtest_qmp_fds_assert_success(qts, &fd, 1, "{'execute': 'add-fd', "
+                                     "'arguments': {'fdset-id': 1}}");
+        close(fd);
+    }
+}
+
+static void *file_offset_fdset_start_hook(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 1);
+    fdset_add_fds(to, file, O_RDONLY, 1);
+
+    return NULL;
+}
+
+static void test_precopy_file_offset_fdset(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = file_offset_fdset_start_hook,
+    };
+
+    test_file_common(&args, false);
+}
+#endif
+
 static void test_precopy_file_offset(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
@@ -3527,6 +3567,10 @@ int main(int argc, char **argv)
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
                        test_precopy_file_offset);
+#ifndef _WIN32
+    migration_test_add("/migration/precopy/file/offset/fdset",
+                       test_precopy_file_offset_fdset);
+#endif
     migration_test_add("/migration/precopy/file/offset/bad",
                        test_precopy_file_offset_bad);
 
-- 
2.35.3


