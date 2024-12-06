Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B770E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRD-0005vn-4N; Fri, 06 Dec 2024 07:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRB-0005vE-GH
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:01 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXR9-00040n-NZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:01 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so1519834a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488078; x=1734092878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCFppN4wAZK14wOe4SWzJCCX/Db2Lt6zBXlKLoRhMX4=;
 b=D0G7KueDeKUk3rOb3r+fJjGeP58DVKPAHYCAzgdu1igLA3GF9pgT+pL0y6cxuItQ7c
 LbB1TWhEXmN9BmDuK/sxAOKHm2X7g9CenJz/rqGphYiB1OKXLmL9VbzZBUdxrZo+vFQG
 PCzQ1EJLZ6i8NugTy9hqiGi7kADSvs4DB91sQ6KCtLjLN34mdqPhx4w61jtHZobd24s3
 hh1I38dAh2btonWyCI7sPazFhXNdTg6OfNyZqvmZqGUzhDXxt5js+KtOUlJAWS2ZbB30
 NkegFbZvcGHBG66Ev0aixj6gIXg+aDVYDYDf6ciN16fNsCAy5l4p2D/cWL2uDSLjHM1d
 kRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488078; x=1734092878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCFppN4wAZK14wOe4SWzJCCX/Db2Lt6zBXlKLoRhMX4=;
 b=cIL+cqHDq98w4vIMGADw69YZ0d5W424ABmJdJH7PhkYqS4iA/SfEe5Es6eCL41MHsL
 2YGv+/HaNfw5Ddfr6Y/dDUCff7Eigxw+KAEkC04WcuXga03mmjxswJya4hPttFa+1GV6
 SJsakkHVfP+Ivbq4T340tHQzusXugqrSTRtpZ6ykbCUCCC19+IKwsmo1EFY7j/WWIOZ/
 MoPuJkm3R2dih/U2OTyn5+dxttG3J7WaaFJcqBtEUPNlttM8IR+F9lVok+J4QQ38542j
 5KQ/XSWaCbtySbOfssVW+Kgtn63Dht7B4O9FTopFeATeGYIKOK8//cqVRyq/7YpkNphl
 4VPg==
X-Gm-Message-State: AOJu0YxmoGzkcdkDbKzbzN4Zg3pyzMviKbxWT4468pYyCAjA9vKW5rCS
 P99s1rG6K50kNZuphxpdAcElTJ7ihP46d0676XcUmGP4dT+hjggp8X1ZrU5+6Q==
X-Gm-Gg: ASbGncsN4cp7yO+QFT85er+8wcuiZqYHwkOiFqVbS2vrhWbwWQ1HGYQQZ1JbbP2vtqs
 MgcwGDgJPUbT4tjW82YEb4fnXMngpvqmc1+ZBJ662wBhu+eplQpyUWf+RLsh2BZ5W1D4iLGPDKB
 NBKH7lfOANBfFHb+3HsTK4D9OrKAGswr+cg0x5qAbuIhb3mWHOlLn+SaDB5aWX9BZ0dnGhn0+ZG
 xhV9UAVRsqtFt7JqkHjcA+8Sdo7212DKpr1iifCHk86pFG1+A5LYZ85wQ==
X-Google-Smtp-Source: AGHT+IHTqkestPcILl8ajPIZnHE76q78Vur6R7bcMCSLVLp3vFNrJPb6EWBjRkEAYYnb8hXsKBSAAQ==
X-Received: by 2002:a05:6a20:a104:b0:1e0:ca1c:8581 with SMTP id
 adf61e73a8af0-1e1870c975dmr4673936637.21.1733488078128; 
 Fri, 06 Dec 2024 04:27:58 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:27:57 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 01/10] vfio/igd: fix GTT stolen memory size calculation for
 gen 8+
Date: Fri,  6 Dec 2024 20:27:39 +0800
Message-ID: <20241206122749.9893-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x543.google.com
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

On gen 8 and later devices, the GTT stolen memory size when GGMS equals
0 is 0 (no preallocated memory) rather than 1MB [1].

[1] 3.1.13, 5th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/www/us/en/content-details/330835

Fixes: c4c45e943e51 ("vfio/pci: Intel graphics legacy mode assignment")

Reported-By: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4047f4f071..73ed1ec8e6 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -268,7 +268,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
     ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen > 6 && ggms != 0) {
         ggms = 1 << ggms;
     }
 
@@ -678,7 +678,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* Determine the size of stolen memory needed for GTT */
     ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen > 6 && ggms_mb != 0) {
         ggms_mb = 1 << ggms_mb;
     }
 
-- 
2.45.2


