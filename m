Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3825DC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlZR-0000XY-Nv; Wed, 21 May 2025 11:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uHlZP-0000Wk-Vn
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:41:28 -0400
Received: from mail-oa1-x43.google.com ([2001:4860:4864:20::43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uHlZJ-0006Tu-2i
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:41:27 -0400
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-2dfb991cb45so2638873fac.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747842079; x=1748446879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A6jfLpKQptxg0zC9dbH9E123pO1cpNNT8hDmZ8jY5SE=;
 b=RPahYFtOvIygVxkIMzz7xhd6GMeG+qZs74GqkpPQ6+DqyM281QIOmeGUOtFhH1CqKS
 awW0KC1IRGBn+5p63mVSv4/rUcRKlbUvQcWi5p7DSwpsaF2M8qcLEOOMUBjBWX0f+IaI
 yhgrdsMfCSqfeQbcIWBrsKqxErD4M5AeMFyD5MSZiVkkWQaFsMKij7wWccBb0rxmje8A
 E33dPVNhovNYeFhSIfOSVcCQuw+wygbrWbf06Q2UE4h/OkeD0IaX4h2UMUTvdALiZk6o
 Wq7jSLqNqAqxJKMP9kOPm7ZUU3KcUq2HyvKfP1RhwQPkEGuAx52t+8kD+NUHlnKfTZla
 Jp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747842079; x=1748446879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A6jfLpKQptxg0zC9dbH9E123pO1cpNNT8hDmZ8jY5SE=;
 b=AwKQgO9ZvtQ6fODIhzR36QGaIFGCETh5z12NFnrEr5buZVllYWlvbq4WR+h9kA587x
 Q+PyRY3DG1pI8c8wlWbTyBox6mZ79EZpb640BegjCdY+WsYl5NUk6xSFPQxyMOdq9BYp
 ZHJAoCmtjWaTpOhvFvllEOcKNGLA2JDUUcniTJx929tcCyTWxFIqkkAobSUcKHU98qWi
 6djDQyvxJUfeEu6n+EYzChF+YcGJmyTnxGFFa8mK9/4mmXcZPviz9OSQEnm1TvuePU9G
 GXYcWu/vaC0UAmSQOVAVgvPeJj3e019pGssUUW30ON4SYaCjwbCkzv8NaWLkyZOph0oj
 64mQ==
X-Gm-Message-State: AOJu0Yz8o4asqi6sDiMYThabQLo4UwlHzmeidcA73YgzBqWPkTo6cScy
 Y3MiL51DvB/iolgsSK5jNQVsY6VtMwE5NiiQyc+HMZK+LV2k6f6WPO8ltyYNgsOQqQ==
X-Gm-Gg: ASbGncthBbGZY4TqLT6S/bAdh4bFoxucPD9SZZUDQcS/nlMdRY9+h/HvRT9pN+SdRn5
 e33P44cdZ1fKnIrFX8Zz2V0Sr8OtWJC/O60PiOOXghrIdmOrcVxzz+/0Nu3HeHY85DKxYUxjavY
 cW0p96BDo4eo6GwKDr391rjMIU1ntk/G3MHStHn9YOsdwtkS/vjpQx78iV0Ohb6CYFacUXLEIpN
 Nio2jZvtJd4z1IGWz0fSQ4U8JDlFO1T34eOXPthn6qCgK3JB5KbcP23ZXXBZj3zQ2oNTVotFxMr
 9ZWV6uKmotJqanf1xnLa0SXHKbhZ+FN5cQXqjQKGBT9GgmyCdu8832PhYSjfC6lusMIdsxpI+0y
 +xg==
X-Google-Smtp-Source: AGHT+IEw0RIPqTO3VViwtxIoNKFZFp+5d4i0JkARTC1NGxLyX4eQM8zx2f+0FJscYRU+j4+HX2Gg/A==
X-Received: by 2002:a17:903:2342:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-231d4516a4fmr326557525ad.22.1747842067762; 
 Wed, 21 May 2025 08:41:07 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adba6dsm94644865ad.68.2025.05.21.08.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 08:41:07 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 edmund.raile@proton.me, Edmund Raile <edmund.raile@protonmail.com>
Subject: [PATCH] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Date: Wed, 21 May 2025 23:40:36 +0800
Message-ID: <20250521154036.28219-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::43;
 envelope-from=tomitamoeko@gmail.com; helo=mail-oa1-x43.google.com
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

In vfio_pci_igd_opregion_detect(), errp will be set when device does
not have OpRegion or is hotplugged. This errp will be propergated to
pci_qdev_realize(), which interprets it as failure, causing unexpected
termination on devices without OpRegion like SR-IOV VFs or discrete
GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().

This patch also checks if the device has OpRegion before hotplug status
to prvent unwanted warning messages on non-IGD devices.

Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
Reported-by: Edmund Raile <edmund.raile@protonmail.com>
Link: https://lore.kernel.org/qemu-devel/30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7952d15a0..e7a9d1ffc1 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 }
 
 static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
-                                         struct vfio_region_info **opregion,
-                                         Error **errp)
+                                         struct vfio_region_info **opregion)
 {
     int ret;
 
-    /* Hotplugging is not supported for opregion access */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
-        return false;
-    }
-
     ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                     VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
-        error_setg_errno(errp, -ret,
-                         "Device does not supports IGD OpRegion feature");
+        return false;
+    }
+
+    /* Hotplugging is not supported for opregion access */
+    if (vdev->pdev.qdev.hotplugged) {
+        warn_report("IGD device detected, but OpRegion is not supported "
+                    "on hotplugged device.");
         return false;
     }
 
@@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     }
 
     /* IGD device always comes with OpRegion */
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         return true;
     }
     info_report("OpRegion detected on Intel display %x.", vdev->device_id);
@@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         /* Should never reach here, KVMGT always emulates OpRegion */
         return false;
     }
-- 
2.47.2


