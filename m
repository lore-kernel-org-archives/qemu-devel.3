Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1606EE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9X2-0006OQ-I1; Thu, 05 Dec 2024 05:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wy-0006Fm-A2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:24 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wu-0003f0-UU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:24 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-7fc41b4c78bso498577a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396173; x=1734000973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJksUVkEtwEudvlxsC5f5lHQl1QlNlGKcBR7V40Y6N8=;
 b=V9rkKx3xiAibnCwx1xUph9HbznuIkZxgtB6NDGz+ZY4qCYIzafqJ8uT++lOacU9TBj
 eMzaPU/PL1WLxDxHrWdm1S+gI/JraxaCvPqdO3S1NczPnYZ16AlyuuAfCCuhyD5jwKiP
 m2bcJeq3jnZOa6tsgNoJB40/wdw1vw4TSMoJu3bTcphT/YI7TcblQ3yRqIvp/xAVeYKu
 oxdRMwd3oEsh9aW7g/ybT4cWD1uhy2iwnO0eI+nhY5Wh9VFzPUfgEuOzYtaMkZsEZxvY
 +98B/tEz9MCQtR0lkZNBl9qD4vCve4XGT6ae6ATwxeE7F96U7KDR0FSX34TsZoOGfHAp
 XDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396173; x=1734000973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJksUVkEtwEudvlxsC5f5lHQl1QlNlGKcBR7V40Y6N8=;
 b=Toa8ioKlwsY9Fr4UvWFMlD2ncXW0w14o2YnqErY8NYD2j/VoLF5zpbellX2/qSNsQn
 XZ/nTwwWUs6N3paABWthEEPQAb8X9HzNYTJIMdyNf/+fKsfYjD28zyC5SdLnmOJ0nTTm
 n4GZ4nXZAfmgfaNoF4ZCj2XhISpRh0l5CwLJ9V6QUs9W41GS21LHzq1bwDYfJ/fQBjNa
 B8JJ77krRxQIW71xTgIGc5C730Aob7YRRzHA+wCzxb7wVrJIChcvnIG3B6posGTbyCUa
 k47BgWjAFjRzg903aiqjdfiApnwAEnJMpQHrQk7Naaw6EIdIPCQbBURmDXwIQyG0THkt
 g6Qw==
X-Gm-Message-State: AOJu0YyBNx0NhdWjWMkPgkDXpPBknADF6190ux1Ij3OBbAJ2qFLGRWeX
 0hqdyaooIYl1jptn6Ow/hgYeSa3DDcMrhcG7D3aAjKKsAZeyzLqmBi6YJIVIKw==
X-Gm-Gg: ASbGnctxENx95g9bSbRhPJ6qUepdjOu2jifQCxPTjIXCUJcycFRPOu0h/eE6b3TC12/
 VUSa3kfre9Jm1ViH90JS2I4yQKn8Atnr/jsY/6MhAC4H4zJqgNNvIgAP6WsLMU80knOb0xiszui
 7sO0qH6XQPtM4ogVp8dy4XTKGfHg0WfbrHIfGZJcatyHwNUVzqIUrXD0HkmDCdOW1QTNVOy9Mul
 BycwtG2IwzeKRYZ2S22yoS+1KxIdwoR+8+RFy05SwxO6CEqq2PctkE4JA==
X-Google-Smtp-Source: AGHT+IFQl82deMWUZdn5mNFsgF9nRsCUuJtg0zW87nzUeU/pa0DnAetKJw8HCiguehQo6CRRBoxulg==
X-Received: by 2002:a05:6a20:8410:b0:1e0:c247:21d2 with SMTP id
 adf61e73a8af0-1e1653c8294mr16251506637.23.1733396173649; 
 Thu, 05 Dec 2024 02:56:13 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:56:13 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 09/10] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
Date: Thu,  5 Dec 2024 18:55:34 +0800
Message-ID: <20241205105535.30498-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


