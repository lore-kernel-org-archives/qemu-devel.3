Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEF2C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9zP-0003Bp-3g; Mon, 03 Mar 2025 12:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9yB-0001aK-Kn
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:53 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y9-0000KR-Gu
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:47 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22349bb8605so91997065ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024364; x=1741629164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRtSHJvA2ZisXRCw+d0PCWWfXqzJR04ZEJdwHvxg6SI=;
 b=jrZjQuHtqwJbn2fW013VIeeLrHWvlAgIgl4nYU3hDqkWGY5bM7C6sg8scEzK+JGJqR
 4baBIa591Dq5zeynzC3We5PuS1NoAv0ABcLWsqKVz2bJdRhcCuTylCxUaIwLStHDCvBT
 Db3D+hd7/bOxS8lowf9cwR5QySXw9BM6JL/cMmpgmuwn+SvUdLe7yiCaoE7j7XnkhlxD
 dpsmSikiw6WLodlx/ru49iFqVDxMk4fGgPsEQtDJtH6gXeoN40b8B1D+5itRZLe5y/VL
 N3LZtxsOH6vu1UDZGBv5+OC1oURlMbKSuwDy0Cc3uf675yJhLYt4tFbIGaLzwW7WaX5z
 JvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024364; x=1741629164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRtSHJvA2ZisXRCw+d0PCWWfXqzJR04ZEJdwHvxg6SI=;
 b=R1pIs+GZWXLoaZK7JptjDHYpPTi5cocMAzWk25zh+pn8UNoanrHNfaPNMmb5MfD+cg
 voPfkM+fNqzPL+sMcIPdCVT1d9kml0yrTz+fD70W6ChxdOMF91p3LrL5rzlRMLCfo0QE
 NgXaaol6xv9FvMc3MXOQaGFcv77WBnejKFvaX848HcObfwQbRGSxZwKseC7QB/wFTH2f
 Eckzbhy5IWtF5+PWhlfcjkSZmy6vlniXhSh9pveRFeKntd+IhpU3aETllUs1SZtteACS
 voByRNUZxRd2sb1MmrGNur2D0nUv83YCDc3dzUW+fkAaI1uo+e/KePdCzowD9qYlj5QD
 4COQ==
X-Gm-Message-State: AOJu0YywM7ymkqAY57q7XV9OP8mpuhdfIZCn/7uvjtUI2b0S8l3jP+mT
 jWiN3hyk5L0Qur1/xTGOaLoCGYv5InVegykygp3DkksyosVhOAlmz6PwFw6m1A==
X-Gm-Gg: ASbGncsvQIsg6la7VOmQpmiritz3vAcJascV/A+xYlONp/hL4WZRuxsjcsRTD5IHqsP
 uml3anPwWOT1yf6KCfkT9WXsgiczx+o2jLjP9kRSSzFEAMziS310WNIjmU2GdIV5hSQsi+dkp65
 WuQDVvWuOOn33brEduoeu+LLSEit717xRl+jUSEueyNCh98jUw/wwmZ9/ac/p9Bn9HlCN1KSWzG
 vWSdKNbuhi85JqdHJiZl20hPqT6EL2f8Y92U+adQCkSJLniZ/ODhTtcGm70ZvqtUgZ8dzKV8sdJ
 6jAW7z02Kftw4PWv+bJ/Ou0SkzfCW7ykgRpnzjvcA/Amv067V7Jm0mUX6Q==
X-Google-Smtp-Source: AGHT+IFZ3D1jkr20vtSH8vMGSnsN0+HBbREHyvo+VfTkeVqYaeCAk/59uoWAGXpE1iBddPTengG6cQ==
X-Received: by 2002:a17:903:2412:b0:21f:8099:72e4 with SMTP id
 d9443c01a7336-22368fc97b7mr258114125ad.28.1741024364173; 
 Mon, 03 Mar 2025 09:52:44 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:43 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 8/9] vfio/igd: Handle x-igd-opregion option in config quirk
Date: Tue,  4 Mar 2025 01:52:18 +0800
Message-ID: <20250303175220.74917-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

Both enable OpRegion option (x-igd-opregion) and legacy mode require
setting up OpRegion copy for IGD devices. As the config quirk no longer
depends on legacy mode, we can now handle x-igd-opregion option there
instead of in vfio_realize.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 14 +++++++++-----
 hw/vfio/pci.c |  9 ---------
 hw/vfio/pci.h |  2 --
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 40f5803be9..9bfaa24c24 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -189,7 +189,7 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
     return true;
 }
 
-bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
     int ret;
@@ -557,10 +557,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
             return false;
         }
 
-        /* Setup OpRegion access */
-        if (!vfio_pci_igd_setup_opregion(vdev, errp)) {
-            return false;
-        }
+        /* Enable OpRegion quirk */
+        vdev->features |= VFIO_FEATURE_ENABLE_IGD_OPREGION;
 
         /* Setup LPC bridge / Host bridge PCI IDs */
         if (!vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
@@ -568,6 +566,12 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
+    /* Setup OpRegion access */
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
+        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        return false;
+    }
+
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b0620a0ae8..8fb415cf45 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3136,15 +3136,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-#ifdef CONFIG_VFIO_IGD
-    if (!vdev->igd_opregion &&
-        vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        if (!vfio_pci_igd_setup_opregion(vdev, errp)) {
-            goto out_unset_idev;
-        }
-    }
-#endif
-
     /* QEMU emulates all of MSI & MSIX */
     if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
         memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b7b07644a8..4bddfb80f8 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -232,8 +232,6 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
-bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp);
-
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
-- 
2.47.2


