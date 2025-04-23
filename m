Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2945C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7U8O-0005hU-Ed; Wed, 23 Apr 2025 03:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7U8L-0005hB-VT
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:03:02 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7U8G-0006pR-EL
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:03:01 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1745391472; bh=/PGDUniSrtOm6utcFhqDk8SiGEVbI1s09kfdMtmvt8g=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 w97YX5aKjln7apJOJ4UM4j4DM9a3HuITASPfTYSpcskckjuo0RBZtb2oraDVYzL1DLLhwrZggmlrJB+Gy5pFAQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1745391472; bh=/PGDUniSrtOm6utcFhqDk8SiGEVbI1s09kfdMtmvt8g=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 F+BiA9ATgDL7qfuhmYkvCIenu+epAYHYtMS2Rx5Fqtr1YUgCBpg88wU69SpLNW1P1mD9/kw93CoZ1frOZoqI9nxE4WphL8q1oy0XGuxInsNj5+TvIhdz9N6eGgiGVxsXCUUikmB+12292DFsJAwGVozOXhlnpDK/7jBmaCdV9ym+ba+4ajcmeUam0+EaYTsbGu6cdW0eiGr7s3pxsgwDep1GfpjGuC89Dxa/BIp4JIiNRyweo8GN1x1TgMhqSq5m1KqniI2fg753oFMfitrG2TeIxjMviK/bLJnAdwNBb/Lfp9nfTjPqVewOA4qMKFFlg6m6uIADSrDgkF0+Wog5Tw==
Received: from 172.17.6.19 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Wed, 23 Apr 2025 06:57:52 GMT
Received: from ex06.beckhoff.com (172.17.5.171) by ex13.beckhoff.com
 (172.17.6.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Apr
 2025 08:54:35 +0200
Received: from ex04.beckhoff.com (172.17.5.170) by ex06.beckhoff.com
 (172.17.5.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 08:54:34 +0200
Received: from ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3]) by
 ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3%6]) with mapi id
 15.01.2507.039; Wed, 23 Apr 2025 08:54:34 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 03/11] vfio/igd: Detect IGD device by OpRegion
Thread-Topic: [PATCH 03/11] vfio/igd: Detect IGD device by OpRegion
Thread-Index: AQHbstrwheP94VaG+kiRYR+rLqiOH7OwseWA
Date: Wed, 23 Apr 2025 06:54:34 +0000
Message-ID: <0da35fa206f66ecd2d3a94b4c79f462284547164.camel@beckhoff.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-4-tomitamoeko@gmail.com>
In-Reply-To: <20250421163112.21316-4-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-R2oxuKJJXuxCuJ+P4H9a"
MIME-Version: 1.0
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--=-R2oxuKJJXuxCuJ+P4H9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-22 at 00:31 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> There is currently no straightforward way to distinguish if a Intel
> graphics device is IGD or discrete GPU. However, only IGD devices expose
> OpRegion. Use the presence of VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION
> to identify IGD devices.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 26 ++++++++++++++++++--------
> =C2=A01 file changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 36316e50ea..7a7c7735c1 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -479,6 +479,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0
> =C2=A0static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **=
errp)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 g_autofree struct vfio_region_info *opregion =3D NULL=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret, gen;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t gms_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *bdsm_size;
> @@ -486,16 +487,20 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 bool legacy_mode_enabled =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0=C2=A0 * This must be an Intel VGA device at address 0=
0:02.0 for us to even
> -=C2=A0=C2=A0=C2=A0=C2=A0 * consider enabling legacy mode.=C2=A0 The vBIO=
S has dependencies on the
> -=C2=A0=C2=A0=C2=A0=C2=A0 * PCI bus address.
> -=C2=A0=C2=A0=C2=A0=C2=A0 */

Why do you remove this comment? Yes, the comment is not correct. Some OS dr=
iver
and the UEFI GOP depend on address 00:02.0 too. Wouldn't it be better to im=
prove
the comment instead of removing it? This restriction looks a bit odd and IM=
O a
comment would help future reader to understand it easier.=20

> =C2=A0=C2=A0=C2=A0=C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_=
ANY_ID) ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_is_vga(vdev)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /* IGD device always comes with OpRegion */
> +=C2=A0=C2=A0=C2=A0 ret =3D vfio_device_get_region_info_type(&vdev->vbase=
dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_REGION_TYPE_PCI_VENDOR_TYPE=
 | PCI_VENDOR_ID_INTEL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_REGION_SUBTYPE_INTEL_IGD_OP=
REGION, &opregion);
> +=C2=A0=C2=A0=C2=A0 if (ret) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 info_report("OpRegion detected on Intel display %x.",=
 vdev->device_id);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * IGD is not a standard, they like to chan=
ge their specs often.=C2=A0 We
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * only attempt to support back to SandBrid=
ge and we hope that newer
> @@ -570,9 +575,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Setup OpRegion access */
> -=C2=A0=C2=A0=C2=A0 if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGIO=
N) &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_pci_igd_setup_opregion(=
vdev, errp)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
> +=C2=A0=C2=A0=C2=A0 if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGIO=
N)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vdev->pdev.qdev.hotplugge=
d) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error=
_setg(errp, "OpRegion is not supported on hotplugged
> device");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
error;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vfio_pci_igd_opregion_in=
it(vdev, opregion, errp)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
error;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

How is this part related to "Detect IGD device by OpRegion"?

> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Setup LPC bridge / Host bridge PCI IDs */

--=20
Kind regards,
Corvin

--=-R2oxuKJJXuxCuJ+P4H9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgIjqkACgkQ2FTaVjFe
Amrl3g//aVp0edYf3MHh3BgvZCn4E00hkXCvhcSwVA9g5xdlvijfy4QKM1fUFl8O
dww2L0w3HANxkR+5Olvkld8REYMOZrYoJaSEZWy6xAwM8bKilFaFI3G/4hZeAG3c
EnqEdrGxNfVkWDxMCaFOFUWHgg9a+ONzAQEswXTeqNPr97HMmnd+/2P5dO1revyL
ubITCNjTN6lg4Sy8VYs5qAYtplgUtyXT2B2x32+ll/oqri3WYINErEh2Szy64LAn
tgbVd3qujllAH1RPCoj32f3sdhzWCJJKVfgug/OyqTH8mAbIwlUBX2o25lewa/Jl
zkquWL+bWZDvhfL5BK53lp29Z5DM0Eaqx5uZ4+WFmx0Ulr1q1lfQiqFCYbSuocks
mEJFUGZ9YWPoyAkkAlluGCwPd/f7fPM9b+w8TpEe5M/s3oPcFxZLKVqpVrjWhASz
kr13PmXLBZ8cErgNRiaZz2iSywpp5R0Cl9ActbVBdpOdgf3UswXzw4v9B9/Z8gi+
ZmdGvZYvetsw5i1eEigqhXEkoLz+7dt9canC7HU+YQGBXCR/oEuGbexiUdpapOjL
hZx4EIa6IhcJxf8Zc6Dau8ctY606Vp6xgRvdWscCrl4t3sngv+cgyq5/P3eyoiFW
VSR70FKVSQ5pnGrLEmJ0KBoRm8u0YeuhonyszbQC8S7tM9K5bkk=
=/2bC
-----END PGP SIGNATURE-----

--=-R2oxuKJJXuxCuJ+P4H9a--


