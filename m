Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D67C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 07:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgJ5v-0002jx-Ly; Fri, 07 Feb 2025 02:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tgJ5u-0002jj-5O
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 02:48:10 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tgJ5r-0000sJ-UJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 02:48:09 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so335812066b.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 23:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738914486; x=1739519286; darn=nongnu.org;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=o+yK6UAvXY4SIGaON49Xovkkw0b+SJZmcCpiYSFv5t8=;
 b=JHXH6JmYleJgLYVfmUKVjB5819fIjB8elRf6ViJYVtiSCci4O1EZd+2zO9maS86uzq
 x6dr1VKZv2CEQyN6ouYbufXBdE7r+nO7yQH+imcxrPBrpx21vzAUuppTiBEkt4uO0cAj
 rvkWwP5olpUwHCmN3uv3D07lAMsyBV+QtQjiAeqPnXGstNUp6DjO38LVwFqZgTpC0Zgf
 O1avM3JocmGdw1Sv6q04+lWJMjbVOBXA9nbalh1YNoRO7hA+8yJR/8RvCXC9rNAufMuX
 2YAcflkGEW8LaSJZUMhYBacj3fZM06WSFE6APDF7Ek8iPqHcXgOAo2DbqhenRFbcVttc
 xiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738914486; x=1739519286;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+yK6UAvXY4SIGaON49Xovkkw0b+SJZmcCpiYSFv5t8=;
 b=EhG1lu4vLkJADBH0R7+8WBGipI2P9P+VnFGzLIrpaOCubKcc9FO6aeWvJTOnopbAyV
 W5j0w7xfG2T6zGVWZPuBJWZ8QFIpDikc82s8NFUbPl9jit/5pe0buhxP/4wJANEtkI9v
 TlfVdUFH0x93I4sml4Ybgu7te5Hal2w/YgCfgv+1Cm0T2JfjV+thtbAnVU+B29iuhioa
 AVW1Fi3+yQ4DevbZQl0ZWEYJ+I6DJjeFOrXeysI9qOumWLrwv85447swKYxCLKdgq0CK
 kd49mMpL732UCSjteziaZJNQu0EOH3FW7aXTvFeU99BaoveA4tS8qQyHLjsuYwQ4xWfH
 pB/g==
X-Gm-Message-State: AOJu0Yy2e0AmhrsZZFpSUOgx+jIvuYvUkyUBi0pQ47iWK6d+br38amIu
 kgKE9/bVEnlJKC7OXFycPRDFJAeWZGvnsnwa7AtWcBGf1P7F7BYh
X-Gm-Gg: ASbGncs75FpO0vv2XALS1FJKcVAnCj1hJ9t7Gp3r35lrC1/0tsGYZRTKqJM6jfJnwV7
 Dmo+9Huq6Ed/J4zAkCvb0fWe/++QCjX+qKg48NkTjmQudRaNgM+PQzYImx7IPOFRpirCPSeBQya
 7N2qH68Qjd1e1lu5YT6Vb35AF5Cu4BSv9D2AxG0deKMUDVAV6TZoOH6wN3r5HymPepQswJEQNCj
 OhhGu8qqOpVAzE6LCArHRTuwHfCX7jQueTE2csNywgNWmqvlxWyJnXfi7ifTtTTssfwr+PfC34O
 Khj2fUv4tbXHW50FOhdMq+rq67QkQPakFM79AWjYmR8CVmIABhFDraz4IPS4YLirjA==
X-Google-Smtp-Source: AGHT+IFurNJimwNUXCHEqmWq3+Eq1fr5vg3LtaSJHsQhtFizCSLKgSioNgF8O4UGIBmzp90HUOLY+Q==
X-Received: by 2002:a17:907:d8f:b0:a9a:9df:5580 with SMTP id
 a640c23a62f3a-ab789b35a92mr179221266b.19.1738914485615; 
 Thu, 06 Feb 2025 23:48:05 -0800 (PST)
Received: from ?IPv6:2001:9e8:dc2a:4d00:bffc:7d1:e004:f4ff?
 ([2001:9e8:dc2a:4d00:bffc:7d1:e004:f4ff])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab773339986sm219035166b.156.2025.02.06.23.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 23:48:05 -0800 (PST)
Message-ID: <dde3f9f8d33bd855bb0081c7e4234739d0f87209.camel@gmail.com>
Subject: Re: [PATCH 3/4] vfio/igd: use PCI ID defines to detect IGD gen
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Date: Fri, 07 Feb 2025 08:47:59 +0100
In-Reply-To: <20250206142641.2acb7ab1.alex.williamson@redhat.com>
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
 <20250206121341.118337-4-corvin.koehne@gmail.com>
 <20250206142641.2acb7ab1.alex.williamson@redhat.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-9zRy1oGUFpooelTE0lzI"
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62c.google.com
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


--=-9zRy1oGUFpooelTE0lzI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-02-06 at 14:26 -0700, Alex Williamson wrote:
> On Thu,=C2=A0 6 Feb 2025 13:13:39 +0100
> Corvin K=C3=B6hne <corvin.koehne@gmail.com> wrote:
>=20
> > From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> >=20
> > We've recently imported the PCI ID list of knwon Intel GPU devices from
> > Linux. It allows us to properly match GPUs to their generation without
> > maintaining an own list of PCI IDs.
> >=20
> > Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> > ---
> > =C2=A0hw/vfio/igd.c | 77 ++++++++++++++++++++++++++++------------------=
-----
> > =C2=A01 file changed, 42 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index 0740a5dd8c..e5d7006ce2 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -18,6 +18,7 @@
> > =C2=A0#include "hw/hw.h"
> > =C2=A0#include "hw/nvram/fw_cfg.h"
> > =C2=A0#include "pci.h"
> > +#include "standard-headers/drm/intel/pciids.h"
> > =C2=A0#include "trace.h"
> > =C2=A0
> > =C2=A0/*
> > @@ -51,6 +52,42 @@
> > =C2=A0 * headless setup is desired, the OpRegion gets in the way of tha=
t.
> > =C2=A0 */
> > =C2=A0
> > +struct igd_device {
> > +=C2=A0=C2=A0=C2=A0 const uint32_t device_id;
> > +=C2=A0=C2=A0=C2=A0 const int gen;
> > +};
> > +
> > +#define IGD_DEVICE(_id, _gen) { \
> > +=C2=A0=C2=A0=C2=A0 .device_id =3D (_id), \
> > +=C2=A0=C2=A0=C2=A0 .gen =3D (_gen), \
> > +}
> > +
> > +static const struct igd_device igd_devices[] =3D {
> > +=C2=A0=C2=A0=C2=A0 INTEL_SNB_IDS(IGD_DEVICE, 6),
> > +=C2=A0=C2=A0=C2=A0 INTEL_IVB_IDS(IGD_DEVICE, 6),
> > +=C2=A0=C2=A0=C2=A0 INTEL_HSW_IDS(IGD_DEVICE, 7),
> > +=C2=A0=C2=A0=C2=A0 INTEL_VLV_IDS(IGD_DEVICE, 7),
> > +=C2=A0=C2=A0=C2=A0 INTEL_BDW_IDS(IGD_DEVICE, 8),
> > +=C2=A0=C2=A0=C2=A0 INTEL_CHV_IDS(IGD_DEVICE, 8),
> > +=C2=A0=C2=A0=C2=A0 INTEL_SKL_IDS(IGD_DEVICE, 9),
> > +=C2=A0=C2=A0=C2=A0 INTEL_BXT_IDS(IGD_DEVICE, 9),
> > +=C2=A0=C2=A0=C2=A0 INTEL_KBL_IDS(IGD_DEVICE, 9),
> > +=C2=A0=C2=A0=C2=A0 INTEL_CFL_IDS(IGD_DEVICE, 9),
> > +=C2=A0=C2=A0=C2=A0 INTEL_CML_IDS(IGD_DEVICE, 9),
> > +=C2=A0=C2=A0=C2=A0 INTEL_GLK_IDS(IGD_DEVICE, 9),
> > +=C2=A0=C2=A0=C2=A0 INTEL_ICL_IDS(IGD_DEVICE, 11),
> > +=C2=A0=C2=A0=C2=A0 INTEL_EHL_IDS(IGD_DEVICE, 11),
> > +=C2=A0=C2=A0=C2=A0 INTEL_JSL_IDS(IGD_DEVICE, 11),
> > +=C2=A0=C2=A0=C2=A0 INTEL_TGL_IDS(IGD_DEVICE, 12),
> > +=C2=A0=C2=A0=C2=A0 INTEL_RKL_IDS(IGD_DEVICE, 12),
> > +=C2=A0=C2=A0=C2=A0 INTEL_ADLS_IDS(IGD_DEVICE, 12),
> > +=C2=A0=C2=A0=C2=A0 INTEL_ADLP_IDS(IGD_DEVICE, 12),
> > +=C2=A0=C2=A0=C2=A0 INTEL_ADLN_IDS(IGD_DEVICE, 12),
> > +=C2=A0=C2=A0=C2=A0 INTEL_RPLS_IDS(IGD_DEVICE, 12),
> > +=C2=A0=C2=A0=C2=A0 INTEL_RPLU_IDS(IGD_DEVICE, 12),
> > +=C2=A0=C2=A0=C2=A0 INTEL_RPLP_IDS(IGD_DEVICE, 12),
> > +};
>=20
> I agree with Connie's comment on the ordering and content of the first
> two patches.
>=20
> For these last two, I wish these actually made it substantially easier
> to synchronize with upstream.=C2=A0 Based on the next patch, I think it
> still requires manually tracking/parsing internal code in the i915
> driver to extract generation information.
>=20
> Is it possible that we could split the above into a separate file
> that's auto-generated from a script?=C2=A0 For example maybe some scripti=
ng
> and C code that can instantiate the pciidlist array from i915_pci.c and
> regurgitate it into a device-id/generation table?=C2=A0 Thanks,
>=20
> Alex
>=20

Hi Alex,

I took a closer look into i915 and it seems hard to parse. Upstream maintai=
ns a
description for each generation, e.g. on AlderLake P [1] the generation is
defined in the .info field of a struct, the .info field itself is defined
somewhere else [2] and sets the .__runtime_defaults.ip.ver by another C mac=
ro
[3]. Other platforms like GeminiLake set the .ip.ver directly in their
description struct [4].

Nevertheless, we may not need this PCI ID mapping at all in the future. It =
looks
like Intel added a new register to their GPU starting with MeteorLake [5]. =
We
can read it to obtain the GPU generation [6]. I don't have a MeteorLake sys=
tem
available yet, so I can't test it. On my TigerLake system, the register ret=
urns
zero. When it works as expected, we could refactor the igd_gen function to
something like:

static int igd_gen(VFIOPCIDevice vdev) {
  uint32_t gmd_id =3D vfio_region_read(&vdev->bars[0].region, GMD_ID_DISPLA=
Y, 4);
  if (gmd_id !=3D 0) {
    return (gmd_id & GMD_ID_ARCH_MASK) >> GMD_ID_ARCH_SHIFT;
  }

  // Fallback to PCI ID mapping.
  ...=20
}

[1]
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/displa=
y/intel_display_device.c#L1171
[2]
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/displa=
y/intel_display_device.c#L1128
[3]
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/displa=
y/intel_display_device.c#L1120
[4]
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/displa=
y/intel_display_device.c#L829
[5]
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/displa=
y/intel_display_device.c#L1326-L1330
[6]
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/gpu/drm/i915/displa=
y/intel_display_device.c#L1432


--=20
Kind regards,
Corvin

> > +
> > =C2=A0/*
> > =C2=A0 * This presumes the device is already known to be an Intel VGA d=
evice, so
> > we
> > =C2=A0 * take liberties in which device ID bits match which generation.=
=C2=A0 This
> > should
> > @@ -60,42 +97,12 @@
> > =C2=A0 */
> > =C2=A0static int igd_gen(VFIOPCIDevice *vdev)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0 /*
> > -=C2=A0=C2=A0=C2=A0=C2=A0 * Device IDs for Broxton/Apollo Lake are 0x0a=
84, 0x1a84, 0x1a85,
> > 0x5a84
> > -=C2=A0=C2=A0=C2=A0=C2=A0 * and 0x5a85, match bit 11:1 here
> > -=C2=A0=C2=A0=C2=A0=C2=A0 * Prefix 0x0a is taken by Haswell, this rule =
should be matched first.
> > -=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0 if ((vdev->device_id & 0xffe) =3D=3D 0xa84) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 9;
> > -=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < ARRAY_SIZE(igd_devices); i++)=
 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (igd_devices[i].device_i=
d !=3D vdev->device_id) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 switch (vdev->device_id & 0xff00) {
> > -=C2=A0=C2=A0=C2=A0 case 0x0100:=C2=A0=C2=A0=C2=A0 /* SandyBridge, IvyB=
ridge */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 6;
> > -=C2=A0=C2=A0=C2=A0 case 0x0400:=C2=A0=C2=A0=C2=A0 /* Haswell */
> > -=C2=A0=C2=A0=C2=A0 case 0x0a00:=C2=A0=C2=A0=C2=A0 /* Haswell */
> > -=C2=A0=C2=A0=C2=A0 case 0x0c00:=C2=A0=C2=A0=C2=A0 /* Haswell */
> > -=C2=A0=C2=A0=C2=A0 case 0x0d00:=C2=A0=C2=A0=C2=A0 /* Haswell */
> > -=C2=A0=C2=A0=C2=A0 case 0x0f00:=C2=A0=C2=A0=C2=A0 /* Valleyview/Bay Tr=
ail */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 7;
> > -=C2=A0=C2=A0=C2=A0 case 0x1600:=C2=A0=C2=A0=C2=A0 /* Broadwell */
> > -=C2=A0=C2=A0=C2=A0 case 0x2200:=C2=A0=C2=A0=C2=A0 /* Cherryview */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 8;
> > -=C2=A0=C2=A0=C2=A0 case 0x1900:=C2=A0=C2=A0=C2=A0 /* Skylake */
> > -=C2=A0=C2=A0=C2=A0 case 0x3100:=C2=A0=C2=A0=C2=A0 /* Gemini Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0x5900:=C2=A0=C2=A0=C2=A0 /* Kaby Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0x3e00:=C2=A0=C2=A0=C2=A0 /* Coffee Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0x9B00:=C2=A0=C2=A0=C2=A0 /* Comet Lake */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 9;
> > -=C2=A0=C2=A0=C2=A0 case 0x8A00:=C2=A0=C2=A0=C2=A0 /* Ice Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0x4500:=C2=A0=C2=A0=C2=A0 /* Elkhart Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0x4E00:=C2=A0=C2=A0=C2=A0 /* Jasper Lake */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 11;
> > -=C2=A0=C2=A0=C2=A0 case 0x9A00:=C2=A0=C2=A0=C2=A0 /* Tiger Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0x4C00:=C2=A0=C2=A0=C2=A0 /* Rocket Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0x4600:=C2=A0=C2=A0=C2=A0 /* Alder Lake */
> > -=C2=A0=C2=A0=C2=A0 case 0xA700:=C2=A0=C2=A0=C2=A0 /* Raptor Lake */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 12;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return igd_devices[i].gen;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 /*
>=20


--=-9zRy1oGUFpooelTE0lzI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmeluq8ACgkQ2FTaVjFe
AmobfQ/+KMOFlCxA/0ofONQlQT/ujJB3j0H4tjpy1dFsMuReYv+9nr/2D94QKS2q
l0KZQZt+0oalJB48j2OzKK0aqlAVMxgqYY0ZcfhDOjPmHPm7/vXdaLPZMsGBsIPJ
uSoKtiXbLs7+3YjA5l2PI4+V2253CpfGuROyk/iXpDJrWdEb5rMICbEb30U3RDOp
kcAsM4ZuUjmVk/DVamOPYL3meTrY44ushD9pAPyDoqsoeFu0tA3JmeWUYXZsm9nI
eH4GGXFpRxGNZWFl+NhMgXIW1q3LTcy6log7paGmqscOXJRFZr70Z/+hgAPNPJ+p
MNdCx/bGKjoMpIFnmqhr916i9pSEwzVv84E2lH4+HOGmGth58NZ+m6V3LLKXnwho
J87Wc97IDE8NZeqZlOH0wus1l9RvK8hVQnoabGspGQvNT+fOwKrafjHNVd6OR2+/
ZS8r4TuZRm24VBH9ojiYT0IOIm4ESCsZi1C4KR9REgswhqkR8G/RyVzY9goL04dh
5mMzXvW1r4vdQkc9/Y7hA0YeVKUgX0cg/JT6FEhsYJAOJycpw9GSzJnDDNWFa8FW
DjIQy66Yfwo2zSKs4JX9sINc3WBFiXyQqOA+6OoVtFm1VvwN99W9bvkArdRImB1m
qD166auXyPUWO/h2ydPkwQFoYr6VnVoOt/TR8occApr4U+A3WHA=
=pUji
-----END PGP SIGNATURE-----

--=-9zRy1oGUFpooelTE0lzI--

