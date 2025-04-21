Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8FCC369D8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u6s-0001g7-4p; Mon, 21 Apr 2025 12:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4P-00088Q-5u
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:33 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4N-0003K0-4z
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-224019ad9edso59751725ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253150; x=1745857950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4sVFv4vcdQmMjNtEjz8ql1XyA/nlU93n52hTlWvaY4=;
 b=XRcAQyI1TQN5qbjA4QWIHKQNe/I6am1Lj7026pYJovM4/bZDYldXWlwq6BvLhFHAmp
 dY+fbtVYarI+EaR1GjhPPE1w9tewff72CMMnZSYbRPVx70W8IyNISSs1X+V4quXO0+jM
 jTRNOPtqmZ7W1IVkZGToyyTiL2fG5jms+AT62M98pyONlW66zq3OmUvMGfSYgzKNwkW9
 nIBRbAs8l6H8GdFValAEF+p3jIo/GlnLX8HdFWYfFeogiJ3R9fj8b6ojDPOM/dtFBqV6
 V0xsHN3njtCeBMSs375f1T+u4KIG+hUaU0ED9uOI/i4p1dhe2Zno0qe5IfeY+XXsSQxT
 XJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253150; x=1745857950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4sVFv4vcdQmMjNtEjz8ql1XyA/nlU93n52hTlWvaY4=;
 b=A7s4RElmqFgiNOrOK9ge2BKX1PBg2WkZB/RF9u/vj8xKYHvPKpQTRFYyD7e6QiWIAt
 wm8y6dh4Q6tLrdet9Fx+LeGpfep/ZFvdFmsXXmzpNYDaJD45YkraKTGaw4sXLLnn7NRH
 RlMkWCq0daLR32FQ6O9B/AvRMz8Xzdw9+ajfF6dCbQa9F9xuqYJcvRmmYQk2Wt+HmMVQ
 WtoS1tW4uZB8ZcDaFqFgJ2zTmkELwpw9kQ/PCO3SMnyFTqfg5fE2Mwib/F93F7mvU/NV
 PsnIP03VlgTH03uiJvVor4jXY3kCVQkWit9SY+qGRYSAlHgjQEvWAdQ0GZgpI6gP4wCd
 Ziww==
X-Gm-Message-State: AOJu0Yx0q3nn9Mw3tFNGi106Oh5lM0lRynL7uPb1VXjmQEkn0GvnphGF
 xWH4NsWduU9YQXbDBvikVefvPYuuUFQKVnNMqoOOoFntLN+EZMs=
X-Gm-Gg: ASbGnctI/wOjejwvflEl9tKN1mGtzyuUYvQx4L5yZORym8GKrUOOe7AIDIp70crIJ2a
 i+vdECksqroPKuYzTd9ZGdrqrHheefWwWQzSp86C5ruai9cVlhNAjGGXx7BJxRFx9+Ldvg7e93f
 FXRhWC486xoZriEb8EA6E/4tWCm4PXDlNuz0j8sYTo7SKvAn8YUStH8ufFJ5fWX+h5NCftJ7SIe
 RqhcnGR5aBy/S8mY47FH/KIxzq7UV95JcWqNcwusIptuvh9L9WFMn8tRR4NUy79NoAmgu9OH6XU
 vlkZG/qjBXNzSK9diqVUlWUQ9nKv/G+84YZaQa9lx03Jl3MSgnnBUA==
X-Google-Smtp-Source: AGHT+IECVA8fAc7p10FAiHSxSfxRuikyZbwjBteFpDMg7o5sVeRCdLqhKeiaFa48rmcDfPawPTshLg==
X-Received: by 2002:a17:903:2f88:b0:223:65a9:ab86 with SMTP id
 d9443c01a7336-22c535a4b55mr187896845ad.12.1745253149681; 
 Mon, 21 Apr 2025 09:32:29 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:29 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 09/11] vfio/igd: Only emulate GGC register when x-igd-gms is
 set
Date: Tue, 22 Apr 2025 00:31:09 +0800
Message-ID: <20250421163112.21316-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
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

x-igd-gms is used for overriding DSM region size in GGC register in
both config space and MMIO BAR0, by default host value is used.
There is no need to emulate it in default case.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b747fdfaeb..bc4c79837d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -453,22 +453,24 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -611,9 +613,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
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
@@ -631,11 +639,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
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


