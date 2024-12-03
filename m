Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42216E64A94
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4o-00084E-JY; Tue, 03 Dec 2024 08:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4m-00083r-H8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:28 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4k-0001He-Ts
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:28 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-215b9a754fbso8804725ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232985; x=1733837785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6y3oESVfrKOXA+XnLfa+UeX0xbcIB3f2chF6SF2TD4=;
 b=gQUUbNgN+GagQ19IHTPH7hnPk5792PfOSLFKxNyqYTbuLS1FCvQ+gDBjrRgIxYueaY
 V1N8JyZ2HgahngABXIWBuSHsm/fiAro93vXEv1cBiJtmc4mMEmJHstz4EOn1fXwCVkow
 n4eLWrD+YkyGF+EGxsrkmE1s2lTVxyQJ+2CTNWFTjEy6/De+3Fj5PQajr+SukNiBSYFY
 abmv+xVVXHbHHgrBjw+QGBJUigvyvX+U5LusUblxY0nAWvEAdcmyjb6GoZzVotZ5IGyY
 ZCsY5dQvWwL6pANjY9d0V56oVbRrtr2BVYySADH5IO62KrGlJa48iM0MuDUXK2CmMn27
 OshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232985; x=1733837785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6y3oESVfrKOXA+XnLfa+UeX0xbcIB3f2chF6SF2TD4=;
 b=UjvW+xdbUXTPISPG86rWUCX2H0bxWABhUk1zNZCSqy+OcDi7O7s/xumxMz39vZgcH3
 gkhdn0xTd3/S+OMmTHiVWjhHscChuwjpCfyFh6TYX3cQWRySK8jT4dg62vAS7gX4gjW0
 LJUpMi7WKic+UGDQHmNqXZ8+TGJP+Ry5U4cIoK7/CCQ/ap+uVc+qj+twtNrSwkpfMns0
 t5ph3eSGnbqJwQtywTmpo2STNI3hK5jFloXjiCrLBKSblOdgoNYlMvzafs/0Xwbnxdwg
 s1nmXPMexobPxJneCxMctb2xIADnGaO1+QNXboVGz1Bg/LaEP9pICDZ0FP574TdvNHQ0
 EOkQ==
X-Gm-Message-State: AOJu0YyZZ308vxqxCJd0VR0eoqlcN1FrkFMHM6c5K8B1A1zYEOqwuMsC
 Z3l5NrHqV1CuFaSp0DrWsKmgWA/s5hlNnZQyAZmFBcBv52vbdaf/gPrjupMUwA==
X-Gm-Gg: ASbGnctWZ2HKYEfJ2xeBFtzWgaISHKQEBGOSQKEfBupgS0JyEEUi3vtaCpJthmzKW+I
 0o+GtNRomS+rOVstCP6cem3Ygxsde6yhBSOFWN9SqHLSJ71S9b5OoLqPWVb31IN5C8zH5lXf3ZK
 EPM9pGlS96KTNr1Xg916f7CH77MOw6/46scJsa5zSZk693KTZ/3fDFJHGkojYgC60Mliua901aw
 xMohEtd8NoSYtH5xUlrdIdxPgDKOC2YyW3JrBkEm8C0yp3JjXgwyBu1TYc=
X-Google-Smtp-Source: AGHT+IGbTN/CU/lv2UfQcCfeoRpd3uBTpSmG+s4O317DJI/1IOZMDonFrSmrsnMxZb6+HzzSHBlT4A==
X-Received: by 2002:a17:903:8c5:b0:215:6995:1ef3 with SMTP id
 d9443c01a7336-215bd1b459emr24735095ad.3.1733232985279; 
 Tue, 03 Dec 2024 05:36:25 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:24 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 8/9] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
Date: Tue,  3 Dec 2024 21:35:47 +0800
Message-ID: <20241203133548.38252-9-tomitamoeko@gmail.com>
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

A recent commit in i915 driver [1] claims the BDSM register at 0x1080c0
of mmio bar0 has been there since gen 6. Mirror this register to the 32
bit BDSM register at 0x5c in pci config space for gen6-10 devices.

[1] https://patchwork.freedesktop.org/patch/msgid/20240202224340.30647-7-ville.syrjala@linux.intel.com

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index bc18fc8cc0..e464cd6949 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -484,7 +484,8 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
 };
 
 VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
-VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm64)
 
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
@@ -511,7 +512,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
      * into MMIO space and read from MMIO space by the Windows driver.
      */
     gen = igd_gen(vdev);
-    if (gen < 11) {
+    if (gen < 6) {
         return;
     }
 
@@ -525,12 +526,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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


