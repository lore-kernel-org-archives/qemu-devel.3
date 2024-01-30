Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD7CC47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 03:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUepx-000689-RD; Mon, 29 Jan 2024 22:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUepP-0005zE-5l; Mon, 29 Jan 2024 22:30:28 -0500
Received: from mail-sh0chn02on20604.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::604]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUepM-0002f6-4L; Mon, 29 Jan 2024 22:30:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zok5XDiISaJqk7OtHzOAj9aJjx+rqlQQ49W3E+I6hwI1OVf4wQr6GpcLpzXsRb3cfBC3dJKIRlGWV//0+FF16YHpktLKiVBqcBqcNM1EKaGOWdVEGf079MTSzyN97SXWSsN+YrUiBKdNh0/Q4CfMT1bYIA3XQPOPlvpFIf32OQkSSVlhxfsYmPUT9fBJObqNUL1hR159c6mUQBJKGGtGgEX2Wzpx8aKVfTOLTrxb1ARoF76EFU8aVh1PAZU3LFxQLnK3pZj5sz3+90umcQ3bYDySzmaNNsyL5I3JGhVEzmtxKOjVREVzeIiauBU2s5kDt8kgLHOFkPTMHcWR9cXplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAcPJNgYqkQKrSOjp1eNoTWazO/781XNf0+D8CRVXGQ=;
 b=D0Qjp2b/DyvHgAh0avOJGwHqtd6rKpRXIMa/WJF7QNArgRqx6oC5ovHfKSc+VwEV1iRM17xKhhaX4X0i9qJHepOlGqFzcX5mm7ikItgQW764RxoKFHl9LNTC6BXuT/THJ21dJjbzcVjg+q/y2v7BADrwkhlAJXsimPoOx5vh/nQwgvz6r1HaVFhJIjl12NEIffo3vSYqTKoWaZwlhumvPCCpLVTrReRoPHVpi3VK3L1dVmRTJyH4Ax3xRM9KFWcjV/A/GqQDHsj65uA7//HdRnQp4nZhhdhTdfWw/k3/mKVaN6LEcyApn4PYPBBysVoQzGcZ+PCavBGWY4aQMX+Xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0738.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 30 Jan
 2024 03:30:13 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Tue, 30 Jan 2024 03:30:13 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation
 to common location
Thread-Topic: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation
 to common location
Thread-Index: AQHaUlj2c34crUqv8ECEnb2uyHCWbrDwg7SAgAEtGJA=
Date: Tue, 30 Jan 2024 03:30:13 +0000
Message-ID: <BJSPR01MB0561D2F722BBC446017856709C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
 <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
 <20240129-e51095f37656f4ba5262ec68@orel>
In-Reply-To: <20240129-e51095f37656f4ba5262ec68@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0738:EE_
x-ms-office365-filtering-correlation-id: c6b32d2b-2fb0-4248-5492-08dc2143c534
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlcvCQw7eMYGZqgh+G0onfPDDE1nean8+V+PKXzobVBE+F/92HVP52LdlpLRvdlgmz+dcymmNjRGM/Voj3nzYGaHGZbxn4rzi/yFoKIZB3NsYGp4XeyJnwL42bwMSxjUa1h0Th2pxuXJv+a8gmkBeNBfemLqoriXUKaD8LSbKbI2pxrM6QUbevFmJko4C2GKJgK2/z/tWWQ3+u52kRAEW3KfMXOPSJMnwr9l4v6C6yDZZ0jBPZrxzM8bLjg0Po1mBzxTW7lVZ+12bhPOJ8xpOCHSAuS6z2hBrVeagcO7exxIYsLOBOCxGEcytI28IhPvANi7UADZA237xv8ONFb0CdygvrRlTqGu961rKMf8Gl5DkIqoCc2ywil6Dyzg/+WYCAz0cphrS/31cqLTbNuI6YT+o7TetQ+UasdAhRKADSJ3EC0EMyFtCTB+ud6CVS2AZJfMcEHS8c6wnO6NovDL0Vh3gJdvnSC0xGBFJKMsJHx+M6lxTH1tH2q+npqwkLwxhnh5A4ttSdcOytA9LB/AL6kWpAP1frjvty0i6OVfsyGd9rS3jeMczGepQcGoIGMO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(396003)(39830400003)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66446008)(66556008)(76116006)(66476007)(38070700009)(41320700001)(8936002)(2906002)(66946007)(30864003)(8676002)(7416002)(6916009)(5660300002)(64756008)(54906003)(55016003)(9686003)(33656002)(40180700001)(83380400001)(71200400001)(4326008)(26005)(41300700001)(508600001)(7696005)(40160700002)(38100700002)(53546011)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oRr/q2s16YrBCNOCT6YHqL6f6WwO+mXF/uWnKykQErfBouQZ1CslQTlRaxSM?=
 =?us-ascii?Q?vxoOJ0b0YE4wRc7mkzLNma3h8CklcPojku9gQJ3dg/I43ZGnpdPruSZKAo38?=
 =?us-ascii?Q?K7Nrx2YeVUK86q0mzDkMq41MgI2rPW5Ui4/GvsVPeNavkTzLFSlXSftXEYKm?=
 =?us-ascii?Q?/emaEuwrOFT9faPYfpv+JD5TwXN1TlCxpuKNGL5trf7mBtkDle7KMuTyCodQ?=
 =?us-ascii?Q?VE3cUm21wUlKMVupe2ynC2TjXdS/jdbnBc0FT/Briut1Mgz9/XxbmcbqsPUk?=
 =?us-ascii?Q?+UV+Q7w9tLcoYI/MThnCBlBH9AOgtiXJlyoR5Y6GnBz+MwjkcdtoK7MkrBog?=
 =?us-ascii?Q?eaaTbgVNfAlkUxQOgt29RqDPjQMkc7MmKZ2+3bzt7/AMANEEpoObTpKHNxiY?=
 =?us-ascii?Q?Z0RhglAV8KBj90YNn5V1jLPQwYTcdCwUsI+ZrzzEQL8FxSwgaovgoaQZavjw?=
 =?us-ascii?Q?cHgLX9EtYMcokyficShozRnaNeLyNRQpSeS6oRwL76CIQVU8IdoT4CLY8TaA?=
 =?us-ascii?Q?UuO4a3p8rp4qY1paip4yxcn2bpdHZqu3lP6ha6GyCcIouQx08bHknA/eJzoB?=
 =?us-ascii?Q?y5Dh1zbOp4rDrY7nISS1J9xiicsMo3FnKMtcvizEpbrxytZuWPzZrfkwwQxp?=
 =?us-ascii?Q?OpMW0XuddZL83wBFoZNkoRfUOAlFxntPW0a1sXmi3geVj3lePMcqG9iuofzU?=
 =?us-ascii?Q?TDZVPRsofBsFGqXyIy7bjTCdG8rRmpqmSad0bjTAxyEvqQEzRwnf+6QWQ49I?=
 =?us-ascii?Q?RZu/a+Y5i6ofM+Qnam5x5RsewzUhvPCDetsTXOnd4akUB4DJAwYSgCZHLOKy?=
 =?us-ascii?Q?M3UHE2i6dg80q+YhNqvSg6H3rfF6vZ3T6qRd07rNDIKlMXl19JMoIm8HpYlC?=
 =?us-ascii?Q?kh8Hy4+MCgKmFMPcTvjh7HlpTv/vCKo3eZf/1POI3HnFtZB8RsXNxl57dbKW?=
 =?us-ascii?Q?m0lXTGZ+0FbL6x9Uv+SQOuAaQvIn1xH+Zh8M3pEp/RceFMY4eaFbAs4Zq8bd?=
 =?us-ascii?Q?i7s/+XEF6YXW9YX/c19fGFRfANr5rS5Mw68nBkqHBu/JFQzWAAMU2Wj7C98e?=
 =?us-ascii?Q?4cxW7azZWsRuRvkfyf/deW8ikUVCqJUichsUCluO2foJqFu//uoSiJukLqBS?=
 =?us-ascii?Q?DRJ1EU2oHjYmPtTyIswNhbQ0lfpB5zBf8+N+utXLvNT6ntwge3vA2+kqbaN2?=
 =?us-ascii?Q?jJzeWnBOV4xTnKGEQWW583VHQyFyD5h0fwW0uv5yegQRFB5dGOeloHFfzN2v?=
 =?us-ascii?Q?+7PF/F62Pik9EBYGywfOC7rm1AaVVWnKsF8QEuvjCHKQN4vR6TWBXC/CcaTI?=
 =?us-ascii?Q?iyAw5je2rQoAuXPXqRSb4o7e7z05RnKf8/pbwWinIU5wIDU9lTJpRN7AOYaB?=
 =?us-ascii?Q?OAta6SPwlQ+A0MDM6dYro5xy4Clf5jXxcTetW5NRZTpclWpx7NbgfMC9zjfv?=
 =?us-ascii?Q?1DUneldeo+lnLwOvEN4oW4NSYMNf9NqSXQlc7+ZEghqn1RqyHF11y3aaFZoX?=
 =?us-ascii?Q?OIPdewXpduTxi8PutY1w9N+7N7CKJc8wVjGETLxVkH0DfkXvBuAaoqISYnHU?=
 =?us-ascii?Q?aoqotStJnDIl+DEvf6+GQVQ4/5LqVHgeLfWyxhvFZKKAgrv+t6VOCzHFZ9Z8?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b32d2b-2fb0-4248-5492-08dc2143c534
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 03:30:13.4732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvOb7cM0AmyRbOB23+oojG6L7bga/sZgTeNc9r0nl8Al/1zLDdTPVv7g3p+z0F53unsjPNwAT7EQ8jKIf9oN0/hEHBa577+DLuCpCdrjCvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0738
Received-SPF: pass client-ip=2406:e500:4420:2::604;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
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
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Monday, January 29, 2024 5:19 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com; =
sunilvl@ventanamicro.com; palmer@dabbelt.com;
> alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com; db=
arboza@ventanamicro.com;
> zhiwei_liu@linux.alibaba.com
> Subject: Re: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creat=
ion to common location
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
>=20
> Sharing code is good, but if we have to parametrize the entire table, the=
n
> we might as well keep Arm and RISCV separate. Building the table first
> with this struct, just to have it built again with the build_append API,
> doesn't make much sense to me. Do Arm and riscv really diverge on all
> these parameters? If not, then just add the parameters which do diverge
> build_scpr's arguments.
It is kind of chicken and egg thing, I would suggest let the arch code to
fill in the value. It doesn't make sense to change again in the future when
both riscv and arm realized the parameters were different.
Can arm confirm that these values wouldn't change in the future?
>=20
> Thanks,
> drew
>=20
>=20
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
> >

