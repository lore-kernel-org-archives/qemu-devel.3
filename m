Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D631C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjm-00021T-Ie; Wed, 15 Jan 2025 18:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjl-0001xw-KY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:49 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCji-0003tX-JZ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:49 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4368a293339so2429175e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983425; x=1737588225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IL9xNknrHx4T5kAU+oIAzW4K0+2aGQMD1Sd2Z6TukXk=;
 b=VV2eFLcsxYNMMYHRrgfoBsWzvB3qhmfIkU+c+MEpJcw7H0TqsWwfqlVENoYw/b6Ytn
 iMXLPiFiSjVW+FBtyHP7+3iAeD79XLX7apAu2qSngVrI2He9OQAuR5nPtX3b9wDOBT55
 LqijQrqDAl2KISVFH7Lm116XN/VATFcaozLgIQz6aktTEpWZCndv48awjdbrLt0nguHN
 a/QDGwtKDs1lwpF+ujcLEekz0PtFmNnzq0Vq2whr6fHa6GkZVRusCx9zs1MeoHZY04b2
 RUOlIlnRgWO0k/74qrA9tEX5be93K0cfz+1GuqWn0cJ2qhZodHHHXfDlBPbucYAR1nHz
 yyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983425; x=1737588225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IL9xNknrHx4T5kAU+oIAzW4K0+2aGQMD1Sd2Z6TukXk=;
 b=fzucF1/uAnpaaL2FY/53NgFeG6zAwg6OULUyWuKndMhfC++AYgkqClhzpgTuAgEdps
 GueQs8icgXSVLlsAqsCYHG8PuIu1Pa3hjmDUCSlsV2L6KLAfg6CnldV146lmPyfvpL2J
 WAI6YMH3td85h5e3Sv4cos6nmd4W0sL/09vammpZwZuft6LSCVqfmtuBaLyMBOa/klFp
 2qDOGvzqAt54lz+OBQsxXpKkfBjieRMBg7jZpvFex3nzc1kYt80zVVTzqs61FyDz0978
 AeuRkMGhACiiA+eZuO3AM0ZbX+AMwfoDKoTtarT4h2TBcUZO2xNQy+70HuxFPNoKcJwY
 svXw==
X-Gm-Message-State: AOJu0YwS/JraFsVkgjScjK7yRjg2ckH7Ok4h1iyHtWUYfJDLXUBMSkXp
 xcXxOB7hiGkB8zLutUjCAN5ueAJg79QWyX1dW8AJB4QDTTVdm2zwIuwIeJ6fnOWKZnWBKb2vPVX
 7QFU=
X-Gm-Gg: ASbGncvU8N+cOlGhv0tr1quIKGpOYwjpfxr4U7MG9G6ys8kkPCC1UfIUwuSJhInAmBp
 s8caiT+vtulNMSyyEjjkBH+dclx/oduOxMH0ny2Dw+QLuLZIamg1F+yKqe7W6xnAbgM7LNvrO66
 IdJjCk7hOYIEWOT7SiEfv4WTGXtBiNnhVeWJ+vyUQgbITpgC73NcP84rtm1obe2Yed7Thrj8awK
 c0ZzbCGPtYNo7UBrdf68WORCmcoT50zPtcHMDTxh7zwvhFgqSU9sbVdfUNzZF393yuzLbnpR4ul
 GJeS8oDHyn2CNNjcxBCoL4H0Hlsltt8=
X-Google-Smtp-Source: AGHT+IE2ywlAkhr/R8XaktPQ6n3w9t2r/4TYAGxOBfCGV5Yl+nyFSn/8q1sTOU3vIg45CVDJJj2zJQ==
X-Received: by 2002:a05:600c:3ca4:b0:436:6460:e680 with SMTP id
 5b1f17b1804b1-436e26c3331mr272269895e9.16.1736983424665; 
 Wed, 15 Jan 2025 15:23:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d012sm18779796f8f.8.2025.01.15.15.23.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 10/21] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
Date: Thu, 16 Jan 2025 00:22:36 +0100
Message-ID: <20250115232247.30364-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the
hw_compat_2_4[] array, via the 'x-disable-pcie=false'
property. We removed all machines using that array,
lets remove all the code around VIRTIO_PCI_FLAG_DISABLE_PCIE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index dd6eb9a4fc7..1ca7419cd43 100644
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
index 8dca3ae73e6..2f2c6b13863 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2347,8 +2347,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
-    DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
@@ -2377,8 +2375,7 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
     PCIDevice *pci_dev = &proxy->pci_dev;
 
-    if (!(proxy->flags & VIRTIO_PCI_FLAG_DISABLE_PCIE) &&
-        virtio_pci_modern(proxy)) {
+    if (virtio_pci_modern(proxy)) {
         pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
     }
 
-- 
2.47.1


