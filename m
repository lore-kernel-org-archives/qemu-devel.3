Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010DE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCQ-0002Ep-A3; Thu, 09 Jan 2025 12:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCN-0002EO-Hf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:19:59 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCL-0000ab-Mg
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:19:59 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so9707295e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443195; x=1737047995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Q9jLlzxL8Ky1CJr0jutwQaeChtyLfFwACEyWiRFh40=;
 b=irH9t4Co6pOxpFCOCF/IhakaPR1LEoAdPcdxmwaq/K/ucONvE2PLblkDO0Qj0cVN6q
 vkaVw5y/GLJWx34Tnl0gq1Syk8WSoyu3drxFxWsxpodAfddt5WbBNSZ+ng+yoZVpNOiI
 7eRNOKMzjUa6CSbjPMOy+O2yHKauOIUlqrorzlSXjk0jrVG+6XUtnSXtULqKa6Qergew
 IbUEEjnBSI+/sEmv8KdnbQaGhRdrlnBMlpJmdRKJLm7+QRi3R02ccR0+C8zNHgbU00ht
 dSM3RlvQiFJnE6XzUVBAXTF6hPEVHzYE1vodYJreKvgGovN7NfiuNTZIGISHhXqTS1ZZ
 n4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443195; x=1737047995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Q9jLlzxL8Ky1CJr0jutwQaeChtyLfFwACEyWiRFh40=;
 b=qUI5EYpV5Ltc51rgMIJEeXd1M7aMP5nJFLZFowYB4FZVcF54jgk1zNMjqLWIKHYUfy
 7JNOJVABKIU+1v/euCa9gXtZwKU9+MOQwZEsCpqJjGMrUFTyGmF1wwfUR/I49+qmwRLz
 mnkbBS5ttin+UGXmVr2m/Zp2idLoe2I4jScsIlLuClJ0FEMAt16XYsJ6yNQhTCET/i9H
 dFB3sJr86af2cDugyIpoAt1ldABC/ohVeGrfA8gv4uB+naijWzT6iyr7hEJGoG4PiJsA
 ZwTo96zTto578E06zT32K7AYjZ9vid6ghOaZ2jODwrxC/t6TLOisLPcdEknoj0JR9k1k
 +AyQ==
X-Gm-Message-State: AOJu0YxBpgmeyDBPgFrEbnlo75I7WCOwwAaQe4oIiYDQvUpSWEF0G/rk
 5ipEWtUwTDJAgcs6LGmZ+e9ZA8lm9GbNUPk0WJoYrea0az1OzzxJ0p33NjMYVYZT4b7ovBf94kK
 /hbU=
X-Gm-Gg: ASbGncsdwsJIvfAkcJpANnHVy93SghIGY8JOewIvTuDnSrjIqgxZwQmnRgBYtkyUOW/
 Xmp/S1sLUqfyXesruyRocfBaX2nBiIApyu6Lhw6morGFiOrDHz85+9Bzow05g56I5NezcF+9HVE
 KLXADgZCvk1TTnSxfq6PmGr3rHPsOePlBHkKdhs+QYt09QeAfIjtZZ/WGfMknINS1rpK4ZILers
 jw+OPxrfXPQ76uvPxKAFK6JdydoSOB8Htm+KUs3GIggjIrHcuF8tQWBeBk2LW8vwFtSbYWLlkzw
 GzaewqrnSYlZgyiG8A6N+Z8Gqx0qBZD8ci2R
X-Google-Smtp-Source: AGHT+IFIhoeE0zWkqWg5VfuT8yphcMYFOvW9uduyHsvWaejxfY1gFpAWaTMQTsVTUzkR21X8pUkzEA==
X-Received: by 2002:a05:600c:3505:b0:434:a7b6:10e9 with SMTP id
 5b1f17b1804b1-436e26a9045mr74163005e9.17.1736443195346; 
 Thu, 09 Jan 2025 09:19:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d74sm26954385e9.29.2025.01.09.09.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:19:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/11] hw/pci: Use -1 as the default value for rombar
Date: Thu,  9 Jan 2025 18:19:38 +0100
Message-ID: <20250109171948.31092-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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
Message-ID: <20250104-reuse-v18-13-c349eafd8673@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci_device.h | 2 +-
 hw/pci/pci.c                | 2 +-
 hw/vfio/pci.c               | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 8eaf0d58bb3..16ea7f4c19b 100644
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
index b6c630c3236..78907527f2e 100644
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
index 17080b9dc0b..ab17a98ee5b 100644
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


