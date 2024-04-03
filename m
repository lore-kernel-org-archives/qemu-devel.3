Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7441BCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryX4-0007gs-1A; Wed, 03 Apr 2024 07:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryX2-0007gR-JW
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryX0-0007M9-QK
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6eaf1a3e917so3389944b3a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142708; x=1712747508;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cuZ7qNeOoLzARiTc2qncpFYpm6OJUrbkrDsBu8qypTc=;
 b=nCyARB33Rd4V9Rma6g+3h9Kgar8Z69oDXYEu18uVrDxpj6ibRaXOvnPeiszkHSzpR5
 gRjLbB7tA/hPSR/8Ybac5Jwz3wFWzmvzpKExEKXz386OywnxWgIU++AKynjr7V105Xyl
 FYZDDwalkDwQ7WHZP74GC4O27Jrz97YsbePLRd5TAOzoBQNIp7G6/EQqg6Zh01XPjYGu
 Zawb4BW1w3O435uOR8yhOeor+gXGyvsRY6IxuNKmwwz+JocwfEIBmSIxuUV6iN299tIq
 BvchHaJS9TKezJp2WfYhPFaQPg1tnIeAryWM5sbHDksgG03zP2yRM3hAIvnGRhAW8TrB
 7Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142708; x=1712747508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuZ7qNeOoLzARiTc2qncpFYpm6OJUrbkrDsBu8qypTc=;
 b=sMCimXPMHfSDzyXn8Tlnr3srr3eDOZechqoZ17JXjybKtWJM8+SFK4RXUh9VR/G305
 jG1Y+jcjQyxNoH+3jSgz4jWGolu8TO02A1jrqDcVknOHxh6nuBlRWVCrGjs2D/BTksOJ
 KkMCJ2zxpRxdsS72d0sgJ/5mB5x5G1LsqwkBRNeSO4F7z1ilz1Nqk9wCO0RMKgyo6r7G
 9sn8/n+WvvhBFV8OJXqcVlW20g4ugvBhLuecOsEcKtOcKto7U3u6AJbVNS4jh61192dG
 3PMzv252bA4D5irfBWxj+O1Zyi3Ii3zdhSr3S0eEuTX2/7r0EgsQGA51qshOwL0i26xG
 H6PQ==
X-Gm-Message-State: AOJu0Yz0bdG0pTye58715emNbdwJVtHEH5W4jIKKuYXi9sPScKekrkLB
 i00dTQUAttSVEwQWuefO5nPUc5AKYUx1Vd7ByDNlZb0MTxJpjU9AaKfID/kME2w=
X-Google-Smtp-Source: AGHT+IE8ZgfZ1W686vfi+Z1aD2xDxZc+fHbZqeSLtK1E3m4MVsAhhzywX5YFmfBGl/LEQnLRHR9Ebw==
X-Received: by 2002:a05:6a00:cc5:b0:6ea:d114:5f05 with SMTP id
 b5-20020a056a000cc500b006ead1145f05mr16871195pfv.34.1712142708628; 
 Wed, 03 Apr 2024 04:11:48 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 k8-20020aa78208000000b006eaad01817esm11537200pfi.105.2024.04.03.04.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:11:01 +0900
Subject: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

vhost requires eBPF for RSS. When eBPF is not available, virtio-net
implicitly disables RSS even if the user explicitly requests it. Return
an error instead of implicitly disabling RSS if RSS is requested but not
available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 61b49e335dea..3d53eba88cfc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static void virtio_net_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIONet *n = VIRTIO_NET(dev);
+    int i, max_queue_pairs;
+
+    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
+        virtio_net_unload_ebpf(n);
+    }
+
+    /* This will stop vhost backend if appropriate. */
+    virtio_net_set_status(vdev, 0);
+
+    g_free(n->netclient_name);
+    n->netclient_name = NULL;
+    g_free(n->netclient_type);
+    n->netclient_type = NULL;
+
+    g_free(n->mac_table.macs);
+    g_free(n->vlans);
+
+    if (n->failover) {
+        qobject_unref(n->primary_opts);
+        device_listener_unregister(&n->primary_listener);
+        migration_remove_notifier(&n->migration_state);
+    } else {
+        assert(n->primary_opts == NULL);
+    }
+
+    max_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+    for (i = 0; i < max_queue_pairs; i++) {
+        virtio_net_del_queue(n, i);
+    }
+    /* delete also control vq */
+    virtio_del_queue(vdev, max_queue_pairs * 2);
+    qemu_announce_timer_del(&n->announce_timer, false);
+    g_free(n->vqs);
+    qemu_del_nic(n->nic);
+    virtio_net_rsc_cleanup(n);
+    g_free(n->rss_data.indirections_table);
+    net_rx_pkt_uninit(n->rx_pkt);
+    virtio_cleanup(vdev);
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
-    }
-}
-
-static void virtio_net_device_unrealize(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VirtIONet *n = VIRTIO_NET(dev);
-    int i, max_queue_pairs;
-
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_unload_ebpf(n);
+    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
+        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
+        virtio_net_device_unrealize(dev);
+        error_setg(errp, "Can't load eBPF RSS for vhost");
     }
-
-    /* This will stop vhost backend if appropriate. */
-    virtio_net_set_status(vdev, 0);
-
-    g_free(n->netclient_name);
-    n->netclient_name = NULL;
-    g_free(n->netclient_type);
-    n->netclient_type = NULL;
-
-    g_free(n->mac_table.macs);
-    g_free(n->vlans);
-
-    if (n->failover) {
-        qobject_unref(n->primary_opts);
-        device_listener_unregister(&n->primary_listener);
-        migration_remove_notifier(&n->migration_state);
-    } else {
-        assert(n->primary_opts == NULL);
-    }
-
-    max_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
-    for (i = 0; i < max_queue_pairs; i++) {
-        virtio_net_del_queue(n, i);
-    }
-    /* delete also control vq */
-    virtio_del_queue(vdev, max_queue_pairs * 2);
-    qemu_announce_timer_del(&n->announce_timer, false);
-    g_free(n->vqs);
-    qemu_del_nic(n->nic);
-    virtio_net_rsc_cleanup(n);
-    g_free(n->rss_data.indirections_table);
-    net_rx_pkt_uninit(n->rx_pkt);
-    virtio_cleanup(vdev);
 }
 
 static void virtio_net_reset(VirtIODevice *vdev)

-- 
2.44.0


