Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A68E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbhE-0005uJ-Vp; Tue, 17 Dec 2024 12:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbhA-0005rM-HR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbh8-0007gg-Gw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CA182115F;
 Tue, 17 Dec 2024 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXSklg9grViJmNB82rRsyIdcvvJIUdnCNV+AwZdWD4A=;
 b=y8AwNYe+wnZnPTtDcFxmOj4+IV0YKplgolbuVXg6nKo4C0E0uRjW5qz+6RMAdWNEEZUzh3
 LsnNfC2yEehuVY/y1ddKhkysh+KO3n0C+nn/Y9id8JuHiJYbBoOqaMQz/73TYkmf5pHuTG
 UpAgKaGm97PTW8dryVxg0wBSvjAGWxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXSklg9grViJmNB82rRsyIdcvvJIUdnCNV+AwZdWD4A=;
 b=A7nLZpcqo3g/6yUJEd71w+Kw7jqx1j/0O8/qRsG40yWtX0H18lfrkFoDj3Vi5ZROPYeteu
 PK8kRy/rWDM1VpDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y8AwNYe+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A7nLZpcq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXSklg9grViJmNB82rRsyIdcvvJIUdnCNV+AwZdWD4A=;
 b=y8AwNYe+wnZnPTtDcFxmOj4+IV0YKplgolbuVXg6nKo4C0E0uRjW5qz+6RMAdWNEEZUzh3
 LsnNfC2yEehuVY/y1ddKhkysh+KO3n0C+nn/Y9id8JuHiJYbBoOqaMQz/73TYkmf5pHuTG
 UpAgKaGm97PTW8dryVxg0wBSvjAGWxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXSklg9grViJmNB82rRsyIdcvvJIUdnCNV+AwZdWD4A=;
 b=A7nLZpcqo3g/6yUJEd71w+Kw7jqx1j/0O8/qRsG40yWtX0H18lfrkFoDj3Vi5ZROPYeteu
 PK8kRy/rWDM1VpDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEAB513A3C;
 Tue, 17 Dec 2024 17:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aBKnJJu5YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 12/17] qmp/cont: Only activate disks if migration completed
Date: Tue, 17 Dec 2024 14:48:50 -0300
Message-Id: <20241217174855.24971-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CA182115F
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

As the comment says, the activation of disks is for the case where
migration has completed, rather than when QEMU is still during
migration (RUN_STATE_INMIGRATE).

Move the code over to reflect what the comment is describing.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241206230838.1111496-3-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/qmp-cmds.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index f84a0dc523..76f21e8af3 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -96,21 +96,23 @@ void qmp_cont(Error **errp)
         }
     }
 
-    /* Continuing after completed migration. Images have been inactivated to
-     * allow the destination to take control. Need to get control back now.
-     *
-     * If there are no inactive block nodes (e.g. because the VM was just
-     * paused rather than completing a migration), bdrv_inactivate_all() simply
-     * doesn't do anything. */
-    bdrv_activate_all(&local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         autostart = 1;
     } else {
+        /*
+         * Continuing after completed migration. Images have been
+         * inactivated to allow the destination to take control. Need to
+         * get control back now.
+         *
+         * If there are no inactive block nodes (e.g. because the VM was
+         * just paused rather than completing a migration),
+         * bdrv_inactivate_all() simply doesn't do anything.
+         */
+        bdrv_activate_all(&local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
         vm_start();
     }
 }
-- 
2.35.3


