Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AFBC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzB-0001Nn-2q; Fri, 28 Aug 2026 11:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyz8-0001N1-B0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:18 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyz2-0008Hq-3p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:16 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F0F11F847;
 Fri, 28 Aug 2026 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cspG0Dh2mxk8vVsB+09O0NDaNl4Dzf0rDzwGrop/RnM=;
 b=wmX5ppQCTRZG0TEbo7H5m7wbwjx25Cjwkrmc/9Kyn3Y3Ss2jr+yLSIT57ZGXCIqYkozj8R
 POgoH/aLHbmeNVL5q518FWjEGuzEPaxL+OEmnGstVYStgZVrMvx5Ib91PBNWt6LkQVJLT7
 Be+Ekz/58/ijgbR/GEv8sNHzbYK1MgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cspG0Dh2mxk8vVsB+09O0NDaNl4Dzf0rDzwGrop/RnM=;
 b=eNCIVivQ0rI6GPqKXukjS5UE6bZbsd9wM4gwhdNvADFtJDEa7Sw1hWkvHUlshjR+kF78Mn
 3GiaraqH737kFHDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cspG0Dh2mxk8vVsB+09O0NDaNl4Dzf0rDzwGrop/RnM=;
 b=m1h6hkarzfK4XFxRb7IGgXA2P1K7ecfBZyF4CsxGQwTIwbkvY/Q9apynMMIFcsS0F8WXH3
 PkkBVYrBps474xbg9cJ7gN6Nw7UvzEMr/poVepTwjZiDo2Uq7FP8BfXGPdD/wrgP1xzZTl
 Tocmx1U3PBbLnnj4wgX3bHLMFrCN8HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cspG0Dh2mxk8vVsB+09O0NDaNl4Dzf0rDzwGrop/RnM=;
 b=cNKoo+pD869k1/6+gluOakAqBikzWLQW1FSNaBvHbtvuu1VDIOMxjOxvls3RenaKaB/qhO
 jkdwGAyiB+/VkfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A6913675;
 Fri, 28 Aug 2026 15:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8CPKOkSwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PULL v2 09/30] migration: update capability conflict test for
 postcopy-ram+mapped-ram
Date: Fri, 28 Aug 2026 12:58:24 -0300
Message-ID: <20260828155845.2874508-10-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Remove the test test_validate_caps_pair, which asserted postcopy-ram
and mapped-ram capabilities cannot be active together. The new fast
snapshot load feature is exactly this pair of capabilities active
together, with the following patches in this series, this combination
will now supported and be functional.

Remove the capability check that rejected mapped-ram and postcopy-ram
being set simultaneously, as this combination now corresponds to fast
snapshot load.

Add a capability check against setting multifd when configured for fast
snapshot load as it is not supported yet. Also add capability check
against setting postcopy-preempt as it is incompatible.

Add infrastructure to check postcopy_notifier_list being empty in
capaility checking to block vhost-user with fast snapshot load as it is
not supported.

Add a check to bail in migrate_prepare to prevent unexpected usage when
fast snapshot load is enabled.

A smoke test exercising this feature has been added further in this
series.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/notify.h              |  2 ++
 migration/migration.c              |  6 ++++
 migration/options.c                | 20 ++++++++++--
 migration/postcopy-ram.c           |  5 +++
 migration/postcopy-ram.h           |  1 +
 tests/qtest/migration/misc-tests.c | 52 ------------------------------
 util/notify.c                      |  5 +++
 7 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/include/qemu/notify.h b/include/qemu/notify.h
index abf18dbf595..666d13f727e 100644
--- a/include/qemu/notify.h
+++ b/include/qemu/notify.h
@@ -75,4 +75,6 @@ void notifier_with_return_remove(NotifierWithReturn *notifier);
 int notifier_with_return_list_notify(NotifierWithReturnList *list,
                                      void *data, Error **errp);
 
+bool notifier_with_return_list_empty(NotifierWithReturnList *list);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 59cdc1a169f..b413d28622a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2048,6 +2048,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             error_setg(errp, "Cannot use compression with mapped-ram");
             return false;
         }
+
+        if (migrate_postcopy_ram()) {
+            error_setg(errp, "Cannot migrate with fast snapshot load "
+                             "enabled(mapped-ram + postcopy-ram)");
+            return false;
+        }
     }
 
     if (migrate_mode_is_cpr()) {
diff --git a/migration/options.c b/migration/options.c
index dfce19405d4..d2575edb6cb 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -736,10 +736,26 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                        "Mapped-ram migration is incompatible with xbzrle");
             return false;
         }
+    }
 
-        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+    if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM] &&
+        new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
             error_setg(errp,
-                       "Mapped-ram migration is incompatible with postcopy");
+                       "Multifd is not supported with fast snapshot load");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT]) {
+            error_setg(
+                errp,
+                "Postcopy Preempt is incompatible with fast snapshot load");
+            return false;
+        }
+
+        if (!postcopy_notifier_list_empty()) {
+            error_setg(errp,
+                       "vhost-user is not supported with fast snapshot load");
             return false;
         }
     }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3b66c1f6d42..885ab58fca5 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -84,6 +84,11 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
                                             &pnd, errp);
 }
 
+bool postcopy_notifier_list_empty(void)
+{
+    return notifier_with_return_list_empty(&postcopy_notifier_list);
+}
+
 /*
  * NOTE: this routine is not thread safe, we can't call it concurrently. But it
  * should be good enough for migration's purposes.
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index c58a60bc8ae..edba7b02404 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -136,6 +136,7 @@ void postcopy_add_notifier(NotifierWithReturn *nn);
 void postcopy_remove_notifier(NotifierWithReturn *n);
 /* Call the notifier list set by postcopy_add_start_notifier */
 int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);
+bool postcopy_notifier_list_empty(void);
 
 void postcopy_thread_create(MigrationIncomingState *mis,
                             QemuThread *thread, const char *name,
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index ec6d438cdcb..4e0deb7f188 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -201,55 +201,6 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     migrate_end(from, to, false);
 }
 
-static void validate_caps_pair(QTestState *from,
-                               const char *first_capability,
-                               const char *second_capability,
-                               const char *expected_error)
-{
-    QDict *rsp;
-    const char *error_desc;
-
-    migrate_set_capability(from, first_capability, true);
-
-    rsp = qtest_qmp_assert_failure_ref(
-        from,
-        "{ 'execute': 'migrate-set-capabilities',"
-        "  'arguments': { 'capabilities': [ { "
-        "      'capability': %s, 'state': true } ] } }",
-        second_capability);
-
-    error_desc = qdict_get_str(rsp, "desc");
-    g_assert_cmpstr(error_desc, ==, expected_error);
-    qobject_unref(rsp);
-
-    migrate_set_capability(from, first_capability, false);
-}
-
-static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
-{
-    g_autofree char *serial_path = g_strconcat(tmpfs, "/src_serial", NULL);
-    g_autofree char *cap_pair = g_path_get_basename(test_path);
-    QTestState *from, *to;
-
-    args->start.hide_stderr = true;
-    args->start.only_source = true;
-
-    if (migrate_start(&from, &to, &args->start)) {
-        return;
-    }
-
-    if (g_str_equal(cap_pair, "mapped_ram_postcopy")) {
-        const char *error =
-            "Mapped-ram migration is incompatible with postcopy";
-
-        validate_caps_pair(from, "mapped-ram", "postcopy-ram", error);
-        validate_caps_pair(from, "postcopy-ram", "mapped-ram", error);
-    }
-
-    qtest_quit(from);
-    unlink(serial_path);
-}
-
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
     args->uri = "tcp:127.0.0.1:0",
@@ -309,7 +260,4 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
-    migration_test_add_suffix("/migration/validate_caps/",
-                              "mapped_ram_postcopy",
-                              test_validate_caps_pair);
 }
diff --git a/util/notify.c b/util/notify.c
index 24420a7288e..512ba6aa916 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -75,3 +75,8 @@ int notifier_with_return_list_notify(NotifierWithReturnList *list, void *data,
     }
     return ret;
 }
+
+bool notifier_with_return_list_empty(NotifierWithReturnList *list)
+{
+    return QLIST_EMPTY(&list->notifiers);
+}
-- 
2.53.0


