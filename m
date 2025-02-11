Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F2AC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 15:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsEh-0005iw-2T; Tue, 11 Feb 2025 10:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thsEf-0005gL-Jx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:31:41 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thsEd-00047x-KS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:31:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F95E37C29;
 Tue, 11 Feb 2025 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjZ9zWeddYbirgfu2Z3mbCNHaJtIqoI8INwYmWtjtOw=;
 b=kcxJqfEtnORRYEXQQDXCU3wN1DKluZa4/Vnf0ubxRj45ikGZJHWmj11Kz4jvnwx0Mkk0j4
 4nq0YRoNHN6zCZn8WfUZbvegKf/Yymby/AQ8LCjK1VdSk7ISRO5iJEP5/Ur0tv+ZRof11o
 Mf+oOZ2fIaLyA4NRiRppktXXvMyGdU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjZ9zWeddYbirgfu2Z3mbCNHaJtIqoI8INwYmWtjtOw=;
 b=Zuot4yAnGbMI7+dZt65y4JcRfAPqd7GexGeg5QZV4MC81E5ZJRI6uMUR63ni6Lx8YPWaw5
 K8+QiUUNwTPSzOBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kcxJqfEt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zuot4yAn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjZ9zWeddYbirgfu2Z3mbCNHaJtIqoI8INwYmWtjtOw=;
 b=kcxJqfEtnORRYEXQQDXCU3wN1DKluZa4/Vnf0ubxRj45ikGZJHWmj11Kz4jvnwx0Mkk0j4
 4nq0YRoNHN6zCZn8WfUZbvegKf/Yymby/AQ8LCjK1VdSk7ISRO5iJEP5/Ur0tv+ZRof11o
 Mf+oOZ2fIaLyA4NRiRppktXXvMyGdU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjZ9zWeddYbirgfu2Z3mbCNHaJtIqoI8INwYmWtjtOw=;
 b=Zuot4yAnGbMI7+dZt65y4JcRfAPqd7GexGeg5QZV4MC81E5ZJRI6uMUR63ni6Lx8YPWaw5
 K8+QiUUNwTPSzOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BFA713AA6;
 Tue, 11 Feb 2025 15:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8COFB2Bmq2c8WwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 11 Feb 2025 15:01:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 7/9] tests/qtest/migration: Introduce
 migration_test_add_suffix
Date: Tue, 11 Feb 2025 12:01:34 -0300
Message-Id: <20250211150136.6781-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250211150136.6781-1-farosas@suse.de>
References: <20250211150136.6781-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F95E37C29
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Introduce a new migration_test_add_suffix to allow programmatic
creation of tests based on a suffix. Pass the test name into the test
so it can know which variant to run.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-util.c | 24 ++++++++++++++++++++++++
 tests/qtest/migration/migration-util.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 6261d80e4a..642cf50c8d 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -236,6 +236,7 @@ char *resolve_machine_version(const char *alias, const char *var1,
 typedef struct {
     char *name;
     void (*func)(void);
+    void (*func_full)(void *);
 } MigrationTest;
 
 static void migration_test_destroy(gpointer data)
@@ -265,6 +266,29 @@ void migration_test_add(const char *path, void (*fn)(void))
                              migration_test_destroy);
 }
 
+static void migration_test_wrapper_full(const void *data)
+{
+    MigrationTest *test = (MigrationTest *)data;
+
+    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
+    test->func_full(test->name);
+}
+
+void migration_test_add_suffix(const char *path, const char *suffix,
+                               void (*fn)(void *))
+{
+    MigrationTest *test = g_new0(MigrationTest, 1);
+
+    g_assert(g_str_has_suffix(path, "/"));
+    g_assert(!g_str_has_prefix(suffix, "/"));
+
+    test->func_full = fn;
+    test->name = g_strconcat(path, suffix, NULL);
+
+    qtest_add_data_func_full(test->name, test, migration_test_wrapper_full,
+                             migration_test_destroy);
+}
+
 #ifdef O_DIRECT
 /*
  * Probe for O_DIRECT support on the filesystem. Since this is used
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index f5f2e4650e..44815e9c42 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -51,6 +51,8 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 bool ufd_version_check(bool *uffd_feature_thread_id);
 bool kvm_dirty_ring_supported(void);
 void migration_test_add(const char *path, void (*fn)(void));
+void migration_test_add_suffix(const char *path, const char *suffix,
+                               void (*fn)(void *));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
 
-- 
2.35.3


