Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A35CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSKF-0004kH-0T; Mon, 08 Jun 2026 01:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWPYj-0002Zm-Hq
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 22:17:49 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWPYg-0005MS-O3
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 22:17:49 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-137dd3bb44eso92854c88.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 19:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780885064; cv=none;
 d=google.com; s=arc-20240605;
 b=a//BwIm++/bIjbr1K6PYpw51SF5CoSXk25nOgCekvngElX3EcIUh37mnM2MwxhaoFN
 b1R9gV9NHJnhJACb1H7xqHHXqAcSHTrab8BocnDXBz/1BiytjfqtjyJ8yiTmnAZY8qEn
 qt5yDnUOPfSd2vZnoKCiqrhF2kEfScsaphidm1lHTBo1+gXxQxD4Wv1+HQMgYFlDoUmb
 hgi4E1SFlSliKF1v1xdE/rrnlVcGUGsyxwZ30l9hoLF6bNmQ/FwkegObnpqSZqSbgeiR
 uLtp1/BRVlJcJ9jAtI4WxGYRBYUH9Y/ms8nLmjtWgAUX4eq9Eh4qJuXGmZ71WLfjt1WM
 z5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sCXu/xHfXBFJGczLiJlm23LVorWUvCYCprJMhYCZn+0=;
 fh=NBHpgcWB3jH5wNz+p8rbis5jnXIHCdFzq93A28pnix8=;
 b=Vf3oNVs2jtaw4gDCPodM4lXr2wDNlgMSiTZ7eakI3CpS1bgP/eGj7oddUxlOAzDnjE
 +j93hT8cLl75fyuxJXAoR3xPrVbN/uUJV7CqVCF3sssc5H/P1o/kNtxvc6/5f8MvTniD
 sho57zrFuZ+jvqgy94ZAbGD7d7oQSf7wLK0SJ6w8jR14OLc1UxNUz0sayGgIVQahR4vQ
 h75nQPZBm6k8jAfvT+2Crwi5EepojRux5a9futs3/392V7Z1obFLVFzmR3YSYoFlMeas
 cgyNKnJmYHzZL7YEmSaYVwuUmMoQoxBzEFJYydkH7DJCx/XdBc2xkrpum+IDOFlorjQO
 OcyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780885064; x=1781489864; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sCXu/xHfXBFJGczLiJlm23LVorWUvCYCprJMhYCZn+0=;
 b=ZLwyGiLrN6huiuSmllhRCjcLZMmHNauu0/oB0GMW8JpD1iUc06I1x/EAkftVFHVZyA
 Ly2GXunE313jiGnQCDh1rZ2i3IYmj/oFll1JFQU9Jee3VwVAj/0wwG/rwNQ9V+VcC4dv
 AOrMfErYBLe732ut2Q0rlMVr3hCT0S8itO/nfBIGmpPlBsvKCCyhNijt8n59EzquNaf6
 qM13JXFvfGTe/K/mPCBEDFwWUe/jd0JY5FU+qubCLg/TgILCESzpJFtSWFw/d5ZUe3SE
 jZb8y8I4hMRK0eWLPSzB0YpfAmaoxOXEDZ9PuE8ehHhaHS6iC3gfZ6gGiWykX9Vq2AuS
 qtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780885064; x=1781489864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCXu/xHfXBFJGczLiJlm23LVorWUvCYCprJMhYCZn+0=;
 b=Hr0MB3q4badTxcYc8yBT8AgTe56WhVuWdvcCjGa/+1pFv9uV4ekOg1x+IPpgqVti7Z
 A1MJdbeUc7+zS5j2b+AOGOei75YRWlE4VI6fowQIF5Rc0knurhNXNZjiGpgT5HTiN3pY
 8VhNVi3yTJrAZbJrO4X31LXfBN4lTdipySgHzyIl9RmeE5Ov39FCEjZYRFNh78ybPkYb
 zVlshK/w2uzvhUV0hpxCn5CS5zKFTeUtQFcM7pJasDG7ZdOGFtot7uBLfGqmy9DYG/D+
 WMGHV+tvvPyFapXmYe1c/2T+I6otzI0WlLFNQSp9f6LGbtfprG2z76sQz/UTas94gJ9c
 whJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s84btl3TG60U5h35wCXxzffB1m0ZHsWCjOPOHvgYZJVUxJ4GGmOO3LFKPg9/SYgm7tdmdkXIN+PXg@nongnu.org
X-Gm-Message-State: AOJu0YxdVPZHId58yl3G68QWlhYU5Z8T4tTaXqNAGbXJzW2x6Iq/EJ4/
 dmUPu0eZYUA87EvBROyyP1aa8BnDzHuj968LuNVlVgL81cQPnz1oy5Hibj6B1IMpdFkRes2g63T
 AIRTnl1VSCI5vnDMM8vSm4S7mcicOjYQ=
X-Gm-Gg: Acq92OHyZu9oWym/mue5ORjgDW6+9rmVDM3NOL0SQNiUt4FP2IIn8+CpGbvswfRlcUo
 /BvVBU9TWHxTbVsIH1oVZ654STyC28HhR1wYsm4IvG+ct2BfM/fDrrrX3Z8AM3opQzI3qSBszMF
 dHxqRl2DvI5Pr5ggdq57tA43LnCcwwqkhUgpWhAVq6jfoAO64itYFBBCFMHaM4Ju/h1Pb/cTFBT
 CJn+XqI/MqSTvUQbJXbfGNBfNcHhejUkbnWcYS34Z021ECGsWrUef5IxQhwOsxvWx6gjQxqfDQL
 oSP26vIR0ddrY36Go3+awin2ik+KfUbyTgLJlyTCj8bfqvZidpwwXdOftjFGJ2E=
X-Received: by 2002:a05:7022:ec3:b0:12c:900b:9dee with SMTP id
 a92af1059eb24-138067716f7mr2459660c88.1.1780885064260; Sun, 07 Jun 2026
 19:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-7-tomitamoeko@gmail.com>
 <20260605160224.32405a42@shazbot.org>
In-Reply-To: <20260605160224.32405a42@shazbot.org>
From: Kirandeep Maan <kirandeepmaan45@gmail.com>
Date: Mon, 8 Jun 2026 07:47:32 +0530
X-Gm-Features: AVVi8Cc0Bh4ZfaFJjhDBaNvkwqoSB0eXAA4P0BuZGiWQSJ3JS8pZqksW9H46NpI
Message-ID: <CAPd5Pt6RVJ72EOpjyzO4aFNaWF9Lcuavs7UHK3R6ORJCeyQHsQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: Alex Williamson <alex@shazbot.org>
Cc: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a4230c0653b49dcc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jun 2026 01:14:59 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000a4230c0653b49dcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, as these patches fixes legacy mode grabled grub screen they add
regression to UEFI guest where monitor won't woke up until grub timeout.

CMD used : -device
vfio-pci,host=3D00:02.0,id=3Digpu,addr=3D2.0,x-igd-legacy-mode=3Doff,x-igd-=
lpc=3Don,romfile=3D/home/maan/QemuVMs/MyGopRomfiles/InteligdGopHD4600.rom

romfile is patched with intelgopdriver.efi from VfioIgdPkg repo.

Here is what i915 logs say in guest with patched qemu :
[   10.823656] i915 0000:00:02.0: [drm] Found haswell (device ID 0412)
integrated display version 7.00 stepping N/A
[   10.824300] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   10.824763] i915 0000:00:02.0: vgaarb: deactivate vga console
[   10.824867] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[   10.824871] i915 0000:00:02.0: [drm] DMAR active, disabling use of
stolen memory
[   10.832111] i915 0000:00:02.0: Invalid PCI ROM header signature:
expecting 0xaa55, got 0x0000
[   10.832118] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT)
[   10.832154] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[   10.842837] i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
[   10.850377] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
[   11.678013] fbcon: i915drmfb (fb0) is primary device
[   11.748610] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device

So look like VBT table is not expose to guest.

These are the logs of stock qemu with working grub and all :
[   28.945622] i915 0000:00:02.0: [drm] Found haswell (device ID 0412)
integrated display version 7.00 stepping N/A
[   28.946393] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   28.961770] i915 0000:00:02.0: vgaarb: deactivate vga console
[   28.961830] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[   28.961833] i915 0000:00:02.0: [drm] DMAR active, disabling use of
stolen memory
[   29.016673] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[   29.051910] i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
[   29.055360] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[   29.903202] fbcon: i915drmfb (fb0) is primary device
[   29.990056] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device

Regards,
K S Maan

On Sat, 6 Jun 2026 at 03:32, Alex Williamson <alex@shazbot.org> wrote:

> On Thu,  4 Jun 2026 01:33:54 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index 17437ae18d..e00f6f8315 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -739,3 +739,109 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> >
> >      return vfio_pci_igd_config_quirk(vdev, errp);
> >  }
> > +
> > +/*
> > + * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM
> region,
> > + * which contains host modifications. In Gen 6-9 VBIOS, the routine
> below is
> > + * used to get BDSM value when programming the initial GTT.
> > + *   xx xx xx xx           v: .long ?                  # saved value
> > + *   66 53                    push  %ebx
> > + *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved valu=
e
> empty?
> > + *   74 07                    je    1f                 # if zero, go
> compute
> > + *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return
> saved value
> > + *   eb 0f                    jmp   2f
> > + *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0,
> offset 5E
> > + *   e8 xx xx                 call  pci_read_cfg_word
> > + *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16
> bits
> > + *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the resu=
lt
> > + *   66 5b                 2=EF=BC=9Apop   %ebx
> > + *   c3                       ret
> > + * When running the VBIOS in guest, saved value still reflects the hos=
t
> stolen
> > + * memory base address, which is not correct in guest. So we need to
> patch the
> > + * VBIOS to clear the saved value.
> > + *
> > + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov
> $0x105e,%ax`
> > + * anchors the match to the routine. Both `cs:` displacements must
> reference
> > + * the same offset.
> > + */
>
> Neat, cool quirk.
>
> > +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t
> rom_size,
> > +                                     uint16_t *bdsm_offset)
> > +{
> > +    static const uint8_t start[] =3D { 0x66, 0x2e, 0x83, 0x3e };
> > +    static const uint8_t middle[] =3D { 0x00, 0x74, 0x07, 0x66, 0x2e,
> 0xa1 };
> > +    static const uint8_t end[] =3D { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
> > +    size_t i;
> > +    bool found =3D false;
> > +
> > +    if (rom_size < 19) {
> > +        return -ENOENT;
> > +    }
> > +
> > +    for (i =3D 0; i + 19 <=3D rom_size; i++) {
> > +        if (memcmp(rom + i, start, sizeof(start)) !=3D 0 ||
> > +            memcmp(rom + i + 6, middle, sizeof(middle)) !=3D 0 ||
> > +            memcmp(rom + i + 14, end, sizeof(end)) !=3D 0) {
> > +            continue;
> > +        }
> > +
> > +        /* same saved value address? */
> > +        if (rom[i + 4] !=3D rom[i + 12] || rom[i + 5] !=3D rom[i + 13]=
) {
> > +            continue;
> > +        }
> > +
> > +        if (found) {
> > +            return -EEXIST;
> > +        }
> > +
> > +        *bdsm_offset =3D rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
>
> This needs a bounds check to make sure it's still within the ROM,
> either here or before the memset().
>
> > +        found =3D true;
> > +    }
> > +
> > +    if (!found) {
> > +        return -ENOENT;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> > +{
> > +    int ret, gen;
> > +    uint16_t pcir_offset, bdsm_offset =3D 0;
> > +    uint8_t checksum;
> > +
> > +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> > +        !vfio_is_vga(vdev) || !vdev->vga) {
> > +        return;
> > +    }
> > +
> > +    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
> > +    gen =3D igd_gen(vdev);
> > +    if (gen < 6 || gen > 9) {
> > +        return;
> > +    }
> > +
> > +    if (pci_get_word(vdev->rom) !=3D 0xaa55) {
> > +        return;
> > +    }
> > +
> > +    /* Must be a legacy ROM */
> > +    pcir_offset =3D pci_get_word(vdev->rom + 0x18);
> > +    if (pcir_offset >=3D vdev->rom_size ||
>
> This gates the below test to pcir_offset + 0x14, so should be:
>
>        if (pcir_offset + 0x14 >=3D vdev->rom_size ||
>
> > +        memcmp(vdev->rom + pcir_offset, "PCIR", 4) ||
> > +        pci_get_byte(vdev->rom + pcir_offset + 0x14) !=3D 0x00) {
> > +        return;
> > +    }
> > +
> > +    ret =3D igd_vbios_find_saved_bdsm(vdev->rom, vdev->rom_size,
> &bdsm_offset);
> > +    if (ret < 0) {
> > +        return;
> > +    }
> > +
> > +    memset(vdev->rom + bdsm_offset, 0, sizeof(uint32_t));
> > +
> > +    checksum =3D pci_rom_calculate_checksum(vdev->rom, vdev->rom_size)=
;
> > +    ((uint8_t *)vdev->rom)[6] =3D checksum;
>
> If updated per previous recommendation, this becomes:
>
>         ((uint8_t *)vdev->rom)[6] -=3D checksum;
>
> Thanks,
> Alex
>

--000000000000a4230c0653b49dcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, as these patches fixes legacy mode grabled=C2=A0grub s=
creen they add regression to UEFI guest where monitor won&#39;t woke up unt=
il grub timeout.<br><br>CMD used : -device vfio-pci,host=3D00:02.0,id=3Digp=
u,addr=3D2.0,x-igd-legacy-mode=3Doff,x-igd-lpc=3Don,romfile=3D/home/maan/Qe=
muVMs/MyGopRomfiles/InteligdGopHD4600.rom=C2=A0<br><br>romfile is patched w=
ith intelgopdriver.efi=C2=A0from=C2=A0VfioIgdPkg=C2=A0repo.<br><br>Here is =
what i915 logs say in guest with patched qemu :<br>[ =C2=A0 10.823656] i915=
 0000:00:02.0: [drm] Found haswell (device ID 0412) integrated display vers=
ion 7.00 stepping N/A<br>[ =C2=A0 10.824300] i915 0000:00:02.0: [drm] VT-d =
active for gfx access<br>[ =C2=A0 10.824763] i915 0000:00:02.0: vgaarb: dea=
ctivate vga console<br>[ =C2=A0 10.824867] i915 0000:00:02.0: [drm] Using T=
ransparent Hugepages<br>[ =C2=A0 10.824871] i915 0000:00:02.0: [drm] DMAR a=
ctive, disabling use of stolen memory<br>[ =C2=A0 10.832111] i915 0000:00:0=
2.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000<br>[ =
=C2=A0 10.832118] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT=
)<br>[ =C2=A0 10.832154] i915 0000:00:02.0: vgaarb: VGA decodes changed: ol=
ddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem<br>[ =C2=A0 10.842837] i91=
5 0000:00:02.0: [drm] Registered 3 planes with drm panic<br>[ =C2=A0 10.850=
377] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0<br>[ =C2=A0 1=
1.678013] fbcon: i915drmfb (fb0) is primary device<br>[ =C2=A0 11.748610] i=
915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device<br><br>So look l=
ike VBT table is not expose to guest.<br><br>These are the logs of stock qe=
mu with working grub and all :<br>[ =C2=A0 28.945622] i915 0000:00:02.0: [d=
rm] Found haswell (device ID 0412) integrated display version 7.00 stepping=
 N/A<br>[ =C2=A0 28.946393] i915 0000:00:02.0: [drm] VT-d active for gfx ac=
cess<br>[ =C2=A0 28.961770] i915 0000:00:02.0: vgaarb: deactivate vga conso=
le<br>[ =C2=A0 28.961830] i915 0000:00:02.0: [drm] Using Transparent Hugepa=
ges<br>[ =C2=A0 28.961833] i915 0000:00:02.0: [drm] DMAR active, disabling =
use of stolen memory<br>[ =C2=A0 29.016673] i915 0000:00:02.0: vgaarb: VGA =
decodes changed: olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem<br>[ =
=C2=A0 29.051910] i915 0000:00:02.0: [drm] Registered 3 planes with drm pan=
ic<br>[ =C2=A0 29.055360] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on =
minor 1<br>[ =C2=A0 29.903202] fbcon: i915drmfb (fb0) is primary device<br>=
[ =C2=A0 29.990056] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer de=
vice<br><br>Regards,<br style=3D"font-family:&quot;Google Sans&quot;,Arial,=
sans-serif;font-size:16px;margin:0px;border-bottom:0px rgb(230,232,240)">K =
S Maan</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, 6 Jun 2026 at 03:32, Alex Williamson =
&lt;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu,=C2=A0 4 Jun=
 2026 01:33:54 +0800<br>
Tomita Moeko &lt;<a href=3D"mailto:tomitamoeko@gmail.com" target=3D"_blank"=
>tomitamoeko@gmail.com</a>&gt; wrote:<br>
&gt; diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c<br>
&gt; index 17437ae18d..e00f6f8315 100644<br>
&gt; --- a/hw/vfio/igd.c<br>
&gt; +++ b/hw/vfio/igd.c<br>
&gt; @@ -739,3 +739,109 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *=
vdev, Error **errp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return vfio_pci_igd_config_quirk(vdev, errp);<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM=
 region,<br>
&gt; + * which contains host modifications. In Gen 6-9 VBIOS, the routine b=
elow is<br>
&gt; + * used to get BDSM value when programming the initial GTT.<br>
&gt; + *=C2=A0 =C2=A0xx xx xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v:=
 .long ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # sa=
ved value<br>
&gt; + *=C2=A0 =C2=A066 53=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 push=C2=A0 %ebx<br>
&gt; + *=C2=A0 =C2=A066 2e 83 3e xx xx 00=C2=A0 =C2=A0 =C2=A0cmpl=C2=A0 $0x=
0,%cs:v=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# is saved value empty?<br>
&gt; + *=C2=A0 =C2=A074 07=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 je=C2=A0 =C2=A0 1f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0# if zero, go compute<br>
&gt; + *=C2=A0 =C2=A066 2e a1 xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mov=C2=A0 =C2=A0%cs:v,%eax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# else retur=
n saved value<br>
&gt; + *=C2=A0 =C2=A0eb 0f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 jmp=C2=A0 =C2=A02f<br>
&gt; + *=C2=A0 =C2=A0b8 5e 10=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1: mov=C2=A0 =C2=A0$0x105e,%ax=C2=A0 =C2=A0 =C2=A0 =C2=A0 # dev 00:02.0=
, offset 5E<br>
&gt; + *=C2=A0 =C2=A0e8 xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0call=C2=A0 pci_read_cfg_word<br>
&gt; + *=C2=A0 =C2=A066 c1 e0 10=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 shl=C2=A0 =C2=A0$0x10,%eax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# left s=
hift 16 bits<br>
&gt; + *=C2=A0 =C2=A066 2e a3 xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mov=C2=A0 =C2=A0%eax,%cs:v=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# save the r=
esult<br>
&gt; + *=C2=A0 =C2=A066 5b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02=EF=BC=9Apop=C2=A0 =C2=A0%ebx<br>
&gt; + *=C2=A0 =C2=A0c3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret<br>
&gt; + * When running the VBIOS in guest, saved value still reflects the ho=
st stolen<br>
&gt; + * memory base address, which is not correct in guest. So we need to =
patch the<br>
&gt; + * VBIOS to clear the saved value.<br>
&gt; + *<br>
&gt; + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x1=
05e,%ax`<br>
&gt; + * anchors the match to the routine. Both `cs:` displacements must re=
ference<br>
&gt; + * the same offset.<br>
&gt; + */<br>
<br>
Neat, cool quirk.<br>
<br>
&gt; +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_s=
ize,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t *bd=
sm_offset)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static const uint8_t start[] =3D { 0x66, 0x2e, 0x83, 0x=
3e };<br>
&gt; +=C2=A0 =C2=A0 static const uint8_t middle[] =3D { 0x00, 0x74, 0x07, 0=
x66, 0x2e, 0xa1 };<br>
&gt; +=C2=A0 =C2=A0 static const uint8_t end[] =3D { 0xeb, 0x0f, 0xb8, 0x5e=
, 0x10 };<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +=C2=A0 =C2=A0 bool found =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (rom_size &lt; 19) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOENT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i + 19 &lt;=3D rom_size; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memcmp(rom + i, start, sizeof(start))=
 !=3D 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcmp(rom + i + 6, middle,=
 sizeof(middle)) !=3D 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcmp(rom + i + 14, end, s=
izeof(end)) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* same saved value address? */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rom[i + 4] !=3D rom[i + 12] || rom[i =
+ 5] !=3D rom[i + 13]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (found) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EEXIST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *bdsm_offset =3D rom[i + 4] | ((uint16_t)=
rom[i + 5] &lt;&lt; 8);<br>
<br>
This needs a bounds check to make sure it&#39;s still within the ROM,<br>
either here or before the memset().<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 found =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!found) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOENT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int ret, gen;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pcir_offset, bdsm_offset =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint8_t checksum;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID)=
 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !vfio_is_vga(vdev) || !vdev-&gt;vga) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Only Gen 6~9 devices have legacy VBIOS as Option ROM=
 */<br>
&gt; +=C2=A0 =C2=A0 gen =3D igd_gen(vdev);<br>
&gt; +=C2=A0 =C2=A0 if (gen &lt; 6 || gen &gt; 9) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (pci_get_word(vdev-&gt;rom) !=3D 0xaa55) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Must be a legacy ROM */<br>
&gt; +=C2=A0 =C2=A0 pcir_offset =3D pci_get_word(vdev-&gt;rom + 0x18);<br>
&gt; +=C2=A0 =C2=A0 if (pcir_offset &gt;=3D vdev-&gt;rom_size ||<br>
<br>
This gates the below test to pcir_offset + 0x14, so should be:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pcir_offset + 0x14 &gt;=3D vdev-&gt;rom_size=
 ||<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcmp(vdev-&gt;rom + pcir_offset, &quot;=
PCIR&quot;, 4) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_get_byte(vdev-&gt;rom + pcir_offset +=
 0x14) !=3D 0x00) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D igd_vbios_find_saved_bdsm(vdev-&gt;rom, vdev-&g=
t;rom_size, &amp;bdsm_offset);<br>
&gt; +=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(vdev-&gt;rom + bdsm_offset, 0, sizeof(uint32_t))=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 checksum =3D pci_rom_calculate_checksum(vdev-&gt;rom, v=
dev-&gt;rom_size);<br>
&gt; +=C2=A0 =C2=A0 ((uint8_t *)vdev-&gt;rom)[6] =3D checksum;<br>
<br>
If updated per previous recommendation, this becomes:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint8_t *)vdev-&gt;rom)[6] -=3D checksum;<br>
<br>
Thanks,<br>
Alex<br>
</blockquote></div>

--000000000000a4230c0653b49dcc--

