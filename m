Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C82EE64A9F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4h-00082K-EP; Tue, 03 Dec 2024 08:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4g-00082A-0q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:22 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4a-0001GR-LE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:21 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-215b45a40d8so10810865ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232975; x=1733837775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbedGQpZbiZzLccaIV/JwHJY9jlVFHdqI1I9GJ45Gm8=;
 b=Q+edaSTwIDqdoHUmXtAkF57PHUtZxPyGBm9gLyae9Ky2Y2wWF8lE8gT/6H74KvB5pf
 2RhLZkfin1DJxzonCzPwqBxHPH7BzFYxf1TlRiNknvsNg+AHS8nvEsdEdPQbCf0EUiak
 doY5mSfar9AA5fsKdSOdCPm6xJ9c4+0ed9aP9IYoVikvtmJfN0BlLlciTO0yq+l32BiM
 GoM4LpYER7BsixuYHP/1MzmjLD3hYNaJRQePmudAslpDfobAp/Rm5XafuyvLHp4MptCX
 /9L/AvYZGVnbl4DFyLWrP2TIpdZetsLwW25z/JrH3Law+2cMyXP8jJk2P5s1PMuV2w5V
 XOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232975; x=1733837775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbedGQpZbiZzLccaIV/JwHJY9jlVFHdqI1I9GJ45Gm8=;
 b=cPUuZ5D6LWDhFXlACV511hzB9CmxmV98QXlCHmD+l67p902Yl4KV6cdmW5LG2iL/uV
 UpPJtHTzJIfaWkNKiUz2alk7DbqOJF/nBWKtHbKJXMhDcpPdV61QNAzIeg9j/UHwbZdX
 XnH/mCVnWM642m5qlldCiq8g1RHKndCFCXPvuJggcl3CsRzfZgacAAmekByody7xIyRt
 XYnhBxhq/SPebhYizoRUxBxr3U01A5ckO+FVX1MbVQxIm1eCK1WTvL9zi3aYSaynoBIr
 9s5h+1x88LO1yo31cjzd1P90h1lOBafkqctmaeONlwEZmw4gYjkZRc93kYcaIBckxJFC
 U7UA==
X-Gm-Message-State: AOJu0Ywqgm031e8JVN37YdiVz5PheBdgN7fM5SncqzkfBNDqrqpTDKVn
 tt8Sg5irogNEunomOHhs5mn3GgVn00skKV2utZfkZLXP3skoqx9lCMzFxyUUaA==
X-Gm-Gg: ASbGncvNcPQpzIhEmMML4KG9ivBWJ6mMMjzOBmaXemFmmX67hsrD+hP9VR+NPNTkmyp
 rp9qo3X5yJpt5ZcIyHqxDm0AjbWhl9Q/Z/7iXTei3nxqtOZuKq0UslPnj2fPAeotofhjDld0nF2
 5o5yYBzlAhMUFiCiZo3wI53w1TZJIaX3fzwQlPAz3RVuH5M8s7b2yopQV0IN8AtvMNQgJqXjm6x
 MK0bN2ipjX1f2tWpg1K9mvH2MXMNy8MkhgFCPV4J9O7aFbq/Ctwlj5R1fQ=
X-Google-Smtp-Source: AGHT+IGPCCuc+PArskTh6njoIEoxM5kniM4GjGvmHycMHU+hoWVHnJeosKkArWVSQvx0Z6zPW7Pniw==
X-Received: by 2002:a17:903:1d2:b0:215:a96d:ec2c with SMTP id
 d9443c01a7336-215bd0e654fmr35187245ad.28.1733232974709; 
 Tue, 03 Dec 2024 05:36:14 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:14 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 3/9] vfio/igd: canonicalize memory size calculations
Date: Tue,  3 Dec 2024 21:35:42 +0800
Message-ID: <20241203133548.38252-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
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

Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
calculating GTT stolen memory and Data stolen memory size in bytes,
and use macros to replace the hardware-related magic numbers for
better readability.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 99 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 2ede72d243..b5bfdc6580 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -106,6 +106,51 @@ typedef struct VFIOIGDQuirk {
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
@@ -254,17 +299,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 {
     uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    int ggms, gen = igd_gen(vdev);
-
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8) {
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
@@ -471,30 +509,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -504,7 +518,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
-    int i, ret, ggms_mb, gms_mb = 0, gen;
+    int i, ret, gen;
+    uint64_t ggms_size, gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     uint16_t cmd_orig, cmd;
@@ -666,13 +681,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
-    /* Determine the size of stolen memory needed for GTT */
-    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8) {
-        ggms_mb = 1 << ggms_mb;
-    }
-
-    gms_mb = igd_get_stolen_mb(gen, gmch);
+    ggms_size = igd_gtt_memory_size(gen, gmch);
+    gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
@@ -683,7 +693,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
+    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -734,5 +744,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                      vdev->vbasedev.name);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
+                                    (ggms_size + gms_size) / MiB);
 }
-- 
2.45.2


