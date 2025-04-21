Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB25BC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u47-0007xH-Lf; Mon, 21 Apr 2025 12:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u42-0007rS-By
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:10 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u40-0003HQ-HG
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:10 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-227b828de00so42870385ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253127; x=1745857927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvtzbswQ9vJhzuX+aoZ5HpUPq7ZF3b4Ei7MsH336AFY=;
 b=aGDIzpzq7HdOQ1L44n8RWXRWTfBkYV+m11MVufZhUNI7k1CN42qhdFDZ/lXZ9JibiF
 mzqf57x8MWtGZ0FFosyfdweIJXBqF0mHRzFPLGuS25WUR0mXYUjyQtgqprs9yO/aFK2H
 5n4EAMpM7/KQyExNRYEP6etPTrY8gPrn2vSPmAfAEsX+t8Ez5KMhDEkbfSslf4iSmdL9
 nw4zIRBYeFvZq4ak8MDFr2spy+m6THdW0j2GI2UjpNpjTf4Q0BFFKWrMD47XHwWGt+lm
 w7bwBXk7KSmZBCX6YARsbzbxVhMX3mdgsHhDhFAKkUROArGI3xaolz93EK5lAmpD9Scg
 3c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253127; x=1745857927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvtzbswQ9vJhzuX+aoZ5HpUPq7ZF3b4Ei7MsH336AFY=;
 b=K7wlmUvyURVOZUwuYMX5RxWRg8ZNzyS7LYrPVH9dsxec/DJxdXm+hH79CZzmKYhJmj
 ZJZQOmn2siyeYPKikAIMVC5dWUaDU9xPxZlUOtVBtMcEK3/1S06yIWBP6pwQu4I+Hnkv
 IssYkr49HYKTLJUgYnIUwhySyzsoAV2hZTrveFQXHnU5B00nenRJHtYvElzFQExqiwUr
 lBBDFTR7OlZlkxwaqM0LmONIUbguZqWIgOYuhgcm3lzRJKivaPY2FrOFCaFE9mFdaeJk
 hc+PRa1ZAiazNcYuyuijqh0jv7gZZHdxet0w2z0IzfS8FZEbdrj2s3F0YlOCFMJlzl3l
 D5FA==
X-Gm-Message-State: AOJu0YwSHwIedJUOSwgCPnRXqMLWi7UXddJoq2Yv2dAiRetvyfaMqS0q
 DinyMhXmjB1nSuedMcgI1BJiJ/oppfxtsDJo1CkL0+wsr8CE7fs=
X-Gm-Gg: ASbGncsYi99TyEw4GCQdGTYtE3rjBJAGIh4bLGh5h7o+DsZKzwEDyYwnlSf/xS6wRF6
 2FdS77kQnKF/etYqWh5bAUcXyvGeNgoYhx7XSTp0RbxmnV/BhKa4l1YiyjmoSBnxtU0+uCU9MLf
 VgC/9Fe3/xr9akl5a0PUWgxFV85BWZ9xdcrxpc9n0372xusq1+dTKZUI9c3gLN0yvnus9+BJK2O
 2azTm8S+1C9+mtuHZ7AnpQFN3rDeLYL2MPjWyWbe89HMe3KcdfMpXR2HVQgMFX4/0fU07IE0HCs
 IavAPGcMiOxnaqe/1WTI7c4/c0+6HvkIsVbdtosCnFsgDw/ibdChYg==
X-Google-Smtp-Source: AGHT+IGfkjOm0yu2R+ftV+RM65XsM/COimANJtspwxcQQlgYjRwTD4+6/RuL96LQRefj7XiBqBA+6Q==
X-Received: by 2002:a17:903:3c6f:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22c535831e2mr188050085ad.21.1745253126973; 
 Mon, 21 Apr 2025 09:32:06 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:06 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 02/11] vfio/igd: Always emulate ASLS (OpRegion) register
Date: Tue, 22 Apr 2025 00:31:02 +0800
Message-ID: <20250421163112.21316-3-tomitamoeko@gmail.com>
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

ASLS register represents the base address of OpRegion, and it is
programmed with HPA. In IGD passthrough scenario, it needs to be
reprogrammed with GPA by guest firmware. To prevent guest accessing
wrong memory range, ASLS should always be emulated and cleared.

In GVT-g scenario, emulating ASLS is unnecessary as access is handled
by kvmgt backend [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gvt/cfg_space.c?h=v6.14#n295

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 01826acf10..36316e50ea 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -182,10 +182,6 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 
     trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
 
-    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
-
     return true;
 }
 
@@ -583,7 +579,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LPC) &&
         !vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
         goto error;
-     }
+    }
+
+    /*
+     * ASLS (OpRegion address) is read-only, emulated
+     * It contains HPA, guest firmware need to reprogram it with GPA.
+     */
+    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
+    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
+    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
 
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
-- 
2.47.2


