Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D3DE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVlN-0003ac-8w; Wed, 11 Dec 2024 18:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLVlH-0003Se-JU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:57 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLVlF-0002M9-DQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:55 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:5829:0:640:f281:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 17FC461469;
 Thu, 12 Dec 2024 02:04:51 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:1227::1:8])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id b4xnrS4GamI0-IWDYxWwA; Thu, 12 Dec 2024 02:04:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733958290;
 bh=7GZCvWgBz83cLwycZqDRu6o5tDHlLyTyQSPwIy527ac=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0CG20qFKFz7eryJxG4hCHg2Jzp3/6HcwQf1IumEz4bunrGxwZWL2HiaCxtEnEp+oV
 BMWMI2/SmGdT5bVjESC1wGcp2AtSRhwEzuBjedk4osOslsaMNo9heQ/V8ziIBhIV8k
 1sjmixfD2VEdVc3D0Q2I/0MGIfL4U8W0tJsDMCPE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v3 1/4] os: add an ability to lock memory on_fault
Date: Thu, 12 Dec 2024 02:04:30 +0300
Message-Id: <20241211230433.1371327-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
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


