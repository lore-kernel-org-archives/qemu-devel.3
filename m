Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34497C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscU8-0006Vx-Ij; Thu, 13 Mar 2025 02:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscU2-0006S7-Hn
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:59 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscU0-00065J-Fb
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso10608735ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848955; x=1742453755;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SlV6ybuLU7WKrkJz3b71+OaSRrTTr9sSud3VMxid9GQ=;
 b=LxHwaX3uaAHy7BtWCaeOQ6MW4rQKHF5bO2sUDQ43mB9JnXf8J7zOtWqFdpJt4/N3p5
 tdgkHcMttltKM9MD4Gw67VBkkk5R0ZHimnZq4I/KlxkezgBIo2Mv7PHRFyJw8dNr3cn6
 NWCKbIO13jWC7fOk0d7Y5MrO2fVLVxP47oZJAk25ShcL5Aj+QiVQwtDeJy6Hcwra/DTd
 zXl7lORn5zREdEoMwc/9hnl7akVmVaW6c30e5w+/O0Taf6RfzCqLogQPg5bOcHkyOL5K
 P6qEMhgpVLJWVMfKc6csDsfc3QVyQrkND2eDR6Nn2AX8ZvctABhZ9/lMeOQHdA8mecq/
 mC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848955; x=1742453755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlV6ybuLU7WKrkJz3b71+OaSRrTTr9sSud3VMxid9GQ=;
 b=CdDCZY2z1OhEx/iycN/FBPdrw0TsZKpEg80FPWM0JeR0BcM27ikBaaSVHvnzvACkwu
 nsIKtWDA1TkCI6N5I4mALI/0Hj59vGOuiDnMPYky818Daz1jQI8QJBNIzKbryVY9726Z
 /YJu6pmhQLQUgIk3HTVt1SplcKNBbdjECJmVv6ICVPjEzH9XYtqYj0+Bg9lUsXQ0/Yem
 yDykNaBVVmBkj8R+9MXq4jYdjG7uHzwWWfpydAbWqCbu/538EW6MYofZMMY1xJQa4krd
 S/hdkwFzOAQ0ucdvz1xJK0t2uRBam+UI5dt0vOAiqj9PfG+54qzPdC1LK+QRaeU3XCyU
 59Rw==
X-Gm-Message-State: AOJu0YxvQdrZk9UtSRv0Vcsd+wzTZIPdKfV5VKc8MTnYsl6PdvvPOH4X
 dAIKQ9DbVaSmibkelEL+GkZyQMCkqZ7cmdLu+HI4hBV0zcmnnNd69Qjgth5EZg4=
X-Gm-Gg: ASbGncuUoVjonFrLB1Z+zbrI1GaiwV5HH0iLKv/Y790XW3b3ai+wWFHJXuDrBDnrhoq
 0N8oztuNIprLZVndR6fc2dZIqVnry/uulSIxOkNAn1AsgKsyXO5Rf9qytdv6eovbjILnehBkS82
 VmGzGP2DjZ9JanOgocgeTbBg2f70lLzw6U4f1Mazj8ps+2QHTBSQaiJ2oRhKEleyLoPgLgI4Btr
 uq9vEjfiT34U0YRySt8KWEoL3d7jOnCSTzCh52xArW6IdyvVWCC/CnHGx4H7GZcAMeLUODBUVFp
 iQ8gPmdthnX0vLZ4I9BfCC7NbbHUe2u98zHD0MdE4gd+T5kH
X-Google-Smtp-Source: AGHT+IHTJdGNRh296jYk+pFzNVcSbXHroum/UKlqkUuc/KIx7yAvPrWTuf+VYCcjP2WXf9ibjg2VGg==
X-Received: by 2002:a17:902:ce0a:b0:220:e338:8d2 with SMTP id
 d9443c01a7336-2242899474amr356581515ad.21.1741848955130; 
 Wed, 12 Mar 2025 23:55:55 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c6bbcba7sm6396075ad.173.2025.03.12.23.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:55:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:29 +0900
Subject: [PATCH RFC v4 03/11] virtio-net: Move virtio_net_get_features() down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-3-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

Move virtio_net_get_features() to the later part of the file so that
it can call other functions.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 146 ++++++++++++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadffe1..df8de1148ba4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -751,79 +751,6 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
-static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
-                                        Error **errp)
-{
-    VirtIONet *n = VIRTIO_NET(vdev);
-    NetClientState *nc = qemu_get_queue(n->nic);
-
-    /* Firstly sync all virtio-net possible supported features */
-    features |= n->host_features;
-
-    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
-
-    if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-    }
-
-    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
-    }
-
-    if (!peer_has_uso(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-    }
-
-    if (!get_vhost_net(nc->peer)) {
-        return features;
-    }
-
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
-    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
-    vdev->backend_features = features;
-
-    if (n->mtu_bypass_backend &&
-            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
-        features |= (1ULL << VIRTIO_NET_F_MTU);
-    }
-
-    /*
-     * Since GUEST_ANNOUNCE is emulated the feature bit could be set without
-     * enabled. This happens in the vDPA case.
-     *
-     * Make sure the feature set is not incoherent, as the driver could refuse
-     * to start.
-     *
-     * TODO: QEMU is able to emulate a CVQ just for guest_announce purposes,
-     * helping guest to notify the new location with vDPA devices that does not
-     * support it.
-     */
-    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
-    }
-
-    return features;
-}
-
 static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
 {
     uint64_t features = 0;
@@ -3080,6 +3007,79 @@ static int virtio_net_pre_load_queues(VirtIODevice *vdev)
     return 0;
 }
 
+static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    NetClientState *nc = qemu_get_queue(n->nic);
+
+    /* Firstly sync all virtio-net possible supported features */
+    features |= n->host_features;
+
+    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+
+    if (!peer_has_vnet_hdr(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+    }
+
+    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
+    }
+
+    if (!peer_has_uso(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+    }
+
+    if (!get_vhost_net(nc->peer)) {
+        return features;
+    }
+
+    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    }
+    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
+    vdev->backend_features = features;
+
+    if (n->mtu_bypass_backend &&
+            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
+        features |= (1ULL << VIRTIO_NET_F_MTU);
+    }
+
+    /*
+     * Since GUEST_ANNOUNCE is emulated the feature bit could be set without
+     * enabled. This happens in the vDPA case.
+     *
+     * Make sure the feature set is not incoherent, as the driver could refuse
+     * to start.
+     *
+     * TODO: QEMU is able to emulate a CVQ just for guest_announce purposes,
+     * helping guest to notify the new location with vDPA devices that does not
+     * support it.
+     */
+    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
+    }
+
+    return features;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;

-- 
2.48.1


