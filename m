Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900F4F3C24C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaLA-0006h2-R4; Mon, 09 Mar 2026 09:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaL8-0006gV-CT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaL6-00088y-LB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F40264D218;
 Mon,  9 Mar 2026 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUm/CHRY+wJrgtDLfEU0Rtxwn7We/QfDRlzCcLCaEno=;
 b=QwWrr9W2jiohsGug16jbVHG245V0mgOzqIvMdosLNAkdj/OYoS+35OLLdNXV6n/vN6dyEw
 xXxKc19kMfB7wBANHyYhuEv4PPxzVtKg6nmTXV4ytm1Yis6QppPMjWHcWuG8wWtFezEN/T
 /57NqvenTeTkUdDSOP9XHDXfu/BuyWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUm/CHRY+wJrgtDLfEU0Rtxwn7We/QfDRlzCcLCaEno=;
 b=JbS6cUtQ67Q5vIhMs6Eh9LGu3+DxNLtQrMx+yJSJ2QwwvrXpesVanXG3cUXPYs+7t0wspl
 vM+jQ08IYmEXXyBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUm/CHRY+wJrgtDLfEU0Rtxwn7We/QfDRlzCcLCaEno=;
 b=QwWrr9W2jiohsGug16jbVHG245V0mgOzqIvMdosLNAkdj/OYoS+35OLLdNXV6n/vN6dyEw
 xXxKc19kMfB7wBANHyYhuEv4PPxzVtKg6nmTXV4ytm1Yis6QppPMjWHcWuG8wWtFezEN/T
 /57NqvenTeTkUdDSOP9XHDXfu/BuyWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUm/CHRY+wJrgtDLfEU0Rtxwn7We/QfDRlzCcLCaEno=;
 b=JbS6cUtQ67Q5vIhMs6Eh9LGu3+DxNLtQrMx+yJSJ2QwwvrXpesVanXG3cUXPYs+7t0wspl
 vM+jQ08IYmEXXyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C69C03EEF3;
 Mon,  9 Mar 2026 13:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cLKmIh3GrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:07:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 05/22] colo: Replace migration_incoming_colo_enabled() with
 migrate_colo()
Date: Mon,  9 Mar 2026 10:07:10 -0300
Message-ID: <20260309130730.20526-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
References: <20260309130730.20526-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Lukas Straub <lukasstraub2@web.de>

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260302-colo_unit_test_multifd-v11-4-d653fb3b1d80@web.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/colo.h | 1 -
 migration/colo.c         | 2 +-
 migration/migration.c    | 9 ++-------
 migration/ram.c          | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index d4fe422e4d..2496a968cc 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -27,7 +27,6 @@ bool migration_in_colo_state(void);
 /* loadvm */
 int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
-bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
 
 COLOMode get_colo_mode(void);
diff --git a/migration/colo.c b/migration/colo.c
index f7a5bd3619..97a224c39c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -935,7 +935,7 @@ void coroutine_fn colo_incoming_co(void)
     QemuThread th;
 
     assert(bql_locked());
-    assert(migration_incoming_colo_enabled());
+    assert(migrate_colo());
 
     qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
                        colo_process_incoming_thread,
diff --git a/migration/migration.c b/migration/migration.c
index f881430efc..e56756dd04 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -605,11 +605,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
 }
 
 static bool migration_colo_enabled;
-bool migration_incoming_colo_enabled(void)
-{
-    return migration_colo_enabled;
-}
-
 void migration_incoming_disable_colo(void)
 {
     ram_block_discard_disable(false);
@@ -739,7 +734,7 @@ static void process_incoming_migration_bh(void *opaque)
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-    } else if (migration_incoming_colo_enabled()) {
+    } else if (migrate_colo()) {
         migration_incoming_disable_colo();
         vm_start();
     } else {
@@ -807,7 +802,7 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
 
-    if (migration_incoming_colo_enabled()) {
+    if (migrate_colo()) {
         /* yield until COLO exit */
         colo_incoming_co();
     }
diff --git a/migration/ram.c b/migration/ram.c
index fc7ece2c1a..aebf77aa0b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4370,7 +4370,7 @@ static int ram_load_precopy(QEMUFile *f)
              * speed of the migration, but it obviously reduce the downtime of
              * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_colo_enabled()) {
+            if (migrate_colo()) {
                 if (migration_incoming_in_colo_state()) {
                     /* In COLO stage, put all pages into cache temporarily */
                     host = colo_cache_from_block_offset(block, addr, true);
-- 
2.51.0


