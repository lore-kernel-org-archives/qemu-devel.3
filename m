Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C02E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbhK-00062U-D9; Tue, 17 Dec 2024 12:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbhE-0005u4-Jx
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:24 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbhC-0007i0-0r
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 104562116F;
 Tue, 17 Dec 2024 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YSDLFpQ/gLoyRLfdBfk+dOQlzC1VgiHItAdmD2q0p0=;
 b=k8h7meuLn3Zw3Mq9XDrNmDK9AxDBv6qdVFNKr9rQYWYdQMtKkJbSCa216RUoKmw6ArGOiN
 H0m5fETjLYNCBMBRFXx+A6ibrETJux8ONYhkXR5rH+Q4mGcg8L0iCMlZO+Y8NQUcp0BwK/
 J1O4uH/xhDmfgPNbjIUJLy36cRh9cT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YSDLFpQ/gLoyRLfdBfk+dOQlzC1VgiHItAdmD2q0p0=;
 b=Epc+XIGHM+aLuia28B5nEZ90lW4eLbF9G+IWGbat8XMJ3MhKyFZ+LPq/g53xHuaFczxNEo
 tBAxp+D4vW2ksIAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k8h7meuL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Epc+XIGH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YSDLFpQ/gLoyRLfdBfk+dOQlzC1VgiHItAdmD2q0p0=;
 b=k8h7meuLn3Zw3Mq9XDrNmDK9AxDBv6qdVFNKr9rQYWYdQMtKkJbSCa216RUoKmw6ArGOiN
 H0m5fETjLYNCBMBRFXx+A6ibrETJux8ONYhkXR5rH+Q4mGcg8L0iCMlZO+Y8NQUcp0BwK/
 J1O4uH/xhDmfgPNbjIUJLy36cRh9cT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YSDLFpQ/gLoyRLfdBfk+dOQlzC1VgiHItAdmD2q0p0=;
 b=Epc+XIGHM+aLuia28B5nEZ90lW4eLbF9G+IWGbat8XMJ3MhKyFZ+LPq/g53xHuaFczxNEo
 tBAxp+D4vW2ksIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C57C13A3C;
 Tue, 17 Dec 2024 17:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJSeNJ65YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 14/17] migration/block: Apply late-block-active behavior to
 postcopy
Date: Tue, 17 Dec 2024 14:48:52 -0300
Message-Id: <20241217174855.24971-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 104562116F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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
index 98821c8120..80726726fe 100644
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


