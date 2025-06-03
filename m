Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB83BC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGcw-0000Td-5b; Mon, 02 Jun 2025 21:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcl-0000HE-CQ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:32 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcj-0001gC-CO
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA85D1F745;
 Tue,  3 Jun 2025 01:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi66cgU68uNxi8+JjcmFVcITaSr2nzElUOJtcyAAYdw=;
 b=cUrP6BFcWczbbm9L3a2M2d6mLC9m0Bx+zDh2AULoAInZksgphB+5UyLcEwTcLLZzvdVmio
 GU1TpovJOcinm95Krcj7cDvvczd8nqoS1ucbI1xZi+HHnOtyd34tURpSr/888CkYSKTT1p
 u4JdFLVkubEMxLwI+Cwk37wxcVSTvOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi66cgU68uNxi8+JjcmFVcITaSr2nzElUOJtcyAAYdw=;
 b=rWWdliYh0KA/KMtri1DvmPy4sFaHtrNm+v/KQgfP2HhDNlG1i8R/nLHSrXYiq40kHqUPua
 kHx+1xzlSXxMAbCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi66cgU68uNxi8+JjcmFVcITaSr2nzElUOJtcyAAYdw=;
 b=cUrP6BFcWczbbm9L3a2M2d6mLC9m0Bx+zDh2AULoAInZksgphB+5UyLcEwTcLLZzvdVmio
 GU1TpovJOcinm95Krcj7cDvvczd8nqoS1ucbI1xZi+HHnOtyd34tURpSr/888CkYSKTT1p
 u4JdFLVkubEMxLwI+Cwk37wxcVSTvOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi66cgU68uNxi8+JjcmFVcITaSr2nzElUOJtcyAAYdw=;
 b=rWWdliYh0KA/KMtri1DvmPy4sFaHtrNm+v/KQgfP2HhDNlG1i8R/nLHSrXYiq40kHqUPua
 kHx+1xzlSXxMAbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D89013700;
 Tue,  3 Jun 2025 01:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SFjDNy9SPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 21/21] tests/qtest/migration: Add a test for config passing
Date: Mon,  2 Jun 2025 22:38:10 -0300
Message-Id: <20250603013810.4772-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Pass the config directly via the migrate/incoming command.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.h  |  2 ++
 tests/qtest/migration/misc-tests.c | 39 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 01e425e64e..e55cd33fa8 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -145,6 +145,8 @@ typedef struct {
     /* Optional: fine tune start parameters */
     MigrateStart start;
 
+    const char *config;
+
     /* Required: the URI for the dst QEMU to listen on */
     const char *listen_uri;
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 54995256d8..e835865aee 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -256,6 +256,42 @@ static void test_validate_uri_channels_none_set(void)
     do_test_validate_uri_channel(&args);
 }
 
+static void test_config_migrate(void)
+{
+    QTestState *from, *to;
+    MigrateStart args = {
+        .hide_stderr = false,
+    };
+    const char *config = "{"
+        "'events':true, "
+        "'multifd':true, "
+        "'multifd-channels': 4"
+        "}";
+
+    if (migrate_start(&from, &to, "defer", &args)) {
+        return;
+    }
+
+    assert(qtest_qmp_cmd_has_feature(from, "migrate", "config"));
+
+    wait_for_serial("src_serial");
+    qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+    migrate_ensure_converge(from);
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL,
+                         "{ 'exit-on-error': false, 'config': %p }",
+                         qobject_from_json(config, &error_abort));
+
+    migrate_qmp(from, to, migrate_get_connect_uri(to), NULL,
+                "{ 'config': %p }",
+                qobject_from_json(config, &error_abort));
+
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+
+    migrate_end(from, to, false);
+}
+
 static void migration_test_add_misc_smoke(MigrationTestEnv *env)
 {
 #ifndef _WIN32
@@ -294,4 +330,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
+
+    migration_test_add("/migration/config/migrate",
+                       test_config_migrate);
 }
-- 
2.35.3


