Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE948C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 00:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGnxT-0007N8-FI; Sun, 18 May 2025 20:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uGnxQ-0007Md-BV
 for qemu-devel@nongnu.org; Sun, 18 May 2025 20:02:16 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uGnxM-0004u8-1D
 for qemu-devel@nongnu.org; Sun, 18 May 2025 20:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=uldaevi6wbd3beelndtqzflpna.protonmail; t=1747612917; x=1747872117;
 bh=jY9zke4yDMAIPMefXw7rItwJ28YWUP0hz3H8he6S45s=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=OUHX40oHhw+FHhSmfa/zE3MJ43G+z45/BsvM/hUN0EPqFcwDMOGA7kJCl4Z6uN7TW
 24GXnbJHdzqUnDJ9TbOoJI+NOWCani3BHJPeEbgTxT3Cd1iED6jWeJr9XLU/OFX/FX
 bSUPZWV/9NEAsEqAK1IEXVDM74vQUph4+gRpAOUp84ZKn3s6uiQruzQLPT1bnzl9x6
 gQs25307EmsCiV+U4e2zAuLEfsEzv+kseU0DHd4yFDbBEubWzXEUum93iVhB/Bw8YG
 cNGXEnjLpcsuwSjxi725wN45Jw0yK9DXX9pftBXtx9UuvZ4lWYbyNMsrfxoqZ8raaX
 7q50+3II6vtaw==
Date: Mon, 19 May 2025 00:01:52 +0000
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "clg@kaod.org" <clg@kaod.org>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] vfio/igd: Respect x-igd-opregion=off in IGD quirk handling
Message-ID: <6TP1d19UA0waLH71Mea1s2U0yFtyKMpqqf6miU7O44BYZm04F4vOJ5c565O09PliXCbSNJJxuIm0zh2Re-gWa6jo08YraLuPOdebgp30n5M=@proton.me>
In-Reply-To: <20250518171730.1ba5bc31.alex.williamson@redhat.com>
References: <nlfoN7cj2SVJ6LQahdnb_xWG6orCIn4hxHq8JTND4cH2gXCVy9X0KKJkVZdNiG6YmFX-1Qkc_fW2tUwk5LkQcZaJz4Lwy5OpMtaVCK7Tq-E=@protonmail.com>
 <20250518171730.1ba5bc31.alex.williamson@redhat.com>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 6f21b4abfd9cac7ada3732787a1da64162a018b8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139;
 envelope-from=edmund.raile@proton.me; helo=mail-0301.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-to:  "edmund.raile" <edmund.raile@proton.me>
From:  "edmund.raile" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > Restore SR-IOV Intel iGPU VF passthrough capability:
> > Check x-igd-opregion=3Doff parameter in vfio_pci_igd_config_quirk and
> > vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=3Doff is
> > respected despite subsequent attempt of automatic
> > IGD opregion detection.
> >
> > Fixes: 7be29f2f1a3f ("Merge tag 'pull-vfio-20250509' of https://github.=
com/legoater/qemu into staging")
>=20
> Can you bisect to a specific commit from the merge?  The merge may be
> where the issue was introduced to mainline, but the merge commit itself
> is more than likely not the source of the issue.  Thanks,
>=20
> Alex

I have to admit, I have no idea how to pluck apart
that merge pull using git.

But from browsing the repo:
https://github.com/qemu/qemu/compare/master...legoater:qemu:vfio-10.1

If I'd have to guess it would be
b16785f1185d ("vfio/igd: Detect IGD device by OpRegion")
https://github.com/qemu/qemu/commit/b16785f1185d4f35a0313d9a472d75bdbafce22=
1
where it is assumed that "IGD device always comes with OpRegion"
which is not true in the case of SR-IOV virtual function devices,
and the user's choice of `x-igd-opregion=3Doff` should still be
respected, for the parameter to not be redundant.
The default was already changed to x-igd-opregion=3Don in
4574a4490a86 ("vfio/igd: Enable OpRegion by default").
https://github.com/qemu/qemu/commit/4574a4490a865587fd24587bd99067615ea1e9b=
d

> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> > Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
> > ---
> > This patch fixes a regression in QEMU=E2=80=99s VFIO IGD quirk handling=
 that
> > established automatic IGD opregion detection which ignores
> > x-igd-opregion=3Doff necessary for SR-IOV VF passthrough of
> > Intel iGPUs using i915-sriov-dkms.
> >
> > Please review and provide feedback.
> > Let me know if additional testing or changes are needed.
> >
> > Kind regards,
> > Edmund Raile.
> >
> >  hw/vfio/igd.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index e7952d15a0..e54a2a2f00 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -523,6 +523,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevic=
e *vdev, Error **errp)
> >          return true;
> >      }
> >
> > +    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
> > +    if (!vdev->igd_opregion) {
> > +        return true;
> > +    }
> > +
> >      /* IGD device always comes with OpRegion */
> >      if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> >          return true;
> > @@ -689,6 +694,11 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDev=
ice *vdev, Error **errp)
> >          return true;
> >      }
> >
> > +    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
> > +    if (!vdev->igd_opregion) {
> > +        return true;
> > +    }
> > +
> >      /* FIXME: Cherryview is Gen8, but don't support GVT-g */
> >      gen =3D igd_gen(vdev);
> >      if (gen !=3D 8 && gen !=3D 9) {

