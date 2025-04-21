Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32BDC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u4u-0008Sz-8G; Mon, 21 Apr 2025 12:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4L-00084q-PA
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:30 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4J-0003JM-Q1
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:29 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2255003f4c6so46926455ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253146; x=1745857946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c87Lgiq7jDdcGg3ilCsOHR7tmTWpS2SJIxQ0tltfjbI=;
 b=TW9ckyZb4mWJ3wQyAImUQBSFo+z4d4WvU6kS5Beo+U+q7pP+vXl5AQyuLxm00cL/0X
 mCkBfuo+QNiyaaO6zvBnfvN3Wxr7v/0+U1pkogqvKcD0boii/pXxMaH8exj3Mxu8mRcW
 DffxiWrzB1rDoGjyCCgGkZPFuzejI5wShKiBIYAYvCqLd2boP/RkCBHOSgPpcsNa3j0X
 rUmilEUTAh/7Run1vwylxxiU/k+aBXnI3H5Y42xOU2CZTNjeXFlJOwyHALLqN8Vxz39U
 7SEQ4N+wLOWSAByWR5gKLzFRacfArtTfEtrWG8Pibx2Zz2jD0+C5oMrxyAMtsoUw5ElY
 m1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253146; x=1745857946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c87Lgiq7jDdcGg3ilCsOHR7tmTWpS2SJIxQ0tltfjbI=;
 b=CdYPa+nGycO0JEarkUakJn1V9pGB4c1UdzGKfhljQIoejA57Y9CPrmps7WeNTyASC/
 nKmRs36gwByJMWJhs8SenOTImXqi5Cxm+gC/zhYe8rr7GUKQH5eJJgk85cR2sjZCZWod
 Vmhl5/E8Kj6tjl4qIw+nnk06SmzvAmVSeKc4BitzBsRJ+FXsDB9o8aiMRZRxDsNS+rUH
 dtrZRJvoUzCARea/n9gddtRXb5YkNOLJphCUkjH3nExk53SAJ7iOG0YeblRnPA0USXcZ
 4nFLTm7tbteSntWDwLGZWWuliqg3o0zd1eKEx531raiew+9NtEyIk/+in+5Pn4yNCd6R
 dbIg==
X-Gm-Message-State: AOJu0YxAT4RiQnJdYZp9E8xORWHDEGsps1uBsTQ9PvRJ+Es7p68y1qXm
 klvOlflzVeJjycx+oPhnnZSyfeK3A6bzCmNPVs9x6Jdc0bQgA1Y=
X-Gm-Gg: ASbGncscRDmfunGdTVVgUZAI/vd5UF5mf6KaOeP9Ki1pXuo0sx3xihHlHthL5gv1duK
 JB0T6PN3s86aoQKYlPRIDua/IxKrXR/cmBtKnlyEeEuSPoebwPAl42A1Ld1Cq5CvLPAG/vi3wxG
 aDiUqYA8IoJ3i/tTM3/+meK/iB9C9n+tDIqhkCEsdAFyqGFs8egPam6SAdiTh6t0oqdHk5golxO
 Mxc4XYIca++rwPYKZRF+Q/9ngTzVrUdN/+lzu+sVPTErUum9BGMfhxlvbos28VsLkBQqAoQCUC/
 B1WtWH7F+L9P8N80rRgziH37CQ+rpsO4XpKXeQ0Dtaqtq4az9+dZiQ==
X-Google-Smtp-Source: AGHT+IGDNTMhKam1a4+asxir+yL9Zjw6wLiI7H4Dnu01H3w4NxjS5xwLf+636JfF5mCb5YgbgzRiYQ==
X-Received: by 2002:a17:903:98f:b0:221:7eae:163b with SMTP id
 d9443c01a7336-22c53627298mr176429775ad.46.1745253145730; 
 Mon, 21 Apr 2025 09:32:25 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:25 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 08/11] vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on
 Gen9+
Date: Tue, 22 Apr 2025 00:31:08 +0800
Message-ID: <20250421163112.21316-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
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
index e3ff86d0e6..b747fdfaeb 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -387,6 +387,44 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
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
+        if ((gms <= 0x40)) {
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
 
@@ -573,24 +611,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
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


