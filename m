Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCFBC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzFF-00064W-FS; Mon, 05 May 2025 13:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzED-0005LE-L1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:44 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzEA-0003a2-4P
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-af59c920d32so3098075a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464616; x=1747069416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moTw5sctyBvVei1kdCd7jbcGztmT6jMi/oWts+VNX2E=;
 b=hQac1thpJb7roQ3knOX2HTbQ+K/eY6PDdROWPCN8N0dHNFgzZGrfD5F9SOrCFIj2h3
 t4TesuIjR4A7GIWpARY7sNVjvJi5TU4L2QZh8JQpvzc44rNb+MQPSCw0W6/ekr6tzPzU
 uBTmILob08jMrGBE004+rbX5Rj/0GIj7mkD5950YmhZvgAn+EyBgJ+8YG0rsIw/UhWcg
 Y9cj/ABIqJSqm0PWVgfYCxWmbywdWwg50fmsdRGSasH8vW7xQcI+6dsmPGbeYMOcMT+f
 Ojk06QQgtreYOKSg8vpn113T+8D6QsV/y+GdvI4QeI7yq75GDjqKv41YmR6L79P+AKwa
 p83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464616; x=1747069416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=moTw5sctyBvVei1kdCd7jbcGztmT6jMi/oWts+VNX2E=;
 b=smnA5KF5kxS0GVJ9TwYy06PJghQVeiRiyIIqXXXDH/4XfwPKxZwN9QbVYhKvhEWaVM
 MbwZcNvVs3ju82wj7w07b7VJVK0HORdKNBfEiSGVvf9ta9u3SP2DK2dGJSciOMUMKLFi
 0qhjxu23hDmiKw89Rde0MPSo6BAG0qBRs8p4uS/BOR55J87kh94kw0RgnejC+j7JwuG6
 IuPkyxmWulvp0o5ZESYLFEwU0xbEcUvsBj8TXuAXhx5W8tg4AqEPPF9i+GgZWijh+yaA
 E8OAYgyBMnwicYGkZ6YB4Z9/iCROpN+HckKqQr0v/Rd4CP3lxFXGkc0tzl2uP8Vf0+o1
 LkJg==
X-Gm-Message-State: AOJu0Yw49/mjrkvQpfmUVQD4bEq0ZXm7WLBwkt+xiyFZa7YFyOIDDghD
 Wi747SLTeHDVMuJXj0rJ0oxhhgyQW+VANOd+/Vot6J9NsuDV9gGiP2TRgoH4U9pD
X-Gm-Gg: ASbGncs0Modz3MOPy74tsj0FHsQ+bosY0jJ86KHTNEQVQ9QSeh36TFPaMZoQjmyyG14
 qNTSGz50oVAn0q/bTXtM1puO4CnG5QgL0qlFH70cdp5GofVpKCQ/2OvTaRylRoXlT7yS9L2WGj0
 LgWmAxcxYeTar2aWNc1teIhMwSPVdsbGYjS6MkCQnc238jQwkdWT0gfifh+g27J2Mye2PFtNlHd
 Djc5z8+Vy4FucX5GpUqEK3mjUPtTDHhqB0Ea++0pJ1vM1h7040zKO1lphGsXuGnPeWhLMcIMSjc
 5Rw8oosUPhwjOag5I3osRlry+C7V1quQ2iw9KEfdE95c4ApSGwvX3+eG
X-Google-Smtp-Source: AGHT+IG2bKuUKhtxRyAEMq72ZUVTL7gi3jA6gP2na77KOu53m8vNAVF0vqHB4sQ12q1hrdUH9azxQg==
X-Received: by 2002:a17:90a:d00e:b0:2fe:8282:cb9d with SMTP id
 98e67ed59e1d1-30a61a507c4mr11133494a91.28.1746464616311; 
 Mon, 05 May 2025 10:03:36 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:35 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 6/9] vfio/igd: Enable OpRegion by default
Date: Tue,  6 May 2025 01:03:02 +0800
Message-ID: <20250505170305.23622-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x542.google.com
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
index 6908bcc0d3..e1fab21b47 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3385,7 +3385,7 @@ static const Property vfio_pci_dev_properties[] = {
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


