Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6230C369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u53-0000EN-7J; Mon, 21 Apr 2025 12:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4A-0007yg-73
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u47-0003IH-38
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:16 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-22409077c06so56939785ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253133; x=1745857933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3318dEN5yphn2eGZq8qF6y5ncWXLMOk5ZMejbsDVdQk=;
 b=mWAnldTtUKT+e5jKJB1Ln9/6CN9JiT4HR94gWrA5j3Gw87MAqMkpEiGMiF2QIUV1KE
 hDCttS0FvbAUh/MkQX3jubLKPeXk/zLD5WXozDhI22AObjuBW7CgYcG0BU00Gp8flAHs
 77H8w28MKcrLsFzBC0mFhOARSmztBMKJCreJcbVgR+wj1vSZqec5qyDGRD8DUfN1K0DN
 MbKFClaeA71hslhF+uZ+rzG0qpUWijQvfWoqVyefAGAa/jgbO8zR/uDLOI/fenr/p8qH
 JbS/o15XIIkO9bY9gUKvUKQH9ma8LPyoWiNql0bEnvqZ6rgL4KZGPzm2hnVQAUVeJ+dB
 RyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253133; x=1745857933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3318dEN5yphn2eGZq8qF6y5ncWXLMOk5ZMejbsDVdQk=;
 b=X9ql1l25LH8mtFke6s2HOZA5l/eD0lqlygqftr1B3QEKXph0YnveEH9Ay2w82koOfi
 898UGw+r41C4E4rh5sUkMwu45FGTyCF+q/zPWYbNttv1fAmRohj8GjWZz/rprQqt4CHA
 SkQRf0AqyiDt0H6CHjLHq5ZkbW2PxQuLLnJZhs3dWsZoKJXAY0n6TuBgI4WXtkDmjOBr
 LZfHXsHguO8pOpYEkC8nlf0UP5RTuwdz3RAQARSlaEyj9gohFGE24qjuZIuAt0OuZPf5
 ES9T/IrjeIIzsZtRPSGRHzTqdyGDq9FPC7jwTMrLdzG4PNQ294Pl/tr1d7vJMnxwRjvS
 mS0Q==
X-Gm-Message-State: AOJu0YwfXQicwmytW0UBbkGqVzWmyKSEhZuAXhIohCvCOX3EgxMXI1Ay
 7RJ/rqTaUlDhbM0Acyb4XpquiKnL/apPIUdp2ZYikZsiZWwrxRE=
X-Gm-Gg: ASbGncsPz2bFjxWdlbrea0XpoD4m7j/y15oC5iCkqwCY48Hd7kXB+L3P7ieReGppwy9
 //IoTHdUmnHQiqn39pEExXqhrtfY7yLXGp+xQKhyCz5deKoP7Wp1eF7F9MbWwBsjIe35Jf9VslV
 9ywK0+0g7m8wbLNyyLQ9igc7SWfCiNSy/FHBBwhWn7m8PmIRQqBRGBONAwqGLWmcdUpoRFqS+AN
 YbJ2lCRy+F7zxYtbZu2Ctd/857pJlR+wWEQTPNT4GGTbgdk5P9FKjYPMITSqFKfBXV4yOqpO3gq
 rw57NheQus1xlutL9/UQmljtc1JATu01AFVlqnIR3oMaxqV/2/ggJw==
X-Google-Smtp-Source: AGHT+IHUNAU7ZiC7RQMVPSBbSy61NbMAPFEfzxejCErgV0gdk/K7Fk3VkNoFYwS1jq87jgf7DqOjxg==
X-Received: by 2002:a17:903:2344:b0:224:23be:c569 with SMTP id
 d9443c01a7336-22c53583780mr198484455ad.22.1745253133123; 
 Mon, 21 Apr 2025 09:32:13 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:12 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 04/11] vfio/igd: Remove vfio_pci_igd_setup_opregion
Date: Tue, 22 Apr 2025 00:31:04 +0800
Message-ID: <20250421163112.21316-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

Since the last commit, vfio_pci_igd_setup_opregion is only called
in GVT-g mode. Move its functionality into vfio_pci_kvmgt_config_quirk
for more GVT-g-specific error logging.

Also, hotplugging GVT-g vGPU is now always disallowed regardless of
OpRegion to prevent potential issues. Intel has never claimed support
for GVT-g hotplugging.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 7a7c7735c1..cc397f8829 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -185,33 +185,6 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
     return true;
 }
 
-static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
-{
-    g_autofree struct vfio_region_info *opregion = NULL;
-    int ret;
-
-    /* Hotplugging is not supported for opregion access */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
-        return false;
-    }
-
-    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
-                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
-    if (ret) {
-        error_setg_errno(errp, -ret,
-                         "Device does not supports IGD OpRegion feature");
-        return false;
-    }
-
-    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
-        return false;
-    }
-
-    return true;
-}
-
 /*
  * The rather short list of registers that we copy from the host devices.
  * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
@@ -681,11 +654,30 @@ error:
  */
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
-    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+    /* Hotplugging is not supported for opregion access */
+    if (vdev->pdev.qdev.hotplugged) {
+        error_setg(errp, "Hotplugging Intel GVT-g vGPU is not supported.");
         return false;
     }
 
+    if (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
+        g_autofree struct vfio_region_info *opregion = NULL;
+        int ret;
+
+        ret = vfio_device_get_region_info_type(&vdev->vbasedev,
+                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
+        if (ret) {
+            /* Should never reach here, KVMGT always emulates OpRegion */
+            error_setg(errp, "No OpRegion on Intel GVT-g vGPU.");
+            return false;
+        }
+
+        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
+            return false;
+        }
+    }
+
     return true;
 }
 
-- 
2.47.2


