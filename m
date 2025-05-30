Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2588CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrRg-0001id-E4; Fri, 30 May 2025 00:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrRM-0001N7-8l
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:59 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrR4-0005Lf-0B
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-231e98e46c0so16112645ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579616; x=1749184416;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3xHxQ8PrI5HPaGnznbShFoLmh2PFnUcEB2+6G2u3KrQ=;
 b=w2dluSkPKMkTvY27rPFWJmB+hFhtw3+qwNHpED0obd5qSxY0S2WI6/uQzRjhDdXcD1
 DntU9oo5KGnDhTXZ6heEmIyY2nYC0WJULFSdCBXsShPmRw4xVjJ+qpwEgHRTIm99zZeh
 AtDGr/SiByiEc3lsOBpPTTXLBnMhAaBjUJvBsmGP6qc7t26wNglhQH7UN7I+K/tsi1sr
 PwIodCHEPnl/cFfdQnSxSxsJuna44FHx+RCbRLeF+PmE4dbAsSRSP++5vb1VTv9vCUj9
 f3k8LFx0yme5/XW3P/LjfoQUn781BH7uZC+rXSYvoK3FkZa5o8MzFxcaRs01Rm+WbpUE
 P1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579616; x=1749184416;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xHxQ8PrI5HPaGnznbShFoLmh2PFnUcEB2+6G2u3KrQ=;
 b=oq4amcFnhl7iZAWhsdxZWqvLTKC3qimKL8aeu3zORLdDnf1pYfSpZKlTabgPVUOcws
 cA934e0CqML3x6rkAH2i0ewFp18vEL0dWpvpI1xO4CzfhdAA1P5zegE49v3FDFxmBfsl
 rH7kZ0p2anBW4BIgdikgMGR8MuY2ZxwoOyESJ+kt2bkPiCXK5vBf1mW50nSrABNzCssy
 kTrhtBnt9B88JFc3LH8qzkKsHfJePuNqxeFcUCi/zciiYfM1h/4wPGHjgkzFokiw//rF
 /9H1Csbi+QVnqivtal3rpBm0Fwi04wQKlrGn+BRiitPHXIxYLZ8Ti+BE6mv93+fmUvCa
 bGaQ==
X-Gm-Message-State: AOJu0YzEetpCmo6cFunMjrw1lcZ09/aqo5WZfELtlbX/Qy3LKj2ZRjm0
 jQtSAsl1wMo9iKEpFoDcwn+XJ4KDJmtmtQulSmnomU0A5rqGz/hxuQf1jqebRulESrDrv272BSE
 bgGwf
X-Gm-Gg: ASbGnctxPvU7l9lVu9fGNN6fbJNqQpOOMP3pOn5Q/m6BKRBaQYMoA9iwbMJnPVSKJek
 QxgvpAMKmhsGA3edPJdLdQxXWxQ6A30FA4rah1wCs/vB54WeZT+AoUOxicE6VADRVF5YbqFU651
 ZqYFtsHaFEFhDnkopo8FCc/DeEJj/Ncno8gmq79/8Wl0qV7iRhhtRpQAuN2F0WCvv6zSKBFcQgB
 ngtoH19TVAy4jsdGAuadZi7QARqOFlQ95rfOMMSXqDAGDpglwTS19NtCkJ4sEOXJCIuhmm+DWlm
 6cDde/VAIZi40n7DwYtxpvXyFTcclu6ITEs6C+fTFIEJEP0/unsP
X-Google-Smtp-Source: AGHT+IE0LgEBlSD21Yq+GwnN2FRZs9DppQqyrHpYUer3CZWWarfp5Ol/MJpmp2xKpPih6YNuO/imVg==
X-Received: by 2002:a17:902:ec84:b0:235:1b3e:c01c with SMTP id
 d9443c01a7336-23529903758mr30471275ad.39.1748579616234; 
 Thu, 29 May 2025 21:33:36 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cf504asm19894115ad.178.2025.05.29.21.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:33:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:33:19 +0900
Subject: [PATCH 4/6] virtio-net: Retrieve peer hashing capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-vdpa-v1-4-5af4109b1c19@daynix.com>
References: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
In-Reply-To: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
index 4ebe7f93f5c3..cd5a632596b1 100644
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
@@ -1178,7 +1178,7 @@ static void rss_data_to_rss_config(struct VirtioNetRssData *data,
 {
     config->redirect = data->redirect;
     config->populate_hash = data->populate_hash;
-    config->hash_types = data->hash_types;
+    config->hash_types = data->runtime_hash_types;
     config->indirections_len = data->indirections_len;
     config->default_queue = data->default_queue;
 }
@@ -1213,6 +1213,10 @@ static void virtio_net_detach_ebpf_rss(VirtIONet *n)
 
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
+    if (n->rss_data.peer_hash_available) {
+        return;
+    }
+
     if (n->rss_data.enabled) {
         n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
         if (n->rss_data.populate_hash) {
@@ -1227,7 +1231,7 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
         }
 
         trace_virtio_net_rss_enable(n,
-                                    n->rss_data.hash_types,
+                                    n->rss_data.runtime_hash_types,
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
@@ -1338,7 +1342,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
+    n->rss_data.runtime_hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
     if (!do_rss) {
@@ -1401,12 +1405,12 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
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
@@ -1808,7 +1812,7 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     net_rx_pkt_set_protocols(pkt, &iov, 1, n->host_hdr_len);
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
     net_hash_type = virtio_net_get_hash_type(hasip4, hasip6, l4hdr_proto,
-                                             n->rss_data.hash_types);
+                                             n->rss_data.runtime_hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
             hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
@@ -3008,6 +3012,14 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
@@ -3044,12 +3056,28 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
 
@@ -3314,6 +3342,17 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
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
@@ -3321,14 +3360,16 @@ static bool virtio_net_rss_needed(void *opaque)
 
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
@@ -3915,8 +3956,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
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
index 1493b08792ea..4f63ded40d47 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -895,13 +895,13 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
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
2.49.0


