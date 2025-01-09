Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0BFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm5A-0002gH-Vh; Thu, 09 Jan 2025 01:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm58-0002P0-4x
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:50 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm56-0003sH-2i
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:49 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso8105225ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404306; x=1737009106;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+xp+DEwbI5wkbMS6fyz7DFx68KMf/qYL5ezviCJNhgw=;
 b=kRqHV4Md2JwJjrkn44SRN3W5wGrztYGX2vG1uphRdJhvzpnpdYht9OMZ1rGnc4fQ+e
 e+giUcJMHGWklYCSDyYsSdvwyzHbt5PFFvZb3o5TohVvy2XfGvMu+8gDKtvIeP09zlu2
 RiPhgqNJ9A0hX9EQcpQS14lx/TZVBpTpEFHqOH/WpQrjatOz1BM6xlkvFh3+a2mASkY5
 7JLnzdYbkwxE5W1atCjjsfbmOxlDC2+JuaEe0Ln2RDFxlLeMzml855nl5GsreSafaaYK
 OD8ZLssWGnchdoLVfKpv4sFjQrdl/8p3W5iLYHHZPlLlr03m6SrEKcaj6XlYqldqnto+
 Wxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404306; x=1737009106;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xp+DEwbI5wkbMS6fyz7DFx68KMf/qYL5ezviCJNhgw=;
 b=dTAcELENNtdnasxQwA/cL/njCB+QfsCeWayyx1DPrgzZcSkmci4kpZ9h7I3/ZU5Orq
 A4Hx2B3JI+ODYKQgV/jNXf4r3EylGyDgg5gJXWt5JXhliJt65JmUOyjTX4hPRJH8BWfL
 CqoV4cy7CCXphtds1G1YLZnBF5YKcBsPar5s3KDmpJykW3PbBahdPDQauwd/SnKkmNTc
 WERCM0bWXLoM0WygMgosMLtneEVCG+8/gIo9/4HH3XOIT5qmySQMW5zV1ZVZ2jVS/rpj
 3c9wqD1uHdiwzeaPA6/g2LjJkWZIPfeD0au6pRDMTpIJSGBUPRdEtojUDqjbYFmy+lb/
 7I6A==
X-Gm-Message-State: AOJu0Yy/ZelnT9uEf+AaChtr6fVEh9Y5oHQFw47YHV5MTEJ7+BsG2bNH
 eOrLaGX2bjvWd2DThxd11nH9iUe08GGoxotOiDO5u4gXbpNVhZyCElQ3Mg2bxIk=
X-Gm-Gg: ASbGncuiaum0355ojoTSWhOGVQ4RzNU+NrLlpq84lS0ATHekhHDY9io7Vqf2BuBsx8F
 CZxGyoVx92MriMngE1t422IPcqRplb0kMYZe/oq3/k5fu/4nOHGZet4IkNW+jgleiH7rz9AFSdw
 yTl9/nt0Eribbk3h7Cn4kIAy1GRi1R/L+dHbSHI0cvBbCE+C8mYHfaVZwgiMlP4gq3eO/LZkhPp
 jCnq8vqxWvorpl21u6Cs5rFVOtuOgAYt4+x/NFVP+7yC14Mh0edjqQtC1s=
X-Google-Smtp-Source: AGHT+IEJhV7ycTUWx0RfFwIwcyfU97KtF+txNOGEWZsjSRmrfBnlA5vr8hKHVMuW6jYRIe6HWDw1oQ==
X-Received: by 2002:a05:6a20:72a1:b0:1e0:c8c5:9b1c with SMTP id
 adf61e73a8af0-1e88d0a1e5amr10248610637.9.1736404306615; 
 Wed, 08 Jan 2025 22:31:46 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a31de807786sm520281a12.76.2025.01.08.22.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:31:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:58 +0900
Subject: [PATCH v19 13/14] hw/pci: Use -1 as the default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250109-reuse-v19-13-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci_device.h | 2 +-
 hw/pci/pci.c                | 2 +-
 hw/vfio/pci.c               | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 66b6c08b0118..add208edfabd 100644
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
index f7445aebadbb..dfd71f8918c3 100644
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


