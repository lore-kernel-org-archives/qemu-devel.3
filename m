Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A73D5B164
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hGT-0007Bn-Sa; Tue, 29 Oct 2024 04:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hGR-0007BY-Vq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hGQ-0003xj-HU
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730189261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVyOAwecPe1+DneilUFhngyUTT3SIJxkG+8rgg9pMfA=;
 b=bbrkp4Ev89gK4l+2BrcndSQPJkfUbQPSOKxDM4iebr79mMNFDjejnIl8qzLAZ2iOEBCZ1p
 mXElMuxcDwFHFAUleMNNLdzhoB0jsQ64J+fgj3SSagN5UKsEyVMc+3zLEEF6f5BnpHFSNA
 cKRJKW5F0nh1xE95DxjqNzMzrROH9l0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-39HM99g5OYS2pzogppFDcg-1; Tue,
 29 Oct 2024 04:07:40 -0400
X-MC-Unique: 39HM99g5OYS2pzogppFDcg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8829A1955D4E
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.36])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 347D41956086; Tue, 29 Oct 2024 08:07:36 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 08/14] hw/net: improve tracing of eBPF RSS setup
Date: Tue, 29 Oct 2024 16:06:59 +0800
Message-ID: <20241029080705.3238-9-jasowang@redhat.com>
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

This adds more trace events to key eBPF RSS setup operations, and
also distinguishes events from multiple NIC instances.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/trace-events | 8 +++++---
 hw/net/virtio-net.c | 9 ++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index 4c6687923e..91a3d0c054 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -394,9 +394,11 @@ virtio_net_announce_notify(void) ""
 virtio_net_announce_timer(int round) "%d"
 virtio_net_handle_announce(int round) "%d"
 virtio_net_post_load_device(void)
-virtio_net_rss_disable(void)
-virtio_net_rss_error(const char *msg, uint32_t value) "%s, value 0x%08x"
-virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes 0x%x, table of %d, key of %d"
+virtio_net_rss_load(void *nic, size_t nfds, void *fds) "nic=%p nfds=%zu fds=%p"
+virtio_net_rss_attach_ebpf(void *nic, int prog_fd) "nic=%p prog-fd=%d"
+virtio_net_rss_disable(void *nic) "nic=%p"
+virtio_net_rss_error(void *nic, const char *msg, uint32_t value) "nic=%p msg=%s, value 0x%08x"
+virtio_net_rss_enable(void *nic, uint32_t p1, uint16_t p2, uint8_t p3) "nic=%p hashes 0x%x, table of %d, key of %d"
 
 # tulip.c
 tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t val) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c08ae55424..60e19bffcb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1241,6 +1241,7 @@ static bool virtio_net_attach_ebpf_to_backend(NICState *nic, int prog_fd)
         return false;
     }
 
+    trace_virtio_net_rss_attach_ebpf(nic, prog_fd);
     return nc->info->set_steering_ebpf(nc, prog_fd);
 }
 
@@ -1297,12 +1298,13 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
             }
         }
 
-        trace_virtio_net_rss_enable(n->rss_data.hash_types,
+        trace_virtio_net_rss_enable(n,
+                                    n->rss_data.hash_types,
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
         virtio_net_detach_ebpf_rss(n);
-        trace_virtio_net_rss_disable();
+        trace_virtio_net_rss_disable(n);
     }
 }
 
@@ -1353,6 +1355,7 @@ static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
     bool ret = false;
 
     if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        trace_virtio_net_rss_load(n, n->nr_ebpf_rss_fds, n->ebpf_rss_fds);
         if (n->ebpf_rss_fds) {
             ret = virtio_net_load_ebpf_fds(n, errp);
         } else {
@@ -1484,7 +1487,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
     virtio_net_commit_rss_config(n);
     return queue_pairs;
 error:
-    trace_virtio_net_rss_error(err_msg, err_value);
+    trace_virtio_net_rss_error(n, err_msg, err_value);
     virtio_net_disable_rss(n);
     return 0;
 }
-- 
2.42.0


