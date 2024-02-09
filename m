Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4B8C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVN-0002Yy-Hl; Fri, 09 Feb 2024 09:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVM-0002XR-1O
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVK-0004Cy-9P
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptL+oHXVBy8DlXSzsfQVfnlB3RTXWG51Oa2V+tLPA8w=;
 b=KwS07WUqYTW7FTOe3Q8pClHXrAfu91z/5MoBHS5FxGdvxQ/ILC4hn/7xLHFx7yn4NweL+o
 z37LgWO3bd8KPsNBbzzl2fvlSrZ9OS0PUO1HfGtu2URSzzz63U4beSPIkgKzp0jgxoC3WS
 7df3g1teTo1r36ceUcwpUP3D2QFb5iE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-ho0vSErHNvKzAYTubmMZvA-1; Fri, 09 Feb 2024 09:05:18 -0500
X-MC-Unique: ho0vSErHNvKzAYTubmMZvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0711085A597;
 Fri,  9 Feb 2024 14:05:17 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A720112A1;
 Fri,  9 Feb 2024 14:05:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 03/17] qemu_init: increase NOFILE soft limit on POSIX
Date: Fri,  9 Feb 2024 14:04:51 +0000
Message-ID: <20240209140505.2536635-4-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

In many configurations, e.g. multiple vNICs with multiple queues or
with many Ceph OSDs, the default soft limit of 1024 is not enough.
QEMU is supposed to work fine with file descriptors >= 1024 and does
not use select() on POSIX. Bump the soft limit to the allowed hard
limit to avoid issues with the aforementioned configurations.

Of course the limit could be raised from the outside, but the man page
of systemd.exec states about 'LimitNOFILE=':

> Don't use.
> [...]
> Typically applications should increase their soft limit to the hard
> limit on their own, if they are OK with working with file
> descriptors above 1023,

If the soft limit is already the same as the hard limit, avoid the
superfluous setrlimit call. This can avoid a warning with a strict
seccomp filter blocking setrlimit if NOFILE was already raised before
executing QEMU.

Buglink: https://bugzilla.proxmox.com/show_bug.cgi?id=4507
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/sysemu/os-posix.h |  1 +
 include/sysemu/os-win32.h |  5 +++++
 os-posix.c                | 22 ++++++++++++++++++++++
 system/vl.c               |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index dff32ae185..b881ac6c6f 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -51,6 +51,7 @@ bool is_daemonized(void);
 void os_daemonize(void);
 bool os_set_runas(const char *user_id);
 void os_set_chroot(const char *path);
+void os_setup_limits(void);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 1047d260cb..b82a5d3ad9 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -128,6 +128,11 @@ static inline int os_mlock(void)
     return -ENOSYS;
 }
 
+static inline void os_setup_limits(void)
+{
+    return;
+}
+
 #define fsync _commit
 
 #if !defined(lseek)
diff --git a/os-posix.c b/os-posix.c
index 52ef6990ff..a4284e2c07 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/resource.h>
 #include <sys/wait.h>
 #include <pwd.h>
 #include <grp.h>
@@ -256,6 +257,27 @@ void os_daemonize(void)
     }
 }
 
+void os_setup_limits(void)
+{
+    struct rlimit nofile;
+
+    if (getrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to query NOFILE limit: %s", strerror(errno));
+        return;
+    }
+
+    if (nofile.rlim_cur == nofile.rlim_max) {
+        return;
+    }
+
+    nofile.rlim_cur = nofile.rlim_max;
+
+    if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to set NOFILE limit: %s", strerror(errno));
+        return;
+    }
+}
+
 void os_setup_post(void)
 {
     int fd = 0;
diff --git a/system/vl.c b/system/vl.c
index 2a0bd08ff1..95cd2d91c4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2778,6 +2778,8 @@ void qemu_init(int argc, char **argv)
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
+    os_setup_limits();
+
     qemu_init_arch_modules();
 
     qemu_init_subsystems();
-- 
2.43.0


