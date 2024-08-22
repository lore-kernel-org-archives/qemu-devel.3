Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C390EC5321D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8HI-0002GM-1q; Thu, 22 Aug 2024 09:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh8HF-000278-S0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:55:01 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh8H8-0002aq-Na
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:55:01 -0400
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 22 Aug 2024 13:54:52 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724334892; bh=vZpI2KX970FCkxh4TIH5tOCE+9k5HnXqH3orDbOlCUg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 ll4BqYlLqTjnTIpoEMlnysz2Hh/5mf/bEGRFUesyLXYBAZmQcbMIFfMcFsryXiCuIVjM+ZuPu1wvIguszRGpBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724334892; bh=vZpI2KX970FCkxh4TIH5tOCE+9k5HnXqH3orDbOlCUg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 JaEZc710jg0Zx6A6IciK7U5NAC1EWre9ETzGNZ/9WsVcYyBci6ZQfIgkAeTQF5ZkkNSRkOfS4wE0XtS/b78D7eWrF6QfmBfHuWqV7Q7UNGCv/1mv4fckEfpD7sw0PlFI5ruyLxQlJfkwJ4vr3Q3/tSbfLzrvXWSRsbuBC6KHVfFzhgjEWqohOnRqKwffIkMk3pnMO0j98t77bM/d8T8NlrwbFModFDpJDPbfKjcdKS+Y2e+E0dI11n+Oqlm+/KQyu2LA0ghx9uYH+HdYazqVvYy+dUByTn7AQwY1mMLh7A7r0GX2KMqgam1NiD0CRZeEE5XjdWkIZBfH5ssN8D4QEQ==
Received: from corvink-nb.c.koehne.headscale.beckhoff.dev (172.17.61.20) by
 ex04.beckhoff.com (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 15:54:50 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 6/7] vfio/igd: don't set stolen memory size to zero
Date: Thu, 22 Aug 2024 15:54:15 +0200
Message-ID: <20240822135420.58849-6-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822111819.34306-1-c.koehne@beckhoff.com>
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.61.20]
X-ClientProxiedBy: ex04.beckhoff.com (172.17.5.170) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

=EF=BB=BFThe stolen memory is required for the GOP (EFI) driver and the Win=
dows
driver. While the GOP driver seems to work with any stolen memory size,
the Windows driver will crash if the size doesn't match the size
allocated by the host BIOS. For that reason, it doesn't make sense to
overwrite the stolen memory size. It's true that this wastes some VM
memory. In the worst case, the stolen memory can take up more than a GB.
However, that's uncommon. Additionally, it's likely that a bunch of RAM
is assigned to VMs making use of GPU passthrough.

Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 84b0ec3139..122432e6a6 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -477,6 +477,23 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, in=
t nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
=20
+static int igd_get_stolen_mb(int gen, uint32_t gmch)
+{
+    int gms;
+
+    if (gen < 8) {
+        gms =3D (gmch >> 3) & 0x1f;
+    } else {
+        gms =3D (gmch >> 8) & 0xff;
+    }
+
+    if (gms > 0x10) {
+        error_report("Unsupported IGD GMS value 0x%x", gms);
+        return 0;
+    }
+    return gms * 32;
+}
+
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom =3D NULL;
@@ -654,23 +671,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, in=
t nr)
         ggms_mb =3D 1 << ggms_mb;
     }
=20
-    /*
-     * Assume we have no GMS memory, but allow it to be overridden by devi=
ce
-     * option (experimental).  The spec doesn't actually allow zero GMS wh=
en
-     * when IVD (IGD VGA Disable) is clear, but the claim is that it's unu=
sed,
-     * so let's not waste VM memory for it.
-     */
-    gmch &=3D ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
-
-    if (vdev->igd_gms) {
-        if (vdev->igd_gms <=3D 0x10) {
-            gms_mb =3D vdev->igd_gms * 32;
-            gmch |=3D vdev->igd_gms << (gen < 8 ? 3 : 8);
-        } else {
-            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
-            vdev->igd_gms =3D 0;
-        }
-    }
+    gms_mb =3D igd_get_stolen_mb(gen, gmch);
=20
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
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




