Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD45AE7717D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSI-00071W-Db; Fri, 06 Dec 2024 07:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRT-00061k-4c
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:19 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRR-00046L-93
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:18 -0500
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-3eb0fbb0f62so690153b6e.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488095; x=1734092895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Afev6en4kR+CrZleuto4wB3x+yzqkCFox++dU9LzUsA=;
 b=P23Rfi9xhNG28NJr6zpJIchfXK1aaJETWfDhv56f8vbq7+TJsI1FWd5oNbv1ukZ8/j
 voypnwV2lPNqKkCoZdwOKkEFJWJpLUbE6uF5jRL3nxUBCopdsXuPyEIuN2KInu5wgDoD
 lCKLw2n4YWPJ+WHMnk+tdGAB3Eg/3GITmdlCfr2QzlvsgoEEI4s7uz4Vkm7WCGN+m10X
 luxmAVimAL5WBiNUgo9y98g11gCMMJeg2FfgrjyakT/GhZOGf9blU+1aVvve37gVbDuc
 GB6okAHwTQke8PT85MZZFmC6MzolMdLHo7DzqHrIUwpjcv5RQIxhJpZwpTfEZn9/YPYM
 nzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488095; x=1734092895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Afev6en4kR+CrZleuto4wB3x+yzqkCFox++dU9LzUsA=;
 b=DdN9U9cMlXIG9mmNj2lKcsoqcdobL/LlFKgRgK9M1tPfQlY/ygZ8I28PIvWwoOx2bn
 Odw59VETJxqEBMJxZ4PRVsMmtTCj1sd3IjW1LgXrxeyCvKGzedBZBmpQkzM7g89/47N/
 xRi7x6tghYLhCGYWZytDicOjFw+H8/G22HkueeVIJiYPLHUa/ci32qkrJQWOgLKkabjG
 7PtJ8whW6OFqzoMcC4ykdbDFnOyhNT8WEtXlkvy/skXWbpYqsX8jm4vuBWZPEFPEEXOI
 sCduiKtudlXpPTNmffO8DsF46vdrjhjiYN32SdbfyywgvMjX0HazE1acOKZqFpQNYdO/
 cqdw==
X-Gm-Message-State: AOJu0YxQgTDmYNxquQ8ulgcF+3ZlJolQEroxTjoeGuHCtiaUlYuTWh2M
 GEY8H9dqYCKgOb0ShfiJ3zslwjrtDhI3+w9PLJzw4wWxsIbptzo=
X-Gm-Gg: ASbGnct2iM6oJ0N5cJ6i3F13T5Q9sfqu3+Lfsa2mGb3fnUNrkMtYmELS4mi2GemQe4x
 fQsM/C/+MWflAt3G+s0RFeXhvZkhC7IJL09BWxYnHDnt5Ju3GEat4xI/R4uip06POzzAVWtso6p
 C2KB8/ET/p/rSYI7CRZP4bF1yQfroP0I82Rk9XITdschK2RLEj9bs3Hi9lvaiwZ8UYmACfcbvqt
 7pPS5TvqHvjpMDPkQW76uRGEsXSiK/DWP5xeGrFJMjvF1F9+TpyORhn4A==
X-Google-Smtp-Source: AGHT+IHuxfKktEOhdP2DbkvOOWn4bYe36TVICO/Y+sH28rjw0ZW2IimGhbngnzJ+0elPz1osV4s1mg==
X-Received: by 2002:a05:6808:3c90:b0:3e7:b9be:5267 with SMTP id
 5614622812f47-3eb19c1fff6mr2703917b6e.6.1733488095379; 
 Fri, 06 Dec 2024 04:28:15 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:28:15 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 08/10] vfio/igd: emulate GGC register in mmio bar0
Date: Fri,  6 Dec 2024 20:27:46 +0800
Message-ID: <20241206122749.9893-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=tomitamoeko@gmail.com; helo=mail-oi1-x243.google.com
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

The GGC register at 0x50 of pci config space is a mirror of the same
register at 0x108040 of mmio bar0 [1]. i915 driver also reads that
register from mmio bar0 instead of config space. As GGC is programmed
and emulated by qemu, the mmio address should also be emulated, in the
same way of BDSM register.

[1] 4.1.28, 12th Generation Intel Core Processors Datasheet Volume 2
    https://www.intel.com/content/www/us/en/content-details/655259

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 18d159aa8e..12e0553e83 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -488,8 +488,10 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
     .endianness = DEVICE_LITTLE_ENDIAN,                                 \
 };
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
 VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
 
+#define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
@@ -518,14 +520,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = vfio_quirk_alloc(1);
+    quirk = vfio_quirk_alloc(2);
     quirk->data = vdev;
 
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_ggc, vdev,
+                          "vfio-igd-ggc-quirk", 2);
+    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
+                                        1);
+
+    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
                           &vfio_igd_quirk_mirror_bdsm, vdev,
                           "vfio-igd-bdsm-quirk", 8);
     memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
+                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],
                                         1);
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
-- 
2.45.2


