Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129E1C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 12:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0lk-0003UQ-U0; Thu, 06 Feb 2025 07:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0li-0003Tn-FH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:06 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0lf-0004UB-LY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:06 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5dcd8d6f130so1724144a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738844038; x=1739448838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI3fpWvES9nsmK1npycauoVJ3MRfZujDLujPDGvVXx4=;
 b=E2iCUAJ3ss+1jP/6s+4fHHVfRu3VX8oGGwdvX2JVGOTfon29EVUFeTMxLkYP1LKAaq
 v3rRd3CrixBl1NwTxi7qkaH9sfX5y1pN58x+Q1zCC9x7rTVKy+LFZU1eJMeiY4yxqRy6
 HuyVpwWBZAAfG583TpXpuWxbY0ur56l/OalwhOT57DdpWeQndFA7jJOn3P9fbrfZb51Z
 9zC2dY6YOmwuCZ3TJnQUNTRqmQUw3M1kA4RbCUq12KmvPjGGheFNnGfNbKWSEsK7o26o
 eaaIgrvZfKVxLarJfnYj++TJ3AX7nlm6SJ1nRjqY1caT/x8/c5ebxJWH5aL6CLAT57Yr
 l+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738844038; x=1739448838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RI3fpWvES9nsmK1npycauoVJ3MRfZujDLujPDGvVXx4=;
 b=XlW4SKrEeaaktEtm8NsXgXBYf3wVZa3VUBMtSKWFLMgf6cqxPJNFJ2BefIS+Urg49r
 3AW1UwZQpBNMop9T56GoWV7brr36bxl3yTfE4Say/hbp6t9ZLZRQJKRPnONibnsUxqsm
 Y8DjpQcxFUh3peXLaVq3SNja4fpeoorLJEiSIj5EQ9kgKIWjKwuAbLL7POUjo/3xmfHI
 zzfrNJPfw9Pz5JeLyRBRnFr1kDoj7Aa0N4sPVTfpAGgfFPHJ1REJau3HreovLwxCGCmI
 NlU7pToVzof9hSG/GjLIIu7lvUOZ7J3ILASOYWimTPk4xShTZP+XRlqYMejwaGmZ0/yi
 8LDw==
X-Gm-Message-State: AOJu0YwuUnvwiDsHUiqdHoa1xE7yw8QujfyTKB3ql/8vt8dAkRWAyHA1
 F3Xdd+5JUfhF+xCIjMIPPVNOaS1UpjEW4b9LXUW+TFyMW9mXDkpExxqzHfCuG/4=
X-Gm-Gg: ASbGncs19mFKMs3c8YpETcW1xew0jocrIeJnAMBmSpU/tVIhCc7Byqc/4twrQa4GR6w
 psjIV78jo7QzrDwQesgNhNPX7T7ILFkPvS/UVe8BA89kAd5Moz7QfrzOR0VguiPKRHtQk/rHdou
 rpFPVfpMnzUgsY4yPdjmwC9AsWKDBw2gOMjvI0es7tUvN3CsA1MaEunvqS9lyatriDQ/evWaPXZ
 48tiK3sTS3AjPrg8lY9VGHweICcF3yutvU6DulT5ApzePt1bN+hCTBiPoZwBlsTKZk2JBiA6Z4L
 kDzDwT5wXL3SxEYi/h6C2vSJ060bmjGMiNhrTVr+/Fw=
X-Google-Smtp-Source: AGHT+IG2BWYp9o1ybtcBhvSn8/nVOb6YVvkETf8bCmJs87YYrsk25K8RI10lDIzzQPf9SDjM8L7FQQ==
X-Received: by 2002:a05:6402:2397:b0:5dc:ebf3:b967 with SMTP id
 4fb4d7f45d1cf-5dcebf3be3amr2206612a12.23.1738844037812; 
 Thu, 06 Feb 2025 04:13:57 -0800 (PST)
Received: from corvink-nb.tail0f5ff.ts.net ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7ade9sm772388a12.25.2025.02.06.04.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 04:13:57 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 3/4] vfio/igd: use PCI ID defines to detect IGD gen
Date: Thu,  6 Feb 2025 13:13:39 +0100
Message-ID: <20250206121341.118337-4-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206121341.118337-1-corvin.koehne@gmail.com>
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52f.google.com
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

From: Corvin Köhne <c.koehne@beckhoff.com>

We've recently imported the PCI ID list of knwon Intel GPU devices from
Linux. It allows us to properly match GPUs to their generation without
maintaining an own list of PCI IDs.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 77 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0740a5dd8c..e5d7006ce2 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -18,6 +18,7 @@
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
+#include "standard-headers/drm/intel/pciids.h"
 #include "trace.h"
 
 /*
@@ -51,6 +52,42 @@
  * headless setup is desired, the OpRegion gets in the way of that.
  */
 
+struct igd_device {
+    const uint32_t device_id;
+    const int gen;
+};
+
+#define IGD_DEVICE(_id, _gen) { \
+    .device_id = (_id), \
+    .gen = (_gen), \
+}
+
+static const struct igd_device igd_devices[] = {
+    INTEL_SNB_IDS(IGD_DEVICE, 6),
+    INTEL_IVB_IDS(IGD_DEVICE, 6),
+    INTEL_HSW_IDS(IGD_DEVICE, 7),
+    INTEL_VLV_IDS(IGD_DEVICE, 7),
+    INTEL_BDW_IDS(IGD_DEVICE, 8),
+    INTEL_CHV_IDS(IGD_DEVICE, 8),
+    INTEL_SKL_IDS(IGD_DEVICE, 9),
+    INTEL_BXT_IDS(IGD_DEVICE, 9),
+    INTEL_KBL_IDS(IGD_DEVICE, 9),
+    INTEL_CFL_IDS(IGD_DEVICE, 9),
+    INTEL_CML_IDS(IGD_DEVICE, 9),
+    INTEL_GLK_IDS(IGD_DEVICE, 9),
+    INTEL_ICL_IDS(IGD_DEVICE, 11),
+    INTEL_EHL_IDS(IGD_DEVICE, 11),
+    INTEL_JSL_IDS(IGD_DEVICE, 11),
+    INTEL_TGL_IDS(IGD_DEVICE, 12),
+    INTEL_RKL_IDS(IGD_DEVICE, 12),
+    INTEL_ADLS_IDS(IGD_DEVICE, 12),
+    INTEL_ADLP_IDS(IGD_DEVICE, 12),
+    INTEL_ADLN_IDS(IGD_DEVICE, 12),
+    INTEL_RPLS_IDS(IGD_DEVICE, 12),
+    INTEL_RPLU_IDS(IGD_DEVICE, 12),
+    INTEL_RPLP_IDS(IGD_DEVICE, 12),
+};
+
 /*
  * This presumes the device is already known to be an Intel VGA device, so we
  * take liberties in which device ID bits match which generation.  This should
@@ -60,42 +97,12 @@
  */
 static int igd_gen(VFIOPCIDevice *vdev)
 {
-    /*
-     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
-     * and 0x5a85, match bit 11:1 here
-     * Prefix 0x0a is taken by Haswell, this rule should be matched first.
-     */
-    if ((vdev->device_id & 0xffe) == 0xa84) {
-        return 9;
-    }
+    for (int i = 0; i < ARRAY_SIZE(igd_devices); i++) {
+        if (igd_devices[i].device_id != vdev->device_id) {
+            continue;
+        }
 
-    switch (vdev->device_id & 0xff00) {
-    case 0x0100:    /* SandyBridge, IvyBridge */
-        return 6;
-    case 0x0400:    /* Haswell */
-    case 0x0a00:    /* Haswell */
-    case 0x0c00:    /* Haswell */
-    case 0x0d00:    /* Haswell */
-    case 0x0f00:    /* Valleyview/Bay Trail */
-        return 7;
-    case 0x1600:    /* Broadwell */
-    case 0x2200:    /* Cherryview */
-        return 8;
-    case 0x1900:    /* Skylake */
-    case 0x3100:    /* Gemini Lake */
-    case 0x5900:    /* Kaby Lake */
-    case 0x3e00:    /* Coffee Lake */
-    case 0x9B00:    /* Comet Lake */
-        return 9;
-    case 0x8A00:    /* Ice Lake */
-    case 0x4500:    /* Elkhart Lake */
-    case 0x4E00:    /* Jasper Lake */
-        return 11;
-    case 0x9A00:    /* Tiger Lake */
-    case 0x4C00:    /* Rocket Lake */
-    case 0x4600:    /* Alder Lake */
-    case 0xA700:    /* Raptor Lake */
-        return 12;
+        return igd_devices[i].gen;
     }
 
     /*
-- 
2.48.1


