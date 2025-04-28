Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC0DC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R5O-0003MV-BQ; Mon, 28 Apr 2025 12:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R49-0002BM-5R
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:54 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R40-0008Pc-Fx
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:44 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-224171d6826so75952035ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856634; x=1746461434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgk5hGTss7Ugjr6726XgfRiiCnxnWB9tkmwUy+R3V5c=;
 b=acx6HSml5maa5sTJzPkiltH18fQDxJmbLoD20A5cx5y366FKJIJcyGb1F47UVIYXyg
 cp9RwaLgLvefN3XcADNADofAUfZrCMCXs/dGkeuFCEHa72i36SxpmJLLQB8PXd8qmktC
 hp9OiVZumyRGcM+dEVuj6yXsoEdr53qpOT0U07GTqT3tekdeRUoPz2jejRQl+jfMiXVd
 qUoYLSUDczElEvbJOREJjNvTV6mWIFSmi7ZYVCUI2siI5dVcjZ0ElfUe4MQ789DAhtxV
 ygrUF3pgjkSDxMch6OOhNOlP57Ou998LGITsy+d8kmqoCRTRnCl88bN+YzXVBqMK/Kgr
 D8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856634; x=1746461434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgk5hGTss7Ugjr6726XgfRiiCnxnWB9tkmwUy+R3V5c=;
 b=wcYEE3R7GUUoP+359fHrgQTwxJG3qUKuIfCX/8msezVGPdttVDg4FeaC4YC/U/oH2y
 8tklQrmwvJ0yFQkI/wn9uIGpDLxJT6MppIzPj5cqxFWtiQofV7EPMQqN/ckG+6zY4Cua
 LvR31670FElErPTv5lPSuqsFP/6/ynYVo+Hk02KkZhATVrz5tGjg5jcWgowrZPkqsL94
 zWcUkOGSnY4+kJ/fT+IiMbUA4JwK8e6hSRU6VKK20j/1z8oBhmyRCwxCIXlXuliLGe8l
 00cAVHhk86tDxtefjQPaoRSo61UXKcXcSiBaDBSdzvtgqkmM9nTDIG9pDwV21XaJImjt
 1sSg==
X-Gm-Message-State: AOJu0YzYY7fbyHcfxwLqWidcZLy7RSRS3XY4wcs9YVjtuppVW2iCiL3x
 ZiS17vFMN9OOu+pEYotJeKANffjOThnLpG6zTiX5nUbAO8tjsVg=
X-Gm-Gg: ASbGnctrdMHcT3lm3e2PK/yIViJ8VIm1sXjLu9YghDB39qQQ7YxiTTb+lIcrFECEfFj
 s26TmXFsNYONtFLVhfV7Pgz5Q/q7LR8R+g5Jxo/9rgf5HNmjzPWmd8DsH+a/wKKOvfktV5eQtZ0
 eK/5Z18k09GtonFUXHJhAmaSMYYBbWRf6BmhVi0uyfVpgYfNLqqhXiXjLUTPZjU8jBURiXqPuCj
 rfuGKxgyRR4BKgEIFSK0YrGWGckFa5m7Vo+J2NPmsoouuzyXx8Y0hv39mnjThgo97b4Bc2Pb3+N
 ArhSIo4r5LlEUm9x+heJAasFfOqe0L9lF9cbMGS1KrQqTht7S9zcgGXP
X-Google-Smtp-Source: AGHT+IGUhnbh7jY2JhR4fmDq2RzDjdMQQCmO6tIKr2aw+Vlx8D5N746yyKadjKZSUm+9gFC9bk2dBw==
X-Received: by 2002:a17:903:1b6e:b0:220:e1e6:4472 with SMTP id
 d9443c01a7336-22dc6a04758mr126653165ad.13.1745856633838; 
 Mon, 28 Apr 2025 09:10:33 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:33 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 4/9] vfio/igd: Check vendor and device ID on GVT-g mdev
Date: Tue, 29 Apr 2025 00:09:59 +0800
Message-ID: <20250428161004.35613-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Check the vendor and device ID on GVT-g mdev to ensure it is a supported
device [1]. This extra check is required for automatically enabling
OpRegion access later.

Note that Cherryview and Gemini Lake are marked as supported here since
current code cannot distinguish them with other Gen8 and Gen9 devices.
Since mdev cannot be created on these devices, this has no functional
impact.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/intel_gvt.c?h=v6.14#n52

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d6880cbff7..c6ecbefb35 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -671,6 +671,18 @@ error:
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
+    int gen;
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev)) {
+        return true;
+    }
+
+    /* FIXME: Cherryview is Gen8, but don't support GVT-g */
+    gen = igd_gen(vdev);
+    if (gen != 8 && gen != 9) {
+        return true;
+    }
 
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
         (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
-- 
2.47.2


