Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5A1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuQ-0001SE-Lb; Fri, 10 Jan 2025 07:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuO-0001RI-S0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:36 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuN-0003L2-93
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:36 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 101A421177;
 Fri, 10 Jan 2025 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY/u0TlQbewjYQ4iu9vwhy+Ms0yAX7sbIp/wCDWLkJ0=;
 b=AI9D/uMETnLD17UljOqOj7nvhNezlrPrFOcyQCX75us7YEMenouuRQmCfg76TocMPN9DJK
 BSIcfm7fqjKPa5BpXhSGDrwrmGAmq0jps6coE5hgRlnoKZ/8Ldfzk2aIBmSQskBg6m9+Ch
 aK+SbkMyHZ8exS7yIb3uOuAXe/Ojp+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY/u0TlQbewjYQ4iu9vwhy+Ms0yAX7sbIp/wCDWLkJ0=;
 b=fcl2whXOftD+bG4V8p/BHqoXBgi64bZETpKjb+8QWyXN5F3IPC74sq/B7f11peQ/8nxkz/
 g5MQu+NYhlouPWBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY/u0TlQbewjYQ4iu9vwhy+Ms0yAX7sbIp/wCDWLkJ0=;
 b=AI9D/uMETnLD17UljOqOj7nvhNezlrPrFOcyQCX75us7YEMenouuRQmCfg76TocMPN9DJK
 BSIcfm7fqjKPa5BpXhSGDrwrmGAmq0jps6coE5hgRlnoKZ/8Ldfzk2aIBmSQskBg6m9+Ch
 aK+SbkMyHZ8exS7yIb3uOuAXe/Ojp+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY/u0TlQbewjYQ4iu9vwhy+Ms0yAX7sbIp/wCDWLkJ0=;
 b=fcl2whXOftD+bG4V8p/BHqoXBgi64bZETpKjb+8QWyXN5F3IPC74sq/B7f11peQ/8nxkz/
 g5MQu+NYhlouPWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9963213A86;
 Fri, 10 Jan 2025 12:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6O40FygPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 11/25] qmp/cont: Only activate disks if migration completed
Date: Fri, 10 Jan 2025 09:13:59 -0300
Message-Id: <20250110121413.12336-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
index 34f215097c..415e645130 100644
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


