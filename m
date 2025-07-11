Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592AFC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEdo-0003mu-0N; Fri, 11 Jul 2025 10:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEU3-0002u0-Dc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:16 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETz-0006r4-JV
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 669901F461;
 Fri, 11 Jul 2025 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLVxbUl1QbCpvaOs+8U0flUWK625i092YCFo0WiecoQ=;
 b=LzQwW1q1pscp5Ja61+ZMgIzV8aoSTo+oVnjkYi+MEx0xH236M9EaCBnfYQTgHk3BBg11wK
 bZ6RR+6TVrHAUrgDVw3nBoinZWzyMC+4UvNafjRElqBsX6YX5VX+3vxoaTjGzXfqMUoTx8
 wdLZLiiWI9ErtG5UYxNm0dGQT+yV+6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLVxbUl1QbCpvaOs+8U0flUWK625i092YCFo0WiecoQ=;
 b=FASXHoFAE2p9UyIYcaBQuEEOc90erJ+G8G2ZV5cqewLNcyMjkVxLhLBVwj71nz5VXWVWyU
 HO35yFm4/mNAYCCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LzQwW1q1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FASXHoFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLVxbUl1QbCpvaOs+8U0flUWK625i092YCFo0WiecoQ=;
 b=LzQwW1q1pscp5Ja61+ZMgIzV8aoSTo+oVnjkYi+MEx0xH236M9EaCBnfYQTgHk3BBg11wK
 bZ6RR+6TVrHAUrgDVw3nBoinZWzyMC+4UvNafjRElqBsX6YX5VX+3vxoaTjGzXfqMUoTx8
 wdLZLiiWI9ErtG5UYxNm0dGQT+yV+6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLVxbUl1QbCpvaOs+8U0flUWK625i092YCFo0WiecoQ=;
 b=FASXHoFAE2p9UyIYcaBQuEEOc90erJ+G8G2ZV5cqewLNcyMjkVxLhLBVwj71nz5VXWVWyU
 HO35yFm4/mNAYCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5155113918;
 Fri, 11 Jul 2025 14:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4DtOBIAbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 20/26] migration/postcopy: Initialize blocktime context only
 until listen
Date: Fri, 11 Jul 2025 11:10:25 -0300
Message-Id: <20250711141031.423-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 669901F461
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

Before this patch, the blocktime context can be created very early, because
postcopy_ram_supported_by_host() <- migrate_caps_check() can happen during
migration object init.

The trick here is the blocktime context needs system vCPU information,
which seems to be possible to change after that point.  I didn't verify it,
but it doesn't sound right.

Now move it out and initialize the context only when postcopy listen
starts.  That is already during a migration so it should be guaranteed the
vCPU topology can never change on both sides.

While at it, assert that the ctx isn't created instead this time; the old
"if" trick isn't needed when we're sure it will only happen once now.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-10-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fe940f89b9..dd3615663f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -325,13 +325,13 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis,
     }
 
 #ifdef UFFD_FEATURE_THREAD_ID
+    /*
+     * Postcopy blocktime conditionally needs THREAD_ID feature (introduced
+     * to Linux in 2017). Always try to enable it when QEMU is compiled
+     * with such environment.
+     */
     if (UFFD_FEATURE_THREAD_ID & supported_features) {
         asked_features |= UFFD_FEATURE_THREAD_ID;
-        if (migrate_postcopy_blocktime()) {
-            if (!mis->blocktime_ctx) {
-                mis->blocktime_ctx = blocktime_context_new();
-            }
-        }
     }
 #endif
 
@@ -1239,6 +1239,11 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (migrate_postcopy_blocktime()) {
+        assert(mis->blocktime_ctx == NULL);
+        mis->blocktime_ctx = blocktime_context_new();
+    }
+
     /* Now an eventfd we use to tell the fault-thread to quit */
     mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
     if (mis->userfault_event_fd == -1) {
-- 
2.35.3


