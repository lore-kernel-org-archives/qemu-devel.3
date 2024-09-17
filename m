Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1820CC35FED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 07:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSsw-0000pU-Cc; Tue, 17 Sep 2024 03:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqSsr-0000Qv-BA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqSsp-00086Q-KO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726559062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlY0ApUfnfVKzZ+HjTB81HGN0SRFrkrGqvAwb94DhZE=;
 b=iiuuOYbbno4vgb4ISsMJvBDD5XZLG/gv0kE5ZoXgwVl0i2640lP7nDXREEJRpL5LAgqXuG
 TBrL+4XeqXhELllB6MuIGBNDTavBnc4Fb2CWikucjzS+pVvfsBi8zYF4ZtkEYaJGGqhbhs
 1b/dH//mNFXfq+SXJrGyzCoEHpC8zpo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-Dis3_I-rN8C6Q3MBalbZ3w-1; Tue, 17 Sep 2024 03:44:20 -0400
X-MC-Unique: Dis3_I-rN8C6Q3MBalbZ3w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cacba219cso29088395e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 00:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726559059; x=1727163859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlY0ApUfnfVKzZ+HjTB81HGN0SRFrkrGqvAwb94DhZE=;
 b=ulRxkqpfWCnBVnGzQUD3+1qw19P50Yww9GsrkXR4WTGDNRHiePQQv3apUv2LJ5IBA2
 K0oKsKwgqs8/StZ1fCDdi/AySQFjkermV7de7n2IN7XpVmafYi7hO+6cReVzaskHq7wg
 43ofgl3vMlKNAHW9+BdrQJCSU2mryGv2fStTNkNr/GAwFzgV12ReDUYYdpdH1mmhF+O9
 uGv37a1e5B6jyMTSC4PmYy0YaUV5QHFFsvRYlVEK9jnjwnC/0i0GyrHe4uYbfDZoP5gm
 XO1BvWOqJ8X+DmvFfm7YADI+QKrDjsPZkeM4GuhsXADokOl9dNpb3N/kjmb2zutCkYx6
 j3aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3aYI7eMjdsNF3/UORTKAieNgoqQvaId+BPEQh18f6Z/BftHtmXSRZEkHHsQTunEVBZd7dmCniOS58@nongnu.org
X-Gm-Message-State: AOJu0YxWH7XTztFqPEcXK+5k3hryFvtatqbaze8CCMQ8rsn9DswoXvWs
 yY0bXCGIZQisyVL21Ax3KxSvpyNqIYghwPZIXcMNOO1kV04f3tEEXtxmr3MgyKzjKYS78LQymOO
 7eZyCgld7uwVRbvyRKGUwkrKUx/M2MZvhwfvjJMQ8QK2jY+I9+Cye
X-Received: by 2002:a05:600c:3c90:b0:42c:b949:328e with SMTP id
 5b1f17b1804b1-42e5f47bb9bmr40017545e9.31.1726559059512; 
 Tue, 17 Sep 2024 00:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAqykBP+DM0+2WF9MMxeo2oDP24G1/+17VecR3l8TvtiqkJneWL8jhHJPNRTwbY0jCPUHnw==
X-Received: by 2002:a05:600c:3c90:b0:42c:b949:328e with SMTP id
 5b1f17b1804b1-42e5f47bb9bmr40017345e9.31.1726559058897; 
 Tue, 17 Sep 2024 00:44:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b189a1esm128372675e9.31.2024.09.17.00.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 00:44:18 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:44:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Ani
 Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "Jason
 A . Donenfeld" <Jason@zx2c4.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] acpi: ged: Add macro for acpi sleep control
 register
Message-ID: <20240917094416.7a9c965c@imammedo.users.ipa.redhat.com>
In-Reply-To: <4e3f67e1-f06a-070e-6b45-89afd1be2884@loongson.cn>
References: <20240911030922.877259-1-maobibo@loongson.cn>
 <20240911030922.877259-2-maobibo@loongson.cn>
 <20240913144104.643c1e89@imammedo.users.ipa.redhat.com>
 <4e3f67e1-f06a-070e-6b45-89afd1be2884@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 14 Sep 2024 10:25:45 +0800
maobibo <maobibo@loongson.cn> wrote:

> On 2024/9/13 =E4=B8=8B=E5=8D=888:41, Igor Mammedov wrote:
> > On Wed, 11 Sep 2024 11:09:21 +0800
> > Bibo Mao <maobibo@loongson.cn> wrote:
> >  =20
> >> Macro definition is added for acpi sleep control register, so that
> >> ged emulation driver can use this, also it can be used in FDT table if
> >> ged is exposed with FDT table.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   hw/acpi/generic_event_device.c         | 6 +++---
> >>   hw/i386/acpi-microvm.c                 | 2 +-
> >>   hw/loongarch/acpi-build.c              | 2 +-
> >>   include/hw/acpi/generic_event_device.h | 9 +++++++--
> >>   4 files changed, 12 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_de=
vice.c
> >> index 15b4c3ebbf..94992e6119 100644
> >> --- a/hw/acpi/generic_event_device.c
> >> +++ b/hw/acpi/generic_event_device.c
> >> @@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr ad=
dr, uint64_t data,
> >>  =20
> >>       switch (addr) {
> >>       case ACPI_GED_REG_SLEEP_CTL:
> >> -        slp_typ =3D (data >> 2) & 0x07;
> >> -        slp_en  =3D (data >> 5) & 0x01;
> >> -        if (slp_en && slp_typ =3D=3D 5) {
> >> +        slp_typ =3D (data & ACPI_GED_SLP_TYPx_MASK) >> ACPI_GED_SLP_T=
YPx_POS; =20
> > this makes a bit more complex expression once macros are expanded,
> > but doesn't really helps to clarity.
> >=20
> > If I have to touch/share this code, I'd replace magic numbers above
> > with corresponding simple numeric macro but keep the same expressions. =
=20
> That sounds reasonable, it is better to keep the same expression such as:
>      slp_typ =3D (data >> ACPI_GED_SLP_TYPx_POS) & ACPI_GED_SLP_TYPx_MASK;
>=20
> However what about for this sentence?
>      slp_en  =3D (data >> 5) & 0x01;
> I think the modification like this is better
>      slp_en  =3D !!(data & ACPI_GED_SLP_EN);

then one has to got and check what ACPI_GED_SLP_EN is
and why it's that specific value.
while keeping it as is would be consistent with slp_typ
line right above it.
But it's stylistic, I don't really care wrt it.
=20
>=20
> >  =20
> >> +        slp_en  =3D !!(data & ACPI_GED_SLP_EN);
> >> +        if (slp_en && slp_typ =3D=3D ACPI_GED_SLP_TYPx_S5) {
> >>               qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDO=
WN);
> >>           }
> >>           return;
> >> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> >> index 279da6b4aa..1e424076d2 100644
> >> --- a/hw/i386/acpi-microvm.c
> >> +++ b/hw/i386/acpi-microvm.c
> >> @@ -131,7 +131,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker =
*linker,
> >>       /* ACPI 5.0: Table 7-209 System State Package */
> >>       scope =3D aml_scope("\\");
> >>       pkg =3D aml_package(4);
> >> -    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
> >> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5)); =20
> >=20
> > what's the point of renaming this? =20
> ACPI spec set name with SLP_TYPx. I am ok with both, it seems less=20
> modification is better.

I'd avoid renaming, if one need to reference spec we usually add
a comment about field/value that points to earliest spec where it
was introduced and chapter in it. Also for fields we also add
a comment with _verbatim_ field name from spec, so that one
can copy/past/search it in spec when needed.


>=20
> Regards
> Bibo Mao
> >  =20
> >>       aml_append(pkg, aml_int(0)); /* ignored */
> >>       aml_append(pkg, aml_int(0)); /* reserved */
> >>       aml_append(pkg, aml_int(0)); /* reserved */
> >> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> >> index 2638f87434..974519a347 100644
> >> --- a/hw/loongarch/acpi-build.c
> >> +++ b/hw/loongarch/acpi-build.c
> >> @@ -418,7 +418,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,=
 MachineState *machine)
> >>       /* System State Package */
> >>       scope =3D aml_scope("\\");
> >>       pkg =3D aml_package(4);
> >> -    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
> >> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5));
> >>       aml_append(pkg, aml_int(0)); /* ignored */
> >>       aml_append(pkg, aml_int(0)); /* reserved */
> >>       aml_append(pkg, aml_int(0)); /* reserved */
> >> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/=
generic_event_device.h
> >> index 40af3550b5..41741e94ea 100644
> >> --- a/include/hw/acpi/generic_event_device.h
> >> +++ b/include/hw/acpi/generic_event_device.h
> >> @@ -81,8 +81,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >>   /* ACPI_GED_REG_RESET value for reset*/
> >>   #define ACPI_GED_RESET_VALUE       0x42
> >>  =20
> >> -/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
> >> -#define ACPI_GED_SLP_TYP_S5        0x05
> >> +/* [ACPI 5.0+ FADT] Sleep Control Register */
> >> +/* 3-bit field defines the type of hardware sleep state */
> >> +#define ACPI_GED_SLP_TYPx_POS      0x2
> >> +#define ACPI_GED_SLP_TYPx_MASK     (0x07 << ACPI_GED_SLP_TYPx_POS)
> >> +#define ACPI_GED_SLP_TYPx_S5       0x05  /* System \_S5 State (Soft O=
ff) */
> >> +/* Write-only, Set this bit causes system to enter SLP_TYPx sleeping =
state */
> >> +#define ACPI_GED_SLP_EN            0x20
> >>  =20
> >>   #define GED_DEVICE      "GED"
> >>   #define AML_GED_EVT_REG "EREG" =20
> >  =20
>=20


