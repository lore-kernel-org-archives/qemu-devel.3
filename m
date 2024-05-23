Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53669C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlW-00029g-Th; Thu, 23 May 2024 15:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlV-00029J-Ve
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:13 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlU-0004IX-7d
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE2602040D;
 Thu, 23 May 2024 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwtD5RitfHwo1/3GuiieS4h4aHhJQYNEx9e0JR0CQDo=;
 b=GTvi8PblbEzD9Koy+pDsEKQBOoL4QbrMZWgW3d987AuLeOfqz41vLzJ/WZz/ef19dnhpou
 wFC2Ika7QDQRysI1hBSqCu89jAw7RmRCqlTvuBppuHnzkD4DmhOig8rrQYpfw7hCVZp1BT
 0KRFb+ctMBpGEOBONwuZgqKQYsBv0Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwtD5RitfHwo1/3GuiieS4h4aHhJQYNEx9e0JR0CQDo=;
 b=X98rZU8Iu1VdSXgwabhyKnvgxTYTpWGpSb7u6I6cMiESMjBjcY59AkJM4iyiQzFGraLRz9
 4Ijl8VZAbBqSZACg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="L/h+uycb";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=79yYwZpL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwtD5RitfHwo1/3GuiieS4h4aHhJQYNEx9e0JR0CQDo=;
 b=L/h+uycbaiWoGYyS5NdNKySegEYlweLXd/Dyf4u5rQkxI7MujRRu5JmZP4g/vbNycKa0C9
 mq6g1DKai8QOGgQjBNxWL0eW+TrDcc3TIvWyJ80l+/EuUn3QnfdWlrmuezUh3sXr7Wps/3
 dUcMpOem/JfUkxG0xHg9WtT5jwIeuJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwtD5RitfHwo1/3GuiieS4h4aHhJQYNEx9e0JR0CQDo=;
 b=79yYwZpL3y6BifCho9tJhe33ZwTxag7vmkAy9k93nu8k0O8xvEtw4rwyXnKttu2glO4qzn
 j+c5YOvUyLtHN8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2369D13A6B;
 Thu, 23 May 2024 19:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GL/ONqCTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 07/18] monitor: Simplify fdset and fd removal
Date: Thu, 23 May 2024 16:05:37 -0300
Message-Id: <20240523190548.23977-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.04 / 50.00]; BAYES_HAM(-2.03)[95.23%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EE2602040D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Remove fds right away instead of setting the ->removed flag. We don't
need the extra complexity of having a cleanup function reap the
removed entries at a later time.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index f7b98814fa..fa723e1883 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -43,7 +43,6 @@ struct mon_fd_t {
 typedef struct MonFdsetFd MonFdsetFd;
 struct MonFdsetFd {
     int fd;
-    bool removed;
     char *opaque;
     QLIST_ENTRY(MonFdsetFd) next;
 };
@@ -188,20 +187,6 @@ static void monitor_fdset_fd_free(MonFdsetFd *mon_fdset_fd)
     g_free(mon_fdset_fd);
 }
 
-static void monitor_fdset_cleanup(MonFdset *mon_fdset)
-{
-    MonFdsetFd *mon_fdset_fd;
-    MonFdsetFd *mon_fdset_fd_next;
-
-    QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
-        if (mon_fdset_fd->removed) {
-            monitor_fdset_fd_free(mon_fdset_fd);
-        }
-    }
-
-    monitor_fdset_free(mon_fdset);
-}
-
 void monitor_fdsets_cleanup(void)
 {
     MonFdset *mon_fdset;
@@ -276,7 +261,7 @@ void qmp_get_win32_socket(const char *infos, const char *fdname, Error **errp)
 void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
 {
     MonFdset *mon_fdset;
-    MonFdsetFd *mon_fdset_fd;
+    MonFdsetFd *mon_fdset_fd, *mon_fdset_fd_next;
     char fd_str[60];
 
     QEMU_LOCK_GUARD(&mon_fdsets_lock);
@@ -284,21 +269,22 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
         if (mon_fdset->id != fdset_id) {
             continue;
         }
-        QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
+        QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next,
+                           mon_fdset_fd_next) {
             if (has_fd) {
                 if (mon_fdset_fd->fd != fd) {
                     continue;
                 }
-                mon_fdset_fd->removed = true;
+                monitor_fdset_fd_free(mon_fdset_fd);
                 break;
             } else {
-                mon_fdset_fd->removed = true;
+                monitor_fdset_fd_free(mon_fdset_fd);
             }
         }
         if (has_fd && !mon_fdset_fd) {
             goto error;
         }
-        monitor_fdset_cleanup(mon_fdset);
+        monitor_fdset_free(mon_fdset);
         return;
     }
 
@@ -408,7 +394,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
 
     mon_fdset_fd = g_malloc0(sizeof(*mon_fdset_fd));
     mon_fdset_fd->fd = fd;
-    mon_fdset_fd->removed = false;
     mon_fdset_fd->opaque = g_strdup(opaque);
     QLIST_INSERT_HEAD(&mon_fdset->fds, mon_fdset_fd, next);
 
-- 
2.35.3


