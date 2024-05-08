Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB9C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpM-0002fZ-21; Wed, 08 May 2024 19:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpJ-0002e0-9b
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:57 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpH-0002KW-J1
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 47E9137725;
 Wed,  8 May 2024 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcVI/R85fJDKlWIRs9/4yVECYIr6dkMFTWYL02L/qK4=;
 b=HteJT3P4mcdcGS/7wcXab1txLuawAVx0khJcAkPz+D56fUr+q1NtlVRNGm4LiQbdt+k6lE
 M9LBB+XnJkmsmdm3ivDCIvpAZtTkVTnE+75iqtT6KqprqZHIeFMJxT/XsxNSIHCukcZ5+9
 aT2FjyLdQpLJJmuU3Vu1Bt8QlL9viJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcVI/R85fJDKlWIRs9/4yVECYIr6dkMFTWYL02L/qK4=;
 b=iTeV09PNoTKRr/BzTRTIJPWiIHRuu23mMNS+PDqNS9JwdQaIrEJGV4tkeNEXaiv3vrBewj
 73HFG1nHlc2EoCAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcVI/R85fJDKlWIRs9/4yVECYIr6dkMFTWYL02L/qK4=;
 b=HteJT3P4mcdcGS/7wcXab1txLuawAVx0khJcAkPz+D56fUr+q1NtlVRNGm4LiQbdt+k6lE
 M9LBB+XnJkmsmdm3ivDCIvpAZtTkVTnE+75iqtT6KqprqZHIeFMJxT/XsxNSIHCukcZ5+9
 aT2FjyLdQpLJJmuU3Vu1Bt8QlL9viJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcVI/R85fJDKlWIRs9/4yVECYIr6dkMFTWYL02L/qK4=;
 b=iTeV09PNoTKRr/BzTRTIJPWiIHRuu23mMNS+PDqNS9JwdQaIrEJGV4tkeNEXaiv3vrBewj
 73HFG1nHlc2EoCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A75C513A27;
 Wed,  8 May 2024 23:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QD1TG1gMPGZ7FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 23:35:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 05/13] migration: process_incoming_migration_co(): rework
 error reporting
Date: Wed,  8 May 2024 20:35:33 -0300
Message-Id: <20240508233541.2403-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508233541.2403-1-farosas@suse.de>
References: <20240508233541.2403-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Unify error reporting in the function. This simplifies the following
commit, which will not-exit-on-error behavior variant to the function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b307a4bc59..a9599838e6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -735,14 +735,16 @@ static void process_incoming_migration_bh(void *opaque)
 static void coroutine_fn
 process_incoming_migration_co(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     assert(mis->from_src_file);
 
     if (compress_threads_load_setup(mis->from_src_file)) {
-        error_report("Failed to setup decompress threads");
+        error_setg(&local_err, "Failed to setup decompress threads");
         goto fail;
     }
 
@@ -779,19 +781,12 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        MigrationState *s = migrate_get_current();
-
-        if (migrate_has_error(s)) {
-            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-                error_report_err(s->error);
-                s->error = NULL;
-            }
-        }
-        error_report("load of migration failed: %s", strerror(-ret));
+        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
         goto fail;
     }
 
     if (colo_incoming_co() < 0) {
+        error_setg(&local_err, "colo incoming failed");
         goto fail;
     }
 
@@ -800,8 +795,16 @@ process_incoming_migration_co(void *opaque)
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
+    migrate_set_error(s, local_err);
+    error_free(local_err);
+
     migration_incoming_state_destroy();
 
+    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+        error_report_err(s->error);
+        s->error = NULL;
+    }
+
     exit(EXIT_FAILURE);
 }
 
-- 
2.35.3


