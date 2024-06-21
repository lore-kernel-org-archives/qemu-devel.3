Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294FC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTR-0003K8-P3; Fri, 21 Jun 2024 13:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTP-0003JA-GR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:55 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTN-0003Km-Vk
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4F6C1FB83;
 Fri, 21 Jun 2024 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za/MdoTjYF8RTE34hqR6WeoRMReozqYIC59R2HEqRgQ=;
 b=SDTez2cWPSNIVtj3PfquviaHkcmg6uyZPWBTz+7FAlM65x9ytc8ax1FMNKzaQgR6mGY+tJ
 +adXO0W7cI8bXGOrX7Wbpf3ThwmW0pxsh0/yW0LN9vu8QIHvNovEJDDGLpY0OwnUrqoafr
 jF9C9b7C1zkDChobUaRvMDMUXQ955xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za/MdoTjYF8RTE34hqR6WeoRMReozqYIC59R2HEqRgQ=;
 b=x8eOSEAcq4j/nQgVpBbIPDdF6n9EvYQR5Bj+urd8jdkDX6bLyVoUFu2o4gPAZ2gtkvX3gu
 f5yU9TYQHnQ2a7CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za/MdoTjYF8RTE34hqR6WeoRMReozqYIC59R2HEqRgQ=;
 b=SDTez2cWPSNIVtj3PfquviaHkcmg6uyZPWBTz+7FAlM65x9ytc8ax1FMNKzaQgR6mGY+tJ
 +adXO0W7cI8bXGOrX7Wbpf3ThwmW0pxsh0/yW0LN9vu8QIHvNovEJDDGLpY0OwnUrqoafr
 jF9C9b7C1zkDChobUaRvMDMUXQ955xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za/MdoTjYF8RTE34hqR6WeoRMReozqYIC59R2HEqRgQ=;
 b=x8eOSEAcq4j/nQgVpBbIPDdF6n9EvYQR5Bj+urd8jdkDX6bLyVoUFu2o4gPAZ2gtkvX3gu
 f5yU9TYQHnQ2a7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A82D013AAA;
 Fri, 21 Jun 2024 17:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2AR7G2u+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:54:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/28] monitor: Simplify fdset and fd removal
Date: Fri, 21 Jun 2024 14:54:14 -0300
Message-Id: <20240621175434.31180-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index 76199d4b3b..e7619a6103 100644
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
@@ -193,20 +192,6 @@ static void monitor_fdset_fd_free(MonFdsetFd *mon_fdset_fd)
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
-    monitor_fdset_free_if_empty(mon_fdset);
-}
-
 void monitor_fdsets_cleanup(void)
 {
     MonFdset *mon_fdset;
@@ -281,7 +266,7 @@ void qmp_get_win32_socket(const char *infos, const char *fdname, Error **errp)
 void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
 {
     MonFdset *mon_fdset;
-    MonFdsetFd *mon_fdset_fd;
+    MonFdsetFd *mon_fdset_fd, *mon_fdset_fd_next;
     char fd_str[60];
 
     QEMU_LOCK_GUARD(&mon_fdsets_lock);
@@ -289,21 +274,22 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
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
+        monitor_fdset_free_if_empty(mon_fdset);
         return;
     }
 
@@ -413,7 +399,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
 
     mon_fdset_fd = g_malloc0(sizeof(*mon_fdset_fd));
     mon_fdset_fd->fd = fd;
-    mon_fdset_fd->removed = false;
     mon_fdset_fd->opaque = g_strdup(opaque);
     QLIST_INSERT_HEAD(&mon_fdset->fds, mon_fdset_fd, next);
 
-- 
2.35.3


