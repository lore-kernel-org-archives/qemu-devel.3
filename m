Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3F8C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u4P-00088m-HO; Mon, 21 Apr 2025 12:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4G-0007zJ-F2
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4D-0003Io-3B
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:23 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-227b828de00so42872965ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253140; x=1745857940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvC99gYRAIEXOQtPt1e5/2mg3W15SfaN/5LpS/IYlFk=;
 b=Bz3rhySTq9dXr/YpDVM8CVYy+O/TyqepbKOSw20U0RkR6Eg7n3IAKuLPs3J66DtVdC
 smpTnkrUGxvmfCi0KFyNXBYlBovWhhN/WOc9QeXob+Y6Uhh4ku6FL3Zd2sbPMJ7QWHc3
 XjLNkkRe5SfZcGUxpTEtRGItQHRtLoF66x0Gle4YKxybidbj83NIWDlsUv4JHUoSXfEh
 +vPubo0TmHrra5DuvdJQBVrvFbmbkOv3b0EXrLNHR1N3OQlfsArTPbiwS6iVpwfgtvsR
 GpHTBXDRctJ3vEP/LrU6qs2m4ddcuaMY3MEmJETZX/0t/LSwgukI6vuB9XnptKm3BTNk
 ALlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253140; x=1745857940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvC99gYRAIEXOQtPt1e5/2mg3W15SfaN/5LpS/IYlFk=;
 b=CqtbW7mVh3ZDvYyBdACI4M1O0qYQx7MSYLTOmlAfOnayGLxErO5DjTz13vCr950f5J
 3V2IzIgicJl52bYnIq7drtAQxtcHLnYFh4rWEr/p0GJ3Lo3tMBmYts92wQuQWKuq+M6/
 L+/UtlHNxaKIOhwXY+w3DCsxOfSol8J8NPHeUQJVniMkP25h2xnPa1hWzj0w8hGqeF8J
 XheMQzi2DZ7E4qDgjY/lbbRGvHDYShUrWM+0iHUOD5L1n1YlSWhZhgF0Og3OsoIi1ZK6
 avx51BB3UiJoGI5melrRWQSfanJwVUWqkEmGxJNLQbOdiF6NQtTfRfxaVvHEMl26ATmv
 lqbQ==
X-Gm-Message-State: AOJu0Yw3ZVIlDKiMkDfuvb8+FFiiHPffqirWYdb6DbOMJeJWfO8+G0zE
 WChlPkGLJf4qyg87qM9NEDCl+8CUvVgxXL2jF9BLvbFWAn4CImSlFWvWIbbg+Q==
X-Gm-Gg: ASbGncsWpEcNG7AaOgOKUxi4BJzYB4yz6UGW78Onk98b8s8r57AhisR3CCDEd6A2Vvv
 7gMCrz6JGi5xDvvP5k23LettelAh7Tc2I79re8MrGLe58u9A9aFkPSnU3tolCo7Ldk5TkjdmGjT
 i1rRIMAJqN3QEWHuSfPKn0ZzDkJJqJgE4NsOpW7uZcFIUmHb5ONgJZpOkaVqY2L51vi1i6OkmPn
 q3oqE9drCdngonWTs46H5ghGAbd6YsY3iDvU+h2riFMMza5nNcrR9Ef0/EYIn4EcT9Q15K3yOAE
 CqZQMZfEFEOrpS1s6bFEpZh8ICd/U8NGJbK02O2VLWQxXCyKelq2jA==
X-Google-Smtp-Source: AGHT+IG5KOMuDw+syVygKtKZbvRcsDy+O4SrasQ9PUJfAcCiU7Ov2frs5yHxYGmZYEoYBaVAswFg3w==
X-Received: by 2002:a17:902:e847:b0:223:35cb:e421 with SMTP id
 d9443c01a7336-22c5362087bmr189089035ad.49.1745253139651; 
 Mon, 21 Apr 2025 09:32:19 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:19 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 06/11] vfio/igd: Enable OpRegion by default
Date: Tue, 22 Apr 2025 00:31:06 +0800
Message-ID: <20250421163112.21316-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
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
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


