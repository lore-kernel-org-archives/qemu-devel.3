Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21211C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4niN-0005Ur-SO; Thu, 10 Sep 2026 18:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lML-00038j-2e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:29 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lMA-00018S-FH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:56 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7CB871FEEB;
 Thu, 10 Sep 2026 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5CQK+0NTx+BlLMQmomgu0zA1iD/w1c1y2gfdfJAoxc=;
 b=wrHjFBM++IR10vCBt8Zu80zqteLh9xsZquxESOaq/1erPYo5Ss5MJUy2RbBArc/osL44+k
 eBqKAJcaDyGzenD98e95mCPG0sfJjhYakR821QLuj8kK+H+CdxsMQnrMQ6FzZHN1aTBVGi
 JKx6BFF+Twe0tLo8NKMPI18A3K57q8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5CQK+0NTx+BlLMQmomgu0zA1iD/w1c1y2gfdfJAoxc=;
 b=RjkBsUSv3Hv63BX1jUOR9261qPGdaZJey02O8o94ya93yLArhbA/pg+VMhrUNtLIU+zCIG
 gJIk+rCHLWIIgOAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kfdGPmLf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9Evuf27y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5CQK+0NTx+BlLMQmomgu0zA1iD/w1c1y2gfdfJAoxc=;
 b=kfdGPmLfn6FJxJaglgpSTILMPlpKIiEXzip1CuZOkSHnGU+Kry/eoBOdLY5nA1LYHwFQeF
 p9ifIGWjseGArRZZn9s8rd2Mtis+VJsMH0FWdJfsjWWDmV0bSz0yV8M/JrKMgUsskxl5kI
 dwf0VZIHlje/l96PcD/4LwAhpmj9XKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5CQK+0NTx+BlLMQmomgu0zA1iD/w1c1y2gfdfJAoxc=;
 b=9Evuf27y41B3iiWDadXY+3RA3lQEl1xgxRn2AU+yXsqc9brxfrf7AOT8QH92ZJ8L7WnwiZ
 du0m6RRuYiAT1vDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A5BE13A5E;
 Thu, 10 Sep 2026 20:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4HsdO2QSo2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:26:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 6/7] migration: Free the JSON writer during snapshots
Date: Thu, 10 Sep 2026 17:25:58 -0300
Message-ID: <20260910202559.916866-7-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
References: <20260910202559.916866-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7CB871FEEB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
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

Reviewed-by: Peter Xu <peterx@redhat.com>
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


