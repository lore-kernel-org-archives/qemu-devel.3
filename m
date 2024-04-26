Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CA3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MRw-0007F2-Gl; Fri, 26 Apr 2024 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRv-0007EI-1D
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRt-00024W-4o
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 547F434E8C;
 Fri, 26 Apr 2024 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8aiSWTRniGHc9b86c5xny7TEU/klyh6y5vk0UkaIyc=;
 b=qq0eE0n26PiAfZsOHJ0s3GYQCH/QjV1c/haZm07OXXL7KeO3B7XX3Svf+LpOLLpppTc3Sz
 I8cxGtwroQJENuEFTYtxI0whslVKSVfmtJCt87weqAz7Lw/AfrG9GHjZvyAHfdoIxIGw8f
 Rh9F+fLA/SIJeQkrOOHq/Mj4VHR9FkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8aiSWTRniGHc9b86c5xny7TEU/klyh6y5vk0UkaIyc=;
 b=bpqV2eMBP2ZxJRfWZ4mhAcXVZoYdFgmIinOG4VDNd9KbF7F8iyLzxGrq5E/e9+/ON24Jf1
 rKtDFvQuZ4ThG7Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qq0eE0n2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bpqV2eMB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8aiSWTRniGHc9b86c5xny7TEU/klyh6y5vk0UkaIyc=;
 b=qq0eE0n26PiAfZsOHJ0s3GYQCH/QjV1c/haZm07OXXL7KeO3B7XX3Svf+LpOLLpppTc3Sz
 I8cxGtwroQJENuEFTYtxI0whslVKSVfmtJCt87weqAz7Lw/AfrG9GHjZvyAHfdoIxIGw8f
 Rh9F+fLA/SIJeQkrOOHq/Mj4VHR9FkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8aiSWTRniGHc9b86c5xny7TEU/klyh6y5vk0UkaIyc=;
 b=bpqV2eMBP2ZxJRfWZ4mhAcXVZoYdFgmIinOG4VDNd9KbF7F8iyLzxGrq5E/e9+/ON24Jf1
 rKtDFvQuZ4ThG7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC19E136DB;
 Fri, 26 Apr 2024 14:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UEN5IFO4K2YWcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:21:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 9/9] tests/qtest/migration: Add a test for mapped-ram with
 passing of fds
Date: Fri, 26 Apr 2024 11:20:42 -0300
Message-Id: <20240426142042.14573-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426142042.14573-1-farosas@suse.de>
References: <20240426142042.14573-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 547F434E8C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

Add a multifd test for mapped-ram with passing of fds into QEMU. This
is how libvirt will consume the feature.

There are a couple of details to the fdset mechanism:

- multifd needs two distinct file descriptors (not duplicated with
  dup()) on the outgoing side so it can enable O_DIRECT only on the
  channels that write with alignment. The dup() system call creates
  file descriptors that share status flags, of which O_DIRECT is one.

  the incoming side doesn't set O_DIRECT, so it can dup() fds and
  therefore can receive only one in the fdset.

- the open() access mode flags used for the fds passed into QEMU need
  to match the flags QEMU uses to open the file. Currently O_WRONLY
  for src and O_RDONLY for dst.

O_DIRECT is not supported on all systems/filesystems, so run the fdset
test without O_DIRECT if that's the case. The migration code should
still work in that scenario.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 90 ++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 512b7ede8b..d83f1bdd4f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2331,8 +2331,93 @@ static void test_multifd_file_mapped_ram_dio(void)
     test_file_common(&args, true);
 }
 
+static void migrate_multifd_mapped_ram_fdset_dio_end(QTestState *from,
+                                                    QTestState *to,
+                                                    void *opaque)
+{
+    QDict *resp;
+    QList *fdsets;
+
+    file_offset_finish_hook(from, to, opaque);
+
+    /*
+     * Check that we removed the fdsets after migration, otherwise a
+     * second migration would fail due to too many fdsets.
+     */
+
+    resp = qtest_qmp(from, "{'execute': 'query-fdsets', "
+                     "'arguments': {}}");
+    g_assert(qdict_haskey(resp, "return"));
+    fdsets = qdict_get_qlist(resp, "return");
+    g_assert(fdsets && qlist_empty(fdsets));
+}
 #endif /* O_DIRECT */
 
+#ifndef _WIN32
+static void *migrate_multifd_mapped_ram_fdset(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    int fds[3];
+    int src_flags = O_WRONLY;
+
+    file_dirty_offset_region();
+
+    /* main outgoing channel: no O_DIRECT */
+    fds[0] = open(file, src_flags, 0660);
+    assert(fds[0] != -1);
+
+    qtest_qmp_fds_assert_success(from, &fds[0], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+#ifdef O_DIRECT
+    src_flags |= O_DIRECT;
+
+    /* secondary outgoing channels */
+    fds[1] = open(file, src_flags, 0660);
+    assert(fds[1] != -1);
+
+    qtest_qmp_fds_assert_success(from, &fds[1], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+    /* incoming channel */
+    fds[2] = open(file, O_CREAT | O_RDONLY, 0660);
+    assert(fds[2] != -1);
+
+    qtest_qmp_fds_assert_success(to, &fds[2], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+    migrate_multifd_mapped_ram_dio_start(from, to);
+#else
+    migrate_multifd_mapped_ram_start(from, to);
+#endif
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
+        .start_hook = migrate_multifd_mapped_ram_fdset,
+#ifdef O_DIRECT
+        .finish_hook = migrate_multifd_mapped_ram_fdset_dio_end,
+#endif
+    };
+
+#ifdef O_DIRECT
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+#endif
+
+    test_file_common(&args, true);
+}
+#endif /* _WIN32 */
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -3761,6 +3846,11 @@ int main(int argc, char **argv)
                        test_multifd_file_mapped_ram_dio);
 #endif
 
+#ifndef _WIN32
+    qtest_add_func("/migration/multifd/file/mapped-ram/fdset",
+                   test_multifd_file_mapped_ram_fdset);
+#endif
+
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
-- 
2.35.3


