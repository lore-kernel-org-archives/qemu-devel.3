Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4089EC54722
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 12:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgONv-0005rX-To; Tue, 20 Aug 2024 08:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sgONt-0005pZ-4b; Tue, 20 Aug 2024 08:54:49 -0400
Received: from mail-bjschn02on2072f.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::72f]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sgONp-0002k6-3z; Tue, 20 Aug 2024 08:54:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo3WJHVyN8OKYvum/V8gUS/7PufuViRSVxYf+uuAh3NXPb4Ozl4Zmsa+3zE3YHJ1QjaKUrZvoSxUvswxo/ZtzUKx1ZZudcd69VFLepyPshX+Asy2WHbX4cLjGpdeL2+GAse1XxokE5NQ2jk2Ktalxo2sHGV2u1TUZrSaG3pUOaJyAWF+QN2H6V7cy9Zo2y7zDDEdpXuEReRjw9yvo8v4AiaDT7f5SGlVxzS6wmTvsQ7yHiEBinobkUjmFBLbl/U6cfGpnmcHWUh3TEgUAX5CyWwUeWwbDKUFFqNpnrwde9hsHnBaCh0GgcvVRZeV1HukNQA6RnqLluubQBd8IYth9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y18ObBfJ+ZHiJQdWv6owPNJgy4pTjfididwN8V0Kb9M=;
 b=CLQFpTELnDymTyoSQ1vMvh9fO4FTbe83LYhYB4ToatFtLj52A44BIQN0Hs0wlBka4crQPDkE7SAVL08Zr6+sTNzHbFDs6slcz8fvQpSnWoX538RH5R88GSMcr/RrulQG9wu6VxpDjBFADDhd2/Abbm7tDswznMKEXjq3T8qmVarnjj/CatASlQK1rk6Gh8qDRE+KI4Lpr+5CyPUfKJM2cUvOtJQSqhLTSZDnbNKGSdcJHWi7g4uSFGOLQZDAFpGp1Z93iNOA/tLUfox9R6qik2w6Lkds52ALLPooNShIOdIfJKDTqwsF3+R45bBwp+F5OJTf4k8oFZnPQOqlVbrt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1231.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 12:54:28 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7875.023; Tue, 20 Aug 2024 12:54:28 +0000
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
Subject: RE: [PATCH v3 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
Thread-Topic: [PATCH v3 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
Thread-Index: AQHa7UDZgmLVZbRpbUy2BtkZ8CGjnLIuAMeAgAIkpNA=
Date: Tue, 20 Aug 2024 12:54:28 +0000
Message-ID: <NT0PR01MB12787808C27B4CA5FE459CD09C8D2@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
References: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
 <20240813052223.1033420-3-jeeheng.sia@starfivetech.com>
 <ZsLFkbZxvOLpf8bZ@sunil-laptop>
In-Reply-To: <ZsLFkbZxvOLpf8bZ@sunil-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB1231:EE_
x-ms-office365-filtering-correlation-id: 3df1861b-e9ee-45f3-b2d6-08dcc1173a44
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: 44uwc6uSN0iuFkzzorjwvT3VxN+UjvfdcKIBox/YBA/kFVZXoG7EarXuWCJFiUV1Byt7tZk54zWdJ5nrMLBsTH03h+7vpSuVAQFhdOHxxh07m3KkjFQpORrcYOfYSOScRZFiuhN14k1qUPdwQ3UNhfqv/oIkcuu2GIjjczpSnzUWCgsr7XUtlSSd7zFXaXqrcmrvgfmgZX6Nok+hf9PjU6ZD6Eg6XK0bzIRB6bh0v6swO8rwkVXdoaco+58aEkhEkakm03mFWE+Tua7gWiPmX74R31OJTy/o8X79+69v+3WsqhohfWt5UNCSvHRPz8wQMj5pnG5Ahmb72Wq1PmNSxoDv+yntdA3qza32Y33iZrlNz80oIVlS32MiaSFrCsoh4h9IGAEraPV6HwkwVrTziRWJFPxrmbSSeH1eBl0dIqEW7+6oaaLoNkOYwuniMIu1ql1d59HDAJnIOBcuOBPrdv4TD7GBGcG7ola9tNzEu2+mIZJCx+nBZGVKUEOASQiU2pa6E85pRZNuAb1bB6F+7iv2/YkZUG7TSmqjS9SCQyQAk7mPmRONW1vbwoPco6ngpIb8E7ViUebUpI5Tb2f+1DbW8u1LcxgN1UcA+0Q9Kr8nl7QjEHfOeafLzRl4t/eV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aX5du1MiMAmnrb6Y3K17KNj9rftve6JDU6RNtYHLR7ktUl3eiTuWlnobDf4z?=
 =?us-ascii?Q?h512yqwl4zZh8DJD63ARkQ0RP8Db2gvaMtWIN/+xKcApUPHIg4/51JKzvicZ?=
 =?us-ascii?Q?6UwPShGM/KsXvBOw1mXWJLYFMCpfoQakj2rxqR31oyvcnA9CsU+BkCp8n2pO?=
 =?us-ascii?Q?bx/PHRG1oXANxKuuYXKgi6Pt2NJaJL2CnXAExPyHrs+HLRnAAYqv+NzNbDFM?=
 =?us-ascii?Q?Q4qCE8x/fwYt2PWNxbnjlurd9/bgSLsl8IERbwqIO84SogAPV3ttBNOKeDz0?=
 =?us-ascii?Q?CgZPlFhMjktxB2vTUmwmuO8P/pK+dCJcb7CFD0IEj/lmPvQOXNk/+GN9F08n?=
 =?us-ascii?Q?6SUdyx+om4T393Td+hnnnW1lQ8GBS+9oF9Z96FxfH1xQ61ExHhB3F5azjMmc?=
 =?us-ascii?Q?T+73jM3+qUSz6vXijYr1u8TfWjBsykVGOXBFfj5FIE4T0Q2iM1T+4srDT+yf?=
 =?us-ascii?Q?CEk4ctau0CtAN6wB9KcIlNvluXftOmSYcTK1EvnzdAzArPcj2tg3TVZ6Lm6q?=
 =?us-ascii?Q?udwcObrlZ4LQ1IiNGyUgSAVZKc3Zaecj9VvNlHRhkLttjGLV5/P6YqWU9jRf?=
 =?us-ascii?Q?ITrsfnVpdiLy6uv3IiwX/HpdjZG3AcxDN2FKmBCVDOgdzxYSKf5r8CadjNKT?=
 =?us-ascii?Q?0hPGU6XXcKNs5KweO7MYsOWIY5bUh9xdYlOkf4/Kuzwoo2Pu3T+P4vqWiVOb?=
 =?us-ascii?Q?FXgPBpYl6cJMODqkcyZZXFVBWkhE6LEbYSWsM/8qlNR2xwcdjU3k3kzTs44W?=
 =?us-ascii?Q?7+uHfvkjRFiOKtoOlnPNwyPeLQx4f+/iEz6Gk7/b4FZRVHCQjK3Ty08u8de/?=
 =?us-ascii?Q?QPIogI6RMVbj/mt0uc51Izj9HMh3ET9aVK+/1NZRhSQ9WQnGJA0q3DohLo2R?=
 =?us-ascii?Q?0TquYd6JU1TlKEpCVkKMpJQISj3PefilGRQlafHpFbjW5c7y6UTilJMvnP96?=
 =?us-ascii?Q?UnCTfY9sXHIk0LDLNLFxwN5575dZImkv5PHw1TMwJHenolFd5486GSt4PZNG?=
 =?us-ascii?Q?jCu4WtUVUa8ekHAoIvEXe4DRdWDkgZCsgPnjZ///ImFBnQhESyCt8ZvmMzAt?=
 =?us-ascii?Q?3hfs9e3Ysm9HA7uYBzivnucCgwaGLbGxww3IVxhIJV63ZmnI5W2YFrdm8ZIk?=
 =?us-ascii?Q?fHKozz+22Vgiuc+uQtrttbhPvBsXbtw2hs+hB+PIWn4Blxypj0kLHUUYSwF8?=
 =?us-ascii?Q?aJl8jrwMot79TyqiH3JgKddANi2XNq1pyBFPkbMSnrC6QNurnCNEJxgbU6pB?=
 =?us-ascii?Q?2ZzRbQ6X0qblpG7jkd9M+Y24T5xXRy1Xo88fF2nnUhvF5hzNdscq7IB0E5Ic?=
 =?us-ascii?Q?0TRkRJyqzcU+qHFzk7cVwJ+YDJ8mzupOyL224XYYI+lUxEj67Q9kaVFiCGHW?=
 =?us-ascii?Q?2fIeeWNnl/TwuEw4R2rhrn7Dw6BKtUg6PLENSesQD9UmBdsJwWsKh9ckCbyX?=
 =?us-ascii?Q?H03h6gO3dithHzl66AphP7bnKazpIGiWsvafvX/ue4hvyGCXltytZup2prmq?=
 =?us-ascii?Q?mYmSpWFVRT9eSp4ZGIwU5RKBD38UzCOd0T9Q9VKPYt85CyROeOSwNde+U1Bo?=
 =?us-ascii?Q?7Zr+jI5F+BQ8N12TRpgzvJGiL4wqnPKDyAnKY8UUzHvwunqcIeJa7m4+ifC3?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df1861b-e9ee-45f3-b2d6-08dcc1173a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 12:54:28.5609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLnjTNsZ+87mpq5O+YjQX4UdIDz/3o6ffNfq23pCR2pnDBBBx0m8EzH803J1eD0NgtNZrHFCkr75+lzblpziK4BXu+xtskhYDQWFUoGSCJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1231
Received-SPF: pass client-ip=2406:e500:4440:2::72f;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Sent: Monday, August 19, 2024 12:10 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com; =
palmer@dabbelt.com; alistair.francis@wdc.com;
> bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com; z=
hiwei_liu@linux.alibaba.com
> Subject: Re: [PATCH v3 2/3] hw/acpi: Upgrade ACPI SPCR table to support S=
PCR table version 4 format
>=20
> Hi Jee Heng,
>=20
> On Mon, Aug 12, 2024 at 10:22:22PM -0700, Sia Jee Heng wrote:
> > Update the SPCR table to accommodate the SPCR Table version 4 [1].
> > The SPCR table has been modified to adhere to the version 4 format [2].
> >
> > [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serport=
s/serial-port-console-redirection-table
> > [2]: https://github.com/acpica/acpica/pull/931
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
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
> >      acpi_table_end(linker, &table);
> >  }
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index e10cad86dd..ae075dc9fd 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -435,11 +435,12 @@ build_iort(GArray *table_data, BIOSLinker *linker=
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
> > @@ -463,9 +464,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker,=
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
> I request the same which I had asked earlier. Please keep SPCR for other
> architectures like ARM intact. The latest revision is primarily required
> for RISC-V. So, restrict the series only for RISC-V. The common
> build_spcr() should create SPCR based on the revision parameter.
Since there is no disagreement from other arch owner, I will proceed to rem=
ove
the changes. thanks
>=20
> Thanks,
> Sunil

