Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0E9C02195
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWK-00046J-TR; Wed, 29 Jan 2025 11:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVf-0003Iv-Af
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVb-0005J0-QK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:45 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACAB71F365;
 Wed, 29 Jan 2025 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vN8JojS+N0xJVWr6EVwFkYPAH1lMSOX0z+A5Ctq3e0M=;
 b=FyGyWkkGuMn5CI1p+j+KA6t5Rtq2/dxYSc7tOr3/fQ+GQGvukrtBb2dFiMuyFdh4enYVi6
 8j5jfAwLaQ7nn0vB+jfC0svfuwbQ3vxXaKMr7skF5MAax4nBzLOKZLT3ib3tmi+hRNIfku
 pDeN90EMNrAWijZ7VUvhCrDuoiUAEz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vN8JojS+N0xJVWr6EVwFkYPAH1lMSOX0z+A5Ctq3e0M=;
 b=eTU2ZSn1tq18RaKtW+6qJ/xvH1eatWJpBtJ3abtO1s/24JravtzSC2HsaHBruXp4jQkUlF
 6M3fTpUZbeWlwOCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vN8JojS+N0xJVWr6EVwFkYPAH1lMSOX0z+A5Ctq3e0M=;
 b=FyGyWkkGuMn5CI1p+j+KA6t5Rtq2/dxYSc7tOr3/fQ+GQGvukrtBb2dFiMuyFdh4enYVi6
 8j5jfAwLaQ7nn0vB+jfC0svfuwbQ3vxXaKMr7skF5MAax4nBzLOKZLT3ib3tmi+hRNIfku
 pDeN90EMNrAWijZ7VUvhCrDuoiUAEz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vN8JojS+N0xJVWr6EVwFkYPAH1lMSOX0z+A5Ctq3e0M=;
 b=eTU2ZSn1tq18RaKtW+6qJ/xvH1eatWJpBtJ3abtO1s/24JravtzSC2HsaHBruXp4jQkUlF
 6M3fTpUZbeWlwOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6891C137DB;
 Wed, 29 Jan 2025 16:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aO+2CuVQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 18/42] migration-test: memory_backend
Date: Wed, 29 Jan 2025 13:00:35 -0300
Message-Id: <20250129160059.6987-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:mid];
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

From: Steve Sistare <steven.sistare@oracle.com>

Allow each migration test to define its own memory backend, replacing
the standard "-m <size>" specification.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1736967650-129648-18-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 15 +++++++++++----
 tests/qtest/migration/framework.h |  5 +++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4550cda129..758e14abab 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -221,6 +221,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     g_autofree char *machine = NULL;
     const char *bootpath;
     g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
+    g_autofree char *memory_backend = NULL;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -296,6 +297,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
             memory_size, shmem_path);
     }
 
+    if (args->memory_backend) {
+        memory_backend = g_strdup_printf(args->memory_backend, memory_size);
+    } else {
+        memory_backend = g_strdup_printf("-m %s ", memory_size);
+    }
+
     if (args->use_dirty_ring) {
         kvm_opts = ",dirty-ring-size=4096";
     }
@@ -314,12 +321,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name source,debug-threads=on "
-                                 "-m %s "
+                                 "%s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs,
+                                 memory_backend, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
@@ -335,13 +342,13 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
-                                 "-m %s "
+                                 "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs, uri,
+                                 memory_backend, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 7991ee56b6..dd2db1c000 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -111,6 +111,11 @@ typedef struct {
     bool suspend_me;
     /* enable OOB QMP capability */
     bool oob;
+    /*
+     * Format string for the main memory backend, containing one %s where the
+     * size is plugged in.  If omitted, "-m %s" is used.
+     */
+    const char *memory_backend;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
-- 
2.35.3


