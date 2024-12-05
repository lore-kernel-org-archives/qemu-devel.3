Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5064CE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9Wo-0005yP-Pc; Thu, 05 Dec 2024 05:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wm-0005pe-6W
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:12 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wk-0003dn-Iu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:11 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-7fc22a88bcbso621892a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396168; x=1734000968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbyhL467kLFoNyl59lj+CqWMKUpCY5M1py2Usy4VavY=;
 b=QKFPVOzwsz1cJL6QUY7vasd1JfKzjHEKKsyOXzLP0DYKPxTMP41Utxrn7Oh+nbrNr2
 yEi7hGfKfVxAZfebwNg/g+wDZZkzq9yZZarrX6lc8c4tYO8tqBT9sahOwj54nFTAOKKK
 qJQQ2IOFjsxiUvJWTzc6QKH+XSGTa5Y9j/a3lxjZRi4ab5iZ/xQvXOc8f7LkELMGhKIE
 CNuMge4sDSjhF71fsiOVTqBpAxm0rWWyAgx6wRibaANp68lTUi77+M5tMUcZopTrGjE6
 DDKek43oK+pNMr7Htn5ml9yDhVeLs8WU3JSbfCUeohlSdI3JEH7PbIZ0PaiSI+YMpv24
 JfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396168; x=1734000968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbyhL467kLFoNyl59lj+CqWMKUpCY5M1py2Usy4VavY=;
 b=khkaW+FxPQyocq/RrX5lfnOcmVwLsiWBzW911Bdj8+uE5J+RZ8CQeAyhnYh9of9DT/
 GF8Eye6fmg3TTHyEwm/nAjthvnF/2fKtVn+HBUBLsH4DIkECV5CJm8mE2YDYaWJQP5d4
 RAAUBATqkWNP6Tfi1z9+dz0qnKfs69dutgCSO1odCM+CV+/diijETAIb2py72upeQEUy
 H7bA6Du8TsakEFMXoaOih88XweTPin6ttMEfHIRyQo/FeZYMwSmFf8nQxFyasEmegx0A
 JWocWHW3SYqCIwVO8exU3TGbd261qSZ4e5x8ErnYa6UTQabWHwJU7WhgeMeBQzROcv3u
 jInQ==
X-Gm-Message-State: AOJu0YyQUUwmz6ANSstYyV7s7lSizF4GIy2eDLh2UKzAw+v9ide2kNvS
 mI0KHwyi900pBB3zB0HMrQ5tHv5ivnihrveUQLqbJsEvyL94veQlXhm4EV7+5Q==
X-Gm-Gg: ASbGncsPqeiu3QQgllQ34Z/3TPwEdBJDhqBA+lIq0yd8Ghrh0Ki8qYtRogCRjulTqxm
 AsD1GQh4uW/JRpbD6vTeq0jFxoLcXfKRTCC8BPTfXDlvEUtdYKxInthfT2Nv63FjYsed4XP1JIo
 gsAfcqlZkBuqYHbw5foraU67fTW9Kf+qOHFXEYBkLnbgPJlDymbV4nPoMThkn5zWjUjBAGwvk4C
 NXMwynrqYwh7mA7LyFuRUZ4raMlNPZzcAuOf7u7+17Sbcs/qHa19qtPqA==
X-Google-Smtp-Source: AGHT+IG47WGTWjdqjMTm9Njiqcark6Mz6UkfHmV3El3oV95OeATOQQ1ZWGxpvGKi+pdlX5DAiitt6w==
X-Received: by 2002:a05:6a21:99a0:b0:1d9:780a:4311 with SMTP id
 adf61e73a8af0-1e1653b9e35mr14590656637.18.1733396168246; 
 Thu, 05 Dec 2024 02:56:08 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:56:07 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 07/10] vfio/igd: add macro for declaring mirrored registers
Date: Thu,  5 Dec 2024 18:55:32 +0800
Message-ID: <20241205105535.30498-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x541.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

igd devices have multipe registers mirroring mmio address and pci
config space, more than a single BDSM register. To support this,
the read/write functions are made common and a macro is defined to
simplify the declaration of MemoryRegionOps.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 60 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 49b6547776..18d159aa8e 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -421,16 +421,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define IGD_BDSM_MMIO_OFFSET 0x1080C0
-
-static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
-                                          hwaddr addr, unsigned size)
+static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
+                                         unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         return pci_get_byte(vdev->pdev.config + offset);
@@ -441,21 +434,17 @@ static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
     case 8:
         return pci_get_quad(vdev->pdev.config + offset);
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config read at %lx, size %u",
+                 offset, size);
         break;
     }
 
     return 0;
 }
 
-static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
+static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
+                                      uint64_t data, unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         pci_set_byte(vdev->pdev.config + offset, data);
@@ -470,17 +459,39 @@ static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
         pci_set_quad(vdev->pdev.config + offset, data);
         break;
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config write at %lx, size %u",
+                 offset, size);
         break;
     }
 }
 
-static const MemoryRegionOps vfio_igd_bdsm_quirk = {
-    .read = vfio_igd_quirk_bdsm_read,
-    .write = vfio_igd_quirk_bdsm_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
+static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
+                                           hwaddr addr, unsigned size)  \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+                                                                        \
+    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
+}                                                                       \
+                                                                        \
+static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
+                                        uint64_t data, unsigned size)   \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+                                                                        \
+    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
+}                                                                       \
+                                                                        \
+static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
+    .read = vfio_igd_quirk_read_##name,                                 \
+    .write = vfio_igd_quirk_write_##name,                               \
+    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
 };
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+
+#define IGD_BDSM_MMIO_OFFSET    0x1080C0
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *quirk;
@@ -510,8 +521,9 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     quirk = vfio_quirk_alloc(1);
     quirk->data = vdev;
 
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
-                          vdev, "vfio-igd-bdsm-quirk", 8);
+    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_bdsm, vdev,
+                          "vfio-igd-bdsm-quirk", 8);
     memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
                                         IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
                                         1);
-- 
2.45.2


