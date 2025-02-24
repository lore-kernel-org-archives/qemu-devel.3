Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF7C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdNc-0002u4-5f; Mon, 24 Feb 2025 13:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDD-0005fY-On
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:54 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdD7-0003KB-T3
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:51 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2212a930001so16496855ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421783; x=1741026583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAilGogcJ69e+gk+U7AAsM5atW/gLI/r88D/oQ3BuBI=;
 b=fZ6oaba5g1JFxoXG3LedXfjOn0wvUmM4kxKYniwnJ1Xibw0jAnmb5w6I/Stiy9M3ZK
 +tTOguMBdn5cEvB/KGZNh3Yp8L6ruG3tAHe0rg9wnTBDfbSTk/3oQMfYu1j5Vqb0BwPo
 vMnKK4+pjAfZIDdVQ8uQJsb+8FdmTMvhWyMUU7h1lo9HwFUYlhJFrD8TGapauOmhTRrb
 Ueg+efzw12eZg25iKokHuQdT6nxDJ/fQ6YXcxUgZ5sKrwZ0BwbBGxyds95YnNzSoq4dI
 7oQ405LMVAKRfXHSAyhgY8xozZ1p3pG+fUBsEgSpqw1fSD4cC14XcAbckWMG41uLF//o
 rVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421783; x=1741026583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAilGogcJ69e+gk+U7AAsM5atW/gLI/r88D/oQ3BuBI=;
 b=tqtnFybGW/+DQjGfdJa3Vpqp/ZLhXe+mWCjtgj50aD9rDh6r5nzR0S6i/7xRJfyysO
 3LcCNsqrWhfH44M+5nq04kk7L0OtxjJ17sMstgO1GWc0UFNtHhgXvEiVsUBMOciCXX6f
 kqn2oH0ar+ZpHHiJax1fGT2knqpAC62DO+eTjaINBZZ3KOZQ/sKwpESr/obiNGHNbqO2
 8Q84B7K6kr0EkXcCqJLuZ/VpNnvUR1gEltlIQfHzrffW52IxIrC3ziQLg3rkG6JOjH2y
 XO3/5293mqe5b7zi7pLmAZkakOpPG6/nfOZcxymLYr9i4OoKsp4y0cUL+s3Izhcy7ZQX
 6/+w==
X-Gm-Message-State: AOJu0Yy25COX4auzgLG6QOiP1RIlUaYc9EeyhFRT844Cov0tED+jXyzq
 O7uXqfKf6tuWV5O7GMIfejVsNxfAJIZnwlN/klCnFsk2CvYXHZY=
X-Gm-Gg: ASbGnctd+Lg4mGxC0Lx372QISOGHHWIK7t4dTm3ngjnzU1n1Ov2pi1+MgA6cG8mHU9C
 hRWUsNZGkDMosJDRFnd96Tzv2yYpM8tPEp9+NYe2YfLcRGYz4qZSPZ3z0QnFiOoYZU5vELVBveY
 c6n8eNNKRW0Xu/J+bA0ShmEuM1Y+R+OdvUE1kVvDuYYUyP/tHTHwRi97BWYmPQczN/sq0YejZU5
 YL+OfNRCwj5CqM395x/BxQJig0hE7yl1jBoq9BBrN168HOe6gwCE6vKySnYAiftmNyP671QxJN7
 GAFndkIkypdsie5tiuYaTx3YfP9SmOU8T13Hhdo=
X-Google-Smtp-Source: AGHT+IFucJTC84KK9NKpkudn0o/c9TawXufCk6sNAkF8gG9bqlnC2mJVWoUPiyOG+OGWKET/zhEgHA==
X-Received: by 2002:a17:903:2f92:b0:220:e896:54e1 with SMTP id
 d9443c01a7336-221a10de4fdmr206300115ad.26.1740421783122; 
 Mon, 24 Feb 2025 10:29:43 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:42 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 02/10] vfio/igd: Do not include GTT stolen size in
 etc/igd-bdsm-size
Date: Tue, 25 Feb 2025 02:29:19 +0800
Message-ID: <20250224182927.31519-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

Though GTT Stolen Memory (GSM) is right below Data Stolen Memory (DSM)
in host address space, direct access to GSM is prohibited, and it is
not mapped to guest address space. Both host and guest accesses GSM
indirectly through the second half of MMIO BAR0 (GTTMMADR).

Guest firmware only need to reserve a memory region for DSM and program
the BDSM register with the base address of that region, that's actually
what both SeaBIOS[1] and OVMF does now.

[1] https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ca3a32f4f2..dda4c7bb5d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -112,28 +112,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
 
 #define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
 #define IGD_GMCH_GEN6_GMS_MASK      0x1f
-#define IGD_GMCH_GEN6_GGMS_SHIFT    8
-#define IGD_GMCH_GEN6_GGMS_MASK     0x3
 #define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
 #define IGD_GMCH_GEN8_GMS_MASK      0xff
-#define IGD_GMCH_GEN8_GGMS_SHIFT    6
-#define IGD_GMCH_GEN8_GGMS_MASK     0x3
-
-static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
-{
-    uint64_t ggms;
-
-    if (gen < 8) {
-        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
-    } else {
-        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
-        if (ggms != 0) {
-            ggms = 1ULL << ggms;
-        }
-    }
-
-    return ggms * MiB;
-}
 
 static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
 {
@@ -367,7 +347,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     g_autofree struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret, gen;
-    uint64_t ggms_size, gms_size;
+    uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     Error *err = NULL;
@@ -527,7 +507,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         }
     }
 
-    ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
@@ -539,7 +518,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
+    *bdsm_size = cpu_to_le64(gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -559,6 +538,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
-                                    (ggms_size + gms_size) / MiB);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
 }
-- 
2.47.2


