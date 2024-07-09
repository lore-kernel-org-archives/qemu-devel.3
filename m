Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1193C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR5Z0-0003Oh-VB; Tue, 09 Jul 2024 03:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sR5Ys-0003Lv-IZ; Tue, 09 Jul 2024 03:46:54 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sR5Yo-0007Og-0S; Tue, 09 Jul 2024 03:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1720511202;
 bh=svssnq9L/GtEkHAa8qP3Wtv9yK9KEi9+sjyIX1j22FI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HlVgl8i8bHI15vo0BnkU9MFpKr4qPFgCEjh8RdyzEbgRS0XYBUYnuk6p5oObkyqJ3
 B2npwXUut/0tRDp13qygCn+ihZ7WQ8K99QWq3CSV0jhz2AR0H2/Eil/4iqIxQZN0kJ
 RivukFWtG0x3+mD/4ocyr7p6eweJcEWzQvHyvTlmx+fYAiCVR9vZP/l0uLcq5SipX7
 T4tGhah6h9LZtrweKOlTOTTDL4kLr/mqSiMo8mlYMy1inC3Nm+4vvCmbcv1QpztDQo
 mHXpVAQZ9corCr4UG8r4WvzMM5zPL/7VVXjujm3JCducD2CZk5IBSDYwwdIsL2o4js
 T2uGDROtBnYOw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4WJCjt3fjxz4xPy; Tue,  9 Jul 2024 17:46:42 +1000 (AEST)
Date: Tue, 9 Jul 2024 17:41:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
Message-ID: <ZozprueD159bjo0Q@zatzit>
References: <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
 <CAFEAcA-QyGWNqS5saqGMc9f4WVS5mg8+YjUfOczovaT6duZAvQ@mail.gmail.com>
 <ZonXSmp9XZxl_HHp@zatzit> <D2JZR5EF6CF1.1DDFFT4TZAD1H@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F3ssdQW31XzY+b21"
Content-Disposition: inline
In-Reply-To: <D2JZR5EF6CF1.1DDFFT4TZAD1H@gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--F3ssdQW31XzY+b21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 05:49:32PM +1000, Nicholas Piggin wrote:
> On Sun Jul 7, 2024 at 9:46 AM AEST, David Gibson wrote:
> > On Sat, Jul 06, 2024 at 11:37:08AM +0100, Peter Maydell wrote:
> > > On Fri, 5 Jul 2024 at 06:13, David Gibson <david@gibson.dropbear.id.a=
u> wrote:
> > > >
> > > > On Fri, Jul 05, 2024 at 02:40:19PM +1000, Nicholas Piggin wrote:
> > > > > On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
> > > > > > On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> > > > > > > On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > > > > > > > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dr=
opbear.id.au> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell w=
rote:
> > > > > > > > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.od=
aki@daynix.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.co=
m>
> > > > > > > > > > > ---
> > > > > > > > > > >  hw/ppc/vof.c | 2 +-
> > > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > > > > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > > > > > > > --- a/hw/ppc/vof.c
> > > > > > > > > > > +++ b/hw/ppc/vof.c
> > > > > > > > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_availab=
le(void *fdt, GArray *claimed, uint64_t base)
> > > > > > > > > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &pr=
oplen);
> > > > > > > > > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint3=
2_t) * (ac + sc));
> > > > > > > > > > >      if (sc =3D=3D 2) {
> > > > > > > > > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_=
reg + sizeof(uint32_t) * ac));
> > > > > > > > > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint=
32_t) * ac);
> > > > > > > > > > >      } else {
> > > > > > > > > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_=
reg + sizeof(uint32_t) * ac));
> > > > > > > > > > >      }
> > > > > > > > > >
> > > > > > > > > > I did wonder if there was a better way to do what this =
is doing,
> > > > > > > > > > but neither we (in system/device_tree.c) nor libfdt see=
m to
> > > > > > > > > > provide one.
> > > > > > > > >
> > > > > > > > > libfdt does provide unaligned access helpers (fdt32_ld() =
etc.), but
> > > > > > > > > not an automatic aligned-or-unaligned helper.   Maybe we =
should add that?
> > > > > > > >
> > > > > > > > fdt32_ld() and friends only do the "load from this bit of m=
emory"
> > > > > > > > part, which we already have QEMU utility functions for (and=
 which
> > > > > > > > are this patch uses).
> > > > > > > >
> > > > > > > > This particular bit of code is dealing with an fdt property=
 ("memory")
> > > > > > > > that is an array of (address, size) tuples where address an=
d size
> > > > > > > > can independently be either 32 or 64 bits, and it wants the
> > > > > > > > size value of tuple 0. So the missing functionality is some=
thing at
> > > > > > > > a higher level than fdt32_ld() which would let you say "giv=
e me
> > > > > > > > tuple N field X" with some way to specify the tuple layout.=
 (Which
> > > > > > > > is an awkward kind of API to write in C.)
> > > > > > > >
> > > > > > > > Slightly less general, but for this case we could perhaps h=
ave
> > > > > > > > something like the getprop equivalent of qemu_fdt_setprop_s=
ized_cells():
> > > > > > > >
> > > > > > > >   uint64_t value_array[2];
> > > > > > > >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &va=
lue_array,
> > > > > > > >                                ac, sc);
> > > > > > > >   /*
> > > > > > > >    * fills in value_array[0] with address, value_array[1] w=
ith size,
> > > > > > > >    * probably barfs if the varargs-list of cell-sizes doesn=
't
> > > > > > > >    * cover the whole property, similar to the current asser=
t on
> > > > > > > >    * proplen.
> > > > > > > >    */
> > > > > > > >   mem0_end =3D value_array[0];
> > > > > > >
> > > > > > > Since 4/8 byte cells are most common and size is probably
> > > > > > > normally known, what about something simpler to start with?
> > > > > >
> > > > > > Hrm, I don't think this helps much.  As Peter points out the ac=
tual
> > > > > > load isn't really the issue, it's locating the right spot for i=
t.
> > > > >
> > > > > I don't really see why that's a problem, it's just a pointer
> > > > > addition - base + fdt_address_cells * 4. The problem was in
> > > >
> > > > This is harder if #address-cells and #size-cells are different, or =
if
> > > > you're parsing ranges and #address-cells is different between parent
> > > > and child node.
> > > >
> > > > > the memory access (yes it's fixed with the patch but you could
> > > > > add a general libfdt way to do it).
> > > >
> > > > Huh.. well I'm getting different impressions of what the problem
> > > > actually is from what I initially read versus Peter Maydell's
> > > > comments, so I don't really know what to think.
> > > >
> > > > If it's just the load then fdt32_ld() etc. already exist.  Or is it
> > > > really such a hot path that unconditionally handling unaligned
> > > > accesses isn't tenable?
> > >=20
> > > The specific problem here is that the code as written tries to
> > > cast a not-aligned-enough pointer to uint64_t* to do the load,
> > > which is UB.
> >
> > Ah... and I'm assuming it's the cast itself which triggers the UB, not
> > just dereferencing it.
>=20
> Oh it's just the cast itself that is UB? Looks like that's true.
> Interesting gcc and clang don't flag it, I guess they care about
> warning on practical breakage first.
>=20
> > Which makes the interface of fdt32_ld()
> > etc. unusable for their intended purpose.  Well.. damn.  Now... how do
> > I fix it without breaking compatibility any more than I have to.
>=20
> Why not just make them take a void * ptr? I don't think that would
> break anything but existing code that was forced to add the cast
> may be at risk of the UB.

That works if recompiling, but I believe it's an ABI change.
Typically library users would get these functions as inlines, but I
believe it's not impossible something could have taken function
pointers to them and get versions from the shared library.

Or... maybe it's not possible, since these aren't listed our
version.lds.  Ugh.

Given the current state is something basically impossible to use
without UB, wearing an ABI breakage might be the lesser evil.

> Could also add fdt64_unaligned_t types with aligned(1) attribute
> for new code. Those can just be dereferenced directly and the
> caller the compiler can choose the appropriate access supported by
> the host. (Actually gcc can recognise that load unaligned and
> byteswap pattern and do the same anyway, but clang at least can
> not yet).

That might be a nice idea, but doesn't solve the immediate versioning
problem.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--F3ssdQW31XzY+b21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmaM6aoACgkQzQJF27ox
2Gev2A//Zov/mt5KSfrJ4R8Kto2lUxGc12+M7TPdsfre4JL6hoOqI76/jZIiJKE2
OZFP9sHRB7L4cESocnHTapbap6OCFM+230nMnwCik3C5xQ7tGQCU/+nNP+sOstH8
Ie0NPXP3WXap+mQgtewX/Uxu8FKSL8uQYoLZM5Lwd/9F+KNjlpqcdjZhW4WiNXcG
1FryMHhRtwcuCG8WnNneHaFonWn0Rgme4aJ+g2XHYTcBi2BgPgyDY6l1sQqG+f9r
OPS9DcISUjBoqnbB4BGeyFgPvNbQrfR0t3ixsmb9mHOFtj6RaNSbkW2cnH0wRYJT
Q8eMZTJlpyaree1kIUIHpaNjy5/ii03FxoWCMEBIUSmYtdk3F+KG+7teC0QxaWkp
X3Rw/vMvSIKtJH8p5c3dXDf5GUPxIfd4q8LAKvFVXAlsKQpMpCsHfIPLwhVX/XOi
yoXnspePtcedX3l5NXE/Hc+4z7TWhqFQNpu5S8N+54xf7/FiqIOPMxlf1+FJQ5mt
ZOsHneNjF7nZTJYrhmfmkxBc2jK3cXnkJpNACaGKsJE6A2JJUfexvv+Sw49tKO3y
3E3sV+WuvXwQeucCpmJOf7oejQHiM2vW8MNdP56MxWUL72nHmLPMb5OsIkqftX7Q
jmW5mrsO+88uioJiUKzGix6wWFOzlddKt/RicT0z/I/RP+s00lk=
=tvOP
-----END PGP SIGNATURE-----

--F3ssdQW31XzY+b21--

