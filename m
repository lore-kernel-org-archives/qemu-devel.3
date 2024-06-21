Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565F5C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTO-0003Im-LL; Fri, 21 Jun 2024 13:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTM-0003Ho-MR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTK-0003KQ-Ta
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 937A721B37;
 Fri, 21 Jun 2024 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1KaYbtoCrYR/UVJrzg71LPk0e1FdJi5ikFfwJo+cZ4=;
 b=DUS/oUwl/tzS78bikzXyrXulVyF7vcGlQncdBhIYst7nggxn27kC5CIOB/kAz/ILk0Zvr6
 fBE4NXxCZhjZG+YEb5eZq751kDwxrSmqViK0BnrO512QlUC2e0rSPXO4y99dR2WoaYtTKo
 6/tTo3fGUrKzGaXFOtfUqEcV6owVbro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1KaYbtoCrYR/UVJrzg71LPk0e1FdJi5ikFfwJo+cZ4=;
 b=fWouPYWHxxAP+qL+0zmruzu+PwpKFLLzcFSx86QPmh+w8gGe+EERFtunhJHio02Sgineo9
 E7DlF+18aM8V9lAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DUS/oUwl";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fWouPYWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1KaYbtoCrYR/UVJrzg71LPk0e1FdJi5ikFfwJo+cZ4=;
 b=DUS/oUwl/tzS78bikzXyrXulVyF7vcGlQncdBhIYst7nggxn27kC5CIOB/kAz/ILk0Zvr6
 fBE4NXxCZhjZG+YEb5eZq751kDwxrSmqViK0BnrO512QlUC2e0rSPXO4y99dR2WoaYtTKo
 6/tTo3fGUrKzGaXFOtfUqEcV6owVbro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1KaYbtoCrYR/UVJrzg71LPk0e1FdJi5ikFfwJo+cZ4=;
 b=fWouPYWHxxAP+qL+0zmruzu+PwpKFLLzcFSx86QPmh+w8gGe+EERFtunhJHio02Sgineo9
 E7DlF+18aM8V9lAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6572913AAA;
 Fri, 21 Jun 2024 17:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4PUFC2i+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:54:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/28] monitor: Introduce monitor_fdset_*free
Date: Fri, 21 Jun 2024 14:54:12 -0300
Message-Id: <20240621175434.31180-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 937A721B37
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Introduce new functions to remove and free no longer used fds and
fdsets.

We need those to decouple the remove/free routines from
monitor_fdset_cleanup() which will go away in the next patches.

The new functions:

- monitor_fdset_free/_if_empty() will be used when a monitor
  connection closes and when an fd is removed to cleanup any fdset
  that is now empty.

- monitor_fdset_fd_free() will be used to remove one or more fds that
  have been explicitly targeted by qmp_remove_fd().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index fb9f58c056..bd45a26368 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -167,6 +167,27 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
     return -1;
 }
 
+static void monitor_fdset_free(MonFdset *mon_fdset)
+{
+    QLIST_REMOVE(mon_fdset, next);
+    g_free(mon_fdset);
+}
+
+static void monitor_fdset_free_if_empty(MonFdset *mon_fdset)
+{
+    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
+        monitor_fdset_free(mon_fdset);
+    }
+}
+
+static void monitor_fdset_fd_free(MonFdsetFd *mon_fdset_fd)
+{
+    close(mon_fdset_fd->fd);
+    g_free(mon_fdset_fd->opaque);
+    QLIST_REMOVE(mon_fdset_fd, next);
+    g_free(mon_fdset_fd);
+}
+
 static void monitor_fdset_cleanup(MonFdset *mon_fdset)
 {
     MonFdsetFd *mon_fdset_fd;
@@ -176,17 +197,11 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
         if ((mon_fdset_fd->removed ||
                 (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
                 runstate_is_running()) {
-            close(mon_fdset_fd->fd);
-            g_free(mon_fdset_fd->opaque);
-            QLIST_REMOVE(mon_fdset_fd, next);
-            g_free(mon_fdset_fd);
+            monitor_fdset_fd_free(mon_fdset_fd);
         }
     }
 
-    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
-        QLIST_REMOVE(mon_fdset, next);
-        g_free(mon_fdset);
-    }
+    monitor_fdset_free_if_empty(mon_fdset);
 }
 
 void monitor_fdsets_cleanup(void)
-- 
2.35.3


