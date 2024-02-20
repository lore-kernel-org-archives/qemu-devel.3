Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E045C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYpE-0005Ar-1w; Tue, 20 Feb 2024 17:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpB-000548-Ib
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:53 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpA-0006Q3-5y
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19EC522260;
 Tue, 20 Feb 2024 22:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6ThC3N+nnfX7FJ2t0KT5ydaj0Xe0MiFJ+bC9uw3Bk=;
 b=nM1y/GoKo65bryCqtQ78BdeRrjgDM7nCc2rTqHH/Dnns3M/pwC4njLRnkbf2Cqe51ZdlPA
 KrXC4yF6Rl3fDCQKg5U8hyvB5gFvoIVSVEemyra4iDfTCDKJKv8HDgwOXCxZrpYyYxJ4PZ
 LsCBHsDZJBXpos8KFxuIWEHCYEcCn70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6ThC3N+nnfX7FJ2t0KT5ydaj0Xe0MiFJ+bC9uw3Bk=;
 b=wTaoonG7gCrkU4Fsbog2NmlIf7YjBIKW709owkqiOCBlmq6nrbT1nB83leT274yB8DlPVg
 JoppppUBaLGY6oAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6ThC3N+nnfX7FJ2t0KT5ydaj0Xe0MiFJ+bC9uw3Bk=;
 b=nM1y/GoKo65bryCqtQ78BdeRrjgDM7nCc2rTqHH/Dnns3M/pwC4njLRnkbf2Cqe51ZdlPA
 KrXC4yF6Rl3fDCQKg5U8hyvB5gFvoIVSVEemyra4iDfTCDKJKv8HDgwOXCxZrpYyYxJ4PZ
 LsCBHsDZJBXpos8KFxuIWEHCYEcCn70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6ThC3N+nnfX7FJ2t0KT5ydaj0Xe0MiFJ+bC9uw3Bk=;
 b=wTaoonG7gCrkU4Fsbog2NmlIf7YjBIKW709owkqiOCBlmq6nrbT1nB83leT274yB8DlPVg
 JoppppUBaLGY6oAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AF99139D0;
 Tue, 20 Feb 2024 22:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EKOvEOkq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 30/34] monitor: Honor QMP request for fd removal immediately
Date: Tue, 20 Feb 2024 19:41:34 -0300
Message-Id: <20240220224138.24759-31-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="nM1y/GoK";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wTaoonG7
X-Spamd-Result: default: False [4.39 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.30)[75.09%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 19EC522260
X-Spamd-Bar: ++++
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We're currently only removing an fd from the fdset if the VM is
running. This causes a QMP call to "remove-fd" to not actually remove
the fd if the VM happens to be stopped.

While the fd would eventually be removed when monitor_fdset_cleanup()
is called again, the user request should be honored and the fd
actually removed. Calling remove-fd + query-fdset shows a recently
removed fd still present.

The runstate_is_running() check was introduced by commit ebe52b592d
("monitor: Prevent removing fd from set during init"), which by the
shortlog indicates that they were trying to avoid removing an
yet-unduplicated fd too early.

I don't see why an fd explicitly removed with qmp_remove_fd() should
be under runstate_is_running(). I'm assuming this was a mistake when
adding the parenthesis around the expression.

Move the runstate_is_running() check to apply only to the
QLIST_EMPTY(dup_fds) side of the expression and ignore it when
mon_fdset_fd->removed has been explicitly set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index d86c2c674c..4ec3b7eea9 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -173,9 +173,9 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
     MonFdsetFd *mon_fdset_fd_next;
 
     QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
-        if ((mon_fdset_fd->removed ||
-                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
-                runstate_is_running()) {
+        if (mon_fdset_fd->removed ||
+            (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0 &&
+             runstate_is_running())) {
             close(mon_fdset_fd->fd);
             g_free(mon_fdset_fd->opaque);
             QLIST_REMOVE(mon_fdset_fd, next);
-- 
2.35.3


