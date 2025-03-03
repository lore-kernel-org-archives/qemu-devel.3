Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C2DC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9y7-0001YM-BP; Mon, 03 Mar 2025 12:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9xy-0001XF-Bw
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:35 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9xw-0000GK-CR
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:34 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2239c066347so32359345ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024350; x=1741629150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAilGogcJ69e+gk+U7AAsM5atW/gLI/r88D/oQ3BuBI=;
 b=KXWyWSWbstX4BDEogXLQAUo8x582HzkrIWuWYvz0zsH9E7XBqnNazeumGHGM0iwZYU
 O78VMEpSMPZR3uP5GRAD1Sz0GPOlTToHtS9fIzLxj/XwNuGG6aF+CosnpltRXYcc3zU+
 eg315rnRRLkfx0ZkPV/l3ThxX8wAdjXtNXzBnG3NKI694E9dTxCl/bL3DoZ2MNPPSBrR
 OGeZ1jvzaS/S7Zx7Y0xlnI/BqqTsFsakLtwLTMaMYicRMQgNUWw3S7Kyy0AgURWRTAoi
 Yy0+UOmluMjYuhDsyQEIU93InzSsrQzbBoPL9tOCvum/zcCtbwIv8aJwdfC186j3ZVI6
 8u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024350; x=1741629150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAilGogcJ69e+gk+U7AAsM5atW/gLI/r88D/oQ3BuBI=;
 b=BdOdFsxpQhJIuAtR4fnGRko4YO8K7JqK0qn3r0dWtdgo/3zEs3U+lEDhLrXg1O4GUl
 6bjaqJ9+DHTSwaZAARgyJiX8WywalpsG6rziMASRZTjgT8YCTKNf8winY4ZDUP7PD4/k
 qeHYHQBMWLJan3ZYAFYxJmUleskvoT+rmt5h/yIijgLxlPBeXS3oWfDrhsV72MZZ19Jl
 74xLDU/83NRoA5oG6g5b77sQ90UBBXZ1fRQCHOTvW21RH2VCKA6dWO/qwXW/nohxAte+
 f9yR9876Ew3d9oFRq3rUzJr30rZoNR+scW2fP47CQHFSQxHJ3LA3lprqcq3auQh3ZiPu
 frlA==
X-Gm-Message-State: AOJu0YwmINn08rH2AjcqOiLDSZPU6OWIqiuiDRBZ+ynSGY0/fZaMYSjE
 76DymJ/gJkYXc9uIwYRAC2A8huPqrJZPrCRS6Q5bM/bTTnTOZt8=
X-Gm-Gg: ASbGncs2Iv2O6CsNvu/v9O6fbFcGKX/Xj08iSODBRY5T+t+Gb3EIj/yh91E+Nm6lgVW
 lVc1HKpvQ77UYB/4FajUA4CDxSbI71Ygj60ZmseD7yLTEubWgTP726WXrj9TAzmvO3wEoE17Z4W
 PGIyZ5fBPi6jra+WLitsDia63rhoNU9ym+3ydB7E0Jf2cxSYsE2ehKshpwXS30aQ1Ngj+BuKeOF
 U9xGlMYcWLAjhE4KDNYdUgXcugh9kk+FgD1BBRmuQJPzUhoYiDkMnmXQLt3E1uOboel+T2LbGG6
 zTczj5VOrel0LvjHgIipoy9Sm46rylWhwRV6tfkmXw4Y6dSmftTkVsD7Zw==
X-Google-Smtp-Source: AGHT+IGQZlUVzjR0TL2Y57P3Bh2O/3804iFF32DUopsZT6Ot8yQnpLZ91aEJ5mClDd+9bASOSxAyKw==
X-Received: by 2002:a17:902:fc45:b0:21f:5638:2d8 with SMTP id
 d9443c01a7336-22369267243mr239876645ad.53.1741024350637; 
 Mon, 03 Mar 2025 09:52:30 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:30 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 2/9] vfio/igd: Do not include GTT stolen size in
 etc/igd-bdsm-size
Date: Tue,  4 Mar 2025 01:52:12 +0800
Message-ID: <20250303175220.74917-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
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


