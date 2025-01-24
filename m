Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76A6C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbP77-0006jU-Jx; Fri, 24 Jan 2025 14:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP75-0006ia-G2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:07 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP73-0007pH-QB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:07 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-21661be2c2dso43900675ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737745984; x=1738350784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpBzjRP7lcZnfFl2TlBZJg+t978qeJXz0xSVkKJdZmw=;
 b=HEfL3R8LAE6CS1BL56yr8xDUOAXf4o+f2JitDfHkZ5ih9XeVlMLKFNVx4EXgL1ZDyE
 ZyLpnvwyN7XkQ4jfkSLCfNScrXfAvidAAOET3v3qU5e0UF0Z28xOUALFTfUAIJpmRjni
 rKoVNSgi8wpdTr6//K3EkLp1Oz8BKeGUa3vpTwPUtNCtO82yHoZncAC1jjKy+TwSKWev
 6yMBmIPjXomLmr6ZBJPbh9+Epf4Ch6ny2WE3G89Q4h75W91vPLv0O0SlgD6qDmM314RJ
 rJkqH2BEzVTGbgia7rrAcVsqAV9rjU3NZ223oC/7dhzpla3PLCOcs7LqK3yrC7YeFV3r
 Eoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745984; x=1738350784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpBzjRP7lcZnfFl2TlBZJg+t978qeJXz0xSVkKJdZmw=;
 b=NDAgKbah1tXh5w4ZxhoLtY3R/vWbgGv9Jc2U3srj3H/bYGc5Arm+s8mHVlUcEEsBSu
 ZMxrrYz9byOycIj68giyBtLiOqC3+amdeWPJEJATokehUL9O+mEgKei+To/m9mdohJ0o
 gvtrCeWz+1V7Sya+YT4kGGz73fPyftWTlGPvESny5jsG+V+Lfj46xhPSCFYH33IS6lh6
 kxWvj/5j3fJOgJsgBl6HBnt/9bvon5nkBgEAmHEQeOLsXpPUzKFSWsGHej5BTRxFEKmM
 1BjMensjUyQdLLTHRhCqwOhXergQwDnmXDPiwJi9OpqneUJb/48AZZsrUhCgfnHznlFa
 ukTg==
X-Gm-Message-State: AOJu0Yz35SryPVbl+hDqJjIRUAe9HsZisPuN5tJqERxBU2veUE1F5w6F
 wmtOOpSD0cYEMGBWKC8frQMELmZ3TWeQqTrRVg0MrjW19SDiR0w=
X-Gm-Gg: ASbGncshCo8+K9cbWQLO/aVnf/ysGZfT7Q0zD8blFduZWaK7Vr5DXRRHb5WyPI/pgsn
 N9+TrmGWhKyDhWsNpqy/rwc3Bi0YX3nyrwYQafoI35VBWXihWLq6WrWYwaZyo9msqVRRpPvM33E
 3ST1fVh0h4ClbiEGVj4rpH3BI8lWGyCK4omnLNUYtvf+ZY4gAqH9P8yoTnXWD0dbU3OqvZPDeVp
 C8c+bQj6os3rqExGYilMPUIK+PABorCS0PXzLyxQTnimmWlHpqBlGUlNRtfB2DY5kZ2rO9R4zyX
 VOjeRhpfAoBY7s38eA==
X-Google-Smtp-Source: AGHT+IH9tCPG4/AODJdqi55ni/jqXRdVVJgh/9jddTcXmaB1iqj+nXihcTUshRATrhyLWNcDRr57tA==
X-Received: by 2002:a05:6a21:9986:b0:1dc:7907:6d67 with SMTP id
 adf61e73a8af0-1eb215f52b2mr57746580637.40.1737745983747; 
 Fri, 24 Jan 2025 11:13:03 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69eb75sm2318406b3a.12.2025.01.24.11.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:13:03 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 2/5] vfio/pci: add placeholder for device-specific config
 space quirks
Date: Sat, 25 Jan 2025 03:12:42 +0800
Message-ID: <20250124191245.12464-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250124191245.12464-1-tomitamoeko@gmail.com>
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some devices, such as IGD, require device-specific quirks to be applied
to their pci config spaces. Currently, these quirks are either part of
BAR quirk, or being a part of vfio_realize(). Add a placeholder for pci
config quirks for moving the quirks to one place later.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 5 +++++
 hw/vfio/pci.c        | 4 ++++
 hw/vfio/pci.h        | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index fbe43b0a79..c40e3ca88f 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1167,6 +1167,11 @@ bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 /*
  * Common quirk probe entry points.
  */
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    return true;
+}
+
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev)
 {
     vfio_vga_probe_ati_3c3_quirk(vdev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab17a98ee5..e624ae56c4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3124,6 +3124,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_unset_idev;
     }
 
+    if (!vfio_config_quirk_setup(vdev, errp)) {
+        goto out_unset_idev;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c166680a..5359e94f18 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -205,6 +205,7 @@ uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_exit(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_finalize(VFIOPCIDevice *vdev);
-- 
2.45.2


