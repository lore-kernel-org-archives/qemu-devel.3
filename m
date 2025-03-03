Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1A7C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9zJ-0002cS-NX; Mon, 03 Mar 2025 12:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y5-0001Yf-Ns
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:45 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y3-0000JK-BN
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:40 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so90497395ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024357; x=1741629157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PsFwF/uA/8VpOdWLdhwbP0WWGdT9opuyryY51WuBZk=;
 b=GaoYSHl8YH5sx3hldunstBhn1c9LcWwRwo+muuhujMQ3X5pWSAZ/y/sc/gdTvosOzr
 Q+GQN+ja2IlVxxp345TnMK0VwNlgABLUl1fTrJhf0taywyy3iueC3zJ+wOId+pMMaAcD
 V38IhoTl6t8WYV/JcykvuU1WA8qSOs+qClBi8LPb0jCDCoe6mK1wq8jJLRC9WWn32B7k
 XMKs/fnc4bRg5a3D/7pFtHUIy9tEEljKhzXG0wW59KnT8J+sFAd3ICfrX+vjCus1ITeK
 +8bIHFV68jxCxpCbUcQvo24MFpgx+NFT5KDCkl6OTnc492r1HlTFVcPfIxoKI9AnPlqE
 YBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024357; x=1741629157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PsFwF/uA/8VpOdWLdhwbP0WWGdT9opuyryY51WuBZk=;
 b=qm37mDV3r7nqwRDYKXroAjcC1tOqjh+JIPxmleVJhvgpukNGh9BNAKK5t1EHrVqhe4
 KeaKiW54oHP1vSWa1OWiyAwHOseI5FHAWYAE04tEQZ6Kh9YLcKdVLOaV+WFVyZPl+wmM
 /cWs+pLHQVaaRqKwzJHKt6VcmhvBU46oGGkgrAURF/Bt6hHemBlPbQhp9E2yRUi/iMGI
 Ifx2P9CdJgn/uWW7kuNI0vRRp7TokbHHbiVzfOWb0nm8yCuY4UV1GsiyZ2KHvwkaBjaf
 3fde47ioxwUSbMSBaNCk9QKhuLTp3p4raHInw+GwNmRzNJlA97ZrHOtFODIQism8/ya2
 IG1g==
X-Gm-Message-State: AOJu0YzLah26+pa2dUL7B2LjapKqnLywTBZtg9ChQ7PhuEqai3+0OfAL
 CNtLiEKLyx+NejRS/3nLpkg7D+vrOkRvfBSs+k9YuTM7pCrrA/Rp9GY73sbpwA==
X-Gm-Gg: ASbGncv79TP9ydnzhbd35PoUMb3Zer7vor/uAJQ5d9hF82voBNatEh/8wj3QZLg+SAN
 5XPy4m2E4S9UExjBjvaiioX1r9NcFq9f+0VlqylJDkIel0LjzKD9gFQ54sbvk4lMHz0U+mKplCf
 XBclxNR1CZSulFQMVPK9OYsmBDFsQnIKj9NY+RoIu/fpv/f3N+pr8f0J6mc+Mz4P0OIQ4sZgkrU
 oJX++95YzVmuHseyxayOEHlV1/PQ5hY06C96sm234FYFT8k79HdPjHUM6EFzfsaVxdBlPdZv7Wo
 VqJ0/RDVh8azQdrpQqR0vjn1q0UhaCoXH2c2T2eLS8gI9n4HfbnhhQLZaQ==
X-Google-Smtp-Source: AGHT+IGQsYfDOHGKlxTZnE/Hu7buARQmXlAycvBJpyzVTV3/Ece5PYqf/vXkHjkwPwCway89BHv1vg==
X-Received: by 2002:a17:902:e80e:b0:223:5645:8e26 with SMTP id
 d9443c01a7336-22368f9590amr202838125ad.20.1741024357545; 
 Mon, 03 Mar 2025 09:52:37 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:36 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 5/9] vfio/pci: Add placeholder for device-specific config
 space quirks
Date: Tue,  4 Mar 2025 01:52:15 +0800
Message-ID: <20250303175220.74917-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
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


