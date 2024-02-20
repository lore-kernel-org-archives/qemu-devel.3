Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32254C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoF-0002sg-74; Tue, 20 Feb 2024 17:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoD-0002sF-OE
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:53 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoC-0006E9-0K
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65E971FB40;
 Tue, 20 Feb 2024 22:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlKPYQWsZs/9s2dBARpZuk+jHSmln4GQa0Pkc6kcwiQ=;
 b=Oan0w3eKm1WtDIe6mQUhdhKSpP9MVJGfTEIcJpvLd6FRr2WVsumnR6zai9sh+3nhTsWdsb
 gz65jehHGCZDys/QaTyVSpgWhYMIoJdyXJ9hTasQ0DG5L9ojPQEuxCAYJAL/yx++OMPxwT
 RKgUXDdDiZl+BT8rJ5DgJrldo88eWGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlKPYQWsZs/9s2dBARpZuk+jHSmln4GQa0Pkc6kcwiQ=;
 b=KOQOSyP78ELIzL7wJqGDBPgSaCwl6W79pFJHJjWTqczYCpJlGgtfoAMVPlPSlYIwMweUUe
 CmKZX7vdsK8xHfDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlKPYQWsZs/9s2dBARpZuk+jHSmln4GQa0Pkc6kcwiQ=;
 b=Oan0w3eKm1WtDIe6mQUhdhKSpP9MVJGfTEIcJpvLd6FRr2WVsumnR6zai9sh+3nhTsWdsb
 gz65jehHGCZDys/QaTyVSpgWhYMIoJdyXJ9hTasQ0DG5L9ojPQEuxCAYJAL/yx++OMPxwT
 RKgUXDdDiZl+BT8rJ5DgJrldo88eWGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlKPYQWsZs/9s2dBARpZuk+jHSmln4GQa0Pkc6kcwiQ=;
 b=KOQOSyP78ELIzL7wJqGDBPgSaCwl6W79pFJHJjWTqczYCpJlGgtfoAMVPlPSlYIwMweUUe
 CmKZX7vdsK8xHfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DD13139D0;
 Tue, 20 Feb 2024 22:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aIaBNasq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:41:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 03/34] tests/qtest/migration: Add a fd + file test
Date: Tue, 20 Feb 2024 19:41:07 -0300
Message-Id: <20240220224138.24759-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Oan0w3eK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KOQOSyP7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.03 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.46)[97.55%]
X-Rspamd-Queue-Id: 65E971FB40
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The fd URI supports an fd that is backed by a file. The code should
select between QIOChannelFile and QIOChannelSocket, depending on the
type of the fd. Add a test for that.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b729ce4d22..83512bce85 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2433,6 +2433,45 @@ static void test_migrate_precopy_fd_socket(void)
     };
     test_precopy_common(&args);
 }
+
+static void *migrate_precopy_fd_file_start(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    int src_flags = O_CREAT | O_RDWR;
+    int dst_flags = O_CREAT | O_RDWR;
+    int fds[2];
+
+    fds[0] = open(file, src_flags, 0660);
+    assert(fds[0] != -1);
+
+    fds[1] = open(file, dst_flags, 0660);
+    assert(fds[1] != -1);
+
+
+    qtest_qmp_fds_assert_success(to, &fds[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    qtest_qmp_fds_assert_success(from, &fds[1], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    close(fds[0]);
+    close(fds[1]);
+
+    return NULL;
+}
+
+static void test_migrate_precopy_fd_file(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .connect_uri = "fd:fd-mig",
+        .start_hook = migrate_precopy_fd_file_start,
+        .finish_hook = test_migrate_fd_finish_hook
+    };
+    test_file_common(&args, true);
+}
 #endif /* _WIN32 */
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
@@ -3529,6 +3568,8 @@ int main(int argc, char **argv)
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
                        test_migrate_precopy_fd_socket);
+    migration_test_add("/migration/precopy/fd/file",
+                       test_migrate_precopy_fd_file);
 #endif
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
-- 
2.35.3


