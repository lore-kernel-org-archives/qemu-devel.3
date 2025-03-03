Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96144C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9zN-00034y-GM; Mon, 03 Mar 2025 12:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9yE-0001cK-6I
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:55 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9yB-0000Ke-Fn
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:49 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2234bec7192so71441215ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024366; x=1741629166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVDCsa3yLXvuTG05pS6r6MokNR6jdPXP7E/1Cp/7QYA=;
 b=ZPbx7AIex2YCF8g2CPkKzpqYMoGIpAIOI5dfl+wSsg2MYBSaLVHIPnZsV9HjqTenIu
 f2cOY87EyI/Ys23I70M1jv49XOcYDZrFRCTwCsAnVaWHa4cGgSEajavneMLcKE0FCSTx
 BhLHrGf8pKoD87SrGoiKfx700vl1UFD/0hxL14/5TZU99w6yjNthnxYH2SGGmXJikRY+
 DEIHP0of/5m2a39bITuGhkg1XK0y9ZxhZK91b4zNWU72myJrdPL64SBf05V7ua11K6dj
 jXpHysYvFSbg6Oz8zmnx/8PL/k40iV7yFIc9aB8nBszgijq4BL5StjecZadc5UQ9A3HM
 P5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024366; x=1741629166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVDCsa3yLXvuTG05pS6r6MokNR6jdPXP7E/1Cp/7QYA=;
 b=KdZWiayMOqmmYpY18WRm3I6cLYS5CXJykb7jb4KxT8L2e3JoQoP3g70Temsbe5R2eX
 kRuIo5h9gaZrJ4Yc5F/VorNre0DaZ1sVDznXTWndJY7glsIjUhnpt9jWMv6dsSxfAQaD
 /a11rAPK5EOE5euVdr5FE5TSCXyJvtuVYPx3O0rNSg8adfLcMQKxe7EiF4APP8cCABZ5
 OGhWXGI4VmSMRhoQP1PHpDSqntizqcK4N8NrEUn3lonF3X6GUfGFjd6I+p0PtvbuWBTB
 +vx3ILxqMDOq0xsvWjyWYnjSrI6QwVd9xMWN2BQIwXkTFi1T9D5w25Tw2LLhAdqGZD5x
 c8vQ==
X-Gm-Message-State: AOJu0YwIGTADQ5Ju7L/hG++PykUKBZvytT1ktX/oi4LRXhdlDbVABnIQ
 7X97Kxlq9CTpOD1hx8Fhd2+O6TbdsKUUGUL2IZEQCn63vjhjdTA=
X-Gm-Gg: ASbGncuJQgw3irbpqXm4BTRcX/GmgJ6y12HgJxI57y5P1jfXQ8JOPv6vPDVrB/l4ITz
 CldqV8/EO7Ypyj69496vgiGcMfELtW+KlQrVO7R+Ms5QmlyPUvWByDfLZc3yNJs3p7+8npsOtcX
 jXIKeJD8bsF+Ta8n8V9YEfhHvRZ2v74IfYt9cG3sKDIlc4pTYbZjcYo7sbIjAFNrRB121w5zX3S
 27/kmgvQUZCb2MtI66OBLAgZ41BHQ8aC05IfiC+at/fLrXJYF1j3awRkyqWAz1d9Gy1nhguLQ5s
 6B2pXPwdmwTLBL2oMMNAFcc0smrV2RJluqJ1Ty3tAfWvIN97yJCKPtNhAg==
X-Google-Smtp-Source: AGHT+IHv4QhhKLMP9Jj0T7VVKihohftTgmUaAYoISXjn9gP0chCyaCrRuLyrzblOtXNcFuwmoN/9Dw==
X-Received: by 2002:a17:902:d511:b0:223:28a8:6101 with SMTP id
 d9443c01a7336-22368fa6da1mr213448025ad.29.1741024366244; 
 Mon, 03 Mar 2025 09:52:46 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:45 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 9/9] vfio/igd: Introduce x-igd-lpc option for LPC bridge ID
 quirk
Date: Tue,  4 Mar 2025 01:52:19 +0800
Message-ID: <20250303175220.74917-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
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
index 9bfaa24c24..d3ebbebe4e 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -557,13 +557,9 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
             return false;
         }
 
-        /* Enable OpRegion quirk */
+        /* Enable OpRegion and LPC brige quirk */
         vdev->features |= VFIO_FEATURE_ENABLE_IGD_OPREGION;
-
-        /* Setup LPC bridge / Host bridge PCI IDs */
-        if (!vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
-            return false;
-        }
+        vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
     }
 
     /* Setup OpRegion access */
@@ -572,6 +568,12 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
+    /* Setup LPC bridge / Host bridge PCI IDs */
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LPC) &&
+        !vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
+        return false;
+     }
+
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8fb415cf45..1e49c4b58b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3354,6 +3354,8 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
     DEFINE_PROP_BIT("x-igd-legacy-mode", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE_BIT, true),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 4bddfb80f8..dd645a5465 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -154,6 +154,9 @@ struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+#define VFIO_FEATURE_ENABLE_IGD_LPC_BIT 3
+#define VFIO_FEATURE_ENABLE_IGD_LPC \
+                                (1 << VFIO_FEATURE_ENABLE_IGD_LPC_BIT)
 #define VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE_BIT 4
 #define VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE_BIT)
-- 
2.47.2


