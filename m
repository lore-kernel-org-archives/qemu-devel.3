Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BB9C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 13:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tax89-00081P-Mu; Thu, 23 Jan 2025 08:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tax82-00080a-F1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:20:15 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tax7x-00024p-B5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:20:14 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c00:2790:0:640:fde4:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 41ACF60A89;
 Thu, 23 Jan 2025 16:20:01 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b702::1:22])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sJYg2w0IhCg0-zYl4iIUk; Thu, 23 Jan 2025 16:20:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1737638400;
 bh=tTZNB9u+ufZxp8DcX+4zszzoLS0jg6bRt+4GjMlP+Es=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=X+wGuTKGAwNMe+3o7dgswTwoSBD2rtDZmeMV1oUHzt28A7JmADlXn3dawbL2VTudt
 UZfkS57ZJ1XOsa1Dzg13vWQxzaDiu4rDPlaxiJy0cqoCYeNXazsvPRw2ZUatcDpGO1
 M/R8fEMH3+djLzN+84rK+zfds8fAP6XREjaejgMY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v4 1/4] os: add an ability to lock memory on_fault
Date: Thu, 23 Jan 2025 16:19:41 +0300
Message-Id: <20250123131944.391886-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
References: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 include/system/os-posix.h |  2 +-
 include/system/os-win32.h |  3 ++-
 migration/postcopy-ram.c  |  2 +-
 os-posix.c                | 10 ++++++++--
 system/vl.c               |  2 +-
 5 files changed, 13 insertions(+), 6 deletions(-)

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
index 9cce55ff2f..48afb2990d 100644
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
index c567826718..09333a48c5 100644
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


