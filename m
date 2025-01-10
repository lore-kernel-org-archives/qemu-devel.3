Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9304CE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuV-0001Ta-GB; Fri, 10 Jan 2025 07:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuT-0001T3-6B
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:41 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuR-0003Lp-HI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 518D41F396;
 Fri, 10 Jan 2025 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAa6lXKXtXfy1Ww9T/GBl77EcaIksgunF62wcjvDAhc=;
 b=0CURpNX12VRQEB1DHDFhgWvc9rvy3lMNn+hTKcXb7guPHJ+htK/283R2sMGpWbpbfmwOcA
 qlXSxQlEhXyywstGd1mGIUBZa6ggJp41al6mcJxvh/tvamfacuqengBOhL/DlQWwrK3unf
 pLNLItsrvLG0MisLV+l1GuxmQb+amXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAa6lXKXtXfy1Ww9T/GBl77EcaIksgunF62wcjvDAhc=;
 b=GKhKb72YoR3I6WVPChqF86llm8jcE/UF3AS4sx4z0oPZ4lAhLoFZAy7R/7g5/iaTzCuaX9
 ZmgrKHoBFyDCalDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0CURpNX1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GKhKb72Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAa6lXKXtXfy1Ww9T/GBl77EcaIksgunF62wcjvDAhc=;
 b=0CURpNX12VRQEB1DHDFhgWvc9rvy3lMNn+hTKcXb7guPHJ+htK/283R2sMGpWbpbfmwOcA
 qlXSxQlEhXyywstGd1mGIUBZa6ggJp41al6mcJxvh/tvamfacuqengBOhL/DlQWwrK3unf
 pLNLItsrvLG0MisLV+l1GuxmQb+amXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAa6lXKXtXfy1Ww9T/GBl77EcaIksgunF62wcjvDAhc=;
 b=GKhKb72YoR3I6WVPChqF86llm8jcE/UF3AS4sx4z0oPZ4lAhLoFZAy7R/7g5/iaTzCuaX9
 ZmgrKHoBFyDCalDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5916213A86;
 Fri, 10 Jan 2025 12:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UDVBBy0PgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 14/25] migration/block: Fix possible race with block_inactive
Date: Fri, 10 Jan 2025 09:14:02 -0300
Message-Id: <20250110121413.12336-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 518D41F396
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Peter Xu <peterx@redhat.com>

Src QEMU sets block_inactive=true very early before the invalidation takes
place.  It means if something wrong happened during setting the flag but
before reaching qemu_savevm_state_complete_precopy_non_iterable() where it
did the invalidation work, it'll make block_inactive flag inconsistent.

For example, think about when qemu_savevm_state_complete_precopy_iterable()
can fail: it will have block_inactive set to true even if all block drives
are active.

Fix that by only update the flag after the invalidation is done.

No Fixes for any commit, because it's not an issue if bdrv_activate_all()
is re-entrant upon all-active disks - false positive block_inactive can
bring nothing more than "trying to active the blocks but they're already
active".  However let's still do it right to avoid the inconsistent flag
v.s. reality.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241206230838.1111496-6-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 9 +++------
 migration/savevm.c    | 2 ++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c80fc7b94c..fd42a549e6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2742,14 +2742,11 @@ static int migration_completion_precopy(MigrationState *s,
         goto out_unlock;
     }
 
-    /*
-     * Inactivate disks except in COLO, and track that we have done so in order
-     * to remember to reactivate them if migration fails or is cancelled.
-     */
-    s->block_inactive = !migrate_colo();
     migration_rate_set(RATE_LIMIT_DISABLED);
+
+    /* Inactivate disks except in COLO */
     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                             s->block_inactive);
+                                             !migrate_colo());
 out_unlock:
     bql_unlock();
     return ret;
diff --git a/migration/savevm.c b/migration/savevm.c
index d4842b519d..3a414aff52 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1558,6 +1558,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
             qemu_file_set_error(f, ret);
             return ret;
         }
+        /* Remember that we did this */
+        s->block_inactive = true;
     }
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
-- 
2.35.3


