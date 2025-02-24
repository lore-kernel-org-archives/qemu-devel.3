Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCEAC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdEa-0007C7-SG; Mon, 24 Feb 2025 13:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDJ-0005id-65
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:58 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDC-0003My-4o
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:55 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-220d28c215eso73436425ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421788; x=1741026588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCCHlPi+FxqsaGVtlmnpzUh3V9i8PkuobSoBDnQT9Bk=;
 b=JGFn+nZKqNY212VYS5RG8gVRhB+KstTPU9LatdgxJjWt9IDNbspoSG5MzuCnXkADpW
 kxKY8f5Ep7av4xvWYCU6UCMbIsL/SzN9q6E/MUXvyM0E7fwZ2YNRTr8eYOMt0netBi9b
 6U2oIKeYnQK87ylKyi7iWqJgCBCewfcAryepC71bJlOaJ7Q8XC3I0eNAfCLqSqATrSaC
 xvISe5rYCoBuMaLOUdFRIZbt41b3lX+v8J53X7w2FB1vlwNFpHu+L6obKh63E6i5RhUj
 xRgyJ24C4To0P/IuGU1EyJHAERZxLjszfBzC7yftGp7hT+ehs6tvdZPnsF0ZkcSSr9lb
 o8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421788; x=1741026588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCCHlPi+FxqsaGVtlmnpzUh3V9i8PkuobSoBDnQT9Bk=;
 b=MpnPmqiRurYZzYr9/3Etb9LwkX0Xc1VFVL8vCKUaqTLuWZ6ZS3yPUk1rgmpmzzU17C
 /gECJmtxN7n1s5B+ZBXdZ5JtiT/sifsLhcTrjFTC/ZrDH2l88JDWFl7V+ToEksIap0N7
 iB/74FIlL4JI4SWDeUkaPk+LXP6Z4SWiFfOcYFk9OYY2ZSF5tR0bPf4id+4+UpPoWDA/
 /qYjYyZEAQHDZfCszbGxEkYSfFYBk5XJn+WmAZreQuDMX3hPszxLe5CTm/NbzmA0Kmbr
 5g8L7fKzfCjda2Bve2pF6PUlRGZz4k6uSmZy8N1oYp2BkUq8ifrrtUHzhi9Vfca+10eZ
 dmog==
X-Gm-Message-State: AOJu0Yw2qPXnhFc1sNpsR3iim8QPGr4oG1xWe9yPzDUprWsTk4mycxHK
 rfcWFEswak715q/IPgTLLRu+sjnH3fNAIvVSN44J4CDElgAipcfkOsTbG1vgsA==
X-Gm-Gg: ASbGncuw8UjJvlGzkL/TabMzkNxRLII/iH3Pg27d08EQR1JFD0c6Vnqu+lk1gFjiuxo
 fyYOsMsoLRDgg6marpJvKjWS6Xr7ft6r3Ix2BrwIFjtCaGgovEiRzXKw6bkav6mXP96gteO3Vpr
 TWxuI6O/jOZTEpHvM5naWBZqWSETLfToliGsuJ/HpZoFlh65D/5DflHIOhllBtx9WmLtBYhYRK4
 jbLNimtWUdCHN0/buVY8OVfjZ4etuLw05/hu2YFImmx8UnvvOSGYaXpdA/uD8hHZo//3u3yCR8K
 gx6+kKqLW/IqVRi1J2322qg6vfHEGUoGqvwDeQs=
X-Google-Smtp-Source: AGHT+IFEPoHZpbhwuiuN1iatqbtTb6riJOi8MfOnbJoZNs7go2bFFJQzmls705M00pfEDV1+5vGWfg==
X-Received: by 2002:a17:903:191:b0:21f:6a36:7bf3 with SMTP id
 d9443c01a7336-22307b4bd13mr3740265ad.12.1740421787028; 
 Mon, 24 Feb 2025 10:29:47 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:46 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 04/10] vfio/igd: Remove implicit VGA access enabled by legacy
 mode
Date: Tue, 25 Feb 2025 02:29:21 +0800
Message-ID: <20250224182927.31519-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Modern EFI-based system and drivers like i915 no longer use VGA IO/MMIO
registers. Currently, legacy mode checks if the VGA decoding cycle is
claimed by IGD, and implicitly exposes VGA address spaces for device.
As we are going to remove legacy mode, remove this implicit behavior.
If users want to enable VGA access for IGD, use the common x-vga option
explicily.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4ae1122a2d..32ae263c23 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -430,20 +430,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
-
-    /*
-     * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
-     * try to enable it.  Probably shouldn't be using legacy mode without VGA,
-     * but also no point in us enabling VGA if disabled in hardware.
-     */
-    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
-        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        error_report("IGD device %s failed to enable VGA access, "
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
     /* Create our LPC/ISA bridge */
     ret = vfio_pci_igd_lpc_init(vdev, lpc);
     if (ret) {
@@ -467,6 +453,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
+    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
+
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
-- 
2.47.2


