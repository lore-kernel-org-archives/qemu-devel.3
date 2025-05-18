Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D903EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGmCg-0006ja-UY; Sun, 18 May 2025 18:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@protonmail.com>)
 id 1uGmCe-0006jQ-C0
 for qemu-devel@nongnu.org; Sun, 18 May 2025 18:09:52 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@protonmail.com>)
 id 1uGmCc-0001ZQ-8E
 for qemu-devel@nongnu.org; Sun, 18 May 2025 18:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1747606177; x=1747865377;
 bh=ptQmGkL9QCBP2Qf6L5lSBUDWia8pgWmk9GViRkGJvDc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=vuJTPueMBlBMsphnA68qL0kLzis6eePvXk7ZYUcQO+xK74jfx/oxHOkOqmrPRZbdm
 DhzYthorljyyEUDrfY8mDbDY7d7ZuRyG2M4lc4sr6NvawfwyWQBE345JXC28zA69xw
 yf2xKV3IZlyGLTMUhN9LXd0HnVwjKbdv0/j5UlPc5X5spfGq6nVQl50iWbgluTsGC1
 OVCaeb58eqTTb5+wPFsqKYPK0WodqIPK5BqTK8jhH1WCv+ytJW7GUDC8cSZROllIQt
 iCNYwWQlZGSn2vvfUyNMjHzxiO8rApIWcvyygrc5o/zP959sTFfMQHe5EDXKdVgRXM
 QOECYjyxjOHYA==
Date: Sun, 18 May 2025 22:09:33 +0000
To: "clg@kaod.org" <clg@kaod.org>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
Subject: [PATCH] vfio/igd: Respect x-igd-opregion=off in IGD quirk handling
Message-ID: <nlfoN7cj2SVJ6LQahdnb_xWG6orCIn4hxHq8JTND4cH2gXCVy9X0KKJkVZdNiG6YmFX-1Qkc_fW2tUwk5LkQcZaJz4Lwy5OpMtaVCK7Tq-E=@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: e620c800f6769f316ca4f98f085edc05f36253e5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139;
 envelope-from=edmund.raile@protonmail.com; helo=mail-0301.mail-europe.com
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

Fixes: 7be29f2f1a3f ("Merge tag 'pull-vfio-20250509' of https://github.com/=
legoater/qemu into staging")
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


