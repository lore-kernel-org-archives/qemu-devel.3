Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EBDE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuS-0001Sm-Lb; Fri, 10 Jan 2025 07:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuQ-0001SC-Af
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:38 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuO-0003LH-Jg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:38 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 767C31F396;
 Fri, 10 Jan 2025 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wo+mfvVqAk+KGqOg5jyVwOXQ7RqLQcRwDfvcBL4NoXs=;
 b=ns4DF+gvf7HysgpQ/DffIUaIaAjyTji1vYUeA+bwDuxCMjVNlultqrBC2/7kPpl5Vc36b4
 vXPf94hyQK4luR5rQqspC6GjhPQr3IT+6yLDlcjtXopIva06tRUEoT/TGKeZvpfYHiCP5h
 Q8Kl85+mif7xpu/t8XmXnRI1wgxUEIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wo+mfvVqAk+KGqOg5jyVwOXQ7RqLQcRwDfvcBL4NoXs=;
 b=I+MJF50DCrBN4IT9W9q5tLbvyTijavOzHX2Gk7L9y67ZiTVyGFNpLHwXLXtGi8y3Wzj1W7
 IbJJWOt1D7wSSrCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wo+mfvVqAk+KGqOg5jyVwOXQ7RqLQcRwDfvcBL4NoXs=;
 b=ns4DF+gvf7HysgpQ/DffIUaIaAjyTji1vYUeA+bwDuxCMjVNlultqrBC2/7kPpl5Vc36b4
 vXPf94hyQK4luR5rQqspC6GjhPQr3IT+6yLDlcjtXopIva06tRUEoT/TGKeZvpfYHiCP5h
 Q8Kl85+mif7xpu/t8XmXnRI1wgxUEIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wo+mfvVqAk+KGqOg5jyVwOXQ7RqLQcRwDfvcBL4NoXs=;
 b=I+MJF50DCrBN4IT9W9q5tLbvyTijavOzHX2Gk7L9y67ZiTVyGFNpLHwXLXtGi8y3Wzj1W7
 IbJJWOt1D7wSSrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED3D13A86;
 Fri, 10 Jan 2025 12:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eNbwECoPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 12/25] migration/block: Make late-block-active the default
Date: Fri, 10 Jan 2025 09:14:00 -0300
Message-Id: <20250110121413.12336-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Migration capability 'late-block-active' controls when the block drives
will be activated.  If enabled, block drives will only be activated until
VM starts, either src runstate was "live" (RUNNING, or SUSPENDED), or it'll
be postponed until qmp_cont().

Let's do this unconditionally.  There's no harm to delay activation of
block drives.  Meanwhile there's no ABI breakage if dest does it, because
src QEMU has nothing to do with it, so it's no concern on ABI breakage.

IIUC we could avoid introducing this cap when introducing it before, but
now it's still not too late to just always do it.  Cap now prone to
removal, but it'll be for later patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241206230838.1111496-4-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 969b03cdcd..c80fc7b94c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -743,24 +743,6 @@ static void process_incoming_migration_bh(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-enter");
 
-    /* If capability late_block_activate is set:
-     * Only fire up the block code now if we're going to restart the
-     * VM, else 'cont' will do it.
-     * This causes file locking to happen; so we don't want it to happen
-     * unless we really are starting the VM.
-     */
-    if (!migrate_late_block_activate() ||
-        (autostart && runstate_is_live(migration_get_target_runstate()))) {
-        /* Make sure all file formats throw away their mutable metadata.
-         * If we get an error here, just don't restart the VM yet. */
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-            autostart = false;
-        }
-    }
-
     /*
      * This must happen after all error conditions are dealt with and
      * we're sure the VM is going to be running on this host.
@@ -775,7 +757,25 @@ static void process_incoming_migration_bh(void *opaque)
 
     if (runstate_is_live(migration_get_target_runstate())) {
         if (autostart) {
-            vm_start();
+            /*
+             * Block activation is always delayed until VM starts, either
+             * here (which means we need to start the dest VM right now..),
+             * or until qmp_cont() later.
+             *
+             * We used to have cap 'late-block-activate' but now we do this
+             * unconditionally, as it has no harm but only benefit.  E.g.,
+             * it's not part of migration ABI on the time of disk activation.
+             *
+             * Make sure all file formats throw away their mutable
+             * metadata.  If error, don't restart the VM yet.
+             */
+            bdrv_activate_all(&local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                local_err = NULL;
+            } else {
+                vm_start();
+            }
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-- 
2.35.3


