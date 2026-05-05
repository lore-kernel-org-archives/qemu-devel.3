Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B50CD3441
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIM2-0008Ip-38; Tue, 05 May 2026 12:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILC-0007w4-Mt
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:47 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIL9-0007RJ-8e
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 884ED6B75F;
 Tue,  5 May 2026 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+tsdWsqYD+15JXRDE2F+ieq7bq30O01GxrwVF0GSkI=;
 b=GGDlS1y5r0aYMCh9p2Pg77suxS5OVBfH1HS4c/g4Vwejg3UTdwCj+H4KaylEGwaZG+hmLx
 vs4u9O8oe2o9R/AiVLk+gOUSileViakUNK0/MBEd0tHMgVpw0kP+on6qVkTqNujmc6UK3q
 159opHCLFFm1stimpvIFDju/+3/3E7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+tsdWsqYD+15JXRDE2F+ieq7bq30O01GxrwVF0GSkI=;
 b=dBhH98HRaOpUQ3NGzO8Du3Z7UsuvKG6lLi24muv7N6Li6gHUIlsuUSiYk4gtySYAfOncm1
 2EjPRE0jSKHTvwAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+tsdWsqYD+15JXRDE2F+ieq7bq30O01GxrwVF0GSkI=;
 b=GGDlS1y5r0aYMCh9p2Pg77suxS5OVBfH1HS4c/g4Vwejg3UTdwCj+H4KaylEGwaZG+hmLx
 vs4u9O8oe2o9R/AiVLk+gOUSileViakUNK0/MBEd0tHMgVpw0kP+on6qVkTqNujmc6UK3q
 159opHCLFFm1stimpvIFDju/+3/3E7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+tsdWsqYD+15JXRDE2F+ieq7bq30O01GxrwVF0GSkI=;
 b=dBhH98HRaOpUQ3NGzO8Du3Z7UsuvKG6lLi24muv7N6Li6gHUIlsuUSiYk4gtySYAfOncm1
 2EjPRE0jSKHTvwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09489593A3;
 Tue,  5 May 2026 16:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4LKyMjIW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 01/15] tests/qtest/migration: Move cpr transfer logic into
 cpr-tests.c
Date: Tue,  5 May 2026 13:09:00 -0300
Message-ID: <20260505160915.25558-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There's some amount of cpr-transfer logic at precopy_common, which in
retrospect was a bad idea. For just two tests, that's too much code to
be in the common function. Move it to the cpr file. We'll need this
cleanup for subsequent improvements.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c | 57 ++++++++++++++++++++++++++++---
 tests/qtest/migration/framework.c | 36 +++----------------
 tests/qtest/migration/framework.h |  3 --
 3 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 63ca5f3996..48c98f0089 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -15,6 +15,9 @@
 #include "migration/framework.h"
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
+#include "qapi/error.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
 
 
 static char *tmpfs;
@@ -42,10 +45,56 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
     test_file_common(args, true);
 }
 
-static void *test_mode_transfer_start(QTestState *from, QTestState *to)
+static int test_transfer(MigrateCommon *args, const char *cpr_channel,
+                         bool incoming_defer)
 {
+    QTestState *from, *to;
+    QObject *obj, *out_channels = qobject_from_json(args->connect_channels,
+                                                    &error_abort);
+    QList *channels_list;
+
+    /*
+     * The cpr channel must be included in outgoing channels, but not in
+     * migrate-incoming channels.
+     */
+    channels_list = qobject_to(QList, out_channels);
+    obj = migrate_str_to_channel(cpr_channel);
+    qlist_append(channels_list, obj);
+
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return -1;
+    }
+
     migrate_set_parameter_str(from, "mode", "cpr-transfer");
-    return NULL;
+
+    wait_for_serial("src_serial");
+
+    qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+    wait_for_stop(from, get_src());
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, NULL, out_channels, "{}");
+
+    qtest_connect(to);
+    qtest_qmp_handshake(to, NULL);
+    if (incoming_defer) {
+        QObject *in_channels = qobject_from_json(args->connect_channels,
+                                                 &error_abort);
+
+        migrate_incoming_qmp(to, NULL, in_channels, "{}");
+    }
+
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+
+    qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+
+    wait_for_resume(to, get_dst());
+    wait_for_serial("dest_serial");
+
+    migrate_end(from, to, true);
+
+    return 0;
 }
 
 /*
@@ -86,15 +135,13 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
     args->listen_uri = incoming_defer ? "defer" : uri;
     args->connect_channels = connect_channels;
-    args->cpr_channel = cpr_channel;
-    args->start_hook = test_mode_transfer_start;
 
     args->start.opts_source = opts;
     args->start.opts_target = opts_target;
     args->start.defer_target_connect = true;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
-    if (test_precopy_common(args) < 0) {
+    if (test_transfer(args, cpr_channel, incoming_defer) < 0) {
         close(cpr_sockfd);
         unlink(cpr_path);
     }
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 9f71d51f1e..4ef5e1de83 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -20,7 +20,6 @@
 #include "ppc-util.h"
 #include "qapi/error.h"
 #include "qobject/qjson.h"
-#include "qobject/qlist.h"
 #include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -833,10 +832,7 @@ int test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    QObject *in_channels = NULL;
-    QObject *out_channels = NULL;
-
-    g_assert(!args->cpr_channel || args->connect_channels);
+    QObject *channels = NULL;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return -1;
@@ -869,40 +865,16 @@ int test_precopy_common(MigrateCommon *args)
         }
     }
 
-    /*
-     * The cpr channel must be included in outgoing channels, but not in
-     * migrate-incoming channels.
-     */
     if (args->connect_channels) {
-        if (args->start.defer_target_connect &&
-            !strcmp(args->listen_uri, "defer")) {
-            in_channels = qobject_from_json(args->connect_channels,
-                                            &error_abort);
-        }
-        out_channels = qobject_from_json(args->connect_channels, &error_abort);
-
-        if (args->cpr_channel) {
-            QList *channels_list = qobject_to(QList, out_channels);
-            QObject *obj = migrate_str_to_channel(args->cpr_channel);
-
-            qlist_append(channels_list, obj);
-        }
+        channels = qobject_from_json(args->connect_channels, &error_abort);
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, out_channels, "{}");
+        migrate_qmp_fail(from, args->connect_uri, channels, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, out_channels, "{}");
-
-    if (args->start.defer_target_connect) {
-        qtest_connect(to);
-        qtest_qmp_handshake(to, NULL);
-        if (!strcmp(args->listen_uri, "defer")) {
-            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
-        }
-    }
+    migrate_qmp(from, to, args->connect_uri, channels, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 79604c60f5..13ce84b49e 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -180,9 +180,6 @@ typedef struct {
      */
     const char *connect_channels;
 
-    /* Optional: the cpr migration channel, in JSON or dotted keys format */
-    const char *cpr_channel;
-
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
-- 
2.51.0


