Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F70EC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFXo-00037H-2t; Thu, 06 Mar 2025 13:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXj-00034p-46
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:02:00 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXb-00008G-02
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:58 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-223959039f4so20660005ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284109; x=1741888909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PsFwF/uA/8VpOdWLdhwbP0WWGdT9opuyryY51WuBZk=;
 b=hK+ZbyUjkRa9YMQT7E4cd/Bbl24FSS3asy3+KC98MxwFfzdshRsg1d6GrAw5rGo5Ej
 EQXcB+I1im3UMLvd3DiVbadQHXyMv6vSKuezrRQJwdF7+ecZImBtC2oKqptf63m5FHam
 sgmfLtDBogSp6xl7E7dfFJwhU3wbFYXalHfdJ6C2ukew0AXI1plCo/ycVQRLGnzie84P
 kS+yKDT0tviZtbQ/vswEAn2v2TsvgQi9e3DwXuudVWeR5Q08wqFXDDovAkV6JZqabc6u
 BkeMgapW64fMoyyWdxxQh117h93SUowD8ZAkjh30wSEkIeNOkqldqkhMzyp9e+9ilE1N
 Gasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284109; x=1741888909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PsFwF/uA/8VpOdWLdhwbP0WWGdT9opuyryY51WuBZk=;
 b=UH++oawC9HkoYkts2VZiCSyD4LXq44F4bAP0tYcr+f5zD70fDQ/zv+2wkgcb2/X5/B
 oo3n379F22o38FQzYNKCWb1h0wb4VtIDY6jyz2gDMk/gO7E2bIX1vOfDyEX84EVMNveM
 h+COhzaJbQYT05qSYgwuEDp7T2PD6p8YZpDZ8mnwGj/a1KSuIgSfqs3ce8rTkNkEBAvY
 VbVGsgo6j8TfAzncUOzz47GRwDgdGw/Ux/yp4j5yXK1ZMMTin5wmFg/ihOMjwqQnE0Iu
 BZtSCV9yKQi0jrYjFz5fCcg8yTLmKBa+fW+FzwzcdB65Qu+XJRG7FbXs60G2YdtUmoBt
 Dtzg==
X-Gm-Message-State: AOJu0YypM/LjgnyfS+tog21kyCoHvw17v2BAwAs2Oh343XYvbcs/J11k
 w10NBolv3197ZQgF4x1e/wTmM5kLvORox3UdczhZ7xaUC+Ds+JMKcm6JZ1TAGg==
X-Gm-Gg: ASbGncsK7eWE62z6N+Vi9lLY0EGU6+ByHAeHd/h8jFQWTJQEPNmuY4JZ0Q01k/JqiSF
 HzmMqCU9vND8xzKsXi0cW3qErtP6TGjizC2J/zrHj1MsPUFfzu6bCP1MJuo/NexNMtt6ZWSjU8k
 qqlt6Xh6dbi9WNQ6kgGpqmk6tH33WGscPJKKMlAlofWRn/XF1IErfToox5FZQpQv/PgMo9t8UgC
 VA1Gbmddn+Rosg6fviaf0g/KhfNOtMF8ORwWoctVimxgjCWKpBZtV7oKFHujSEwwP2c8V5PbaV4
 TRhoDGwWAT6RH2hoLon/saiLaDoLOdDkmsSGI6vDiW/gFxBi4Dm8+/5eTw==
X-Google-Smtp-Source: AGHT+IEfDcc69/rQZ37g+UchCe2/B2HUPfGLw8hKwKNG8GOK0WX64d5JlT8EUw3LPpouNtdkCCParw==
X-Received: by 2002:a05:6a21:7a43:b0:1f3:45f4:9ba0 with SMTP id
 adf61e73a8af0-1f544b1a99fmr853603637.25.1741284108739; 
 Thu, 06 Mar 2025 10:01:48 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:48 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 05/10] vfio/pci: Add placeholder for device-specific config
 space quirks
Date: Fri,  7 Mar 2025 02:01:25 +0800
Message-ID: <20250306180131.32970-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
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

IGD devices require device-specific quirk to be applied to their PCI
config space. Currently, it is put in the BAR4 quirk that does nothing
to BAR4 itself. Add a placeholder for PCI config space quirks to hold
that quirk later.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 5 +++++
 hw/vfio/pci.c        | 4 ++++
 hw/vfio/pci.h        | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index cac0aa1910..8a81c60400 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1117,6 +1117,11 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
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
index 098d17b866..a58d555934 100644
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
index 4763f14415..d54e43764b 100644
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
2.47.2


