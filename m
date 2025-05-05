Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C67C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzF5-0005na-TK; Mon, 05 May 2025 13:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzEH-0005MP-7R
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:46 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzEF-0003an-9m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2243803b776so21624365ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464621; x=1747069421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPYpTPwf/6Pu1dRKPkIxTVM3y+lOEO4lxLo9YC7d6k8=;
 b=LN7Vu45qYRheyQ4IgtJPJ/ZYb3OKKcVEi/Pe82vk3cy1ZR1Dhagbi8GjOf5ONOddrO
 r39znfyJ+jS7UgzJqFVJTK3P91MFOgcxWd7A/7P59eZp1oqF5Nrc3tnkTZcEWZDL/jUP
 6el7VsQrBaqIYM/djhvuxUCh72YMbG0LIexXjo8pRMqRC0/RlS8Oh5Mak2af9VYxntNY
 JlOHJMn14+oR50E7KhKY23B7qY9G0nBTHiE6psiU9yLB6syzhoEPlmTZh81JHeBbuMPJ
 0ltrOOKvBHfY5SS90vCcXYTyAwkOP6Md7RGAeDIqb/TFkQvPpP0L4V+g342cp8gQHBlI
 K3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464621; x=1747069421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPYpTPwf/6Pu1dRKPkIxTVM3y+lOEO4lxLo9YC7d6k8=;
 b=cutdzK4/fT+s4HRd9P/2d0lgIWBDzJJetDXZdDM8ljXcd07LoibR876Fnj/0vQUdVo
 MGoBdf++sDxjVbSqNebpc7Ip7l8s+KOD6SbpfT2KtBIg3yf9ERSRg03ArcZQBwFQRfD4
 MUtgmmjHef2z2G7VpWZeYAW3ZWSL9mV1ohsBZYn+IXQhZxzF/2RxrZLXNNdbF6HfikNV
 2l4rtDDG2DCl1WwH0ijea1Cn+FBEoTbE06ydmHowzHIivYm78DaupEadLp1BW4cSJkEa
 c0US/cQFL6En+iGpp4rd4F9eT73oXUnE69QT3gqpaL3BnjeJaieXEK8dM2fpdAaTbp2n
 OMuA==
X-Gm-Message-State: AOJu0Yy/kCSV5ywgjai5M5gjty9E+fHPEiZUArQuB2/EDRFGhiEethrS
 BDNWqzBMAxsEHB8RM09WYEq5WAvNKnQ4qhIBnrb4B6VUDJhyLb4=
X-Gm-Gg: ASbGncvYQC5+xLGdSd1PnHhuG8n1lhZpCy62fUNnYQxydLlfL3AtnNnClohKIHA64IT
 nkQ5lS17afnd6Ur3zTp5ztUQLt58wilLrJGk7cGTb0X6/OnFydPm+pEq5FKiKxA1SHrbYmmh4a9
 6YgSqSAk0rwER4lXf4Pp+olu1CP36GBi6HDWm+EXPwbijVvz4QVrMCCrmoOdFGhZ0JAZdicukHH
 VaNL9jkpcQTKjS60WFQwMlXkmWOvDoO91IIoU6Wm9RNYgUdXhJUICzJXttPEY+lovRmN7qz3Wwp
 9ZcMnMWSZo6lT0kgpnMU2ngQVPfsMEDGUTOv7cC7Lqnn48kW1slnPWsU2mrjitkxOaw=
X-Google-Smtp-Source: AGHT+IGQdxtG5yK/KLN1DR+/D4NN9H1pmd+N7ronuP29RobY/m4/7rvqY4rskN8lxnT8eGvxOPHG1Q==
X-Received: by 2002:a17:903:3b86:b0:224:910:23f0 with SMTP id
 d9443c01a7336-22e18c3de51mr129201815ad.49.1746464620467; 
 Mon, 05 May 2025 10:03:40 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:40 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 7/9] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on
 Gen9+
Date: Tue,  6 May 2025 01:03:03 +0800
Message-ID: <20250505170305.23622-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
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

On Gen9 and later IGD devices, GMS 0xf0 to 0xfe represents 4MB to 60MB
pre-allocated memory size in 4MB increments. Allow users overriding
GMS with these values.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 59 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 9dec32818c..8ad9d723e2 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -412,6 +412,44 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
+{
+    bool ret = false;
+
+    if (gen == -1) {
+        error_report("x-igd-gms is not supported on this device");
+    } else if (gen < 8) {
+        if (gms <= 0x10) {
+            *gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
+            *gmch |= gms << IGD_GMCH_GEN6_GMS_SHIFT;
+            ret = true;
+        } else {
+            error_report(QERR_INVALID_PARAMETER_VALUE, "x-igd-gms", "0~0x10");
+        }
+    } else if (gen == 8) {
+        if (gms <= 0x40) {
+            *gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+            *gmch |= gms << IGD_GMCH_GEN8_GMS_SHIFT;
+            ret = true;
+        } else {
+            error_report(QERR_INVALID_PARAMETER_VALUE, "x-igd-gms", "0~0x40");
+        }
+    } else {
+        /* 0x0  to 0x40: 32MB increments starting at 0MB */
+        /* 0xf0 to 0xfe: 4MB increments starting at 4MB */
+        if ((gms <= 0x40) || (gms >= 0xf0 && gms <= 0xfe)) {
+            *gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+            *gmch |= gms << IGD_GMCH_GEN8_GMS_SHIFT;
+            ret = true;
+        } else {
+            error_report(QERR_INVALID_PARAMETER_VALUE,
+                         "x-igd-gms", "0~0x40 or 0xf0~0xfe");
+        }
+    }
+
+    return ret;
+}
+
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
@@ -594,24 +632,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
      * 32MiB. This option should only be used when the desired size cannot be
      * set from DVMT Pre-Allocated option in host BIOS.
      */
-    if (vdev->igd_gms) {
-        if (gen < 8) {
-            if (vdev->igd_gms <= 0x10) {
-                gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
-                gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
-            } else {
-                error_report(QERR_INVALID_PARAMETER_VALUE,
-                             "x-igd-gms", "0~0x10");
-            }
-        } else {
-            if (vdev->igd_gms <= 0x40) {
-                gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
-                gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
-            } else {
-                error_report(QERR_INVALID_PARAMETER_VALUE,
-                             "x-igd-gms", "0~0x40");
-            }
-        }
+    if (vdev->igd_gms &&
+        !vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
+        return false;
     }
 
     gms_size = igd_stolen_memory_size(gen, gmch);
-- 
2.47.2


