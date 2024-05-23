Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81393C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlN-00022K-JT; Thu, 23 May 2024 15:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlM-00021Y-6w
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:04 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlK-0004GA-Ei
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:03 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D0AD52040D;
 Thu, 23 May 2024 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ER5Peeluxy6JHmSRH7zQ8d3YDDvk/6q9I4V6pgtQEYE=;
 b=1VMJu6e1iveSpV6QYuluTlc9Q/Nyty9M9X33/s/qVrr/IlM6rdvqJJFCQFnfBaKcRPPXc1
 getx6Y7fU4kK1KGK4GP1BmTkjrUx/ln4wiPAkvolg88xR6YM8MLtXlVmIzseYYD11VVJU0
 VoENooGvbryvQ8GlcwdhO3IaDirySUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ER5Peeluxy6JHmSRH7zQ8d3YDDvk/6q9I4V6pgtQEYE=;
 b=tCORUTJvo1nPfEALMVo84uUvYWoRtlBg/s8U8MVC8okaTSz0nqw+k/cz4rYQrWIODDA5a6
 /PRGcjCK+iZsaAAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ER5Peeluxy6JHmSRH7zQ8d3YDDvk/6q9I4V6pgtQEYE=;
 b=1VMJu6e1iveSpV6QYuluTlc9Q/Nyty9M9X33/s/qVrr/IlM6rdvqJJFCQFnfBaKcRPPXc1
 getx6Y7fU4kK1KGK4GP1BmTkjrUx/ln4wiPAkvolg88xR6YM8MLtXlVmIzseYYD11VVJU0
 VoENooGvbryvQ8GlcwdhO3IaDirySUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ER5Peeluxy6JHmSRH7zQ8d3YDDvk/6q9I4V6pgtQEYE=;
 b=tCORUTJvo1nPfEALMVo84uUvYWoRtlBg/s8U8MVC8okaTSz0nqw+k/cz4rYQrWIODDA5a6
 /PRGcjCK+iZsaAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BEA713A6B;
 Thu, 23 May 2024 19:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0Fn+BJaTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:05:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 03/18] tests/qtest/migration: Add a precopy file test with
 fdset
Date: Thu, 23 May 2024 16:05:33 -0300
Message-Id: <20240523190548.23977-4-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Add a test for file migration using fdset. The passing of fds is more
complex than using a file path. This is also the scenario where it's
most important we ensure that the initial migration stream offset is
respected because the fdset interface is the one used by the
management layer when providing a non empty migration file.

Note that fd passing is not available on Windows, so anything that
uses add-fd needs to exclude that platform.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index ec905543cf..5bb53f4839 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2013,6 +2013,46 @@ static void test_precopy_file(void)
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
@@ -3521,6 +3561,10 @@ int main(int argc, char **argv)
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


