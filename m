Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92181D5B16A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hGP-0007BA-Pm; Tue, 29 Oct 2024 04:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hGN-0007B1-EN
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hGM-0003xB-0Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730189255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2suDZfQpDqpwj6AS4dJJjae/UH5ptWRp3zP+J83GOs=;
 b=S4D2V5RVhfFhvZS+mwP5tHakufMuOZFZyCZP/LC9ZpJIWLC3HHQ88+5ZSFXtpOWbsnmKOL
 PyFORHhBsiB+2IwYXuB0aAADOAMT5tNNOTP5PqZQFtvZMw2qS6194kWYAzKCWgZs6to+Wu
 lrT+s6R8K54znhtdR3+3DRbYJMmAVP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-AV2E5m3vN3GbVJ5q5ECWHQ-1; Tue,
 29 Oct 2024 04:07:33 -0400
X-MC-Unique: AV2E5m3vN3GbVJ5q5ECWHQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D79F1956048
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.36])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0D751956086; Tue, 29 Oct 2024 08:07:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 06/14] hw/net: report errors from failing to use eBPF RSS FDs
Date: Tue, 29 Oct 2024 16:06:57 +0800
Message-ID: <20241029080705.3238-7-jasowang@redhat.com>
In-Reply-To: <20241029080705.3238-1-jasowang@redhat.com>
References: <20241029080705.3238-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

If the user/mgmt app passed in a set of pre-opened FDs for eBPF RSS,
then it is expecting QEMU to use them. Any failure to do so must be
considered a fatal error and propagated back up the stack, otherwise
deployment mistakes will not be detectable in a prompt manner. When
not using pre-opened FDs, then eBPF RSS is tried on a "best effort"
basis only and thus fallback to software RSS is valid.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 289fba8152..c08ae55424 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1316,28 +1316,27 @@ static void virtio_net_disable_rss(VirtIONet *n)
     virtio_net_commit_rss_config(n);
 }
 
-static bool virtio_net_load_ebpf_fds(VirtIONet *n)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
     int ret = true;
     int i = 0;
 
     if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
-        warn_report("Expected %d file descriptors but got %d",
-                    EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
-       return false;
-   }
+        error_setg(errp, "Expected %d file descriptors but got %d",
+                   EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+        return false;
+    }
 
     for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
-        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i],
-                                  &error_warn);
+        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i], errp);
         if (fds[i] < 0) {
             ret = false;
             goto exit;
         }
     }
 
-    ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3], NULL);
+    ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3], errp);
 
 exit:
     if (!ret) {
@@ -1349,13 +1348,15 @@ exit:
     return ret;
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
     bool ret = false;
 
     if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
-            ret = ebpf_rss_load(&n->ebpf_rss, NULL);
+        if (n->ebpf_rss_fds) {
+            ret = virtio_net_load_ebpf_fds(n, errp);
+        } else {
+            ret = ebpf_rss_load(&n->ebpf_rss, errp);
         }
     }
 
@@ -3761,7 +3762,23 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
+        Error *err = NULL;
+        if (!virtio_net_load_ebpf(n, &err)) {
+            /*
+             * If user explicitly gave QEMU RSS FDs to use, then
+             * failing to use them must be considered a fatal
+             * error. If no RSS FDs were provided, QEMU is trying
+             * eBPF on a "best effort" basis only, so report a
+             * warning and allow fallback to software RSS.
+             */
+            if (n->ebpf_rss_fds) {
+                error_propagate(errp, err);
+            } else {
+                warn_report("unable to load eBPF RSS: %s",
+                            error_get_pretty(err));
+                error_free(err);
+            }
+        }
     }
 }
 
-- 
2.42.0


