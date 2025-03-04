Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB21C282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpMXG-0001sZ-63; Tue, 04 Mar 2025 02:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tpMXC-0001rS-Nu
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:17:46 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tpMX5-00052G-0N
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:17:45 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390e88caa4dso2454018f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 23:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741072656; x=1741677456; darn=nongnu.org;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Hv9FQg1pr3JObiucW1oYEE0A4HPO8B+IKoNtb7njX3o=;
 b=cft7NLHhfpPc3EW7NLR3vjtshA9xD6kqkVPAqUCLtEb2QnN+hrdWJ3mGz6FVK/WGyo
 S1Kcag95slPq1Ghv07beISHJ5VQNErcEH+Nngm7Mba0qFjFSbFOx/ThWxMwjD5029yNw
 aGAdg3LjR6fTd6ClxJxFRQiGucWdKBr10ceJQoqkg/H6IKUjxt9T0+IKOAAPziZSyxqV
 518OdPqK/d406ZjEFSvcQWWjV9yCUIxnS/HRNoXB31w2/szlvK9ekntoQtfsZi21rP0X
 pkOTGOqRX/w6LpfCY5OfA5gR9ORsbxGBCAt6cEOMtF6uUYAJSW7MdSqZV84dVrbMSz9d
 4aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741072656; x=1741677456;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv9FQg1pr3JObiucW1oYEE0A4HPO8B+IKoNtb7njX3o=;
 b=ZLzP0PP4l+Oe2Xi5E3lDUhwFBwgqq7/Mky8f0eBDWqC5RPoPjmsAceybc8nwSCvsxJ
 xL6z7FqEQIIFoc0cpNCkemMfNCgbWejsLbE7ON3x/sPvwP2v1r0n2ZwuNaWa9IiD+vBP
 uUV4/tp2QFicsknt0UKKT8NnLzOLIT7CXwCb8kWnFY9oYafro9NiQTQwFieUTNV6PtEP
 3wlUutBKsmUvT5NYv1mAZ8K+yFwxzXN+qZLoKBXuCzPkXk/onkPrqcRKjfsjOyTM2sJQ
 Vif9W0fOnZqf6fqhyE3NncmYD5UooSSDE3+QfrJ/uEfoYZcrsg/Mjn1YSepVzuxyt9u4
 A8Nw==
X-Gm-Message-State: AOJu0YzFVC9DVmwPbs0htxJ17B/HhRxLx0+xF4AbOnRZ8pwOA3qfNB8m
 Z9IqXRgt9jkz75mUP1NASS6v9tSq/CiGU08OfAwO7U5ClqzxBxdo
X-Gm-Gg: ASbGnctxRvwVEu9vNvvCt9uWPa7cl31MgIpwXOuLEJXU4BDUAfCZBGaFelrZhJPI2MI
 P/Nxo3tAs66tu6byDpWVjYgLWp3enaApnxsV7KjZwy3CNag9Krbo03OFVtNP7BFMVJ2tiD8znid
 /VWBBrvg+XVzwFzEF1fKaOJLEOBy1kwNPOhKw4xSkU+WhLNsQDn4olLqnwpRPm3oBci5yf8Ldck
 rFSPz6hy0U5gokGpTGkKlTlQpejSWHfM3wX/PjEF0ORBNBV4tPOyq56ry0e4RRVPzUq89lDEKGM
 E/Dc7SkFM93Vshny/AqMo4hqphl2gNbc1V3WV+Sea8EhrzLRJ1/T3sxwNg==
X-Google-Smtp-Source: AGHT+IFFXgyZBh57ufbjs+1+G2n5ZNiPS2skRHD9+KbtjfzXwv4FQCzB+xQH8NUWMkXLq7Hg2ZKkNg==
X-Received: by 2002:a5d:6da3:0:b0:390:e9ea:59a with SMTP id
 ffacd0b85a97d-390ec7c8eb6mr13469849f8f.5.1741072655906; 
 Mon, 03 Mar 2025 23:17:35 -0800 (PST)
Received: from [172.21.179.157] ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e61csm16976351f8f.98.2025.03.03.23.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 23:17:35 -0800 (PST)
Message-ID: <e8a2be911535f345e8008b0dfccf8cd7a989578f.camel@gmail.com>
Subject: Re: [PATCH v2 2/9] vfio/igd: Do not include GTT stolen size in
 etc/igd-bdsm-size
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Tomita Moeko <tomitamoeko@gmail.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Tue, 04 Mar 2025 08:17:34 +0100
In-Reply-To: <20250303175220.74917-3-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
 <20250303175220.74917-3-tomitamoeko@gmail.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-KH8VXGOijFC5ezhed916"
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x42d.google.com
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


--=-KH8VXGOijFC5ezhed916
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-03-04 at 01:52 +0800, Tomita Moeko wrote:
> Though GTT Stolen Memory (GSM) is right below Data Stolen Memory (DSM)
> in host address space, direct access to GSM is prohibited, and it is
> not mapped to guest address space. Both host and guest accesses GSM
> indirectly through the second half of MMIO BAR0 (GTTMMADR).
>=20
> Guest firmware only need to reserve a memory region for DSM and program
> the BDSM register with the base address of that region, that's actually
> what both SeaBIOS[1] and OVMF does now.
>=20

When was this merged to OVMF?

> [1]
> https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit=
.c#L319-332
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 28 +++-------------------------
> =C2=A01 file changed, 3 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index ca3a32f4f2..dda4c7bb5d 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -112,28 +112,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
> =C2=A0
> =C2=A0#define IGD_GMCH_GEN6_GMS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 3=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SNB_GMCH in i915 */
> =C2=A0#define IGD_GMCH_GEN6_GMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1f
> -#define IGD_GMCH_GEN6_GGMS_SHIFT=C2=A0=C2=A0=C2=A0 8
> -#define IGD_GMCH_GEN6_GGMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0 0x3
> =C2=A0#define IGD_GMCH_GEN8_GMS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 8=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* BDW_GMCH in i915 */
> =C2=A0#define IGD_GMCH_GEN8_GMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xff
> -#define IGD_GMCH_GEN8_GGMS_SHIFT=C2=A0=C2=A0=C2=A0 6
> -#define IGD_GMCH_GEN8_GGMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0 0x3
> -
> -static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
> -{
> -=C2=A0=C2=A0=C2=A0 uint64_t ggms;
> -
> -=C2=A0=C2=A0=C2=A0 if (gen < 8) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> IGD_GMCH_GE=
N6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
> -=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> IGD_GMCH_GE=
N8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ggms !=3D 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =
=3D 1ULL << ggms;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 return ggms * MiB;
> -}
> =C2=A0
> =C2=A0static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
> =C2=A0{
> @@ -367,7 +347,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0 g_autofree struct vfio_region_info *lpc =3D NULL=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 PCIDevice *lpc_bridge;
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret, gen;
> -=C2=A0=C2=A0=C2=A0 uint64_t ggms_size, gms_size;
> +=C2=A0=C2=A0=C2=A0 uint64_t gms_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *bdsm_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t gmch;
> =C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
> @@ -527,7 +507,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 ggms_size =3D igd_gtt_memory_size(gen, gmch);
> =C2=A0=C2=A0=C2=A0=C2=A0 gms_size =3D igd_stolen_memory_size(gen, gmch);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> @@ -539,7 +518,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * config offset 0x5C.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size =3D g_malloc(sizeof(*bdsm_size));
> -=C2=A0=C2=A0=C2=A0 *bdsm_size =3D cpu_to_le64(ggms_size + gms_size);
> +=C2=A0=C2=A0=C2=A0 *bdsm_size =3D cpu_to_le64(gms_size);
> =C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-siz=
e",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size, sizeof(*bdsm_si=
ze));
> =C2=A0
> @@ -559,6 +538,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_quad(vdev->emula=
ted_config_bits + IGD_BDSM_GEN11, ~0);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ggms_size =
+ gms_size) / MiB);
> +=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, =
(gms_size / MiB));
> =C2=A0}


--=-KH8VXGOijFC5ezhed916
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmfGqQ4ACgkQ2FTaVjFe
Amr1Dw/7BPiAV/Z1wt1PXdvIh6EFnwC4b1A56zfe7J1Y4VGMDgPKhIRaQ6BS6kVE
JkK6/nMZM7fXemIMNZTwD0b1PjcK+sXjoxXM6J+VeA4FIEV15qG8ZHtEfo9YhFni
RVrbzSYyZQnI4+a5x7QWV0pjGealfCYP9PjZK03b624cDjhMEVkyKOIlKHCkH/co
9MN2GNEDmeXD72VPmUchf07bBSra/5HL3n6Sk2eA711d9HPsWAjeOyvt+5BGEGls
DgIvUwl/0/MSM+MKmbyIE30+TWkivtPzOz6V9Mk3gm8H7GFsPBcIw9l1SJFqEUyk
cY26jZci/97LGkfEyqZmVGhTX4cRRhtJZwEtRMudRy7KIw8T/oVUOtsakv74yw+o
ZeWVHlOzdK1F2JG1d8nkWvEpWKPiN0v52gBbs3lWQMAq1k4bFNJgN/+585ojKwLz
OQjve7bLoQBwhCeHZ3zbLIiwLxXr/JLX8vjD5UVbjsSHDnHWSCEk6DORUnbER2pG
Gq0YnbOAlCfIFw4hZXPm9WGu49OUfOtttHaRv/iTQb2uZxitNDeJ/8dsOSMvmagr
i/3VyWHMs+hqDOMFUX/8k6TDxfSiuvsr2QnZubj/MN03cAbnuuNhfKJ0oQZPALB/
ibmAk6FMo8Xu/sVUQ1IgA/5p8jBfjwqLXERHI0J/3lk7vwtSk4E=
=X1yA
-----END PGP SIGNATURE-----

--=-KH8VXGOijFC5ezhed916--

