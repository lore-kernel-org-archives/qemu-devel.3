Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63614E64A9E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4m-000842-SM; Tue, 03 Dec 2024 08:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4k-00083T-HY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:26 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4i-0001HS-RZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:26 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-215b9a754fbso8803955ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232983; x=1733837783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqEk4QSdK+ADWOaMOo65vdWqo7DUiTKvO758XSd7V+E=;
 b=KDE0RaR//01gKbsg6khpDeXfxT0keJWMuRcnmfp9O2sMr9llWLSL6e5k6t/wGsTFsQ
 /QheXcQ6sx720UhMLMiMIzx1tKXU46/xXtmF0FCI6MzFAvrz2sDzAU6keWMrgC1qQEtH
 xaVfamN7f60r9ovPQ2vNuoaZp9FFMzdY3bYxqb0k3P4psNcwTMpsuaslxLLjnvSqdL++
 8Kgopdx7F8KgkBxASrVSMzpCJGohOr/o0FIFHVKJeRWg2KWBinDPWScCuOTkGt6iYliC
 cVGMdGhjioOJj85wXiWdUuwCfVhblKF8c66mUcbpi2pwvtAhedM2rLP3CwxBHZhDa31o
 mo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232983; x=1733837783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqEk4QSdK+ADWOaMOo65vdWqo7DUiTKvO758XSd7V+E=;
 b=INgNKbF7NX6tNDYYk3lFeDbN5lSmS3jCfShhY4u5BSCWANxLxR3LLw13eckI3HxMIf
 Yqyxlnn4QcjqkABbmqjCgbiIgVgwBkHxE64Tnyk3MQtZt5cqRtlwfZS2vEKdykPcIhVe
 NdzYANZul3L0c29EfO0L2fAidwKd60PW8gugPEuKlPVpB9EYor1COdRyaeNVu7Yj724x
 av9m1KlsgDwo658hKBrv0W59oNV+l426ImtABpnNOCi2ikLBYqSzBgdwYZKjjrX/kKms
 FRuUnYA1yYjVi6sz9Ddg5CgQZnkNTrztkrOob7u4dfR1CKIcSw/C6RXtjtLeGoaXbesD
 PURg==
X-Gm-Message-State: AOJu0YycySl0ONAW9fcCsb9NtMGHHbamNLT7lOneteoQoyFYyZaUcET0
 TKwf81Z9X0AmXq1K1wamLG/8Zfa8qUiQE/YcVxuqxxOoQDgR8UhUqlDnivrLJA==
X-Gm-Gg: ASbGncuUCy2GKWJ0uBLvNus5JvHGNaZcy3dh6FaDfCsD9GNERAoE3Xsol+GcuNfQbxa
 n9yx9nkXxCrxGDxnd8dVTVTx/fx29hKjRSwz3VrGM7xKe1846sVjhciea4rL7DipTZYFn+jdXY8
 86yhEAEb083Qef+GZv5DgyZM4B5yqXqFNmyIa7SMLupQ2SFv3TW+Fxw8BgxGbKT71ENr6mTDjdr
 RxC6AsSGSwD1uGfM97d1Au4s+WfsWzrvdLcwX8KHn3J/OourfaSxwzuNxc=
X-Google-Smtp-Source: AGHT+IEYiVCkVYMPqwfp7JdomS9h8enpXN2aA2H25ejNtXt45LIjaAtdgRI1ctC8tkv1eX1vTKeBZQ==
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id
 d9443c01a7336-215bd25580bmr32592225ad.53.1733232983215; 
 Tue, 03 Dec 2024 05:36:23 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:22 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 7/9] vfio/igd: emulate GGC register in mmio bar0
Date: Tue,  3 Dec 2024 21:35:46 +0800
Message-ID: <20241203133548.38252-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
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

The GGC register at 0x50 of pci config space is a mirror of the same
register at 0x108040 of mmio bar0 [1]. i915 driver also reads that
register from mmio bar0 instead of config space. As GGC is programmed
and emulated by qemu, the mmio address should also be emulated, in the
same way of BDSM register.

[1] 4.1.28, 12th Generation Intel Core Processors Datasheet Volume 2
    https://www.intel.com/content/www/us/en/content-details/655259

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 522845c509..bc18fc8cc0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -483,8 +483,10 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
     .endianness = DEVICE_LITTLE_ENDIAN,                                 \
 };
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
 VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
 
+#define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
@@ -513,9 +515,16 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = vfio_quirk_alloc(1);
+    quirk = vfio_quirk_alloc(2);
     quirk->data = vdev;
 
+    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_ggc, vdev,
+                          "vfio-igd-ggc-quirk", 2);
+    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
+                                        1);
+
     memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
                           &vfio_igd_quirk_mirror_bdsm, vdev,
                           "vfio-igd-bdsm-quirk", 8);
-- 
2.45.2


