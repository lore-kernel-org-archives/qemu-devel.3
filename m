Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6620C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6q9v-00015Z-V1; Tue, 14 May 2024 07:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s6q9r-000145-Je; Tue, 14 May 2024 07:17:24 -0400
Received: from mail-sh0chn02on20730.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::730]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s6q9n-0000JF-SO; Tue, 14 May 2024 07:17:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK1dV2JYRHvGrx/whlize8+Si0mCAKRAiBv4N1toivp1rLiq209f744eJQpmAT56C+Nc4frm62zuvnIzd4FvxZjkbS+3mAVXUp3R4td7qEqdBzAn2OtM93A+nokXeg+cnKpJpE1zE4aw03F9kTgK2tA9FQZt9AB9h1o5YHmt3w6HWyHjAk2pmln92waMgvCL9I11V0+QjsV52Ze7h0KAkU/tQlqys1G+PhvqeqwX8taUv5RlfMs3PdM1CjLK3WHSU+bArjvl+N6q2NMIQT/VRFJMks+p7k9NAyjU3ZJ1WZr/z5TyitdsKDXr4GIJ8DocvmjeI37g8BQX20GcGb97qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRWJI0Ty2t5CRIOpNvaMqqmsaQmv2cN9ltve5K6keMg=;
 b=X5+YTqC2ECcd7HBi9uUIfMaIcfszvcbGmCF8jp72Y/fIimFkaDgLN6HzXhqqJnjmsFF4zxjgoZ9/C6EPvMFLYnM274wj7F6Gq8kRglqSQWaXXvT+hPzz8IJd7shYc9siV9z6Wcc+UEhtnXpZ/rTK8+MgiwFqbKgql8s0saECDtVd9pz5PCe1fiw+9+X2prYz1U31SGCq0gj2LUtFuKDY9KSaV86CNQEqGxqiv8XQzK7d+tGJTJQq3tLkUJ2WOVeYf4K+QCjhIn98OMGN4xR80GZjlWGyCGNthDNyIDfA5HwbJoA18XP/bPuWJA0na4yUcSVpcljoNpGKb+fp+mt+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0990.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Tue, 14 May
 2024 11:16:59 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Tue, 14 May 2024 11:16:59 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Sunil V L <sunilvl@ventanamicro.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
Thread-Topic: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
Thread-Index: AQHaoD6TJusz/RVVrkmf1vrsO+W0+bGUqM+AgAH2FWA=
Date: Tue, 14 May 2024 11:16:59 +0000
Message-ID: <NT0PR01MB12782432813293E9D7B17D889CE32@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
References: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
 <20240507052212.291137-3-jeeheng.sia@starfivetech.com>
 <ZkGiE68wMiVwZi/E@sunil-laptop>
In-Reply-To: <ZkGiE68wMiVwZi/E@sunil-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB0990:EE_
x-ms-office365-filtering-correlation-id: 47c39810-264b-492c-aba9-08dc74075f7f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oFLzDaOVfA/Yw0eSF4dZEiN36vIYdv73RjuTlM/v1KEAIy3Tg656M/df1gFLL2GX27U14Zq9xxQrlsZPAToA1Lg0GWHz+EmDz1kLpCD/5ERus0Z5JH0gppJfB04Vu/1oFkb1ffhcXo473JlqR8DHKuT47V7oDrjFhq9snbNq9A8jJEB4CxQNLQuxuPOZlA6AdoiRB4gXVxtX+mjeyIu68armpbXNJm6K6GqbHNLr7mvMZM1DExefM76BaOIIKsXBtcBp544Ie8HtuZPfMxMBk3wDiVBzKh+LmOE8qjQFnIAqbZf/WxnMY7YcEAAqobbGr1XOlmRZV24Azqpq0aq8+qRN+AcNh095FI++yHRjsvoTNT8VXXpZFwwUt51C2/cuGGiRpkqdl70aPhWXwX7Ych/hdM/acKNueQ6Fv5m1GPn0lbjmvkGyvkuYRCSrOYLZKH00lCpBTgZNZTE1gJB+/fv8CoAs6Xfr1cA1g6/WJW0recbJoOX4M6GYHINQzFi02sn652ssGpXDKCKBaB608JIb7V3PyoyOg3w4MWrzaQDj/iFi/a9tQpO5dgySF5lWzQM6+rzeg/cJZ2xRPFOfsEFh7A4tGRrWnjuDkgvbeyWWUAxZwFudgmpdTKzRk9C0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(41320700004)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ed06lyRgqwJSJ7EAwpCFKSChKJ2erZlJzHeOUXCRbmZPErkrVy4KtGzs4iTw?=
 =?us-ascii?Q?78AvtZk9mFPX5YKVLD2fCjniCXeF72nZuFzz1qN/5Kr3G02v5sCY8kU9J660?=
 =?us-ascii?Q?aA0a/2YZtcSOSQWMNc4oWs/9rWFgHCiBRshejR2+Uttf2nXgIcTWooAOnisQ?=
 =?us-ascii?Q?l/ikpFXOh136aDRykg9CJ+jZRIBbVgfrE3ef2Yw9EgVdwZzSOqiJXdGxzgKx?=
 =?us-ascii?Q?CuJ4lKJNAXGciTWsTkE2IUkAEIN4WarCHwV/oP0spadTFHCBlPh+7NjZgid1?=
 =?us-ascii?Q?BA0djxgonzQlSLs9t2h2NAQi2Vn7j8Yeg/CfHjHB81L3bkb8vqwG6qmWLKy8?=
 =?us-ascii?Q?UVbqvBmVn/1L54PGthBhL/+ZVUKqgTUYEwhHQw9SXsEIB3k+YzXQYDAHFfUe?=
 =?us-ascii?Q?gSYMVYitR0rjhPLRa24WYDjYW/1BRAWasTkUPnHEFUNF9klDcRxIIJAXDnQH?=
 =?us-ascii?Q?FX0/NqFsgkDzpg2x03PegdQEySU4lnuHew1wIaHLSfWmFeqv2JtGWbIZ/cKP?=
 =?us-ascii?Q?mjHAcnUDWfQUz0lazBrsRSc7tC18nogQZW2/bZsNABUZQRsQAj8ZeXbH4S3e?=
 =?us-ascii?Q?6pZZ9mmRuhesp8DOx4wPtAUhO7EuLm05sOEL6aAxvJZrj0tL0uw0AP7jj+uA?=
 =?us-ascii?Q?ePtBuviWf60OTggejKEBccP84PZ3XYeCjzPJ9W85Rg1p9KoIew/CZSXkbYFY?=
 =?us-ascii?Q?fiGO+5KqxCno03rr9pNRtEAT6ZrTp6/BU/eCMg8PeqiwFF0MzGsEgay3LSLd?=
 =?us-ascii?Q?nMfXQ96ahLmUrcfvZMmeHSuk/hNtmWoOSgPz/bs5GRgklhA5kKl5b6orcBIj?=
 =?us-ascii?Q?zZ8CjgheQniIiypoG0rO+tfc7ETaE4/ZYeQt/i3LfujxGVEm/sJjk/ztgfWa?=
 =?us-ascii?Q?n52cU19RNGaLK92TsFeLUOGkFRraeQNHWaUP4S1vf/PdM1fM/hov5NHBFhKC?=
 =?us-ascii?Q?wv0xTYDk0K0qbCnltQXST31JR8ULkG+CGTDkixm+n4hVVSk/V4RxRLacLNcU?=
 =?us-ascii?Q?XcDXya9G+PfPKt4dAOdyjAO7qGO+Rk6ZI8znwmQIEPLaorvvy288uTjp41xH?=
 =?us-ascii?Q?uvqzlf+jfZPsJuv/f0nykBG8ru2bUljHHjwDHDt7kJEV3A4HvD/wVDtkZjUi?=
 =?us-ascii?Q?8osQBP2fnb+HMPB111tbgg5onvIWJYiMXlHW9fDq1QjF0EeCgcfKByvDeDv8?=
 =?us-ascii?Q?3m/9lt5FY6bpB8Og8vaER1EHxHtGgg27ndhwaIIG+CS+b9LJvE4iunt0iT5Z?=
 =?us-ascii?Q?nlfVVMYgf80Q4wiyE5FUTxl3YnBaJzYeRuETEveFEaxQGnWFtlzD0hgl8cp6?=
 =?us-ascii?Q?UBGEegXKiuw2GZz69SdXgeqdWf4crSq7kkapHbMLFA4Mrfjs3HSGH/kSzDTA?=
 =?us-ascii?Q?Vejm4F68vhYNVARiTx7OcWX+FmYAz0Krv4It4YyaCQqOoxeXcoBE3nBOcT8B?=
 =?us-ascii?Q?XYkTnCsOc7zGlm6ZggaHLOvNVRU6favu8hr7Fytwqmg93YBKL2dNvOWtxWqM?=
 =?us-ascii?Q?uzEqvjb7ohiEMN0MrU+gR4zhee9zkVyPq2WhTi1Eo/oitM4nLHTSBU4Yo+EJ?=
 =?us-ascii?Q?j2sdiOCcROhZq1ZHGvYk8GbiRzsVevsAXRO2hzm0FjKXhbg13YzLagWkO8Vn?=
 =?us-ascii?Q?Ozh4i6O+saFJbdw7SghjLz8X7xLFPc/GXpy6kwYgeW3XQqcc/SwpHJn++bOX?=
 =?us-ascii?Q?9PHx7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c39810-264b-492c-aba9-08dc74075f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 11:16:59.5365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hm3rmuAT0uhEX6RoYJFOGKMQk3HqP4xubUj4r0U0UlocjdOkUOE5xkKI0c/XXTKV4h5S9lDsdtt1H4VJ5Be1d8jnaqrMR0zu+gFZD0dDuCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0990
Received-SPF: pass client-ip=2406:e500:4420:2::730;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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



> -----Original Message-----
> From: Sunil V L <sunilvl@ventanamicro.com>
> Sent: Monday, May 13, 2024 1:16 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com; =
palmer@dabbelt.com; alistair.francis@wdc.com;
> bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com; z=
hiwei_liu@linux.alibaba.com
> Subject: Re: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support S=
PCR table version 4 format
>=20
> Hi Sia Jee Heng,
>=20
> On Mon, May 06, 2024 at 10:22:11PM -0700, Sia Jee Heng wrote:
> > Update the SPCR table to accommodate the SPCR Table version 4 [1].
> > The SPCR table has been modified to adhere to the version 4 format [2].
> >
> > [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serport=
s/serial-port-console-redirection-table
> > [2]: https://github.com/acpica/acpica/pull/931
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > ---
> >  hw/acpi/aml-build.c         | 14 +++++++++++---
> >  hw/arm/virt-acpi-build.c    | 10 ++++++++--
> >  hw/riscv/virt-acpi-build.c  | 12 +++++++++---
> >  include/hw/acpi/acpi-defs.h |  7 +++++--
> >  include/hw/acpi/aml-build.h |  2 +-
> >  5 files changed, 34 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index 6d4517cfbe..7c43573eef 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -1996,7 +1996,7 @@ static void build_processor_hierarchy_node(GArray=
 *tbl, uint32_t flags,
> >
> >  void build_spcr(GArray *table_data, BIOSLinker *linker,
> >                  const AcpiSpcrData *f, const uint8_t rev,
> > -                const char *oem_id, const char *oem_table_id)
> > +                const char *oem_id, const char *oem_table_id, const ch=
ar *name)
> >  {
> >      AcpiTable table =3D { .sig =3D "SPCR", .rev =3D rev, .oem_id =3D o=
em_id,
> >                          .oem_table_id =3D oem_table_id };
> > @@ -2042,8 +2042,16 @@ void build_spcr(GArray *table_data, BIOSLinker *=
linker,
> >      build_append_int_noprefix(table_data, f->pci_flags, 4);
> >      /* PCI Segment */
> >      build_append_int_noprefix(table_data, f->pci_segment, 1);
> > -    /* Reserved */
> > -    build_append_int_noprefix(table_data, 0, 4);
> > +    /* UartClkFreq */
> > +    build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
> > +    /* PreciseBaudrate */
> > +    build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> > +    /* NameSpaceStringLength */
> > +    build_append_int_noprefix(table_data, f->namespace_string_length, =
2);
> > +    /* NameSpaceStringOffset */
> > +    build_append_int_noprefix(table_data, f->namespace_string_offset, =
2);
> > +    /* NamespaceString[] */
> > +    g_array_append_vals(table_data, name, f->namespace_string_length);
> >
> Is it possible to check the revision here and add new fields only if the
> revision supports it? ARM maintainers are better to comment but IMO, we
> better keep ARM's SPCR in the same current version since I don't know
> how consumers like linux (and other OSs) react to the change.
Hi Sunil, there is only one prebuilt SPCR binary. By doing this, the qtest
will fail. I think I will let ARM maintainer to comment.
>=20
> Thanks!
> Sunil
> >      acpi_table_end(linker, &table);
> >  }
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 6a1bde61ce..cb345e8659 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -428,11 +428,12 @@ build_iort(GArray *table_data, BIOSLinker *linker=
, VirtMachineState *vms)
> >
> >  /*
> >   * Serial Port Console Redirection Table (SPCR)
> > - * Rev: 1.07
> > + * Rev: 1.10
> >   */
> >  static void
> >  spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *v=
ms)
> >  {
> > +    const char name[] =3D ".";
> >      AcpiSpcrData serial =3D {
> >          .interface_type =3D 3,       /* ARM PL011 UART */
> >          .base_addr.id =3D AML_AS_SYSTEM_MEMORY,
> > @@ -456,9 +457,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker,=
 VirtMachineState *vms)
> >          .pci_function =3D 0,
> >          .pci_flags =3D 0,
> >          .pci_segment =3D 0,
> > +        .uart_clk_freq =3D 0,
> > +        .precise_baudrate =3D 0,
> > +        .namespace_string_length =3D sizeof(name),
> > +        .namespace_string_offset =3D 88,
> >      };
> >
> > -    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_t=
able_id);
> > +    build_spcr(table_data, linker, &serial, 4, vms->oem_id, vms->oem_t=
able_id,
> > +               name);
> >  }
> >
> >  /*
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index 0925528160..5fa3942491 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -176,14 +176,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry =
*uart_memmap,
> >
> >  /*
> >   * Serial Port Console Redirection Table (SPCR)
> > - * Rev: 1.07
> > + * Rev: 1.10
> >   */
> >
> >  static void
> >  spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
> >  {
> > +    const char name[] =3D ".";
> >      AcpiSpcrData serial =3D {
> > -        .interface_type =3D 0,       /* 16550 compatible */
> > +        .interface_type =3D 0x12,       /* 16550 compatible */
> >          .base_addr.id =3D AML_AS_SYSTEM_MEMORY,
> >          .base_addr.width =3D 32,
> >          .base_addr.offset =3D 0,
> > @@ -205,9 +206,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker,=
 RISCVVirtState *s)
> >          .pci_function =3D 0,
> >          .pci_flags =3D 0,
> >          .pci_segment =3D 0,
> > +        .uart_clk_freq =3D 0,
> > +        .precise_baudrate =3D 0,
> > +        .namespace_string_length =3D sizeof(name),
> > +        .namespace_string_offset =3D 88,
> >      };
> >
> > -    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table=
_id);
> > +    build_spcr(table_data, linker, &serial, 4, s->oem_id, s->oem_table=
_id,
> > +               name);
> >  }
> >
> >  /* RHCT Node[N] starts at offset 56 */
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 0e6e82b339..2e6e341998 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -112,7 +112,6 @@ typedef struct AcpiSpcrData {
> >      uint8_t flow_control;
> >      uint8_t terminal_type;
> >      uint8_t language;
> > -    uint8_t reserved1;
> >      uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
> >      uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
> >      uint8_t pci_bus;
> > @@ -120,7 +119,11 @@ typedef struct AcpiSpcrData {
> >      uint8_t pci_function;
> >      uint32_t pci_flags;
> >      uint8_t pci_segment;
> > -    uint32_t reserved2;
> > +    uint32_t uart_clk_freq;
> > +    uint32_t precise_baudrate;
> > +    uint32_t namespace_string_length;
> > +    uint32_t namespace_string_offset;
> > +    char namespace_string[];
> >  } AcpiSpcrData;
> >
> >  #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
> > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > index a3784155cb..68c0f2dbee 100644
> > --- a/include/hw/acpi/aml-build.h
> > +++ b/include/hw/acpi/aml-build.h
> > @@ -500,5 +500,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *lin=
ker, GArray *tcpalog,
> >
> >  void build_spcr(GArray *table_data, BIOSLinker *linker,
> >                  const AcpiSpcrData *f, const uint8_t rev,
> > -                const char *oem_id, const char *oem_table_id);
> > +                const char *oem_id, const char *oem_table_id, const ch=
ar *name);
> >  #endif
> > --
> > 2.34.1
> >

