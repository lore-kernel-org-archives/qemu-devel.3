Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616BFE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuT-0001Su-2v; Fri, 10 Jan 2025 07:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuR-0001SX-Ja
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:39 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuQ-0003LY-0h
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:39 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD1871F455;
 Fri, 10 Jan 2025 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZ3qvsHzfzNqDsiwG9uEjcWL04HA8tR/C0s6fvzBh9c=;
 b=anOqbNyEY1txRvx87tZS+yuJ1217SwqNFCdyAtYvxaI6v8qj5iCBFOEJNVJaWag9P43Ani
 dszin7dYb7+r7mpv28bw4OMApY2ZDsm89fSeql/tPGBVaLsYtjqOd7JMXlXjgnPyDBMRx7
 kv3TGglljiTX2T4qYR4nNNto8jckMcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511276;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZ3qvsHzfzNqDsiwG9uEjcWL04HA8tR/C0s6fvzBh9c=;
 b=vif/z5Eu+fiJPSCzVI02OxVrCTxer7zpL5TPu/4doHBTySz5jOuX97xCrNiffFpNcI/6bi
 3oqbhpzWAIYM4lDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZ3qvsHzfzNqDsiwG9uEjcWL04HA8tR/C0s6fvzBh9c=;
 b=anOqbNyEY1txRvx87tZS+yuJ1217SwqNFCdyAtYvxaI6v8qj5iCBFOEJNVJaWag9P43Ani
 dszin7dYb7+r7mpv28bw4OMApY2ZDsm89fSeql/tPGBVaLsYtjqOd7JMXlXjgnPyDBMRx7
 kv3TGglljiTX2T4qYR4nNNto8jckMcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511276;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZ3qvsHzfzNqDsiwG9uEjcWL04HA8tR/C0s6fvzBh9c=;
 b=vif/z5Eu+fiJPSCzVI02OxVrCTxer7zpL5TPu/4doHBTySz5jOuX97xCrNiffFpNcI/6bi
 3oqbhpzWAIYM4lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E693013A86;
 Fri, 10 Jan 2025 12:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +C08KisPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 13/25] migration/block: Apply late-block-active behavior to
 postcopy
Date: Fri, 10 Jan 2025 09:14:01 -0300
Message-Id: <20250110121413.12336-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
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

Postcopy never cared about late-block-active.  However there's no mention
in the capability that it doesn't apply to postcopy.

Considering that we _assumed_ late activation is always good, do that too
for postcopy unconditionally, just like precopy.  After this patch, we
should have unified the behavior across all.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241206230838.1111496-5-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 927b1146c0..d4842b519d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2137,22 +2137,21 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-announced");
 
-    /* Make sure all file formats throw away their mutable metadata.
-     * If we get an error here, just don't restart the VM yet. */
-    bdrv_activate_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        local_err = NULL;
-        autostart = false;
-    }
-
-    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
-
     dirty_bitmap_mig_before_vm_start();
 
     if (autostart) {
-        /* Hold onto your hats, starting the CPU */
-        vm_start();
+        /*
+         * Make sure all file formats throw away their mutable metadata.
+         * If we get an error here, just don't restart the VM yet.
+         */
+        bdrv_activate_all(&local_err);
+        trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        } else {
+            vm_start();
+        }
     } else {
         /* leave it paused and let management decide when to start the CPU */
         runstate_set(RUN_STATE_PAUSED);
-- 
2.35.3


