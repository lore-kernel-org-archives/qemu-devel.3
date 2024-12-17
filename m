Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74912E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbhI-0005zP-7J; Tue, 17 Dec 2024 12:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbhE-0005td-6R
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:24 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbhC-0007ia-JR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70F841F394;
 Tue, 17 Dec 2024 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C26dDCgyfL8z+AvKKT1qlQ/KbxBpmIyuukZoQK1PwEo=;
 b=hecTFFnaTmDX7ta61cUg3ktAI54h128Ll1964DbmOOX7BAPosNhqKWCmn6MarLMSviybXp
 nHYDYOKig3wbswL2eTtbpZvp6+VtFJ7uUGGi6kaXw3Iez2m7XsIrXJlSGfjW8r3pQM3VOo
 TLTf+g4P+gYtF82nVtc2ACxxnTbIUhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C26dDCgyfL8z+AvKKT1qlQ/KbxBpmIyuukZoQK1PwEo=;
 b=ObmbxKbzdoCkoRKo3dr1dq+6Y08osbShPm7GVqKkIwxSkRhc22YehpPgVFiBpnoqdIPJTU
 xzN4ZgCSwYeCKhCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C26dDCgyfL8z+AvKKT1qlQ/KbxBpmIyuukZoQK1PwEo=;
 b=hecTFFnaTmDX7ta61cUg3ktAI54h128Ll1964DbmOOX7BAPosNhqKWCmn6MarLMSviybXp
 nHYDYOKig3wbswL2eTtbpZvp6+VtFJ7uUGGi6kaXw3Iez2m7XsIrXJlSGfjW8r3pQM3VOo
 TLTf+g4P+gYtF82nVtc2ACxxnTbIUhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C26dDCgyfL8z+AvKKT1qlQ/KbxBpmIyuukZoQK1PwEo=;
 b=ObmbxKbzdoCkoRKo3dr1dq+6Y08osbShPm7GVqKkIwxSkRhc22YehpPgVFiBpnoqdIPJTU
 xzN4ZgCSwYeCKhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C7B913A3C;
 Tue, 17 Dec 2024 17:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uOyzEKC5YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 15/17] migration/block: Fix possible race with block_inactive
Date: Tue, 17 Dec 2024 14:48:53 -0300
Message-Id: <20241217174855.24971-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
index e6db9cfc50..ba5deec5bc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2749,14 +2749,11 @@ static int migration_completion_precopy(MigrationState *s,
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
index 80726726fe..706b77ffab 100644
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


