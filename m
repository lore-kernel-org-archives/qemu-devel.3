Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A865BC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9le6-0001oG-7E; Tue, 29 Apr 2025 10:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9le3-0001il-Vl
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9le2-0006Mt-6p
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so59777555e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935748; x=1746540548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BkDThoIzdV48soT64XeZ7dLWYwQOfmi2dWyVwZ8yvw=;
 b=Yak1JtEYB7/rU6ct+aGcG7Tk4IRDAmsZREb2xKrC+G64CMQYDAUB49PLQfmxo4RPqg
 HfYCTyAvkbkMyvYw0zH4Uh6FJy1L/F+9TXkLIeyTrmxtVXDQtGSbxGnfzrDzPv/ZnoQM
 hIe84wuK6Ez41+gTq7pfRrk2EPU4TOaCb1oaIsV9dQdjJ6/a5x+NrU+inqk7QntVGMi+
 jkY8q53ISnoVjc1BWXObdRd2R2aiCznsksSVTtCNKoV3BDoQfayJ4VX2K6iCgyuoOKSS
 DUN8+qXRYc+SRSQ6NMlXrIZg+ymvSDCAQ1CTswmXUE9oASB/6cI7tDClLFoFPLQAksCg
 /ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935748; x=1746540548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BkDThoIzdV48soT64XeZ7dLWYwQOfmi2dWyVwZ8yvw=;
 b=jNehzPmRxAWBeVu1bAwau+rjm0ALI7afdaOrUSORBpAIzxZmk0FmDPrX4o5wlzwBra
 6FC6rFPl4H0B8v3GjkAcoqjZ4pM7xrThS6OmxEmwqJCh1+yBd4XAkQ6SzCkRND4LfGHO
 FKYLtko1mMcZqBPpcX+h+mR+srBbvAOp+vNDbKwhJuMcfMQYGhQdZB31/ECmwQsCnhfY
 TjUUZA0MlzLKAO/WJ2wLLKpl4jIiTRi16Vr9UiDrcEpuk2ziBTivKlO1IO2ibzZFl7XV
 L9CNzHkzj/KxfTcFRmVAsF9PCk0WDreLi4rCtI/yZP0wMp3oqfUCYvugaCMIdVu3DDPr
 pfjw==
X-Gm-Message-State: AOJu0YwfmxW7ZRB+pzHHuy4wK8E5HXGjsLsPI8UCVChmNgo54zpv74nI
 vO29rx0ABG7Cayh5+Lcjr/H+ocb4OB7Y5nTHJzNK0FO3eoXwCBsjlVl2goaoiIZMkEJNgVr/9mG
 t
X-Gm-Gg: ASbGnctNVvhxN1OpyzmrD+Mn6nNw9RoQ8fqLT38BbJZqfXU7h/te4Pxt8LyD2ESUZ0j
 cVLM+iAuHTs7+nVepQWWCJedfkvfF1Epq7CE30VvVpV/qj8IrFB4o0wEXZ92+zblYfKpMmeabF1
 a3wHL5u8Lm5SeE1nIH+YYawXbItRole5ueQFOc2MFfyQcJvMj2JgTaBezmiQsHoKSxKHJaZyVSX
 fqa2hSWp79N7fRz6vbuNqFw17hKlyWDP8+4JF6EBpzFQWyvg915wDqz+N+JwSSvmYuVIcjynSsC
 +WTm5GcY9TbxrJpjJykAR0gBXxv/uuWyh1noy6cRG1ovx7F6ykuutqCKsvHE7SJutbtd4mTSBwW
 Fj+YEjzdEXa8v0gmOn8Sx
X-Google-Smtp-Source: AGHT+IFbgdgq3YX3mZzTAVSG1Sqr+MjwfiL6A7LR/kE4dSTV7LwM2dHShhBtv7zgYeKGghEghADm8Q==
X-Received: by 2002:a05:600c:1e19:b0:43d:fa59:af98 with SMTP id
 5b1f17b1804b1-441ad500331mr25384995e9.33.1745935748163; 
 Tue, 29 Apr 2025 07:09:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e0241sm191035395e9.37.2025.04.29.07.09.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 08/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
Date: Tue, 29 Apr 2025 16:08:14 +0200
Message-ID: <20250429140825.25964-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the hw_compat_2_4[]
array, via the 'x-disable-pcie=false' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_DISABLE_PCIE (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index d39161766e0..f962c9116c1 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -33,7 +33,6 @@ enum {
     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
-    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
@@ -53,9 +52,6 @@ enum {
  * vcpu thread using ioeventfd for some devices. */
 #define VIRTIO_PCI_FLAG_USE_IOEVENTFD   (1 << VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT)
 
-/* virtio version flags */
-#define VIRTIO_PCI_FLAG_DISABLE_PCIE (1 << VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT)
-
 /* have pio notification for modern device ? */
 #define VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY \
     (1 << VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a3e2e007d6c..8d68e56641a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2349,8 +2349,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
-    DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
@@ -2379,8 +2377,7 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
     PCIDevice *pci_dev = &proxy->pci_dev;
 
-    if (!(proxy->flags & VIRTIO_PCI_FLAG_DISABLE_PCIE) &&
-        virtio_pci_modern(proxy)) {
+    if (virtio_pci_modern(proxy)) {
         pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
     }
 
-- 
2.47.1


