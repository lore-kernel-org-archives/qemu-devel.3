Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8AACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDdwu-0000rb-D0; Tue, 28 Oct 2025 03:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDdws-0000qh-Og
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:16:54 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDdwn-0002i2-Kg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:16:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so1054558066b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761635807; x=1762240607; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zB+81qr5fyzRi3t9mH0+KlO4414dUIRjUl8O7kRsM+k=;
 b=ND28aKaq3bADjhJVytKcvnTxTEH85qIQoyRBV7HBYIrZhNpar8mywnxnyT7Vh6vbra
 zGiFX0rM/jzmbQnC7ypSMOosOMfqzhFyxTYMJm+E5RiqgpPTZfDbYPnVVAUeLX+SCtJx
 MjFHGdulPRjmNavfwTprqPjycXBWhgKnASDRCKSIlExWtEzPpYvJoDDuh2BR3feA2twx
 SEvXZpzMIQlaaM3m93lEwvcApey2wgOBT0PqF/dUWoFvSQF0BegkdguLd75YnqXljx/5
 jKTbdHDISC4JuVXOt4b69PS6sixdzu464WFwhsm/nam5YI5IAuK0S5YLOZdmLqy5BEJ3
 VeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761635807; x=1762240607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zB+81qr5fyzRi3t9mH0+KlO4414dUIRjUl8O7kRsM+k=;
 b=HaruacqHR0FQIA3bU5PE0i6uceYMsT8Otfya3dWSD7Noj+jq390n9wrozq+W45CW5u
 802zf0V1TCqxchW9VDZPLg4rICOxk+oNVBLUM48oLJkZE7VSXafNCgcjhzzk2l2+eal/
 6DPa+gJF7/B7wlXOQ0U6HEMfYysPo1p09h2XBnewTtr4hBp+x8rvsYpb8LJO5I2IiIIA
 1ITXKiVHCz0K6murFrltnwX3uyduO6LMjG1u58oQVOxbVHhUnvTGZs1S6YJD8Q0bl4XL
 hThYBxMK0Z0DbCN9MigcSyH4Twev7PRc0C7r6C5hk1uMBZPPDQTrLV5HlWl+mZrsgzXD
 sGbA==
X-Gm-Message-State: AOJu0YwVAtA4s7UXK2wwloqBWMKL2D/nhCOpoN2SLieiNqGqH0ztU1Ma
 SWYEeFIa6InWcJq+c7YjX5HDPRyx4YIMmOqA58n5KSUE5RX/i+VN0s//UzIj2R3W95PQNv7x/tz
 6fHnE+LLdEa7DWsSWsuCl/VY01v713g0=
X-Gm-Gg: ASbGnct4JjEwHkfqGpsCkp5iUjJ4LBhRGNANFIlG/QJOICGuBsArpi72G+SqoeTHKLK
 U2cbXSDP3AifxvfwuSGgVdZzwvNAQNMXEWzBoHebY9iqBJcFOKSAAdnxA4LHBGUQfpIchYVqnyb
 lSGGfQHhJmApJsrF3OUOl5xz1Hd2ZJDpzp1Ab9pCxn80qdxDy01XgC7g0v7JKPUvRqlxGb8mdlA
 bAZ+Af8anx/jAE5B3EGxHdx2SxHfoAh+/Q7EVphLZMetrdKq59qqNq7k9+idMvoclHHOPC47wQy
 iZb2uKwZ4j2MJfmsX28Z8m5pabc=
X-Google-Smtp-Source: AGHT+IGUT0mUMBlAFpIk7Uw371kmagbxrKKwUGJQVOvWp2MTBTBhvoA7xFVx57DkJg2tsgUwltvTZj9rcB3vX+ZyBbw=
X-Received: by 2002:a17:907:1b22:b0:b42:9840:eac1 with SMTP id
 a640c23a62f3a-b6dba55c48fmr268141066b.49.1761635806450; Tue, 28 Oct 2025
 00:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251027112306.57634-1-philmd@linaro.org>
In-Reply-To: <20251027112306.57634-1-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 11:16:30 +0400
X-Gm-Features: AWmQ_bkROYGAvMhgKZM_C4h-8F7-NuAcB_I38QjM8k4bTkHHodupVhTJTizl7Qc
Message-ID: <CAJ+F1CKRRQY9w=e8XnxxMNTLoJqWiN-TBtu7qV_+2pAaEhM5fA@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent
 class_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paul Burton <paulburton@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Aditya Gupta <adityag@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 27, 2025 at 3:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> No need to set DEVICE_CATEGORY_BRIDGE for each device
> implementing TYPE_PCI_HOST_BRIDGE: set it once in the
> parent.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

this will also categorize a bunch of devices

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/pci-host/articia.c     | 1 -
>  hw/pci-host/aspeed_pcie.c | 1 -
>  hw/pci-host/designware.c  | 3 ---
>  hw/pci-host/gpex.c        | 2 --
>  hw/pci-host/grackle.c     | 1 -
>  hw/pci-host/gt64120.c     | 1 -
>  hw/pci-host/mv64361.c     | 1 -
>  hw/pci-host/pnv_phb.c     | 1 -
>  hw/pci-host/ppce500.c     | 1 -
>  hw/pci-host/q35.c         | 1 -
>  hw/pci-host/raven.c       | 1 -
>  hw/pci-host/remote.c      | 1 -
>  hw/pci-host/sabre.c       | 1 -
>  hw/pci-host/uninorth.c    | 4 ----
>  hw/pci-host/xilinx-pcie.c | 2 --
>  hw/pci/pci_host.c         | 1 +
>  16 files changed, 1 insertion(+), 22 deletions(-)
>
> diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
> index cc65aac2a87..47f223879f0 100644
> --- a/hw/pci-host/articia.c
> +++ b/hw/pci-host/articia.c
> @@ -200,7 +200,6 @@ static void articia_class_init(ObjectClass *klass, co=
nst void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D articia_realize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>
>  /* TYPE_ARTICIA_PCI_HOST */
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index f7593444fc4..2499d3fe680 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -312,7 +312,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *kl=
ass, const void *data)
>      dc->desc =3D "ASPEED PCIe RC";
>      dc->realize =3D aspeed_pcie_rc_realize;
>      dc->fw_name =3D "pci";
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>
>      hc->root_bus_path =3D aspeed_pcie_rc_root_bus_path;
>      device_class_set_props(dc, aspeed_pcie_rc_props);
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index f6e49ce9b8d..b0b51ad9517 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -593,8 +593,6 @@ static void designware_pcie_root_class_init(ObjectCla=
ss *klass,
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -
>      k->vendor_id =3D PCI_VENDOR_ID_SYNOPSYS;
>      k->device_id =3D 0xABCD;
>      k->revision =3D 0;
> @@ -736,7 +734,6 @@ static void designware_pcie_host_class_init(ObjectCla=
ss *klass,
>
>      hc->root_bus_path =3D designware_pcie_host_root_bus_path;
>      dc->realize =3D designware_pcie_host_realize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>      dc->vmsd =3D &vmstate_designware_pcie_host;
>  }
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index b806a2286f7..5f809028be2 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -200,7 +200,6 @@ static void gpex_host_class_init(ObjectClass *klass, =
const void *data)
>      hc->root_bus_path =3D gpex_host_root_bus_path;
>      dc->realize =3D gpex_host_realize;
>      dc->unrealize =3D gpex_host_unrealize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>      device_class_set_props(dc, gpex_host_properties);
>  }
> @@ -242,7 +241,6 @@ static void gpex_root_class_init(ObjectClass *klass, =
const void *data)
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->desc =3D "QEMU generic PCIe host bridge";
>      dc->vmsd =3D &vmstate_gpex_root;
>      k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index f9da5a908c1..fa872c17e3b 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -140,7 +140,6 @@ static void grackle_class_init(ObjectClass *klass, co=
nst void *data)
>
>      dc->realize =3D grackle_realize;
>      device_class_set_props(dc, grackle_properties);
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>      sbc->explicit_ofw_unit_address =3D grackle_ofw_unit_address;
>  }
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index b1d96f62fe9..bffa1165580 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -1298,7 +1298,6 @@ static void gt64120_class_init(ObjectClass *klass, =
const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      device_class_set_props(dc, gt64120_properties);
>      dc->realize =3D gt64120_realize;
>      device_class_set_legacy_reset(dc, gt64120_reset);
> diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
> index e05b6770102..e5e6614b139 100644
> --- a/hw/pci-host/mv64361.c
> +++ b/hw/pci-host/mv64361.c
> @@ -108,7 +108,6 @@ static void mv64361_pcihost_class_init(ObjectClass *k=
lass, const void *data)
>
>      dc->realize =3D mv64361_pcihost_realize;
>      device_class_set_props(dc, mv64361_pcihost_props);
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>
>  static const TypeInfo mv64361_pcihost_info =3D {
> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> index 4b0ced79b08..e07cf8a0d0f 100644
> --- a/hw/pci-host/pnv_phb.c
> +++ b/hw/pci-host/pnv_phb.c
> @@ -202,7 +202,6 @@ static void pnv_phb_class_init(ObjectClass *klass, co=
nst void *data)
>      hc->root_bus_path =3D pnv_phb_root_bus_path;
>      dc->realize =3D pnv_phb_realize;
>      device_class_set_props(dc, pnv_phb_properties);
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->user_creatable =3D true;
>  }
>
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index 975d191ccb8..edadc35384c 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -516,7 +516,6 @@ static void e500_pcihost_class_init(ObjectClass *klas=
s, const void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D e500_pcihost_realize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      device_class_set_props(dc, pcihost_properties);
>      dc->vmsd =3D &vmstate_ppce500_pci;
>  }
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 1951ae440cc..c134679fa0c 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -194,7 +194,6 @@ static void q35_host_class_init(ObjectClass *klass, c=
onst void *data)
>      device_class_set_props(dc, q35_host_props);
>      /* Reason: needs to be wired up by pc_q35_init */
>      dc->user_creatable =3D false;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>  }
>
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index eacffc86d84..661a4223d69 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -365,7 +365,6 @@ static void raven_pcihost_class_init(ObjectClass *kla=
ss, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->realize =3D raven_pcihost_realizefn;
>      dc->fw_name =3D "pci";
>  }
> diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
> index e6d2af4502a..959beb5c301 100644
> --- a/hw/pci-host/remote.c
> +++ b/hw/pci-host/remote.c
> @@ -55,7 +55,6 @@ static void remote_pcihost_class_init(ObjectClass *klas=
s, const void *data)
>      dc->realize =3D remote_pcihost_realize;
>
>      dc->user_creatable =3D false;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>  }
>
> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index 538624c5079..f95e5db583a 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -505,7 +505,6 @@ static void sabre_class_init(ObjectClass *klass, cons=
t void *data)
>      dc->realize =3D sabre_realize;
>      device_class_set_legacy_reset(dc, sabre_reset);
>      device_class_set_props(dc, sabre_properties);
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>      sbc->explicit_ofw_unit_address =3D sabre_ofw_unit_address;
>  }
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 194037d6e75..d337a2fd62c 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -435,7 +435,6 @@ static void pci_unin_main_class_init(ObjectClass *kla=
ss, const void *data)
>
>      dc->realize =3D pci_unin_main_realize;
>      device_class_set_props(dc, pci_unin_main_pci_host_props);
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>      sbc->explicit_ofw_unit_address =3D pci_unin_main_ofw_unit_address;
>  }
> @@ -453,7 +452,6 @@ static void pci_u3_agp_class_init(ObjectClass *klass,=
 const void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D pci_u3_agp_realize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>
>  static const TypeInfo pci_u3_agp_info =3D {
> @@ -469,7 +467,6 @@ static void pci_unin_agp_class_init(ObjectClass *klas=
s, const void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D pci_unin_agp_realize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>
>  static const TypeInfo pci_unin_agp_info =3D {
> @@ -485,7 +482,6 @@ static void pci_unin_internal_class_init(ObjectClass =
*klass, const void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D pci_unin_internal_realize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>
>  static const TypeInfo pci_unin_internal_info =3D {
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index c71492de9e7..1540533223c 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -172,7 +172,6 @@ static void xilinx_pcie_host_class_init(ObjectClass *=
klass, const void *data)
>
>      hc->root_bus_path =3D xilinx_pcie_host_root_bus_path;
>      dc->realize =3D xilinx_pcie_host_realize;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
>      device_class_set_props(dc, xilinx_pcie_host_props);
>  }
> @@ -291,7 +290,6 @@ static void xilinx_pcie_root_class_init(ObjectClass *=
klass, const void *data)
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->desc =3D "Xilinx AXI-PCIe Host Bridge";
>      k->vendor_id =3D PCI_VENDOR_ID_XILINX;
>      k->device_id =3D 0x7021;
> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index 7179d99178b..b5c624e12e8 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -245,6 +245,7 @@ static void pci_host_class_init(ObjectClass *klass, c=
onst void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      device_class_set_props(dc, pci_host_properties_common);
>      dc->vmsd =3D &vmstate_pcihost;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>
>  static const TypeInfo pci_host_type_info =3D {
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

