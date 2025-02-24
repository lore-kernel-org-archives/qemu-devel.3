Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A54CC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdF7-0007tW-Un; Mon, 24 Feb 2025 13:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDD-0005fX-HG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:54 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdD9-0003LG-4x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:51 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-220c665ef4cso82664325ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421785; x=1741026585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kLNEh9HDxPlg3F7QyIz3eXfGlUA0e6Zl/yhAOMn0zU=;
 b=a/GYbZhRe1mKFUpVmNub7cxjfbm0aiC7hPmquQA84tbxXRs1FkYqiBhEDz/DjsDOHa
 SXFY5WsZ6hikGbSF6wjEdhSrYiRQJ/anTMaWaJnxqkigy//w2gptfuONSrgCxiTGdzg+
 ZJHV/+2RI7fNJlbv49EVSSpngu+TqXrYKsZq/Yrryu5xz8SWeXnoiH52V9bxZ1Aroquf
 wF/Fexzpkqr7/g+N8j32WoZaQSwFkGkFX6Z+q+JDuLMRLzFeNrS3TL8uHgljdR5Mo0fE
 6PIJkonDuuI1HkZdWO7HQK1uKIs8ax7yX78tPDLqNmsjOOcCaFsZQwccLqhIJMbL+iax
 wwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421785; x=1741026585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kLNEh9HDxPlg3F7QyIz3eXfGlUA0e6Zl/yhAOMn0zU=;
 b=PtoJ4+YDzOOKvspn6LNfR3p4BdutdT3AZpsHC7vztKg3+y4jJd/LKTT2m0Rkb7tiJU
 h6bGl2zfYuOIR+DyehMfF8hNaBQZXCG8U99+Nc39MPLMlgkpC4sk0ZWyVurUqh18fqag
 VSmIt723IJu4O6CakAHeM8InnE2715PbIsQx9JWkLyBZ0RXZZtGvEDJtumQsYXKHuTZw
 uOEMSiB/pK1d2EnDJkM6KIkvj05SzoqBXbyjgpKFPQmOMOjVZJcE4raJuabY0OUBwQC5
 d1rwSnz+y0er+5LzfXPWP5UJ44dn2Wy44C/ApbMo4aZsZtLbrFhNLjSbeEdWPxMcjgz/
 fugg==
X-Gm-Message-State: AOJu0YzUlk3Hew+jx1LpbewiLmfl+pd5uXYnx4tW9/poBnOE8oLDmYj+
 3w0e2btNYfNxH9dTGljXugq0+d+XAV2TiKdS4G24jDzdEkiQzO9+HcH67UyozA==
X-Gm-Gg: ASbGncsl/L6+fhK5ciCOu9yvrrWx4AP0GxGueH9CxhRvFjzzZ3xMDbkJR1TpB1HXzDm
 uTc+OzaifK6xq7snfvWze+jK+OF1mCJMXd4VURqn82mXuLGxShh5k+M+FI45YlR6sgyYjNJCXk9
 46tc3gNWonyG5Juh/FsELgcss2Vs5nlX4hhkxYQEIbkIs9WPZV/rizfvM6KpjPUXe6vOYtXAdSt
 TGBHi1fb0xSNhZcvCb7iGt7EB4Sc7s84x+RcRjduiD5nFjmmMyBlcYXd+N7+O10aGG3JtMHIVqQ
 rpAZ0yzDSwYZ/Jy2nH4JXDqQuiLzLblAeMZGlgY=
X-Google-Smtp-Source: AGHT+IHJy5VPpAReOcowVJ73MUH1kZ7j0UbHrtDMEMa0g6kzQ0BsHckuMpZv6GoQPDEUMVzNPQQ/0g==
X-Received: by 2002:a17:902:f544:b0:215:6cb2:7877 with SMTP id
 d9443c01a7336-2219ff827cdmr285377375ad.4.1740421785122; 
 Mon, 24 Feb 2025 10:29:45 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:44 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 03/10] vfio/igd: Remove rombar check for legacy mode
Date: Tue, 25 Feb 2025 02:29:20 +0800
Message-ID: <20250224182927.31519-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
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

Legacy VBIOS support was removed in Gen 11 and later IGD devices. While
we usually uses romfile for IGD-related DXE drivers, it's not always
necessary. Remove the ROM BAR requirement for legacy mode to support
newer devices without a specified romfile.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index dda4c7bb5d..4ae1122a2d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -341,7 +341,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    g_autofree struct vfio_region_info *rom = NULL;
     g_autofree struct vfio_region_info *opregion = NULL;
     g_autofree struct vfio_region_info *host = NULL;
     g_autofree struct vfio_region_info *lpc = NULL;
@@ -391,26 +390,12 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /*
-     * Most of what we're doing here is to enable the ROM to run, so if
-     * there's no ROM, there's no point in setting up this quirk.
-     * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
-     */
-    ret = vfio_get_region_info(&vdev->vbasedev,
-                               VFIO_PCI_ROM_REGION_INDEX, &rom);
-    if ((ret || !rom->size) && !vdev->pdev.romfile) {
-        error_report("IGD device %s has no ROM, legacy mode disabled",
-                     vdev->vbasedev.name);
-        return;
-    }
-
-    /*
-     * Ignore the hotplug corner case, mark the ROM failed, we can't
-     * create the devices we need for legacy mode in the hotplug scenario.
+     * Ignore the hotplug corner case, we can't create the devices we
+     * need for legacy mode in the hotplug scenario.
      */
     if (vdev->pdev.qdev.hotplugged) {
-        error_report("IGD device %s hotplugged, ROM disabled, "
-                     "legacy mode disabled", vdev->vbasedev.name);
-        vdev->rom_read_failed = true;
+        error_report("IGD device %s hotplugged, legacy mode disabled",
+                     vdev->vbasedev.name);
         return;
     }
 
-- 
2.47.2


