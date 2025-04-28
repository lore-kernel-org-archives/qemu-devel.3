Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F89C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R60-0004Ha-NZ; Mon, 28 Apr 2025 12:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R4M-0002EF-SN
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:11:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R4E-0008RL-5q
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:54 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-225df540edcso60591745ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856646; x=1746461446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aE8b1UhajUDkj6qd0OYblaMEqfKDSI9mrQFdziqmhQ=;
 b=fTRKidCXePIqlZiARiHuHKUlhVElkxwY2ENoHWf7wMs43Vi7PVyqpvkaCaeSMpGipO
 Lq8I9TACyeK5HGDiy0cFR6QocHZsPwqdZf3maYxtzLMwa6LCudjG7cmduXxXIEtAgszX
 dt5KkaeFBW8rH/Gi60WQm+vB/VhQyDMwaXY2EcNpI4UvY9Qxrzuw0wvfMWPr7N799oIK
 gEKUOCsjpT5b9y2ZE8gsy5+gpBCXpv9FU7bkM6tEg14v2FhR0ExHLGhlO5xIr8CEc5ou
 TWkhXOJcqIWDZAxB7bH1EGOn0ecUqyX3HVsPgi/w4Oj4WPymWEHp2Cx6HQon5VMi5zzY
 itsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856646; x=1746461446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aE8b1UhajUDkj6qd0OYblaMEqfKDSI9mrQFdziqmhQ=;
 b=tqbxNxruUj+yemcUD3jhNpkL7S6L807MLn/0EUa2pDj1zRLlaFTywsTBVJwZx5mFC0
 ve5jj0cOiddy5QqGoQtZnIIXnHADRLatIzZPzF1E6oLwjo3F0vQeqX7Qyz7eYS14gnXK
 j94InNxPtppZh4zG8z3hHcjNctDXB3o5jEkTJv5nRERatDENKC+PDiCtic6j8x3PXdZk
 Rk5H8hH5gOB/d4mn/ipUNgWkZtYBT2Oq14j9UStbt8BJxY+ztFwGw/pWgcWhb7+toe6f
 WWqWwXai9iHEqwsPnpswF2Bn4DQoD5VVnwPXYQLNk30ueMZyo96sPRj7ueaJ0ZrJ5aF8
 481Q==
X-Gm-Message-State: AOJu0YyvGUPvBTz+MR5SHSa/1/AglhWB0f07NbebBwFdKQjbfAtB31j1
 99a6UdSVEvMKwr3YyXKBPi9xHoeU2l4nyBaSVqqF2smbAd7rliA=
X-Gm-Gg: ASbGncu/yfs8CS3NPIfd09C7We7qcWJdzkfjq2hvF9ocXGXUkoHfgTAnzJbVZ8rTWX2
 9dSFr/MNHacMQ5WAs7WjnFcFnraYSHEGzESCgeu+F0xldAL4gbtqaXw0IMDiWhIRZF9FptJdLPE
 4dotHkXQJKo43Ec43T1f4LT5GnWnX9IPBd03Vkhg6WDQwmseP9oI62svUDMYu8LL0UgF6zZ+sdq
 TrfeXqacC6zp8rCm9qbMt0Zq0JMHNXvqyOsUfmo+/wn/OKizbO9co8BufcVK3FoHZwZDbAnGrR2
 7o8sJ6rB8mqHA/Y1ZJqKHvngIwSd7jBKzLZ4xcipWbBbwRQRD4KhP1vb
X-Google-Smtp-Source: AGHT+IF0P4WqVmtv2hEgazmdoJOonBje32hXkn1pw5WMtRPCiXTmlp0XUAXweGDpid1uxs2zR4N8hA==
X-Received: by 2002:a17:903:3bae:b0:215:a2f4:d4ab with SMTP id
 d9443c01a7336-22dbf8ea2ecmr160007625ad.7.1745856646136; 
 Mon, 28 Apr 2025 09:10:46 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:45 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 7/9] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
Date: Tue, 29 Apr 2025 00:10:02 +0800
Message-ID: <20250428161004.35613-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
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

On Gen9 and later IGD devices, GMS 0xf0 to 0xfe represents 4MB to 60MB
pre-allocated memory size in 4MB increments. Allow users overriding
GMS with these values.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 59 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 496d3df598..7f289a62a3 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -411,6 +411,44 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
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
 
@@ -593,24 +631,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
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


