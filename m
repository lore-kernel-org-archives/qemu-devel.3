Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD84AE7717E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSM-0007Jf-3F; Fri, 06 Dec 2024 07:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRW-00062i-Bw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:23 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRT-000477-Oe
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:21 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7252b7326f4so1694189b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488098; x=1734092898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJksUVkEtwEudvlxsC5f5lHQl1QlNlGKcBR7V40Y6N8=;
 b=cF2v5Xyuc6dD8QzfIZOTUE/qBd7zTizmRF90WS6G6r5vmLWGnRNNRRdaPpFkjN2t65
 5Ndi+y195fy08eO0Jgqqd6Me0WEPSZccPegAhWHbVF+5zw8QZLO/SQ9uTQjpDvYYLbHw
 jMufCXm+7TqL+A7xX/gsWbFdeOCMGsMxqVdO9RYJ6BbH3S2G9MbAh6w15C6a+HVrtZ4R
 iFo5lmDDAKyOZPefXHgKxiAYL41jFZ/t7lIEZSYl7Mnliw/oAQ31Aa8ULg/sUpFEDurD
 wsSuh54NdSJXaJZEj2QA4B3j0jFHPvXd3y/EHKrmXhGIevRhXmPzxh8uiykaH2yyX32h
 pzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488098; x=1734092898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJksUVkEtwEudvlxsC5f5lHQl1QlNlGKcBR7V40Y6N8=;
 b=PMTuncABVAOZzo8K7+icTCV47pR/zYuyFPPY3Cy9bleM9cCqbjQm2C/H+4c3qlYfHt
 bT8vso7koYnfDMH4N6UTKnF1Ag0qbfN30MC+1A65qMuhEsnkP73QO+OZ0gfmBzyDv8BR
 g4tY+p1PW3R1DmeGH1WhnDAB53YsIWcO4YdyHa6mNTQ7pUj4dvt5Ny4Cybrll22mdPlh
 LoY5cJmxnNb1U4aka977kdQViyhy4eCLjsDvfOb6rw6uEK+B1y79xwD9J/ZTTxT6ByY0
 fT8cEO9S3QexbJO3k0r7wrOxPCp5L5qwOxDh4vAIAsNacpmO3n8SuxYrT92IPFanGw/o
 QpSA==
X-Gm-Message-State: AOJu0YwMC3hMkpTZKG+wJn0POopXVELNdhye1IrRABtVD4u2CKAXkSl0
 SFTJuloHFzMt+GLYVsNezVbptQzilD5522B74zHcO3KIOxOHxxQ=
X-Gm-Gg: ASbGncuAcIDB/LWFHbkw7etrX/8NPWo5SkId2/SJhbNIXdiHCKfH3Dt773z2F0Y5BRY
 TcA3RTkxU9VpsHoqssj51rUjck74zWgoQXPgMqWazDp3bUjNftY1dUlQl9XIc7SihF6IbApPPAI
 rOS1SqMF3AxysfzF2QIknNJvp9mfDEpVMgWyh6Hj8GMBMDsWY4ZuX0v8l/L5G2L0j/W91aravop
 qDSr++aWycRfalYwRTzg2eN1UWu+mQE2HSIEaAhxo1P7+MNB0CimK3SwA==
X-Google-Smtp-Source: AGHT+IFR5YiU72D3L7D+7WF+NcaK+QXd/DKpK5EVePqLoxZlsQ1jzzgi7Y6gXOyfUn4YuZJYddc/LA==
X-Received: by 2002:a05:6a00:b46:b0:71e:1722:d019 with SMTP id
 d2e1a72fcca58-725b81f81a2mr4462054b3a.22.1733488098280; 
 Fri, 06 Dec 2024 04:28:18 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:28:17 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 09/10] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
Date: Fri,  6 Dec 2024 20:27:47 +0800
Message-ID: <20241206122749.9893-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
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

A recent commit in i915 driver [1] claims the BDSM register at 0x1080c0
of mmio bar0 has been there since gen 6. Mirror this register to the 32
bit BDSM register at 0x5c in pci config space for gen6-10 devices.

[1] https://patchwork.freedesktop.org/patch/msgid/20240202224340.30647-7-ville.syrjala@linux.intel.com

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 12e0553e83..73c06bbf64 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -489,7 +489,8 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
 };
 
 VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
-VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm64)
 
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
@@ -516,7 +517,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
      * into MMIO space and read from MMIO space by the Windows driver.
      */
     gen = igd_gen(vdev);
-    if (gen < 11) {
+    if (gen < 6) {
         return;
     }
 
@@ -530,12 +531,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
                                         IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
                                         1);
 
-    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
-                          &vfio_igd_quirk_mirror_bdsm, vdev,
-                          "vfio-igd-bdsm-quirk", 8);
-    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],
-                                        1);
+    if (gen < 11) {
+        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
+                              &vfio_igd_quirk_mirror_bdsm, vdev,
+                              "vfio-igd-bdsm-quirk", 4);
+        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                            IGD_BDSM_MMIO_OFFSET,
+                                            &quirk->mem[1], 1);
+    } else {
+        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
+                              &vfio_igd_quirk_mirror_bdsm64, vdev,
+                              "vfio-igd-bdsm-quirk", 8);
+        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                            IGD_BDSM_MMIO_OFFSET,
+                                            &quirk->mem[1], 1);
+    }
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
-- 
2.45.2


