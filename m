Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44mJ-0001As-GH; Wed, 01 Oct 2025 17:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44mH-00018x-6d
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:54:25 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44m5-0005gF-R8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:54:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA9603372E;
 Wed,  1 Oct 2025 21:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=To6xMRqb8yYay6YxoHR5rSGf6MY01GT1/0EJLQKKqpE=;
 b=zs54vFAWghVQH+4m7fArnxZwmV1Jy7s7LgzXGJeUtrTM4dY+0y5fAF3cV7YyH/ANpUstEM
 Z0a4tKZUujwF9tSlm83IFafX2DBWWZpwToKoOm3rURTQznApwoUNdtM3WMNfp9U+wp11WY
 iul9Lu4rTGbDiH344xE5zUJzjjGivM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=To6xMRqb8yYay6YxoHR5rSGf6MY01GT1/0EJLQKKqpE=;
 b=805X8KMJlcltDK0Fo72266hRPcISyJdlbl/jXXvlRd5n8kuoqJipkyDwd3pCymZnZwRME6
 jVOlOdbXzaAYm/DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zs54vFAW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=805X8KMJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=To6xMRqb8yYay6YxoHR5rSGf6MY01GT1/0EJLQKKqpE=;
 b=zs54vFAWghVQH+4m7fArnxZwmV1Jy7s7LgzXGJeUtrTM4dY+0y5fAF3cV7YyH/ANpUstEM
 Z0a4tKZUujwF9tSlm83IFafX2DBWWZpwToKoOm3rURTQznApwoUNdtM3WMNfp9U+wp11WY
 iul9Lu4rTGbDiH344xE5zUJzjjGivM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=To6xMRqb8yYay6YxoHR5rSGf6MY01GT1/0EJLQKKqpE=;
 b=805X8KMJlcltDK0Fo72266hRPcISyJdlbl/jXXvlRd5n8kuoqJipkyDwd3pCymZnZwRME6
 jVOlOdbXzaAYm/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DCE513A3F;
 Wed,  1 Oct 2025 21:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WF8ADLyi3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/13] tests/qtest/migration: Fix cpr-tests in case the machine
 is not available
Date: Wed,  1 Oct 2025 18:52:43 -0300
Message-Id: <20251001215254.2863-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BA9603372E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

When QEMU has been compiled with "--without-default-devices", the
migration cpr-tests are currently failing since the first test leaves
a socket file behind that avoids that the second test can be initialized
correctly. Make sure that we delete the socket file in case that the
migrate_start() failed due to the missing machine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250930090932.235151-1-thuth@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c | 5 ++++-
 tests/qtest/migration/framework.c | 6 ++++--
 tests/qtest/migration/framework.h | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5e764a6787..c4ce60ff66 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -97,7 +97,10 @@ static void test_mode_transfer_common(bool incoming_defer)
         .start_hook = test_mode_transfer_start,
     };
 
-    test_precopy_common(&args);
+    if (test_precopy_common(&args) < 0) {
+        close(cpr_sockfd);
+        unlink(cpr_path);
+    }
 }
 
 static void test_mode_transfer(void)
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 407c9023c0..a044b35465 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -736,7 +736,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     migrate_postcopy_complete(from, to, args);
 }
 
-void test_precopy_common(MigrateCommon *args)
+int test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
@@ -746,7 +746,7 @@ void test_precopy_common(MigrateCommon *args)
     g_assert(!args->cpr_channel || args->connect_channels);
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
-        return;
+        return -1;
     }
 
     if (args->start_hook) {
@@ -869,6 +869,8 @@ finish:
     }
 
     migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+
+    return 0;
 }
 
 static void file_dirty_offset_region(void)
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 01e425e64e..744040d53a 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -227,7 +227,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest);
 
 void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args);
-void test_precopy_common(MigrateCommon *args);
+int test_precopy_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
-- 
2.35.3


