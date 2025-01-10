Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3211DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuO-0001R8-Nv; Fri, 10 Jan 2025 07:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuN-0001Qh-4X
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuL-0003Ko-Et
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2AAA51F45A;
 Fri, 10 Jan 2025 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3XF/ui51K3r+SLzwS7YeqUfolBcPPBko7F0Cr76l2g=;
 b=nnJ9WZgWxqdq5BrGh571uARrQrbENO5SADpjS3XSy+Kh/JpoXdELUAm3c87Pwlc0xGBX1R
 FHagg0RRMfkZQ0yFvpuOP+ABafHXKeG7gwR5UxO9vyqpTSqtA4Ib6AoRRfumFGRjJdmA4m
 u62TZy1pthrF6h9I4gzo530VqKPAF8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3XF/ui51K3r+SLzwS7YeqUfolBcPPBko7F0Cr76l2g=;
 b=GteXazCq0yDnOv5+pQYreQ8qYZjGnDvo0IhD6Cb10XmBLReX6q5PIz/b4VGJ6hIJz9s/Nm
 tRS9T8k/Po2c5+AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nnJ9WZgW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GteXazCq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3XF/ui51K3r+SLzwS7YeqUfolBcPPBko7F0Cr76l2g=;
 b=nnJ9WZgWxqdq5BrGh571uARrQrbENO5SADpjS3XSy+Kh/JpoXdELUAm3c87Pwlc0xGBX1R
 FHagg0RRMfkZQ0yFvpuOP+ABafHXKeG7gwR5UxO9vyqpTSqtA4Ib6AoRRfumFGRjJdmA4m
 u62TZy1pthrF6h9I4gzo530VqKPAF8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3XF/ui51K3r+SLzwS7YeqUfolBcPPBko7F0Cr76l2g=;
 b=GteXazCq0yDnOv5+pQYreQ8qYZjGnDvo0IhD6Cb10XmBLReX6q5PIz/b4VGJ6hIJz9s/Nm
 tRS9T8k/Po2c5+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 300BB13A86;
 Fri, 10 Jan 2025 12:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0DlsOSYPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 10/25] migration: Add helper to get target runstate
Date: Fri, 10 Jan 2025 09:13:58 -0300
Message-Id: <20250110121413.12336-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AAA51F45A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In 99% cases, after QEMU migrates to dest host, it tries to detect the
target VM runstate using global_state_get_runstate().

There's one outlier so far which is Xen that won't send global state.
That's the major reason why global_state_received() check was always there
together with global_state_get_runstate().

However it's utterly confusing why global_state_received() has anything to
do with "let's start VM or not".

Provide a helper to explain it, then we have an unified entry for getting
the target dest QEMU runstate after migration.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241206230838.1111496-2-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index df61ca4e93..969b03cdcd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -135,6 +135,21 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
+static RunState migration_get_target_runstate(void)
+{
+    /*
+     * When the global state is not migrated, it means we don't know the
+     * runstate of the src QEMU.  We don't have much choice but assuming
+     * the VM is running.  NOTE: this is pretty rare case, so far only Xen
+     * uses it.
+     */
+    if (!global_state_received()) {
+        return RUN_STATE_RUNNING;
+    }
+
+    return global_state_get_runstate();
+}
+
 static bool transport_supports_multi_channels(MigrationAddress *addr)
 {
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
@@ -735,8 +750,7 @@ static void process_incoming_migration_bh(void *opaque)
      * unless we really are starting the VM.
      */
     if (!migrate_late_block_activate() ||
-         (autostart && (!global_state_received() ||
-            runstate_is_live(global_state_get_runstate())))) {
+        (autostart && runstate_is_live(migration_get_target_runstate()))) {
         /* Make sure all file formats throw away their mutable metadata.
          * If we get an error here, just don't restart the VM yet. */
         bdrv_activate_all(&local_err);
@@ -759,8 +773,7 @@ static void process_incoming_migration_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        runstate_is_live(global_state_get_runstate())) {
+    if (runstate_is_live(migration_get_target_runstate())) {
         if (autostart) {
             vm_start();
         } else {
-- 
2.35.3


