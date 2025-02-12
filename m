Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2364BC021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDu6-00027I-SX; Wed, 12 Feb 2025 09:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDu4-00026d-A2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:52 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDu2-00080U-Di
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:51 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a4:0:640:7b31:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5016060D7D;
 Wed, 12 Feb 2025 17:39:47 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b518::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ddQHZB0Id8c0-4FitjubQ; Wed, 12 Feb 2025 17:39:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739371186;
 bh=ycc6hH2EYxa4YpjcKhOHgF7XnHb2B2jrBSSSENpPfPA=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lZ01fUfGovtA6cL5nBGWWD19GUurpXpfqiPlHq0VXr//6lijYDYn+zxipfbKK5uzd
 4UhN6Xtq9llhacXf4RaxSTnclloz/56w6psw0GFSL2oPZnuVjIBmicbY4CmH8/5jX9
 MfieIXIemIJ8pCq70uEzwcfaK+RJV90U8X/0pXCM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH v5 1/4] os: add an ability to lock memory on_fault
Date: Wed, 12 Feb 2025 17:39:17 +0300
Message-Id: <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 include/system/os-posix.h |  2 +-
 include/system/os-win32.h |  3 ++-
 meson.build               |  6 ++++++
 migration/postcopy-ram.c  |  2 +-
 os-posix.c                | 14 ++++++++++++--
 system/vl.c               |  2 +-
 6 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/system/os-posix.h b/include/system/os-posix.h
index b881ac6c6f..ce5b3bccf8 100644
--- a/include/system/os-posix.h
+++ b/include/system/os-posix.h
@@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
 void os_set_chroot(const char *path);
 void os_setup_limits(void);
 void os_setup_post(void);
-int os_mlock(void);
+int os_mlock(bool on_fault);
 
 /**
  * qemu_alloc_stack:
diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index b82a5d3ad9..cd61d69e10 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
     return false;
 }
 
-static inline int os_mlock(void)
+static inline int os_mlock(bool on_fault)
 {
+    (void)on_fault;
     return -ENOSYS;
 }
 
diff --git a/meson.build b/meson.build
index 18cf9e2913..59953cbe6b 100644
--- a/meson.build
+++ b/meson.build
@@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
     return mlockall(MCL_FUTURE);
   }'''))
 
+config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
+  #include <sys/mman.h>
+  int main(void) {
+      return mlockall(MCL_FUTURE | MCL_ONFAULT);
+  }'''))
+
 have_l2tpv3 = false
 if get_option('l2tpv3').allowed() and have_system
   have_l2tpv3 = cc.has_type('struct mmsghdr',
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6a6da6ba7f..fc4d8a10df 100644
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
index 9cce55ff2f..17b144c0a2 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -327,18 +327,28 @@ void os_set_line_buffering(void)
     setvbuf(stdout, NULL, _IOLBF, 0);
 }
 
-int os_mlock(void)
+int os_mlock(bool on_fault)
 {
 #ifdef HAVE_MLOCKALL
     int ret = 0;
+    int flags = MCL_CURRENT | MCL_FUTURE;
 
-    ret = mlockall(MCL_CURRENT | MCL_FUTURE);
+#ifdef HAVE_MLOCK_ONFAULT
+    if (on_fault) {
+        flags |= MCL_ONFAULT;
+    }
+#else
+    (void)on_fault;
+#endif
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
index 9c6942c6cf..e94fc7ea35 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -797,7 +797,7 @@ static QemuOptsList qemu_run_with_opts = {
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


