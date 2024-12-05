Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6D6E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9X0-0006JC-Ho; Thu, 05 Dec 2024 05:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Ww-00066q-SO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:22 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wn-0003em-HJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:14 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-215909152c5so7928545ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396171; x=1734000971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Afev6en4kR+CrZleuto4wB3x+yzqkCFox++dU9LzUsA=;
 b=bEi+aJEzgzpOmdJaaHAfB/Pzu3/e0fSJTLniRkiQMD4aqkOwQSQDgYm+7Duv4ZoyGg
 m6uSikOcWR9sgHfMzAIFXJwuc31trgqOLYg4INN+HqltFUzi+3zXf8DyeY237xXwJco1
 hw++QIQ06FRiPQJ+CZLIRPkuJm42bgj1FsE9wCNY3T73Z2poA6dX9A4Q4gu+YxV+ORR/
 NpM76gQKwxdd39Q5oSG/pi+FHSqCE79zPo/a1tNwAs4yaOFxqYwlVAQZygchqScrKaY9
 de0WAUddOYYu786y7wI+OlvFcLYqkhy+r+7+IAWtOyq72hzLXON8mYPr4/on6q/bsypB
 JkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396171; x=1734000971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Afev6en4kR+CrZleuto4wB3x+yzqkCFox++dU9LzUsA=;
 b=XzJafLUbQfaddCNzwYKr3D+HTS0T5GggMSDNSFTnAE55R883jA+12ize+vpNtT/rn0
 hnxiYOf+OIL9HM0hpyUi3UTDyc3hOeHlCFQsjkukmFOnE1JvQFqJWg8yw4rui+xdTPFI
 D1s12PYzkxZLXsyiOJ+3LoXQVQJNngU1RhgYkn+FCNzEo70K8bvFszJlyWZt8ggxxrnl
 t/q9zSsFdHbd72oz9WzIWybzUMd+x0qrRnchw2ARJeBTEe0dEsVigoiLg3sbCHAr0++P
 /wFlkn8YVKU2V0DWYMI+apEWXZLtgTP6Pz/ZUglRvY1kF1mdz9laCLTe37yw5hisYZcw
 l2Mg==
X-Gm-Message-State: AOJu0YzcXcW+PUnF19LSpRfyg/sDw4+LE/25e9IKLpXQRnE+CUZ8D9vr
 jxeQcc7dCOnTOZ6vbZoeUCqN+7f3peS3WMyTAXKWTRt2jmzITBd03myEQmIlaA==
X-Gm-Gg: ASbGncuwQGz3J2QtsFPWMWDaZLHM4Aru4SmyktbJyKEgAK8L/h0Kdr+aZ2XJgGlHOti
 xMjDJroGucgbUVmJ6T7p+3KIFFCD3IISTX24TbCbinDeH03WI/zmnQIzymkOdNWh3jLmSk35eS0
 52g3aoV0+1XuzTG10hpE+II3+IMEu7HGwUFF3Bw5RQrnhsI7HOX8RRaJfADFKRY4HPC2kV8bRx9
 tStt9doh/qncNE+glyfpLIqf8Tg43YH6rGmvP5o18LYFeYLP3ALiYhHAw==
X-Google-Smtp-Source: AGHT+IGPKdydCue07Ns3c9gmXsFN8oeu7yRBTNG/TIcycFfDBLY2MvLM5p5xvGg9I8J3AkSNq2ZsxQ==
X-Received: by 2002:a17:902:dacb:b0:215:a60d:bcd9 with SMTP id
 d9443c01a7336-215bd24ba1bmr97962255ad.45.1733396170947; 
 Thu, 05 Dec 2024 02:56:10 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:56:10 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 08/10] vfio/igd: emulate GGC register in mmio bar0
Date: Thu,  5 Dec 2024 18:55:33 +0800
Message-ID: <20241205105535.30498-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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


