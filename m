Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46B8C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKre-0003SU-Cq; Sat, 15 Mar 2025 02:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrL-0003EZ-UP; Sat, 15 Mar 2025 02:19:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrH-0003GT-QW; Sat, 15 Mar 2025 02:18:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C1A9FF9D6;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6377D1CAC3F;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 43174558C3; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 10/51] hw/net: Fix NULL dereference with software RSS
Date: Sat, 15 Mar 2025 09:17:16 +0300
Message-Id: <20250315061801.622606-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

When an eBPF program cannot be attached, virtio_net_load_ebpf() returns
false, and virtio_net_device_realize() enters the code path to handle
errors because of this, but it causes NULL dereference because no error
is generated.

Change virtio_net_load_ebpf() to return false only when a fatal error
occurred.

Fixes: b5900dff14e5 ("hw/net: report errors from failing to use eBPF RSS FDs")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-software-v1-1-9e5161b534d8@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit bc82af6b0dcb0933e72640851fdd2594f822b23e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6e8c51a2db..f8c6ccbec4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1352,18 +1352,25 @@ exit:
 
 static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
-    bool ret = false;
+    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        return true;
+    }
 
-    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        trace_virtio_net_rss_load(n, n->nr_ebpf_rss_fds, n->ebpf_rss_fds);
-        if (n->ebpf_rss_fds) {
-            ret = virtio_net_load_ebpf_fds(n, errp);
-        } else {
-            ret = ebpf_rss_load(&n->ebpf_rss, errp);
-        }
+    trace_virtio_net_rss_load(n, n->nr_ebpf_rss_fds, n->ebpf_rss_fds);
+
+    /*
+     * If user explicitly gave QEMU RSS FDs to use, then
+     * failing to use them must be considered a fatal
+     * error. If no RSS FDs were provided, QEMU is trying
+     * eBPF on a "best effort" basis only, so report a
+     * warning and allow fallback to software RSS.
+     */
+    if (n->ebpf_rss_fds) {
+        return virtio_net_load_ebpf_fds(n, errp);
     }
 
-    return ret;
+    ebpf_rss_load(&n->ebpf_rss, &error_warn);
+    return true;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3801,23 +3808,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        Error *err = NULL;
-        if (!virtio_net_load_ebpf(n, &err)) {
-            /*
-             * If user explicitly gave QEMU RSS FDs to use, then
-             * failing to use them must be considered a fatal
-             * error. If no RSS FDs were provided, QEMU is trying
-             * eBPF on a "best effort" basis only, so report a
-             * warning and allow fallback to software RSS.
-             */
-            if (n->ebpf_rss_fds) {
-                error_propagate(errp, err);
-            } else {
-                warn_report("unable to load eBPF RSS: %s",
-                            error_get_pretty(err));
-                error_free(err);
-            }
-        }
+        virtio_net_load_ebpf(n, errp);
     }
 }
 
-- 
2.39.5


