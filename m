Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90910C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6qBg-00028W-Jk; Tue, 14 May 2024 07:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s6qBR-0001y0-0t; Tue, 14 May 2024 07:19:04 -0400
Received: from mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::719]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s6qBO-0000VD-P8; Tue, 14 May 2024 07:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAvOeZJwBgcITYk5DV6UBXgIehnXNl22sBtb1WpyNtYJlU/WdGcJV44DCXDGWKRfkjela62xv5OYFkvSIYd6ivbZM5Ey+iHt2zMSvCRIbj4heTNYY51AtM83jbYbTQ69/AnDC/T4dhv58fShb240uyzCvRhf439zVBMjVnW5n/EX/sTWYrjvNMGN3sVWDu0AjP3swR5m3FPROLvXusGmT6Rhvi0o2F4Ux7S8JngIab3/g5v6F9eG10m+Wa82jj4qsbXJ1r/xReb+2E2bz9NYWXvfwMHEmkWAVnNtwtVjJbFzNwc1haOoY8JTF2q/8sRl4vnlkJP1TOCBdx4vSf91FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxhEIjvL8ex1M2lzlfUIeMM9alDewMIfOIQfFxQgx1U=;
 b=BhcdK4g62VdF8cBY+JWz4UnDyoKpUagcUlKMPPTq2LKsMyyIMGMtImuWZoVHIj+PgEEn4SfqHDgjI1y8hMwwtvRN6frOcsT6nB1zF9uUvyxlsv7rdZ9fiYlxhsMxS8MRZKhmDeYp6CqfcR0GyuSFEMVzJ/GMeEMDzycDKqpNB5VGZ9PE+7BDb/2Qs3UcIhzHPuNML8oyVRNtIvHQXZ+yRGu96GfN/w/hxqX1NqJDTT030Gf1Cb8WUwhV+LzN7xnlpyTpKuWjR+ljffsotdH0V1MV7NV9cjuarsztQPuxZgXfbocgNty8nbGzZLljPmmQfTqS/kW6WBgBNdYRH8IgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1280.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 14 May
 2024 11:18:38 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Tue, 14 May 2024 11:18:38 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "anisinha@redhat.com"
 <anisinha@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
Thread-Topic: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
Thread-Index: AQHaoD6TJusz/RVVrkmf1vrsO+W0+bGUvcGAgAHilDA=
Date: Tue, 14 May 2024 11:18:38 +0000
Message-ID: <NT0PR01MB1278A2D1A44A6616011F0A779CE32@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
References: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
 <20240507052212.291137-3-jeeheng.sia@starfivetech.com>
 <20240513023035-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240513023035-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB1280:EE_
x-ms-office365-filtering-correlation-id: b3fce442-d379-4596-0544-08dc74079a86
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yqLWJX/RK4OfYDEmcz5RqLBz6a0E6UXYLdZoeZFjpU415FPik/Pp32NRVhU1Ug0amfUa+oP7mW0F8UdZbkotADed2gFBPe577YeyLWDol2tiIdl2mqJO9HumEFqG85bGUKU4lXFN67jAvncIcJBREEh7QnqwNFlshurENf99nzvE7AuFkofeoO1e8zr45dsaEDS8EuH6w/J8sMSsTEjqNt3D58/WgeyDVft9Plj+6CtvTaMjE+eeW148uglPjjNin9xcL9vmC/lZAlliyp20smPzOUzRrSEuBpfenXeREIZyQzKkdhZVqXzdrdAGKToH1xazHPf65XssXREjI0Qr2e4uaVarxoCB4OzLRumdbMhx2dnEg77Vw7N4dG/GdFa9Jk7Ozj8a1a4alOjIfg8DrEtPcNhIbaBxKOttXqoSrwKFM9PJJax/MTgqEYHyqDOrVAmkRUjfcsurGerRboZMtRIkYQJsvPgjY2jsLUxdYUPgiP5M5B8gFROY64QuRtnZx+6GbAua2yKzXtyN2Ru9hO7Bvb58GAV8Ks4T9ic4S7LMaiH4eWOAYDUWFE7siY5G2j1Lg0Ms6VN6p9B0i1tia40hTujsn1EoVGXdZAA1kz5cAz3Cg63KFP7wjh0l4rps
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(41320700004)(7416005)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Ba8V8+811NSWOwH6WIQFfIgQewU9WU32HtvFgaG7HFl8QnIU0msFZTWAHUE?=
 =?us-ascii?Q?EnydZKdt1QO8Ue2mgYGWSbEXiD2NDwf8FRK0uSeBZdbOJlFc3E1UwwORtQAs?=
 =?us-ascii?Q?jEvkH8RItx1Q4Pri+v7C0PCfEaVvrZSnVlWauosLY2h7yaX07rk01g/JmzMO?=
 =?us-ascii?Q?7UqLg3l+8ZI4r90b5FsBAUbNw+gh1mQEytdPPgBp3JPTehAT/JHcO+L7Njyj?=
 =?us-ascii?Q?kVgyt1VHFBmolqatbriB/s4EuEL8Gz0zhlgDa3pAvvfG6PLmepLo8dxImWKo?=
 =?us-ascii?Q?K/wAXU6Mf3pFS+ZgUedqx4Qx7ezJbg5deSL+BMTXDIbTeJ6bHDYZ3SkoITKX?=
 =?us-ascii?Q?7qQG5FqjPyz8XZH/0tnCxRL04FESYzwOfK+a4mpq/nLRvlsBrxVhcXMTWLk+?=
 =?us-ascii?Q?HUK74E4kXeHVlyU7PBa3cxa1VHZumHWZ4bTs5cA25VWJFtGXc0Ksd5JgUEFY?=
 =?us-ascii?Q?ojXekzVPD3EffsEXqnEWVNTANA23Qu5wXesfbS8PZZ5PhEhfIulUHtfEkiW2?=
 =?us-ascii?Q?Smz0WE8y7Cr84RC2WPkiNGspOWshps9TS2SVO8JrjDVNQI8ALODz5jfntcqL?=
 =?us-ascii?Q?GNEErRK69Jy/eb0U/0N2imiD5fEFTf+Qxq8yU1Ndp+TZgBu5TX8T/8blipqO?=
 =?us-ascii?Q?7+tnRIt4ltT4oLLQiH6pZEQTOJrfD3I1gO3R+s/dEeQxbqzM6wrfVtYWBzlG?=
 =?us-ascii?Q?QPJgB/wmLdKFpWcFX0wqDtAAtfVmB6xAlLwcBAdpDEGzEDWTQRQ9ry8zn1U1?=
 =?us-ascii?Q?DHDO3tgu2zD85fJ6ylw3yRhVArPyQeE77Efc8o3I8l/IvPhPqNQ9i7BLzkTM?=
 =?us-ascii?Q?1ag1ncmod7bAUhWaIbHRqUyUhL5a/ZW7Yb8TukaBYX0XuameQ5DDAUwmznPM?=
 =?us-ascii?Q?+WzU81ji8NJT9DNVQU8hySdyRrKM733ljKgW6+BBKB/GN4CASg+ZZ+by1O9h?=
 =?us-ascii?Q?2nzEWSazjPsf+kNoQHtXb5uUs5oNXzSsX+46IZa5ZBFtzfvSMo+9xiFiBevV?=
 =?us-ascii?Q?irNidVPti/+BPiOFM7VGWDIvMaE9GD6+fZDVUuQ71slNWEqAfNEAficPOGUD?=
 =?us-ascii?Q?aZz+dlz9kjSvUqXHQlXuM3AtOWqndIWc2FN/UBP8Aedm6lDl+MGautsCINRY?=
 =?us-ascii?Q?gM2dMaMNtyNg2lPgliZQ3bsz185IEtTUg44mDOi7ACLqQP5rvh08ROm7Fv2P?=
 =?us-ascii?Q?ASo9YSVKcaiV9BrQZ/VRFyNrmn2lV6E3NOe8UOTE8lRbXHPoFr6I/gtdLUBQ?=
 =?us-ascii?Q?x7gYtN0WhPpiZPveQtX5uJ3iSH4cmI9fYr27YZSC1lbWsShAdSdy5rEmBSH6?=
 =?us-ascii?Q?0SOvy08P++1TNLB9ug8yH8gu/p01tKfmYpLnM1o3A/G7KIGfAY6P05iM0lo0?=
 =?us-ascii?Q?SIEerovoU/AS2/FYKB9uQZ0Sbx5tjqO64BpegntF50ipz+/t8TS1Thfmzuyo?=
 =?us-ascii?Q?x8eAyFVy1rvQFJsVtT3YDvjNf9azqzU6Bd/ePRG6aTyAR558SXNEcFB5KGrT?=
 =?us-ascii?Q?rZtCJd90YvBVfDQjL+fqeP8+xq31WJphWewPPvk1+8ALd8RMNPf0hQJKUeRa?=
 =?us-ascii?Q?g+I2FO8T5ZulWUHZP39b8UoAwgZ+Lpxo16Em9+pusb98G/L0GI35KCKoeg9I?=
 =?us-ascii?Q?ciTsgYnLU4E17RueycJmrMOEshPUh4ufWn59fNj/vNWnOGe/QDQDQJZ0f8x3?=
 =?us-ascii?Q?u2yraQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fce442-d379-4596-0544-08dc74079a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 11:18:38.5298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNHM9hRa8iLZG2qup5gvVBSAeUz5Yhytu+ks2k3FvYJn5p4Mb8ZlmTX2kx40cNh2gmelByVv7cb1C0Rhc0peJcN01nuRYttR1x+UdL/3Ig4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1280
Received-SPF: pass client-ip=2406:e500:4440:2::719;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
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
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 13, 2024 2:31 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; im=
ammedo@redhat.com; anisinha@redhat.com;
> peter.maydell@linaro.org; shannon.zhaosl@gmail.com; sunilvl@ventanamicro.=
com; palmer@dabbelt.com; alistair.francis@wdc.com;
> bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com; z=
hiwei_liu@linux.alibaba.com
> Subject: Re: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support S=
PCR table version 4 format
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
>=20
> What does this achieve? We don't normally change unless it gets
> us some useful feature.
The changes in Table 4 primarily include the addition of RISC-V support
and modifications to the Interrupt Type field. Additionally, new fields
added are Precise Baud Rate, NamespaceStringLength, NamespaceStringOffset,
and NamespaceString[].
>=20
>=20
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


