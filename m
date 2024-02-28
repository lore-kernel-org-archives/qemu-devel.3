Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D397CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIC9-0000ga-74; Wed, 28 Feb 2024 06:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIBz-0000bI-Hk
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIBs-0006YA-Kf
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:43 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc418fa351so5459055ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120013; x=1709724813;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WM47wdy4Cb/mp1eobpOxgb3rFoDQbhprTWLPDZcJhAo=;
 b=LdOcJL84pER8wpeoTjZpI8Pt7UUv7JwzG8WuxghqnUKLhyBPqts25BFFGVB5j4dlTr
 wJEiRE3owiGAOsR8mwDNWG+Yeyz8valATi+PguO+OFnaH6NdBWhe8blVd3otMZPhuNzP
 YYIruPV549hv9A3rGx0bvcf3x0Q3M14/g2UcmwdD4+dtcpq+HC38AgVupmFX99qcsF7p
 I3zDUhWu0iBAzivCRZNWrDk6hy3yCmi46h/sybA9gsAoc8M+6gX7BVw6IDXNcStNN7N6
 2hTVxjONF7L0Lx+UHZCs30PtHn8qMjM57/hjbgqVTZv3NbLdFVF7+AvNJoHM902b2muQ
 Sasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120013; x=1709724813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WM47wdy4Cb/mp1eobpOxgb3rFoDQbhprTWLPDZcJhAo=;
 b=xDE4cp0WRfJeP6+ss94Dw+ipiRkjUxVcmajtThZSF98Y29kn/7DlyOPCeWSE8xTYvN
 RJHhy/IPxquv7kTmRnCwZzayuprQtxKXlkSD384XleT2K5tBu3iOHBC4vzIz+KGJpKyP
 ++z/8vTzareZRRCknrkRpN1IlC6C7GE/uaXMwoQ381zfUpgFM3zVZt0f+w68st3Hoi4+
 lu1X0cOQI9ekZsDikiMXBbzxcycoglYdXQTwlwsrZKD0XK+eDR7N/XlOd0UHQtYZMefp
 o5jjrxRB/jWxIYERYM8FlIQKlRj9V7n5a0Z/8ypNeV6UI31Uvx7E1UOMCQpPmlfkjSEs
 yXdQ==
X-Gm-Message-State: AOJu0YxQiLtKupR/CGBBToAGvBnbEQTLjOnRRun0WQuWBIOYy5g467wN
 8grkRxnS3ByMjbaLJxDpj4lWTeVBATj7OG2e/fhbnCZsFW3e47cU8I/7CpS594g=
X-Google-Smtp-Source: AGHT+IGQpgps2S10/Nvj6qmU4b+svH/KrNWP4jZCGiGnOlKRhuNBcpWRl2cAJy8oAqpf9d3M9OvMXA==
X-Received: by 2002:a17:903:234a:b0:1db:b8dc:a016 with SMTP id
 c10-20020a170903234a00b001dbb8dca016mr2949665plh.7.1709120013303; 
 Wed, 28 Feb 2024 03:33:33 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 jz5-20020a170903430500b001dc41904d3bsm3128601plb.61.2024.02.28.03.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:33:33 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:12 +0900
Subject: [PATCH v8 01/15] hw/nvme: Use pcie_sriov_num_vfs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-1-282660281e60@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
configurations to know the number of VFs being disabled due to SR-IOV
configuration writes, but the logic was flawed and resulted in
out-of-bound memory access.

It assumed PCI_SRIOV_NUM_VF always has the number of currently enabled
VFs, but it actually doesn't in the following cases:
- PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never been.
- PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
- VFs were only partially enabled because of realization failure.

It is a responsibility of pcie_sriov to interpret SR-IOV configurations
and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), which it
provides, to get the number of enabled VFs before and after SR-IOV
configuration writes.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2024-26328
Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/nvme/ctrl.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e9e..7a56e7b79b4d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qdev)
     nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
 }
 
-static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
-                                      uint32_t val, int len)
+static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
 {
     NvmeCtrl *n = NVME(dev);
     NvmeSecCtrlEntry *sctrl;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
-    uint32_t off = address - sriov_cap;
-    int i, num_vfs;
+    int i;
 
-    if (!sriov_cap) {
-        return;
-    }
-
-    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (!(val & PCI_SRIOV_CTRL_VFE)) {
-            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-            for (i = 0; i < num_vfs; i++) {
-                sctrl = &n->sec_ctrl_list.sec[i];
-                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
-            }
-        }
+    for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
+        sctrl = &n->sec_ctrl_list.sec[i];
+        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
     }
 }
 
 static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
                                   uint32_t val, int len)
 {
-    nvme_sriov_pre_write_ctrl(dev, address, val, len);
+    uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
+
     pci_default_write_config(dev, address, val, len);
     pcie_cap_flr_write_config(dev, address, val, len);
+    nvme_sriov_post_write_config(dev, old_num_vfs);
 }
 
 static const VMStateDescription nvme_vmstate = {

-- 
2.43.2


