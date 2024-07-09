Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9546AC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR5Z4-0003RD-S5; Tue, 09 Jul 2024 03:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sR5Yu-0003Nl-33; Tue, 09 Jul 2024 03:46:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sR5Yq-0007Oj-MX; Tue, 09 Jul 2024 03:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1720511202;
 bh=0h0Q72GUmfh/c4838TYp4OUUee9ueAOroICMvfyaeEk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mS+wE7ulOHQBFgcOv9hApdFanh61QdFFjGnoHel631SLC2lODxtY7n3pzmpUdv5nm
 Yb9XdGkLjz8GwVefs+UT8ZzOoCupMbQ2G5sl7idTDbJdN/EL9dCHUW3uk/sgM3n/8+
 5FIAS5+wnjKsLfxSYgJqXvWZec+WS/kRv2bSsCWGVXQerxSFm3FJex4ccSyRlUafp+
 Fyagg9KsgVtw7Ur5po7R+imPy7txqPbdeDD0YveN25UclfBtYImTOWb3w5OgLzaf6E
 qHQFLwiJafA/wKvSPULW1a5W6fphLsegQw+hJVC/BOY6D6hh4fU2Nmzfg9gzw+a7r6
 YZqxxjACiWcbA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4WJCjt3qNbz4xPc; Tue,  9 Jul 2024 17:46:42 +1000 (AEST)
Date: Tue, 9 Jul 2024 17:46:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
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
Message-ID: <Zozq33YdKd6pGUtZ@zatzit>
References: <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
 <CAFEAcA-QyGWNqS5saqGMc9f4WVS5mg8+YjUfOczovaT6duZAvQ@mail.gmail.com>
 <ZonXSmp9XZxl_HHp@zatzit> <D2JZR5EF6CF1.1DDFFT4TZAD1H@gmail.com>
 <CAFEAcA9L+ApvH8bptyEi2C7fg=WPYLZecAUBv6mpx0o1-3K2=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8bAhviUwxguhI0sd"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9L+ApvH8bptyEi2C7fg=WPYLZecAUBv6mpx0o1-3K2=w@mail.gmail.com>
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


--8bAhviUwxguhI0sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 04:59:30PM +0100, Peter Maydell wrote:
> On Mon, 8 Jul 2024 at 08:49, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Sun Jul 7, 2024 at 9:46 AM AEST, David Gibson wrote:
> > > On Sat, Jul 06, 2024 at 11:37:08AM +0100, Peter Maydell wrote:
> > > > On Fri, 5 Jul 2024 at 06:13, David Gibson <david@gibson.dropbear.id=
=2Eau> wrote:
> > > > > Huh.. well I'm getting different impressions of what the problem
> > > > > actually is from what I initially read versus Peter Maydell's
> > > > > comments, so I don't really know what to think.
> > > > >
> > > > > If it's just the load then fdt32_ld() etc. already exist.  Or is =
it
> > > > > really such a hot path that unconditionally handling unaligned
> > > > > accesses isn't tenable?
> > > >
> > > > The specific problem here is that the code as written tries to
> > > > cast a not-aligned-enough pointer to uint64_t* to do the load,
> > > > which is UB.
> > >
> > > Ah... and I'm assuming it's the cast itself which triggers the UB, not
> > > just dereferencing it.
> >
> > Oh it's just the cast itself that is UB? Looks like that's true.
> > Interesting gcc and clang don't flag it, I guess they care about
> > warning on practical breakage first.
>=20
> Er, I was speaking a bit vaguely there, don't take my word for
> it without going and looking at the text of the C standard.

Sure.

> What I *meant* was that the practical problem here is that we
> really do dereference a pointer for a 64-bit load when the
> pointer isn't necessarily 64-bit-aligned.

=46rom the qemu point of view, yes.  And theoretically, the fix is easy,
since libfdt provides fdt32_ld() etc. for exactly this use case.  But..

> As it happens, C99 says that it is the cast that is UB:
> section 6.3.2.3 para 7 says:
>  "A pointer to an object or incomplete type may be converted to
>   a pointer to a different object or incomplete type. If the
>   resulting pointer is not correctly aligned for the pointed-to
>   type, the behavior is undefined. Otherwise, when converted back
>   again, the result shall compare equal to the original pointer."

=2E. this makes fdt32_ld() etc. unusable by design.

> Presumably this is envisaging the possibility of a pointer cast
> being a destructive operation somehow, such that e.g. a uint64_t*
> can only represent 64-bit-aligned values. But I bet QEMU does
> a lot of casting pointers around that might fall foul of this
> rule, so I'm not particularly worried about trying to clean up
> that kind of thing (until/unless analysers start warning about
> it, in which case we have a specific set of things to clean up).

Fair enough from the qemu point of view.  However, this unusable by
design interface was written by me as part of a library I maintain, so
it certainly worries *me*.

> What I care about from the point of view of this patch
> is that we fix the actually-broken-on-some-real-hardware problem
> of doing the load as a misaligned access. My vote would be for
> "take Akihiko's patch as-is, rather than gating fixing the bug
> on deciding on an improvement/change to the fdt API or our
> wrappers of it".
>=20
> thanks
> -- PMM
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--8bAhviUwxguhI0sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmaM6t4ACgkQzQJF27ox
2Gd67w//RbXjzTPyMisJ+Fn1jAW0vvt8NSGSxt0U93c3voCYBHgKeowEf1nJz46U
IVtRlBK7S6eGmWYXDUX8UBica7aaRaPbeASisCBnhTTEDK3J4yGRt988QqU3/3SH
V5YzOOyEobDJpQmPvAt5eJTsndP8z8HEEU+06KtnorBfVGvWUE8xONbwHXQGV4CZ
VkEl1pPGiRyTupyI1f1gXAOrAI112TxQ0nsctvtKNUue2wBeWSXzqqRDzlphgS/K
OMi3MXg2KmY0vf/fUsonj5YSPbY+f8MWga24m0Rgw2+FciN1vpZ4hnDZ2BWRdR4O
ROsqTiwOR+OZasPZBWz/Fuff7hfa+Ug39yl3uNwvCQVcsxUPMhNlTGsAo7cRP6D9
luSdoWSOPpZ+2p9z5AUJkZpmGyuUSd1GLI+DUo78wHCmYE0+b5o5kpwrmGmlHJJk
tw5E65t8SYqInRFxIW7OQfLhaBslpW1dML31ItoB1XZTfAq+uDMXdH5sjxTbB3Xc
hPBd1y4IQJd629oqmE7sN04ZGtaJBWaUSRiQlvFl/tWoWP5eSaAZAzcTAOcnYYp8
B4CJZcc2R5akA1BTDMKCdkQJfiG7ENpKurZBM8zwdV9GTUm0NiqEagPoKJH6fbYl
ap9U4Dyv3dMg99zGzUIVuM4NgtxapWiV49Nl4uomwN2LlaSL+3w=
=DCX/
-----END PGP SIGNATURE-----

--8bAhviUwxguhI0sd--

