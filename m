Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D98BC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 22:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4QYs-0001lC-11; Wed, 09 Sep 2026 18:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4QYp-0001kW-Qj
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 18:14:31 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4QYo-0000yf-0R
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 18:14:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 431EF1FCF3;
 Wed,  9 Sep 2026 22:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788992064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exSYBQtEcpABGaw42zqfCE2VGLqOY0jqbjkNcttm/y4=;
 b=yQ7XPSwcaZbtZHYDCpxquwYu6sCuT4KVrkpKqaKSoEVrBv8O72O2g5OGQkHspoVsDVCJ3I
 cvDkRWOUav0J0QU+77lyuXdbUK5rWNn5K+syvEZpJ7Ki9805LwBAR4YtuGUwqBG07F5osW
 1EaUZXI24at05tcarYVzQ0SOGIdHREw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788992064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exSYBQtEcpABGaw42zqfCE2VGLqOY0jqbjkNcttm/y4=;
 b=/q0++yzUMwcTAfHmfG3qaNDkviujrU/it1zUTVYsCdee8aWGv2KVHsrNKx8kNKkuL+lwQM
 RV95Gve3CVHiGDCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lSvlhYke;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XRBKsQ+4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788992060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exSYBQtEcpABGaw42zqfCE2VGLqOY0jqbjkNcttm/y4=;
 b=lSvlhYkeEVA5+Nvk/DZ4wDYWsDY1dq0tJPtrjJkMVdLwdmKYOfUw8a/UVjvH8fg6JPv8Uj
 JIuZJh/SCUDhEjzNWehuG4KVSyp9jQYML3D642X6CX/GbtfwrmbxSTZg1+u17FI6GKFBxX
 P0votdd1u7JHoLJb1ke5dyq5x8b0Yzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788992060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exSYBQtEcpABGaw42zqfCE2VGLqOY0jqbjkNcttm/y4=;
 b=XRBKsQ+4eYNJah+Ck8nShUrFOMd8+HZ2Y4WndRNeA9gJXtyyjkr7X5tCkGEgsdbfgl9JL8
 2OQbhWUXaw9kMoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49D8F13770;
 Wed,  9 Sep 2026 22:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AJw5BzvaoWqMPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 22:14:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 3/3] migration: Free the JSON writer during snapshots
Date: Wed,  9 Sep 2026 19:14:09 -0300
Message-ID: <20260909221409.291560-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909221409.291560-1-farosas@suse.de>
References: <20260909221409.291560-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 431EF1FCF3
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
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

The JSON writer is created at migrate_init() and freed at
migration_cleanup(). The latter is not called for snapshots. Add a
call to migration_cleanup_json_writer() to make sure it doesn't leak:

Indirect leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x55ca12aabca0 in malloc
    #1 0x7fd97d7e595d in g_malloc
    #2 0x7fd97d7ffe38 in g_slice_alloc
    #3 0x7fd97d8042e2 in g_string_sized_new
    #4 0x55ca1571dd6b in json_writer_new ../qobject/json-writer.c:36:24
    #5 0x55ca12e0de56 in migrate_init ../migration/migration.c:1718:21
    #6 0x55ca12ec8fe6 in qemu_savevm_state ../migration/savevm.c:1921:11
    #7 0x55ca12ec8b93 in save_snapshot ../migration/savevm.c:3380:11

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 +-
 migration/migration.h | 1 +
 migration/savevm.c    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index b413d28622..d0b864a760 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1330,7 +1330,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
     }
 }
 
-static void migration_cleanup_json_writer(MigrationState *s)
+void migration_cleanup_json_writer(MigrationState *s)
 {
     g_clear_pointer(&s->vmdesc, json_writer_free);
 }
diff --git a/migration/migration.h b/migration/migration.h
index e47ff4e3d1..683bc7bdd5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -633,4 +633,5 @@ void migration_bitmap_sync_precopy(bool last_stage);
 void dirty_bitmap_mig_init(void);
 bool should_send_vmdesc(void);
 
+void migration_cleanup_json_writer(MigrationState *s);
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 8d4bdc28ab..4b590ea672 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1952,6 +1952,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
 cleanup:
     qemu_savevm_state_cleanup();
+    migration_cleanup_json_writer(ms);
 
     if (ret != 0) {
         status = MIGRATION_STATUS_FAILED;
-- 
2.53.0


