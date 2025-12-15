Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ED6D5B873
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGen-00065T-Mm; Mon, 15 Dec 2025 17:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeU-0005Xf-Np
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeR-0002wM-4j
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:46 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D30E133779;
 Mon, 15 Dec 2025 22:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VelK7fLHQ6eX0P1c1YVlPHhMUBXgA0swSVzuX7SCq/A=;
 b=f2k8jSWTV2wuTic2QVCeJHQOgSN1hfnGhdqiepzoEzqZWrRl17OzOGRTqmBPLbtOTOPfbl
 O4wTG8llsCpyxMY4aM2ApQyXL+fR0ldlEEr7SiS04F1kwJncjt0ypnTxhVraHyDO8ZalOJ
 Nl4+qaUAVB/YzwBGzjIRu234c4ouNew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VelK7fLHQ6eX0P1c1YVlPHhMUBXgA0swSVzuX7SCq/A=;
 b=UEa6YAb1TAPaXsNs1Z6jQ2mPAd2ITBpKx1qyiJtZi+hyfFMWsjGg2/waymzrUdHqle4G9q
 bCSNF+y7MWdtrSCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f2k8jSWT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UEa6YAb1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VelK7fLHQ6eX0P1c1YVlPHhMUBXgA0swSVzuX7SCq/A=;
 b=f2k8jSWTV2wuTic2QVCeJHQOgSN1hfnGhdqiepzoEzqZWrRl17OzOGRTqmBPLbtOTOPfbl
 O4wTG8llsCpyxMY4aM2ApQyXL+fR0ldlEEr7SiS04F1kwJncjt0ypnTxhVraHyDO8ZalOJ
 Nl4+qaUAVB/YzwBGzjIRu234c4ouNew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VelK7fLHQ6eX0P1c1YVlPHhMUBXgA0swSVzuX7SCq/A=;
 b=UEa6YAb1TAPaXsNs1Z6jQ2mPAd2ITBpKx1qyiJtZi+hyfFMWsjGg2/waymzrUdHqle4G9q
 bCSNF+y7MWdtrSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD1E83EA63;
 Mon, 15 Dec 2025 22:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cIoAI2WFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 34/51] tests/qtest/migration: Use migrate_incoming_qmp
 where possible
Date: Mon, 15 Dec 2025 19:00:20 -0300
Message-ID: <20251215220041.12657-35-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D30E133779
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Always use the proper function for starting the incoming migration,
there's no need to call QMP directly from the tests.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c | 19 ++++++++++++-------
 tests/qtest/migration/framework.c | 16 +++++++++-------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 7456337370..280e671e4b 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -15,6 +15,8 @@
 #include "migration/framework.h"
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
+#include "qapi/error.h"
+#include "qobject/qjson.h"
 
 
 static char *tmpfs;
@@ -183,6 +185,7 @@ static void test_cpr_exec(MigrateCommon *args)
     g_autofree char *connect_uri = g_strdup(args->connect_uri);
     g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
                                                 FILE_TEST_FILENAME);
+    g_autofree char *channels = NULL;
 
     if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
         return;
@@ -203,13 +206,15 @@ static void test_cpr_exec(MigrateCommon *args)
 
     to = qtest_init_after_exec(from);
 
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { "
-                             "      'channels': [ { 'channel-type': 'main',"
-                             "      'addr': { 'transport': 'file',"
-                             "                'filename': %s,"
-                             "                'offset': 0  } } ] } }",
-                             filename);
+    channels = g_strdup_printf("[ { 'channel-type': 'main',"
+                               "    'addr': { 'transport': 'file',"
+                               "              'filename': '%s',"
+                               "              'offset': 0  } } ]",
+                               filename);
+
+    migrate_incoming_qmp(to, NULL,
+                         qobject_from_json(channels, &error_abort),
+                         "{}");
     wait_for_migration_complete(to);
 
     wait_for_resume(to, get_dst());
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index ebd41d3c9f..227bc39303 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -579,6 +579,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                                     MigrateCommon *args)
 {
     QTestState *from, *to;
+    QObject *channels;
 
     /* set postcopy capabilities */
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
@@ -594,13 +595,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_ensure_non_converge(from, args->start.config);
     migrate_prepare_for_dirty_mem(from);
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { "
-                             "      'channels': [ { 'channel-type': 'main',"
-                             "      'addr': { 'transport': 'socket',"
-                             "                'type': 'inet',"
-                             "                'host': '127.0.0.1',"
-                             "                'port': '0' } } ] } }");
+
+    channels = qobject_from_json("[ { 'channel-type': 'main',"
+                                 "    'addr': { 'transport': 'socket',"
+                                 "              'type': 'inet',"
+                                 "              'host': '127.0.0.1',"
+                                 "              'port': '0' } } ]",
+                                 &error_abort);
+    migrate_incoming_qmp(to, NULL, channels, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.51.0


