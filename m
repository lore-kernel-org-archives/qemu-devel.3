Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C77C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzET-0005Qi-Lf; Mon, 05 May 2025 13:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzE6-0005J1-23
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:37 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzE4-0003Yx-4r
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:33 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22e3460ac50so116355ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464609; x=1747069409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIs0+GafT0/4erELdOajfHeeHakN74diZI7Ii2sgJTo=;
 b=GmcJp6TM4iSBPYk5vwcvgMD9DLkL0X+NWBNMviVSIUf6InedScFWIZ7dWJ5Hku+x1S
 nL4vhkTJQO5KjjCo9S9NX0Ruexlq88fsU962WktwoP9ekLYt10N1drG8GPcri6ypZl9E
 lOYH1X4x4x+pU/JdNmS+M10pqgAdN3lQigCJ12GVhwGdr53sMCfBvUsvPu43Xt4pfms2
 aEwS4nZJ5q2hlnD8CKiityjxBlodovH2ODbh98yzt01htwgIazhBAIkvez+ILvWEnXU2
 JNHn/8GQmDEMBysL0r3Lo8gc10EnPUWO11fKsCgjN4/R+0q/+iU8ujZArm4M2w5ylrFE
 4xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464609; x=1747069409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIs0+GafT0/4erELdOajfHeeHakN74diZI7Ii2sgJTo=;
 b=JnEUKnmQdjJ1HkZmMeceKyAi1JNtwaodSO7RYTwnTXs5bMB2mg7eHONHK7hGSmJcc1
 dR03WsJRZaJhOBh8sKCsUFwmnEI6vaQc8nn15nCVp4w4+e+WKbL8m9uJbiM76kYeIBYZ
 XV9wGJ9fVwMjEHtsg6xj9A6feJ89AIDaWElk7vxG+fvhTnv9xFomBLrv36jbamzPmJ7L
 DsSrllF/59CGllXV/1HwBkDuinyRstX1MZnJS8gH/Rpb9akh3l3KKM6d7hI9f1H4XNBC
 OIZ3F4dHC5QX3imQqhaGcurVYUDvByV2rFV9O96RMT+aK2VL+gfRcUVbS8Z1+SGLuIC8
 x/UQ==
X-Gm-Message-State: AOJu0YxMYWCIwz+cgfAMktjmFD1shbNx9AbdcWeYqUjZjnKA5zmGB49m
 MLA7xvprm2i8d53nkFb1JSQxuUunfHjetid90dzZrS68EQIyI/U=
X-Gm-Gg: ASbGncsTq2uguFcvBejt8BTdjD8T+4xkUzkdqc7veuCeHWPwbkLChgaYZGIcNYa37Ud
 OjPIeNbs0bPJmF+1mefvoT4F+b880cPK6y86QwmKupPiccjSwDRgEOPp7li15TYCnENNkjPTw8a
 h9ehEf1X8AG9B9NnqpxQTzZ5f8l5N7aa1eTZp4jgt11HFM1dhM8s6Wce7PBU4hUxDM+RY6hv6Cu
 XU48ZkFcXclaLVR30VBI3H2Emkui18C3AW3rXcVcPLxl5zwB07Hcrl2WPnPKNaIaCRY5CG+jvG+
 9cDG78uhWfQAFIC/qv/brru9KIIA2tapHql5mgOUjBP384L770Mqu96s2drJkljaK28=
X-Google-Smtp-Source: AGHT+IFu72Xbgp2DjpgHTKvClS96PKLwPrGAiG5Jhc5KzHZt/vMfKqHIMCgDgnl63+/oAa8kFpDZbA==
X-Received: by 2002:a17:902:e549:b0:220:df73:b639 with SMTP id
 d9443c01a7336-22e1ea636femr123142445ad.36.1746464609508; 
 Mon, 05 May 2025 10:03:29 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:29 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 4/9] vfio/igd: Check vendor and device ID on GVT-g mdev
Date: Tue,  6 May 2025 01:03:00 +0800
Message-ID: <20250505170305.23622-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
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

Check the vendor and device ID on GVT-g mdev to ensure it is a supported
device [1]. This extra check is required for automatically enabling
OpRegion access later.

Note that Cherryview and Gemini Lake are marked as supported here since
current code cannot distinguish them with other Gen8 and Gen9 devices.
Since mdev cannot be created on these devices, this has no functional
impact.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/intel_gvt.c?h=v6.14#n52

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 347253d08c..f5dd475028 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -672,6 +672,18 @@ error:
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
+    int gen;
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev)) {
+        return true;
+    }
+
+    /* FIXME: Cherryview is Gen8, but don't support GVT-g */
+    gen = igd_gen(vdev);
+    if (gen != 8 && gen != 9) {
+        return true;
+    }
 
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
         (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
-- 
2.47.2


