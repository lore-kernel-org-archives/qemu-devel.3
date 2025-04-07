Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2249CC3601A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hsB-0004Tf-Pz; Mon, 07 Apr 2025 04:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u1hs3-0004FR-4f
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:30:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u1hrt-00031L-6E
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:30:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso37408085e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1744014599; x=1744619399; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M+UOXJWeGDngXv/nS9fMg51KMnWcSkDRnmG0t4jTSoE=;
 b=iCPWmXbv3p+dyCSUDluMn3f2QYiPik+J6Z2I8Hn+S9c5ru9hVbFq5s7zHYSNJ+Zjsd
 Fatgov3kMJlLr1t1urBrSYUubvp4s9ZnzF4WUiIJvKCNmcPNyxAcVm/k/BaRywA6cyi6
 ULKFCfLKQDlnvtaXlNZ5IB1jsmWRK3mc40nnL9AAkg/ztWSXkCDoQ53iuO3tMxvPSeWz
 ODAIcy6ePr1bMIugmMNMsi6Wr7YvyEE/Tx7eGxFDJ9rS0QMXh+di1CrkNOh49PpE0CYI
 tCHKR0rbmsMSzG3mQ7k0sgtKMGfVxcnGZs6n8tjPeK1mztiOZhF2xGfbuTh/Koq7DSj5
 KsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744014599; x=1744619399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+UOXJWeGDngXv/nS9fMg51KMnWcSkDRnmG0t4jTSoE=;
 b=af8eSzin8LJapCoULnAgh3FIB4FP9paSYq8cSRvP42yrBCQRkWtC+bQSdth3ghRQth
 5MWSAj5Y1gAqGRfgGyOhR2pVYN2hEPAOtvxI0ACN80VxG7oZFhywVUwmrw1Y5HO3btmM
 v5vZxCZJYSplj0FMaJ18rAuWiSm61/p9aN4gGZg+3ImBNbXXKT3z7Uis+90oHhSHTVA/
 6A8Ks1z6xmkdlm8kIMTrnWJgaosOfSNmEiUdJRhstes7zMtzwcD8kUqvY8W4TDqtt7ei
 rCNinAsf3aVn4T/M7Cvhbh19DN96mwdwK/LL3n4JG3tYpOxe2zEggX16qmqcMgxnRJOI
 2NJQ==
X-Gm-Message-State: AOJu0YxQtViE3q5ZDfcXPGYnP7GQUH8XlCGexpcQuM/OfzsPcC0CDFIC
 d2Y2uZVllErCuAqSA95BJlH5osnIqddnvH0dpWRgg3gc256TRgeQYI4rRoGfUFQ=
X-Gm-Gg: ASbGncvaaMCbS/uddqgdo1M+BWGHHiSa593k5wz6GfK7hDP4lOVo3EI2i/Wgcze+mPt
 4bnRwkFckNdqg1aJx1h/kWEUzCogY/uZX68fVA01zFuKbiNO89uyYCAmKjUXEw7iNCTN9pwgJdn
 Ud6FPyxOayln1XLeoqQhsmvnPrIQx4IM5KbbdOMjHQQvLGaMnAC0ThhNSXxCQIShqgQzqKYdfuR
 K7vtwSI6ru0i9nWgjBNbdylY/1cteYxI7Unzy6VRyDzDy2wWdct9CnVGGmUR5up6COp7YjIv397
 WSeWQ/aEdustKqRlw5zEBXojGLXVilsBuLbGo+AaAW0R
X-Google-Smtp-Source: AGHT+IGm8dCEIIzuX4VQhgduv7yvEcuD62NCr+mf2P/R/5Iek/EQ5fythQfMF5aQ2738cVfB6lSw6w==
X-Received: by 2002:a05:600c:1c07:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43ecf84287dmr109186615e9.4.1744014598655; 
 Mon, 07 Apr 2025 01:29:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:e9e:c3d0:7a5b:f76a:6cf6:aac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b3572sm125529435e9.39.2025.04.07.01.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:29:58 -0700 (PDT)
Date: Mon, 7 Apr 2025 10:29:57 +0200
From: Antoine Damhet <adamhet@scaleway.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, devel@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
Message-ID: <su2au5bn77cjz64dgsd4by5atjlbun54467c2srdcmgoyeefpw@xym6ucphqa2d>
References: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pky7tesimesqfqpk"
Content-Disposition: inline
In-Reply-To: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x32d.google.com
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


--pky7tesimesqfqpk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
MIME-Version: 1.0

On Sat, Apr 05, 2025 at 05:04:28PM +0900, Akihiko Odaki wrote:
> The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
> buffer") was to remove the need to patch the (const) input buffer with a
> recomputed UDP checksum by copying headers to a RW region and inject the
> checksum there. The patch computed the checksum only from the header
> fields (missing the rest of the payload) producing an invalid one
> and making guests fail to acquire a DHCP lease.
>=20
> Fix the issue by copying the entire packet instead of only copying the
> headers.
>=20
> Fixes: 7987d2be5a8b ("virtio-net: Copy received header to buffer")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-By: Antoine Damhet <adamhet@scaleway.com>

> ---
> This patch aims to resolves the issue the following one also does:
> https://lore.kernel.org/qemu-devel/20250404151835.328368-1-adamhet@scalew=
ay.com
>=20
> The difference from the mentioned patch is that this patch also
> preserves that the original intent of regressing change, which is to
> remove the need to patch the (const) input buffer with a recomputed UDP
> checksum.
>=20
> To Antoine Damhet:
> I confirmed that DHCP is currently not working and this patch fixes the
> issue, but I would appreciate if you also confirm the fix as I already
> have done testing badly for the regressing patch.

Thanks for the swift response, ideally I'd like a non-regression test in
the testsuite but a quick test showed me that I couldn't easily
reproduce with user networking so unless someone has a great idea it
would be a pain.

> ---
>  hw/net/virtio-net.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadffe1..a920358a89c5 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1687,6 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev=
, struct virtio_net_hdr *hdr)
>      virtio_tswap16s(vdev, &hdr->csum_offset);
>  }
> =20
> +typedef struct Header {
> +    struct virtio_net_hdr_v1_hash virtio_net;
> +    uint8_t payload[1500];
> +} Header;
> +
>  /* dhclient uses AF_PACKET but doesn't pass auxdata to the kernel so
>   * it never finds out that the packets don't have valid checksums.  This
>   * causes dhclient to get upset.  Fedora's carried a patch for ages to
> @@ -1701,7 +1706,7 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev,=
 struct virtio_net_hdr *hdr)
>   * we should provide a mechanism to disable it to avoid polluting the ho=
st
>   * cache.
>   */
> -static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> +static void work_around_broken_dhclient(struct Header *hdr,
>                                          size_t *hdr_len, const uint8_t *=
buf,
>                                          size_t buf_size, size_t *buf_off=
set)
>  {
> @@ -1711,20 +1716,20 @@ static void work_around_broken_dhclient(struct vi=
rtio_net_hdr *hdr,
>      buf +=3D *buf_offset;
>      buf_size -=3D *buf_offset;
> =20
> -    if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
> -        (buf_size >=3D csum_size && buf_size < 1500) && /* normal sized =
MTU */
> +    if ((hdr->virtio_net.hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* =
missing csum */
> +        (buf_size >=3D csum_size && buf_size < sizeof(hdr->payload)) && =
/* normal sized MTU */
>          (buf[12] =3D=3D 0x08 && buf[13] =3D=3D 0x00) && /* ethertype =3D=
=3D IPv4 */
>          (buf[23] =3D=3D 17) && /* ip.protocol =3D=3D UDP */
>          (buf[34] =3D=3D 0 && buf[35] =3D=3D 67)) { /* udp.srcport =3D=3D=
 bootps */
> -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSU=
M_UDP);
> -        hdr->flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> -        *hdr_len +=3D csum_size;
> -        *buf_offset +=3D csum_size;
> +        memcpy((uint8_t *)hdr + *hdr_len, buf, buf_size);
> +        net_checksum_calculate((uint8_t *)hdr + *hdr_len, buf_size, CSUM=
_UDP);
> +        hdr->virtio_net.hdr.flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> +        *hdr_len +=3D buf_size;
> +        *buf_offset +=3D buf_size;
>      }
>  }
> =20
> -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
> +static size_t receive_header(VirtIONet *n, Header *hdr,
>                               const void *buf, size_t buf_size,
>                               size_t *buf_offset)

`receive_header` can now "receive" the whole packet that's kinda
misleading. I though another approach would be to only do the
detection/flag patching from receive_header and recompute the checksum
directly in the final `iov`, this would also eliminate the extra payload
copy.

Cheers,

--=20
Antoine 'xdbob' Damhet
Engineer @scaleway


>  {
> @@ -1736,7 +1741,7 @@ static size_t receive_header(VirtIONet *n, struct v=
irtio_net_hdr *hdr,
>      work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset=
);
> =20
>      if (n->needs_vnet_hdr_swap) {
> -        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
> +        virtio_net_hdr_swap(VIRTIO_DEVICE(n), (struct virtio_net_hdr *)h=
dr);
>      }
> =20
>      return hdr_len;
> @@ -1907,13 +1912,6 @@ static int virtio_net_process_rss(NetClientState *=
nc, const uint8_t *buf,
>      return (index =3D=3D new_index) ? -1 : new_index;
>  }
> =20
> -typedef struct Header {
> -    struct virtio_net_hdr_v1_hash virtio_net;
> -    struct eth_header eth;
> -    struct ip_header ip;
> -    struct udp_header udp;
> -} Header;
> -
>  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t =
*buf,
>                                        size_t size)
>  {
> @@ -2002,8 +2000,7 @@ static ssize_t virtio_net_receive_rcu(NetClientStat=
e *nc, const uint8_t *buf,
>              }
> =20
>              guest_offset =3D n->has_vnet_hdr ?
> -                           receive_header(n, (struct virtio_net_hdr *)&h=
dr,
> -                                          buf, size, &offset) :
> +                           receive_header(n, &hdr, buf, size, &offset) :
>                             n->guest_hdr_len;
> =20
>              iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
>=20
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250405-mtu-834d4c62c93c
>=20
> Best regards,
> --=20
> Akihiko Odaki <akihiko.odaki@daynix.com>

--pky7tesimesqfqpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmfzjQIACgkQ3AmjLzzl
jz7AEQgAp5edyhwS9dsWh9CPnmm96OCRseZEJz/HepNlm7CZJqyuV6EkAmrJwAB/
32fxFv2nj0wzOCAVcfUvjsbWdnHAp6BJ+XEDXfCcxRTXB7fPOQnfy8kCfGjAhzah
cMntDdXBnjsoJGWze5Ks1m1iu3RBft6zLV0zICgrjPCbeFFz3mqSVO474LpT2A/M
KXOsi2B9fcPtZRxTqc0a1W0+jsB5RpulLByyFHl+ddVT/W3mvvgPUcW70StJnv9b
PtIJ0hYjGpVWHVpOU2ShArXfiFt4K0HL7YzlokYiISk7g+QoZgSRBOqbBEwe3Q2x
Ktc1ZxQ3BNPMO8sR56zaF/6Fk75Wfg==
=7saO
-----END PGP SIGNATURE-----

--pky7tesimesqfqpk--

