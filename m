Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCE8CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Oz-0001ei-JO; Mon, 01 Sep 2025 08:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Oc-0001RF-4P
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3ON-0006DM-QC
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=UZz6/zeejZkwvJJJjKyQ4lcGhhR0a2ff2nsIdivviqI=;
 b=PXeyFia4MJEGMlk8dlveOGi2dVYD++kFCvHd3rqJyPj92r+Tjv5gJWfuTt1EpdJ455Rktu
 HwuhzBa91TQLTgXnE8f5mwsYnUcMiQMnLifMVxq0nyckUrohkmvuZb20rCh2G3zjfO3H39
 vyxIfw4EVRhloQOfvYegllfXGf6sHJY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-ftEDinsyP_2Inn6Oj_l9Jg-1; Mon,
 01 Sep 2025 08:11:58 -0400
X-MC-Unique: ftEDinsyP_2Inn6Oj_l9Jg-1
X-Mimecast-MFC-AGG-ID: ftEDinsyP_2Inn6Oj_l9Jg_1756728718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95ED180048E; Mon,  1 Sep 2025 12:11:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A00519560B4; Mon,  1 Sep 2025 12:11:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 925F521E6774; Mon, 01 Sep 2025 14:11:51 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:11:51 +0200
Resent-Message-ID: <87ecsq2wzc.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:53:00 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF06A21E6774; Mon, 01 Sep 2025 13:53:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 5/5] Revert "tests/qtest: use qos_printf instead of
 g_test_message"
Date: Mon,  1 Sep 2025 13:53:00 +0200
Message-ID: <20250901115300.2541937-6-armbru@redhat.com>
In-Reply-To: <20250901115300.2541937-1-armbru@redhat.com>
References: <20250901115300.2541937-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 tests/qtest/qos-test.c        |  5 -----
 tests/qtest/vhost-user-test.c | 27 +++++++++++++--------------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index abfd4b9512..00f39f33f6 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -328,11 +328,6 @@ static void walk_path(QOSGraphNode *orig_path, int len)
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
index 75cb3e44b2..56472ca709 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -26,7 +26,6 @@
 #include "libqos/virtio-pci.h"
 
 #include "libqos/malloc-pc.h"
-#include "libqos/qgraph_internal.h"
 #include "hw/virtio/virtio-net.h"
 
 #include "standard-headers/linux/vhost_types.h"
@@ -345,7 +344,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     }
 
     if (size != VHOST_USER_HDR_SIZE) {
-        qos_printf("%s: Wrong message size received %d\n", __func__, size);
+        g_test_message("Wrong message size received %d", size);
         return;
     }
 
@@ -356,8 +355,8 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
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
@@ -393,7 +392,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * We don't need to do anything here, the remote is just
          * letting us know it is in charge. Just log it.
          */
-        qos_printf("set_owner: start of session\n");
+        g_test_message("set_owner: start of session\n");
         break;
 
     case VHOST_USER_GET_PROTOCOL_FEATURES:
@@ -419,7 +418,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * the remote end to send this. There is no handshake reply so
          * just log the details for debugging.
          */
-        qos_printf("set_protocol_features: 0x%"PRIx64 "\n", msg.payload.u64);
+        g_test_message("set_protocol_features: 0x%"PRIx64 "\n", msg.payload.u64);
         break;
 
         /*
@@ -427,11 +426,11 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
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
@@ -464,7 +463,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_CALL:
         /* consume the fd */
         if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
-            qos_printf("call fd: %d, do not set non-blocking\n", fd);
+            g_test_message("call fd: %d, do not set non-blocking\n", fd);
             break;
         }
         /*
@@ -510,12 +509,12 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
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
 
@@ -539,7 +538,7 @@ static const char *init_hugepagefs(void)
     }
 
     if (access(path, R_OK | W_OK | X_OK)) {
-        qos_printf("access on path (%s): %s", path, strerror(errno));
+        g_test_message("access on path (%s): %s", path, strerror(errno));
         g_test_fail();
         return NULL;
     }
@@ -549,13 +548,13 @@ static const char *init_hugepagefs(void)
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
2.49.0



