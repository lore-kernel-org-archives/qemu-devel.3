Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09000D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7BA-0008Fl-JV; Mon, 02 Dec 2024 09:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2WH-0008G4-Rr
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:15:06 -0500
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2WF-0007MN-Hy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:15:05 -0500
Received: from 172.17.5.173 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 02 Dec 2024 09:10:02 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733130602; bh=EFszqXZEbq+1YP8gTXbqB8hO9mR5b8GaLY5KoQMCmqU=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 SOZe2/GSvFjMITWIFaq5m+UhTqY+71dwBzoik5l9VYxgPwy/5pp+5IVowJpqgrEFvVd80CVQJOiHXILizTm4CQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733130602; bh=EFszqXZEbq+1YP8gTXbqB8hO9mR5b8GaLY5KoQMCmqU=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 KByznabZoBUqEGnqOdL0R7rsr+SolCP6JtT+qYi0MfZSsTn0s7Bf6iCe8eL9UE/uVbDkRcg3Uz6lHzUlFY6tC8w3D0qkwQYDY5eSyHA6qgLywPaTSI0ebg0cCuTh+NpV2g1Yy6vpJdU5rVVBgrYYTwCs5HsMJ9FvliwNCCHsHSrE0YGeumS7nQCySQEV/tVPdnIUiGe+uiZR/wQQBtR2+Ivg/qT7yzynN64QBskSwC+IwJlQoYvoc+MIfBJZZKSCiUup+gAbfGDehZUz0IAqbjmtD3Ov/1epFLMIRhHuvlxAsgkbXLAmtnFeGBzRS8IaiQe2/oKpuGj8hL3VPiDGKA==
Received: from ex04.beckhoff.com (172.17.5.170) by ex08.beckhoff.com
 (172.17.5.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Dec
 2024 10:10:00 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Mon, 2 Dec 2024 10:10:00 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/8] vfio/igd: canonicalize memory size calculations
Thread-Topic: [PATCH 2/8] vfio/igd: canonicalize memory size calculations
Thread-Index: AQHbRAt1kQe/tija70mTGY/VpdiWyLLSXT+AgAA91AA=
Date: Mon, 2 Dec 2024 09:10:00 +0000
Message-ID: <c5e8fbe268e344d03b63e94c440da965121bfb98.camel@beckhoff.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-3-tomitamoeko@gmail.com>
 <20241201222843.6f415e29.alex.williamson@redhat.com>
In-Reply-To: <20241201222843.6f415e29.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [87.122.28.117]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-PVpTIw0wOkWfJbz55QWU"
MIME-Version: 1.0
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Dec 2024 09:13:31 -0500
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

--=-PVpTIw0wOkWfJbz55QWU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2024-12-01 at 22:28 -0700, Alex Williamson wrote:
> CAUTION: External Email!!
> On Mon,=C2=A0 2 Dec 2024 00:09:32 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>=20
> > Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
> > calculating GTT stolen memory and Data stolen memory size in bytes,
> > and use macros to replace the hardware-related magic numbers for
> > better readability.
> >=20
> > Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> > ---
> > =C2=A0hw/vfio/igd.c | 101 ++++++++++++++++++++++++++++-----------------=
--
> > ---
> > =C2=A01 file changed, 57 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index e40e601026..b449316ec0 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -116,6 +116,54 @@ typedef struct VFIOIGDQuirk {
> > =C2=A0#define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
> > =C2=A0#define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen =
11
> > and later */
> > =C2=A0
> > +#define IGD_GMCH_GEN6_GMS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 3
> > +#define IGD_GMCH_GEN6_GMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1f
> > +#define IGD_GMCH_GEN6_GGMS_SHIFT=C2=A0=C2=A0=C2=A0 8
> > +#define IGD_GMCH_GEN6_GGMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0 0x3
> > +#define IGD_GMCH_GEN8_GMS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 8
> > +#define IGD_GMCH_GEN8_GMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xff
> > +#define IGD_GMCH_GEN8_GGMS_SHIFT=C2=A0=C2=A0=C2=A0 6
> > +#define IGD_GMCH_GEN8_GGMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0 0x3
> > +

You should consider reusing the names used by Linux [1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/drm/intel/i915_drm.h?h=3Dv6.12#n50

> > +static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
> > +{
> > +=C2=A0=C2=A0=C2=A0 uint64_t ggms;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (gen < 8) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> IGD_GMCH_=
GEN6_GGMS_SHIFT) &
> > IGD_GMCH_GEN6_GGMS_MASK;
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> IGD_GMCH_=
GEN8_GGMS_SHIFT) &
> > IGD_GMCH_GEN8_GGMS_MASK;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms *=3D 2;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 return ggms * MiB;
> > +}
> > +
> > +static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
> > +{
> > +=C2=A0=C2=A0=C2=A0 uint64_t gms;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (gen < 8) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> IGD_GMCH_G=
EN6_GMS_SHIFT) &
> > IGD_GMCH_GEN6_GMS_MASK;
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> IGD_GMCH_G=
EN8_GMS_SHIFT) &
> > IGD_GMCH_GEN8_GMS_MASK;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 if (gen < 9) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms < 0x10) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn gms * 32 * MiB;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> igd_get_stolen_mb() used:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms > 0x10) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_=
report("Unsupported IGD GMS value 0x%x", gms);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gms * 32;
>=20
> Therefore this should use <=3D to be equivalent.

I'd personally prefer moving the code in one commit and change the
format in a second one.

If you want to touch this, I'd align it with Linux, which multiplies gms
by 32 MB unconditionally for gen 6 and 8 [1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/kernel/early-quirks.c?h=3Dv6.12#n404

> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms < 0xf0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn gms * 32 * MiB;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn (gms - 0xf0 + 1) * 4 * MiB;
>=20
> This does not match the line from igd_get_stolen_mb():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 (gms - 0xf0) * 4 + 4;
>=20
> Explain.
>=20

I've chosen the current format because it aligns with Linux [1]. I would
keep it as is to make it easier to sync with Linux.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/kernel/early-quirks.c?h=3Dv6.12#n460

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 error_report("Unsupported IGD GMS value 0x%lx", gms=
);
> > +=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > =C2=A0
> > =C2=A0/*
> > =C2=A0 * The rather short list of registers that we copy from the host
> > devices.
> > @@ -264,17 +312,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice
> > *vdev,
> > =C2=A0static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t gmch =3D vfio_pci_read_config(&vdev->=
pdev, IGD_GMCH,
> > sizeof(gmch));
> > -=C2=A0=C2=A0=C2=A0 int ggms, gen =3D igd_gen(vdev);
> > -
> > -=C2=A0=C2=A0=C2=A0 gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_GMCH=
,
> > sizeof(gmch));
> > -=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> > -=C2=A0=C2=A0=C2=A0 if (gen > 7) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D 1 << ggms;
> > -=C2=A0=C2=A0=C2=A0 }
> > -
> > -=C2=A0=C2=A0=C2=A0 ggms *=3D MiB;
> > +=C2=A0=C2=A0=C2=A0 int gen =3D igd_gen(vdev);
> > +=C2=A0=C2=A0=C2=A0 uint64_t ggms_size =3D igd_gtt_memory_size(gen, gmc=
h);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 return (ggms / (4 * KiB)) * (gen < 8 ? 4 : 8);
> > +=C2=A0=C2=A0=C2=A0 return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
> > =C2=A0}
> > =C2=A0
> > =C2=A0/*
> > @@ -481,30 +522,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice
> > *vdev, int nr)
> > =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quir=
k, next);
> > =C2=A0}
> > =C2=A0
> > -static int igd_get_stolen_mb(int gen, uint32_t gmch)
> > -{
> > -=C2=A0=C2=A0=C2=A0 int gms;
> > -
> > -=C2=A0=C2=A0=C2=A0 if (gen < 8) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> 3) & 0x1f;
> > -=C2=A0=C2=A0=C2=A0 } else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> 8) & 0xff;
> > -=C2=A0=C2=A0=C2=A0 }
> > -
> > -=C2=A0=C2=A0=C2=A0 if (gen < 9) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms > 0x10) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report("Unsupported IGD GMS value 0x%x", gms);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 0;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gms * 32;
> > -=C2=A0=C2=A0=C2=A0 } else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms < 0xf0)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn gms * 32;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn (gms - 0xf0) * 4 + 4;
> > -=C2=A0=C2=A0=C2=A0 }
> > -}
> > -
> > =C2=A0void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 g_autofree struct vfio_region_info *rom =3D NU=
LL;
> > @@ -514,7 +531,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
> > *vdev, int nr)
> > =C2=A0=C2=A0=C2=A0=C2=A0 VFIOQuirk *quirk;
> > =C2=A0=C2=A0=C2=A0=C2=A0 VFIOIGDQuirk *igd;
> > =C2=A0=C2=A0=C2=A0=C2=A0 PCIDevice *lpc_bridge;
> > -=C2=A0=C2=A0=C2=A0 int i, ret, ggms_mb, gms_mb =3D 0, gen;
> > +=C2=A0=C2=A0=C2=A0 int i, ret, gen;
> > +=C2=A0=C2=A0=C2=A0 uint64_t ggms_size, gms_size;
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *bdsm_size;
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t gmch;
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint16_t cmd_orig, cmd;
> > @@ -676,13 +694,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
> > *vdev, int nr)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quir=
k, next);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 /* Determine the size of stolen memory needed for G=
TT */
> > -=C2=A0=C2=A0=C2=A0 ggms_mb =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> > -=C2=A0=C2=A0=C2=A0 if (gen > 7) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms_mb =3D 1 << ggms_mb;
> > -=C2=A0=C2=A0=C2=A0 }
> > -
> > -=C2=A0=C2=A0=C2=A0 gms_mb =3D igd_get_stolen_mb(gen, gmch);
> > +=C2=A0=C2=A0=C2=A0 ggms_size =3D igd_gtt_memory_size(gen, gmch);
> > +=C2=A0=C2=A0=C2=A0 gms_size =3D igd_stolen_memory_size(gen, gmch);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Request reserved memory for stolen mem=
ory via fw_cfg.=C2=A0 VM
> > firmware
> > @@ -693,7 +706,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
> > *vdev, int nr)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * config offset 0x5C.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size =3D g_malloc(sizeof(*bdsm_size));
> > -=C2=A0=C2=A0=C2=A0 *bdsm_size =3D cpu_to_le64((ggms_mb + gms_mb) * MiB=
);
> > +=C2=A0=C2=A0=C2=A0 *bdsm_size =3D cpu_to_le64(ggms_size + gms_size);
> > =C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-s=
ize",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size, sizeof(*bdsm=
_size));
> > =C2=A0
> > @@ -744,5 +757,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
> > *vdev, int nr)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev-
> > >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAAD3YuKN4_e
> > If2wAAADsWKVxcuZtvheRgRqIemuzgT-OABVjIqlMqKN-
> > EU30bxV28qXZ_Y5_SMs0YfH8q_KtHOPLp1QG1mJuzWERjIVCEePSftEKzXou_Qr3jboY
> > Ii_VUdvptqZTIPyfY-GJ9iOrnUrKoc_oifOB9wY1=C2=A0);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_bdsm_enabled(vdev-
> > >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAAD3YuKN4_e
> > If2wAAADsWKVxcuZtvheRgRqIemuzgT-OABVjIqlMqKN-
> > EU30bxV28qXZ_Y5_SMs0YfH8q_KtHOPLp1QG1mJuzWERjIVCEePSftEKzXou_Qr3jboY
> > Ii_VUdvptqZTIPyfY-GJ9iOrnUrKoc_oifOB9wY1=C2=A0, ggms_mb + gms_mb);
> > +=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_bdsm_enabled(vdev-
> > >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAAD3YuKN4_e
> > If2wAAADsWKVxcuZtvheRgRqIemuzgT-OABVjIqlMqKN-
> > EU30bxV28qXZ_Y5_SMs0YfH8q_KtHOPLp1QG1mJuzWERjIVCEePSftEKzXou_Qr3jboY
> > Ii_VUdvptqZTIPyfY-GJ9iOrnUrKoc_oifOB9wY1=C2=A0, *bdsm_size / MiB);
>=20
> Technically this should use le64_to_cpu(*bdsm_size), or retain the
> addition logic.=C2=A0 Thanks,
>=20
> Alex

--=20
Kind regards,
Corvin
disable-disclaimer-BADE




--=-PVpTIw0wOkWfJbz55QWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdNeWgACgkQ2FTaVjFe
AmqmZg//RthBmxV3durOnCcYgtOPDEjUrp7LIPxu+AUaLm3OiC2MOXZoOQhGdZ8B
LeQQm71uc2jxjX74XAA7cspSlS3W0XV1dpkiKuni4rkP3esCL9bOVgEjrf25Qr6m
x4FJk1cQeLUHGMZYrJTrOPNSFPHp2b0crw301XrrQhhfkjM6qoFPnSorxZFWjSLm
54rPENW6Ue2OtaPRPte2rCKNamlo1IHvjF9gKHig61iPSNLsNy69DUzjS17eHsth
oZmfvYzZxBzJMxvmnGKjJI+ptVG2q5ejIS0HTTPXbguXLON5uQzkR6T1/HIbwVPJ
ZjwAiC02Tk043/dgh3EXBtUzz+qiKEG7MnLe987R2qzloLivqJ5WifxCtEM8Fgkc
dUkAA92aFeryxmGXU0TYxIbQgPo1sxvpApvY39WISb54bbrql+sirmnp50aaaWbR
YdnD6A9uZCjnD/dGUTzystnQplmOm7YglYmpk3sUxcyHCeaz71NZ4saCtd8fHPIF
aXf3xIG2UCDAdXzHmJqPHbIAweV4kIT7622rJeXltGgG0prNOZGU13CPYrxRPYx1
T51jzdHaVhyW2kr/3yLKlbpsycIAw5bmpaIOawE46PjAeGMagkkvGXkH+Eh3hgEu
QCPJtLH/oF+dmlsIL3v7309JPmh0HuxCFhYTSNrjJ0rJoZNSCKk=
=Kany
-----END PGP SIGNATURE-----

--=-PVpTIw0wOkWfJbz55QWU--


