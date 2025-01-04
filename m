Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B2EE77197
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyzA-0003Hx-Vl; Sat, 04 Jan 2025 02:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyu-00033s-G9
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:54:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyq-0003BQ-KO
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:54:00 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21661be2c2dso165192825ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977235; x=1736582035;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4T7+xpoh9Dmk1g5SU4jk8//FeoTKo7JN583Hy7sRWks=;
 b=Pn+AqYQED3Wd3QyOF6USuRCG0oY5TCn32jd2J91WOIZ/I/AbBh9s6t43C/KIBvwT/I
 D1MLFdx1bwtogqekCJRQImLbHVSW/caOIhaxnViWr2cgcFAwWO3LPzWktKTDf07x3p2i
 tpa8l2Vzs4LvSbUvfWDP2uJPH+P/q6U1bhF8zUJt6tcEDDrE91CIN0xDNHMnn8ZF5fsY
 T3Vv/9BV4clgUAKTWEICTsy06uchJz/1yk3nVJew/h8tp3KqqEP3GS9JbSILWhRsWTeR
 ZSBP1PtFFVepH1zpou9VgsqPelAa3aSXg2HPp2fpuR0qXz72C3NEvDrN5VPGQe4CeXzU
 SfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977235; x=1736582035;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4T7+xpoh9Dmk1g5SU4jk8//FeoTKo7JN583Hy7sRWks=;
 b=axyVNWFiqEYJqsVeVyK4JFTFXJsTQ/7TevBuNKHmlWp+AQkV+B9J1Oz27pwQx8EenO
 94unvh/CLrenYcAzUeMpJtderboEwUS+pRzFq16amjTvPLiVvgphgzODoqEANVJWmT72
 YL0XCH0bKoFYhcNuB0O3p4uWvNWFDndqRxlsvRD/wfm84rwn9co3mGBDM8mQKkHS4oIQ
 CvzrTOWdzoGy+6GUn7zDlMuBgBwo4F+cM1Hnb7R5Twz5BNo2Oi1yX4pXFOnoFRCFMmKr
 DQX48xsDcyeh+U1wsesDz+XjtCkwZV6RZ1E2sHh7YoqNnnWokKwsx1/Jj2gXHMdQCsuw
 NL7g==
X-Gm-Message-State: AOJu0YyiX4uRK0mqKIg2aikGuDB92ELdB7Fdz2Q97E2CxuaBnIQfzGA+
 MxyRLtkpnQRYkgTbmqYPjm2UBuVpqZZQvrhKVCjLfa9civX9F008NvvHyvnuZ8k=
X-Gm-Gg: ASbGnctQu4/SPqvQX9zCNUeFh9Y3E06MXysJblmRTHxrjkt2hUnnfHO+jF87yv8TD3F
 8WIOTXgTyqsXYdr8yHuVOhs876q4rDZiNoi8PTE6VTasf7Q6C1SOcnJM4JM53ndKL11yrFx7GHO
 YDIP3FuaAztv6xDGMnAFNjPmDvVJEiUnuhSvivRBeotJzlKeC1lI2E4UVjBdnGxxUYGHNWKGnkB
 S+O73NkifHdu5D5V/P5efgWlmhnm91scskGbWULcJPKIwMGRXRLnxsDYAxo
X-Google-Smtp-Source: AGHT+IF7zU1h8f5FnPqd4R3qtrmyjc/b+SpPqi7xy26IgaEAdzxrGxuuOCw39nYathvDb86vvtYLUg==
X-Received: by 2002:a05:6a00:39a6:b0:729:1b8f:9645 with SMTP id
 d2e1a72fcca58-72abdebf1a1mr78427109b3a.24.1735977234996; 
 Fri, 03 Jan 2025 23:53:54 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8dbba0sm28358450b3a.107.2025.01.03.23.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:33 +0900
Subject: [PATCH v18 13/14] hw/pci: Use -1 as the default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-13-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

vfio_pci_size_rom() distinguishes whether rombar is explicitly set to 1
by checking dev->opts, bypassing the QOM property infrastructure.

Use -1 as the default value for rombar to tell if the user explicitly
set it to 1. The property is also converted from unsigned to signed.
-1 is signed so it is safe to give it a new meaning. The values in
[2 ^ 31, 2 ^ 32) become invalid, but nobody should have typed these
values by chance.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/pci/pci_device.h | 2 +-
 hw/pci/pci.c                | 2 +-
 hw/vfio/pci.c               | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 37d88f0cd05b..613f78aebf62 100644
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
index 2724297ea43c..8f160c0c0d8a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,7 +85,7 @@ static const Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 17080b9dc0bf..ab17a98ee5b6 100644
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
2.47.1


