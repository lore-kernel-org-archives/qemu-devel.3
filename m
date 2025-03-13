Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48F8C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscUK-0006j2-0b; Thu, 13 Mar 2025 02:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUB-0006c8-Uz
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUA-00067r-6M
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22409077c06so16026145ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848965; x=1742453765;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MopfiGBM9Z8oEbwyR+l0MgHiADxFvlgYbngCIIS2QmI=;
 b=EU5kQIESTU4jLx9nYqKz8AvdNMZTNurJjwcYjgdMLOBR5E+fys4hvwQmuGr7fFtvwb
 AlFb4NA5XremgJq9aFtMP7EWPYKbNel3kn4p9rlH89ed5GYaWnQ7dOx2psl+fAPNHL+p
 3ewNAEIbt5hjLadmSCaxfRz6bQO1yI5OZI2aVp5eq7h4H+RJtNX7QO01GAFyXzAYwiNZ
 LcyaHUbBWVNJKjvsIqqEWnck05qLgyZTHiVie8qDJbJh8hxvNl+jskFl0fCZAOULDlfD
 s3LaDkRSHQXDROk1C3Fofisr6g+lp/bLROuoz9z5fHr2cgtnwYTz4CXDScd7y10BOj9W
 +vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848965; x=1742453765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MopfiGBM9Z8oEbwyR+l0MgHiADxFvlgYbngCIIS2QmI=;
 b=NS1IKiouQ1aXTxbYMFG98gI8Y+Yg9jX7t/Mg60sAtDa7g9vYOi2aFVNvjboWYsC+1U
 L9QKpB1QKK33TBwzp1eZ5ckrh/EkcYOIWBCMdOZ9kYSv8eKY8xCktyr9ljiAsCqSl++1
 JWhT7XEksYKc6ibwnACi8+fBXdYaW3x1QsirWzkc03H4UUxt1aBkE7nS7/dYOsNv1mbt
 KYH14zPB/NO9QIwmIAPj8A2H12iK/aM1c8I+EaDmtCQDl6cAszEEOVbLhzW+exO5Lv7t
 gvZX9CXM0OjawxGSyOIGNtvWRS9SusiNPYsexPQW7wqgX9sFnAzOA55Y4+zCyE4P4pgR
 52rA==
X-Gm-Message-State: AOJu0Yw4FOaZEK7izrpbpvlRjQGLB+NcgR1Axjj/Oe+I0R8Bd+nWcYmV
 qAmxzATxONGZf2FCLJv7G+TIA9B5PXf8Ai2brPN/ZPorJV5g4M4A3O8hDYHg+q4=
X-Gm-Gg: ASbGncuEkF16eOM1cuDYUFhGX/pF3hbwSTgr9G2Im6VqdUcqviGGc3OV/UBpCcoWwuc
 iJYpMM7oyxW7Dbhv8PtvgV69F0yGvUWTPgybkBJFHmxCE6lODtQ8g86lwwMWAd/+8PTPlr4gzGi
 DxeDZmhyNefOq7QcFnIwUtNwVw7BaGzsohK1bRJRXjVZonbZcBda0FeYl2uIhKhY/CeAhOsQLlc
 LVZO2dLhFAipkH5XfHEMuYAnfltIND4Qv9D+5SLZzKaaWA/EkVXqkHB/OSZeuJkZcPT7B0TVNJ1
 VqslJKpEuwLksNusqTDimpkc55mS/gE/ax4YPOXeBFdM18kA03QJ2VMSDoY=
X-Google-Smtp-Source: AGHT+IEx/lbs2ZrH4aTBsjgYxVv/7NeQ54forRfKtiD2Rt4KJWIyqWTM93rXDacqgcUORICBDbC8rw==
X-Received: by 2002:a17:903:2405:b0:224:24d5:f20a with SMTP id
 d9443c01a7336-22428bfdba7mr436327225ad.48.1741848964926; 
 Wed, 12 Mar 2025 23:56:04 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7371167e02esm639778b3a.95.2025.03.12.23.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:56:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:32 +0900
Subject: [PATCH RFC v4 06/11] virtio-net: Add hash type options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-6-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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
index 133317d8c358..b0f2ad78cb39 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3963,9 +3963,14 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
 
@@ -4182,6 +4187,42 @@ static const Property virtio_net_properties[] = {
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
 
 static void virtio_net_class_init(ObjectClass *klass, void *data)

-- 
2.48.1


