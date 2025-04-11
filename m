Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E81DC369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3EJI-00040z-2T; Fri, 11 Apr 2025 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u3EJ4-0003zZ-9l
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:20:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u3EJ1-000828-PY
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:20:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so9657375e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1744377625; x=1744982425; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SFVtRYCu24+twV9jOKPANnIfNqNo8QdaQ2jo2GLBWA0=;
 b=CGW1k11L87uUfdmigWlxWPgzBsRwGFCQBteoxEz2mg7qSCUNkvpMUyDBEiz7rW1FKP
 aUj2VXUekvDiTRqcfyzgMGIzhgG5c58CBcIbxGKSfPH8jmTRW0cwa/IpCIZVEbA9NxKm
 3sV4P5Gouw38PO0bJj0uCX90pBdyvpP+4Orx+2FgnD86rqcHsLKIopwaSdBG1BrmqLRe
 uFDq4R50XsrAizgbsXoeuIc5rTx6mdSIMMuMad21VySMWJOxRmpQEK/C15HBGN/Jih/8
 AKu0nb6nlTArP7jNeXyd9arEvDjE2soHSvUltjBk4jeAbrhcVLbLwbKa8KF9vz2XYF0i
 dhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744377625; x=1744982425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFVtRYCu24+twV9jOKPANnIfNqNo8QdaQ2jo2GLBWA0=;
 b=OabZ4fv4f5DxQOAsmFc2Gh7XIsF1fJTMM2Z1xP2IbCPmN2SdM1fUWKUY2y17vJRZnW
 dzkC+dl3OHj5I3f/DW/Qw2VWLwqTUaD3mWsf7zF4O6kO021rJ2OS1wl+lUo3tikTKqLR
 NxVcWGinP0lObU3pm+DhrxEtr376KrkgbEhkMYE7+6RrKdbM0XWNZRSe/X0TJot7wJIZ
 qtIjS2r2h/mF4izS0Nkb+fL0O7fw0ufTR1RU4UzWQmdsR8xeUVEQfq/WcSGKh0w6KYK3
 e5V7PUDXG7aRMrrO3Ey0NKN97d72eMT/jSB4LcuD+vosQl3cgUCrVJA1770newViMGll
 4s+Q==
X-Gm-Message-State: AOJu0Yz0biiv/y+fEr73B6Ej4vvfpjhhjZ/cIOawRVfNvGu7PfOHBq8c
 Qt6vbyJ2gSmgn8e5YrvIXJfUVlaaRxH08rWPkNtlPSEHLUlmi0jzh9UR50wQBMY=
X-Gm-Gg: ASbGnctEC+jwW+XpvfXoUHwgEFFU84WLbX7pbHGS7YuUg56aYHjJ/TnWB8eEfcbLnTA
 HESJ/mytCgXBXDmjIrAqEBPxpbpACd6fv+PgG37Te6RybJ+AaaeHFpJWr8r40icMrh1cTG8q1Xv
 Z3Eqw7PR1HPSdFJwotoIORKMlqyUf6JI//lfpw8Z/+3DLkS0l0jGEmmiNiujAEW9eq6nsJiS1sF
 dr6f77ZsZh0+OTJYaJgdN9j62DcGbXKYNLc3yeyuFuD1Uc+PxqVLyO3H8aD2VeQgjttOqp3gLRp
 ZjBac9B47HQOnHUocVynJN1BpR/VnU4eE6W6IEgykf7ndoVpejusA/MSGNGbGShTYQ==
X-Google-Smtp-Source: AGHT+IHDt9ZeTOTKgHDwEtW9jauWIaOSSz61rU5iD7wxlm7do1H0RP2D4XIDQkbGnUpNmY2LcuwBWg==
X-Received: by 2002:a05:6000:4205:b0:391:40bd:6222 with SMTP id
 ffacd0b85a97d-39ea5200a8emr1759847f8f.22.1744377625188; 
 Fri, 11 Apr 2025 06:20:25 -0700 (PDT)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae964025sm1970314f8f.6.2025.04.11.06.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 06:20:24 -0700 (PDT)
Date: Fri, 11 Apr 2025 15:20:20 +0200
From: Antoine Damhet <adamhet@scaleway.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, devel@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
Message-ID: <pssex66ivae3kkxo7rwxo2mnroit7zpnirxis6eu56b2scaj3h@2flhgmzcxvy6>
References: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
 <su2au5bn77cjz64dgsd4by5atjlbun54467c2srdcmgoyeefpw@xym6ucphqa2d>
 <0a2611ae-93b0-48d6-ae89-02ab50339946@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b2lbrg2fgkwu6nq5"
Content-Disposition: inline
In-Reply-To: <0a2611ae-93b0-48d6-ae89-02ab50339946@daynix.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


--b2lbrg2fgkwu6nq5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
MIME-Version: 1.0

On Fri, Apr 11, 2025 at 05:01:01PM +0900, Akihiko Odaki wrote:
> On 2025/04/07 17:29, Antoine Damhet wrote:
> > On Sat, Apr 05, 2025 at 05:04:28PM +0900, Akihiko Odaki wrote:
> > > The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
> > > buffer") was to remove the need to patch the (const) input buffer wit=
h a
> > > recomputed UDP checksum by copying headers to a RW region and inject =
the
> > > checksum there. The patch computed the checksum only from the header
> > > fields (missing the rest of the payload) producing an invalid one
> > > and making guests fail to acquire a DHCP lease.
> > >=20
> > > Fix the issue by copying the entire packet instead of only copying the
> > > headers.
> > >=20
> > > Fixes: 7987d2be5a8b ("virtio-net: Copy received header to buffer")
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >=20
> > Tested-By: Antoine Damhet <adamhet@scaleway.com>
> >=20
> > > ---
> > > This patch aims to resolves the issue the following one also does:
> > > https://lore.kernel.org/qemu-devel/20250404151835.328368-1-adamhet@sc=
aleway.com
> > >=20
> > > The difference from the mentioned patch is that this patch also
> > > preserves that the original intent of regressing change, which is to
> > > remove the need to patch the (const) input buffer with a recomputed U=
DP
> > > checksum.
> > >=20
> > > To Antoine Damhet:
> > > I confirmed that DHCP is currently not working and this patch fixes t=
he
> > > issue, but I would appreciate if you also confirm the fix as I already
> > > have done testing badly for the regressing patch.
> >=20
> > Thanks for the swift response, ideally I'd like a non-regression test in
> > the testsuite but a quick test showed me that I couldn't easily
> > reproduce with user networking so unless someone has a great idea it
> > would be a pain.
> >=20
> > > ---
> > >   hw/net/virtio-net.c | 35 ++++++++++++++++-------------------
> > >   1 file changed, 16 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index de87cfadffe1..a920358a89c5 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -1687,6 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *=
vdev, struct virtio_net_hdr *hdr)
> > >       virtio_tswap16s(vdev, &hdr->csum_offset);
> > >   }
> > > +typedef struct Header {
> > > +    struct virtio_net_hdr_v1_hash virtio_net;
> > > +    uint8_t payload[1500];
> > > +} Header;
> > > +
> > >   /* dhclient uses AF_PACKET but doesn't pass auxdata to the kernel so
> > >    * it never finds out that the packets don't have valid checksums. =
 This
> > >    * causes dhclient to get upset.  Fedora's carried a patch for ages=
 to
> > > @@ -1701,7 +1706,7 @@ static void virtio_net_hdr_swap(VirtIODevice *v=
dev, struct virtio_net_hdr *hdr)
> > >    * we should provide a mechanism to disable it to avoid polluting t=
he host
> > >    * cache.
> > >    */
> > > -static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> > > +static void work_around_broken_dhclient(struct Header *hdr,
> > >                                           size_t *hdr_len, const uint=
8_t *buf,
> > >                                           size_t buf_size, size_t *bu=
f_offset)
> > >   {
> > > @@ -1711,20 +1716,20 @@ static void work_around_broken_dhclient(struc=
t virtio_net_hdr *hdr,
> > >       buf +=3D *buf_offset;
> > >       buf_size -=3D *buf_offset;
> > > -    if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csu=
m */
> > > -        (buf_size >=3D csum_size && buf_size < 1500) && /* normal si=
zed MTU */
> > > +    if ((hdr->virtio_net.hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&=
 /* missing csum */
> > > +        (buf_size >=3D csum_size && buf_size < sizeof(hdr->payload))=
 && /* normal sized MTU */
> > >           (buf[12] =3D=3D 0x08 && buf[13] =3D=3D 0x00) && /* ethertyp=
e =3D=3D IPv4 */
> > >           (buf[23] =3D=3D 17) && /* ip.protocol =3D=3D UDP */
> > >           (buf[34] =3D=3D 0 && buf[35] =3D=3D 67)) { /* udp.srcport =
=3D=3D bootps */
> > > -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> > > -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size,=
 CSUM_UDP);
> > > -        hdr->flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> > > -        *hdr_len +=3D csum_size;
> > > -        *buf_offset +=3D csum_size;
> > > +        memcpy((uint8_t *)hdr + *hdr_len, buf, buf_size);
> > > +        net_checksum_calculate((uint8_t *)hdr + *hdr_len, buf_size, =
CSUM_UDP);
> > > +        hdr->virtio_net.hdr.flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> > > +        *hdr_len +=3D buf_size;
> > > +        *buf_offset +=3D buf_size;
> > >       }
> > >   }
> > > -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hd=
r,
> > > +static size_t receive_header(VirtIONet *n, Header *hdr,
> > >                                const void *buf, size_t buf_size,
> > >                                size_t *buf_offset)
> >=20
> > `receive_header` can now "receive" the whole packet that's kinda
> > misleading. I though another approach would be to only do the
> > detection/flag patching from receive_header and recompute the checksum
> > directly in the final `iov`, this would also eliminate the extra payload
> > copy.
>=20
> It is possible to avoid copying but I chose not to do that because this is
> not a hot path and the code complexity required for that does not look
> worthwhile for me.

Understood and OK.

>=20
> But I agree that the names of receive_header() and Header structure are
> misleading. The reasoning I used to convince myself is that the "Header" =
is
> at the head of the packet at least. I'd like to hear if you have an idea =
of
> better naming; otherwise I would rather leave it as is.

Maybe we can sidestep this entirely, do we need to do the workaround
_inside_ `receive_header` ? WDYT of the following pseudocode:

```
guest_offset =3D receive_header(&header);
iov_from_buf(&header);
work_around_broken_dhclient(&header, &payload);
iov_from_buf(&payload);
```

If not maybe something along the line of "PacketPrefix" or
"PacketStart".

Regards,

--=20
Antoine 'xdbob' Damhet
Engineer @scaleway



>=20
> Regards,
> Akihiko Odaki
>=20
> >=20
> > Cheers,
> >=20
>=20

--b2lbrg2fgkwu6nq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmf5FwoACgkQ3AmjLzzl
jz6i7Af+O3oV6MiIRpPnKG21CJhp8X0Jmqj6e4eHCqZH4OIWd/w+8lxATKO9KXXQ
AQ0eTeniEJcUAz5khbOFwxdapV+832czJuJQgD66N/wolZ5w1D6GuxS0hZ+Y02RT
DJiTbEVQ88QG95pwimi8e+ihdzlQdicIzq7KXd7t9Xvkz8LjDiANB3PyoKAPtVOm
4QG77mkR9pyLYflVSQWrmuLg+wPsECKzpZlxkDGKYvAs5wDqKLbAKXqZYHu2HmKI
7J4xy9F4cUkVyFd1qocyaESPrWUgTsPqCB5IDz5WZaeYRQDdQ0KcA+5NYbFIBiHe
QL6FkomaNIhj868gIFxIHgyII1GL3g==
=Ln8h
-----END PGP SIGNATURE-----

--b2lbrg2fgkwu6nq5--

