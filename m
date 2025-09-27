Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A3CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Qr2-00047z-2D; Sat, 27 Sep 2025 05:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qqy-000479-AE; Sat, 27 Sep 2025 05:04:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qql-0006sS-03; Sat, 27 Sep 2025 05:04:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6BDD415855A;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C751291577;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 05/16] Revert "tests/qtest: use qos_printf instead of
 g_test_message"
Date: Sat, 27 Sep 2025 12:02:49 +0300
Message-ID: <20250927090304.2901324-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Markus Armbruster <armbru@redhat.com>

This reverts commit 30ea13e9d97dcbd4ea541ddf9e8857fa1d5cb30f.

Also rewrites qos_printf() calls added later.

"make check" prints many lines like

    stdout: 138: UNKNOWN:     # # qos_test running single test in subprocess
    stdout: 139: UNKNOWN:     # # set_protocol_features: 0x42
    stdout: 140: UNKNOWN:     # # set_owner: start of session
    stdout: 141: UNKNOWN:     # # vhost-user: un-handled message: 14
    stdout: 142: UNKNOWN:     # # vhost-user: un-handled message: 14
    stdout: 143: UNKNOWN:     # # set_vring(0)=enabled
    stdout: 144: UNKNOWN:     # # set_vring(1)=enabled
    stdout: 145: UNKNOWN:     # # set_vring(0)=enabled
    stdout: 146: UNKNOWN:     # # set_vring(1)=enabled
    stdout: 147: UNKNOWN:     # # set_vring(0)=enabled
    stdout: 148: UNKNOWN:     # # set_vring(1)=enabled
    stdout: 149: UNKNOWN:     # # set_vring(0)=enabled
    stdout: 150: UNKNOWN:     # # set_vring(1)=enabled
    stdout: 151: UNKNOWN:     # # set_vring(0)=enabled
    stdout: 152: UNKNOWN:     # # set_vring(1)=enabled
    stdout: 153: UNKNOWN:     # # set_vring_num: 0/256
    stdout: 154: UNKNOWN:     # # set_vring_addr: 0x7f9060000000/0x7f905ffff000/0x7f9060001000

Turns out this is qos-test, and the culprit is a commit meant to ease
debugging.  Revert it until a better solution is found.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250728145747.3165315-1-armbru@redhat.com>
[Commit message clarified]
(cherry picked from commit c9a1ea9c52e6462ad5c7814f3abd65baa69dc4ce)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 5da4091ec3..566cb3b00b 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -321,11 +321,6 @@ static void walk_path(QOSGraphNode *orig_path, int len)
 int main(int argc, char **argv, char** envp)
 {
     g_test_init(&argc, &argv, NULL);
-
-    if (g_test_subprocess()) {
-        qos_printf("qos_test running single test in subprocess\n");
-    }
-
     if (g_test_verbose()) {
         qos_printf("ENVIRONMENT VARIABLES: {\n");
         for (char **env = envp; *env != 0; env++) {
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 6d9e53ff07..9bfd7f7217 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -26,7 +26,6 @@
 #include "libqos/virtio-pci.h"
 
 #include "libqos/malloc-pc.h"
-#include "libqos/qgraph_internal.h"
 #include "hw/virtio/virtio-net.h"
 
 #include "standard-headers/linux/vhost_types.h"
@@ -338,7 +337,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     }
 
     if (size != VHOST_USER_HDR_SIZE) {
-        qos_printf("%s: Wrong message size received %d\n", __func__, size);
+        g_test_message("Wrong message size received %d", size);
         return;
     }
 
@@ -349,8 +348,8 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         p += VHOST_USER_HDR_SIZE;
         size = qemu_chr_fe_read_all(chr, p, msg.size);
         if (size != msg.size) {
-            qos_printf("%s: Wrong message size received %d != %d\n",
-                       __func__, size, msg.size);
+            g_test_message("Wrong message size received %d != %d",
+                           size, msg.size);
             goto out;
         }
     }
@@ -386,7 +385,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * We don't need to do anything here, the remote is just
          * letting us know it is in charge. Just log it.
          */
-        qos_printf("set_owner: start of session\n");
+        g_test_message("set_owner: start of session\n");
         break;
 
     case VHOST_USER_GET_PROTOCOL_FEATURES:
@@ -412,7 +411,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * the remote end to send this. There is no handshake reply so
          * just log the details for debugging.
          */
-        qos_printf("set_protocol_features: 0x%"PRIx64 "\n", msg.payload.u64);
+        g_test_message("set_protocol_features: 0x%"PRIx64 "\n", msg.payload.u64);
         break;
 
         /*
@@ -420,11 +419,11 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * address of the vrings but we can simply report them.
          */
     case VHOST_USER_SET_VRING_NUM:
-        qos_printf("set_vring_num: %d/%d\n",
+        g_test_message("set_vring_num: %d/%d\n",
                    msg.payload.state.index, msg.payload.state.num);
         break;
     case VHOST_USER_SET_VRING_ADDR:
-        qos_printf("set_vring_addr: 0x%"PRIx64"/0x%"PRIx64"/0x%"PRIx64"\n",
+        g_test_message("set_vring_addr: 0x%"PRIx64"/0x%"PRIx64"/0x%"PRIx64"\n",
                    msg.payload.addr.avail_user_addr,
                    msg.payload.addr.desc_user_addr,
                    msg.payload.addr.used_user_addr);
@@ -457,7 +456,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_CALL:
         /* consume the fd */
         if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
-            qos_printf("call fd: %d, do not set non-blocking\n", fd);
+            g_test_message("call fd: %d, do not set non-blocking\n", fd);
             break;
         }
         /*
@@ -503,12 +502,12 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * fully functioning vhost-user we would enable/disable the
          * vring monitoring.
          */
-        qos_printf("set_vring(%d)=%s\n", msg.payload.state.index,
+        g_test_message("set_vring(%d)=%s\n", msg.payload.state.index,
                    msg.payload.state.num ? "enabled" : "disabled");
         break;
 
     default:
-        qos_printf("vhost-user: un-handled message: %d\n", msg.request);
+        g_test_message("vhost-user: un-handled message: %d\n", msg.request);
         break;
     }
 
@@ -532,7 +531,7 @@ static const char *init_hugepagefs(void)
     }
 
     if (access(path, R_OK | W_OK | X_OK)) {
-        qos_printf("access on path (%s): %s", path, strerror(errno));
+        g_test_message("access on path (%s): %s", path, strerror(errno));
         g_test_fail();
         return NULL;
     }
@@ -542,13 +541,13 @@ static const char *init_hugepagefs(void)
     } while (ret != 0 && errno == EINTR);
 
     if (ret != 0) {
-        qos_printf("statfs on path (%s): %s", path, strerror(errno));
+        g_test_message("statfs on path (%s): %s", path, strerror(errno));
         g_test_fail();
         return NULL;
     }
 
     if (fs.f_type != HUGETLBFS_MAGIC) {
-        qos_printf("Warning: path not on HugeTLBFS: %s", path);
+        g_test_message("Warning: path not on HugeTLBFS: %s", path);
         g_test_fail();
         return NULL;
     }
-- 
2.47.3


