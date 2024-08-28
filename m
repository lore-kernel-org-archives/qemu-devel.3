Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742AFC54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxW-0004So-H1; Wed, 28 Aug 2024 09:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxU-0004Mo-V7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:36 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxT-0002Kr-9f
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:36 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a86acbaddb4so626340566b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852613; x=1725457413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxXaT5Ge9ysYGoLxhhM7szMpSqkvt89S9Abd0b/m8pw=;
 b=LeHcZdFHC6TBjKH1DBNVz9C8/Pikg04Rz6ojz900inRfS9rSVKsgKzxLRnBhReo2dt
 iW/zOQz+0l0KZY8kbgAVPg4jh8qz9vE9q/hdhmQlwnqZOxMi3hTTFEUCAt98XEKMUj+o
 M2OBFehuGVNRaE3Od2RCkKmcZVsIYA5HzQ0QZJmkQEkpNAOA8deIl4oOYuC/lGOb/h1M
 FZ4JT5IEpw5JBMZQ25KzKGB+gGWQp40wTdpdEx/KbGHvwWbXVfBDewUfF1+BbxGTJ6QX
 dA9bosRjUDlmbVupb1vVKbUpOaKoF0/xaHoCUy8U0hKf72LsGAt2IJAvjyZ0d0OEeyJX
 AyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852613; x=1725457413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxXaT5Ge9ysYGoLxhhM7szMpSqkvt89S9Abd0b/m8pw=;
 b=GBE1eZNSvxIYlnVw8iFduitRdAnfcNtMGimc2E4cIOWGz5Rr20tZIPsoYaIPRsTgjO
 gJV2b1gInmQIBGf/JBFG6UXV25rQAnSf2kSrb4WzhUicxABE+C3V7ylekQpIU5kN0ApE
 cHAg4vxQg9N4TlvSccQndbT6tX4qlmx+CfmzvMNJTpl8zrVSrdZXeOogmmc/A3ZiMD8G
 MZJpLTa4ws6ca1Zeos+IFwMpe+q4z0eC6ubHHJk/Gt4XA0OcJPJK660MuEB+gI88FEAW
 MtLbIX/00NnGbN5opeuNxfZesR2RXPi5choSnp0MbMgB8qNm2RmgBOaJb0gzpgjq4jxL
 9Lkg==
X-Gm-Message-State: AOJu0YyTctBQmWFkspmvDYDcwX1Ohu8At9wwkAzMNcXqBl4fJ1/YC2gB
 8/vv4uNWQuk4i2Jb72d6N8kX/7ZDTLZunA5ahxjnXMMDVx7tqwdLAtrtWg==
X-Google-Smtp-Source: AGHT+IFBPL2h5aQ6nvjqF7BTB97SHmXxrdyU3doFhRkRnApjgalJnNaGNhC0vnl3utyq0YVakP+y6w==
X-Received: by 2002:a17:907:7290:b0:a86:fa3d:e984 with SMTP id
 a640c23a62f3a-a870a9b4a93mr150040166b.20.1724852613026; 
 Wed, 28 Aug 2024 06:43:33 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:32 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 3/7] vfio/igd: use new BDSM register location and size for
 gen 11 and later
Date: Wed, 28 Aug 2024 15:43:24 +0200
Message-ID: <20240828134328.94528-4-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Intel changed the location and size of the BDSM register for gen 11
devices and later. We have to adjust our emulation for these devices to
properly support them.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d5e57656a8..0b6533bbf7 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -100,11 +100,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
 typedef struct VFIOIGDQuirk {
     struct VFIOPCIDevice *vdev;
     uint32_t index;
-    uint32_t bdsm;
+    uint64_t bdsm;
 } VFIOIGDQuirk;
 
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
+#define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
 
 
 /*
@@ -313,9 +314,13 @@ static void vfio_igd_quirk_data_write(void *opaque, hwaddr addr,
      */
     if ((igd->index % 4 == 1) && igd->index < vfio_igd_gtt_max(vdev)) {
         if (gen < 8 || (igd->index % 8 == 1)) {
-            uint32_t base;
+            uint64_t base;
 
-            base = pci_get_long(vdev->pdev.config + IGD_BDSM);
+            if (gen < 11) {
+                base = pci_get_long(vdev->pdev.config + IGD_BDSM);
+            } else {
+                base = pci_get_quad(vdev->pdev.config + IGD_BDSM_GEN11);
+            }
             if (!base) {
                 hw_error("vfio-igd: Guest attempted to program IGD GTT before "
                          "BIOS reserved stolen memory.  Unsupported BIOS?");
@@ -519,7 +524,13 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     igd = quirk->data = g_malloc0(sizeof(*igd));
     igd->vdev = vdev;
     igd->index = ~0;
-    igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    if (gen < 11) {
+        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    } else {
+        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11, 4);
+        igd->bdsm |=
+            (uint64_t)vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11 + 4, 4) << 32;
+    }
     igd->bdsm &= ~((1 * MiB) - 1); /* 1MB aligned */
 
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_quirk,
@@ -577,9 +588,15 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
 
     /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
-    pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+    if (gen < 11) {
+        pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
+        pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
+        pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+    } else {
+        pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
+        pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
+        pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
+    }
 
     /*
      * This IOBAR gives us access to GTTADR, which allows us to write to
-- 
2.46.0


