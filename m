Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56779C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 22:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Rvz-0000r6-PG; Mon, 14 Apr 2025 18:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u4Rvv-0000qY-Sd
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 18:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u4Rvt-0000J2-MB
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 18:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744668335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebkJWADGWU7QqTV6dBZM2uagiBXaAaI4EgLlmUx2hm4=;
 b=D/51A4N2/mmeFjp1cH2bFo6gEvuvmHS3hf6yK2/6E18nre3crQwbKSsc5e5Taf7aLxPFaB
 LTYgGZVvrkOl5NEj8aXJg53SIM6o0e5rOafB2m4F6gm2EBdjCdubG5CjCOUVKUmuKQCJF+
 kVyT0lQ6dF+gxYeisAM3P+dQ/6EIa3c=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-vjV3MeV9MFyJRIzOYXm14w-1; Mon, 14 Apr 2025 18:05:33 -0400
X-MC-Unique: vjV3MeV9MFyJRIzOYXm14w-1
X-Mimecast-MFC-AGG-ID: vjV3MeV9MFyJRIzOYXm14w_1744668333
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3d59fc520edso5366475ab.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 15:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744668333; x=1745273133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebkJWADGWU7QqTV6dBZM2uagiBXaAaI4EgLlmUx2hm4=;
 b=uCGsW9vZmZ+tp/lH0zJsJAIuzNR4/FoG66aE6vNVZjW6PePcJs0lRFjHjMKjR9ZXwh
 iquxElj7Tf4Gc30F1Lx5oZ1XfQTiT3qjY2SzGazBfJkjJuQvlP5CekXTjzzwgFZvWGG4
 N687F2CFNqlCgHzzzEvh/q2d2ebjlVJBk1QvxmK0NFFxATnMrjaei7QoB4uMK+ZfSNEO
 Ox1UH3bwxu8L5h5Kh+FZenVqcampiTLNOGQGxKR8Y+A09QYrznJSTxEZem7tTI/bIJPs
 sfImJDOWh7niFuZDcNQ+/J2cKUwb5nHm6EdhcpBGdt7sBLRvUGu9PNM82EDUmOSBtta8
 Y15A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjTRNveoEEl8qFFzdAU7ulU2nz3ZLIQTRYIRNUCZXLE6cd2A13xCbWGCaldrg6obasrFXXETR6L6Kt@nongnu.org
X-Gm-Message-State: AOJu0Yxl8bC5sDtD6EfO2EcaYTCBDXgrYhjEMR9Ja8giW8Csi+MYsh9a
 hx1lfOEFGQgsPgnyqtunqyJ/ZXRvHmclrUVZdT1sTris3NK6/eluF8JrSwpLMtXMv4LM/m2os8s
 jwmc8drQcfSvn7cUZCScDFcfVcN9/CAlt6/+MNfOKLiS8niz/dxdz
X-Gm-Gg: ASbGncs2t5ScUIAkdWcUkMU2XNPEwjoSi0jDDmBQjR6pEjRqRq//eEJWl44z4l6fOtO
 rSYQnpS/+N58MNMM2Sci5g+7BvEyyb2FdVnLjWfnMvjINV9PXgn67NXl21ityDiN+/4Bw8YiI0m
 xiWGdHUvZUKjTWYAliPyZyW145ji1KhYlOGj8UXe7XKR4WY2tqrbOWT2e1Xe1f6oP11JnIVZPpt
 IOs8e4rOZXpMeih8T29k74J32HsBD+x2VKhDGhcup8oKVHISi/sxxUfH1N/KM8tYm8igTW3//8I
 ux0EwpRaaU0csfE=
X-Received: by 2002:a05:6e02:2161:b0:3d5:eb0e:be0e with SMTP id
 e9e14a558f8ab-3d7ec0e346cmr33136305ab.0.1744668333052; 
 Mon, 14 Apr 2025 15:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh7g01TX2XpLCMm51HwNeTk720gYCvHb2GDpmP8bULy/33rtMLwx4yezDblU8vVV3Q1tcQgA==
X-Received: by 2002:a05:6e02:2161:b0:3d5:eb0e:be0e with SMTP id
 e9e14a558f8ab-3d7ec0e346cmr33136195ab.0.1744668332671; 
 Mon, 14 Apr 2025 15:05:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505e2ece0sm2805054173.131.2025.04.14.15.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 15:05:31 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:05:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
Message-ID: <20250414160530.5d86aaf2.alex.williamson@redhat.com>
In-Reply-To: <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
 <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 14 Apr 2025 01:23:56 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> On 4/10/25 15:34, C=C3=A9dric Le Goater wrote:
> > + Corvin
> >=20
> > On 4/9/25 19:18, Alex Williamson wrote: =20
> >> On Wed, 26 Mar 2025 01:22:39 +0800
> >> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> >> =20
> >>> So far, all Intel VGA adapters, including discrete GPUs like A770 and
> >>> B580, were treated as IGD devices. While this had no functional impac=
t,
> >>> a error about "unsupported IGD device" will be printed when passthrou=
gh
> >>> Intel discrete GPUs.
> >>>
> >>> Since IGD devices must be at "0000:00:02.0", let's check the host PCI
> >>> address when probing.
> >>>
> >>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> >>> ---
> >>>   hw/vfio/igd.c | 23 +++++++++--------------
> >>>   1 file changed, 9 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> >>> index 265fffc2aa..ff250017b0 100644
> >>> --- a/hw/vfio/igd.c
> >>> +++ b/hw/vfio/igd.c
> >>> @@ -53,6 +53,13 @@
> >>>    * headless setup is desired, the OpRegion gets in the way of that.
> >>>    */
> >>>   +static bool vfio_is_igd(VFIOPCIDevice *vdev)
> >>> +{
> >>> +    return vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) &&
> >>> +           vfio_is_vga(vdev) &&
> >>> +           vfio_pci_host_match(&vdev->host, "0000:00:02.0");
> >>> +} =20
> >>
> >> vfio-pci devices can also be specified via sysfsdev=3D rather than hos=
t=3D,
> >> so at a minimum I think we'd need to test against vdev->vbasedev.name,
> >> as other callers of vfio_pci_host_match do.  For example building a
> >> local PCIHostDeviceAddress and comparing it to name.  This is also not
> >> foolproof though if we start taking advantage of devices passed by fd.
> >>
> >> Could we instead rely PCIe capabilities?  A discrete GPU should
> >> identify as either an endpoint or legacy endpoint and IGD should
> >> identify as a root complex integrated endpoint, or maybe older versions
> >> would lack the PCIe capability altogether. =20
> >=20
> > Maintaining a list of PCI IDs for Intel GPU devices as Corvin was
> > proposing in [1] is not a viable solution ?
> >=20
> > Thanks,
> >=20
> > C.
> >=20
> > [1] https://lore.kernel.org/qemu-devel/20250206121341.118337-1-corvin.k=
oehne@gmail.com/ =20
>=20
> I checked Intel doc, probably maintaining an device ID list is the only
> possible way. But given that intel is moving to xe driver, generation
> becomes unclear, I'd like to propose a list with quirk flags for igd.
>=20
> static const struct igd_device igd_devices[] =3D {
>     INTEL_SNB_IDS(IGD_DEVICE, OPREGION_QUIRK | BDSM_QUIRK),
>     INTEL_TGL_IDS(IGD_DEVICE, OPREGION_QUIRK | BDSM64_QUIRK),
> }
>=20
> Matching in the list is more time consuming than current switch-case,
> it's better to have a new field to cache it.
>=20
> I will go with Corvin's first 2 patches with reordering suggested by
> Cornelia.

If I recall the discussion correctly, Corvin's series was mapping device
IDs to generation, where I had the concern that it creates ongoing
overhead to sync with the i915 driver to create new mappings.  There
was a suggestion that newer hardware has a register that reports the
generation, so maybe we only need to manage creating the mapping table
up to the point we can rely on getting the generation information from
hardware (with the massive caveat that Intel could drop that generation
register in the future, or maybe already has).

The above table however suggests yet another use case of the table, a
mapping of quirks to specific devices.  It seems this once again
introduces the maintenance issue.  Why would it not be sufficient to
determine the quirks based on the generation alone?  Thanks,

Alex


