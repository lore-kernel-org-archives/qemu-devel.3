Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BC8D5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGet-0006x1-2Y; Mon, 15 Dec 2025 17:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGej-0005xv-Ew
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:03 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGef-0002zP-Bh
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BEF95BDCA;
 Mon, 15 Dec 2025 22:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DumyBHiCFUhY6V6t2Mp/7FrVHpWBsR7MipuXJaxNuzk=;
 b=1xIJyakG2sS1PEDB82t0LdUsbYBZguNlazNWpFlDezxm1VzBBKd8dPAGQ+EzxtaJ9ZRrA1
 65nlrytj1sWxY288Sm0oUtEa6IOaChLW2F48agNhayVglQd1QX5ywjeFsg7LYGC2GRpgNI
 7ZIZ1Akk5kbazHJ+yRCrRFc935JxtsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DumyBHiCFUhY6V6t2Mp/7FrVHpWBsR7MipuXJaxNuzk=;
 b=3nkLzNmrtVshrtQL4wJTRlUhz+NFZw7FVHdoGfVcEZDbUN1FDRgRRO+ekzHP9ZgkgMjwlO
 kVjMQ6rUNH3x0UAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1xIJyakG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3nkLzNmr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DumyBHiCFUhY6V6t2Mp/7FrVHpWBsR7MipuXJaxNuzk=;
 b=1xIJyakG2sS1PEDB82t0LdUsbYBZguNlazNWpFlDezxm1VzBBKd8dPAGQ+EzxtaJ9ZRrA1
 65nlrytj1sWxY288Sm0oUtEa6IOaChLW2F48agNhayVglQd1QX5ywjeFsg7LYGC2GRpgNI
 7ZIZ1Akk5kbazHJ+yRCrRFc935JxtsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DumyBHiCFUhY6V6t2Mp/7FrVHpWBsR7MipuXJaxNuzk=;
 b=3nkLzNmrtVshrtQL4wJTRlUhz+NFZw7FVHdoGfVcEZDbUN1FDRgRRO+ekzHP9ZgkgMjwlO
 kVjMQ6rUNH3x0UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 957163EA63;
 Mon, 15 Dec 2025 22:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cBwTFW2FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 37/51] tests/qtest/migration: Add new hook with data
Date: Mon, 15 Dec 2025 19:00:23 -0300
Message-ID: <20251215220041.12657-38-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9BEF95BDCA
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

Add a new start hook that takes an opaque pointer so the tests can
stop having to nest hook calls.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c |  8 ++++++++
 tests/qtest/migration/framework.h | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index f740228cf2..b9bbdca6a9 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -591,6 +591,9 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     if (args->start_hook) {
         args->postcopy_data = args->start_hook(from, to);
+    } else if (args->start_hook_full) {
+        args->postcopy_data = args->start_hook_full(from, to,
+                                                    args->start_hook_data);
     }
 
     migrate_ensure_non_converge(from, args->start.config);
@@ -868,6 +871,9 @@ int test_precopy_common(MigrateCommon *args)
 
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
+    } else if (args->start_hook_full) {
+        data_hook = args->start_hook_full(from, to,
+                                          args->start_hook_data);
     }
 
     if (args->start.incoming_defer && !args->start.defer_target_connect) {
@@ -1062,6 +1068,8 @@ void test_file_common(MigrateCommon *args, bool stop_src)
 
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
+    } else if (args->start_hook_full) {
+        data_hook = args->start_hook_full(from, to, args->start_hook_data);
     }
 
     migrate_ensure_converge(from, args->start.config);
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 65c656e0d3..2584599f14 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -65,6 +65,19 @@ int migration_env_clean(MigrationTestEnv *env);
 typedef void * (*TestMigrateStartHook)(QTestState *from,
                                        QTestState *to);
 
+
+/*
+ * A hook that runs after the src and dst QEMUs have been created, but
+ * before the migration is started. This can be used to run routines
+ * that require the QTestState object.
+ *
+ * Returns: NULL, or a pointer to opaque state to be
+ *          later passed to the TestMigrateEndHook
+ */
+typedef void * (*TestMigrateStartHookFull)(QTestState *from,
+                                           QTestState *to,
+                                           void *opaque);
+
 /*
  * A hook that runs after the migration has finished,
  * regardless of whether it succeeded or failed, but
@@ -196,6 +209,9 @@ typedef struct {
     /* Optional: callback to run at finish to cleanup */
     TestMigrateEndHook end_hook;
 
+    TestMigrateStartHookFull start_hook_full;
+    void *start_hook_data;
+
     /*
      * Optional: normally we expect the migration process to complete.
      *
-- 
2.51.0


