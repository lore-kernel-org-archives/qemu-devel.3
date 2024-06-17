Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A30EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYE-0003pt-Am; Mon, 17 Jun 2024 14:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYD-0003pV-Ky
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:57 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYB-0004sm-PZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CD9E1F443;
 Mon, 17 Jun 2024 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceChUQ59yKW8r+uZdm7f/uUA8rCn96xY3ZW0kVrinNg=;
 b=0bvs6lGPLOeVN4l/8HluTH0ActiUL/HrHVimoBfTfe37oGx6ew7nugTutgfjQ96Qjr2zM7
 iVscsUS2W7mivFweg0X8h8lu2+8/FFX2dTNJt/RgnOd70+6uPruBigHs8++NoXqK3qjTc8
 9c9py1bb7yygNHTwDo9iuKRC8YX4+wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceChUQ59yKW8r+uZdm7f/uUA8rCn96xY3ZW0kVrinNg=;
 b=U1wuhfyZCdv5oUeI8nULLIKE03FEAoRL559d8KuNwruQ9V4l8yZwH7wzpp808yEPUVvDDI
 yKibZS0b4HinPODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceChUQ59yKW8r+uZdm7f/uUA8rCn96xY3ZW0kVrinNg=;
 b=0bvs6lGPLOeVN4l/8HluTH0ActiUL/HrHVimoBfTfe37oGx6ew7nugTutgfjQ96Qjr2zM7
 iVscsUS2W7mivFweg0X8h8lu2+8/FFX2dTNJt/RgnOd70+6uPruBigHs8++NoXqK3qjTc8
 9c9py1bb7yygNHTwDo9iuKRC8YX4+wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceChUQ59yKW8r+uZdm7f/uUA8rCn96xY3ZW0kVrinNg=;
 b=U1wuhfyZCdv5oUeI8nULLIKE03FEAoRL559d8KuNwruQ9V4l8yZwH7wzpp808yEPUVvDDI
 yKibZS0b4HinPODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54BE1139AB;
 Mon, 17 Jun 2024 18:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OMQVBzCHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:57:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 07/16] monitor: Stop removing non-duplicated fds
Date: Mon, 17 Jun 2024 15:57:22 -0300
Message-Id: <20240617185731.9725-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617185731.9725-1-farosas@suse.de>
References: <20240617185731.9725-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

monitor_fdsets_cleanup() currently has three responsibilities:

1- Remove the fds that have been marked for removal(->removed=true) by
   qmp_remove_fd(). This is overly complicated, but ok.

2- Remove any file descriptors that have been passed into QEMU and
   never duplicated[1,2]. A file descriptor without duplicates
   indicates that no part of QEMU has made use of it. This is
   problematic because the current implementation does it only if the
   guest is not running and the monitor is closed.

3- Remove/free fdsets that have become empty due to the above
   removals. This is ok.

The scenario described in (2) is starting to show some cracks now that
we're trying to consume fds from the migration code:

- Doing cleanup every time the last monitor connection closes works to
  reap unused fds, but also has the side effect of forcing the
  management layer to pass the file descriptors again in case of a
  disconnect/re-connect, if that happened to be the only monitor
  connection.

  Another side effect is that removing an fd with qmp_remove_fd() is
  effectively delayed until the last monitor connection closes.

  The usage of mon_refcount is also problematic because it's racy.

- Checking runstate_is_running() skips the cleanup unless the VM is
  running and avoids premature cleanup of the fds, but also has the
  side effect of blocking the legitimate removal of an fd via
  qmp_remove_fd() if the VM happens to be in another state.

  This affects qmp_remove_fd() and qmp_query_fdsets() in particular
  because requesting a removal at a bad time (guest stopped) might
  cause an fd to never be removed, or to be removed at a much later
  point in time, causing the query command to continue showing the
  supposedly removed fd/fdset.

Note that file descriptors that *have* been duplicated are owned by
the code that uses them and will be removed after qemu_close() is
called. Therefore we've decided that the best course of action to
avoid the undesired side-effects is to stop managing non-duplicated
file descriptors.

1- efb87c1697 ("monitor: Clean up fd sets on monitor disconnect")
2- ebe52b592d ("monitor: Prevent removing fd from set during init")

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c              | 15 ++++++++-------
 monitor/hmp.c              |  2 --
 monitor/monitor-internal.h |  1 -
 monitor/monitor.c          |  1 -
 monitor/qmp.c              |  2 --
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index bd45a26368..ea85ba1f05 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -175,6 +175,11 @@ static void monitor_fdset_free(MonFdset *mon_fdset)
 
 static void monitor_fdset_free_if_empty(MonFdset *mon_fdset)
 {
+    /*
+     * Only remove an empty fdset. The fds are owned by the user and
+     * should have been removed with qmp_remove_fd(). The dup_fds are
+     * owned by QEMU and should have been removed with qemu_close().
+     */
     if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
         monitor_fdset_free(mon_fdset);
     }
@@ -194,9 +199,7 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
     MonFdsetFd *mon_fdset_fd_next;
 
     QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
-        if ((mon_fdset_fd->removed ||
-                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
-                runstate_is_running()) {
+        if (mon_fdset_fd->removed) {
             monitor_fdset_fd_free(mon_fdset_fd);
         }
     }
@@ -211,7 +214,7 @@ void monitor_fdsets_cleanup(void)
 
     QEMU_LOCK_GUARD(&mon_fdsets_lock);
     QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
-        monitor_fdset_cleanup(mon_fdset);
+        monitor_fdset_free_if_empty(mon_fdset);
     }
 }
 
@@ -484,9 +487,7 @@ void monitor_fdset_dup_fd_remove(int dup_fd)
             if (mon_fdset_fd_dup->fd == dup_fd) {
                 QLIST_REMOVE(mon_fdset_fd_dup, next);
                 g_free(mon_fdset_fd_dup);
-                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
-                    monitor_fdset_cleanup(mon_fdset);
-                }
+                monitor_fdset_free(mon_fdset);
                 return;
             }
         }
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 69c1b7e98a..460e8832f6 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1437,11 +1437,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
             monitor_resume(mon);
         }
         qemu_mutex_unlock(&mon->mon_lock);
-        mon_refcount++;
         break;
 
     case CHR_EVENT_CLOSED:
-        mon_refcount--;
         monitor_fdsets_cleanup();
         break;
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 252de85681..cb628f681d 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -168,7 +168,6 @@ extern bool qmp_dispatcher_co_shutdown;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
-extern int mon_refcount;
 
 extern HMPCommand hmp_cmds[];
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 01ede1babd..db52a9c7ef 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -71,7 +71,6 @@ static GHashTable *monitor_qapi_event_state;
 static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 
 MonitorList mon_list;
-int mon_refcount;
 static bool monitor_destroyed;
 
 Monitor *monitor_cur(void)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index a239945e8d..5e538f34c0 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -466,7 +466,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         data = qmp_greeting(mon);
         qmp_send_response(mon, data);
         qobject_unref(data);
-        mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
         /*
@@ -479,7 +478,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         json_message_parser_destroy(&mon->parser);
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
-        mon_refcount--;
         monitor_fdsets_cleanup();
         break;
     case CHR_EVENT_BREAK:
-- 
2.35.3


