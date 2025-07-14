Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393B3C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFq-0001bt-DX; Mon, 14 Jul 2025 19:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFo-0001UI-MA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFn-0005ME-1L
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bg7AEVJg/9+B0Q277s7PjoUmjr+ue8mbxt0k+bakIw=;
 b=BE0F5sPqyraJPfVQBNtv5R2DAuDszoXZKNwFGE6z0Ak8e3GCePatYIZJu3iljghwXCBLW+
 762RJ9TvuEStRr9D8CV/cGoGCIhs6bsmXaHFwEVr+lsR7du/WMUR4pPQFWNh8eJTfNXzX+
 sqpzwYnqcKACw39dWkG5Cip9Otro0as=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-EAzvNBS-N9CJInY1EGQnwA-1; Mon, 14 Jul 2025 19:06:33 -0400
X-MC-Unique: EAzvNBS-N9CJInY1EGQnwA-1
X-Mimecast-MFC-AGG-ID: EAzvNBS-N9CJInY1EGQnwA_1752534392
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso3630975f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534391; x=1753139191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bg7AEVJg/9+B0Q277s7PjoUmjr+ue8mbxt0k+bakIw=;
 b=lgOYCzLpAyEb035IKDrg2ogtTaZI7ks5ehMlpplB/8SOMtJXqRO0BFKM71Oacna6h+
 60nd05WyXWYnP9mk5PLjr/rYdejheqEiL0db9SJsXpTXT3Pka8zkDwYj3o9n+sOaf773
 B972dAjeD4v3/iU0CYqfPiMYTe40GI0dG4T5ygJMke8svpRzxYWK5aFmMqI/TKGyftri
 SovjZs486p7VO2ADor1RhxHHmc8Adglt2E0NzMkOnb/CkQ93JJVAxJ716rbXv5xXOIQZ
 h1fl4JVD5JmL8cxVeL2trfuUyvRIOD8vg2CbtNdZfkloW1+EcX/Df+LXOAADU768T/D0
 PZtw==
X-Gm-Message-State: AOJu0YzVE6EucS+ae4PBnT2GRv7+TpMIlF2q5XqiMOSEmc9UM+wErnl0
 14LpIckQbiJj6RjxXDQpfWPS6yrQDGq9UzKN0Z2ctVLtiL3PXbJYuLVqoSP71B0jYxqrc2jms1c
 tCWglRFDe58DDbGG44U07nTTM5/+EE3hTuK5775E6a/jbycwNm4XHYqs4qI5XFgC25IgEfM/Bcc
 KWLIsseIcvAghim9cWhGzD04CqwxZXcRzOXg==
X-Gm-Gg: ASbGncsDbPByg7S8GJy9tveaw7FUW8i6U9BoS02vYVy9aaRBBQvS2ufqC+0+0jMh3dm
 f6V5M1lAhHvLBEYuc5RcAZI+3dpL3d5qJPGfahAWWE6CBmvd4Cu9C9xIQWJFaW9Hio/Joj/lCuO
 b9n7VCr60xOnVSZt1ePzu9sj5HIidjJollUu4NSBYLt0JDgwjylUSGqUijvLFUAhBhlCg7Gcc+5
 CXhRqsB3D42psGu3anpBiEbnUTNljQF5DJ+JcOZDOC8t3b+OQHpMyv7zm9z7pM5VrctVQLN/jT8
 4agtWVqQ8J4wvU3F2hdA8xbkCXehkrUf
X-Received: by 2002:a05:6000:2203:b0:3a5:57b7:cd7b with SMTP id
 ffacd0b85a97d-3b5f2dd118cmr9836875f8f.22.1752534391520; 
 Mon, 14 Jul 2025 16:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwFS5502dgwfUrzqLfaf0TV1G0nB3jWBlHH0FysnqJk78cA7g8TN52vk/a0L2hNAsOqPQxrA==
X-Received: by 2002:a05:6000:2203:b0:3a5:57b7:cd7b with SMTP id
 ffacd0b85a97d-3b5f2dd118cmr9836859f8f.22.1752534390965; 
 Mon, 14 Jul 2025 16:06:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f222e4f4sm104479425e9.10.2025.07.14.16.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:30 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 06/97] virtio-net: Add hash type options
Message-ID: <729b5734197d1afad364bb025a827438bb85e050.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

By default, virtio-net limits the hash types that will be advertised to
the guest so that all hash types are covered by the offloading
capability the client provides. This change allows to override this
behavior and to advertise hash types that require user-space hash
calculation by specifying "on" for the corresponding properties.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250530-vdpa-v1-6-5af4109b1c19@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-net.h |  1 +
 hw/net/virtio-net.c            | 45 ++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index c4957c44c0..73fdefc0dc 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -148,6 +148,7 @@ typedef struct VirtioNetRssData {
     uint32_t runtime_hash_types;
     uint32_t supported_hash_types;
     uint32_t peer_hash_types;
+    OnOffAutoBit64 specified_hash_types;
     uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
     uint16_t indirections_len;
     uint16_t *indirections_table;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9888ff22bd..6af230bca9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3959,9 +3959,14 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     if (qemu_get_vnet_hash_supported_types(qemu_get_queue(n->nic)->peer,
                                            &n->rss_data.peer_hash_types)) {
         n->rss_data.peer_hash_available = true;
-        n->rss_data.supported_hash_types = n->rss_data.peer_hash_types;
+        n->rss_data.supported_hash_types =
+            n->rss_data.specified_hash_types.on_bits |
+            (n->rss_data.specified_hash_types.auto_bits &
+             n->rss_data.peer_hash_types);
     } else {
-        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+        n->rss_data.supported_hash_types =
+            n->rss_data.specified_hash_types.on_bits |
+            n->rss_data.specified_hash_types.auto_bits;
     }
 }
 
@@ -4178,6 +4183,42 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_IPv4 - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-tcp4", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_TCPv4 - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-udp4", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_UDPv4 - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv6", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_IPv6 - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-tcp6", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_TCPv6 - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-udp6", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_UDPv6 - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv6ex", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_IPv6_EX - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-tcp6ex", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_TCPv6_EX - 1,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-udp6ex", VirtIONet,
+                                  rss_data.specified_hash_types,
+                                  VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
+                                  ON_OFF_AUTO_AUTO),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
-- 
MST


