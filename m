Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF07C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdGu-0001gs-8Z; Mon, 24 Feb 2025 13:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDL-0005lL-W3
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:01 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDE-0003N5-Vx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:59 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-220c8f38febso101231905ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421789; x=1741026589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Xs0oZUmiKgigK0ttBSqwyz2fzSA+xd8KRytqyUvu9g=;
 b=DOBR0VVQZMJZ0yshDgf0X/u4uLQyICx50l5UKbDIx2DIxzuk5E0LXf/pDx87b746Po
 5Lo7p5VxJdV5Kqp2oa/pJKAz6mouXwfS1wY7Px7XOzzWOjY4OoIRlJuCrLK/RywuCHmy
 dDnvG+kjOsElubI+ZGJaAP8Bboau8TrrJsNIQNlFJAw9x7IFxj0Jlev2Gn9w1UCfKl3C
 eyt1MQsKB1NX5veKyRV0ZXDxztv7P/AEdwYMJoyD/S50AlrrrRSpzJiNXQBd7FwPh4kX
 cq2wATF9KOwBrERnl6rPa5JlCkqXl3agUqYBpamdzpgtdtPOyg2jJxSCRgBHQoXNnv+Y
 meZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421789; x=1741026589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Xs0oZUmiKgigK0ttBSqwyz2fzSA+xd8KRytqyUvu9g=;
 b=vj41GPOR+tfZe0jXOwMTwvdcClHI0MjMS7M/jlZamZZSw5FLibn97g9U0WfJITOS0R
 VG2oLTxrtRSWz+8xOBAlK989NJuqUHtcY7m8S6MKMm4klzjNmDK09X2DWmsWBK3Jw6G0
 yQY5ykVttz+fR6U02PRIyc1eb50e0AT7cAWxJrS5EPVnZEBikndEkDBUuT8UCXKH0LKP
 x3NJil49ft6XuAQ3LkS8d5b5PF58iDWX6ZzjsaHDvaJWDbe9RWOKS8nMnKNdaX4scqAl
 NPbd7KwtUOgBqMS6XfXWn0Yx7rWfs5XnCzuI1nkyHjvddO5DE+0GmMsPSpjQnsh+kTZP
 DC+A==
X-Gm-Message-State: AOJu0Yxnjda6KXuxey0SNYVC3AlnsSsJPts/xafkdlMcQh4N2yE7G0vn
 FUcYN9LlQ6cZF4czCL1awWLCa5ihHh6VGyE60bhFQZqJO/O2wGo=
X-Gm-Gg: ASbGncv1O/NPSHvPMFiHTlJb7wCNik4KEgvy50c2dHogqlALsZDW2THx9WN1YnCpw3e
 LhEbsHuXGD7aNWxVVBmGCCGPLM48NW4X/Ft3OSyS3PmpUV5qrOfso7EtgoeMiZw48IOocNSTHXj
 pujwGsiX82FfY4QCcukQXWQKA7wZSHHMOmNNvn7bRJYHM6bLONqd1fY9KErFzq0ds2xFj5NZsrQ
 0XH8QjK6a+ugcBe0tTAHyXk8tvBL8hE9gx4BLhgTjLlt9BXWGfksQgQ/sOB2VtPSIuq79hjMsA0
 CTgRlBArS7y3fseUWSJrm0V73qjsROO0Khi2g5w=
X-Google-Smtp-Source: AGHT+IFkQgbH3w0XNQSLSs0IZW30wkVNYiXZJc1thKc1gtNS9q8KDQbESAPj8nsUriDgOXBqHnXKjw==
X-Received: by 2002:a17:903:41c8:b0:215:ac55:fd72 with SMTP id
 d9443c01a7336-221a001576cmr214460635ad.37.1740421789005; 
 Mon, 24 Feb 2025 10:29:49 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:48 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 05/10] vfio/pci: Make vfio_populate_vga static
Date: Tue, 25 Feb 2025 02:29:22 +0800
Message-ID: <20250224182927.31519-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
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

vfio_populate_vga is no longer called in igd.c. Make it static.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci.c | 2 +-
 hw/vfio/pci.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 89d900e9cf..1c45e3987e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2662,7 +2662,7 @@ static VFIODeviceOps vfio_pci_ops = {
     .vfio_load_config = vfio_pci_load_config,
 };
 
-bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     g_autofree struct vfio_region_info *reg_info = NULL;
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c166680a..75505af6a3 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -226,8 +226,6 @@ bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
 
-bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
-
 bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                 struct vfio_region_info *info,
                                 Error **errp);
-- 
2.47.2


