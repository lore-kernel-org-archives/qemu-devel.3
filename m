Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401E9C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 08:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgJPm-0007zP-Hw; Fri, 07 Feb 2025 03:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tgJPj-0007y4-Kt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 03:08:39 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tgJPh-0000q8-Gb
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 03:08:39 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab698eae2d9so320400866b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 00:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738915716; x=1739520516; darn=nongnu.org;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=f2IW7sw5VPjFxAUEnjm9d+enG57wNGw2VEmGyaGu774=;
 b=ZTc2ory0SK8HUs0IsP/KZkPyH/GWx+U6+KQuDQ5aBIpy1m3fsuBUCBTXaCE+aCjSaC
 dPgdNQr3lIHSKchhYKI1DWnrlyvYy+B+XMuN+h6ttgqUZSLlOwPGbdNWax1/R83xdwji
 Ll8hnUqdpcrri6bilM2ClntSdfn39B8phjfI3T9W2hjvCcgdRPqq0z41rN/57fRPnYMS
 mkbpeJkwu3X1mu40T6/ECkydTdAGVn4IS9vH1tpcpkY7h7MUSEnMZTV6D/BxZLobV+HI
 R3+HBa9LRE42B+s6i4Evd47RxEtrkfm4zKVNpph6wit6UE2olhJwNyAP8JWgmDVJ+3SD
 ia1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738915716; x=1739520516;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2IW7sw5VPjFxAUEnjm9d+enG57wNGw2VEmGyaGu774=;
 b=eyL3WSBXZ2ltL80US5thWWZMQXqZCHufnZ3AiEjZjkRUmLugTSq0ZVHRBHcv9oxTAU
 pgY2pvZCSZwFyqpe5SpQgpujy6P+3Jy0EOjQB+Cp9p5eUYcbm0BJXL9XE0PyAmlg911X
 E9VJKtY7Nc/ExryjDQzkQNDWDQjb1OLins47VJM3p4I8FamUYd922HmS0D6+tYtpJvua
 CWkqO4238kGpJrRCICTzKmxLB/eJTc3+wr17MJZteKjbtnaWSayVXTUMKNKXNSMM4uwt
 1DpE3zbktQ2BO0A2R4ez575Oq5MMR+7VTbsxrStz7tP9jhHWMZSBca/Txbkr0cIZCKte
 TLCA==
X-Gm-Message-State: AOJu0Yw6RfFFFwsSaorocmw3mfqTToU5W+kI+6t9pHMZVORVx1LEI5PI
 dGGkQiaOCNJ5xtTvDF1u3jSE3jOrZI04Mn80FcoGDJswc5E9EZdcpTmAa7TjuM0=
X-Gm-Gg: ASbGncu9qSpjq21MIX3iLL+XNgtldlONpr8cZK8Qo4r5I1vt4xwy+evWzyvMsRuITPC
 70MkkrEHCBG3DHxbKni3uBkTIyWHWQzrTcUYx+oDxUI0rzWvVHcLNc4p0qmkaHcUXDXo/eDwEuq
 4xchjCYxhg7sG+lPMaT65OHnxSGn9LP0p9UuO0BfWATzWifA5AkPXUfM+fsyK/VJ1RPQwLWVK3o
 6TGGSQ/lD0r2ykkmxqC67k7UHCgiHrifISFiAEuDSZ8a7ShT16CbPvYclLpd4YCKiuzwR5Y53XD
 aktOr0iFuQ5zQq/2sIECb4u/y7CIxGHEcQWbVBIuNXmFmbmhBZgaQdTmMcna3Q7ACw==
X-Google-Smtp-Source: AGHT+IEf0g2LxYK9e2YBgMKBZGi3t9PsR/SmJYiTH0QDViC1r33fizF8pj7Z2TiA8rraHyIjpv5gFA==
X-Received: by 2002:a17:907:6eac:b0:ab6:ed8a:8a90 with SMTP id
 a640c23a62f3a-ab789b1c2a4mr213593766b.24.1738915715426; 
 Fri, 07 Feb 2025 00:08:35 -0800 (PST)
Received: from ?IPv6:2001:9e8:dc2a:4d00:bffc:7d1:e004:f4ff?
 ([2001:9e8:dc2a:4d00:bffc:7d1:e004:f4ff])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f484acsm225534466b.11.2025.02.07.00.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 00:08:34 -0800 (PST)
Message-ID: <31df084577c276e99245f26cb019cfb701efe91c.camel@gmail.com>
Subject: Re: [PATCH 3/4] vfio/igd: use PCI ID defines to detect IGD gen
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Date: Fri, 07 Feb 2025 09:08:34 +0100
In-Reply-To: <dde3f9f8d33bd855bb0081c7e4234739d0f87209.camel@gmail.com>
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
 <20250206121341.118337-4-corvin.koehne@gmail.com>
 <20250206142641.2acb7ab1.alex.williamson@redhat.com>
 <dde3f9f8d33bd855bb0081c7e4234739d0f87209.camel@gmail.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-0hIR0dejUs/fUoZDETsK"
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


--=-0hIR0dejUs/fUoZDETsK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-02-07 at 08:47 +0100, Corvin K=C3=B6hne wrote:
> On Thu, 2025-02-06 at 14:26 -0700, Alex Williamson wrote:
> > On Thu,=C2=A0 6 Feb 2025 13:13:39 +0100
> > Corvin K=C3=B6hne <corvin.koehne@gmail.com> wrote:
> >=20
> > > From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> > >=20
> > > We've recently imported the PCI ID list of knwon Intel GPU devices fr=
om
> > > Linux. It allows us to properly match GPUs to their generation withou=
t
> > > maintaining an own list of PCI IDs.
> > >=20
> > > Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> > > ---
> > > =C2=A0hw/vfio/igd.c | 77 ++++++++++++++++++++++++++++----------------=
-------
> > > =C2=A01 file changed, 42 insertions(+), 35 deletions(-)
> > >=20
> > > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > > index 0740a5dd8c..e5d7006ce2 100644
> > > --- a/hw/vfio/igd.c
> > > +++ b/hw/vfio/igd.c
> > > @@ -18,6 +18,7 @@
> > > =C2=A0#include "hw/hw.h"
> > > =C2=A0#include "hw/nvram/fw_cfg.h"
> > > =C2=A0#include "pci.h"
> > > +#include "standard-headers/drm/intel/pciids.h"
> > > =C2=A0#include "trace.h"
> > > =C2=A0
> > > =C2=A0/*
> > > @@ -51,6 +52,42 @@
> > > =C2=A0 * headless setup is desired, the OpRegion gets in the way of t=
hat.
> > > =C2=A0 */
> > > =C2=A0
> > > +struct igd_device {
> > > +=C2=A0=C2=A0=C2=A0 const uint32_t device_id;
> > > +=C2=A0=C2=A0=C2=A0 const int gen;
> > > +};
> > > +
> > > +#define IGD_DEVICE(_id, _gen) { \
> > > +=C2=A0=C2=A0=C2=A0 .device_id =3D (_id), \
> > > +=C2=A0=C2=A0=C2=A0 .gen =3D (_gen), \
> > > +}
> > > +
> > > +static const struct igd_device igd_devices[] =3D {
> > > +=C2=A0=C2=A0=C2=A0 INTEL_SNB_IDS(IGD_DEVICE, 6),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_IVB_IDS(IGD_DEVICE, 6),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_HSW_IDS(IGD_DEVICE, 7),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_VLV_IDS(IGD_DEVICE, 7),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_BDW_IDS(IGD_DEVICE, 8),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_CHV_IDS(IGD_DEVICE, 8),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_SKL_IDS(IGD_DEVICE, 9),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_BXT_IDS(IGD_DEVICE, 9),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_KBL_IDS(IGD_DEVICE, 9),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_CFL_IDS(IGD_DEVICE, 9),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_CML_IDS(IGD_DEVICE, 9),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_GLK_IDS(IGD_DEVICE, 9),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_ICL_IDS(IGD_DEVICE, 11),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_EHL_IDS(IGD_DEVICE, 11),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_JSL_IDS(IGD_DEVICE, 11),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_TGL_IDS(IGD_DEVICE, 12),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_RKL_IDS(IGD_DEVICE, 12),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_ADLS_IDS(IGD_DEVICE, 12),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_ADLP_IDS(IGD_DEVICE, 12),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_ADLN_IDS(IGD_DEVICE, 12),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_RPLS_IDS(IGD_DEVICE, 12),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_RPLU_IDS(IGD_DEVICE, 12),
> > > +=C2=A0=C2=A0=C2=A0 INTEL_RPLP_IDS(IGD_DEVICE, 12),
> > > +};
> >=20
> > I agree with Connie's comment on the ordering and content of the first
> > two patches.
> >=20
> > For these last two, I wish these actually made it substantially easier
> > to synchronize with upstream.=C2=A0 Based on the next patch, I think it
> > still requires manually tracking/parsing internal code in the i915
> > driver to extract generation information.
> >=20
> > Is it possible that we could split the above into a separate file
> > that's auto-generated from a script?=C2=A0 For example maybe some scrip=
ting
> > and C code that can instantiate the pciidlist array from i915_pci.c and
> > regurgitate it into a device-id/generation table?=C2=A0 Thanks,
> >=20
> > Alex
> >=20
>=20
> Hi Alex,
>=20
> I took a closer look into i915 and it seems hard to parse. Upstream maint=
ains
> a
> description for each generation, e.g. on AlderLake P [1] the generation i=
s
> defined in the .info field of a struct, the .info field itself is defined
> somewhere else [2] and sets the .__runtime_defaults.ip.ver by another C m=
acro
> [3]. Other platforms like GeminiLake set the .ip.ver directly in their
> description struct [4].
>=20
> Nevertheless, we may not need this PCI ID mapping at all in the future. I=
t
> looks
> like Intel added a new register to their GPU starting with MeteorLake [5]=
. We
> can read it to obtain the GPU generation [6]. I don't have a MeteorLake s=
ystem
> available yet, so I can't test it. On my TigerLake system, the register
> returns
> zero. When it works as expected, we could refactor the igd_gen function t=
o
> something like:
>=20
> static int igd_gen(VFIOPCIDevice vdev) {
> =C2=A0 uint32_t gmd_id =3D vfio_region_read(&vdev->bars[0].region, GMD_ID=
_DISPLAY,
> 4);
> =C2=A0 if (gmd_id !=3D 0) {
> =C2=A0=C2=A0=C2=A0 return (gmd_id & GMD_ID_ARCH_MASK) >> GMD_ID_ARCH_SHIF=
T;
> =C2=A0 }
>=20
> =C2=A0 // Fallback to PCI ID mapping.
> =C2=A0 ...=20
> }
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/disp=
lay/intel_display_device.c#L1171
> [2]
> https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/disp=
lay/intel_display_device.c#L1128
> [3]
> https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/disp=
lay/intel_display_device.c#L1120
> [4]
> https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/disp=
lay/intel_display_device.c#L829
> [5]
> https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/disp=
lay/intel_display_device.c#L1326-L1330
> [6]
> https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/disp=
lay/intel_display_device.c#L1432
>=20
>=20

I've missed that upstream maintains a second list [1]. Nevertheless, it loo=
ks
still hard to parse.

[1]
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/i915_p=
ci.c


--=20
Kind regards,
Corvin

--=-0hIR0dejUs/fUoZDETsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmelv4IACgkQ2FTaVjFe
AmopCBAAiySsWkSLLsZynchcxxPEGS5OeEaWZHOhE+fbziMOQUEd7l8Xjf1GXdc4
XEbpUCmo3uFHnmYaj5b+ZPrhpVXId02eALOHG7J+hE3amXEMpR0T4NWtN0pqbOzK
MvrZFqn0moHoQCl4ZfQt9tgk+WY93ig1DK3LC8pBQT0zf74Jg1BmEdfoGhZMd5yi
jtH3f2Bf/i0jcHP6oyRRCE6F5y4XdnniTgF0Tn7NrxiTTQ94UskGZgqBC2EnWqev
1+VeR3TVjvz5jWHQeyPTqGCxuWnivNw03jxEa/985h+QBbOXCrgXYiZFui7Jvlnq
vS8S/ncJ7ayoxdfnwi9+NwhEikQIxmmtknF46GqAKBRVq9oFEs+/zzb2QVJOW1Wj
8vCP6qjA2SevmKoughRQn0NpmHCR2/Hmd9n1Id0ClVFKwFJzQRdL5e31wLwGMUTo
t87Tf5pI+Z/t0nKCE4AlVlsbTBsriwYZl1jqcA4E3Ny+sDHFtG/HLaiz3ssuDuVE
iXRutVgribb0N0V059DQc9LLkpcVlViYheZq0pM0K2vk+uv+q4F2Qi6WYbHWIJTE
pEfNcY5+98vWMwIyVxqiFIKjAYNYsUPL1alYQOOyPlGWGLKszComMm0kMJqAxywc
5AWLWf9HqZgM3upUxjDWGIMTRK8jh5Yg6HWKSi4b12eYMQdxqxs=
=9tip
-----END PGP SIGNATURE-----

--=-0hIR0dejUs/fUoZDETsK--

