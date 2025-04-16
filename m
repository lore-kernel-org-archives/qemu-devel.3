Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8547BC369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 13:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u533v-0005Dd-Kp; Wed, 16 Apr 2025 09:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u533i-0005CL-1P
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:44:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u533f-00068q-TP
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:44:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7059C2118E;
 Wed, 16 Apr 2025 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744811046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxlfOf6Lg8XKT/rYFTB01aW6q7bFd3J6Ggpw2jHwpmg=;
 b=mIlPSKeIP5g9T4i5MaFBHMgvn1slEnLc04/ZovOdTOhAxSYAoZwRKe+Y2WiMnuea9Yh+hu
 I3HI/oF+YGqz6e6zqhqgGkLZMaKMs5ibkzRX3itYRMCp05aGMSh6Ktz0N2nvA3j7js60lp
 GsNJgRGsmyJHAdFe0/PhIpUAk8eenPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744811046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxlfOf6Lg8XKT/rYFTB01aW6q7bFd3J6Ggpw2jHwpmg=;
 b=nkd+y5/8s8zHr6XLOh4Qq4XKbke6MhNEKilhdELaowXExjRidR/fSAXo3M80jvD9KcVgVr
 S7dCnYGpQXxNb6CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744811046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxlfOf6Lg8XKT/rYFTB01aW6q7bFd3J6Ggpw2jHwpmg=;
 b=mIlPSKeIP5g9T4i5MaFBHMgvn1slEnLc04/ZovOdTOhAxSYAoZwRKe+Y2WiMnuea9Yh+hu
 I3HI/oF+YGqz6e6zqhqgGkLZMaKMs5ibkzRX3itYRMCp05aGMSh6Ktz0N2nvA3j7js60lp
 GsNJgRGsmyJHAdFe0/PhIpUAk8eenPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744811046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxlfOf6Lg8XKT/rYFTB01aW6q7bFd3J6Ggpw2jHwpmg=;
 b=nkd+y5/8s8zHr6XLOh4Qq4XKbke6MhNEKilhdELaowXExjRidR/fSAXo3M80jvD9KcVgVr
 S7dCnYGpQXxNb6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D04C13976;
 Wed, 16 Apr 2025 13:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHgDByW0/2czQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Apr 2025 13:44:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/2] migration: Trivial cleanups for postcopy
Date: Wed, 16 Apr 2025 10:43:56 -0300
Message-Id: <20250416134356.29879-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250416134356.29879-1-farosas@suse.de>
References: <20250416134356.29879-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Some general cleanups of silly things that were left behind when
refactoring code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d46e776e24..89b1de0ab5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2732,19 +2732,15 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
 
     /*
-     * in Finish migrate and with the io-lock held everything should
+     * in FINISH_MIGRATE and with the BQL held everything should
      * be quiet, but we've potentially still got dirty pages and we
      * need to tell the destination to throw any pages it's already received
      * that are dirty
      */
-    if (migrate_postcopy_ram()) {
-        ram_postcopy_send_discard_bitmap(ms);
-    }
+    ram_postcopy_send_discard_bitmap(ms);
 
-    if (migrate_postcopy_ram()) {
-        /* Ping just for debugging, helps line traces up */
-        qemu_savevm_send_ping(ms->to_dst_file, 2);
-    }
+    /* Ping just for debugging, helps line traces up */
+    qemu_savevm_send_ping(ms->to_dst_file, 2);
 
     /*
      * While loading the device state we may trigger page transfer
@@ -2774,9 +2770,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail_closefb;
     }
 
-    if (migrate_postcopy_ram()) {
-        qemu_savevm_send_ping(fb, 3);
-    }
+    qemu_savevm_send_ping(fb, 3);
 
     qemu_savevm_send_postcopy_run(fb);
 
@@ -2807,13 +2801,11 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     migration_downtime_end(ms);
 
-    if (migrate_postcopy_ram()) {
-        /*
-         * Although this ping is just for debug, it could potentially be
-         * used for getting a better measurement of downtime at the source.
-         */
-        qemu_savevm_send_ping(ms->to_dst_file, 4);
-    }
+    /*
+     * Although this ping is just for debug, it could potentially be
+     * used for getting a better measurement of downtime at the source.
+     */
+    qemu_savevm_send_ping(ms->to_dst_file, 4);
 
     if (migrate_release_ram()) {
         ram_postcopy_migrated_memory_release(ms);
-- 
2.35.3


