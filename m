Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2388BC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoi-0003KW-DM; Tue, 20 Feb 2024 17:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoe-0003KI-UG
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:21 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYod-0006Ld-Bs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 192BB1FB40;
 Tue, 20 Feb 2024 22:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSbiTWWDbTpy9l2roNT+qTSBnWkmKZrMhXNYrciFAWY=;
 b=DA3bnF1ti6pMi8KGBvh9f3g9/sScVWcj8PfMEl+K6BrbWsKvduERYdsxMKoe11XMPOHKkx
 YLErO7nI2fZKYQU6O1tzAviaglAXx3Vwygqcgr+iUoOMAt9gFsk6MownC545yD1SAb4Tdr
 3xVhaZKS40N3jwgxTG7N8pRlpWvlMwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSbiTWWDbTpy9l2roNT+qTSBnWkmKZrMhXNYrciFAWY=;
 b=L/C2xDhkZGOg+NtseWDv7hqPrGKCJ0Te4Th0oKgCN1A7Vk3oROr3p9HG9Tl30hb5mCPQwa
 yS1kATYT+84GD7CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSbiTWWDbTpy9l2roNT+qTSBnWkmKZrMhXNYrciFAWY=;
 b=DA3bnF1ti6pMi8KGBvh9f3g9/sScVWcj8PfMEl+K6BrbWsKvduERYdsxMKoe11XMPOHKkx
 YLErO7nI2fZKYQU6O1tzAviaglAXx3Vwygqcgr+iUoOMAt9gFsk6MownC545yD1SAb4Tdr
 3xVhaZKS40N3jwgxTG7N8pRlpWvlMwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSbiTWWDbTpy9l2roNT+qTSBnWkmKZrMhXNYrciFAWY=;
 b=L/C2xDhkZGOg+NtseWDv7hqPrGKCJ0Te4Th0oKgCN1A7Vk3oROr3p9HG9Tl30hb5mCPQwa
 yS1kATYT+84GD7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C403F139D0;
 Tue, 20 Feb 2024 22:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YAtoIscq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 15/34] tests/qtest/migration: Add tests for fixed-ram
 file-based migration
Date: Tue, 20 Feb 2024 19:41:19 -0300
Message-Id: <20240220224138.24759-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DA3bnF1t;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="L/C2xDhk"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
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
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 192BB1FB40
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 83512bce85..d61f93b151 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2200,6 +2200,14 @@ static void *test_mode_reboot_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
+static void *migrate_fixed_ram_start(QTestState *from, QTestState *to)
+{
+    migrate_set_capability(from, "fixed-ram", true);
+    migrate_set_capability(to, "fixed-ram", true);
+
+    return NULL;
+}
+
 static void test_mode_reboot(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -2214,6 +2222,32 @@ static void test_mode_reboot(void)
     test_file_common(&args, true);
 }
 
+static void test_precopy_file_fixed_ram_live(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_fixed_ram_start,
+    };
+
+    test_file_common(&args, false);
+}
+
+static void test_precopy_file_fixed_ram(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_fixed_ram_start,
+    };
+
+    test_file_common(&args, true);
+}
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -2462,6 +2496,13 @@ static void *migrate_precopy_fd_file_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
+static void *migrate_fd_file_fixed_ram_start(QTestState *from, QTestState *to)
+{
+    migrate_fixed_ram_start(from, to);
+
+    return migrate_precopy_fd_file_start(from, to);
+}
+
 static void test_migrate_precopy_fd_file(void)
 {
     MigrateCommon args = {
@@ -2472,6 +2513,17 @@ static void test_migrate_precopy_fd_file(void)
     };
     test_file_common(&args, true);
 }
+
+static void test_migrate_precopy_fd_file_fixed_ram(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .connect_uri = "fd:fd-mig",
+        .start_hook = migrate_fd_file_fixed_ram_start,
+        .finish_hook = test_migrate_fd_finish_hook
+    };
+    test_file_common(&args, true);
+}
 #endif /* _WIN32 */
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
@@ -3509,6 +3561,11 @@ int main(int argc, char **argv)
         migration_test_add("/migration/mode/reboot", test_mode_reboot);
     }
 
+    migration_test_add("/migration/precopy/file/fixed-ram",
+                       test_precopy_file_fixed_ram);
+    migration_test_add("/migration/precopy/file/fixed-ram/live",
+                       test_precopy_file_fixed_ram_live);
+
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
@@ -3570,6 +3627,8 @@ int main(int argc, char **argv)
                        test_migrate_precopy_fd_socket);
     migration_test_add("/migration/precopy/fd/file",
                        test_migrate_precopy_fd_file);
+    migration_test_add("/migration/precopy/fd/file/fixed-ram",
+                       test_migrate_precopy_fd_file_fixed_ram);
 #endif
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
-- 
2.35.3


