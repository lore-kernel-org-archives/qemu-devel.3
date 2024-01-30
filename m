Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1110C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 03:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUecS-0000eU-D7; Mon, 29 Jan 2024 22:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUecG-0000db-Jl; Mon, 29 Jan 2024 22:16:54 -0500
Received: from mail-bjschn02on20627.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::627]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUecC-0007bb-Kw; Mon, 29 Jan 2024 22:16:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdtSsYfMo2z84gqTlRxISjl3FUfJ4XmYbSEmPUKNMegW4Xyg4que3LvI5YwwxgFB+OZ1fXHc/TXlmbxFuX2vcGqj7LEBC/siF9Wpb2uCddzkiZPqwFpdv4r7Uw7acHFskDKzZeYgBiOZeFhWdb9ugG2rxPJHcGzDVAwv+Mzt7nRqTypcKNzeQVskSDDbXumR1Qi8GDdaXnIHJ9B5daVq/99dr+liclRlkqDsXkdSpiaDBYTAQphVNoJVsSHKrqzPJn/GyJosPQlMmQPRjf+Io42HSrcstAdry81jUia/I8spnzS1jScAoD33STSVoZo+n40cAPorJkc7K0jZSWhl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVtBuDPELf8/qkemeMEsWvX3+y9uKa9Eq1qrdw5afR4=;
 b=V/W0iJ2ARqt84lf+n+efnFhBI/D6VK8gONjNR+gWoeBVeoR74ag0poKPX7cHAeB2DrVwquwWwooEUslZ8mr7qwIudodGklS+w43swoZZBo42bLKnBoL5/UxXFNVLE0lorbzdIY/x+geuxdZ4rhMjWmC6pYLx/mPrpf8nu4BLkZym8XNCbdOltiYBvF8UG0qyPjeoS17dNhoKV/mSQe+E6xjbcg/F+/YNGIm4ZHsrQAj5TH+L1e6C1Cn03o4s7M0UJDlgIjGsjNJgVFH7NlIzbpq6+RPH1r175odmfxyVSNhvGmtWeMKKfWaVBrSdmiqUAJt318A38Nufx0/LHWXmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0753.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Tue, 30 Jan
 2024 03:16:34 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Tue, 30 Jan 2024 03:16:34 +0000
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
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>
Subject: RE: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation
 to common location
Thread-Topic: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation
 to common location
Thread-Index: AQHaUlj2c34crUqv8ECEnb2uyHCWbrDwPuGAgAFsvSA=
Date: Tue, 30 Jan 2024 03:16:34 +0000
Message-ID: <BJSPR01MB0561C2196A51F2AE79DA67C29C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
 <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
 <Zbczy87+E0gJEzgw@sunil-laptop>
In-Reply-To: <Zbczy87+E0gJEzgw@sunil-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0753:EE_
x-ms-office365-filtering-correlation-id: 6e4be548-ad00-44aa-38ad-08dc2141dd20
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLXwh1PRmdclpiKILeLy+/dnZ2oBqZvecvVnMT738vpt+H6Ry28BTi2x+KtFYRBIOv+trL0vpoV4/iPToSA/GEl7CWJo2WW+LKRqyCXPSsVt0LUhMCe0E7i6R3drKoIrar9FNEvY5k2U0XOQFYFKhmi+n6mzq5MthsDWLaRxeypqB32gVCCo+XfnfnVg6RFfaWoCg1+PJwKLKpRall+eTI6qmFJe1YTnNZYL1idNinb3IODdJGYdd/1sFP8ApKwCno9dVfbANKx5qVgaHkr7mLUV+zK7YKSRu4zHYF9d017DshOet6l0kZ+3CQjYTBJeLO0Tj6i1p3mF6cJfL1NaISfXH9eLKHeYWc2DRDfSk++kfHeYiRfSgfA35+BFhaziFEwvhJK+VkS91JAoqSIs2ory25wiJm0FURZAisB2i6GR4zc+wMG3wNQ12nC08qpy9TFEVzuiyHMo2jBATKQ8CALqoztr9chTqYH3ry45IVJ+DpKxMskcpQKKco3z+4zDkW7blIVGFnugsJRCvkyzmcOjvzHsRSUxPY7D29hdSxBBTFLi52uC1PkPfAUPo8L9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(346002)(39830400003)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(76116006)(54906003)(6916009)(66946007)(86362001)(122000001)(64756008)(66556008)(66476007)(508600001)(66446008)(38100700002)(5660300002)(9686003)(7696005)(71200400001)(26005)(53546011)(4326008)(8936002)(8676002)(83380400001)(33656002)(30864003)(7416002)(40180700001)(2906002)(38070700009)(40160700002)(41320700001)(41300700001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m98yWtViY/z50dL5TZlKe40Ae9D2h2eTflQAs7UruntMEPrPASIKDYhTgDpq?=
 =?us-ascii?Q?wO+1xDGuaFpKmHE3yn30w2jIfIXo7yg4Hp+/xWf44Pb60dpQ+uGgGyj905Sb?=
 =?us-ascii?Q?TDvY54tNr2jXJQ1qFvJvEgl/YHjx7CsBetsbqvDsuMI6FEZ36yCnNVTcJrza?=
 =?us-ascii?Q?gyaPJ7L7pqed3TCYeQNzz3QTAwwO63qLdV0kockrpBBbrblb7UXuofyXvdvQ?=
 =?us-ascii?Q?e/JmBWsAv9KyvzA+rXT1NiyI48gF3gN0o/BgbVRakMOpfb5F/Pn1rAbQOzUN?=
 =?us-ascii?Q?7Qj+IetjL9nkLjqn/xXGcRk3p31siHePeUPOaqN71WoDfLEdYDIgxr6Lj/O5?=
 =?us-ascii?Q?xQfxFXH4FC+gxkPBdCrjKWkmrKsUf0ma63LqfQ8GGjOSgpltqodLI0h9ZT63?=
 =?us-ascii?Q?9Zohafad7SgZpnOu/VR3OIG3wR9K+H8xPl4XmHMyMsXMAB5MuBmWAOotIV0B?=
 =?us-ascii?Q?IbemgVEhp8W3JoZTkAn0XJsvQ0BKy2GAWSI0ynAg5mylaVCHfvHGJZVvwkv6?=
 =?us-ascii?Q?HoKamPNdLf+gMM8BztKdkAPi2S+NABHABFOx54tpyfw+lbDUyYMxUkjEWUdB?=
 =?us-ascii?Q?yx/GIpaWp9yn4pjThklmAToA7cd4LiwLjPfyLuqQlpRb+Rme537UlAg+BS2i?=
 =?us-ascii?Q?WX5kKeejV14QZ24nQrmycP7WTzqAwq1CEmbMG5jlF7wlaarAedylLLwIRV4W?=
 =?us-ascii?Q?wOiPanoSUIcE4c2314FP2RcyJobyN27QMBIrOPwQk8yJSd07ujCwZruU2+bA?=
 =?us-ascii?Q?UyXwyxyUchvtq2PsztdtEjfsv16ZZtTuL4nTnAG7HP2eSogSZWmYpH512fV/?=
 =?us-ascii?Q?9BQDBV5PaB6dzIITp7+LnkiJzPcBbAArtaEXKyaOKqGME0csvN7K5KAyuOBm?=
 =?us-ascii?Q?DUfwzH5Aw3nFajpRxuo/t360r1ymki7SSS+t94hadgEjF6Kr05JZQFbzjhi3?=
 =?us-ascii?Q?ELctoUnx7t9Jn7MIMrDs4ZhmtiLrsnC/O/j/uw7dPVVEcFpUNsGVRwcebZgN?=
 =?us-ascii?Q?//YNwf8KpM00UJf7HaD1fT+abI4InseqVazi2iXxDOr/A535Jc2ZTXrTNeTf?=
 =?us-ascii?Q?2zFj2gRRkvytc7jv5E33sIeGdb0epR8ewRVsY+XH2kXvbsc7mGTOGhvntJCi?=
 =?us-ascii?Q?KIOgFLQ4THdeC5ta0LGdsMJ11cdM+yOK7v2jbJKi7pPe/i+SqBOvJjaIG3eF?=
 =?us-ascii?Q?JduHj9/8MFfif3TCzPTELwsy5BdeJjgiSWA1kqTRSb6iuWycTnouo78Bf8E6?=
 =?us-ascii?Q?D5zCxonurg2NRLt3Cj8HUDp2U49zwtmFQf0vOSZLqqzAmDlBHtuw6LmFlilU?=
 =?us-ascii?Q?reCp7XUB2SmGj0+QlPxxbsv7BGzus9kPo9SiK5HrPZEv1E4ElOa9unznlVQe?=
 =?us-ascii?Q?zf/A5Js9zznuGlw7VcsbVvCnRUbj0Q2TYhkXp78NuFRX23B5gtMOMRioan4e?=
 =?us-ascii?Q?CWCoaYS5vbwfn33VYpnUphCdyYM5ma677TRf3PlTjgu8auO/MBRdlJ3NUz2J?=
 =?us-ascii?Q?QluBXA7ut9J24IsUSKmgYnSHSOwt4VR8XWfF0cG049xWzlY8IUtUQ+3SjzxO?=
 =?us-ascii?Q?AF9WdWdkxGjhuisKgcxkPa7ILjiZnk3hoQ04yfMzPrg1HCFrXKAKFEI6Uwqj?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4be548-ad00-44aa-38ad-08dc2141dd20
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 03:16:34.6086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCyvv8pu9v86uAKCwxeQk1wWSaj2e0wjzO/Ew2ZEiHxy37L6+K9YGsNnEE0WYDVWi1vXcA41HjhKp/qDiZXleNC46BHtWGfN6DWTa0o4X2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0753
Received-SPF: pass client-ip=2406:e500:4440:2::627;
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
> Sent: Monday, January 29, 2024 1:13 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com; =
palmer@dabbelt.com; alistair.francis@wdc.com;
> bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com; z=
hiwei_liu@linux.alibaba.com
> Subject: Re: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creat=
ion to common location
>=20
> Hi Jee Heng,
>=20
> On Sun, Jan 28, 2024 at 06:14:39PM -0800, Sia Jee Heng wrote:
> > RISC-V should also generate the SPCR in a manner similar to ARM.
> > Therefore, instead of replicating the code, relocate this function
> > to the common AML build.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > ---
> >  hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
> >  hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
> >  include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
> >  include/hw/acpi/aml-build.h |  4 +++
> >  4 files changed, 115 insertions(+), 41 deletions(-)
> >
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index af66bde0f5..f3904650e4 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GArra=
y *tbl, uint32_t flags,
> >      }
> >  }
> >
> > +void build_spcr(GArray *table_data, BIOSLinker *linker,
> > +                const AcpiSpcrData *f, const uint8_t rev,
> > +                const char *oem_id, const char *oem_table_id)
> > +{
> > +    AcpiTable table =3D { .sig =3D "SPCR", .rev =3D rev, .oem_id =3D o=
em_id,
> > +                        .oem_table_id =3D oem_table_id };
> > +
> > +    acpi_table_begin(&table, table_data);
> > +    /* Interface type */
> > +    build_append_int_noprefix(table_data, f->interface_type, 1);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 3);
> > +    /* Base Address */
> > +    build_append_gas(table_data, f->base_addr.id, f->base_addr.width,
> > +                     f->base_addr.offset, f->base_addr.size,
> > +                     f->base_addr.addr);
> > +    /* Interrupt type */
> > +    build_append_int_noprefix(table_data, f->interrupt_type, 1);
> > +    /* IRQ */
> > +    build_append_int_noprefix(table_data, f->pc_interrupt, 1);
> > +    /* Global System Interrupt */
> > +    build_append_int_noprefix(table_data, f->interrupt, 4);
> > +    /* Baud Rate */
> > +    build_append_int_noprefix(table_data, f->baud_rate, 1);
> > +    /* Parity */
> > +    build_append_int_noprefix(table_data, f->parity, 1);
> > +    /* Stop Bits */
> > +    build_append_int_noprefix(table_data, f->stop_bits, 1);
> > +    /* Flow Control */
> > +    build_append_int_noprefix(table_data, f->flow_control, 1);
> > +    /* Terminal Type */
> > +    build_append_int_noprefix(table_data, f->terminal_type, 1);
> > +    /* PCI Device ID  */
> > +    build_append_int_noprefix(table_data, f->pci_device_id, 2);
> > +    /* PCI Vendor ID */
> > +    build_append_int_noprefix(table_data, f->pci_vendor_id, 2);
> > +    /* PCI Bus Number */
> > +    build_append_int_noprefix(table_data, f->pci_bus, 1);
> > +    /* PCI Device Number */
> > +    build_append_int_noprefix(table_data, f->pci_device, 1);
> > +    /* PCI Function Number */
> > +    build_append_int_noprefix(table_data, f->pci_function, 1);
> > +    /* PCI Flags */
> > +    build_append_int_noprefix(table_data, f->pci_flags, 4);
> > +    /* PCI Segment */
> > +    build_append_int_noprefix(table_data, f->pci_segment, 1);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 4);
> > +
> I think either there should be a comment that this supports only v2 of
> SPCR spec or it should be able to create SPCR of any version. IMO, I
> think it is better to add support till v4 (latest). Since consumers like
> Linux probably doesn't support v4 yet, ARM/RISC-V can continue to create
> v2 itself for the time being but the generic build_spcr() should be able
> to create v4 also if the arch requires it.
A v4 table depends on the updated acpica. I am not aware if there is a
request from ARM to update to v4. Anyway, RISC-V BRS Spec did mentioned
on poll-based sbi console. I can check with acpica community if updating
table to v4 is the go otherwise I would suggest we cont stick to v2 because
there is no compatible ACPI guest to test the code.
>=20
> Thanks,
> Sunil
> > +    acpi_table_end(linker, &table);
> > +}
> >  /*
> >   * ACPI spec, Revision 6.3
> >   * 5.2.29 Processor Properties Topology Table (PPTT)
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index a22a2f43a5..195767c0f0 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -431,48 +431,34 @@ build_iort(GArray *table_data, BIOSLinker *linker=
, VirtMachineState *vms)
> >   * Rev: 1.07
> >   */
> >  static void
> > -build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *v=
ms)
> > +spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *v=
ms)
> >  {
> > -    AcpiTable table =3D { .sig =3D "SPCR", .rev =3D 2, .oem_id =3D vms=
->oem_id,
> > -                        .oem_table_id =3D vms->oem_table_id };
> > -
> > -    acpi_table_begin(&table, table_data);
> > -
> > -    /* Interface Type */
> > -    build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
> > -    build_append_int_noprefix(table_data, 0, 3); /* Reserved */
> > -    /* Base Address */
> > -    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
> > -                     vms->memmap[VIRT_UART].base);
> > -    /* Interrupt Type */
> > -    build_append_int_noprefix(table_data,
> > -        (1 << 3) /* Bit[3] ARMH GIC interrupt */, 1);
> > -    build_append_int_noprefix(table_data, 0, 1); /* IRQ */
> > -    /* Global System Interrupt */
> > -    build_append_int_noprefix(table_data,
> > -                              vms->irqmap[VIRT_UART] + ARM_SPI_BASE, 4=
);
> > -    build_append_int_noprefix(table_data, 3 /* 9600 */, 1); /* Baud Ra=
te */
> > -    build_append_int_noprefix(table_data, 0 /* No Parity */, 1); /* Pa=
rity */
> > -    /* Stop Bits */
> > -    build_append_int_noprefix(table_data, 1 /* 1 Stop bit */, 1);
> > -    /* Flow Control */
> > -    build_append_int_noprefix(table_data,
> > -        (1 << 1) /* RTS/CTS hardware flow control */, 1);
> > -    /* Terminal Type */
> > -    build_append_int_noprefix(table_data, 0 /* VT100 */, 1);
> > -    build_append_int_noprefix(table_data, 0, 1); /* Language */
> > -    /* PCI Device ID  */
> > -    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/=
, 2);
> > -    /* PCI Vendor ID */
> > -    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/=
, 2);
> > -    build_append_int_noprefix(table_data, 0, 1); /* PCI Bus Number */
> > -    build_append_int_noprefix(table_data, 0, 1); /* PCI Device Number =
*/
> > -    build_append_int_noprefix(table_data, 0, 1); /* PCI Function Numbe=
r */
> > -    build_append_int_noprefix(table_data, 0, 4); /* PCI Flags */
> > -    build_append_int_noprefix(table_data, 0, 1); /* PCI Segment */
> > -    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> > +    AcpiSpcrData serial =3D {
> > +        .interface_type =3D 3,       /* ARM PL011 UART */
> > +        .base_addr.id =3D AML_AS_SYSTEM_MEMORY,
> > +        .base_addr.width =3D 32,
> > +        .base_addr.offset =3D 0,
> > +        .base_addr.size =3D 3,
> > +        .base_addr.addr =3D vms->memmap[VIRT_UART].base,
> > +        .interrupt_type =3D (1 << 3),/* Bit[3] ARMH GIC interrupt*/
> > +        .pc_interrupt =3D 0,         /* IRQ */
> > +        .interrupt =3D (vms->irqmap[VIRT_UART] + ARM_SPI_BASE),
> > +        .baud_rate =3D 3,            /* 9600 */
> > +        .parity =3D 0,               /* No Parity */
> > +        .stop_bits =3D 1,            /* 1 Stop bit */
> > +        .flow_control =3D 1 << 1,    /* RTS/CTS hardware flow control =
*/
> > +        .terminal_type =3D 0,        /* VT100 */
> > +        .language =3D 0,             /* Language */
> > +        .pci_device_id =3D 0xffff,   /* not a PCI device*/
> > +        .pci_vendor_id =3D 0xffff,   /* not a PCI device*/
> > +        .pci_bus =3D 0,
> > +        .pci_device =3D 0,
> > +        .pci_function =3D 0,
> > +        .pci_flags =3D 0,
> > +        .pci_segment =3D 0,
> > +    };
> >
> > -    acpi_table_end(linker, &table);
> > +    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_t=
able_id);
> >  }
> >
> >  /*
> > @@ -930,7 +916,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBui=
ldTables *tables)
> >      }
> >
> >      acpi_add_table(table_offsets, tables_blob);
> > -    build_spcr(tables_blob, tables->linker, vms);
> > +    spcr_setup(tables_blob, tables->linker, vms);
> >
> >      acpi_add_table(table_offsets, tables_blob);
> >      build_dbg2(tables_blob, tables->linker, vms);
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 2b42e4192b..0e6e82b339 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -90,6 +90,39 @@ typedef struct AcpiFadtData {
> >      unsigned *xdsdt_tbl_offset;
> >  } AcpiFadtData;
> >
> > +typedef struct AcpiGas {
> > +    uint8_t id;                /* Address space ID */
> > +    uint8_t width;             /* Register bit width */
> > +    uint8_t offset;            /* Register bit offset */
> > +    uint8_t size;              /* Access size */
> > +    uint64_t addr;             /* Address */
> > +} AcpiGas;
> > +
> > +/* SPCR (Serial Port Console Redirection table) */
> > +typedef struct AcpiSpcrData {
> > +    uint8_t interface_type;
> > +    uint8_t reserved[3];
> > +    struct AcpiGas base_addr;
> > +    uint8_t interrupt_type;
> > +    uint8_t pc_interrupt;
> > +    uint32_t interrupt;        /* Global system interrupt */
> > +    uint8_t baud_rate;
> > +    uint8_t parity;
> > +    uint8_t stop_bits;
> > +    uint8_t flow_control;
> > +    uint8_t terminal_type;
> > +    uint8_t language;
> > +    uint8_t reserved1;
> > +    uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
> > +    uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
> > +    uint8_t pci_bus;
> > +    uint8_t pci_device;
> > +    uint8_t pci_function;
> > +    uint32_t pci_flags;
> > +    uint8_t pci_segment;
> > +    uint32_t reserved2;
> > +} AcpiSpcrData;
> > +
> >  #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
> >  #define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
> >
> > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > index ff2a310270..a3784155cb 100644
> > --- a/include/hw/acpi/aml-build.h
> > +++ b/include/hw/acpi/aml-build.h
> > @@ -497,4 +497,8 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, co=
nst AcpiFadtData *f,
> >
> >  void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalo=
g,
> >                  const char *oem_id, const char *oem_table_id);
> > +
> > +void build_spcr(GArray *table_data, BIOSLinker *linker,
> > +                const AcpiSpcrData *f, const uint8_t rev,
> > +                const char *oem_id, const char *oem_table_id);
> >  #endif
> > --
> > 2.34.1
> >

