Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251CAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICi-0001R1-F0; Wed, 28 Feb 2024 06:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICg-0001Qe-F3
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:26 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICd-0007G6-Ph
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:26 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6e4b03f0903so696715a34.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120062; x=1709724862;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=53XyZW+eFVvoAPfI8083D4zbyq4zLHK5w/Vl/6iTbj0=;
 b=x+bvAwc2UYIy5z7TykwnOxdqo6y6AxoLtRZrVtDWwj5axCvenOqBMdVAe2gK2rgTV/
 7OIaK8U26RnPyB6Fnw5AznIGSjCb3oNLCl00Ysmck3YhrxnymRZ7R4xn/RDObTZuSKlf
 CdpMmtgV+QIaPJ+VTFJPJayGxjl1kzKNGcO9+W4Hs9n8qcCy8O6iZyi3gzNFc1VaIOUM
 FUexy3NIYiDiCikDCuGTkMWuU47VRWJclUS49yHVQdediGLsxBmrbI6vi4tn8NowkWaE
 m01l1FhuJZxI9wLBsdw4jyhL8uOHLgXvs1torArAqFJfJ5k4ekL+OB8Ki4sAedHRzEvE
 jJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120062; x=1709724862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53XyZW+eFVvoAPfI8083D4zbyq4zLHK5w/Vl/6iTbj0=;
 b=qOX3IYZVrRtG5miYpOlPt7AgZl2iSbXftnGo7Ayg+7xn3MEbCIJ0NUmQL+/aNeyKL9
 CYQZtJkidgZLwosdOVGmsJKhapKuk9NRWu+xhEOOwSo+F+qH89J1LE8IYGpuzD/pHHub
 VQVPWrOfpaQ/zKIQm5zoxhtQ/PadZ85XT4Tt/OWVP4T+icFKPase7X1E/cvv3NjuINgQ
 Y0BbrOQnJhRzABis7q+kdC3o5xa9sv0s6wG2eFvbQmFV017hv1npRbMJqkRVAhQ6Aj2R
 FnTcrOupvBdxo807dtzF+RgKevJCJAknEWyRS9zyKMjAWuoykmMeAnVDoIa9p4so7QqD
 R3rA==
X-Gm-Message-State: AOJu0YxKL3DIZM7mk8yUgC1km3z4Fx0FnMHRFQHmid/jxbNAb5xQqDPL
 Z2kyTFLirT5cu5rDY8X00JAHBYw9KUVUyo/WsUJh9mSxHw2dstAAG92IvC74BjY=
X-Google-Smtp-Source: AGHT+IFIt/H0kJ6j7elWz2sy8w2zoDCZSYOwdSHkT59AjYX5MGpCW+olhyG2Et+2a8z11ebapiqUOQ==
X-Received: by 2002:a05:6830:144d:b0:6e4:696d:14e0 with SMTP id
 w13-20020a056830144d00b006e4696d14e0mr12703758otp.37.1709120062354; 
 Wed, 28 Feb 2024 03:34:22 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 c2-20020a63a402000000b005e45b337b34sm7432721pgf.0.2024.02.28.03.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:22 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:22 +0900
Subject: [PATCH v8 11/15] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-11-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 793d03c5f12e..d576a8c6be19 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
+void pcie_sriov_pf_post_load(PCIDevice *dev);
+
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 750c2ba696d1..54b375da2d26 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -733,10 +733,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
+static int pci_post_load(void *opaque, int version_id)
+{
+    pcie_sriov_pf_post_load(opaque);
+    return 0;
+}
+
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index fb48c1a18c9a..09a53ed30027 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -239,6 +239,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     }
 }
 
+void pcie_sriov_pf_post_load(PCIDevice *dev)
+{
+    if (dev->exp.sriov_cap) {
+        register_vfs(dev);
+    }
+}
+
 
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev)

-- 
2.43.2


