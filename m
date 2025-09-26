Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41288CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27qS-0008Bm-MO; Fri, 26 Sep 2025 08:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27qO-0008AV-MK; Fri, 26 Sep 2025 08:46:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27q9-0006eP-JP; Fri, 26 Sep 2025 08:46:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC5C4157F4B;
 Fri, 26 Sep 2025 15:45:39 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5BF70290F09;
 Fri, 26 Sep 2025 15:45:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 03/38] ui/vnc: Fix crash when specifying [vnc] without
 id in the config file
Date: Fri, 26 Sep 2025 15:45:03 +0300
Message-ID: <20250926124540.2221746-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when there is a [vnc] section in the config
file that does not have an "id = ..." line:

 $ echo "[vnc]" > /tmp/qemu.conf
 $ ./qemu-system-x86_64 -readconfig /tmp/qemu.conf
 qemu-system-x86_64: ../../devel/qemu/ui/vnc.c:4347: vnc_init_func:
  Assertion `id' failed.
 Aborted (core dumped)

The required "id" is only set up automatically while parsing the command
line, but not when reading the options from the config file.
Thus let's move code that automatically adds the id (if it does not
exist yet) to the init function that needs the id for the first time,
replacing the assert() statement there.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2836
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250821145130.845104-1-thuth@redhat.com>
(cherry picked from commit 38dd513263d814dc3cf554b899c118a46ca77577)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index a6bf8442d5..6a26f05daa 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4265,8 +4265,9 @@ void vnc_display_add_client(const char *id, int csock, bool skipauth)
     }
 }
 
-static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)
+static char *vnc_auto_assign_id(QemuOpts *opts)
 {
+    QemuOptsList *olist = qemu_find_opts("vnc");
     int i = 2;
     char *id;
 
@@ -4276,23 +4277,18 @@ static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)
         id = g_strdup_printf("vnc%d", i++);
     }
     qemu_opts_set_id(opts, id);
+
+    return id;
 }
 
 void vnc_parse(const char *str)
 {
     QemuOptsList *olist = qemu_find_opts("vnc");
     QemuOpts *opts = qemu_opts_parse_noisily(olist, str, !is_help_option(str));
-    const char *id;
 
     if (!opts) {
         exit(1);
     }
-
-    id = qemu_opts_id(opts);
-    if (!id) {
-        /* auto-assign id if not present */
-        vnc_auto_assign_id(olist, opts);
-    }
 }
 
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -4300,7 +4296,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     Error *local_err = NULL;
     char *id = (char *)qemu_opts_id(opts);
 
-    assert(id);
+    if (!id) {
+        /* auto-assign id if not present */
+        id = vnc_auto_assign_id(opts);
+    }
+
     vnc_display_init(id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.47.3


