Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096B6C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrRh-0001jv-6s; Fri, 30 May 2025 00:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrRM-0001NG-V1
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrR9-0005Oz-3X
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23526264386so6825985ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579621; x=1749184421;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PzspMOXBN18eh+XrNUrzXep8Qjkld4nXnkxOhOiGHWE=;
 b=tinI5KiEdDNc/fHo2hoELeRoqUk8vU1ejVkhQPceGhk1VUOZUXpcB62qdwWS0PzEzy
 LGlgSc9iRKf9v8h20zaXq6yB7oPVPFK6ZfLDV5ivg6TzITSQEkuVv0hZLkvnMibZi9b3
 QIWo1uQS5O67tkGMk/asDVctiDS32sBM0ekmi3KnftANq61wWbOwL6zg+sYcmKqoGO7Y
 2dxzERzOnLWU9I0qiMpmgy2LERGvnyozYOZdkQ0KRPMqgjlQzM5lkSqYlzmbOrvKGsR1
 5bv9dMIMfRlPzf1UphJFotkjDEQ4wqQmq/Qfo6uURLU7Tl73MJbu3/hIw5QZfzmS/CSP
 +CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579621; x=1749184421;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzspMOXBN18eh+XrNUrzXep8Qjkld4nXnkxOhOiGHWE=;
 b=V9X/jJNzemsQ7LstpewSVdLGAg2om1vVrO4E9zS2nryXm1/JX2eNBJT+1IR1Jm+AGb
 8a4cGbHE5j2DLaO4hbf3CD4d2qlPQqNd+QOx1nbU1YMhwOIWrL45ckg/Hs9NzDtJ4G9t
 lKfSaKMnDB3LzsE2sZ9K27zA54x0m+HaQckbILWqe6YyW0XJEoJw8/XLiuGdJ5BtFzQu
 7n8+dVscjf+N7J564DrjAeuWICv7Ig/BAF80nh9Ri6uzyzK4BjEOjdKF+dCxgV68pN7H
 D7GWi51e3fb+pL962I/uS8U2av9wiu+c2bbhuMGwS2sm/BDzDmcha7UoqPjPmBk49inj
 rogA==
X-Gm-Message-State: AOJu0YzTjsLWa+Iir+vu4PigwOd0+BVB2wAkQr3PGPfHyeib3Hw2df51
 a7o1nAgtrY7PTva8fmf83GdmSaFcekEE6CmbfBOGvcfFivzdKKdguwBeSyzsvUjwG2wXlhLEh8E
 uLfrN
X-Gm-Gg: ASbGncv2Vo6hO7BP5GoLLGGEUOk2HStWeTDiHIhP1EYT68KPLAUP358zuQjIHmiJH4R
 5z/rbZzTkfCA6PLdlsasMApa1iRO09UmStP3CVDcqNSclelqOLT/r2707RTYx4Ug5oyp26x8T4+
 liJzNhVuO10HQC+n0qzDlxZ5XsQMT6rOMVnNynIPJYT+oFljj9RZKsxA/g10arrq99Od7ww/z3E
 LYGH4U5ktfF7/JIOrpoq/P6y1FJI1F2DYRrySx2w8Q9Rersn68hKSqRUCl9ZQ/0HNRTZSaWOZIh
 2/6nLfOO3iXz1sff7rPnqjmdSkIySSb7bv8gQ4bT0COmwbWPwDI8qNbkNmt1yDo=
X-Google-Smtp-Source: AGHT+IEaxA8Lq0B1laCaHcOAnqBoXnkQajj1gzeNhidp1lDH2ysWr3Z4JGktRcIikctO2CosWX5uMw==
X-Received: by 2002:a17:903:2f90:b0:234:f580:a15 with SMTP id
 d9443c01a7336-23529203bdfmr34360395ad.14.1748579621512; 
 Thu, 29 May 2025 21:33:41 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506d14702sm19809485ad.214.2025.05.29.21.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:33:41 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:33:21 +0900
Subject: [PATCH 6/6] virtio-net: Add hash type options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-vdpa-v1-6-5af4109b1c19@daynix.com>
References: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
In-Reply-To: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

By default, virtio-net limits the hash types that will be advertised to
the guest so that all hash types are covered by the offloading
capability the client provides. This change allows to override this
behavior and to advertise hash types that require user-space hash
calculation by specifying "on" for the corresponding properties.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |  1 +
 hw/net/virtio-net.c            | 45 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index c4957c44c06e..73fdefc0dcb8 100644
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
index cd5a632596b1..52fe404b3431 100644
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
2.49.0


