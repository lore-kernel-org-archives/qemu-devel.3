Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A0CC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOkc-00008d-5e; Tue, 04 Jun 2024 03:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkZ-0008TE-Qw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkY-0006KZ-5w
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sfcDD9wsGZpiveUClF4yEEzLk1RGaLngadoEU7p+GQ=;
 b=DTHhXwVHygVRyUe5wvppzPByiCTaRqvBgIvk9ImFnZMxokopQnD4XT/54SFBY+dRXSwrcE
 7me2EcBo7zzVI9x3KFf9tg2gaTXsNlJLlj6A4BVPjHsfWclKCinOSrElMg1CAhPg4ZvJAg
 byRDmw3o9l9fAJhHzO83LR8FN5W57gc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-o-h75tCtNkGG-l78eUtWFQ-1; Tue, 04 Jun 2024 03:38:22 -0400
X-MC-Unique: o-h75tCtNkGG-l78eUtWFQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8225885A5BA;
 Tue,  4 Jun 2024 07:38:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE85492BD4;
 Tue,  4 Jun 2024 07:38:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 07/20] virtio-net: Do not propagate ebpf-rss-fds errors
Date: Tue,  4 Jun 2024 15:37:42 +0800
Message-ID: <20240604073755.1859-8-jasowang@redhat.com>
In-Reply-To: <20240604073755.1859-1-jasowang@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Propagating ebpf-rss-fds errors has several problems.

First, it makes device realization fail and disables the fallback to the
conventional eBPF loading.

Second, it leaks memory by making device realization fail without
freeing memory already allocated.

Third, the convention is to set an error when a function returns false,
but virtio_net_load_ebpf_fds() and virtio_net_load_ebpf() returns false
without setting an error, which is confusing.

Remove the propagation to fix these problems.

Fixes: 0524ea0510a3 ("ebpf: Added eBPF initialization by fds.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ff600b3002..3cee2ef3ac 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1329,24 +1329,22 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
-static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
     int ret = true;
     int i = 0;
 
-    ERRP_GUARD();
-
     if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
-        error_setg(errp,
-                  "Expected %d file descriptors but got %d",
-                  EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+        warn_report("Expected %d file descriptors but got %d",
+                    EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
        return false;
    }
 
     for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
-        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i], errp);
-        if (*errp) {
+        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i],
+                                  &error_warn);
+        if (fds[i] < 0) {
             ret = false;
             goto exit;
         }
@@ -1355,7 +1353,7 @@ static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
     ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
 
 exit:
-    if (!ret || *errp) {
+    if (!ret) {
         for (i = 0; i < n->nr_ebpf_rss_fds && fds[i] != -1; i++) {
             close(fds[i]);
         }
@@ -1364,13 +1362,12 @@ exit:
     return ret;
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
+static bool virtio_net_load_ebpf(VirtIONet *n)
 {
     bool ret = false;
 
     if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        if (!(n->ebpf_rss_fds
-                && virtio_net_load_ebpf_fds(n, errp))) {
+        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
             ret = ebpf_rss_load(&n->ebpf_rss);
         }
     }
@@ -3809,7 +3806,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n, errp);
+        virtio_net_load_ebpf(n);
     }
 }
 
-- 
2.42.0


