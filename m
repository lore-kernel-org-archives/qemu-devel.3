Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F56C3ABA4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R70-0005Tg-78; Mon, 28 Apr 2025 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R4P-0002HT-Hy
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:11:04 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R4L-0008S0-Lw
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:11:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2295d78b433so53455445ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856651; x=1746461451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04Ru2G52IZKwkHppg+UoPnW9YEjqrdfMwPJFhOoWFbw=;
 b=Yv+xLR1TvoBdSmPO/eope6BLRnUIbGhUW/TtbqL/sCtA8ttvxpoL3/JOoZAsAYL547
 4GkmdTmnKuvO9sn7kfOLhBmr4zH64FKkt9Q0siZYxGAqpai4106LAM0k6/LY38IPiRx5
 UGjUNj1BPLF0u+/mgPBf+8+MxVssso0zOtm2cW1taDUrEIjPid5yi2y+IRWBKunQSvAZ
 SO8Upy5uIvBfa4c/dY5Q5KzHKriKfD6eNvJf1K7LYMoTcO5sFW2qASkyIxrLi3W/jLhf
 oWQ153cRtU4i92ma3a4MDrWfrnM8JyDeMMJKQ+LMvGfJZDHGdeSiYhwWc/qRl/UhOjH5
 nPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856651; x=1746461451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04Ru2G52IZKwkHppg+UoPnW9YEjqrdfMwPJFhOoWFbw=;
 b=vJ+Kh0MldljSmL4NmpjO4AnPltQtDv+YjNUdojYXWV7avE8AF8kmyUwMZ6jdEJyKif
 vfMVEyW7O+j4UHp2G495nFrKDwa3xX3cK9Z7bkmGAIUAp+TwvjyFvFTJZDdcwn1/HZNE
 x08Y2b2jJAqkkuiqWreTknmfVNeVFqjgwVHJj7OAEM4WBYmcQ0Nh2I5WkiLSsdszet58
 qgD7LpV9+3BDCBH+mzLh5qM9YfgvffVDZUwTjuvIPAaLfHFbSrvx53vDNy3TBnlwEWLM
 9PMzKrpn2cbzHIBWefNqdMM0WIen6s/n4iiyK0NQ/S18UdUr+igD+Ji5UhsivJ1FG2Ra
 +AyA==
X-Gm-Message-State: AOJu0YwQFcTaRU34SSrb1YmV4rRlSMtaAXNbX1HjOlTl1B/XbX0Bjz5o
 Ih2QC3q+xtTaOwi23DOi8z+/QoQEmzvALSNLMi6n8tDvt7iorDM=
X-Gm-Gg: ASbGncsDn47/a8GOvvTDSmffjl8XQMLsa6HRSppXIzcFy9DQIlFJ97T0kGQwgaTD3n9
 tiF7Ct1jco4ToUqbhcvyr8xeaXS946aVi48caFIuv28JO7VSUoSZoegJnOlo0j+RSP68N3wl5sR
 yFZ/mpdwXGMxViBiqYij/6LddqpkCmrelopnXkzBBsvVp/1/UPRCro2UucLlLJbJEvJAYX/d6UX
 pNj4QgA8zI2BdieJ7w4Ab5RwVFCdo7x6Ho3tc4NcOEqIErq706zXrYDgZTChaHoMGp7XcPNftJu
 FBSYPaQN6awgouEUCsqyrk+876susLQcQ+SYEzievrIBNONir/yhN2S5
X-Google-Smtp-Source: AGHT+IHJ9KKGnrSW1+N3nRSLeam5U+W/J0vSSY/JBIZz9s1ub8+XCY51mIvjV+QgIXYXdIBjvAZ35g==
X-Received: by 2002:a17:903:228a:b0:223:4d5e:789d with SMTP id
 d9443c01a7336-22dc6a0013dmr148209445ad.19.1745856651582; 
 Mon, 28 Apr 2025 09:10:51 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:51 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 8/9] vfio/igd: Only emulate GGC register when x-igd-gms is set
Date: Tue, 29 Apr 2025 00:10:03 +0800
Message-ID: <20250428161004.35613-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
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

x-igd-gms is used for overriding DSM region size in GGC register in
both config space and MMIO BAR0, by default host value is used.
There is no need to emulate it in default case.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 7f289a62a3..5d12f753ab 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -477,22 +477,24 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    ggc_quirk = vfio_quirk_alloc(1);
-    ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
-    ggc_mirror->mem = ggc_quirk->mem;
-    ggc_mirror->vdev = vdev;
-    ggc_mirror->bar = nr;
-    ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
-    ggc_mirror->config_offset = IGD_GMCH;
-
-    memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
-                          &vfio_generic_mirror_quirk, ggc_mirror,
-                          "vfio-igd-ggc-quirk", 2);
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        ggc_mirror->offset, ggc_mirror->mem,
-                                        1);
+    if (vdev->igd_gms) {
+        ggc_quirk = vfio_quirk_alloc(1);
+        ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
+        ggc_mirror->mem = ggc_quirk->mem;
+        ggc_mirror->vdev = vdev;
+        ggc_mirror->bar = nr;
+        ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
+        ggc_mirror->config_offset = IGD_GMCH;
 
-    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, ggc_quirk, next);
+        memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
+                              &vfio_generic_mirror_quirk, ggc_mirror,
+                              "vfio-igd-ggc-quirk", 2);
+        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                            ggc_mirror->offset, ggc_mirror->mem,
+                                            1);
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, ggc_quirk, next);
+    }
 
     bdsm_quirk = vfio_quirk_alloc(1);
     bdsm_mirror = bdsm_quirk->data = g_malloc0(sizeof(*bdsm_mirror));
@@ -631,9 +633,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
      * 32MiB. This option should only be used when the desired size cannot be
      * set from DVMT Pre-Allocated option in host BIOS.
      */
-    if (vdev->igd_gms &&
-        !vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
-        return false;
+    if (vdev->igd_gms) {
+        if (vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
+            /* GMCH is read-only, emulated */
+            pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
+            pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
+            pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
+        } else {
+            return false;
+        }
     }
 
     gms_size = igd_stolen_memory_size(gen, gmch);
@@ -651,11 +659,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
-    /* GMCH is read-only, emulated */
-    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
-    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
-    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
-
     /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
     if (gen < 11) {
         pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-- 
2.47.2


