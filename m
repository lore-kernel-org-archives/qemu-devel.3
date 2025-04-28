Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF07C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R5C-0002ww-SA; Mon, 28 Apr 2025 12:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R46-0002Az-VO
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R3t-0008P4-LK
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2240b4de12bso75494765ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856626; x=1746461426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+hBDhes3/DrcIWlptsB64Pmy5+nfTxX6Db/iDs1KCE=;
 b=kqJ5EURp6S+KLM7HxWrJ5TnZTd9egvuFIT0/Jzfp9t/+NsvBnDNEpJAMWyBoxEmwgV
 uagE05vSuFA2EG45seEBCe1qbw2+Hluns/7/VzKsPtLLmvl8T1GTTjoch6TnluBzTeS6
 xBNX49RzvGZwN8pP67EyiStH8QKfKhJk0LodzmwPHx14pC8e0+IvrPuCUqDeZi0RbbKJ
 l/IunLJpC4SsGpDIywvAn2h3FztYyOS+IxfaCV9GWaGPCmrNuBOkIMG86h6u6wPQj52l
 8ZH/vcGWy00lO0fWESC86vRnxiLQDd+V9vNbtFkMQqVfqqjuHxCtldg3uwGtyTE3NYKY
 WzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856626; x=1746461426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+hBDhes3/DrcIWlptsB64Pmy5+nfTxX6Db/iDs1KCE=;
 b=OWjeqYA5H3L3z3NH4fv3y9521q0bC+aoTDSRmLtGMtDGpxJ6t75Cdh5iGPmO9C37KO
 t2LPWcL+NP5M130UQBcn2RNB7AvkpDkvpW5KCOIaKfuO8/qzqb9P3FEnKuaVPKso1EXc
 pk3X7opCdG02Z8W/eHcxYrr3bAm4NcMNAl6tiz+tqR1I2tt6yHvLOLX7Yws161T4Hpxb
 E0BOMQzI/bwr0wWeREI+RRvG75s1dLtucYiA430Yq/CsqlSFge8ITHilDv1YR78H8paV
 d3FfB2dSyum5stU35VMNYweiQbfv21efiKn7AUYiaiBn/8dvAvw774azLH0eFOEus+US
 WUxw==
X-Gm-Message-State: AOJu0YyGDd4eOo9tcmY3U973aaq+NQ3iSRo+8GBr9okKZhJd760YHpCL
 s5fmB7mzTewrox2aDoj8E4CxbubBWCv9emlIVFYPn9bELhR5utM=
X-Gm-Gg: ASbGncsdAk7+0oEOjgX6DdEHZjNXRudRxKhnkIx1J810TovdykDRX5ZHeaAYL1ZiWJh
 40YIC3jJ3h0DV2YDwHKJaxZuCfUWR73F/5WqWPJRI2JQifQdtR1Q/JjtnoKpgLR/urdGHAv4iKH
 ENFjlzegBk/vVzTXewoMN/IDcf4QtSsXbzzdiozrO0cqBqROnuM64CC9NrIJ0NJvOWrnsT6Y1yv
 uTsDa5s112ykuOz3lbhQTSVvEL9C4H7KUYh3SrcYafqJjm8qb2NoNGTzXQwDmn8N67ZWdiDRfXC
 2TYAP3CwLqBXrUR2v/xBYZa5nOBZozWptJRkSR8NIZILVtxLp+wuINBE
X-Google-Smtp-Source: AGHT+IGHrAlQjtNfNelP3s4SZrhhlaFRgStmo2Z7AIrMI8EPbpiLPNUP/51zzUtf+nK4OUzO7zbWfQ==
X-Received: by 2002:a17:902:f60e:b0:224:c46:d166 with SMTP id
 d9443c01a7336-22dc6a684famr156183585ad.40.1745856625758; 
 Mon, 28 Apr 2025 09:10:25 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:25 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 2/9] vfio/igd: Always emulate ASLS (OpRegion) register
Date: Tue, 29 Apr 2025 00:09:57 +0800
Message-ID: <20250428161004.35613-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
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
index cecc3245b7..ae19456457 100644
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


