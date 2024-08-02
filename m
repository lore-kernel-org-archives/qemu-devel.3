Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB49C52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkhS-0007Vg-K1; Fri, 02 Aug 2024 01:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkhQ-0007KF-4A
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkhO-000702-Ez
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:31 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc566ac769so56957045ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722575969; x=1723180769;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+i3x/GdHilVxxuP70OvKDjvZUNatxzQ32Tx86w/1Hns=;
 b=aPk+CRZy6BkQZ/H6Ho0z/3Qx9odW5jiPw5XGHGsiZx5Z5cvsb/V9IwrjJCuBNKCuaq
 pa5URqYM06vwdenQzfzgBe7pyu9zV9LdcrAwT4BlOEajtTg8LYa8ZqmCoxUwt8ka9pKb
 SUSUmkoV1Mh2MkMhXJliZh78P9hMi8mlXmjXaJhLMhyJCTthvdGn21OP55vVvRts1eWV
 JBJwxJJC/bdD0UEeAQmk+jV8eY2uvJczOoopQZSd/DsC6HLdqh9GVna2Upw63AVfergr
 0LlNisSik/HQr1RDYe+8xLbSOpVx9GDrudmYZxH2dx1XJJBxs4dOEa9c5Aai3Lz7Ofem
 Hy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722575969; x=1723180769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+i3x/GdHilVxxuP70OvKDjvZUNatxzQ32Tx86w/1Hns=;
 b=ef/vDUDIGsgnfTQZN2yrzgjcru9Nl5wdNBePaliieFlhUcLyU189EujrsbLIKSGS29
 xxKqhgn09gFsGza546yNE64m4iyImvX6O40uyM2x5rsst3AwKoOZBiM2j6SIY917KVy3
 q7PXmFiEVNtROvILJ1lXSPAzg6lbLPjFVgse94sGzUoHaAT35VzLL3ag62yc5VMHSqiT
 kg5ILdfgoOOZEVJAuhNkcWQH9hcyYfwNkUmPXK/vmhWwDLJScXgA+D1mOI3ea3XozBiw
 zuAbj6qGR3AQARaWZqA5CEsd1E9Joa53Xi1VVzHt/ZG0XCJSaFenCcEcK2IYuq+HjLRT
 IngQ==
X-Gm-Message-State: AOJu0YwdsgpXtZuljbN+QaRZqvYJ1Ai4AnYf+cUKDjfKq4NSmenKKRES
 uav7HpGyd3JjpKM9gdrOILgOubZX9c6B+TvPxuCh5OPjzWS6lutMyvLDBxFD9Dc=
X-Google-Smtp-Source: AGHT+IHFklOY1ndd84v8L9jdyUXComkgpEIr0jwG8rI/UHTP4iWaIrO8bceen1mtvc3C7Z7ZGSf0Gw==
X-Received: by 2002:a17:902:fa07:b0:1fd:5ed7:19e4 with SMTP id
 d9443c01a7336-1ff574cf70dmr21303235ad.60.1722575969113; 
 Thu, 01 Aug 2024 22:19:29 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f5714asm8129145ad.85.2024.08.01.22.19.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:19:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 14:18:00 +0900
Subject: [PATCH for-9.2 v11 10/11] hw/pci: Use -1 as the default value for
 rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-reuse-v11-10-fb83bb8c19fb@daynix.com>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
In-Reply-To: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

vfio_pci_size_rom() distinguishes whether rombar is explicitly set to 1
by checking dev->opts, bypassing the QOM property infrastructure.

Use -1 as the default value for rombar to tell if the user explicitly
set it to 1. The property is also converted from unsigned to signed.
-1 is signed so it is safe to give it a new meaning. The values in
[2 ^ 31, 2 ^ 32) will be invalid, but nobody should have typed these
values by chance.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 2 +-
 hw/pci/pci.c                | 2 +-
 hw/vfio/pci.c               | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 1ff3ce94e25b..8fa845beee5e 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -148,7 +148,7 @@ struct PCIDevice {
     uint32_t romsize;
     bool has_rom;
     MemoryRegion rom;
-    uint32_t rom_bar;
+    int32_t rom_bar;
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be5295110..d2eaf0c51dde 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2407720c3530..dc53837eac73 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1046,12 +1045,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (vdev->pdev.rom_bar > 0) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
             error_printf("Proceeding anyway since user specified"
-                         " non zero value for rombar\n");
+                         " positive value for rombar\n");
         } else {
             warn_report("Rom loading for device at %s has been disabled"
                         " due to system instability issues",

-- 
2.45.2


