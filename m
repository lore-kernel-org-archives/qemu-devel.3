Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4CCC2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYB-0003oC-3E; Mon, 17 Jun 2024 14:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHY8-0003mr-VD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHY7-0004p8-2c
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80A681F7B0;
 Mon, 17 Jun 2024 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej2WTQ/a70FEnSwNeGX5ZJIjI8llyrpp7m9fi688FQk=;
 b=r2Bp8P2buLBhzvab6jVtWB1hCUtEcc//ifK+d8o3f+gIMV+Ri8fGFFjibQw9sn5iVhOAPj
 nAG78rhBxnRSCdvnFawtS/3DGXjcVYkdKJRHUDTgyQlGsog0ESyZOR7Bk8Sk1rQ2A2KDOj
 42/cVdHHos4VVgNn6LOegyHFzKXWOiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej2WTQ/a70FEnSwNeGX5ZJIjI8llyrpp7m9fi688FQk=;
 b=toSTv19mCAhQxVmbHds/EnkN9EUmetcnunRtJPqsWwaMtBtNspQiy/IIP5qvsi1hUubnQj
 pXCHG1JHP8nM9FDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej2WTQ/a70FEnSwNeGX5ZJIjI8llyrpp7m9fi688FQk=;
 b=r2Bp8P2buLBhzvab6jVtWB1hCUtEcc//ifK+d8o3f+gIMV+Ri8fGFFjibQw9sn5iVhOAPj
 nAG78rhBxnRSCdvnFawtS/3DGXjcVYkdKJRHUDTgyQlGsog0ESyZOR7Bk8Sk1rQ2A2KDOj
 42/cVdHHos4VVgNn6LOegyHFzKXWOiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej2WTQ/a70FEnSwNeGX5ZJIjI8llyrpp7m9fi688FQk=;
 b=toSTv19mCAhQxVmbHds/EnkN9EUmetcnunRtJPqsWwaMtBtNspQiy/IIP5qvsi1hUubnQj
 pXCHG1JHP8nM9FDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00464139AB;
 Mon, 17 Jun 2024 18:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ODwSLiqHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:57:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 05/16] monitor: Drop monitor_fdset_dup_fd_find/_remove()
Date: Mon, 17 Jun 2024 15:57:20 -0300
Message-Id: <20240617185731.9725-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617185731.9725-1-farosas@suse.de>
References: <20240617185731.9725-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Peter Xu <peterx@redhat.com>

Those functions are not needed, one remove function should already
work.  Clean it up.

Here the code doesn't really care about whether we need to keep that dupfd
around if close() failed: when that happens something got very wrong,
keeping the dup_fd around the fdsets may not help that situation so far.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[add missing return statement, removal during traversal is not safe]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/monitor/monitor.h |  1 -
 monitor/fds.c             | 28 ++++++----------------------
 stubs/fdset.c             |  5 -----
 util/osdep.c              | 15 +--------------
 4 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 965f5d5450..fd9b3f538c 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -53,7 +53,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
                                 const char *opaque, Error **errp);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags);
 void monitor_fdset_dup_fd_remove(int dup_fd);
-int64_t monitor_fdset_dup_fd_find(int dup_fd);
 
 void monitor_register_hmp(const char *name, bool info,
                           void (*cmd)(Monitor *mon, const QDict *qdict));
diff --git a/monitor/fds.c b/monitor/fds.c
index d86c2c674c..fb9f58c056 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -458,7 +458,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
 #endif
 }
 
-static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
+void monitor_fdset_dup_fd_remove(int dup_fd)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
@@ -467,31 +467,15 @@ static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
-                if (remove) {
-                    QLIST_REMOVE(mon_fdset_fd_dup, next);
-                    g_free(mon_fdset_fd_dup);
-                    if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
-                        monitor_fdset_cleanup(mon_fdset);
-                    }
-                    return -1;
-                } else {
-                    return mon_fdset->id;
+                QLIST_REMOVE(mon_fdset_fd_dup, next);
+                g_free(mon_fdset_fd_dup);
+                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
+                    monitor_fdset_cleanup(mon_fdset);
                 }
+                return;
             }
         }
     }
-
-    return -1;
-}
-
-int64_t monitor_fdset_dup_fd_find(int dup_fd)
-{
-    return monitor_fdset_dup_fd_find_remove(dup_fd, false);
-}
-
-void monitor_fdset_dup_fd_remove(int dup_fd)
-{
-    monitor_fdset_dup_fd_find_remove(dup_fd, true);
 }
 
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
diff --git a/stubs/fdset.c b/stubs/fdset.c
index d7c39a28ac..389e368a29 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -9,11 +9,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
     return -1;
 }
 
-int64_t monitor_fdset_dup_fd_find(int dup_fd)
-{
-    return -1;
-}
-
 void monitor_fdset_dup_fd_remove(int dupfd)
 {
 }
diff --git a/util/osdep.c b/util/osdep.c
index 5d23bbfbec..756de9a745 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -398,21 +398,8 @@ int qemu_open_old(const char *name, int flags, ...)
 
 int qemu_close(int fd)
 {
-    int64_t fdset_id;
-
     /* Close fd that was dup'd from an fdset */
-    fdset_id = monitor_fdset_dup_fd_find(fd);
-    if (fdset_id != -1) {
-        int ret;
-
-        ret = close(fd);
-        if (ret == 0) {
-            monitor_fdset_dup_fd_remove(fd);
-        }
-
-        return ret;
-    }
-
+    monitor_fdset_dup_fd_remove(fd);
     return close(fd);
 }
 
-- 
2.35.3


