Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5846CC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTS-0003KA-12; Fri, 21 Jun 2024 13:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTR-0003Js-Cd
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:57 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTP-0003Kw-PB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 774851F7F2;
 Fri, 21 Jun 2024 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jN1SnHdsTSkY/VL7VN47UOFrwpUi7Yv/L/E/snGVRF0=;
 b=h7SCQlitth1JxjgOFpt4qJv+U7Zql1frMn/6r9rtdxotKIRGs8GyhnNmfQCORLfv+nk0SO
 5XTf1q4rA6WFmvw7XyukJTA0s0X0Znms1+cntpnKCyiiRxzXJOpyn8ys/v3FU/PTlrLdme
 ABRbdBReCtWgjDILTWj2ho7D35MSqsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jN1SnHdsTSkY/VL7VN47UOFrwpUi7Yv/L/E/snGVRF0=;
 b=kYR7dSj8mnRvlXzxs3TF37DPRuYzkq5ewaBjjqOdE/HEFcp1gZrm5+3mMo+2rxuWGToQHV
 M363OjJeKvUiyzDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jN1SnHdsTSkY/VL7VN47UOFrwpUi7Yv/L/E/snGVRF0=;
 b=h7SCQlitth1JxjgOFpt4qJv+U7Zql1frMn/6r9rtdxotKIRGs8GyhnNmfQCORLfv+nk0SO
 5XTf1q4rA6WFmvw7XyukJTA0s0X0Znms1+cntpnKCyiiRxzXJOpyn8ys/v3FU/PTlrLdme
 ABRbdBReCtWgjDILTWj2ho7D35MSqsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jN1SnHdsTSkY/VL7VN47UOFrwpUi7Yv/L/E/snGVRF0=;
 b=kYR7dSj8mnRvlXzxs3TF37DPRuYzkq5ewaBjjqOdE/HEFcp1gZrm5+3mMo+2rxuWGToQHV
 M363OjJeKvUiyzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CF8813AAA;
 Fri, 21 Jun 2024 17:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iNsUBW2+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:54:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/28] monitor: Report errors from monitor_fdset_dup_fd_add
Date: Fri, 21 Jun 2024 14:54:15 -0300
Message-Id: <20240621175434.31180-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
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

I'm keeping the EACCES because callers expect to be able to look at
errno.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/monitor/monitor.h |  2 +-
 monitor/fds.c             | 10 +++++++++-
 stubs/fdset.c             |  2 +-
 util/osdep.c              | 10 +---------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index fd9b3f538c..c3740ec616 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -51,7 +51,7 @@ int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
 
 AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
                                 const char *opaque, Error **errp);
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags);
+int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 
 void monitor_register_hmp(const char *name, bool info,
diff --git a/monitor/fds.c b/monitor/fds.c
index e7619a6103..d8c6b395b0 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -409,9 +409,10 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     return fdinfo;
 }
 
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
+int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp)
 {
 #ifdef _WIN32
+    error_setg(errp, "Platform does not support fd passing (fdset)");
     return -ENOENT;
 #else
     MonFdset *mon_fdset;
@@ -431,6 +432,8 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
         QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
             mon_fd_flags = fcntl(mon_fdset_fd->fd, F_GETFL);
             if (mon_fd_flags == -1) {
+                error_setg(errp, "Failed to read file status flags for fd=%d",
+                           mon_fdset_fd->fd);
                 return -1;
             }
 
@@ -442,11 +445,15 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
 
         if (fd == -1) {
             errno = EACCES;
+            error_setg(errp,
+                       "Failed to find file descriptor with matching flags=0x%x",
+                       flags);
             return -1;
         }
 
         dup_fd = qemu_dup_flags(fd, flags);
         if (dup_fd == -1) {
+            error_setg(errp, "Failed to dup() given file descriptor fd=%d", fd);
             return -1;
         }
 
@@ -456,6 +463,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
         return dup_fd;
     }
 
+    error_setg(errp, "Failed to find fdset /dev/fdset/%" PRId64, fdset_id);
     errno = ENOENT;
     return -1;
 #endif
diff --git a/stubs/fdset.c b/stubs/fdset.c
index 389e368a29..2950fd91fd 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -3,7 +3,7 @@
 #include "monitor/monitor.h"
 #include "../monitor/monitor-internal.h"
 
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
+int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp)
 {
     errno = ENOSYS;
     return -1;
diff --git a/util/osdep.c b/util/osdep.c
index 756de9a745..5bbfdfac7a 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -310,7 +310,6 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
     /* Attempt dup of fd from fd set */
     if (strstart(name, "/dev/fdset/", &fdset_id_str)) {
         int64_t fdset_id;
-        int dupfd;
 
         fdset_id = qemu_parse_fdset(fdset_id_str);
         if (fdset_id == -1) {
@@ -319,14 +318,7 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
             return -1;
         }
 
-        dupfd = monitor_fdset_dup_fd_add(fdset_id, flags);
-        if (dupfd == -1) {
-            error_setg_errno(errp, errno, "Could not dup FD for %s flags %x",
-                             name, flags);
-            return -1;
-        }
-
-        return dupfd;
+        return monitor_fdset_dup_fd_add(fdset_id, flags, errp);
     }
 #endif
 
-- 
2.35.3


