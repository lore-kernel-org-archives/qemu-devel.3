Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weojc-0007YS-D8; Wed, 01 Jul 2026 02:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1weojb-0007YK-HF
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:47:47 -0400
Received: from mail-dy2-x01.google.com ([2607:f8b0:4864:36::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1weojZ-0005sr-TI
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:47:47 -0400
Received: by mail-dy2-x01.google.com with SMTP id
 5a478bee46e88-30ec3bbd7easo127179eec.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782888464; cv=none;
 d=google.com; s=arc-20260327;
 b=gqen3aT7gTe9SJ2rBKnQZbmkaIPJH2eLjKaH7rS4535xPZiOv88Gjdh/pwIz7FS4Rk
 ix5qDRBn5Scdo0i9I7lP7+nyVzcItyBx0jqIneZGPQGYfinGAhB5I2Ys3tWbLNDsRJNu
 TWTknN4vKYB4hZrB8TpcpJW0LPFsSJ6MSr0sk8Lzp3IKg/TtYrp3B9gkbzV38KDfpBnl
 UP61V76+BIBbEApA0SaiQmrSX0224DzIA/DMNcxzxMl+VFCCd3nbUZr3FKMWrxP7X4Xr
 1+AYJk9cxoh2mjf0bIggSj42fOEtWlT4rQU2mDshT1Pquszqjv/ckJMBEA8IdJjWeAeI
 kbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1qV7tcto+MoOqtkwiGPJaneLqZHb0D4RH1cEL7txYKY=;
 fh=xD3U/lq/RbPvvuU9ttebvD2SUzAJpF9b362HY4Sc478=;
 b=sKDEiSl7EOvdEjrXwErpDWtdJna1dI9cqU83BR6V6vwUfiBHgSzBRNMtPu1w1Af2OR
 7SgISuWo9+SF6PWXOX51/srywEnzGUtAaZL1yV6R/SYYUG4FS6CJMox50kfjCdVTlyEg
 chrf5iGQit82UF5ilhLomqb1D5SOMH0MaO8eo3du5uWH9t+APVsFc9uaQTnFGMknufk6
 TKlxLGQaRisowzciyzzwn0b7SVTPJpMges6G/VcqnvNq+vY9k8x6sZuFyiZHHjqvatZp
 VjXWooJnSmUgIDmxrbAVVCTo0NxPp4iH4PGiWBysWXnkGV8gTptuYBhdcT+MZx1ZKsoB
 5i8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782888464; x=1783493264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qV7tcto+MoOqtkwiGPJaneLqZHb0D4RH1cEL7txYKY=;
 b=sT8uq5GgWdbXn4/ktOOqPpftdiVpklIOFrtPLMIf98LUQi1+1LQ9a3uukChBSysB+Q
 WTM06ZOMKLo/6Xu++GEBrQh0HBRU/G3dyZpxwXFOexudXt6wLG4GKz/mLAGyWgYrvpr5
 F7un9opjWPS+q/T8a9xtd9/Hr2vlKIPtcx18/ZDsUd73d6Lf1zObUgQwwfflvANHLyi7
 vgX5hEtfJ8OOAXBt1oHsw4hpygKhJeYmuIutMqiN813yQilRQpDCbwfyEnhLdpnrxxhL
 HgNH20oUwv/cMDgmx2EOvBls/ZFrNb4rp1zmk4MzrNt+H0iBUc7bfZfiui2sLjAks3vF
 0G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782888464; x=1783493264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1qV7tcto+MoOqtkwiGPJaneLqZHb0D4RH1cEL7txYKY=;
 b=BEGHFFUCwW1HmuDFdDBev8+IBlJUqISCwQ3lPhNzW8/kKLJUGBC3cWiDaWRIaE7cIK
 L7DCZKKYKcTXPzE+U1GqUfkSZpfbtaEXNcZig9ah9PhYYl3xU3/NTHLdfQonHocTr1/Y
 /3Fb4W8/OwHuKZqgkx5lV4eJvBgqNFe+MybfSBzgfTCRz1N7RpgkOIa7kjdnqyr9BBn/
 TkT7hUVF/lL0IjKgajkH+eYMnCHN1y+uS5axVY6WKJTyCvcHMKV5zt5rC0biLwPopSi2
 L7YB/U7DG/dl9M41VpLLY3aPCuQqWWjasSUz4J5gdusCR3kW3rSirCDVv3Ewbudk3Hfk
 w87w==
X-Gm-Message-State: AOJu0YzU1/rsiNgYJO4mj7CCywnLFok4nwTc0cBen1Z2xf415Yxk80gm
 4GwhlmnXUg5YVYhaTV4QAesDt2S1D7dq1cKO36cmg92LpRP7CSZGNYz0y05sMGEFAlqyxS8dSNf
 Q6O7CY+0tUE4XXSIxSnWksix6jA1ahQ==
X-Gm-Gg: AfdE7cntOZxlh3bcl6m/WmZtA0X+HCFXBrbHh3t6NYE2ALP+HeN6DzUrbZtHmlDCNQ5
 ymIDAqVTuaz6WaOX4hfCqjKv3ughO616kYcDnOL63YccmkIPq4v8BeQRoXv/PB3WHWC+QT2pEsm
 5QiKV7oi4kEuCpPXZCMaCbNysWRIK6Lq6QDcR0jXVynt0J+8vGzrMSM8X00Tkjy3OArTIyoAaLX
 8Ms1BTM/D6EEejPP78eu4Qgtnv6CjjHT91axxKzd927/0LnSO0Z5ukt3sl8cm3kSnJbixRAeQ==
X-Received: by 2002:a05:7300:8182:b0:30e:cb91:65ae with SMTP id
 5a478bee46e88-30eff2ddd98mr605596eec.22.1782888463701; Tue, 30 Jun 2026
 23:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <20260617100646.28326-2-tomitamoeko@gmail.com>
 <20260626062248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260626062248-mutt-send-email-mst@kernel.org>
From: Moeko Tomita <tomitamoeko@gmail.com>
Date: Wed, 1 Jul 2026 14:47:30 +0800
X-Gm-Features: AVVi8CcgtVX04QLRnHHqZCI2Nq1EbngQ49rZ6oHUv5RwpmvaCZY9YSxr9Mgili4
Message-ID: <CAJ+pfRS5A+KMZN+c4SCDxcr1PuqdC1Ci7yiJieAR8Rxgiut=HQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] hw/pci: Recalculate option ROM checksum before
 patching ID
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 K S Maan <kirandeepmaan45@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:36::1;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy2-x01.google.com
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

pci_patch_ids() is only called for ROMs flagged rom_need_patch_id
(only ipxe roms
and IGD), the scope is still limited and won't potentially impact
other existing functions,
it's safe doing it here.

The fix is targeted on IGD romfile, which can't easily go in vfio.
vfio_pci_size_rom()
simply lets PCI core to handle the romfile and never touches or sees the ro=
mfile
itself. Adding a hook in vfio brings extra code duplication and complexity.

Moeko

On Fri, Jun 26, 2026 at 6:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jun 17, 2026 at 06:06:38PM +0800, Tomita Moeko wrote:
> > pci_patch_ids() only adjusts checksum based on the new IDs. For an
> > option ROM with invalid checksum, the patched one will still have
> > an invalid checksum. Always calculate the checksum and patch it if
> > necessary to ensure the option ROM is valid.
> >
> > This is intended for fixing the romfile used in IGD passthrough as
> > multiple IGD devices share the same rom with possible non-matching
> > device ID, and its checksum is known to be bogus [1].
> >
> > A helper function pci_rom_calculate_checksum() is added and exported
> > for reusing in IGD-specific quirk later.
> >
> > [1] hw/vfio/pci.c:1090
> >
> > Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> > Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>
> This seems very aggressive.
> Why not recalculate in vfio then?
> It has a chance to do a targeted fix.
>
> > ---
> >  hw/pci/pci.c         | 32 +++++++++++++++++++++++---------
> >  include/hw/pci/pci.h |  2 ++
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index cec065d108..601d65aef3 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2479,6 +2479,18 @@ static uint8_t pci_find_capability_at_offset(PCI=
Device *pdev, uint8_t offset)
> >      return found;
> >  }
> >
> > +uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
> > +{
> > +    uint8_t checksum =3D 0;
> > +    uint32_t i;
> > +
> > +    for (i =3D 0; i < size; i++) {
> > +        checksum +=3D ptr[i];
> > +    }
> > +
> > +    return checksum;
> > +}
> > +
> >  /* Patch the PCI vendor and device ids in a PCI rom image if necessary=
.
> >     This is needed for an option rom which is used for more than one de=
vice. */
> >  static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size=
)
> > @@ -2514,25 +2526,27 @@ static void pci_patch_ids(PCIDevice *pdev, uint=
8_t *ptr, uint32_t size)
> >      trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
> >                                rom_vendor_id, rom_device_id);
> >
> > -    checksum =3D ptr[6];
> > +    /* In case the checksum is bogus */
> > +    checksum =3D pci_rom_calculate_checksum(ptr, size);
> >
> >      if (vendor_id !=3D rom_vendor_id) {
> >          /* Patch vendor id and checksum (at offset 6 for etherboot rom=
s). */
> > -        checksum +=3D (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id=
 >> 8);
> > -        checksum -=3D (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
> > -        trace_pci_rom_checksum_change(ptr[6], checksum);
> > -        ptr[6] =3D checksum;
> > +        checksum +=3D (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
> > +        checksum -=3D (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id=
 >> 8);
> >          pci_set_word(ptr + pcir_offset + 4, vendor_id);
> >      }
> >
> >      if (device_id !=3D rom_device_id) {
> >          /* Patch device id and checksum (at offset 6 for etherboot rom=
s). */
> > -        checksum +=3D (uint8_t)rom_device_id + (uint8_t)(rom_device_id=
 >> 8);
> > -        checksum -=3D (uint8_t)device_id + (uint8_t)(device_id >> 8);
> > -        trace_pci_rom_checksum_change(ptr[6], checksum);
> > -        ptr[6] =3D checksum;
> > +        checksum +=3D (uint8_t)device_id + (uint8_t)(device_id >> 8);
> > +        checksum -=3D (uint8_t)rom_device_id + (uint8_t)(rom_device_id=
 >> 8);
> >          pci_set_word(ptr + pcir_offset + 6, device_id);
> >      }
> > +
> > +    if (checksum) {
> > +        trace_pci_rom_checksum_change(ptr[6], ptr[6] - checksum);
> > +        ptr[6] -=3D checksum;
> > +    }
> >  }
> >
> >  /* Add an option rom for the device */
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 5b179091de..2d8a4ad0eb 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -1103,4 +1103,6 @@ void pci_set_enabled(PCIDevice *pci_dev, bool sta=
te);
> >  void pci_set_power(PCIDevice *pci_dev, bool state);
> >  int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
> >
> > +uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size);
> > +
> >  #endif
> > --
> > 2.53.0
>

