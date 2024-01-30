Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C12EC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgWA-0005ZX-Em; Tue, 30 Jan 2024 00:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUgW8-0005XC-BL; Tue, 30 Jan 2024 00:18:40 -0500
Received: from mail-bjschn02on20614.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::614]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUgW4-0004sc-SS; Tue, 30 Jan 2024 00:18:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4UaAOawao/ZYT7NiKZ1SxFXSojt9J60a51UvipQSiWyOx5XE+MP9iPF7rK3hUwp5ERY9pD3iMWhMdMIaLlqeCU75tEOrYuWXhKwSJJopWxrDuyFsOXErUK9OX/qdsfsfWTi9TzpROG8bShvbm8tijJw8zK/joGhtvIx5l5wkh5DyqynC3Nx4O356RCCmeSWgpAnM2qA/15Bx9ewcw3Vxtcyl6CsfJMWPS24QAW7ricJi4cjt4W+93O5eiiGfFy4zDQSX30//j9bSDFE+R5gKRDO6lthRG4Aw/Zmtjp3gKIXmtBkYNzsJYZyT1qLY6O5nHDwwhD5VnDaoI8XzTzm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRpAR7hOh6XqO5fyg8rR+iNJmCJa3CqbZImjV/4wbBg=;
 b=gs1+U1ACeUXOGLaBieMAK27QWhES5Y1JodiUvWRt0u6jovzg+qIsM7KjU59a+oVmL+7Ogsi9xcDjPDZXfZ9a+czDoT8kMzMwm6WtZQprSKo0bISyLU6ul7zkImClTUr4/vLjVT5ZVcu+LTli6DWtOYdfY0ZB8fXapqFX3WcH2StgpTEzLFFpVSdweAZjaJhwhpr+SY2Fhxyh8vsPVYah0dHNAi4J3zHRIW8PQh/wqvmBDDTl7D1ROj/jnI14C58NlHG90aAPuCAv86z2E547yQPGVuQVesfgfDHTdZpe9GxGo5fWAG1lSla2/rEjMI27Js7pcrUidbRJtF+clm/1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0657.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 30 Jan
 2024 05:03:16 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Tue, 30 Jan 2024 05:03:15 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [RFC v1 3/3] hw/arm/virt-acpi-build.c: Enable CPU cache topology
Thread-Topic: [RFC v1 3/3] hw/arm/virt-acpi-build.c: Enable CPU cache topology
Thread-Index: AQHaUotAR3phIJDYW0aSb65J9lLXcrDwodyAgAEru/A=
Date: Tue, 30 Jan 2024 05:03:15 +0000
Message-ID: <BJSPR01MB056164DC332463349ACD6F3A9C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
 <20240129081423.116615-4-jeeheng.sia@starfivetech.com>
 <20240129110823.000076df@Huawei.com>
In-Reply-To: <20240129110823.000076df@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0657:EE_
x-ms-office365-filtering-correlation-id: c95f9798-0f77-4a22-ee65-08dc2150c449
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4wCqZRO9Sky4I+8VYqgwlopHT/iBKUayiz8S/ELBOLZo0xgP3BiG/Tbz6Q2fmp6GgXdDGRxooHS5P5GDXCg9MrIv9QjkzeUKFycxe5dYHC3VfCDTA9lHBhKKexwjzP9gQ66yCmlsY9bcfX8fJLsvViowyPlr5RQKI65ziKza7BwH0Gb3qDmoHE1T41rDui1k4As77yZdWcStJifdZ26acvy02/3cRB4NLUxCvjpGTtuoWZKzgQKKa2U4G5Ex8ylG8Uqpr8WJS17+YiGjpvM5aJ8psxkPJHYE8jAwhfVoPoh9CGwqozr63RvGYtguEFR0RjSvRkYWp1lWy/LIl9rm/Mews1ODTYug9rpBunOn49n04cf3FcuFDEiGPXlsDtQqusGrbL4HuWc06Ltl+km0yqT/VcvX1R4J/BkwismrmD7o2IPqFgE+W9E72P9ypyobSmIS3v9rt2nQRNnYg0fskoyIbz5MG0s6w/0+kxQfz6qENJoKxn1yoNa0pHnTsvHIKoQKih9/V+l6gubImYIvafY3joqaiTG8ds2S4Izusw4OwRwpvJdNCmBbpzrcQrgA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39830400003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(41300700001)(2906002)(40180700001)(5660300002)(7416002)(33656002)(41320700001)(66476007)(8936002)(66556008)(66946007)(64756008)(966005)(66446008)(54906003)(6916009)(76116006)(86362001)(9686003)(83380400001)(40160700002)(55016003)(71200400001)(508600001)(53546011)(7696005)(4326008)(8676002)(38100700002)(122000001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yoScppQQP2whPoaJlSnj93+R4IHaNRcP7NFphBhYGzXk5dCunLDOVCKYfSRm?=
 =?us-ascii?Q?El/0HsuGQ6vO3acy7yKA/Q+UqclHzrASeJF1OL4/fviXOx+H7in/ENHnc656?=
 =?us-ascii?Q?akO0vmBRaOGzRg5tyhLk8IqTo6voKBYZ6iB4rSQ0pfKz7Alzn/4+bJ5e9OY4?=
 =?us-ascii?Q?+ZETc4Ep/bA8D/8SP6kKsRmDfvc/wL7EdKIT9jXddbPyxfzB2fq/ZkctkomR?=
 =?us-ascii?Q?GohkJQ7H/gm+1JEmN+zSXPWlsE4shlkAIC/i7CQV3/fWKVD5HV5kQfKPtOJY?=
 =?us-ascii?Q?BsGMJ9wx8sKdqF5h9Kp/48+9A8NyIQLV+8WKzu3oz0EssgyAPC6vgoH0eFPR?=
 =?us-ascii?Q?NeSABcIfc3mmo9XWMCtiUsEE3CqL7W/xSD68VPHETPZowtaLsUsI6QVL2Jny?=
 =?us-ascii?Q?cWNeIs+XUg5VicAnavJErm+oqcdxNIowi0Sa7L3oYWgr362X7yCtI8tOrZ/l?=
 =?us-ascii?Q?8vJzuTfh1osaAdbeeXMMVgZ9Ak8HVdT9lmMcsM+ZAtaDOmIXfkEM/rGd2STz?=
 =?us-ascii?Q?Lbl0n2ItccUyJtSaS8MppiDxih0Kq5FM7DYl7SM9a0/Rr/0WPHXagdIUTb2F?=
 =?us-ascii?Q?iMQ2/URIgkggjN01s+h9uQAWo4UdML+yCJR9aHZq/VaUrBynpw7+TqWyO8qw?=
 =?us-ascii?Q?aM9UXwamTpyA026Pcb3BGTIRzD6+kS1hjzs2s03wWmhcjG2jxWdlfTK3BEtw?=
 =?us-ascii?Q?QDddePVPMXPc5U4pvI3AuGZODzq7Srchfp07MVT3vW8eJJIYQFxfJrocC0dW?=
 =?us-ascii?Q?CDRPp/qYnALGaRym8gSBipUvOQ40G4UANkFu+gfANkUNgm85I0kz/Z4VQYoM?=
 =?us-ascii?Q?2IVLEICYY0HS2HMJtLWDLjRJnKiIc0zTDbKP07lYB9hBi7D8Vb0Znsvf3TL5?=
 =?us-ascii?Q?SAhyesW8Mc9yAfd5H7+aCsF9UQakpNDuPVKXvXIyPZnhQxNhfuRlzkJRrJ4x?=
 =?us-ascii?Q?jNRzHJ+CAaCdrQbT06RS4y2LuZVLEtERclAe+l/EF5wGSKEFufsPRrFMyo7u?=
 =?us-ascii?Q?ekJsYN7DylcOQfPUgMsUAPg7AzP11UetkaJk+/57gh7lhlwWE8GX0InEBF31?=
 =?us-ascii?Q?Cx997gb5muKIifX+Wh9Le5UDLRz7Zym2RZ916HFXqCx+20U0soZIVNjV9AcD?=
 =?us-ascii?Q?uCfD2CS2syNVHIw8Hqy1P2vqXTPoOwX8nFKxK4J9O6ZnDKEGMNrcU6e2KYD0?=
 =?us-ascii?Q?hv4menot1xTMy5MzPa6K9triZDUNTbad2hR9+XgiZh0VskYB9BXxTMzaDTqa?=
 =?us-ascii?Q?OwDA6Ezfa7/AY4yrjaW1vJXCQBs3thU/3YEKYNc3T7W6tQrPgjFUqQnBFNIN?=
 =?us-ascii?Q?ZUJvZmsb910Jzkk4xIkVj96XTzbBYD+zigft1TsVrjIA9Z9qT2hpZhLy1Wt4?=
 =?us-ascii?Q?MQj+MfsAhrQQlOtYmHtXKRI/PMn/JqOjODNvByziLJUf7Ad69QzOX6QZXsFZ?=
 =?us-ascii?Q?yX6KQxbSW74o2tD55fzpHslVyw7M84l7p5N3DTI9DtU/dbSl3ThEw5//6L9R?=
 =?us-ascii?Q?//+NvQOHFGeek6SETnI3wOTcY7891IAoaUDplmNiX5d1Mw1tvd3r/1foQb5d?=
 =?us-ascii?Q?H/HK0PYonDF5lat/Eoigak/o+Czyidwa8qzlr3N00MeTG/53pQKwlThzDUy/?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c95f9798-0f77-4a22-ee65-08dc2150c449
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 05:03:15.3420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbLOeLf0o8EoTaMNVztEwnoRVrtqoEbITSQ0ydh83EuIy5QvBmdiQuFvjUx207t0QtTF3iIk2cr7pvqqyRnqJBIDMUlVsmJgWAaVwg2m9Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0657
Received-SPF: pass client-ip=2406:e500:4440:2::614;
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
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, January 29, 2024 7:08 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; shannon.zhaosl@gmail.com; peter.maydell@linaro.org; =
sunilvl@ventanamicro.com; palmer@dabbelt.com;
> alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com; db=
arboza@ventanamicro.com;
> zhiwei_liu@linux.alibaba.com
> Subject: Re: [RFC v1 3/3] hw/arm/virt-acpi-build.c: Enable CPU cache topo=
logy
>=20
> On Mon, 29 Jan 2024 00:14:23 -0800
> Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:
>=20
> > Introduced a 3-layer cache for the ARM virtual machine.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>=20
> There are a bunch of CPU registers that also need updating to reflect the
> described cache.
> https://lore.kernel.org/qemu-devel/20230808115713.2613-3-Jonathan.Cameron=
@huawei.com/
> It's called HACK for a reason ;)
> But there is some discussion about this issue in the thread.
>=20
> The l1 etc also needs to reflect the CPU model.  This stuff needs to matc=
h.
> Wrong information being passed to a VM is probably worse than no informat=
ion.
>=20
> Whilst I plan to circle back to the MPAM support (perhaps next month) the=
re
> is a lot more to be done here before we have useful cache descriptions fo=
r
> guests.
Thanks for the info. I will spend time to look into.
>=20
> Jonathan
>=20
> > ---
> >  hw/arm/virt-acpi-build.c | 44 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 17aeec7a6f..c57067cd63 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -426,6 +426,48 @@ build_iort(GArray *table_data, BIOSLinker *linker,=
 VirtMachineState *vms)
> >      g_array_free(its_idmaps, true);
> >  }
> >
> > +static void pptt_setup(GArray *table_data, BIOSLinker *linker, Machine=
State *ms,
> > +                       const char *oem_id, const char *oem_table_id)
> > +{
> > +    CPUCaches default_cache_info =3D {
> > +        .l1d_cache =3D &(CPUCacheInfo) {
> > +            .type =3D DATA_CACHE,
> > +            .size =3D 64 * KiB,
> > +            .line_size =3D 64,
> > +            .associativity =3D 4,
> > +            .sets =3D 256,
> > +            .attributes =3D 0x02,
> > +        },
> > +        .l1i_cache =3D &(CPUCacheInfo) {
> > +            .type =3D INSTRUCTION_CACHE,
> > +            .size =3D 64 * KiB,
> > +            .line_size =3D 64,
> > +            .associativity =3D 4,
> > +            .sets =3D 256,
> > +            .attributes =3D 0x04,
>=20
> This is the duplication I commented on in patch 1.
> The bit set there is the one to indicate it's an instruction
> cache and we have type doing that as well.
But this gives a great readability, no?
>=20
>=20
> > +        },
> > +        .l2_cache =3D &(CPUCacheInfo) {
> > +            .type =3D UNIFIED_CACHE,
> > +            .size =3D 2048 * KiB,
> > +            .line_size =3D 64,
> > +            .associativity =3D 8,
> > +            .sets =3D 4096,
> > +            .attributes =3D 0x0a,
> > +        },
> > +        .l3_cache =3D &(CPUCacheInfo) {
> > +            .type =3D UNIFIED_CACHE,
> > +            .size =3D 4096 * KiB,
> > +            .line_size =3D 64,
> > +            .associativity =3D 8,
> > +            .sets =3D 8192,
> > +            .attributes =3D 0x0a,
> > +        },
> > +    };
> > +
> > +    build_pptt(table_data, linker, ms, oem_id, oem_table_id,
> > +               &default_cache_info);
> > +}
> > +
> >  /*
> >   * Serial Port Console Redirection Table (SPCR)
> >   * Rev: 1.07
> > @@ -912,7 +954,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBui=
ldTables *tables)
> >
> >      if (!vmc->no_cpu_topology) {
> >          acpi_add_table(table_offsets, tables_blob);
> > -        build_pptt(tables_blob, tables->linker, ms,
> > +        pptt_setup(tables_blob, tables->linker, ms,
> >                     vms->oem_id, vms->oem_table_id);
> >      }
> >


