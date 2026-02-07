Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEFCEE0AE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voigU-0003eL-Au; Sat, 07 Feb 2026 08:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifx-0003Lq-On
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifv-0003Fp-IJ
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLH/nCdIPlCaFM08m7QBinpS9H2mQdsoowpj1lshi04=;
 b=dTy3IDNvZlR0BCDGpOpFUAHwcDpeibOrGZEAoSCgsVfkGToLjlhhaM9vb9VCaUg8LbqCNy
 3Nbx31D6WE3l2yxdLERJZoekygKnjKqWFu6DUKqC23Yp+DXZK9hJnaSsTENSsCnbNL25z4
 ftoOns7gzZ1qKtb/DRxZJS2pKsy4wtI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-_OKPVU8wOQWjQxXQBNJH_A-1; Sat,
 07 Feb 2026 08:48:37 -0500
X-MC-Unique: _OKPVU8wOQWjQxXQBNJH_A-1
X-Mimecast-MFC-AGG-ID: _OKPVU8wOQWjQxXQBNJH_A_1770472116
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9613118003FC; Sat,  7 Feb 2026 13:48:36 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72CF230001A8; Sat,  7 Feb 2026 13:48:32 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 08/12] virtio-net: disable backend poll while stopped by
 default
Date: Sat,  7 Feb 2026 21:47:24 +0800
Message-ID: <20260207134728.1495932-8-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jason Wang <jasowang@redhat.com>

When the VM is stopped, reading from the backend (e.g. tap) can pull host
traffic into QEMU queues at a point where the core networking code may flush
or purge queued packets on vmstop to avoid state changes while not running.
This can show up as intermittent packet loss around stop/resume transitions.

Register a virtio-net vm change state handler that disables backend read_poll()
while the VM is stopped, and re-enables it when the VM runs again. Use a
higher priority so it runs early on vmstop, while allowing netfilter pipelines
(e.g. redirector with enable_when_stopped) to re-enable polling explicitly
when they are ready to handle traffic.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c            | 47 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 17ed0ef919..d6d2188863 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -41,6 +41,7 @@
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
 #include "system/replay.h"
+#include "system/runstate.h"
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
@@ -1310,6 +1311,38 @@ static void virtio_net_disable_rss(VirtIONet *n)
     virtio_net_commit_rss_config(n);
 }
 
+static void virtio_net_backend_read_poll_set(VirtIONet *n, bool enable)
+{
+    int i;
+
+    if (!n->nic) {
+        return;
+    }
+
+    for (i = 0; i < (int)n->max_ncs; i++) {
+        NetClientState *frontend = qemu_get_subqueue(n->nic, i);
+        NetClientState *backend = frontend ? frontend->peer : NULL;
+
+        if (backend && backend->info && backend->info->read_poll) {
+            backend->info->read_poll(backend, enable);
+        }
+    }
+}
+
+static void virtio_net_vm_state_change_backend_poll(void *opaque, bool running,
+                                                    RunState state)
+{
+    VirtIONet *n = opaque;
+
+    /*
+     * Prevent backend (e.g. tap) from reading packets while the VM is stopped.
+     * This avoids pulling host->guest traffic into QEMU queues that may be
+     * purged on vmstop, and lets netfilter pipelines (e.g. redirector+buffer)
+     * explicitly re-enable polling when they are ready.
+     */
+    virtio_net_backend_read_poll_set(n, running);
+}
+
 static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
@@ -4047,6 +4080,15 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             n->rss_data.specified_hash_types.on_bits |
             n->rss_data.specified_hash_types.auto_bits;
     }
+
+    /*
+     * Default behavior: use a higher priority than netfilter redirector
+     * handlers (default 0) so that on vmstop we disable first, and redirectors
+     * can re-enable read_poll after this if enable_when_stopped is set.
+     */
+    n->backend_poll_vmstate =
+        qemu_add_vm_change_state_handler_prio(
+            virtio_net_vm_state_change_backend_poll, n, 10);
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev)
@@ -4059,6 +4101,11 @@ static void virtio_net_device_unrealize(DeviceState *dev)
         virtio_net_unload_ebpf(n);
     }
 
+    if (n->backend_poll_vmstate) {
+        qemu_del_vm_change_state_handler(n->backend_poll_vmstate);
+        n->backend_poll_vmstate = NULL;
+    }
+
     /* This will stop vhost backend if appropriate. */
     virtio_net_set_status(vdev, 0);
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index f708355306..a40a7d7cc6 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -218,6 +218,8 @@ struct VirtIONet {
     uint64_t saved_guest_offloads;
     AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
+    /* Keep backend (e.g. tap) from reading while VM is stopped. */
+    VMChangeStateEntry *backend_poll_vmstate;
     bool mtu_bypass_backend;
     /* primary failover device is hidden*/
     bool failover_primary_hidden;
-- 
2.52.0


