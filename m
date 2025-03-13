Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2FBC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscUB-0006X5-8G; Thu, 13 Mar 2025 02:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscU7-0006VK-QV
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:03 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscU5-00065z-GJ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:03 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22548a28d0cso17021255ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848958; x=1742453758;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qeez6nQnPC+h3f/6T7AEax1CgK0z5iWn6bN3521NMLM=;
 b=imeOaQgCa5h6bVULUE1OZHvbPjJq4R2Hz4MmNYtgWQqjgdJ3BsQz/VAdC6BBDN/3n5
 1gg1FceEjN1dWyKfHb7Xq+MQ0pypyVsuUPrF6Ht1QvCfVUhpiBeOlyorAYX/k1rgQ0uF
 c8NKiGvU683JLttSEmMmDMG0WbXAp81fXNqtD9FLm91b1Gplqi+eMfOgo7Gs88sulYOI
 hO5KMiBtbvfcxG6+ejZ4FUITETNVw20/7ZDZVk/VwSXh2kTEzGaT40dYAfJJgXWPJJ6M
 aRcyMz3XZJW91rvHf+RYHoN4F/SXaRqBuqd8uHe6hzSUVTdhWlefgI5YSu7Oludr841r
 6JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848958; x=1742453758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qeez6nQnPC+h3f/6T7AEax1CgK0z5iWn6bN3521NMLM=;
 b=WEiiEJl/TnmHBILL+T421h3rkBEob/qOcNk40gWSeuXfCXI4jzSHX9Ocuq+89mOHPw
 x4UfvhrUlsZxWaaQrnB5/cEBOTIFUPxcJ0vWan1Nr/TSJb87l0Tc17IB+Bn1ObHLu1WI
 ZMeaAKK4pDfz3V6DPO9ocsJ0eGkCTuw5GAkMKSSRHCEH2MTYuSubQ9Ws64SSFvx5Xfr6
 OnSHvVSgbjow3UTeSmH2OO/8uGt8/M98hszgEf3lLECSfr/8LqMsyfwoN0mmMsR8altK
 BIGJiv+NBrupaKicsPGUNdM2TZ/Qx98V6E+m2COuJHchA0NFWApRhVQU9iMSGEipDeOX
 uaGA==
X-Gm-Message-State: AOJu0Yyefc1sR57I2hiTXUfpYSZLvtfo2EqkYs6QWrPSI59plQgMMgxv
 WwlJjAefS462nCZ8d0aU4F959W6KGzC/kJPL4vy35JaH6H6dGTeCEXOfBCgN5/g=
X-Gm-Gg: ASbGncvbVuaD6s4oq5PcbpTLmWvVFZr8kccv5W0SSUdnruI5BBQ/B00gVXU17hCKggy
 AFxrkUeZsZYSwfV6mbsAOkPPkmkWdXxEt3PyiMX66v++ipw+w69tnTbmgV7nl3RzUI30+vAryX1
 I34YLDgzGmgYzrTbVFFVUqMR1GBI0gCUR3UCFxpicgDEyKvJ506uSBHHGZr2OcXlVw4hleDKDiP
 CnM7WakAk2PTthHYPWIzV51QB7BTqR0CIQKMDBg9yN63cU7DJK3P/lzByxP+Tt622y+CC7R9+lr
 aQG3r16/4fOqt+e34NaWYh2DsdKXck849llMhpmHDwdptF7C
X-Google-Smtp-Source: AGHT+IFxn00awTee98uXE3tJTj0eyWUbb3a45gfzBS7sXxKQ/QZjlck0VCIHo+LYoDKdvBsssZdUZg==
X-Received: by 2002:a05:6a00:3d55:b0:736:5b85:a911 with SMTP id
 d2e1a72fcca58-736aaa1cf54mr41753854b3a.8.1741848958415; 
 Wed, 12 Mar 2025 23:55:58 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-737115293a8sm649349b3a.10.2025.03.12.23.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:55:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:30 +0900
Subject: [PATCH RFC v4 04/11] virtio-net: Retrieve peer hashing capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-4-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Retrieve peer hashing capability instead of hardcoding.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |  5 ++-
 hw/net/virtio-net.c            | 71 ++++++++++++++++++++++++++++++++++--------
 net/vhost-vdpa.c               |  4 +--
 3 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b9ea9e824e3c..c4957c44c06e 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -144,7 +144,10 @@ typedef struct VirtioNetRssData {
     bool    enabled_software_rss;
     bool    redirect;
     bool    populate_hash;
-    uint32_t hash_types;
+    bool    peer_hash_available;
+    uint32_t runtime_hash_types;
+    uint32_t supported_hash_types;
+    uint32_t peer_hash_types;
     uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
     uint16_t indirections_len;
     uint16_t *indirections_table;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index df8de1148ba4..133317d8c358 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -158,7 +158,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
                  virtio_host_has_feature(vdev, VIRTIO_NET_F_RSS) ?
                  VIRTIO_NET_RSS_MAX_TABLE_LEN : 1);
     virtio_stl_p(vdev, &netcfg.supported_hash_types,
-                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
+                 n->rss_data.supported_hash_types);
     memcpy(config, &netcfg, n->config_size);
 
     /*
@@ -1177,7 +1177,7 @@ static void rss_data_to_rss_config(struct VirtioNetRssData *data,
 {
     config->redirect = data->redirect;
     config->populate_hash = data->populate_hash;
-    config->hash_types = data->hash_types;
+    config->hash_types = data->runtime_hash_types;
     config->indirections_len = data->indirections_len;
     config->default_queue = data->default_queue;
 }
@@ -1212,6 +1212,10 @@ static void virtio_net_detach_ebpf_rss(VirtIONet *n)
 
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
+    if (n->rss_data.peer_hash_available) {
+        return;
+    }
+
     if (n->rss_data.enabled) {
         n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
         if (n->rss_data.populate_hash) {
@@ -1226,7 +1230,7 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
         }
 
         trace_virtio_net_rss_enable(n,
-                                    n->rss_data.hash_types,
+                                    n->rss_data.runtime_hash_types,
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
@@ -1337,7 +1341,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
+    n->rss_data.runtime_hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
     if (!do_rss) {
@@ -1400,12 +1404,12 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = temp.b;
         goto error;
     }
-    if (!temp.b && n->rss_data.hash_types) {
+    if (!temp.b && n->rss_data.runtime_hash_types) {
         err_msg = "No key provided";
         err_value = 0;
         goto error;
     }
-    if (!temp.b && !n->rss_data.hash_types) {
+    if (!temp.b && !n->rss_data.runtime_hash_types) {
         virtio_net_disable_rss(n);
         return queue_pairs;
     }
@@ -1810,7 +1814,7 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     net_rx_pkt_set_protocols(pkt, &iov, 1, n->host_hdr_len);
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
     net_hash_type = virtio_net_get_hash_type(hasip4, hasip6, l4hdr_proto,
-                                             n->rss_data.hash_types);
+                                             n->rss_data.runtime_hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
             hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
@@ -3012,6 +3016,14 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
+    uint32_t supported_hash_types = n->rss_data.supported_hash_types;
+    uint32_t peer_hash_types = n->rss_data.peer_hash_types;
+    bool use_own_hash =
+        (supported_hash_types & VIRTIO_NET_RSS_SUPPORTED_HASHES) ==
+        supported_hash_types;
+    bool use_peer_hash =
+        n->rss_data.peer_hash_available &&
+        (supported_hash_types & peer_hash_types) == supported_hash_types;
 
     /* Firstly sync all virtio-net possible supported features */
     features |= n->host_features;
@@ -3048,12 +3060,28 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     if (!get_vhost_net(nc->peer)) {
+        if (!use_own_hash) {
+            virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+        } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+            virtio_net_load_ebpf(n, errp);
+        }
+
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    if (!use_peer_hash) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+
+        if (!use_own_hash || !virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+            if (!virtio_net_load_ebpf(n, errp)) {
+                return features;
+            }
+
+            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+        }
     }
+
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -3318,6 +3346,17 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
     },
 };
 
+static int virtio_net_rss_post_load(void *opaque, int version_id)
+{
+    VirtIONet *n = VIRTIO_NET(opaque);
+
+    if (version_id == 1) {
+        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+    }
+
+    return 0;
+}
+
 static bool virtio_net_rss_needed(void *opaque)
 {
     return VIRTIO_NET(opaque)->rss_data.enabled;
@@ -3325,14 +3364,16 @@ static bool virtio_net_rss_needed(void *opaque)
 
 static const VMStateDescription vmstate_virtio_net_rss = {
     .name      = "virtio-net-device/rss",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = virtio_net_rss_post_load,
     .needed = virtio_net_rss_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(rss_data.enabled, VirtIONet),
         VMSTATE_BOOL(rss_data.redirect, VirtIONet),
         VMSTATE_BOOL(rss_data.populate_hash, VirtIONet),
-        VMSTATE_UINT32(rss_data.hash_types, VirtIONet),
+        VMSTATE_UINT32(rss_data.runtime_hash_types, VirtIONet),
+        VMSTATE_UINT32_V(rss_data.supported_hash_types, VirtIONet, 2),
         VMSTATE_UINT16(rss_data.indirections_len, VirtIONet),
         VMSTATE_UINT16(rss_data.default_queue, VirtIONet),
         VMSTATE_UINT8_ARRAY(rss_data.key, VirtIONet,
@@ -3919,8 +3960,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n, errp);
+    if (qemu_get_vnet_hash_supported_types(qemu_get_queue(n->nic)->peer,
+                                           &n->rss_data.peer_hash_types)) {
+        n->rss_data.peer_hash_available = true;
+        n->rss_data.supported_hash_types = n->rss_data.peer_hash_types;
+    } else {
+        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
     }
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index de006f3a2265..0e9f4482ce7a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -882,13 +882,13 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
      * configuration only at live migration.
      */
     if (!n->rss_data.enabled ||
-        n->rss_data.hash_types == VIRTIO_NET_HASH_REPORT_NONE) {
+        n->rss_data.runtime_hash_types == VIRTIO_NET_HASH_REPORT_NONE) {
         return 0;
     }
 
     table = g_malloc_n(n->rss_data.indirections_len,
                        sizeof(n->rss_data.indirections_table[0]));
-    cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
+    cfg.hash_types = cpu_to_le32(n->rss_data.runtime_hash_types);
 
     if (do_rss) {
         /*

-- 
2.48.1


