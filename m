Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D74EC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7ze-0003ZN-Bc; Tue, 25 Mar 2025 13:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tx7zL-0003V5-NH
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 13:23:02 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tx7zI-00005a-NH
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 13:22:55 -0400
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso8188394a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742923370; x=1743528170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wjRZjoUllmqSg+EfYpaDTJAMQbZL+d+HVA4PveMvE6s=;
 b=mXYK0vU/4WwralgyoC97+Bpe4yQEgRBODVUvsP4nf/zp+IC2AtsPI/MblU3J9HG1F8
 v4CNOLlWAVuu6TgscCctXx5EfQxYbwEtDjVmR6hWaUQ30/eVHUfjDCXNfawMX+X6XojN
 F4wrnvD19I6N0l7Xb+d2ChMTF1IgcCgdMKAlsafGFEs3AW1+9+pW4fkjNM3EmIGTdZJK
 y0OVEluoUOpYI3ygn3kLGWCPzvy5/ZeeRvm4jA4EDIuhMz3ECHRnN9VAynIxpMQHwnDN
 xQqudlBxh8MmeWko0j4xma/uQK3dRuxAj/n82piLiiSjpvFz6mMEXynmlb8mDmLxtQe8
 Chvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742923370; x=1743528170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wjRZjoUllmqSg+EfYpaDTJAMQbZL+d+HVA4PveMvE6s=;
 b=QBpuQQU0hlvdZpp5hnlKnCqcJyQP4bCKEfwX6+jbh+02WWNXBlAZs84e727uaySMKc
 YAYBS0z1kQXA2jBMCJEz5xOxUfkwSjmKfaXXqmuqaYizvmRhl0W+zbpUT7nLgD871Ghk
 j8YlGz9DPXkpz9/JcenSVF/zX2oHsoUQGz5Eg463446L5oVtT1M2cMlsL0aTGkqKtqE8
 kH4U3ihRZfdX9SJIDR/gZNbAI0NgI4WWQs9pEuqXBJb3ilf4t6brPjzCK4hG6wIa+Wa3
 iq8oS8vyXiRiacHsaUuAPLcQ7AyDD42ls7a7B6IcAflv68jRKErh6ctj6BwQv8ctA1oA
 HGLQ==
X-Gm-Message-State: AOJu0YzCiMXOUgSHK5WKwkPGhITnHVzcCSZeiCcxxGQk7bmBPM6XMrSz
 RacyAivZrAHPgJmCD/j1dE08t0nvKVfoIXQBxQbyoYF54xWnsd9AHBMv7gw=
X-Gm-Gg: ASbGncv8ZEOGQUSAZehjKMnGOSbHfnlxaG/dTbBYfi0v0wkWHe1TmXmZPWh6jSg1ok2
 U0a48yIX/cqu5dtY74edVA9nXJLFmB8ZVWjV3hdQfKdAmChqz6Fzx+XBfiyKHCt66gUwN+Azme8
 5hsJOZr6Qasxv5Tqv0/w15mcpWFqEOEjkNyA3AgHGFx+nfszRxNwIQ0icnFwSaesvJUx75bAj0v
 QKtwJ5n58J8KXdszPw4dhoaX97h6T1yw2EG3c66TzbtXbKo2nUXNgjVP/H6tG9MeuNlHBioi9x9
 WS6HhM2x7jArwU6LuW8Yr27AnxV870bTLT4sPGf+XYp0pReum0vdSriExNDR
X-Google-Smtp-Source: AGHT+IHPOBfIPDOPwOkH5k1lHT/VfshmB9448Zlc/5usgVFgpBbY97SN0o3vGQvlMTri9+KZNdpEQw==
X-Received: by 2002:a17:90b:48c2:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-3030fe83954mr36375338a91.12.1742923369501; 
 Tue, 25 Mar 2025 10:22:49 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.126])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f39802sm92986365ad.17.2025.03.25.10.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 10:22:48 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] vfio/igd: Check host PCI address when probing
Date: Wed, 26 Mar 2025 01:22:39 +0800
Message-ID: <20250325172239.27926-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1041.google.com
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

So far, all Intel VGA adapters, including discrete GPUs like A770 and
B580, were treated as IGD devices. While this had no functional impact,
a error about "unsupported IGD device" will be printed when passthrough
Intel discrete GPUs.

Since IGD devices must be at "0000:00:02.0", let's check the host PCI
address when probing.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 265fffc2aa..ff250017b0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -53,6 +53,13 @@
  * headless setup is desired, the OpRegion gets in the way of that.
  */
 
+static bool vfio_is_igd(VFIOPCIDevice *vdev)
+{
+    return vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) &&
+           vfio_is_vga(vdev) &&
+           vfio_pci_host_match(&vdev->host, "0000:00:02.0");
+}
+
 /*
  * This presumes the device is already known to be an Intel VGA device, so we
  * take liberties in which device ID bits match which generation.  This should
@@ -427,13 +434,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode. Some driver have dependencies on the PCI
-     * bus address.
-     */
-    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 0) {
+    if (nr != 0 || !vfio_is_igd(vdev)) {
         return;
     }
 
@@ -490,13 +491,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     bool legacy_mode_enabled = false;
     Error *err = NULL;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode.  The vBIOS has dependencies on the
-     * PCI bus address.
-     */
-    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev)) {
+    if (!vfio_is_igd(vdev)) {
         return true;
     }
 
-- 
2.47.2


