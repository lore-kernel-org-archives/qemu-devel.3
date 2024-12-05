Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9C2E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJL8O-00056Q-Lr; Thu, 05 Dec 2024 18:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tJL8N-00055q-OE
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:19:47 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tJL8L-0000Ww-0E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:19:47 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:44a0:0:640:8777:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B6D0860A22;
 Fri,  6 Dec 2024 02:19:37 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6b8:b081:19::1:8])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id UJrB130IfiE0-aHGputyz; 
 Fri, 06 Dec 2024 02:19:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733440776;
 bh=ie0pYxJqCCGU8z5mNS5J9GdSLn6s7GFlj7cvYyFRz4Q=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WcFOhnLsQjk//upt9rObi6aOv4cUFqQhoG4hCoL2uCebQz/W36EY3DphXGcDH/4n/
 8aCo0vfzG+Ig8BhfU1H7zjt3UpqG1ee216AIR03XN7ESTuzbwLBctuFa75Fg1XHav3
 xPHhm5vVwI7fr5y+BdVC8V6U0aAVF149zpS88NoA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] os: add an ability to lock memory on_fault
Date: Fri,  6 Dec 2024 02:19:07 +0300
Message-Id: <20241205231909.1161950-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This will be used in the following commits to make it possible to only
lock memory on fault instead of right away.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 include/sysemu/os-posix.h |  2 +-
 include/sysemu/os-win32.h |  3 ++-
 migration/postcopy-ram.c  |  2 +-
 os-posix.c                | 10 ++++++++--
 system/vl.c               |  2 +-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index b881ac6c6f..ce5b3bccf8 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
 void os_set_chroot(const char *path);
 void os_setup_limits(void);
 void os_setup_post(void);
-int os_mlock(void);
+int os_mlock(bool on_fault);
 
 /**
  * qemu_alloc_stack:
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index b82a5d3ad9..cd61d69e10 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
     return false;
 }
 
-static inline int os_mlock(void)
+static inline int os_mlock(bool on_fault)
 {
+    (void)on_fault;
     return -ENOSYS;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a535fd2e30..36ec6a3d75 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -652,7 +652,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     if (enable_mlock) {
-        if (os_mlock() < 0) {
+        if (os_mlock(false) < 0) {
             error_report("mlock: %s", strerror(errno));
             /*
              * It doesn't feel right to fail at this point, we have a valid
diff --git a/os-posix.c b/os-posix.c
index 43f9a43f3f..0948128134 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -327,18 +327,24 @@ void os_set_line_buffering(void)
     setvbuf(stdout, NULL, _IOLBF, 0);
 }
 
-int os_mlock(void)
+int os_mlock(bool on_fault)
 {
 #ifdef HAVE_MLOCKALL
     int ret = 0;
+    int flags = MCL_CURRENT | MCL_FUTURE;
 
-    ret = mlockall(MCL_CURRENT | MCL_FUTURE);
+    if (on_fault) {
+        flags |= MCL_ONFAULT;
+    }
+
+    ret = mlockall(flags);
     if (ret < 0) {
         error_report("mlockall: %s", strerror(errno));
     }
 
     return ret;
 #else
+    (void)on_fault;
     return -ENOSYS;
 #endif
 }
diff --git a/system/vl.c b/system/vl.c
index 54998fdbc7..03819a80ef 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -793,7 +793,7 @@ static QemuOptsList qemu_run_with_opts = {
 static void realtime_init(void)
 {
     if (enable_mlock) {
-        if (os_mlock() < 0) {
+        if (os_mlock(false) < 0) {
             error_report("locking memory failed");
             exit(1);
         }
-- 
2.34.1


