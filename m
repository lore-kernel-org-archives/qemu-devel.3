Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47123D3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3z3-0002cI-H2; Tue, 09 Dec 2025 15:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3z0-0002FA-LL
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yy-0001Mh-VL
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso30834025e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310807; x=1765915607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=monw4Wg+E2ePG8KINi+zLSSpB7+yENlvRjgHjIT21Uk=;
 b=djiI/f/wzteaYOYg4zEDhaomnwilEZ802taIzXyDc6nX8J9iyoQGqrTGuF1G4eMbmT
 PtKRCDK/fYGBYiOEbJIEMOGOFrJ6iSaEPDWAvd6aqhymUv7Rt2hlXBdNs2+UgC0+9mjU
 yPVBo6uigpGmQWl4Xu3bYr+XTj6OQZfpIM5hFRtNYOAUgzOkbefhuC64aaKMEOXN9/op
 yNqEK1iQH6sJqsijRCJ0a1ZzhNH6UsHpDbLzfwRiwa8Tp9pgvyaGhtY1oi/z/IjO2LqT
 Em6Nw+J+pp+GaxOIp0zQGLLc2i4bCCbmTBL8HL74CK5zl/XmuzGXfraI0pVrWvAaUxKV
 zXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310807; x=1765915607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=monw4Wg+E2ePG8KINi+zLSSpB7+yENlvRjgHjIT21Uk=;
 b=mlruen/3HVPWPRyHzADmG0qJpGyhWcStsEQCitvzvPFc9fRBaMcGTSZdI2TT+dIlx2
 32D41oM8scS1SSAhoh0e0CFYrQ3tQLyHJTXAciHvf3VboJ3F6p/IE1Vb3BhIGMN+Nzy+
 MetbOObQi1F1CuK+I+RC78eQ4FAMzBaULqOxBBHSIEaYHlTKhGQfVBTj7wax6kvlJDpK
 cE+j33IYF4EeLLiTMIO7IXRYzjHkPT0xtKnCyI54COYvow52iEdzArThQcPQ28uiB9aI
 +ff64d4AkXFCNW7h63D2Z1OazrYnPnWgMHqCcw80AFJBZ36CqEdFUtI6Vs6yuOGZl5zg
 pO8w==
X-Gm-Message-State: AOJu0Yym/nGjRMmpUiDzPfj50uCl3gSs+UZA5QJVW31RfSiizrFC+fCk
 Txhl5WIe6y3w8iv46PVujDBFB6LUtmluiGQ1oKWYr/SeAp2jxpWI1UnsD/Na0teNrW1IAwB54h7
 eycL/QDw=
X-Gm-Gg: ASbGncvEfXGSTIbpqKUN7NFUvpWKaOGdEgAXj8vk1mtcuGAHYOhSb5dPuq+Ln3orrjF
 HbjbcDh6a9PCh5sOGbhI9WAhAfMhQc/DRnOYdwpv59lNZCiSum+v4ybINzH76wtSL9GHZuCqjw9
 fIvE61HvfY3hs2CZaSL0mIIiMBl4Am6zeWcdryso9RCw6kTGXNymv8leRskr/gXdOlNr/F+JQWH
 f87aaKsLJywQZggNO41weI/8KCcaE4cZa3gPWuGLjCzctkD2G6D5ZRbyX9oHVeY5p23LUBwqnqH
 sv0esGvqsCaHECdF9deQI2l8jOhyYYnXc9AFiHdusknrTtUHmhdBfbsBbZZUGg6vCPBNWy7Uava
 2IpxQVJSA7/LIBzVylHOPsmQRCBfrw9shXwv9AVf/6pLcbAohrMZtFPtATosT7nwaUtI39P7QnF
 S2IKOMZO5qkPUSi/8e13nqNjghzI+OerjpP1PVxjfz7zq9ea4hRH3CGUHuMQgs
X-Google-Smtp-Source: AGHT+IEtrRjOzMoibLSmbu4TFXJhdwFMc6XNdC4mMZJMGTxczCyWOCVzX202+PqEqLi+Oxum1ZAKtA==
X-Received: by 2002:a05:600c:64c9:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47a837b9d3emr677935e9.29.1765310806859; 
 Tue, 09 Dec 2025 12:06:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d3e6651sm24550505e9.7.2025.12.09.12.06.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:06:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] Revert "hw/net/virtio-net: make VirtIONet.vlans an array
 instead of a pointer"
Date: Tue,  9 Dec 2025 21:05:37 +0100
Message-ID: <20251209200537.84097-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Per https://lore.kernel.org/qemu-devel/7798584d-e861-47b7-af52-2c2efb67a4de@proxmox.com/:

Loading a VM state taken with v10.1.2 or older doesn't work anymore,
using the script [*] we get:

  kvm: VQ 1 size 0x100 < last_avail_idx 0x9 - used_idx 0x3e30
  kvm: load of migration failed: Operation not permitted: error while loading state for instance 0x0 of device '0000:00:13.0/virtio-net': Failed to load element of type virtio for virtio: -1
  qemu-system-x86_64: Missing section footer for 0000:00:13.0/virtio-net
  qemu-system-x86_64: Section footer error, section_id: 41

[*]:

  #!/bin/bash
  rm /tmp/disk.qcow2
  args="
    -netdev type=tap,id=net1,ifname=tap104i1,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on
    -device virtio-net-pci,mac=BC:24:11:32:3C:69,netdev=net1,bus=pci.0,addr=0x13,id=net1
    -machine type=pc-i440fx-10.1
  "
  $1/qemu-img create -f qcow2 /tmp/disk.qcow2 1G
  $1/qemu-system-x86_64 --qmp stdio --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 $args <<EOF
  {"execute": "qmp_capabilities"}
  {"execute": "snapshot-save", "arguments": { "job-id": "save0", "tag": "snap", "vmstate": "node0", "devices": ["node0"] } }
  {"execute": "quit"}
  EOF
  $2/qemu-system-x86_64 --qmp stdio --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 $args -loadvm snap

This reverts commit 3a9cd2a4a1571266dea37398de04f650c2a72d86.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Suggested-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-net.h | 2 +-
 hw/net/virtio-net.c            | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index f7083553068..5b8ab7bda79 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -202,7 +202,7 @@ struct VirtIONet {
         uint8_t uni_overflow;
         uint8_t *macs;
     } mac_table;
-    uint32_t vlans[MAX_VLAN];
+    uint32_t *vlans;
     virtio_net_conf net_conf;
     NICConf nic_conf;
     DeviceState *qdev;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f5d93eb4005..ca813203d76 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -986,7 +986,7 @@ static void virtio_net_set_features(VirtIODevice *vdev,
         virtio_has_feature_ex(vdev->guest_features_ex,
                               VIRTIO_NET_F_CTRL_VLAN)) {
         bool vlan = virtio_has_feature_ex(features, VIRTIO_NET_F_CTRL_VLAN);
-        memset(n->vlans, vlan ? 0 : 0xff, sizeof(n->vlans));
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
     if (virtio_has_feature_ex(features, VIRTIO_NET_F_STANDBY)) {
@@ -3598,8 +3598,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * buffer; hold onto your endiannesses; it's actually used as a bitmap
          * but based on the uint.
          */
-        VMSTATE_BUFFER_UNSAFE(vlans, VirtIONet, 0,
-                              sizeof(typeof_field(VirtIONet, vlans))),
+        VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -4017,7 +4016,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
-    memset(n->vlans, 0xff, sizeof(n->vlans));
+    n->vlans = g_malloc0(MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, MAX_VLAN >> 3);
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -4066,6 +4066,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     n->netclient_type = NULL;
 
     g_free(n->mac_table.macs);
+    g_free(n->vlans);
 
     if (n->failover) {
         qobject_unref(n->primary_opts);
-- 
2.51.0


