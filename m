Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBAFC3DA6D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGvTs-0008Sd-Uo; Mon, 19 May 2025 04:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@protonmail.com>)
 id 1uGvTh-0008SC-Cr
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:04:08 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@protonmail.com>)
 id 1uGvTc-0008OI-GW
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1747641833; x=1747901033;
 bh=D/cBre1ruufahZanN+iYmEjNuHEluhpwOwu4cPB7ozM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=My3FAfThRBqMZ9HAR34rbFYiJpajkYZHordamztd49K6abhl8q3zjuUHhn9IJq39V
 37V356PuwLzMMI4Fvhg4/XPAHef2c89hXJTNgs2z9l9E9rUT8n7KchTcOELjD6FfP3
 CKA23246CT7WEiXqCVy9Iua+eSieowi9atApFKy9J0kEGivqZ3n9dcPfGi4KZCosQs
 8PdsVelX46hsrspUr5KYK0kRyzY8YQKlY615NLDgk2sDTHsy99eBpFWtAGzbyb1jUk
 EfrQY+u8VFeAZEm91f7tBe056ivClshGKw7Tqwya0Ao4zHSqeddGWWqe1zR9QhTOh9
 ZmFTd+gxuTrqg==
Date: Mon, 19 May 2025 08:03:49 +0000
To: "clg@redhat.com" <clg@redhat.com>,
 "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
Subject: [PATCH v2] vfio/igd: Respect x-igd-opregion=off in IGD quirk handling
Message-ID: <tgKYxqCs9bUrxIZV2h4pSnR4gEjle4oq8tKs65J8lM70PMsBpuxOPKbv0cUJLfLQdks2C-PUIBJx3kqMQ78ufP2EMEBwwjzT6FxfsZlBfcs=@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 43b33c573cf9e621dfc65c888644fa89c3d4a655
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.77.79.158;
 envelope-from=edmund.raile@protonmail.com; helo=mail-0201.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  "edmund.raile" <edmund.raile@protonmail.com>
From:  "edmund.raile" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Restore SR-IOV Intel iGPU VF passthrough capability:
Check x-igd-opregion=3Doff parameter in vfio_pci_igd_config_quirk and
vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=3Doff is
respected despite subsequent attempt of automatic
IGD opregion detection.

Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
---
This patch fixes a regression in QEMU=E2=80=99s VFIO IGD quirk handling tha=
t
established automatic IGD opregion detection which ignores=20
x-igd-opregion=3Doff necessary for SR-IOV VF passthrough of
Intel iGPUs using i915-sriov-dkms.

Please review and provide feedback.
Let me know if additional testing or changes are needed.

Kind regards,
Edmund Raile.

 hw/vfio/igd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7952d15a0..e54a2a2f00 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -523,6 +523,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *v=
dev, Error **errp)
         return true;
     }
=20
+    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
+    if (!vdev->igd_opregion) {
+        return true;
+    }
+
     /* IGD device always comes with OpRegion */
     if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
         return true;
@@ -689,6 +694,11 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice =
*vdev, Error **errp)
         return true;
     }
=20
+    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
+    if (!vdev->igd_opregion) {
+        return true;
+    }
+
     /* FIXME: Cherryview is Gen8, but don't support GVT-g */
     gen =3D igd_gen(vdev);
     if (gen !=3D 8 && gen !=3D 9) {
--=20
2.49.0



