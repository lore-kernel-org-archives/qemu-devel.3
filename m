Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9C4C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFY2-0003AU-8a; Thu, 06 Mar 2025 13:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXn-000369-0X
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:02:03 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXi-0000As-Su
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:02:02 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-224171d6826so18100635ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284117; x=1741888917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8M9rnvjJnQ63p7IcHB549w9iy3Ic13BvRR7pu9O0E8=;
 b=EK5fqMjyWCgEKmBTVf3RJkdLdpel7yHGrGorohiLSLmAf8IgWopixGm3PZy36sx0LO
 DwLasSv6QHq0FO4yKCcihgAyJqq2QLnmsbzgIR6uV2uRnYTwzYKEfKYV9H1xkpprgnhE
 X2etTxSzoyJ5aag330QII61Ba2lb7NsvdX3CmvFNsDo6yxzYkoeG3r1rxN6NBLEne8wa
 MtZFOjf3MGHLzS1gApNZCFyDpWHefPb8OvFUvbPv9VgVWGDXppDDaLA+gqH/t2U+9HiH
 LNgLdk47mrxZWeEDDgJYummAz/rQDep6n/h1p1aci1M+BoU1/7l28WknJfdzGPqfnpOT
 eOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284117; x=1741888917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8M9rnvjJnQ63p7IcHB549w9iy3Ic13BvRR7pu9O0E8=;
 b=Kzwu7tpSulsvFdfHwaFeTeKebgzBA9D0HFFyII3mTJdmJFI90UvZCLgWJdLs7laWoM
 UNy/ME3mSzfKo8CvM6qjAYiRFL3uDtNGiYhwYIA2T0FtQ2zXNvjf3b9GakRk8b1bs54Q
 EDvL+kZT1dVBJk8qdGGwKKstZ1DYH7XXD7AgRkaR3xiJj38C660stlxtuixUZxnfXIZS
 HRchiOwWv6ozJq5IsKXCAEFqL7xSF+eWrBbYrpioAzDxYslRHHCUPpOQ08ILoVeoF1zH
 zAXzcI1odrLxkmz4w1w+YpZr0Bn4m2RYsJTxNae5mWGozaGsPR4deOr2pqIEKm7P6O3w
 Oaqw==
X-Gm-Message-State: AOJu0Yy9sVI9cW8qDq7HlWC0K7rLDea6BXVp3pIVUIIcnyMhJC4d0a78
 RxbC/Ses8t16T653subwQ7GN7RJFrUX5KCB45l13EXQtbq9bZBk=
X-Gm-Gg: ASbGncuRPQEfFthdpbmVNCtbZRfGDpw2WlO3SnrsXzLulkzkzS9ZU0Q21EM6oOk9uCX
 +YhCjOZXxK0u6RiOOAsLZ/JuJNIUZJS+4lRgQaVAc2wy0B6IKVRvJogZMwjjKgKbpEDocdy08KH
 DMD8xzPceDIHV00I/mYs9ceWCGQdkuxPoneWkmPgim/6kWICQ0nDGgZ7sih0iPXTJAOM+MucyHg
 DX3x40Zrhs+MpV/yUKUubuBcza1+1R8DJkE29vob9PTbiC4vyNQtYn1VKrsVHYWQ/RzZDOhfCT+
 bns8R2Z4eBGQwIW+dNQUAseAWN1hC33FIHwcU7jc+NAAMBNaOcP5ubKddg==
X-Google-Smtp-Source: AGHT+IHIDHEzv65ld05hZ0sLqC+sutNGyUBEHk3QWa4OJK8rzqKl3agUH7dUa2yHvPjNUu15zeyaig==
X-Received: by 2002:a17:902:ccca:b0:223:fabd:4f76 with SMTP id
 d9443c01a7336-224289946c6mr2838485ad.30.1741284117189; 
 Thu, 06 Mar 2025 10:01:57 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:56 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 09/10] vfio/igd: Introduce x-igd-lpc option for LPC bridge
 ID quirk
Date: Fri,  7 Mar 2025 02:01:29 +0800
Message-ID: <20250306180131.32970-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
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

The LPC bridge/Host bridge IDs quirk is also not dependent on legacy
mode. Recent Windows driver no longer depends on these IDs, as well as
Linux i915 driver, while UEFI GOP seems still needs them. Make it an
option to allow users enabling and disabling it as needed.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 14 ++++++++------
 hw/vfio/pci.c |  2 ++
 hw/vfio/pci.h |  3 +++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4c3862b61e..6775ce2eac 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -560,13 +560,9 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
             goto error;
         }
 
-        /* Enable OpRegion quirk */
+        /* Enable OpRegion and LPC brige quirk */
         vdev->features |= VFIO_FEATURE_ENABLE_IGD_OPREGION;
-
-        /* Setup LPC bridge / Host bridge PCI IDs */
-        if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
-            goto error;
-        }
+        vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
     } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
         error_setg(&err,
                    "Machine is not i440fx or assigned BDF is not 00:02.0");
@@ -579,6 +575,12 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         goto error;
     }
 
+    /* Setup LPC bridge / Host bridge PCI IDs */
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LPC) &&
+        !vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
+        goto error;
+     }
+
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c9a484fa68..d16cc5cc90 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3354,6 +3354,8 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
                             igd_legacy_mode, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 0d0a18136a..a87333f3d5 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -154,6 +154,9 @@ struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+#define VFIO_FEATURE_ENABLE_IGD_LPC_BIT 3
+#define VFIO_FEATURE_ENABLE_IGD_LPC \
+                                (1 << VFIO_FEATURE_ENABLE_IGD_LPC_BIT)
     OnOffAuto display;
     uint32_t display_xres;
     uint32_t display_yres;
-- 
2.47.2


