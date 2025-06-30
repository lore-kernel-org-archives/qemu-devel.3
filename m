Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AEAC83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKgV-0005UV-42; Mon, 30 Jun 2025 16:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKgB-0004zW-Gs
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKg9-0007mM-Ka
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07D691F445;
 Mon, 30 Jun 2025 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsAtYJ4xAGrX6j3QtAxnvyE9GbMjpAanjWUq0BYEkAU=;
 b=FgKEpyZoH6Qe/HdwYC8pZwAD7LpJioNSOUpSwIBBXzsc11nkfmNNGcgzbzH/bgz3cPuEj3
 uQ8V6KDlfC/9OBzXXoBwYNGATcSriimft72uHmgND4zLAFGYVdixbuo1sf/vXdGCX+8BUp
 6kjw2P9ibgD5SCT10bdGC0l7WqNcHUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsAtYJ4xAGrX6j3QtAxnvyE9GbMjpAanjWUq0BYEkAU=;
 b=5bUWL/03klR3+PcqiFmAiSixYGI/c0YQZYgOwlFF6aSRZIhCdwSf3ouJQVccqOLpllDXfL
 UJx0aQYVm/0cnbDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FgKEpyZo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5bUWL/03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsAtYJ4xAGrX6j3QtAxnvyE9GbMjpAanjWUq0BYEkAU=;
 b=FgKEpyZoH6Qe/HdwYC8pZwAD7LpJioNSOUpSwIBBXzsc11nkfmNNGcgzbzH/bgz3cPuEj3
 uQ8V6KDlfC/9OBzXXoBwYNGATcSriimft72uHmgND4zLAFGYVdixbuo1sf/vXdGCX+8BUp
 6kjw2P9ibgD5SCT10bdGC0l7WqNcHUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsAtYJ4xAGrX6j3QtAxnvyE9GbMjpAanjWUq0BYEkAU=;
 b=5bUWL/03klR3+PcqiFmAiSixYGI/c0YQZYgOwlFF6aSRZIhCdwSf3ouJQVccqOLpllDXfL
 UJx0aQYVm/0cnbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B6C1399F;
 Mon, 30 Jun 2025 20:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sLArLcTsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 20:00:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 22/24] tests/qtest/migration: Adapt the capabilities helper
 to take a config
Date: Mon, 30 Jun 2025 16:59:11 -0300
Message-Id: <20250630195913.28033-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 07D691F445
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

Allow migrate_start_set_capabilities() to set the config object
instead of setting the capabilities via calls to
migrate-set-capabilities.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 31 +++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 407c9023c0..9ff5576328 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -211,6 +211,37 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
 static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
                                            MigrateStart *args)
 {
+    if (args->config) {
+        const char *cap_multifd;
+        bool multifd;
+
+        for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+            const char *cap = MigrationCapability_lookup.array[i];
+
+            if (!args->caps[i]) {
+                continue;
+            }
+
+            qdict_put_bool(args->config, cap, true);
+        }
+
+        if (!args->defer_target_connect) {
+            qdict_put_bool(args->config, "events", true);
+        }
+
+        cap_multifd = MigrationCapability_str(MIGRATION_CAPABILITY_MULTIFD);
+        multifd = qdict_get_try_bool(args->config, cap_multifd, false);
+
+        if (multifd) {
+            qdict_put_int(args->config, "multifd-channels",
+                          MULTIFD_TEST_CHANNELS);
+            qdict_put_int(args->config, "multifd-channels",
+                          MULTIFD_TEST_CHANNELS);
+        }
+
+        return;
+    }
+
     /*
      * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
      * are from qapi-types-migration.h.
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 01e425e64e..9b281d6757 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -128,6 +128,7 @@ typedef struct {
      * migration_set_capabilities().
      */
     bool caps[MIGRATION_CAPABILITY__MAX];
+    QDict *config;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
-- 
2.35.3


