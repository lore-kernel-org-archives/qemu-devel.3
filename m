Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B61C54F32
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHuI-0005nv-Dt; Wed, 28 Aug 2024 08:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHu9-0005JX-LZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:36:07 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHu5-0003Am-4w
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:36:04 -0400
Received: from 172.17.5.170 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Wed, 28 Aug 2024 12:35:58 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724848558; bh=7yYl05lZacMAh3tZlu2XKHEwlxzsHcRZiBDxfb3o9dE=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 7Bk8C68lQX9prUO0DvK7XadMlpW/cMQhnMh9+XgGQkY0Cw99Gs0tsJyse4zKZK8j1oUpsj6q2tc9noFRh0RSAg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724848558; bh=7yYl05lZacMAh3tZlu2XKHEwlxzsHcRZiBDxfb3o9dE=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 klOvL6o9qQ3vRCRK4bI7+XcMk6+xay1b2pApH80RBjTWbthDfRGkMcJWMfhDyS1BDkaEpqQPMKezpXnyjFAWFput4XzpvCvwgxwERzV6+LHfnnjgbD+jI4XejDf0Hx+uxF3riPiakCY7FnyzEgmcDXtiR9hA2dWLBdwzrKA5Rp48P31e8OFkYLAaOGTh2JuTaRz4IVZk9Ale1pil0g4HKs1JWtjUrB0/eqvOkxXhwNpaXCzws33nB8pe+SKYofTZCJOMxo6rkTEN8j7TG4DuCjBT5uU61g9nhrsBp5yopvx9/uPDie3UKLn5lefQ/5L4MLZVW8ymVEw8X9JaOCTaIw==
Received: from corvink-nb.beckhoff.com (172.17.128.201) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:35:55 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>, <c.koehne@beckhoff.com>
CC: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: [PATCH v2 3/7] vfio/igd: use new BDSM register location and size for
 gen 11 and later
Date: Wed, 28 Aug 2024 14:35:45 +0200
Message-ID: <20240828123549.83293-4-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828123549.83293-1-c.koehne@beckhoff.com>
References: <20240828123549.83293-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.128.201]
X-ClientProxiedBy: ex03.beckhoff.com (172.17.2.169) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

=EF=BB=BFIntel changed the location and size of the BDSM register for gen 1=
1
devices and later. We have to adjust our emulation for these devices to
properly support them.

Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d5e57656a8..0b6533bbf7 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -100,11 +100,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
 typedef struct VFIOIGDQuirk {
     struct VFIOPCIDevice *vdev;
     uint32_t index;
-    uint32_t bdsm;
+    uint64_t bdsm;
 } VFIOIGDQuirk;
=20
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
+#define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and la=
ter */
=20
=20
 /*
@@ -313,9 +314,13 @@ static void vfio_igd_quirk_data_write(void *opaque, hw=
addr addr,
      */
     if ((igd->index % 4 =3D=3D 1) && igd->index < vfio_igd_gtt_max(vdev)) =
{
         if (gen < 8 || (igd->index % 8 =3D=3D 1)) {
-            uint32_t base;
+            uint64_t base;
=20
-            base =3D pci_get_long(vdev->pdev.config + IGD_BDSM);
+            if (gen < 11) {
+                base =3D pci_get_long(vdev->pdev.config + IGD_BDSM);
+            } else {
+                base =3D pci_get_quad(vdev->pdev.config + IGD_BDSM_GEN11);
+            }
             if (!base) {
                 hw_error("vfio-igd: Guest attempted to program IGD GTT bef=
ore "
                          "BIOS reserved stolen memory.  Unsupported BIOS?"=
);
@@ -519,7 +524,13 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, in=
t nr)
     igd =3D quirk->data =3D g_malloc0(sizeof(*igd));
     igd->vdev =3D vdev;
     igd->index =3D ~0;
-    igd->bdsm =3D vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    if (gen < 11) {
+        igd->bdsm =3D vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    } else {
+        igd->bdsm =3D vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11, 4)=
;
+        igd->bdsm |=3D
+            (uint64_t)vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11 + 4=
, 4) << 32;
+    }
     igd->bdsm &=3D ~((1 * MiB) - 1); /* 1MB aligned */
=20
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_qu=
irk,
@@ -577,9 +588,15 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, in=
t nr)
     pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
=20
     /* BDSM is read-write, emulated.  The BIOS needs to be able to write i=
t */
-    pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+    if (gen < 11) {
+        pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
+        pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
+        pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+    } else {
+        pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
+        pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
+        pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
+    }
=20
     /*
      * This IOBAR gives us access to GTTADR, which allows us to write to
--=20
2.46.0

This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments=
. If you have received the e-mail in error, please inform me immediately by=
 reply e-mail and then delete this e-mail from your system. Thank you
=20
Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben. Sollten Sie die M=
ail versehentlich erhalten haben, teilen Sie mir dies bitte umgehend per An=
twort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann aus Ihrem System. V=
ielen Dank

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Bec=
khoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075




