Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14EDC021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidV8-00064H-QC; Thu, 13 Feb 2025 12:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidV6-00063E-HP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:49 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidV4-00068R-RP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AAA23225C3;
 Thu, 13 Feb 2025 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wnieFaULoZsqv7dcoALZa0T7zVyblYiS1hKhyamz3A=;
 b=AaH9ZLNsl4EahixoKP+XSY+7KAPWHy/Q/8ffjaF4GeEtGWi7ADlAJD5qLOxnImz/rKM06u
 31rxNFTzeJ4X68HsSQladaXRiIHQ7iQYCmZj7hU+t4yx4kZ5VenyK2W/OsLFKSGzUYwg/C
 RnPFz5RAqOPh6hsSBGjMWh5attEIQ0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wnieFaULoZsqv7dcoALZa0T7zVyblYiS1hKhyamz3A=;
 b=ru9yeGf3f2WxciXgQJ4Z8FPfqmBHqd4OBXAzAROJRh5kM+JpqeQIWfs9RqTQUzpAlM+mpV
 UggWhRgqcuj6/qCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wnieFaULoZsqv7dcoALZa0T7zVyblYiS1hKhyamz3A=;
 b=AaH9ZLNsl4EahixoKP+XSY+7KAPWHy/Q/8ffjaF4GeEtGWi7ADlAJD5qLOxnImz/rKM06u
 31rxNFTzeJ4X68HsSQladaXRiIHQ7iQYCmZj7hU+t4yx4kZ5VenyK2W/OsLFKSGzUYwg/C
 RnPFz5RAqOPh6hsSBGjMWh5attEIQ0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wnieFaULoZsqv7dcoALZa0T7zVyblYiS1hKhyamz3A=;
 b=ru9yeGf3f2WxciXgQJ4Z8FPfqmBHqd4OBXAzAROJRh5kM+JpqeQIWfs9RqTQUzpAlM+mpV
 UggWhRgqcuj6/qCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C88BE13874;
 Thu, 13 Feb 2025 17:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OO9XIQ8zrmfqMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 17:59:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 7/9] tests/qtest/migration: Introduce
 migration_test_add_suffix
Date: Thu, 13 Feb 2025 14:59:25 -0300
Message-Id: <20250213175927.19642-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250213175927.19642-1-farosas@suse.de>
References: <20250213175927.19642-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

Reviewed-by: Peter Xu <peterx@redhat.com>
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


