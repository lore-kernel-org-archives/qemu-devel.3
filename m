Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ACEC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZET-0001MD-Ka; Sat, 17 Feb 2024 23:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZES-0001LY-4C
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:52 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEQ-00041m-Hg
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:51 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59fd6693ac1so18862eaf.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232209; x=1708837009;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BaCmMEn+CDQfp2DNhTw9K7jZZQfvGGVZ+DKaMJUxrD4=;
 b=QUQdLIidnjdLp3N7oxI+b/k+BQQKnk7z0slhzlVnNAVm3sGgalfI8M9EykpqhIIo92
 ESgt4RU7Ck9p/B4/ZlLY6Zrc81JceqBx4q6e/CxIAFKeFQMNKwrlip9ksPpxBcViQr/r
 EyJXgCNac6cbVpyyp1Zsa+vG8M2rLCuiO4OtWrIYCJiBH4NzSIlDZZU9Q+Al0smYCiYJ
 rl1LS6fdnoluOB6JR4wDCsZBB3ZeIh4aCrbvtoTDLVpMgK7JRROqdNO5q8q6qWu4sxrw
 NLLYwLzawHtQQqE1/sbONQJXAS+zRqWJl3NrVEFSn/O2k6WKUEFzd7greURWTwtRfG4s
 AOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232209; x=1708837009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaCmMEn+CDQfp2DNhTw9K7jZZQfvGGVZ+DKaMJUxrD4=;
 b=mhWySZ2IPMUZF+FZch974FpbaGPJPdcgakancPEuEWE1OaPqC+gndUkeTEQzfvxbku
 R6PLMsQ5VSBXQOt1EDJpMNOC/fjWXWHAeyMjuLRDrApSeGqjqFVRC1iDarxJZB2DxkOf
 giL2SBS14/U7Wv4ST77t8/AZdKjlvagofJCj7PSzN7mwwr5+opwTAkANiOkitHhIORHN
 uE9fR7GeZpoxkNk5HJ6edYxEDZ3F/8sbe3X/mwFXeWSj4XOrRjKpTjs1GPM43ih8oDJd
 NJTxavCo855Xc6cUvdH7xWNZSCUC9H+aSrjZA2GfYcO1zX0YNVV5yYA5oRB9J4kebRgm
 uaSw==
X-Gm-Message-State: AOJu0YyvbFPEnwm4e8CayywiY2sLjvjoh2D7DCwDh9G0nSt7N/fFCKrT
 5aAmkS3AMlrAxF2Sh0VVW0AqjxEhyldsvm4RmwevyMTebWW7A+TG6+VvU5T8ugY=
X-Google-Smtp-Source: AGHT+IHDlGvYAmrrsax7qRZ/bNJU5MjCoAKtoH3OwUpUDvYTGXKlnxCAjdAQUV9bZmds6UREDPd/lQ==
X-Received: by 2002:a05:6358:724:b0:17b:3369:ef32 with SMTP id
 e36-20020a056358072400b0017b3369ef32mr2389749rwj.27.1708232209192; 
 Sat, 17 Feb 2024 20:56:49 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 u4-20020a17090ac88400b00296f3401cabsm2621911pjt.41.2024.02.17.20.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:56:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:08 +0900
Subject: [PATCH v5 03/11] hw/pci: Use -1 as a default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-3-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently there is no way to distinguish the case that rombar is
explicitly specified as 1 and the case that rombar is not specified.

Set rombar -1 by default to distinguish these cases just as it is done
for addr and romsize. It was confirmed that changing the default value
to -1 will not change the behavior by looking at occurences of rom_bar.

$ git grep -w rom_bar
hw/display/qxl.c:328:    QXLRom *rom = memory_region_get_ram_ptr(&d->rom_bar);
hw/display/qxl.c:431:    qxl_set_dirty(&qxl->rom_bar, 0, qxl->rom_size);
hw/display/qxl.c:1048:    QXLRom *rom = memory_region_get_ram_ptr(&qxl->rom_bar);
hw/display/qxl.c:2131:    memory_region_init_rom(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
hw/display/qxl.c:2154: PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->rom_bar);
hw/display/qxl.h:101:    MemoryRegion       rom_bar;
hw/pci/pci.c:74:    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
hw/pci/pci.c:2329:    if (!pdev->rom_bar) {
hw/vfio/pci.c:1019:    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
hw/xen/xen_pt_load_rom.c:29:    if (dev->romfile || !dev->rom_bar) {
include/hw/pci/pci_device.h:150:    uint32_t rom_bar;

rom_bar refers to a different variable in qxl. It is only tested if
the value is 0 or not in the other places.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca61..47f38375bb09 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,

-- 
2.43.1


