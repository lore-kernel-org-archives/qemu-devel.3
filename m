Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DC2D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmeq-0006F3-LE; Sun, 01 Dec 2024 11:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmW9-0004dP-QN
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:53 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmW8-0000La-5j
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:53 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7256a7a3d98so337016b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069390; x=1733674190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FCjKkqD1YQ50P5Txv3hBWG+zfbM2d/VSBEmFOMVPzg=;
 b=GDrFgjGRreDSVOWoC7gjaiKO359VZofij071Rbw6FwI7oIVlgI+HK/Jcy95s1fsnB0
 yOszTiVbiP5MN+sTD+ULDzjBQ6cnF6jg6mS+t2eDCrIx2yiiTs04qCKr+p7cYkGIpX4E
 aTVt0qcEYbm6v/qR7t4R3DSDf+IXMR6P/VTuVXyc6KBI6tp+edpLurCfr2xINoHbaw1j
 M2c48+XpYbqC8EwUSy9JC55hgfWJiYJ2wCA3ORUXc9GvQdw5PP2btWHmdvaU6LiAtu8Q
 gBZcDkt5d9riJbqocgajIlw0Cg2UsV9aRjefghLfHHasXdaQR3aVz3KnvZuzELzO3aus
 ZFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069390; x=1733674190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FCjKkqD1YQ50P5Txv3hBWG+zfbM2d/VSBEmFOMVPzg=;
 b=s1NQMhz6WNgFC56YzuODzSgJMbOakHAhS4opUXVmvhqzTozh3Ce5osqwurrHe/47SV
 y1+LXuGsaoINhuGXQVt0flTTbyRVOtUTJzRG491wrbDQ7idwXoag2PxXhqxST1FGlz2/
 CQmx3B00+pcgsVs0aVgeMHTSo0DrUc4UdFvbj5xewbMk9X91Gz0HNkXOLLRR5BFG8fXj
 29jzL+mid4lZaRZTMoLBJpM1z+FZuIrO2UZ2MFmMv8CRJgo08o9l8WEmML9uYy96GB6Y
 dfJhPuTA1Vxxo56MhgBn63qwbckRC7id0WRQOUvHbmXo67jUojKerusQq0fSzRfnKO11
 1F0w==
X-Gm-Message-State: AOJu0YwoWK7pwPrTuNI6c83YUNWhyGBmoIwW7VnstVeGqGFDr25JqqU/
 JEkZu/3hHtRGD1QHae2M4CvYQs0pqrmyqWmDOCMCqNNr2uURPfYREYPI8459pQsH
X-Gm-Gg: ASbGncslRFt6X9dabgWIRdHMaOG1vgLrG6ZJG5hn7+zIecoMf9A//F4Vr9TSOYP/tGg
 RZ5fe8n9sQezK40N/1pVV6zc+1+DnJeGJDLDN9c2NtAfrg99ITYVgijAdZ/PrMwKeaPcW1G0bD7
 7PVVR2/lCORaoQXnwOt2eqPjJOf6TvAhkeWIHL6LtjZGmjcMJHFW9HNkNeeFd+G8EabvYOlGVER
 V9MS4omh6wmlJkUJ/CbSMAw76AhTExr/vSBYa9Ai626MZbZlzj6zJ1uw0Y=
X-Google-Smtp-Source: AGHT+IH4Ilz7LnqGFNtq3FoqfEnb0d84XHXIvOWlzEEpb4YGpHD8injZMp1Y2eAi241gMFbFE/qNkg==
X-Received: by 2002:a05:6a00:1396:b0:725:e6e:53f3 with SMTP id
 d2e1a72fcca58-7253003fb8bmr25936326b3a.12.1733069389912; 
 Sun, 01 Dec 2024 08:09:49 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:09:49 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/8] vfio/igd: canonicalize memory size calculations
Date: Mon,  2 Dec 2024 00:09:32 +0800
Message-ID: <20241201160938.44355-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201160938.44355-1-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:42 -0500
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

Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
calculating GTT stolen memory and Data stolen memory size in bytes,
and use macros to replace the hardware-related magic numbers for
better readability.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 101 ++++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e40e601026..b449316ec0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -116,6 +116,54 @@ typedef struct VFIOIGDQuirk {
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
 
+#define IGD_GMCH_GEN6_GMS_SHIFT     3
+#define IGD_GMCH_GEN6_GMS_MASK      0x1f
+#define IGD_GMCH_GEN6_GGMS_SHIFT    8
+#define IGD_GMCH_GEN6_GGMS_MASK     0x3
+#define IGD_GMCH_GEN8_GMS_SHIFT     8
+#define IGD_GMCH_GEN8_GMS_MASK      0xff
+#define IGD_GMCH_GEN8_GGMS_SHIFT    6
+#define IGD_GMCH_GEN8_GGMS_MASK     0x3
+
+static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
+{
+    uint64_t ggms;
+
+    if (gen < 8) {
+        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
+    } else {
+        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
+        ggms *= 2;
+    }
+
+    return ggms * MiB;
+}
+
+static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
+{
+    uint64_t gms;
+
+    if (gen < 8) {
+        gms = (gmch >> IGD_GMCH_GEN6_GMS_SHIFT) & IGD_GMCH_GEN6_GMS_MASK;
+    } else {
+        gms = (gmch >> IGD_GMCH_GEN8_GMS_SHIFT) & IGD_GMCH_GEN8_GMS_MASK;
+    }
+
+    if (gen < 9) {
+        if (gms < 0x10) {
+            return gms * 32 * MiB;
+        }
+    } else {
+        if (gms < 0xf0) {
+            return gms * 32 * MiB;
+        } else {
+            return (gms - 0xf0 + 1) * 4 * MiB;
+        }
+    }
+
+    error_report("Unsupported IGD GMS value 0x%lx", gms);
+    return 0;
+}
 
 /*
  * The rather short list of registers that we copy from the host devices.
@@ -264,17 +312,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 {
     uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    int ggms, gen = igd_gen(vdev);
-
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 7) {
-        ggms = 1 << ggms;
-    }
-
-    ggms *= MiB;
+    int gen = igd_gen(vdev);
+    uint64_t ggms_size = igd_gtt_memory_size(gen, gmch);
 
-    return (ggms / (4 * KiB)) * (gen < 8 ? 4 : 8);
+    return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
 }
 
 /*
@@ -481,30 +522,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
 
-static int igd_get_stolen_mb(int gen, uint32_t gmch)
-{
-    int gms;
-
-    if (gen < 8) {
-        gms = (gmch >> 3) & 0x1f;
-    } else {
-        gms = (gmch >> 8) & 0xff;
-    }
-
-    if (gen < 9) {
-        if (gms > 0x10) {
-            error_report("Unsupported IGD GMS value 0x%x", gms);
-            return 0;
-        }
-        return gms * 32;
-    } else {
-        if (gms < 0xf0)
-            return gms * 32;
-        else
-            return (gms - 0xf0) * 4 + 4;
-    }
-}
-
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
@@ -514,7 +531,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
-    int i, ret, ggms_mb, gms_mb = 0, gen;
+    int i, ret, gen;
+    uint64_t ggms_size, gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     uint16_t cmd_orig, cmd;
@@ -676,13 +694,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
-    /* Determine the size of stolen memory needed for GTT */
-    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 7) {
-        ggms_mb = 1 << ggms_mb;
-    }
-
-    gms_mb = igd_get_stolen_mb(gen, gmch);
+    ggms_size = igd_gtt_memory_size(gen, gmch);
+    gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
@@ -693,7 +706,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
+    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -744,5 +757,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                      vdev->vbasedev.name);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, *bdsm_size / MiB);
 }
-- 
2.45.2


