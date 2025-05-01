Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B9C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbAq-0007YL-Jf; Thu, 01 May 2025 17:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7v-0003qR-E3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:31 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7r-0006qH-Iu
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:25 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85db3475637so87039939f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133641; x=1746738441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sYT96Q+b8vV/xVN5xVJCJ5YUm+R4rge65haKgSbsJY=;
 b=Ma9XUVrNMPO0Cyx3Wm26LTcrduCW6S1K5VUa6gio800UkvEgDtuXQlaTqKGcJga/Dw
 l3M1ZovSylb5P+MYlyoElnstWrWAKijO5tODkv7xkUYpY0uOI8FnFkT7QkVg8WSyqxe9
 0DzoklSRsO9gcAr+QylL6T+5IYSBe24YmRH11binljuqcw1JBWYLZ0TmzEqcY6eJmTBt
 26r9cZJkYYtwzA+W2GABPWJsmJjgKhsjvpxhShoPAtqWCn5DuJlHuE6gIAL0PdEq9fRh
 JvBRkeIsCn6ghBQsPI0UYNrhIR8ljMTcJU4qnBdyqA0lAvka5+FYi9VoV3xfBEDNNciW
 HxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133641; x=1746738441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sYT96Q+b8vV/xVN5xVJCJ5YUm+R4rge65haKgSbsJY=;
 b=q10qwmpWV+JNmQ5dis+ZTDQSBl3pQkuj/b/oujLPmmKZP1CdIwPprttUIzFr5RqhYj
 4Tm/QTytDKO+mJ6AmuP/H93nZoBxOznt4oP5kZLNS++Kwma/DhddT2cfzYSeRYtN9YaA
 HQMm1NZYHIzfPMsDcXBiqoJ0xR2Cz6lrczI30g/rhQP/tcnxZOjAjxvSmstCuKwuAaZH
 wbICRYrU46sJZCqQQbGZE2ekIi61UfQEGUujnWs4O+IjaI0UQLkKygh1ytIuo3qPgaLM
 pY7ZIiLcp6FVEfnPWRl66FAH0KjOb3blMGDLsp1d16Gy9itxYPIPaUIwjLWgHQUCyk/u
 2Zmg==
X-Gm-Message-State: AOJu0YxYosUw43FTgTdYWqPma+/caWHx4Ilh6ElNEx+YvjvBug9266DW
 Y1Kx8ppS/nLhOPI3NlFkiY0sFOIwsDuiuRNvWDdnKS8DXTO+U7P21RjtvfUNGdTv0qwDawnLNzG
 T
X-Gm-Gg: ASbGncsrJRlHEY570OAcNupC0LaJPSfDT9/tuJEAyrjNVKuea7ruJwazTqBFHS6hA+J
 o6LcIbqPSRCh0CKaLPmsxZt0QI8k9ZTLoPUgyrpcbUyloBiv76W3E8YJVMEyHVNyQKWc4P987oy
 vm5WzwagjS8/TQvwjdmJkiukVS/ZJSXcUUyfIjf9MSMbH+2ufL5y6R6c4/Lq4qa5lTCNF9PicOl
 VCU4ryE6svbyGljIavhmF9jK/dEiizGOmyzmdRmLarQAWKlBgaePfo6qVB8R8OtPN3H7/b0m1b9
 yfW5mE84vo0fsC5pjK+sJMxG78LjP3h7p83dQXXyUSbnn/7pTGeLzFHw2CWOZnecm/Ia0C0R7cD
 K2eirUsQayFQD+nQ=
X-Google-Smtp-Source: AGHT+IFGqEyNq9qahKbJ00O0JYK18J5gKj3OWvCE509BkFlAxLqOoJhJG/vCXZ0YxjnMxOO+6J+RZw==
X-Received: by 2002:a6b:601a:0:b0:85e:d0ca:b635 with SMTP id
 ca18e2360f4ac-864a3bceb99mr487124339f.2.1746133641157; 
 Thu, 01 May 2025 14:07:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a8d0fecsm50261173.12.2025.05.01.14.07.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:07:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 16/18] hw/net/virtio-net: Remove VirtIONet::mtu_bypass_backend
 field
Date: Thu,  1 May 2025 23:04:54 +0200
Message-ID: <20250501210456.89071-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The VirtIONet::mtu_bypass_backend boolean was only set in
the hw_compat_2_9[] array, via the 'x-mtu-bypass-backend=off'
property. We removed all machines using that array, lets remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-net.h | 1 -
 hw/net/virtio-net.c            | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b9ea9e824e3..353e872f677 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -214,7 +214,6 @@ struct VirtIONet {
     uint64_t saved_guest_offloads;
     AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
-    bool mtu_bypass_backend;
     /* primary failover device is hidden*/
     bool failover_primary_hidden;
     bool failover;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2de037c2736..a8a43ffa242 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -801,8 +801,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
-    if (n->mtu_bypass_backend &&
-            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
+    if (n->host_features & (1ULL << VIRTIO_NET_F_MTU)) {
         features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
@@ -953,8 +952,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     Error *err = NULL;
     int i;
 
-    if (n->mtu_bypass_backend &&
-            !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
+    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
         features &= ~(1ULL << VIRTIO_NET_F_MTU);
     }
 
@@ -4121,8 +4119,6 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
                        VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
-    DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
-                     true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
-- 
2.47.1


