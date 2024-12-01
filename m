Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8816D4977B
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmej-0006Am-AG; Sun, 01 Dec 2024 11:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWL-0004l0-UR
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:07 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWK-0000as-5F
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:05 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-7fbc29b3145so3112140a12.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069402; x=1733674202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tueBpIYPosweRTFKRGJqnAbIWV+bdPvEzW06gBaClo=;
 b=RwrA3Q6k69Vlc2Vj7SavtsdUx/s0Fr/kSUya4UD9fVhH83YCZBrPMX2lvrbpMYlS5h
 5sCDDHFRfEibcqZHwmfkIORz/mn+abeaJPm72z4X6/fMrh7MW2j1AXU0gOUE/7eABumJ
 VmdVakyl5sdY05PjOhwtb8F3vLNjbJ82QlHIpX4TP3/6kZMSMT61M3078OmiQh0ASam6
 lQNK2GlIHhSumvQNEI36syLdM6QHY0Jpi1i/ubMnAJEUDTXRWqmDbDHJXTpcDjo3LYP+
 kFan3Uriiqvfb9cYkiadnlQJd1zMlemqvTw4FiqssUBPI7LbOcSg8zT4cjz1O/pAWkEY
 3wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069402; x=1733674202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tueBpIYPosweRTFKRGJqnAbIWV+bdPvEzW06gBaClo=;
 b=PKcSbxzZp9UyXGLgLveDd2JNPzzaBL0CSFxEgoPqGV36eoMtFSbEfhJDO0csvYZl1K
 puj/rx1I7JaeBrOVZnKHDI1rVHbuh+wTwkqoQ+QI5dtY2vmosLMpA8Jm+0xAhyTbkm8/
 QwqytruPrYfRiKs+xktjfbfCaPkZdZrNCb4B8DgfzBjEsOTBu85Nur8vRwa0qEjmHI2p
 O1wNeo6OfheTTPfcgdqBIGLFU7J5Eu14CVOv2+9edYYGbjmM93W4UNPC0CgL61tCf4b9
 5Z64qVE7jKw+ydrRd+UssrbzQ9cdiZ6Qtco6Zfs5v6NxL04RGMcDteOIKmUdzVQNuwCR
 zYJg==
X-Gm-Message-State: AOJu0YzDsrfTfKZOlEujNvduEiFaOH+Pfuilnco5g9UJj9MLhVJo7TM0
 S1eWzQrxYfVZ0wSBH3wxQz+MR20d0dOO1DEwaBAOuicYVGf4NJhhBNlGV6fk4wrm
X-Gm-Gg: ASbGncvXSqs7SmIzD9hiCzAkPhMgRs1NL7Dh/Phk6GBygl+czqN5EW8R5yA9AuaZPBL
 l3vFnwWBFJjP950rWjkGj+gco6KTRr7itSALitRLCqW1PVoYv7fINrVn3mqIRUz99ejCbh3P+Qh
 jKWJuIWsryRAQRVjoTjFKiwwrh519U/zD56thi7eS8aE5bnALhpW/Ssj67/7d4+sS3u3j95VBUF
 zPv0uUreOqPrF81mdOFhP1DWcdvOrPUAVsWaiIh/cv7pMBl+9ncYTs7DfY=
X-Google-Smtp-Source: AGHT+IF1/MrkmyKDLZLiIEUl6wJ9c6krgys9gLqcLjRrFJn3nYjCG1QNNE06M3efbTLsKQEnuAijhA==
X-Received: by 2002:a05:6a20:9185:b0:1e0:c166:18ba with SMTP id
 adf61e73a8af0-1e0ec841220mr21690295637.12.1733069402049; 
 Sun, 01 Dec 2024 08:10:02 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:10:01 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 7/8] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
Date: Mon,  2 Dec 2024 00:09:37 +0800
Message-ID: <20241201160938.44355-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201160938.44355-1-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x543.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:43 -0500
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
index 07700dce30..3fd822241d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -482,7 +482,8 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
 };
 
 VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
-VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm64)
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
@@ -506,7 +507,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
      * into MMIO space and read from MMIO space by the Windows driver.
      */
     gen = igd_gen(vdev);
-    if (gen < 11) {
+    if (gen < 6) {
         return;
     }
 
@@ -520,12 +521,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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


