Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E3ED5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdy-0004Fk-2s; Mon, 15 Dec 2025 17:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdv-0004Dd-TG
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:11 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdt-0002pU-Tf
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71BC633779;
 Mon, 15 Dec 2025 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GirnPds6eybe2IGq51SAr5b0gzxORMXHl7tMh/4dldo=;
 b=pYzSd1qPQUvabjghBi2L7LdG6gPj16R1WjHT6pg6F5IAfRzDuIdiAU7sh4PsHRosbJr7Ny
 sfqAoxFBmBNtZQ+v7mdIIxRo3IXwppqfLZeMdybOny0gMhZRnr2oX+Y64TPR6AVMaQDZQm
 4WyRPqiovC+/a7not3IOjZijf9BujXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GirnPds6eybe2IGq51SAr5b0gzxORMXHl7tMh/4dldo=;
 b=kq9iBGh0K9bJluBg3CmR35ifNgtRA1BXBro+rMxTccAPK9DbFiWunISCoXJ29ZP4EPd+t5
 zXoYRlksEqgi2dBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GirnPds6eybe2IGq51SAr5b0gzxORMXHl7tMh/4dldo=;
 b=pYzSd1qPQUvabjghBi2L7LdG6gPj16R1WjHT6pg6F5IAfRzDuIdiAU7sh4PsHRosbJr7Ny
 sfqAoxFBmBNtZQ+v7mdIIxRo3IXwppqfLZeMdybOny0gMhZRnr2oX+Y64TPR6AVMaQDZQm
 4WyRPqiovC+/a7not3IOjZijf9BujXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GirnPds6eybe2IGq51SAr5b0gzxORMXHl7tMh/4dldo=;
 b=kq9iBGh0K9bJluBg3CmR35ifNgtRA1BXBro+rMxTccAPK9DbFiWunISCoXJ29ZP4EPd+t5
 zXoYRlksEqgi2dBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69F593EA63;
 Mon, 15 Dec 2025 22:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EJ8nC1CFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 26/51] tests/qtest/migration: Pass MigrateStart into cancel
 tests
Date: Mon, 15 Dec 2025 19:00:12 -0300
Message-ID: <20251215220041.12657-27-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
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

Pass the "args" parameter to the cancel tests so they can access the
config object which will be part of this struct.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/precopy-tests.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 086d06a31c..aca7ed51ef 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -642,7 +642,8 @@ static void test_multifd_postcopy_tcp_cancel(char *name, MigrateCommon *args)
 }
 
 static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
-                                         const char *uri, const char *phase)
+                                         const char *uri, const char *phase,
+                                         MigrateStart *args)
 {
     /*
      * No migrate_incoming_qmp() at the start to force source into
@@ -669,7 +670,8 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
-                                            const char *uri, const char *phase)
+                                            const char *uri, const char *phase,
+                                            MigrateStart *args)
 {
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
@@ -693,7 +695,8 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
-                                           const char *uri, const char *phase)
+                                           const char *uri, const char *phase,
+                                           MigrateStart *args)
 {
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
@@ -714,7 +717,8 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_after_none(QTestState *from, QTestState *to,
-                                       const char *uri, const char *phase)
+                                       const char *uri, const char *phase,
+                                       MigrateStart *args)
 {
     /*
      * Test that cancelling without a migration happening does not
@@ -735,7 +739,8 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
-                                           const char *uri, const char *phase)
+                                           const char *uri, const char *phase,
+                                           MigrateStart *args)
 {
     migrate_set_capability(from, "pause-before-switchover", true);
     migrate_set_capability(to, "pause-before-switchover", true);
@@ -775,20 +780,20 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
 
     if (g_str_equal(phase, "cancelling") ||
         g_str_equal(phase, "cancelled")) {
-        test_cancel_src_after_cancelled(from, to, uri, phase);
+        test_cancel_src_after_cancelled(from, to, uri, phase, &args->start);
 
     } else if (g_str_equal(phase, "completed")) {
-        test_cancel_src_after_complete(from, to, uri, phase);
+        test_cancel_src_after_complete(from, to, uri, phase, &args->start);
 
     } else if (g_str_equal(phase, "failed")) {
-        test_cancel_src_after_failed(from, to, uri, phase);
+        test_cancel_src_after_failed(from, to, uri, phase, &args->start);
 
     } else if (g_str_equal(phase, "none")) {
-        test_cancel_src_after_none(from, to, uri, phase);
+        test_cancel_src_after_none(from, to, uri, phase, &args->start);
 
     } else {
         /* any state that comes before pre-switchover */
-        test_cancel_src_pre_switchover(from, to, uri, phase);
+        test_cancel_src_pre_switchover(from, to, uri, phase, &args->start);
     }
 
     migrate_end(from, to, false);
-- 
2.51.0


