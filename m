Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1166CD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 07:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq6Ok-0007I4-Gq; Fri, 29 Mar 2024 03:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6Of-0007Gg-UH
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6Od-0001BR-Nq
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711696286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P56QHNzwrxOcRr68lM03Rk+oU19INbJ4X5uupxFJH4g=;
 b=it/+OS5ykUEhg8STTxL12B8w2aoD006rHr+ftPc6Bd0PfdGuECDNfTzFFDRBm+sbLrZzcC
 rJuj6/PXhC/YxUNXgmHe9y4AUzOEVosEVtOJTa5A6Ny9nrhLugduejVnN5lXhdipBlxJQG
 Abd0us1CkEKGAtVl/PSlqXfbI8haYC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-qaqyV4L9OgizZuWLimZDDA-1; Fri, 29 Mar 2024 03:11:24 -0400
X-MC-Unique: qaqyV4L9OgizZuWLimZDDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F9D28007A1;
 Fri, 29 Mar 2024 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86107C423E0;
 Fri, 29 Mar 2024 07:11:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 5/5] Revert "tap: setting error appropriately when calling
 net_init_tap_one()"
Date: Fri, 29 Mar 2024 15:11:00 +0800
Message-ID: <20240329071100.31376-6-jasowang@redhat.com>
In-Reply-To: <20240329071100.31376-1-jasowang@redhat.com>
References: <20240329071100.31376-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This reverts commit 46d4d36d0bf2b24b205f2f604f0905db80264eef.

The reverted commit changed to emit warnings instead of errors when
vhost is requested but vhost initialization fails if vhostforce option
is not set.

However, vhostforce is not meant to ignore vhost errors. It was once
introduced as an option to commit 5430a28fe4 ("vhost: force vhost off
for non-MSI guests") to force enabling vhost for non-MSI guests, which
will have worse performance with vhost. The option was deprecated with
commit 1e7398a140 ("vhost: enable vhost without without MSI-X") and
changed to behave identical with the vhost option for compatibility.

Worse, commit bf769f742c ("virtio: del net client if net_init_tap_one
failed") changed to delete the client when vhost fails even when the
failure only results in a warning. The leads to an assertion failure
for the -netdev command line option.

The reverted commit was intended to avoid that the vhost initialization
failure won't result in a corrupted netdev. This problem should have
been fixed by deleting netdev when the initialization fails instead of
ignoring the failure with an arbitrary option. Fortunately, commit
bf769f742c ("virtio: del net client if net_init_tap_one failed"),
mentioned earlier, implements this behavior.

Restore the correct semantics and fix the assertion failure for the
-netdev command line option by reverting the problematic commit.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/vhost_net.h |  3 ---
 net/tap.c               | 22 +++++-----------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index c37aba35e6..c6a5361a2a 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -4,9 +4,6 @@
 #include "net/net.h"
 #include "hw/virtio/vhost-backend.h"
 
-#define VHOST_NET_INIT_FAILED \
-    "vhost-net requested but could not be initialized"
-
 struct vhost_net;
 typedef struct vhost_net VHostNetState;
 
diff --git a/net/tap.c b/net/tap.c
index c698b70475..baaa2f7a9a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -743,11 +743,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
             if (vhostfd == -1) {
-                if (tap->has_vhostforce && tap->vhostforce) {
-                    error_propagate(errp, err);
-                } else {
-                    warn_report_err(err);
-                }
+                error_propagate(errp, err);
                 goto failed;
             }
             if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
@@ -758,13 +754,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
-                if (tap->has_vhostforce && tap->vhostforce) {
-                    error_setg_errno(errp, errno,
-                                     "tap: open vhost char device failed");
-                } else {
-                    warn_report("tap: open vhost char device failed: %s",
-                                strerror(errno));
-                }
+                error_setg_errno(errp, errno,
+                                 "tap: open vhost char device failed");
                 goto failed;
             }
             if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
@@ -777,11 +768,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
-            if (tap->has_vhostforce && tap->vhostforce) {
-                error_setg(errp, VHOST_NET_INIT_FAILED);
-            } else {
-                warn_report(VHOST_NET_INIT_FAILED);
-            }
+            error_setg(errp,
+                       "vhost-net requested but could not be initialized");
             goto failed;
         }
     } else if (vhostfdname) {
-- 
2.42.0


