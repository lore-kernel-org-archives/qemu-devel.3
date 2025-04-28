Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCEFC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R4v-0002U9-Jj; Mon, 28 Apr 2025 12:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R3t-0001wp-RM
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:34 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R3p-0008Nn-J4
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:28 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-22c33e5013aso60107435ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856622; x=1746461422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duZXrZnRA5wj2/8ui2msQzSMqliRghPddVvk8iG7h/c=;
 b=eAwe743hZeLuK0+ETgKR0DMXjeGDr+Yh9Bk1Jy8as6F4IoeupBSPTHOqjWLrNFt2Bt
 t36Rtn8NT5708ROlyHfBMiW+tOwXN6UJnOBRg8PLsJuZHHKdpztE/smj68I0mwQ+1Kkb
 6lP8r6Pnp5ICPQ5I2Y/ve7FxUJdcMXy8AQ4nqEMUseC4xf5b1cbzzh6tJWIDEf3w9Th1
 vtM5lEEwILa+aWkjeG47LJlxA9zAsY52ZMtN80W78sKco+jDHMSFPDxXnJLM5MJ5SFxS
 MxSG1DvcCtVddYNGBwOnh7yUnx7XGPjhliXxyaWsDPoS7m0fquVF0RrPlMmLEoRcZ7GU
 8EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856622; x=1746461422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duZXrZnRA5wj2/8ui2msQzSMqliRghPddVvk8iG7h/c=;
 b=tBJZHE/a5bD7Cpn1QvBuezcczubaHBvplpMuCnGODNdf6fmAS47JWs8nrLzBqiQU2C
 zbC31M1Yh32p3RiSTZ89JzVrgE9cIip640F1Kh5Foi1VYiePc6VF/vmjErZEp2PUdRuD
 ACYdInRfLFCZeAK1rEJdavKwgClAppylcs+o8AkA7K8Rc4v5w3m7JMkG2za3LIEGXuix
 udYxqrDhcnAgrgnOl5FA/T3Wc6iTGEwMbnhfIc7G0pfU/vCFKb83g/bgdCsxwDMaN3Qk
 ezJ1rNwoI2MUJbdIJj8ekwPPY/MBjsoSUhYpwH4TwT4gFeuEQ5Zwk5nc7bRc59GZCeA2
 tHBw==
X-Gm-Message-State: AOJu0YzmXJ33z8K0qlYUVlpzrcenCDpH+0YnH85t+EAslmBf8vEsrLTu
 vLo9XVWL4b3hiEto9y/gUmlPDxeAmGHawH3OKXCRcAd8Oup8ONo=
X-Gm-Gg: ASbGncvdNDgVl32jp0aPCIxmPlRNRFKbFnY8UFvLJXP6X2veL1DNKo+VRMsjT6JBAO6
 j/JPCZpW757k4xxJ5KwLQA30C+EjmAmGW3cwJpPuMX2Nd0gLZWGkSc7DXjCFZZ//5WQdcKIOks3
 HdrfNeVH/hatKe6UzQtULm3W+9NP1dI4g+4CFGYy5AUar8Jeqqc6iVCPMg98q74wjLOamH0k+BB
 T8fXcOg3A3pLVW4/tJ4m4hb987wVJNq57er6rcvh27DJ7NxvYIhod454gSkicWJNtXXpvoq68Xb
 o00PsTP5rg7qPM/nfguI9c3gJVw+rMEFHMco6kcwS+fZ00qQGNs+jKPB
X-Google-Smtp-Source: AGHT+IH94K57H6yfgOVlI7r9VYrXUFkZWzvwefbsfyWt1wX2m1BwFaS1GamjeS7scOsyjFHJ41Xnbg==
X-Received: by 2002:a17:903:41c9:b0:223:f9a4:3fa8 with SMTP id
 d9443c01a7336-22dc6a040dcmr136348865ad.19.1745856622320; 
 Mon, 28 Apr 2025 09:10:22 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:22 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 1/9] vfio/igd: Restrict legacy mode to Gen6-9 devices
Date: Tue, 29 Apr 2025 00:09:56 +0800
Message-ID: <20250428161004.35613-2-tomitamoeko@gmail.com>
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

Intel only provides legacy VBIOS for IGD up to Gen9, and there is no
CSM support on later devices. Additionally, Seabios can only handle
32-bit BDSM register used until Gen9. Since legacy mode requires VGA
capability, restrict it to Gen6 through Gen9 devices.

Link: https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com/T/
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 docs/igd-assign.txt | 1 +
 hw/vfio/igd.c       | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index 3aed7956d5..95beb76812 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -47,6 +47,7 @@ Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
 
 QEMU also provides a "Legacy" mode that implicitly enables full functionality
 on IGD, it is automatically enabled when
+* IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)
 * Machine type is i440fx
 * IGD is assigned to guest BDF 00:02.0
 * ROM BAR or romfile is present
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6678e0e5cd..cecc3245b7 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -516,11 +516,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /*
      * For backward compatibility, enable legacy mode when
+     * - Device geneation is 6 to 9 (including both)
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
+        (gen >= 6 && gen <= 9) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
         (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
         0, PCI_DEVFN(0x2, 0)))) {
@@ -565,7 +567,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
     } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
         error_setg(&err,
-                   "Machine is not i440fx or assigned BDF is not 00:02.0");
+                   "Machine is not i440fx, assigned BDF is not 00:02.0, "
+                   "or device %04x (gen %d) doesn't support legacy mode",
+                   vdev->device_id, gen);
         goto error;
     }
 
-- 
2.47.2


