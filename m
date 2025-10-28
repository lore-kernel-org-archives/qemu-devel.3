Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D260CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeTb-0000rW-FK; Tue, 28 Oct 2025 03:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeTB-0000bn-V8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:50:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeT8-0007P5-RP
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:50:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so20146175e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637811; x=1762242611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTLB3cFEY6Tsij+P5yppIDVPLmX58penzFNO8leReIM=;
 b=ZJd00j49Iam41xtHLzPdaJ3Brz/YXciESOmm72NbwPm0k7gjjZpHxBcuxkTN9BDhlR
 1zvZA2NYAz9jV+FpfxalFWWqElR2Q6u6Hu6EAzvMhM833Emu0oaXhyEBKaaYWdtkTLID
 jOT9YXE9RsKRS5PeXw5TTCJJA9B7EGWdlu61WMdw4k3N5nhZeAyEicGqJ1Y9cVzMC0Lh
 NvxQ5YAiO0vT6vJqG1WEFxw4A+QROCipziAA43xSs3w5kUOlZpKcp2zFDYHag2XehzBr
 qx1nrot7SqPk+RuTZHvUmCe8nbe0PjEsERrv1bVBs2wDAs1JHpHS2UPtxpiHxtEQn8ZE
 dG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637811; x=1762242611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTLB3cFEY6Tsij+P5yppIDVPLmX58penzFNO8leReIM=;
 b=YMUJOFll+nLz3ATWuRNFVzrqeXrRmvORJWeSFoRIATh8epWHCqFFqonR2d3rgYj0zg
 ikXDC0W0KPfJCopFjhB4srk3WrpVesR7+SaBqRJkM2UsyIYRkdPKtP1Xf9SBgDS4p5aV
 g9Ghicgh9s1nvI7+Ap90W2K55Z9j5xX1OkI9Gz7NG2gdPRSNDWRtDAHOaOPMPLmtQ7i+
 ar9R3t9hhg/pyzkX21eZYZkWY6/4l9uEtLE5IDiWOCrqZ98AIH8rfEnlqywVIqSaUX5G
 KF7rUyi3oUlj4i9oh1GfPwmzY12+mAlLItnR3S2CR8TBN+49ZzQkaNbpHvVE+XI0xEmK
 IyZQ==
X-Gm-Message-State: AOJu0YwiQalQglYZ2bW0ee3vMzY+C2mB9/NPQfiF4A1fYL2fFs9PEM5T
 6r2hHd+AC6Ikv4Ui1004IYSAB3I+jvODR8KMQwvykvZnwexk3hhHZ3ETDpzZGvzOfPoiRO/QnHj
 BDc5EYvQ=
X-Gm-Gg: ASbGncsvlMrzaOe7eDfpQiZSR3z+m1MOZD2n+2OgbdlwTqK2uuMoO1EMBwdDq/9R3T1
 uZFihcPohdHpQeDoDhhJ5JTJAz6BDcY5ai7BwIht5APRyVsMPz8zzZWgWMVn20A1AlnwtX6jCCH
 PjIlB0IZYD8QYTLc+u8llYu/m2UN5SID9aTyZmAVMzNKAJvbAzDQab+2Dguu9Ya7+9ZKm8zuqyw
 +wYxBQXotVpUkHq/XxmmUqkoyXRv4NJA8AsYa5OScDwoPDzp/C7U2RnLU/yQmBjWha4Q3+ikpuW
 EGUvMUdDjlVl7njBunhZJoDnirDO5i5R0GmQi7DQuzOzNFyC5utzccLCem2cWPlPuFY1RSOjo6M
 SLsDz/RgB6/EFxHuyYhd4KALdAJcSRGXwEeqBY98vf93rYOhz8WPV3pZt0YZiiOj9l4/EvctCmd
 Czi7QSBMRoVITnq0heFV977G/eHQ6OlkDv8Wune6YnAG4vFIaU1gJxVAs=
X-Google-Smtp-Source: AGHT+IEw5keHIFH1+3mzddsjpLeBiEFEAjEtmyjxajE9J84wqtnL9TyoPfgqU/NWW1vCosA3jYCeNQ==
X-Received: by 2002:a05:600c:8710:b0:477:bf0:b9da with SMTP id
 5b1f17b1804b1-47717e41402mr20379905e9.19.1761637810877; 
 Tue, 28 Oct 2025 00:50:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd494d5csm183211645e9.9.2025.10.28.00.50.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:50:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Lei Yang <leiyang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/23] hw/net/virtio-net: make VirtIONet.vlans an array instead
 of a pointer
Date: Tue, 28 Oct 2025 08:48:39 +0100
Message-ID: <20251028074901.22062-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

This field is a fixed-size buffer (number of elements is MAX_VLAN,
known at build time).  There's no need to allocate it dynamically,
it can be made an integral part of VirtIONet structure.

This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20251023135316.31128-2-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-net.h | 2 +-
 hw/net/virtio-net.c            | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5b8ab7bda79..f7083553068 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -202,7 +202,7 @@ struct VirtIONet {
         uint8_t uni_overflow;
         uint8_t *macs;
     } mac_table;
-    uint32_t *vlans;
+    uint32_t vlans[MAX_VLAN];
     virtio_net_conf net_conf;
     NICConf nic_conf;
     DeviceState *qdev;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 33116712eb4..17ed0ef9190 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -986,7 +986,7 @@ static void virtio_net_set_features(VirtIODevice *vdev,
         virtio_has_feature_ex(vdev->guest_features_ex,
                               VIRTIO_NET_F_CTRL_VLAN)) {
         bool vlan = virtio_has_feature_ex(features, VIRTIO_NET_F_CTRL_VLAN);
-        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
+        memset(n->vlans, vlan ? 0 : 0xff, sizeof(n->vlans));
     }
 
     if (virtio_has_feature_ex(features, VIRTIO_NET_F_STANDBY)) {
@@ -3600,7 +3600,8 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * buffer; hold onto your endiannesses; it's actually used as a bitmap
          * but based on the uint.
          */
-        VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        VMSTATE_BUFFER_UNSAFE(vlans, VirtIONet, 0,
+                              sizeof(typeof_field(VirtIONet, vlans))),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -4018,8 +4019,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
-    n->vlans = g_malloc0(MAX_VLAN >> 3);
-    memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, sizeof(n->vlans));
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -4068,7 +4068,6 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     n->netclient_type = NULL;
 
     g_free(n->mac_table.macs);
-    g_free(n->vlans);
 
     if (n->failover) {
         qobject_unref(n->primary_opts);
-- 
2.51.0


