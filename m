Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0346BC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoPs-0006z6-As; Wed, 21 Feb 2024 10:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcoKw-0001tO-AK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:43 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcnap-0001ny-NX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:29:06 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so613259b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708525741; x=1709130541;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOaNI0V+2Wp7MgiU941gaE2D4c7zy9o6QApRVg0EiP4=;
 b=jtjHRET7ZrB6x+LAvivfnijT/pH32O5SNYKnM09XzrA0XtXSRVueSvzCCKCcuQeuZ2
 IArihp6POEdlHvDm3lQMy1ycqHlAZn8IyxsL/m2JHH+sA4iqDC6AK76ZabZa55n643kP
 pR8VM9NFt4LuNoPNNJIl1na9xzkb6UgcjKqykDFqY0zTR8AUotPWFjxoIyCvpRUf60t4
 3kBa5gU+D6M3L4UjsQY4l3TGfD+uX7VG5abUxpvJEzBorDuD9U5mCJpGiWK/ygICYDmC
 8eHW0UTITtrfYIyR3wMijIQk6p4Bo9F9icsTqFxPEqX9lC549h+HZh2GpNbFS6wgDa8X
 j0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708525741; x=1709130541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOaNI0V+2Wp7MgiU941gaE2D4c7zy9o6QApRVg0EiP4=;
 b=oEctM9x5NEUOFjARrG41lT7u3Os0NlIpUFX80PrUnoJioBVTLVOXMvd3U7gosKTZ1c
 0c5VVuDh22+KfMmHdVhbHT6OFawnbBDjlu9l1yGG/tQqkxTCspMOtbKRVq6d/LJ7esnv
 VtlPGUBiwF9wE36AGSCrE1bkBOedpCN/CYrjqvv+iBfCSdW7u1Astl6J55YxiZqN4oFV
 iuGliVHQoham3lo57Ltja30oG+wNfR+zRIlgfiJ64KwJxlnW6CggH2coGLkuXiwWrW16
 3zLhCGFgzUGvcWszYp1j64116ofNTIKpK0pLisNGfoyVk1uRyMoz8HWaQg35ZZUfkGga
 HAow==
X-Gm-Message-State: AOJu0YwsObiESFhmaIVn1nx0QE2sY7JlpnrNTQDO0tLmnF+M/M6ZGT1O
 Vw0kBBWsIKaYm3flYUAOquA1S42b3Re+gfY9bHvhwjPL9qEFU8xL6Ub0eDZUNldwlLLUvFmso8F
 T4+6HgA==
X-Google-Smtp-Source: AGHT+IFVutvz898v5jVWF8iLEaMOfGKYSMDGjn6l0k28TPuD0nl3kY7eOvwYWOTAdPpt0YtDi7kHgw==
X-Received: by 2002:aa7:8e06:0:b0:6e4:c376:1e57 with SMTP id
 c6-20020aa78e06000000b006e4c3761e57mr248564pfr.2.1708525740461; 
 Wed, 21 Feb 2024 06:29:00 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 p129-20020a625b87000000b006e4762b5f3bsm4480030pfb.172.2024.02.21.06.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 06:29:00 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 1/3] qmp: Switch x-query-virtio-status back to numeric
 encoding
Date: Wed, 21 Feb 2024 22:28:51 +0800
Message-Id: <580203ff6e650450cd6445f31fb6ebea21da56c5.1708525606.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708525606.git.yong.huang@smartx.com>
References: <cover.1708525606.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

x-query-virtio-status returns several sets of virtio feature and
status flags.  It goes back to v7.2.0.

In the initial commit 90c066cd682 (qmp: add QMP command
x-query-virtio-status), we returned them as numbers, using virtio's
well-known binary encoding.

The next commit f3034ad71fc (qmp: decode feature & status bits in
virtio-status) replaced the numbers by objects.  The objects represent
bits QEMU knows symbolically, and any unknown bits numerically just like
before.

Commit 8a8287981d1 (hmp: add virtio commands) added the matching HMP
command "info virtio" (and a few more, which aren't relevant here).

The symbolic representation uses lists of strings.  The string format is
undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readable
explanation".

This symbolic representation is nice for humans.  Machines it can save
the trouble of decoding virtio's well-known binary encoding.

However, we sometimes want to compare features and status bits without
caring for their exact meaning.  Say we want to verify the correctness
of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
QMP command x-query-virtio-status to retrieve vhost-user net device
features, and the "ovs-vsctl list interface" command to retrieve
interface features.  Without commit f3034ad71fc, we could then simply
compare the numbers.  With this commit, we first have to map from the
strings back to the numeric encoding.

Revert the decoding for QMP, but keep it for HMP.

This makes the QMP command easier to use for use cases where we
don't need to decode, like the comparison above.  For use cases
where we need to decode, we replace parsing undocumented strings by
decoding virtio's well-known binary encoding.

Incompatible change; acceptable because x-query-virtio-status
comes without a stability promise.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hw/virtio/virtio-hmp-cmds.c |  25 +++--
 hw/virtio/virtio-qmp.c      |  23 ++---
 qapi/virtio.json            | 192 ++++--------------------------------
 3 files changed, 45 insertions(+), 195 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..721c630ab0 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "virtio-qmp.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
@@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  endianness:              %s\n",
                    s->device_endian);
     monitor_printf(mon, "  status:\n");
-    hmp_virtio_dump_status(mon, s->status);
+    hmp_virtio_dump_status(mon,
+        qmp_decode_status(s->status));
     monitor_printf(mon, "  Guest features:\n");
-    hmp_virtio_dump_features(mon, s->guest_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->guest_features));
     monitor_printf(mon, "  Host features:\n");
-    hmp_virtio_dump_features(mon, s->host_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->host_features));
     monitor_printf(mon, "  Backend features:\n");
-    hmp_virtio_dump_features(mon, s->backend_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->backend_features));
 
     if (s->vhost_dev) {
         monitor_printf(mon, "  VHost:\n");
@@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "    log_size:       %"PRId64"\n",
                        s->vhost_dev->log_size);
         monitor_printf(mon, "    Features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->features));
         monitor_printf(mon, "    Acked features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->acked_features));
         monitor_printf(mon, "    Backend features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->backend_features));
         monitor_printf(mon, "    Protocol features:\n");
-        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
+        hmp_virtio_dump_protocols(mon,
+            qmp_decode_protocols(s->vhost_dev->protocol_features));
     }
 
     qapi_free_VirtioStatus(s);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..1660c17653 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     status->name = g_strdup(vdev->name);
     status->device_id = vdev->device_id;
     status->vhost_started = vdev->vhost_started;
-    status->guest_features = qmp_decode_features(vdev->device_id,
-                                                 vdev->guest_features);
-    status->host_features = qmp_decode_features(vdev->device_id,
-                                                vdev->host_features);
-    status->backend_features = qmp_decode_features(vdev->device_id,
-                                                   vdev->backend_features);
+    status->guest_features = vdev->guest_features;
+    status->host_features = vdev->host_features;
+    status->backend_features = vdev->backend_features;
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
@@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     }
 
     status->num_vqs = virtio_get_num_queues(vdev);
-    status->status = qmp_decode_status(vdev->status);
+    status->status = vdev->status;
     status->isr = vdev->isr;
     status->queue_sel = vdev->queue_sel;
     status->vm_running = vdev->vm_running;
@@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
-        status->vhost_dev->features =
-            qmp_decode_features(vdev->device_id, hdev->features);
-        status->vhost_dev->acked_features =
-            qmp_decode_features(vdev->device_id, hdev->acked_features);
-        status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features);
-        status->vhost_dev->protocol_features =
-            qmp_decode_protocols(hdev->protocol_features);
+        status->vhost_dev->features = hdev->features;
+        status->vhost_dev->acked_features = hdev->acked_features;
+        status->vhost_dev->backend_features = hdev->backend_features;
+        status->vhost_dev->protocol_features = hdev->protocol_features;
         status->vhost_dev->max_queues = hdev->max_queues;
         status->vhost_dev->backend_cap = hdev->backend_cap;
         status->vhost_dev->log_enabled = hdev->log_enabled;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 19c7c36e36..26516fb29c 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -102,10 +102,10 @@
             'n-tmp-sections': 'int',
             'nvqs': 'uint32',
             'vq-index': 'int',
-            'features': 'VirtioDeviceFeatures',
-            'acked-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
-            'protocol-features': 'VhostDeviceProtocols',
+            'features': 'uint64',
+            'acked-features': 'uint64',
+            'backend-features': 'uint64',
+            'protocol-features': 'uint64',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
             'log-enabled': 'bool',
@@ -170,11 +170,11 @@
             'device-id': 'uint16',
             'vhost-started': 'bool',
             'device-endian': 'str',
-            'guest-features': 'VirtioDeviceFeatures',
-            'host-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
+            'guest-features': 'uint64',
+            'host-features': 'uint64',
+            'backend-features': 'uint64',
             'num-vqs': 'int',
-            'status': 'VirtioDeviceStatus',
+            'status': 'uint8',
             'isr': 'uint8',
             'queue-sel': 'uint16',
             'vm-running': 'bool',
@@ -217,41 +217,14 @@
 #          "name": "virtio-crypto",
 #          "started": true,
 #          "device-id": 20,
-#          "backend-features": {
-#              "transports": [],
-#              "dev-features": []
-#          },
+#          "backend-features": 0,
 #          "start-on-kick": false,
 #          "isr": 1,
 #          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
+#          "status": 15,
 #          "num-vqs": 2,
-#          "guest-features": {
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#              ]
-#          },
-#          "host-features": {
-#              "unknown-dev-features": 1073741824,
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
-#          },
+#          "guest-features": 5100273664,
+#          "host-features": 6325010432,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 1,
@@ -279,147 +252,22 @@
 #              "max-queues": 1,
 #              "backend-cap": 2,
 #              "log-size": 0,
-#              "backend-features": {
-#                  "dev-features": [],
-#                  "transports": []
-#              },
+#              "backend-features": 0,
 #              "nvqs": 2,
-#              "protocol-features": {
-#                  "protocols": []
-#              },
+#              "protocol-features": 0,
 #              "vq-index": 0,
 #              "log-enabled": false,
-#              "acked-features": {
-#                  "dev-features": [
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#                  ]
-#              },
-#              "features": {
-#                  "dev-features": [
-#                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#                  ]
-#              }
-#          },
-#          "backend-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
+#              "acked-features": 5100306432,
+#              "features": 13908344832,
 #          },
+#          "backend-features": 6337593319,
 #          "start-on-kick": false,
 #          "isr": 1,
 #          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
+#          "status": 15,
 #          "num-vqs": 3,
-#          "guest-features": {
-#              "dev-features": [
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#             ]
-#          },
-#          "host-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#             ]
-#          },
+#          "guest-features": 5111807911,
+#          "host-features": 6337593319,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 2,
-- 
2.39.3


