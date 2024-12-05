Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870F5E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9We-0005bL-8G; Thu, 05 Dec 2024 05:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wb-0005Z6-Oj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:02 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wa-0003bo-11
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:01 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-725ad59ad72so141360b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396158; x=1734000958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lx7mWSlMFt3UwBpDPHAXwsNgtKvBMAr06837vMU0kv4=;
 b=aM36dsgJAeF+LK5wTosMhRPXzRE1YDbwfn7XepLOB08umTlU34doMoPMD2kMMApPDz
 sHaVe7RWr29CSPwX2FfkoxdoYcSzx2Yjvkoy/TZucHm7Ax5OPXm4DipDSmYwyA5gw95v
 Ap6pTwRclPteuOZn0zNzl+9Y2Ve5bWGUc0aUS4qBAhhpBJkL5Xg2FYqBG+GP+vdWmOqk
 0RdJCWeJfm1LAIT4D/CxmUwoho1T7sx9XPM4cEZ4CL+VyGBYUtu0kWpk2H9kYOK1Lak3
 uWz7bRAg1OVxO59+3BOzRJONx0A3othU6b0848XJPqvwULYBIzdgQ7vvrCd2a/t5Ja4G
 YmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396158; x=1734000958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lx7mWSlMFt3UwBpDPHAXwsNgtKvBMAr06837vMU0kv4=;
 b=wkQp8zxTGve19zVkdUQKrGYur+krqLt0uUL+XymLz0RgEhQHogmVS5rO5tQR3g0MXF
 u+/SETpWHtvNz4MWAe/tFERLnags4MEOMQNwdrp/Cyi/dmp0zFYLHf1IkhChTfoqvBpq
 tC9ft6nDWVq+Is7OE1HioWPl5mpTfDtR32d8fCpwnwOt4f3qFtocZNAIzS/AobZNmR/h
 5gn3+ZnZ9POcVUIBSpgSUVghoCG+tq3BNwm2+XqcqIx834Fp3McvtziovhFrPgGcofBM
 HCieRnfAF9HcRbNEnHfsVdcQuOc6O3LJYZ1qqaOGzBsLcOC7sVV3MmQiLfC09TvI4jIt
 2/GQ==
X-Gm-Message-State: AOJu0YxxL4CgyaFxILaVigUR+Nen7FBbEco4X2l/JkMrvNZomPzUg8bf
 Ht6XjUYAWeipzO9rrVHGizHCVXnVZI0IhsZS4FYDanP91dtJpSHyoCa/bUFnmw==
X-Gm-Gg: ASbGncuxs9v7MQg9ezQNnQ6eZmuFSTIm8mB4x4HBwEXwTWnFNqMjul7TFodpp+Yj7ee
 TDriNmGvuotyLHOy9D/00v+iTm76XuhWBf9NARa0m7JlKmDVG7Xss1s6nAtkOOATZ8DAZDGu5ug
 qXjQLFaR2VvJp6Z0aZ+jyePFLK+1c2d/vR5EXRV/95yt8FLzZIqJccOSps9Gy/Q65sSddGEP38w
 7/RfdKIQTm1F6Ozce6NdDVPLrJ/m0mPNwqfyTDdufeXKoGEoWt1UtroAg==
X-Google-Smtp-Source: AGHT+IElHDMBurudKcGoWRWi6fyKYNok/8W+f8PLeyH9+kbUvgGCXItmMlhbbPN4nuo67Kwykyfniw==
X-Received: by 2002:a05:6a00:a95:b0:71e:587d:f268 with SMTP id
 d2e1a72fcca58-72587ee644dmr11995990b3a.4.1733396158378; 
 Thu, 05 Dec 2024 02:55:58 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:55:58 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 04/10] vfio/igd: canonicalize memory size calculations
Date: Thu,  5 Dec 2024 18:55:29 +0800
Message-ID: <20241205105535.30498-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x441.google.com
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

Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
calculating GTT stolen memory and Data stolen memory size in bytes,
and use macros to replace the hardware-related magic numbers for
better readability.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 101 ++++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 09bd4e5383..e231865d72 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -107,6 +107,53 @@ typedef struct VFIOIGDQuirk {
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
 
+#define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
+#define IGD_GMCH_GEN6_GMS_MASK      0x1f
+#define IGD_GMCH_GEN6_GGMS_SHIFT    8
+#define IGD_GMCH_GEN6_GGMS_MASK     0x3
+#define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
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
+        if (ggms != 0) {
+            ggms = 1 << ggms;
+        }
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
+            return gms * 32 * MiB;
+    } else {
+        if (gms < 0xf0) {
+            return gms * 32 * MiB;
+        } else {
+            return (gms - 0xf0 + 1) * 4 * MiB;
+        }
+    }
+
+    return 0;
+}
 
 /*
  * The rather short list of registers that we copy from the host devices.
@@ -255,17 +302,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 {
     uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    int ggms, gen = igd_gen(vdev);
-
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8 && ggms != 0) {
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
@@ -472,30 +512,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -505,7 +521,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
-    int i, ret, ggms_mb, gms_mb = 0, gen;
+    int i, ret, gen;
+    uint64_t ggms_size, gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     uint16_t cmd_orig, cmd;
@@ -667,13 +684,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
-    /* Determine the size of stolen memory needed for GTT */
-    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8 && ggms_mb != 0) {
-        ggms_mb = 1 << ggms_mb;
-    }
-
-    gms_mb = igd_get_stolen_mb(gen, gmch);
+    ggms_size = igd_gtt_memory_size(gen, gmch);
+    gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
@@ -684,7 +696,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
+    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -735,5 +747,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                      vdev->vbasedev.name);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
+                                    (ggms_size + gms_size) / MiB);
 }
-- 
2.45.2


