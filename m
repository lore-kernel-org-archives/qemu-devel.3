Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07111C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10UX-0007i1-0e; Sun, 28 Apr 2024 05:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UU-0007hV-Km
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:34 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UP-0003wX-5F
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1eab699fcddso26491045ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295188; x=1714899988;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KYFokKhXysTWjT3OFitjO+OVj2oTKkLxJ60GTT7+88s=;
 b=T0YEUizFEav3/K72YYunCUm80NxOxpCriL49W59ZyoEwlI6OglOVGf9iLksizWzKq+
 q7IHbK25+JzujbpwcCqQqcAet1E2jP3z76zfD6n8X4bIFmPy88VTNaD345Uf6YqANVop
 oKApDBrZ0GuoFksEBMW6NVVkA2hgygdKVa2rUxlPA3qKR75dMOxUH5FjP/UDj2kHPA8g
 /lZWjvwLD8h5J6OotBSkOonx6mukVmqcNKfCezjFSwe17W9WsrGLzY5T0heRDrtLkcck
 YtqIlUGM9v8g3KS3DYT+A3uuuxpneix4oTwhRkPx0vKGCzYR8r7KLjNR9Gh5ccuIVvzd
 IPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295188; x=1714899988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYFokKhXysTWjT3OFitjO+OVj2oTKkLxJ60GTT7+88s=;
 b=S0k7tYAA/GM1GPxsQDnaP4tJOHNuuemsyCpGt8J2g9U+zNIIsvXiA1DYfoFa/Xxchf
 DE7yOIvMcBVWGwltNaIB2DiHJhCN++HbJD9N0YOuOwIc79YYkPo2sVBZ8axuji6NIfSe
 NCGupfwE91rS/Tl7roZrDoa7bhm1Qipet/lQvhkB7hxPV+vPKs1W+2qR8w2BLo3Ua8gE
 tubgejoJbf0B0DU9nPyxdAjbU/cYzED7EqErLzDeHl5JhpIpXGXjh33VRHcQiUKcQr6o
 rSjge39CBaZQcL+nnUf5hWXG6c1I+QFnb10bqC6odOHBVP8eybxB/xlGA6Mm1p3zOcu8
 kuzQ==
X-Gm-Message-State: AOJu0YxijV1++UO545p6CN4QjBc/JcpGeMK6iiFDsxQ2sDSVWQbwgS29
 1bcjHrJsUuhzp+7G8R+mhIZXNC0bj7y6jgRzgkOqV+V6DeAnbdVXJ77/3BxAycI=
X-Google-Smtp-Source: AGHT+IEDMLcOKPVG8HiLsZVvaamd2lro71ACJjACOM7U6z8LlpUPdEr1HX0YliO/Kpvtb2UYESt4Hg==
X-Received: by 2002:a17:902:ce02:b0:1eb:57cb:4c69 with SMTP id
 k2-20020a170902ce0200b001eb57cb4c69mr4526854plg.45.1714295187923; 
 Sun, 28 Apr 2024 02:06:27 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 bf6-20020a170902b90600b001e86e5dcb81sm18096416plb.283.2024.04.28.02.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:06:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 18:05:46 +0900
Subject: [PATCH RFC v4 6/7] virtio-pci: Implement SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-sriov-v4-6-ac8ac6212982@daynix.com>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

Allow user to attach SR-IOV VF to a virtio-pci PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index eaaf86402cfa..996bb2cbad20 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2245,6 +2245,12 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
+
+    if (pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
+                                                 PCI_CONFIG_SPACE_SIZE,
+                                                 errp)) {
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    }
 }
 
 static void virtio_pci_device_unplugged(DeviceState *d)
@@ -2253,6 +2259,7 @@ static void virtio_pci_device_unplugged(DeviceState *d)
     bool modern = virtio_pci_modern(proxy);
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     virtio_pci_stop_ioeventfd(proxy);
 
     if (modern) {

-- 
2.44.0


