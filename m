Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8C4E77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9X2-0006Np-Dr; Thu, 05 Dec 2024 05:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wy-0006Fi-9H
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:24 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Ww-0003fR-Ki
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:24 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7258cf297d4so739433b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396177; x=1734000977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMVtNuBqtIXXm2C24hwxrJtPRQT47P73SaeeHd2lWK4=;
 b=faMLOlNFe0C6rRNRxTFR3FC4p5fBNFq+EPRJcwpoTEChQsxAqeaQa16ahXG6z1BZtL
 e8t2oCXsfMwPkM5ccP/fOk0sNyvhvRqHjsjEo279xJpfv7PFl5RN8BBk0JEEMPEsU0Oi
 gARwZPOtX1KZE6/CfxHLwOHF3W4aZ0VUKyE+B1SN0vHbWbgTwIklSmM0/Zq7AS6Fstkd
 ImFTNsKQDawrPHBXqS84CUdCY/5QXL5PutjXK8ED4Nz4Sq0kWAp9MoG+2kKVGfgblQr6
 P7OJS8Vx0oBWXCbhBxavX0sy9N9p78wuXQgBie0VwpGqXYEiNigIZj2F9OuiEL63prN3
 8ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396177; x=1734000977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMVtNuBqtIXXm2C24hwxrJtPRQT47P73SaeeHd2lWK4=;
 b=rNmQBI0belaEVijB3mq1j4R5KGqGiZml1BSKv+PDatGl5111fhURKqr7m7TTElpceP
 KS2RH/Ko32rJfyLZnRptQqBkOqLWghqB5neMaMKFvAp8Td4VSdM4jWYxojtOZJ8bVN6G
 x49KT2e3B23WixAeS2EVeSqGiDId/LlvqxPJcZClznmp+Cu4hYFY7MyWTSbZuVmv1ph2
 VjBoJk1UEa0eAc08HPcZobMvUFW3bMW9ZzJWM8MPFBF5Tx7CBzZjDYUuvdhYPEtjoFf8
 uNWw6Phv5EgTSVK5ENU/rEDLNTT1ShZKyi5/nDUV46qmP/+uIcfm2L2JZMfvQdShcMDu
 yiSw==
X-Gm-Message-State: AOJu0Yzn2BWU9rHdVb0200pzlHrCtDZ3n65v3cZmV7nLzCdy92UbFcz8
 EFWao+LRkpgVRuw9l135bAAem3+2KPTpQDIkGk5RlokNZd+OKYc/Cg4GEd+Mbw==
X-Gm-Gg: ASbGncvzNxHnnYkUTWv+SEJkbaIRtno32zVKt2k5XcKXe76+FQdIiW/5AjkeiTjeWYT
 5/6An4qNntsx6n9l0+FJtlBqEMkWIQzHSkMJirzAKHD/Px0S/+tI4cbLCCAemft8N2WpWO5BN2M
 1EcGFOw2byvJEhaFWL8kY2Zh6Q9BNwM0ieYU7hNzz2qxO7JwISQrY2AxmSQBqK5JNvW2fBGh4xM
 3Tkrx2jDwnCOfESTPstm1OsC0zF74YBj4dtrxb9fq7O67y2q1n9VIKD8A==
X-Google-Smtp-Source: AGHT+IHuIdpgw/LuC72t6bmxi6VEw3WoD084zBzgUlsYBXDyKYexlvZXexLMVRNNov4+TTxrK/SE+A==
X-Received: by 2002:a05:6a00:1d1c:b0:724:dba1:61ef with SMTP id
 d2e1a72fcca58-7257fcca10cmr14326435b3a.24.1733396177131; 
 Thu, 05 Dec 2024 02:56:17 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:56:16 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 10/10] vfio/igd: add x-igd-gms option back to set DSM
 region size for guest
Date: Thu,  5 Dec 2024 18:55:35 +0800
Message-ID: <20241205105535.30498-11-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
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

DSM region is likely to store framebuffer in Windows, a small DSM
region may cause display issues (e.g. half of the screen is black).
Since 971ca22f041b ("vfio/igd: don't set stolen memory size to zero"),
the x-igd-gms option was functionally removed, QEMU uses host's
original value, which is determined by DVMT Pre-Allocated option in
Intel FSP of host bios.

However, some vendors do not expose this config item to users. In
such cases, x-igd-gms option can be used to manually set the data
stolen memory size for guest. So this commit brings this option back,
keeping its old behavior. When it is not specified, QEMU uses host's
value.

When DVMT Pre-Allocated option is available in host BIOS, user should
set DSM region size there instead of using x-igd-gms option.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 73c06bbf64..b0fef90240 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -14,6 +14,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
@@ -722,6 +723,31 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
+    /*
+     * Allow user to override dsm size using x-igd-gms option, in multiples of
+     * 32MiB. This option should only be used when the desired size cannot be
+     * set from DVMT Pre-Allocated option in host BIOS.
+     */
+    if (vdev->igd_gms) {
+        if (gen < 8) {
+            if (vdev->igd_gms <= 0x10) {
+                gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
+                gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
+            } else {
+                error_report(QERR_INVALID_PARAMETER_VALUE,
+                             "x-igd-gms", "0~0x10");
+            }
+        } else {
+            if (vdev->igd_gms <= 0x40) {
+                gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+                gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
+            } else {
+                error_report(QERR_INVALID_PARAMETER_VALUE,
+                             "x-igd-gms", "0~0x40");
+            }
+        }
+    }
+
     ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
-- 
2.45.2


