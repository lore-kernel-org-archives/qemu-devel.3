Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722ABC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAY1-00007i-0H; Wed, 29 Jan 2025 11:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW4-0003Yk-GA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:13 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW2-0005No-Fs
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DCBE210F3;
 Wed, 29 Jan 2025 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPj0tXlq9RQfRMMsa7wzUhIOLHQvTsJrKzXSP/1EGEA=;
 b=Mrfsth6ZPSFpsLg/AQYDsHog6vcPG85UkB6fRRWec9iFfUlXPYEoplJujp9/uBGfcGdQmJ
 fAMFK3o2s9yU6jqGq5bWKwPv6avBi5HeSVswkqcE2RPJnwSyUTnmnPk/KyiBsiDY7qOoJ8
 av4TtCREu218VYRnSCfj2fFikGSfVr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPj0tXlq9RQfRMMsa7wzUhIOLHQvTsJrKzXSP/1EGEA=;
 b=kEa/OJq8JtAeICgjVhvrJFak0pKi/X1FTXFv2R3f3ztwYMbvXZsYIsCrlvum6jMRYChOar
 94wQihnshKeZGDDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mrfsth6Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kEa/OJq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPj0tXlq9RQfRMMsa7wzUhIOLHQvTsJrKzXSP/1EGEA=;
 b=Mrfsth6ZPSFpsLg/AQYDsHog6vcPG85UkB6fRRWec9iFfUlXPYEoplJujp9/uBGfcGdQmJ
 fAMFK3o2s9yU6jqGq5bWKwPv6avBi5HeSVswkqcE2RPJnwSyUTnmnPk/KyiBsiDY7qOoJ8
 av4TtCREu218VYRnSCfj2fFikGSfVr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPj0tXlq9RQfRMMsa7wzUhIOLHQvTsJrKzXSP/1EGEA=;
 b=kEa/OJq8JtAeICgjVhvrJFak0pKi/X1FTXFv2R3f3ztwYMbvXZsYIsCrlvum6jMRYChOar
 94wQihnshKeZGDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A59E4137DB;
 Wed, 29 Jan 2025 16:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gM1hGf9QmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 32/42] migration: Adjust postcopy bandwidth during switchover
Date: Wed, 29 Jan 2025 13:00:49 -0300
Message-Id: <20250129160059.6987-33-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DCBE210F3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Precopy uses unlimited bandwidth always during switchover, it makes sense
because this is so critical and no one would like to throttle bandwidth
during the VM blackout.

OTOH, postcopy surprisingly didn't do that.  There's one line that in the
middle of the postcopy switchover it tries to switch to postcopy's
specified max-postcopy-bandwidth, but even so it's somewhere in the middle
which is strange.

This patch brings the two modes to always use unlimited bandwidth for
switchover, meanwhile only apply the postcopy max bandwidth after the
switchover is completed.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-8-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 46e30a4814..03e3631d5b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2629,7 +2629,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     int ret;
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
-    uint64_t bandwidth = migrate_max_postcopy_bandwidth();
     int cur_state = MIGRATION_STATUS_ACTIVE;
 
     /*
@@ -2678,6 +2677,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
+    /* Switchover phase, switch to unlimited */
+    migration_rate_set(RATE_LIMIT_DISABLED);
+
     /*
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
@@ -2694,12 +2696,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         ram_postcopy_send_discard_bitmap(ms);
     }
 
-    /*
-     * send rest of state - note things that are doing postcopy
-     * will notice we're in POSTCOPY_ACTIVE and not actually
-     * wrap their state up here
-     */
-    migration_rate_set(bandwidth);
     if (migrate_postcopy_ram()) {
         /* Ping just for debugging, helps line traces up */
         qemu_savevm_send_ping(ms->to_dst_file, 2);
@@ -2783,6 +2779,12 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
 
+    /*
+     * Now postcopy officially started, switch to postcopy bandwidth that
+     * user specified.
+     */
+    migration_rate_set(migrate_max_postcopy_bandwidth());
+
     return ret;
 
 fail_closefb:
-- 
2.35.3


