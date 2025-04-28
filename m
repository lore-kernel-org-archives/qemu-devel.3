Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E9DC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R5x-0003uM-Du; Mon, 28 Apr 2025 12:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R4F-0002CK-UR
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:55 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R49-0008Qc-VI
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:51 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so53564825ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856642; x=1746461442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fhN0VyLSegOAjwuvnZ1woBdLvhXgEUMO0BwptjYJj8=;
 b=XU/KHaqlTGEKLZHJaRJ501/5Noqg5cuAMqKnL1vw40HInuW5IrIodJOTWtoVVGXcxS
 NoeJADmsGrVw6cScA9SoPY7Y8c3wzyv07aw184+rBFcyGKMfm+wcuNuHzy44YNHSamvK
 ndzoGQZpEwOdnOD+AW9yVvgnXx+DlY9lhJdtMD6GE5FUDSpdkbMdxQR29nsybWDZn9/s
 hInsO+dlmzTtCTgbaEH3VIGfBYUg/0Ald8CMKYITTaDa9Z32729Ir+rbFS6Cg0rfII9g
 4bJ919F2LLo8ck+0dMZKUIYp+4U0wg0Q8Y8j5eDW6PlEBCbYfK3DqlsyQHLf9Y/ygavE
 0uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856642; x=1746461442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fhN0VyLSegOAjwuvnZ1woBdLvhXgEUMO0BwptjYJj8=;
 b=sDRcBrE7sVHxjddxjs+3IzzROH0WhlHuAAN896iUo1deaUWemDQtjnWakPkUqcaJvs
 WXBXDN2lAff2HObLmOleXJpadu2nwtNSnwqJejjJe1vXWJjVVRuwUM4oExTWH1bCWf5w
 sgzs6BDhrr/Yf6kEddfC+AlE2ePJ4emEbYFf/xMei3tjaFoQoN4zsQpE/AZO0EKX4UW1
 zV4myDdEDaMXQ6UlJi31OaU77UxNX1CWxE5zcYaU9f8gbbKxwP2BlkFArLRfe16vYSLf
 fsaFoFyqQEJKxc6O8PQJ+qvBfg0KrkElUH7ZqwZw3GiALMtx20+6z/AS5C6PDYP3S9ud
 DH0Q==
X-Gm-Message-State: AOJu0YyVzNaK7mDALKhOPwXcswKwZ8LHh2A2oVFilFnHUw4PryhAKmu3
 JfcNdNjNZrMddmVcqAqV8t3OP1IL0R9uOtMtOxwqow8RrYObizM=
X-Gm-Gg: ASbGnct3SDAeftycaeYkNAy4tGxp2dzFOVTuQ80w+8fC4siPITPn2E9glci7ZOoJm8Q
 nVlyZ+igiBU+9NbTvt/gk9otrih3q4Zjm1DSKDGgPX60T0TS59MMANJOkE7kZpiF/XpRh0N2m+1
 vzaUd3YNORXhAX+2iYvxCJoLLogVdabGwvTl+aRtT4wasCLti/87ddKM/xoor8vxgzWK3OzGpZI
 clOfIYYB7PX8qf1cLa9PB9XLgYQ4R9FOJB+SDUCSlI+Qn6G4jFsDC1RfGzF3gEadeBr0rFyLcPX
 SbkTJIL42IkvvBtlpUkWlPXmjOoANnIz7i00Y9jBz+LosEmFohO+oYqj
X-Google-Smtp-Source: AGHT+IGOtORRFBZhqBFIVRplUhNCQjH+UBq0vzYsv3blOegcIFMh5wKcWZno+md0N/gEUAfnswBt0Q==
X-Received: by 2002:a17:903:1212:b0:223:325c:89de with SMTP id
 d9443c01a7336-22de5eca45bmr2947185ad.1.1745856641846; 
 Mon, 28 Apr 2025 09:10:41 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:41 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 6/9] vfio/igd: Enable OpRegion by default
Date: Tue, 29 Apr 2025 00:10:01 +0800
Message-ID: <20250428161004.35613-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
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

As the presence of OpRegion is used to detect IGD device now, and
guest driver usually depends on OpRegion to work. Enable OpRegion
on IGD devices by default for out-of-the-box passthrough experience
(except pre-boot display output), especially for libvirt users.

Example of IGD passthrough with libvirt:
<hostdev mode="subsystem" type="pci" managed="yes">
  <source>
    <address domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
  </source>
  <rom file="/path/to/igd/rom"/>
  <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
 </hostdev>

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 docs/igd-assign.txt | 4 ++--
 hw/vfio/pci.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index 95beb76812..fc444503ff 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -102,7 +102,7 @@ digital formats work well.
 
 Options
 =======
-* x-igd-opregion=[on|*off*]
+* x-igd-opregion=[*on*|off]
   Copy host IGD OpRegion and expose it to guest with fw_cfg
 
 * x-igd-lpc=[on|*off*]
@@ -124,7 +124,7 @@ Examples
 
 * Adding IGD with OpRegion and LPC ID hack, but without VGA ranges
   (For UEFI guests)
-  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-opregion=on,x-igd-lpc=on,romfile=efi_oprom.rom
+  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-lpc=on,romfile=efi_oprom.rom
 
 
 Guest firmware
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 05a7a62204..38ff231625 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3361,7 +3361,7 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, true),
     DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
-- 
2.47.2


