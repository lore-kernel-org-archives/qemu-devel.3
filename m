Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C276D2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X5o-0000ci-Qy; Wed, 23 Oct 2024 04:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5n-0000c9-M9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5m-00083J-58
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729673502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmXiOf165+njZ1qiIARlokKmafDPS99jQJnvPyjMbM8=;
 b=EB421RexkFV5jZHeoDmteSzvjtyQckaSeFEnvA47Yo5K6eXACIzdLkFMgb80slxi5PEoR5
 eZ91qV6d3rudMfqjHNRDk0Ei98HICr3ubEd5ZfZJz4IwcQBAkID6WajhxkjTDMxe6idDYx
 csiCvHA0sz6EHQv9Skwb4xLY6Sor6Zk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-lMz9WMH1MJagKyZaY51w4g-1; Wed,
 23 Oct 2024 04:51:39 -0400
X-MC-Unique: lMz9WMH1MJagKyZaY51w4g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0626E195608A; Wed, 23 Oct 2024 08:51:38 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7F0B1956056; Wed, 23 Oct 2024 08:51:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 8/8] hw/net: improve tracing of eBPF RSS setup
Date: Wed, 23 Oct 2024 09:51:03 +0100
Message-ID: <20241023085103.1980072-9-berrange@redhat.com>
In-Reply-To: <20241023085103.1980072-1-berrange@redhat.com>
References: <20241023085103.1980072-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds more trace events to key eBPF RSS setup operations, and
also distinguishes events from multiple NIC instances.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.46.0


