Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBF6C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2FZ8-000736-2k; Thu, 03 Sep 2026 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2FZ1-00072K-9a
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 18:05:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2FYy-0003Y9-6K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 18:05:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC88E22345;
 Thu,  3 Sep 2026 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788473134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYLBkV1ylKw6NH3s0B5Xr4pifVev5evnseeNUB3+u+Y=;
 b=bpcvxp0gn0ISNOpweP2WexbBoHBb1Bjpp9B+lFatoGUWR45GjLb0NKKGZgHL6+cUS3ZWhU
 SAKgsU88hdtytLWoNy8v6aKd9gl2ghPA3GUqKDMiwM0Yy/+2igxEldMXEATgYAJKeEgNAN
 I4cftM4Ff6girh0qFrglUtEmD8Ew1XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788473134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYLBkV1ylKw6NH3s0B5Xr4pifVev5evnseeNUB3+u+Y=;
 b=r+ma7/jkyOZ0QdAx1kD+wgiCtMhckfkCyFSMBMHOcplkKpVF5NvJ1PNQTkCsVUdIOJ27jH
 Yeph3yOlKsD3ybAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788473130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYLBkV1ylKw6NH3s0B5Xr4pifVev5evnseeNUB3+u+Y=;
 b=bZq+OFSmjw0i5AA1xNGCdAwXM/VV3Drw64aHnetXHhkY6sVCUHWabGqmOjM4kT69uvWRI6
 yLl9k6ULW1TszOrKQ/6ffMOf24UyNauoAimzsrwC+Zn0+NjUpNh1fgBRgqW/azfoIUBvwY
 /JTigoQbg14nhSG2X++r2EUr3xedFZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788473130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYLBkV1ylKw6NH3s0B5Xr4pifVev5evnseeNUB3+u+Y=;
 b=rzH09Eefjk5AzRwemmprz0o4SYLM24IO8DRODYD78sacUeVRLHhD0iyMvpw7FIasoylYDj
 6nbFNcVLCUjx3dBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE51A13869;
 Thu,  3 Sep 2026 22:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +A9TJynvmWppUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 22:05:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 3/3] migration: Free the JSON writer during snapshots
Date: Thu,  3 Sep 2026 19:05:23 -0300
Message-ID: <20260903220523.2849019-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903220523.2849019-1-farosas@suse.de>
References: <20260903220523.2849019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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
 migration/savevm.c    | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

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
index 8d4bdc28ab..a31f34f25c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3404,7 +3404,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
 
  the_end:
     bdrv_drain_all_end();
-
+    migration_cleanup_json_writer(migrate_get_current());
     vm_resume(saved_state);
     return ret == 0;
 }
-- 
2.53.0


