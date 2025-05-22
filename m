Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB0C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7yN-0003Ql-Tn; Thu, 22 May 2025 11:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uI7yL-0003N7-Ne
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:36:41 -0400
Received: from mail-24425.protonmail.ch ([109.224.244.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uI7y9-0002TN-R6
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1747928184; x=1748187384;
 bh=ZMMy3wNTzo1mB5J12StlPZhTmmXys1OeNRsTvcZ9IrI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=C/srw7RXf0QTgvGvUqi5ORKhoC6FWt+Cd1Bma+drV2pWO1U5YuE261ANHuWkb2RGL
 WMgxyVC6UUpOwknyyobJeGsQNq5MCwoN+qbimaMAmFoJTsSOYymPgwVktE4Vvb+7O0
 nggR2/2Xjs2Y6LDYU28nBsGJ9X3DgxgU0Xmr8kamfH+RYum02Qe+8Efba0Coj0cpbU
 uJuRg+B+jy6gNR5iUTPTzz0BCr8CMaxJ/nrPAnJyE7Cot7vEIslnPjQiocuJUGxgFX
 yM3EoRF1Bz9g29V4WJdCrC3CEGy3fXT6Ko3AgtdMuMSXOTonXhC0A1e5HJ1jC661yK
 dZ2jOVSV7wj3g==
Date: Thu, 22 May 2025 15:36:20 +0000
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "c.koehne@beckhoff.com" <c.koehne@beckhoff.com>
Subject: Re: [PATCH] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Message-ID: <eNe_mk1SBIlC3q43ujt4rZfx2rEmWy9h08Faxg4kaSLinxbZbY5-XfjCP4wcZLfkOtrIS1yVnlO9cmKOS_Qak6JgqnswyIIiCk2NL5gwrXs=@proton.me>
In-Reply-To: <20250521154036.28219-1-tomitamoeko@gmail.com>
References: <20250521154036.28219-1-tomitamoeko@gmail.com>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 62f246532b73f5032ac46eae6497a52107cc1cbc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.25;
 envelope-from=edmund.raile@proton.me; helo=mail-24425.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  "edmund.raile" <edmund.raile@proton.me>
From:  "edmund.raile" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Moeko,

>I did some further debugging, and found it was caused by a mistake in
>error handling. In vfio_pci_igd_opregion_detect(), `errp` is set when
>OpRegion is not found. However, in pci_qdev_realize(), the caller of
>vfio_realize(), it checks if the errp is set for failure, rather than
>the return value.

Am I correct in assuming that errp can just be removed because the
return status already carries the information?

>I will submit a patch later to fix error handling.

I've had to manually apply the patch by hand.
For me, your patch became:

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7952d15a0..e7a9d1ffc1 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice =
*vdev,
 }
=20
 static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
-                                         struct vfio_region_info **opregio=
n,
-                                         Error **errp)
+                                         struct vfio_region_info **opregio=
n)
 {
     int ret;
=20
-    /* Hotplugging is not supported for opregion access */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_setg(errp, "IGD OpRegion is not supported on hotplugged devi=
ce");
-        return false;
-    }
-
     ret =3D vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL=
,
                     VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
-        error_setg_errno(errp, -ret,
-                         "Device does not supports IGD OpRegion feature");
+        return false;
+    }
+
+    /* Hotplugging is not supported for opregion access */
+    if (vdev->pdev.qdev.hotplugged) {
+        warn_report("IGD device detected, but OpRegion is not supported "
+                    "on hotplugged device.");
         return false;
     }
=20
@@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vd=
ev, Error **errp)
     }
=20
     /* IGD device always comes with OpRegion */
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         return true;
     }
     info_report("OpRegion detected on Intel display %x.", vdev->device_id)=
;
@@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *=
vdev, Error **errp)
         return true;
     }
=20
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         /* Should never reach here, KVMGT always emulates OpRegion */
         return false;
     }

Testing it, it works (for me)!
Though I can only confirm the negative (for a SR-IOV iGPU
virtual function).
I can't unbind my primary GPU (the root iGPU device) since
I'm using it.
The VM boots fine regardless whether
`-device vfio-pci,...,x-igd-opregion=3D` is set to off or on now.
Tested-by: Edmund Raile <edmund.raile@protonmail.com>

Your patch provides successful automatic OpRegion detection.

But for the case that this automatic detection should some day break
or become ineffective due to new hardware: should I still send in my
[PATCH v3]?

[PATCH v3] vfio/igd: Respect x-igd-opregion=3Doff in IGD quirk handling

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7a9d1ffc1..ac9f504e8f 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -521,6 +521,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *v=
dev, Error **errp)
         return true;
     }
=20
+    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
+    if (!(vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
+        return true;
+    }
+
     /* IGD device always comes with OpRegion */
     if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         return true;

That way, we'd have a certain way to force it off if need be
A redundancy, in case.
Can't always expect everything to always work perfectly.

Thanks,
Edmund

