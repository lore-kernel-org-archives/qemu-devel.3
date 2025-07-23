Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48349C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uec29-0002Ev-Ab; Wed, 23 Jul 2025 12:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uec20-00029A-GD
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:09:27 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uec1y-0004Af-1A
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:09:24 -0400
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-3137c20213cso1847a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286961; x=1753891761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHffcDkEd5IyvSc6NJ5MksKSKbYft6cFEVxYiWUulo0=;
 b=PUYM4WSExPPZD2aVnXvMB/dS5ZUoHiri8rzSBgxd+nvOMmo/TRzYb9rsqbCUHnXzYr
 755WF/4VD03SBJEFA1Bvj2ik5jO9nh0dTBNiWgeReGwc/tFjycaEBfRwbjTz70oragVv
 L2yvoXi/o17QybzTUpQ27GRByDfC/FVrwZFKKzm8IZhmpiYs1f3BuzXLc4rAWa3fvnz9
 PHyCx2PBzHxLtkY2sta3fBQnrBpmnU9AqOC10EfeOHi/FjTlT5/vrw/5LVJSwOTBTBdS
 Lfr+jo2RMHcxjX+gZJOA2m5lhGVAYA1zA9LQeMhWTpa+vP0Z4wMMWaKUiiYtkG9sqvTs
 Tdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286961; x=1753891761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHffcDkEd5IyvSc6NJ5MksKSKbYft6cFEVxYiWUulo0=;
 b=RPNhmjcCkaSdJC09SR2tpC5veaLzEnXzk6/wSE3idanKhqQXYMhc+QvcZI7evQRnIo
 VqqB5Yaewx6iaqzaGZ+RodhA6qflQQk9bzlZWo24LoY7HPYyb113/HlTbcPotdWDnoaH
 QvLDg0NHheszj9I0bFu8y5SQ8wp7c2qk8rgCrXPY66kkb+Yg2zrMrv7dY37G237gXVzx
 r1sQ0FC/pqOKIlgJtsDnhnxdME5y9Av8IBSRrzy8dYvlG/noz7FTbiP05gI44MQpbpWx
 0lPBuaZX1QchIdWCzJuouImLL1NPf6LBV7XgAwrYSrdW84/mZu6+h2A7TjKiTcAHM2zI
 m/fA==
X-Gm-Message-State: AOJu0Yzart5gF8yAK7yhEl65xrauBsPzY4ZrxkEaoQPtJAfP/C0kSUjW
 XVQML34VfD+OlX/3dW+1CBvEy71ig5vmOXqCwqoclSBuAre0T2gWC6p37V5CWbeQ0w==
X-Gm-Gg: ASbGnctbjLbJuLgR1/hm+8LheiKKpYBpWSUoZwebnc8GZt263VytXrEZpMvmge7tXvX
 45dx0L4cBVj+ETEx98DfFk3G3e2eDwV/4OZtNsIKksmoC8Si5LHRWA8BEjBjxZNVqU7hr6Dr1sb
 2FsKGxlfaTUWABDjO/rRYBm//sQF7lzY/bF8lKP1T2Am/pdJfNiOEPuIZjdDsNAnYCNWoGmqlaR
 K4xJQBknG4sMlVkgijf/qrLh/o/3y0m5meKytHqsp/dSRHEV//R13OEW8C0sUMBIPKwrToqi2UL
 NhS1KQLoG14TIJS0EPywTsvckIY4ICThvc2ujaDkOZfHBzI3xxb29pa8LVS0BFqTYxo6KeTrBrZ
 mvyDzKJ3xSzV1Sh+vMIQOCqk9LDe5LjtGhps=
X-Google-Smtp-Source: AGHT+IHu1uKVDT6THDnmjzvTRoJps5DVnAzqyrGhcxNEMg/7oYbxFAVfahkh3RVl3vPZpI8WJopYMA==
X-Received: by 2002:a17:90b:2686:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31e507ce0d9mr5211127a91.29.1753286960266; 
 Wed, 23 Jul 2025 09:09:20 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.46])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e519f61eesm1968353a91.14.2025.07.23.09.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:09:19 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/2] vfio/igd: Require host VGA decode for legacy mode
Date: Thu, 24 Jul 2025 00:09:05 +0800
Message-ID: <20250723160906.44941-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723160906.44941-1-tomitamoeko@gmail.com>
References: <20250723160906.44941-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1044.google.com
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

Commit a59d06305fff ("vfio/pci: Introduce x-pci-class-code option")
allows user to expose non-VGA IGD device as VGA controller to the
guest. However, legacy mode requires host VGA range access. Check
that GGC.IVD == 0 before enabling legacy mode to ensure IGD is a real
VGA device claiming host VGA ranges.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 docs/igd-assign.txt |  1 +
 hw/vfio/igd.c       | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index af4e8391fc..e54040335b 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -48,6 +48,7 @@ Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
 QEMU also provides a "Legacy" mode that implicitly enables full functionality
 on IGD, it is automatically enabled when
 * IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)
+* IGD claims VGA cycles on host (IGD is VGA controller on host)
 * Machine type is i440fx
 * IGD is assigned to guest BDF 00:02.0
 * ROM BAR or romfile is present
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7a9d1ffc1..5b1ad1a804 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -113,6 +113,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
 
+#define IGD_GMCH_VGA_DISABLE        BIT(1)
 #define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
 #define IGD_GMCH_GEN6_GMS_MASK      0x1f
 #define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
@@ -533,12 +534,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     /*
      * For backward compatibility, enable legacy mode when
      * - Device geneation is 6 to 9 (including both)
+     * - IGD claims VGA cycles on host
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
         (gen >= 6 && gen <= 9) &&
+        !(gmch & IGD_GMCH_VGA_DISABLE) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
         (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
         0, PCI_DEVFN(0x2, 0)))) {
@@ -568,12 +571,10 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         }
 
         /*
-         * If IGD VGA Disable is clear (expected) and VGA is not already
-         * enabled, try to enable it. Probably shouldn't be using legacy mode
-         * without VGA, but also no point in us enabling VGA if disabled in
-         * hardware.
+         * If VGA is not already enabled, try to enable it. We shouldn't be
+         * using legacy mode without VGA.
          */
-        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
+        if (!vdev->vga && !vfio_populate_vga(vdev, &err)) {
             error_setg(&err, "Unable to enable VGA access");
             goto error;
         }
-- 
2.47.2


