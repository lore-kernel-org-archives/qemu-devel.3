Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A1EC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFY0-0003AL-9A; Thu, 06 Mar 2025 13:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXn-00036Z-IY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:02:03 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXl-0000DN-OL
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:02:03 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-22401f4d35aso18439285ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284120; x=1741888920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jrFIingrAbF5dij+VV01pN3aIuY/zKM1+KpxvGbRKI=;
 b=BffE7O73YHCSxxL38icGoNCj2UY8CVfCkDJtA6aHAU8UdT6mRBC/Iu7j9g2N2qyjYH
 GccGPcOueWLZWyBKClMTY1GD75BcMDZV63sIqjC80paTXOj/F8ev/s0UqIdE4zaPXcss
 uBsqYlMmtXsb7pVCwgOieZINHdw/+y2VTwSsUhK+BG8y4kdqtiwqHz3nUbLXpHUkIiK7
 yGh9Ko9qvBDYe+rtyr1j2G0a325JX8qaZZ3qgNwmW+rX4PlWzQRdqT7UJe/PAls2c89O
 TTLeve3Ks2DAUty2z1WRVNLPlrtFEWLF3bw99PRv9A4wvb1mw7UGvXZmJDtWmSbu1Ces
 TjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284120; x=1741888920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jrFIingrAbF5dij+VV01pN3aIuY/zKM1+KpxvGbRKI=;
 b=IJyLkO6L0Q2uGjfCNkKBjxMFisFVqxSLxw1CvrLTN6qalt7nvm3wh+EDTu7ZPbR9Gj
 HTRXVl/CVXaxh0VFFA8dtNLRVglgHTZjEwue0jnevieai+JBeQfnuBccwZb2p7lzi/kk
 FdJfWqsGNY+pItXc7c/1Tk0DTZENZQOGtjFReS/xI37IDc9UzbL9dIHTdnR1guzub5Uq
 e+vvRRgntYcFoqQi2/aNKEI35FxaCgJT00dBqOXcJQNPKAiCSs8PM5hO8QuROWwWRhit
 VwHhQyt+WvWTxb5C10N6oQV8fN8BPw7eXDQ3Fv7LlNzVcQNjL7rSNH7PTaljyhkxnx5n
 OFlg==
X-Gm-Message-State: AOJu0YxTnTR5eYk8ubBFvoU3+3MX62Ryr4C5kaaVxzwvUlMUnYZCkJr4
 a4VQw+YYEesQycWwW2ET/F/wl3Hhl4CpbPn6PK17Yxx/D/OPfkQ=
X-Gm-Gg: ASbGncuZ+n21sw6R/kkGCiQQi52zlyTe/kKqdXmRDoK9zcOR6KEazsfZlk/ttiw/rz0
 V58uEOHtbPy0sSKvdKuqR6r/a8inU6wUD/+K4UeObWe8RhUCZIpeUk0y95xklnqsv7+hHl0oQ2i
 f45SAKITZVVNYladu14V3/fhfdv6d/iYoHDxx5LNcSZYMieE2RgfIxNnMGHjt/Ns9wCBBnhqsHT
 x2TH2laK3WoTcAvqLqDvqBeibYW68zGMHj8aKkHoyITC1TuDX3oMFb2dNTCxLMxOJr7m7WuwZnk
 W73pjy2UcLPv41qz1lZc0IRnREFRStZHjzi4UX90nwvOwTV49il8uChXRA==
X-Google-Smtp-Source: AGHT+IGM+vtzTBAbn3N/cHyXCI95F0tCreWUJsk8cg2uorxSD5Tj6eRkaJiFjpeTcqP8yizysmsBbg==
X-Received: by 2002:a17:90b:1b0b:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2ff7ce989dcmr336874a91.18.1741284119206; 
 Thu, 06 Mar 2025 10:01:59 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:58 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 10/10] vfio/igd: Fix broken KVMGT OpRegion support
Date: Fri,  7 Mar 2025 02:01:30 +0800
Message-ID: <20250306180131.32970-11-tomitamoeko@gmail.com>
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

The KVMGT/GVT-g vGPU also exposes OpRegion. But unlike IGD passthrough,
it only needs the OpRegion quirk. A previous change moved x-igd-opregion
handling to config quirk breaks KVMGT functionality as it brings extra
checks and applied other quirks. Here we check if the device is mdev
(KVMGT) or not (passthrough), and then applies corresponding quirks.

As before, users must manually specify x-igd-opregion=on to enable it
on KVMGT devices. In the future, we may check the VID/DID and enable
OpRegion automatically.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6775ce2eac..4c5d6a016b 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -481,7 +481,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     int ret, gen;
     uint64_t gms_size;
@@ -655,3 +655,28 @@ error:
     error_propagate(errp, err);
     return false;
 }
+
+/*
+ * KVMGT/GVT-g vGPU exposes an emulated OpRegion. So far, users have to specify
+ * x-igd-opregion=on to enable the access.
+ * TODO: Check VID/DID and enable opregion access automatically
+ */
+static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+{
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
+        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+{
+    /* KVMGT/GVT-g vGPU is exposed as mdev */
+    if (vdev->vbasedev.mdev) {
+        return vfio_pci_kvmgt_config_quirk(vdev, errp);
+    }
+
+    return vfio_pci_igd_config_quirk(vdev, errp);
+}
-- 
2.47.2


