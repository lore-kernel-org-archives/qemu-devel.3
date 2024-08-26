Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEF2C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 04:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siRkZ-0004FN-Ke; Mon, 26 Aug 2024 00:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1siRkW-0004CB-37; Mon, 26 Aug 2024 00:54:40 -0400
Received: from mail-bjschn02on20725.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::725]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1siRkS-0005iA-WC; Mon, 26 Aug 2024 00:54:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCqfCff3NvLMO9iS1rKu93rAJGp9c3rtxC6pP1S6loHdQv+EDiosKJWulBJpu1CY83DHdv55Q3gq3/vlK/GIP+f1ZGa4Bgb8LQglvZEJ39gSZavS889ppucsuWmYZsOxCkiGQy4oQuM64b/8iVmW2lJsTLH4kMKgFxiGD5x1F9GU7A3tP8JOApzCei8gxBmqYasNu7iKArR8AaQAfHfEd75A//slp3uEu4pzU24BCVcxvuE/0WAb5XiN/utiCZYn71oSA3wLgsHMqws19Gd3T53bWeeStrbLpKNQlo0euKriDBHJs1KPYedJQRPz82rpyhHwAJWITZqCkT4TdwDsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrB+wGuP6UJ748VSFgv4IW7iVsiB3Om5Cip/9wp0u1o=;
 b=Of3644AjB0T8rzZEC6GxQek5wTfKpXSiaoP+OQDDl7DuV2UQLpT5ItYL7PByZTslpYW4k7ejzZX6dIUQMVRYkVZeMxmcEQmnkpS1ZrnbPG/RpbXQxWOLceEkzwGudMClpIoo4o1vamVKtWKwbspthQNWp1kQyCgjT7f2SxODBmRe0++1/nPkpVy4YPTllXN9SmWETPkDH84XiTBjPRSkuejP310rRSyV2+2o0marroOnla148ThlCMdGTa5uQBYY6+pf6YV5AR4qZeAsnD/FuRa+F3HqxGeO2wXiMzQzddEurdueF7m51TEa34dLT7IIBExD6kRfmCkkWplkmfccRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0990.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Mon, 26 Aug
 2024 04:54:24 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.021; Mon, 26 Aug 2024 04:54:24 +0000
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
Subject: RE: [PATCH RESEND v4 2/3] hw/acpi: Upgrade ACPI SPCR table to support
 SPCR table revision 4 format
Thread-Topic: [PATCH RESEND v4 2/3] hw/acpi: Upgrade ACPI SPCR table to
 support SPCR table revision 4 format
Thread-Index: AQHa9VAXimg33+NjmkKD7QRn1VjlWbI00jeAgAQqklA=
Date: Mon, 26 Aug 2024 04:54:24 +0000
Message-ID: <NT0PR01MB1278DF7C6AA6E276A202A8989C8B2@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
 <20240823113142.161727-3-jeeheng.sia@starfivetech.com>
 <ZsiLRdozsvdCLgqg@sunil-laptop>
In-Reply-To: <ZsiLRdozsvdCLgqg@sunil-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB0990:EE_
x-ms-office365-filtering-correlation-id: 16f45895-1e5f-4285-5274-08dcc58b27fa
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: KWgJrvk4djR0D48zDGCr6nTCfA7VE8kU9hpin1yZ7K9jqRoCOhPt6WAoOvxLRwMQb4yrWrBhkLSlqC6oMLiDuuV4rjmC+kkUGOKBc5eN1zoXUX/f7pLD8HQ4fwi0XjbXAaREli9bbLntitmuMUvJg8RrOic/kcmQ1PoeUt9ezG61HfqJo00WA37QCsSc2qQtC2kOwtjGUjhiI9c65LF/tUUXTs7SmxYGsw9EqdPiXnwKx5yQEQq/SFOv3w4hIgCC1OEHrBiNWbkQ0/bpFtMxpg5kZje7r8oH37/ew3J9FPzH0aMFYyDW2YmmtkbkKtT8pfZQAUAtGmijV71aQM6n/7jUAgGoCn/CpvPwrrF4TUOwiGIXh3KOt4+d3AU7/DcvEcT/vZ4aK578aY6vq7E3Ta82je3UHnHcME2mb3O1eBMoVS0w+KWWA0BkmGfzqpVW+p+N7YP5zNUdqwVRFPvta9Bn3QIDsxIB+O5neclt8CunlWAzLxG9+kIHH9XQmAE4OrrrRptIHpKeDnjUbKqWFJThf7RP1lWuWj77g/Uh9SvkyFOB+udZfMoTg9Bl7gAPU3oF5RGOAXgxVGB/KwZI1qnZWpd+7urMNKTaPngvQ8kmLb96ZtfqFmkxWM+JO0R6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jvSvnP79DuRBXZhZ04vvF0TjXGuF3pC+w5h/aKe0gj+LBsGf2facFIiu2P/w?=
 =?us-ascii?Q?kLdU+OHh2OdxsqkmCIPsrPtLhYBq12Zqf7myBLRjw1Ip5BQ42j6MjypYb51C?=
 =?us-ascii?Q?UQV7uKgQYXih4b9wWJx/+QG79AO33ZvZMWEMhHMjEqpLvLFXbeNrQGFatuVI?=
 =?us-ascii?Q?IwDpoQxCHIoDivILjkmFVpk/WFJmPOu1DKLc2Awb9g2kyPEfM/TOx1JHGTf+?=
 =?us-ascii?Q?dhIjgTQ+MfqW6KBjBWjloYS84IErhO7sPCnaYbFI8Ndo3kZGpK+naCGEMTHN?=
 =?us-ascii?Q?0xt0DF9Jdp1gyyTYFK22uUTEjfSq284Lq9WdOPozQbA7/y5iIiUzGxHXHkrt?=
 =?us-ascii?Q?h3tH7N/9X2k0MXMqH/RJRLn3h3qZaCS7tQJ1fTqoanwD07EC2lMqoyJ9KvQX?=
 =?us-ascii?Q?FQZFY2bCtEqf7Xc7lg8KFrX+PTHlRS+WJG8aMb8TaONHBpECC8IjS2+msR8i?=
 =?us-ascii?Q?kiphcsMxV37xlyC69Wb8VvO9YYlns31F6EhI+/i7ZnsY3gt3GAfNw5uRGJvB?=
 =?us-ascii?Q?IF9Sdx4hlCOGPx8NzcWHqR4gY8NQM3cPSLJIPo/gkMWFEj3s5ZfcaQYyJnlP?=
 =?us-ascii?Q?TcetsCZhxJL50qwFbLP73V5Nfxs2DuGxZUbgrxRyH03pC9b4ND6Kz+vMbixT?=
 =?us-ascii?Q?4KDJyph7Fm5GEsMvNHZoUYIlqCeRaQWtOAKQzpd3AXAsmCQoWPOW4OWrc4jw?=
 =?us-ascii?Q?4qeRsVSO58afqaaT1J2+wNYcvsww67AhfQQ1LU3JgMTeptlB26wzbTwL3vDu?=
 =?us-ascii?Q?hIg2bhbY1GtmXuqd1z88JBwE5k5SswcRr8FwyGdP6Jjm5xhn7vT1pzK24qoe?=
 =?us-ascii?Q?wAhabOszc1N7GG0ZWbjDGuJLL0gVNtjGTS4vdS+bDoxCdtC6KjHiRtJlQBwn?=
 =?us-ascii?Q?CJ/LReEML3MFRgBIEKe7m420lLpF52+tF/FdohnGrSHclvZyciYo96yZW+yb?=
 =?us-ascii?Q?SV4A43YMWwhfV6RLIsM7ZoSFQBu2nUU2OXwrbmyxtw5aJDNfV1gUeomTnZj8?=
 =?us-ascii?Q?9AQGmWK0viZaqscnpb4EyfCeIcpAMy1PqFjHVnZWdZKL00UGzQOD3fcjAHDq?=
 =?us-ascii?Q?MK/QDgX2/Oeugr6muDliGRUbmh/5oqjvrXTjUc2IMvS2GZZQM1KLWTFrScga?=
 =?us-ascii?Q?DM7q7S9ruVeIlbROrYmX2n9XxKdtZiJRPXzgX7iV/usQKMal0MTJRrsV+vOg?=
 =?us-ascii?Q?YZ1LN6EjRDidnZ2JKtr9mhhCfWwWcyzytib4AC7A6FddIsvFhPPOdhgpOYxb?=
 =?us-ascii?Q?wTvenY/Or6PKwVK/plvF7hLnszaEbqb8KCGWGCShfRW7xuxx++t+irbJ+QKi?=
 =?us-ascii?Q?svZLUBcLyRdoY8uv4ycvMk72W9QAvET/sFiW9W3ul8fyJ8jWZNwIJK1fhsSI?=
 =?us-ascii?Q?a1Hr60Va0DoWHSZ218HXbmv+sbc2JFU6ZgQW1tocMrSnlOZK1R4aoPWfe55N?=
 =?us-ascii?Q?R8klBxJrHVP3C3fjueNeoJLec9YfeyG9fXYd/c/Z8a5JR+ptf23+TYCOYqw6?=
 =?us-ascii?Q?vpacTLwAJ3KSrriR2mP5Dkv1HGwUIciwSioTl+f/SPe2a83VL3mcH5HTSMO3?=
 =?us-ascii?Q?kyi3Qt7RKegXxvRCPtbsojdWmLNVm8OlnIHiawko7ODisN0VJuKHqoqjSIpK?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f45895-1e5f-4285-5274-08dcc58b27fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 04:54:24.1267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgkwG2h2EhpbgNGzKf5D4LEV7nVro2vNWD7TW8CDCeo2KPXbp31BXddj5GMduqJ4J5Wk9GOs95fUwYvqn5Ca5p06M5LNZxpMNBwlfjwQg28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0990
Received-SPF: pass client-ip=2406:e500:4440:2::725;
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
> Sent: Friday, August 23, 2024 9:15 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com; =
palmer@dabbelt.com; alistair.francis@wdc.com;
> bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com; z=
hiwei_liu@linux.alibaba.com
> Subject: Re: [PATCH RESEND v4 2/3] hw/acpi: Upgrade ACPI SPCR table to su=
pport SPCR table revision 4 format
>=20
> On Fri, Aug 23, 2024 at 04:31:41AM -0700, Sia Jee Heng wrote:
> > Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> > The SPCR table has been modified to adhere to the revision 4 format [2]=
.
> >
> > [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serport=
s/serial-port-console-redirection-table
> > [2]: https://github.com/acpica/acpica/pull/931
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/acpi/aml-build.c         | 20 ++++++++++++++++----
> >  hw/arm/virt-acpi-build.c    | 10 +++++++---
> >  hw/riscv/virt-acpi-build.c  | 12 +++++++++---
> >  include/hw/acpi/acpi-defs.h |  7 +++++--
> >  include/hw/acpi/aml-build.h |  2 +-
> >  5 files changed, 38 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index 6d4517cfbe..ad0a306db1 100644
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
> > @@ -2042,9 +2042,21 @@ void build_spcr(GArray *table_data, BIOSLinker *=
linker,
> >      build_append_int_noprefix(table_data, f->pci_flags, 4);
> >      /* PCI Segment */
> >      build_append_int_noprefix(table_data, f->pci_segment, 1);
> > -    /* Reserved */
> > -    build_append_int_noprefix(table_data, 0, 4);
> > -
> > +    if (rev < 4) {
> > +        /* Reserved */
> > +        build_append_int_noprefix(table_data, 0, 4);
> > +    } else {
> > +        /* UartClkFreq */
> > +        build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
> > +        /* PreciseBaudrate */
> > +        build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> > +        /* NameSpaceStringLength */
> > +        build_append_int_noprefix(table_data, f->namespace_string_leng=
th, 2);
> > +        /* NameSpaceStringOffset */
> > +        build_append_int_noprefix(table_data, f->namespace_string_offs=
et, 2);
> > +        /* NamespaceString[] */
> > +        g_array_append_vals(table_data, name, f->namespace_string_leng=
th);
> > +    }
> >      acpi_table_end(linker, &table);
> >  }
> >  /*
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index f76fb117ad..cc27ba7daf 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -435,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
> >
> >  /*
> >   * Serial Port Console Redirection Table (SPCR)
> > - * Rev: 1.07
> > + * Rev: 1.10
> Why should this comment be updated? Since revision 2 of SPCR table ARM
> uses corresponds to only 1.07 right?
You are right. I will revert this.
>=20
> >   */
> >  static void
> >  spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *v=
ms)
> > @@ -464,8 +464,12 @@ spcr_setup(GArray *table_data, BIOSLinker *linker,=
 VirtMachineState *vms)
> >          .pci_flags =3D 0,
> >          .pci_segment =3D 0,
> >      };
> > -
> > -    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_t=
able_id);
> > +    /*
> > +     * Passing NULL as the SPCR Table for Revision 2 doesn't support
> > +     * NameSpaceString.
> > +     */
> > +    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_t=
able_id,
> > +               NULL);
> >  }
> >
> >  /*
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index 36d6a3a412..68ef15acac 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -200,14 +200,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry =
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
> > @@ -229,9 +230,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker,=
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
>=20
> Otherwise, LGTM.
>=20
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

