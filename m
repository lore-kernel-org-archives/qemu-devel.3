Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AA6CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLE-0004FP-0h; Wed, 07 Oct 2026 04:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJt1-0001cw-72
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJsu-0005KP-Fj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so14043025e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791349687; x=1791954487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gmuD2D7dO3jWUTvhm2jqXEfMN+iA6krFRyTGqZlQEkQ=;
 b=X0JIbb6a1QLb5ITT6tiBmWtTxkxlyjUO0R0qE3AturSku6Q6ls/PkApi/yzeIBY/TX
 MAKgQCWpg/nCSgkhgQaSeBYf4UW2xMzglsMsNYJ6gE+m8w5VllzvFd2oHpsW/tSB49nh
 +zlH1BE7nAthg89WlP8lPe/PW/ys7tPWwUz9iQjZnjobk7datP0PWI2Q5NIYoPsAj/0y
 jGaT4aSVbbquhQWVNqY/8567ZrGq4UvTYUrqH48xYtlZ2wvc0Cx5kcMTcE2Gp6sv/cDE
 tK/FF5uq/ySj833CvtxJC25n362H1bS8j8hJQhFTuRUluCDpwuDP7S0KW7C9mgb4yUE0
 iE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349687; x=1791954487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gmuD2D7dO3jWUTvhm2jqXEfMN+iA6krFRyTGqZlQEkQ=;
 b=JNk1ioh8yI5yi15pqcSEnLSh12b3TCtM/pIO+p+F//5NuZ0Ume4EQYP/flu7u/MCbE
 i9gMQAP0CHCtvrUrC9dG6GqjkEMOJuNOZGOGNrCrHdp02c93bJ0j+MC737jshK6GGtYB
 j9UwM0A/AhYTHoCvuUGyJTtIxsCCcQEqYBi4ctpPzjlFhJjDAIYlYivGiVr7mndLUqqz
 6W9BFbPIwWKyVNT4LuaMrHL2ROaqXcrz2j5UlwSDcR0RQEEH7gcpw3CuWrOCugkqImSs
 ZhWmRATvIgXfpVqhQKS3msak78z7p0iqKHKWABx2lCYKDzNXg/hXE/2+ul8PfXQRO9Wl
 biEA==
X-Gm-Message-State: AFuF++lVtedEc4gEndxk1gmNEHXZiw6eQNaLvOqCggysCHEH3SJ4jBEz
 q2p/b51JpmqPkn4OL90WdRH+ziD11gkJ4uusuaXcivoaaMwQGCvah7RUHnvX/9T0lGQ=
X-Gm-Gg: AYBFou0LbbbuKuJq/y2FRxIUPhelXbeiikuo4I5j+gSCgWkZMveEyeF20Zs49LqV3ib
 R2DQkT2ZQR5Y0pbQTtmRL41kBB3PW3z+sADANTv/j3+c+HEoM/KX8VJYQNwtwZxHahgKG+yBGwu
 Kq5+5Lh4DKQOr1vJlfmMyVA/rPf0NhTiZuvn/UUCEF9w/JxXUOKpiHI3E0unJt+0lG/1HyUsngj
 B9RNDxZS8gHyVXbxNgCmlour2PXbkp7Ua8Ri/CECZFozv4vl78WZGn6KD6jLq3L1/WvaryyNPEN
 Rlhi+1ObanGUSOrGD0GZosLCI0Vlq9AtqXyBQqa7ctwTqydSFz5HbTczUCDDlyytUHGLqMx07ky
 1OT2hDQxUIhqYos0+kRbyYcGpizb8TBxrosEeEiXUc/lvqWYs1IncotiOJ4yzy9JqtuzwjCIUJ7
 B/XkOCsQ37jbKhlzhVdqYUgN+I9ccsB0JPm3ZfGWwd9ya+ZW/EhnMjInmUAhZuXmjfD//2VMjFo
 IHidRf6XPBPpTfSuF+HJzKx
X-Received: by 2002:a05:600c:83c4:b0:4a1:7cf8:5433 with SMTP id
 5b1f17b1804b1-4a1800d3d44mr12300545e9.3.1791349686951; 
 Tue, 06 Oct 2026 22:08:06 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.190.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f795f29sm33359315e9.11.2026.10.06.22.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 22:08:06 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Nariman Sayed <narimansayed28@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v2 3/3] virtio-net: add mtu-from-tap property for automatic
 MTU detection
Date: Wed,  7 Oct 2026 08:07:18 +0300
Message-Id: <20261007050718.926-4-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007050718.926-1-narimansayed28@gmail.com>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20261007050718.926-1-narimansayed28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=narimansayed28@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, exposing the host tap device's MTU to the guest via
VIRTIO_NET_F_MTU requires manually specifying host_mtu= on the
virtio-net-pci device, duplicating the MTU already configured on
the host's tap interface.

Add a new mtu-from-tap boolean property (default off, preserving
existing behavior). When enabled, the netdev peer's MTU is queried
via the generic qemu_get_mtu() and used to set net_conf.mtu and
enable VIRTIO_NET_F_MTU, regardless of the backend's type.

This detection must happen in virtio_net_device_realize(), before
virtio_net_set_config_size() computes the virtio config space
size from host_features. Performing the detection later (e.g. in
the get_features_ex() callback, which runs after the NIC and its
config space are already sized) results in the mtu config field
falling outside the sized config space, and the guest reading
back an unmapped garbage value (0xffff) instead of the intended
MTU.

Since qemu_new_nic() has not yet been called at this point in
realize(), the peer is accessed via n->nic_conf.peers.ncs[0]
(populated during property parsing, before realize() runs, via
the netdev= property) rather than through n->nic.

Signed-off-by: Nariman Sayed <narimansayed28@gmail.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
---
 hw/net/virtio-net.c            | 10 ++++++++++
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d..89fb3bad10 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3901,6 +3901,15 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    if (n->net_conf.mtu_from_tap) {
+        NetClientState *peer = n->nic_conf.peers.ncs[0];
+        int mtu = qemu_get_mtu(peer);
+        if (mtu > 0) {
+            n->net_conf.mtu = mtu;
+            n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
+        }
+    }
+
     if (n->net_conf.duplex_str) {
         if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
             n->net_conf.duplex = DUPLEX_HALF;
@@ -4275,6 +4284,7 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
                        VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
+    DEFINE_PROP_BOOL("mtu-from-tap", VirtIONet, net_conf.mtu_from_tap, false),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e376428..11044b6d27 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -52,6 +52,7 @@ typedef struct virtio_net_conf
     uint16_t rx_queue_size;
     uint16_t tx_queue_size;
     uint16_t mtu;
+    bool mtu_from_tap;
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
-- 
2.34.1


