Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE71AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOk3-0001jc-Nm; Mon, 12 May 2025 04:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOip-0007rO-CI
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOig-0001lg-UP
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so28015605e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039265; x=1747644065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcBK5F9fX1ixcWZyQOGrUKdvI9t7kjvAceG3Q+c4oSA=;
 b=mEuDiEeHi7MWRqxJUUXRCPVdwui5iBIR+6m7aYiV52hcDB+Huze7fNYDyRyHS6fYDb
 2q6CxhS4w3eDXJXS+csy/VtGMRR5Ahi9g6blGBEdSVQEJbG2DBx2BPeo4LBhl5eGv9eJ
 /1Ng/u3qmldrYSP0qVCAU42L7L8EpJOnCNPns39xUw3em1R/oE6ZM04RAgaDi8fwFnej
 OZ6yBnBl0mhXDPdoWWhF7ZFyCvpLMk0hSKyZ0yvKWw211n9/L1g/D7wi2+UHzK5hlU+Z
 e9D5WxPNHXXWjHSZHQ+A6WLogmYx9xKq5/CLjXiPq51VrTKOYep9PxL1nLYhgVj2Z6Dj
 cLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039265; x=1747644065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcBK5F9fX1ixcWZyQOGrUKdvI9t7kjvAceG3Q+c4oSA=;
 b=S0IZskqPb+HD8QwpCcn9w0OxXi48vxV0R4SXpRQjPq4VE3wg+YFdatqIKqroOkrini
 WGTgRuBLLW7avkD19GyJxzmoqhrlJyyJI80LT8fK4Vj274NhRIJ8rJMCn0eGF0xnwYbN
 6HyIFh2II9I+ExTB4PtFT13ulK/64MR4FWBmBiHlYxSskhO5hanZ6ducQmqC5s6N+93w
 nQmjAyXdpqLz/TjHN7mVubXaJPnAtw4WHUEFWa4DBh3Sh6ORvHibEW2tuE65Ldlg+pRw
 j9H89/5WfWNmVv4wRPuQaYcNf3Qz5XnWWDipajr+sx3kt3gUZoJRqsTIBZvMoc5cixMQ
 A/4Q==
X-Gm-Message-State: AOJu0YxEG7kJj9b3AxEDRCOZuMSdVlt8JU6p4wDHxqWlDYYGdAX8RJhA
 o83Ol96XupOE+gUyViriBkaentfNU2D23EGCr4lRwfd5QDizZRJDqbaj4/BMS4Is1z3KQQ7IAQ8
 L1r1iQg==
X-Gm-Gg: ASbGnctHMXj9A1fFQcMz9hkv4VxgNDc4hAy24dACyNg5X/MNZFbOdOCREPbfCbVh7ZO
 HxqDiZMJn8KJLsTodltZGNjgSFKZnIDgg6AGfZS9+Rm+FaN1Mal1OeAiq10eM0XkPlCO/THah25
 XikO+XRbNZoUlJQeKo+4WEmFINzTbhKB0BSvJ8b5Raod0OdcSmSibzzAcfuraFAak/OZ7jD2cP5
 X0MMJJNH5IReMFABmMsjrAui7hbYAMlQcuihicJRvXfW9t7pgdvWjlcDh8PY1FPZ/E+MchueLrM
 OP4wPZ7PGI8VQzd2EhTpemsUe1LinGIymYfeZgBEV614V7KVoQEXj4LSS3qGVo8cLfDS7UBtf/l
 uRWBE1MeFZ9fdZtpjBUJxdW8=
X-Google-Smtp-Source: AGHT+IH5E51ONDcA6ic6S7uvbrQbDba1vcCY6Ax9LhiADjB6LEgAJUQZ0mW9Dwy9f3FEBxHlOrpSjw==
X-Received: by 2002:a05:600c:c0d2:10b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-442d9cac8b6mr60485795e9.17.1747039264864; 
 Mon, 12 May 2025 01:41:04 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67ee33bsm117390175e9.20.2025.05.12.01.41.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:41:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 08/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
Date: Mon, 12 May 2025 10:39:37 +0200
Message-ID: <20250512083948.39294-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


