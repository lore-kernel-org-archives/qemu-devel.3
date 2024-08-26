Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79716C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 07:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siU17-0004aA-RB; Mon, 26 Aug 2024 03:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1siU14-0004Vn-UZ; Mon, 26 Aug 2024 03:19:54 -0400
Received: from mail-sh0chn02on20703.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::703]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1siU10-0005WX-Sh; Mon, 26 Aug 2024 03:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHLYwJPr7N3o9LPuW/G25TOKHijf2jBD6I4ONU+Bsv+gqkzz5i1H3BBLdlGyGVL3F/sUkd1ZTDVOGB+1fFNLiadpBhKTVomFujHIck7Ju+aSUPe4MoWU6FiqGZO3zGGNj+OMcZswLqGrtUeZ0H62MsJThQ+mMR+GeJmJ013j26vkOTgmToqZdULgk7q7ynrbRzzq0KLxyFD0OygvZlsCWXGhkyFIUB8K4ZUCzNscqoKJxYYKhFNppeywCV3WminYsMBzpn5cAVznK4To7f9k1PEx5/j5X4XIbdp+UyRpa+PNVNw26cR2I/J19ZWgromDETwlzK7w4wdcCwmAR/tB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf9eADy4NdR2zYq61AJuS32BOiO6yEBenndQ8hae4f0=;
 b=DvFflj36q4VFSnv9OmlbjkfZe1FLJBimFZpQHJ9lOfWRYuG5shWAisydix7s3baHr1QUgodzbaTtNROJvXzn8fVZwkoofAetPYtfUbvdlBxkHC/9s22jWlnTPlf6qZ1mLQtpH1JdtEuFSJsXRDcE40b4hljbMsNgeBatoD3hWnUTJZSAVwSzStII5T47duA75SaryZ6X4ec/wiDSLhI3zX71bcivaGf75GvJaRMplXaMpKEIracINdWDUZFdbblU2zckIEVlvV5YF/Z1l5QHzNRAK2p+YDwL2+ztRAqgXCVE8LJDEpxeSr49oTTGGMU6uduIyfRjQ26ygcoSP6fRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0990.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Mon, 26 Aug
 2024 07:19:31 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.021; Mon, 26 Aug 2024 07:19:31 +0000
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
Subject: RE: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support SPCR
 table revision 4 format
Thread-Topic: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support SPCR
 table revision 4 format
Thread-Index: AQHa9VATullMknu1c0mBI+U6CpILCLI05waAgAQ50qCAAAOFAIAAAU2g
Date: Mon, 26 Aug 2024 07:19:31 +0000
Message-ID: <NT0PR01MB12783CEA8A87CE93C5A211919C8B2@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
 <ZsicubCBw2YAjq9c@sunil-laptop>
 <NT0PR01MB1278D6E5A7CD617D9783C7259C8B2@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
 <ZswrLDbIFpPpZDAW@sunil-laptop>
In-Reply-To: <ZswrLDbIFpPpZDAW@sunil-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB0990:EE_
x-ms-office365-filtering-correlation-id: 0bb7dfca-64bd-4418-b2a6-08dcc59f6ded
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|41320700013|38070700018; 
x-microsoft-antispam-message-info: tqyi5PLFjEIChuX0OqprkpQycaWedmVByjyP8ia5Lbbo7uUXKD2nTS5ioJhXpn8Z5ubH7R8iiV3gdvuuvcdsGWspM7f+oM+vUDAZ1y+QG60Rb1WbBPb2L3AHuuBjt9goE76vKAC8t34TKv8Vp6t4AfIQKR/5dpqhEJNrgFJTRqHxo/T3q1iDuMAMz33OPHrTj2j8wOon683OgTJdPgRYc/PmenifjYhNHmuyDaDwJgfdWRz10haOChFrbtiT4PiPdaT5mW9fT0cLlVrdJE3B2pwFEre2bH5At9lBRXQDR8M0i847ru3xzCZBp8GOSJ11Tuyztd10gYP4ZsRTASrhIhS9mk04UxH3MuIbbm2VJutqWPb8lCNi+RiNUzn+uYIecUc+Z3VQV2buY351oPPrVLCZwq9vmlsW+yGr8o8sDaefbA5MDgZctNeELxBVZ5lDlhTE+X8OYDDXWSc7AFz8YJ//WuZNsYWZxqQHB6zVcZ86wUbqofkcxMdvN0Y9t8FA8K5OZI21eCqVTjw4gQResPxRWFrZAtssExJP7rbeUSUl3byaKv2Tdqs2Ddl/k8lziCHaAtnbU9/aIXm9f5QTWCIwcALwM71VXGHCY2NbEeAcf3U5C37fJ8Ut8Y3X/43G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(41320700013)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4osLL+DkHdIs8+ep+NIPJyqSctsbNsV7Dwlq4ZRbzTyEGx+iIl4Bwxo+XZX6?=
 =?us-ascii?Q?zwA7/JzQWDvx3wB3TqXlrOh8CJXAOFU2fzFnUDHb8AnqbvIaFqs9FuXiz/7F?=
 =?us-ascii?Q?GamlSmbI0KNEgg5kJzJ8ja9gQR1FaoKmP1t+bk3VzFK3akYp0vKtsAzI4abo?=
 =?us-ascii?Q?X1rem+tuokdk8nxraQYa0LJ0ZHaObuBhYq2mLNXVL+kkyf1Io1VUAbgnmvL7?=
 =?us-ascii?Q?yV0TWqO7dABcOnTdeD6TvXLPbUPa0H4RqxrGJaqCHoslbvaCBeFMcYdc6PRK?=
 =?us-ascii?Q?2ZC7jZhVVnR8rbwgxvaFCzIz8yL0hZK1mg6OCoupcUCq3dSsXrwNHisTwHDJ?=
 =?us-ascii?Q?9zaL2n1Ey5Pfl/utXL2z3zC+eHxMvvUS1Q8lmvqmgbnVhatVkbkabqHt7Kw2?=
 =?us-ascii?Q?qHaqBDrWT9l8t4RaPDpNRnhyaCwX8xOMoZ12lexp8RJH3Ks8yvUoNAzRAKvO?=
 =?us-ascii?Q?AVpEmR/NSs6KFcdRGxCYRjX7r4sgfRFDhKt/Y123Ok4r49KxP5FrmsHV6rv7?=
 =?us-ascii?Q?lKFyOKms2L+hwRpwXI1Ol+K8/mriRfKLPJbtdWPKtp8cRCNYzWeeCyc90HVq?=
 =?us-ascii?Q?921ZDUtRRC+ibfQdQlGFSmfc3qzUkgWI+KPkUWXSvJNF4i0Xc5Vowa3TJyoS?=
 =?us-ascii?Q?tr+K/re2WIuvQRsUm9ZGKZmxXngzyAwbqpfBHz3xFR74g2AxVyaMUt7NuykC?=
 =?us-ascii?Q?vpJjeiEUYWUsNWRlCXORF80tB/Hwkd8NHaIKZ40HLi9QQg6G4Ob4JYtafSi9?=
 =?us-ascii?Q?cVETxmpuL3G5MPRR6HWNly+VN9M7aA9xieA8psbB3KBXT6kbRm+3XqyvSm6o?=
 =?us-ascii?Q?XjxeMLVkvEPEo3fg7MwH8RrAk7aZQO5xkgMeYTATtR4nhtjSwuYZD6AUjlJD?=
 =?us-ascii?Q?A0Un96Y8NuG6SLxTG1l+XFtVagaTCbFzZS+zKuB1FLs00+bGBD4S0T1Z5ThX?=
 =?us-ascii?Q?w7aa91fhhLaNugeCtra/keM2/G3EnrZEmVNV/xUqIVJivf6Zi+nYD2q9ziq1?=
 =?us-ascii?Q?i8zL6qRp2WLgY1SNT9mxYw7FmglmC87jMFodiXokAVTQOy6/6qermW4zT4BU?=
 =?us-ascii?Q?jcOFtVvDUDfCQVVLi0thMcYcClCTNywW9ZjAt/25+McTrnyVJ9rlWNcJRXDL?=
 =?us-ascii?Q?v+AAgVTXhoEoqnTEUn0E6ji0TqjUz9S3nUXYf1qjyrqsmfZWxsHzAgIlftmD?=
 =?us-ascii?Q?c6weJJroR+Zo5DW26g7xebkW3saZ73uir5NUibx/3snZ/dtMlYvzX+XP1/vd?=
 =?us-ascii?Q?gs0ElFnAcklJjPBAZ0wyqTaoJxrVb06CowVuEO28zZzIqvPnSxaLg0NUe0eP?=
 =?us-ascii?Q?SdYpgObUUnexb5YPG+LCW2x6qE5gBHJ8fZkDDKJGBj+W/3ku2lIpBSDWHtWF?=
 =?us-ascii?Q?PvCMs095eUlROQh52mEOJEKN3x0m/E4ClMIct1aQrSJsKsXmKYCWF1bIZfWi?=
 =?us-ascii?Q?zzdko+nO7Zo4e5+hr/CeJ9ShzD4a+5Sqag8auOw2vEW1ysp9jPofcIOP8DN0?=
 =?us-ascii?Q?SK+iJvgWNMMMXz5gDXn8dMTWX+v0bMyxPaqsktzrW8GekV/6z2oFhmtGQtk3?=
 =?us-ascii?Q?PPnHcNjA8L45J0DPJEJJeo2OtKh6Ga8rUwy1jKCezq+nQ2DU76YE3pw6jB+r?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb7dfca-64bd-4418-b2a6-08dcc59f6ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:19:31.4341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ku6Ay2H2+Bolo8j/H42FjMlf7EnpPrcNyia8Dwuq4cM5VMLQNsQnvrXJF6PzR8i+5Ulsy0hCNwLEHjyTgBa6RfqkQUOyOnaAJl+7H6y2h58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0990
Received-SPF: pass client-ip=2406:e500:4420:2::703;
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
> From: Sunil V L <sunilvl@ventanamicro.com>
> Sent: Monday, August 26, 2024 3:14 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com; =
palmer@dabbelt.com; alistair.francis@wdc.com;
> bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com; z=
hiwei_liu@linux.alibaba.com
> Subject: Re: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support SPC=
R table revision 4 format
>=20
> Hi Jee Heng,
>=20
> On Mon, Aug 26, 2024 at 07:04:11AM +0000, JeeHeng Sia wrote:
> >
> >
> > > -----Original Message-----
> > > From: Sunil V L <sunilvl@ventanamicro.com>
> > > Sent: Friday, August 23, 2024 10:29 PM
> > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org=
; mst@redhat.com; imammedo@redhat.com;
> > > anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.c=
om; palmer@dabbelt.com; alistair.francis@wdc.com;
> > > bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.co=
m; zhiwei_liu@linux.alibaba.com
> > > Subject: Re: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support=
 SPCR table revision 4 format
> > >
> > > Hi Jee Heng,
> > > On Fri, Aug 23, 2024 at 04:31:39AM -0700, Sia Jee Heng wrote:
> > > > Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> > > > The SPCR table has been modified to adhere to the revision 4 format=
 [2].
> > > >
> > > > Meanwhile, the virt SPCR golden reference file for RISC-V have been=
 updated to
> > > > accommodate the SPCR Table revision 4.
> > > >
> > > > [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ser=
ports/serial-port-console-redirection-table
> > > > [2]: https://github.com/acpica/acpica/pull/931
> > > >
> > > Just curious - whether this needs changes in linux side as well? Does
> > > current linux code work fine with version 4 of SPCR table on RISC-V?
> > The current Linux ACPI Table has not yet been updated to support SPCR v=
4.
> > However, Linux RISC-V will be able to use the information in the QEMU's
> > SPCR table to boot with behaviour similar to ARM.
> > >
> So, it means even if qemu risc-v SPCR is upgraded to version 4,
> current linux continues to work. It may be just able to decode SPCR v2
> fields only until enhanced to understand v4 but but doesn't break
> anything or crash. Is that correct?
Yes, correct.
>=20
> Just wanted to confirm qemu changes can get merged without any
> dependency.
>=20
> Thanks!
> Sunil


