Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B39DD49793
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 01:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHvGx-00008p-T9; Sun, 01 Dec 2024 20:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1tHvGl-00007S-Dt; Sun, 01 Dec 2024 20:30:35 -0500
Received: from mail-sh0chn02on20728.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::728]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1tHvGf-0002mq-Md; Sun, 01 Dec 2024 20:30:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0Q6IQqIODLkA/fbH2n5Bay9EWCBlYWg+glxqaQXIyUg0Ab1A8rxvstAKoRlpb01yg4wRKKVUN3TnxNlZp95hTq/RTIbCYmv2T9JdBeCsV07IECGVDVyvrRL+SHhCEvCuR+CCcENxktGV3Rdj/yzlP776Jf3i3RPjRph01OryPCafY8lfCPgYk5dTOScymRuDHmUsr6Yk+EJhkRANWbXkcMc73dNY2H9zAja0U92OSFe6oqg0RXOJvtFvitbw9N5/SaXexHMhFpy08QoFu4pN2lZwXObVuQkISIqWzI1Xq74P0SdDzNhZIvGBDXe6MWRiD2bEk33GWVafARFaUQNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTEpCS4YrSxoAxMEPK/LcHBg/Aa71JEBf6w40V8yd8A=;
 b=Si0tnvOLiXM77S513v4MD7wYPf38muWp0mfU8lyJisecz4GwgdRAKN7qW+utfYZEbrMY6EJtnSRWDUjpyR4C9+oCYp8D8soBY/0hySWebnHvYHylefNzhNEPJ4R7tkooGu5UQ6ztgv9K5MO80r/MNCCj4R5djuwVMOldXI2oDkV/i46+ltEbKejMoz0B+Lb6E3pHrxb/c/5aaJ3ZdWMs8RksPbOIHojvf38WNAKu0F7u2O5lmUZleIc/RVzP3tgNVLdS2j8YUokWXoPgtYd7/2RMMlPV1bshygj9Fi6rt5fHpPDzgj0/9QOTBwn7x0le1Tbd1VQ1i0imZ4FoYcS98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1133.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Mon, 2 Dec
 2024 01:30:33 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%6])
 with mapi id 15.20.8207.010; Mon, 2 Dec 2024 01:30:33 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "gaosong@loongson.cn" <gaosong@loongson.cn>,
 "jiaxun.yang@flygoat.com" <jiaxun.yang@flygoat.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>
Subject: RE: [PATCH v6 0/3] Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Thread-Topic: [PATCH v6 0/3] Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Thread-Index: AQHbKNzUOkVQiFLvLkuI8r9ZO8B5sLLSYY1w
Date: Mon, 2 Dec 2024 01:30:33 +0000
Message-ID: <NT0PR01MB1278358D85002212C3FE0A539C35A@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
References: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB1133:EE_
x-ms-office365-filtering-correlation-id: c6f1ad79-4f4a-45d5-1307-08dd1270eaaa
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|38070700018|7053199007; 
x-microsoft-antispam-message-info: MWpuf3IhRgh5+j1y4VQsFiHnAxWUozXedvAys73DfEPYmzX+86yCWs63JrWlSat2dzPYVbnRJ72nmjRooFpMyL1+INUex/UOh+d1cDgZjYWnr+P586+2g1dNXtWE3yXRCUGKebrS4wfRyjnzZqF5LuCwQt0CyYqY6FErYln2EYSyfxyyVX8uHVTopm8/2RyfSY/QWwmMqFENuAxwcLDbKy3exre01gjY7140sJED1mSBfoJjaMh/JM1pUew4uf04vRdPcbZiaM/6KJ8LRZycuxMQvScdGG6WYedqSmrVsS5tFSdM4llKLYfm5PoZfFaZtjBHKwgZvgB2FtZVTN9qf/1ybBF4IFwxZw0wC3EwUqMQcEmw1VIHg1VmA74Y/eJZuZiStOTMQCEqDuDxUg5FGFml53HG6tBc7gzX2dVua2G2/f6L4/Q5MAKZaDCkrX16SZbtkyr0MObptKJjyL0uXEjv9fpiMv4xBFQdcltR6fNXtOH23mKkcgqbSN7DZ0AZap/gqgysxDX/1wjPOYbjuldGZ603Ridg0iocNQWxSmDeA5fO85TyQZtwUVwyT0PPAjPBEv9lFgB+hV8s567G+/dLqS9Z6dYImbM2Mnv+qUfiofvwPyHXCo29OAOtgqP3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSNSxhKYUAtPmCAjtlVNnoKAS/aKWWsJpxxFg13M/A6r0Azdx5q1xD/vE4RO?=
 =?us-ascii?Q?oXl5UUgRAoFvkbwoCWbYuWVsmMeP3qEcstaaI1fQsxWYKkRwjy+iTBFWK04P?=
 =?us-ascii?Q?yaqP49cfco8P5pU4vl2jybpEdPd/puWIjMLyqav5o1Z732PVXMmWK9i29c5j?=
 =?us-ascii?Q?QwiW27kMIyKtniDk+tu2D/pLsDV7GLYuZAxQCOrjGBhUbZqzX/Ll6DntKIwI?=
 =?us-ascii?Q?vaiLQYST+jHh/GLbj/W0+g/aMRAl92IKchQjLQFAfNu6bADnINpGniByaPuF?=
 =?us-ascii?Q?twrGb1rcTDsUZw1NrdqtEWr6B+aNyBSyaF7w/XvtZreCjwM6CTLJxmkKcPev?=
 =?us-ascii?Q?ltY6f3ruhWlRrA0j01q11hj2Y1k7XZUN+4A5qbx4gwz05rxOjgkAmfYLl5od?=
 =?us-ascii?Q?Oeuvn6GypoRImDmcCVB+Rq7lbyoFgk1no9MMshYRE0HNnd+7nSQy5Hnpd5S5?=
 =?us-ascii?Q?G03+d7Dwyw4uOEQi/oDZ8ScMD/kagNPQ7fJ1hTuWlI5rgIh6oWXGQniPvICn?=
 =?us-ascii?Q?OxoWSadfx0/VZtoomGQftIEMBwKTsvA+aP6WOcPHOEmyZh3Bq2uRUDzCsLzX?=
 =?us-ascii?Q?1wivBAA9IZ8u9DgtsGte/xAxMZ5yTPDLBj9wxJujvYKl+FqcHFgJTbn2H0M1?=
 =?us-ascii?Q?U/eqVPLZS4VLLrHVTMpbIQ8fzL/32UdjaIPxjnl/NMelCfcung4/pSXy9BK4?=
 =?us-ascii?Q?7ZCW8K53GpSScLXPcY8duRq9KthftNtwhUlzHnb9AoOTXrvAGB3byP+gGPS/?=
 =?us-ascii?Q?+LPJ/0p/Yv9UEsGHgsl5JhUCw/S7xxN0yg3aypOzxWMRX41RdibuWhcqIoPg?=
 =?us-ascii?Q?XNU7DmvXUSFcu1QvX3PR877rCcku39wL2aqdjEYJ4rZX43OeXgwE/MzCeD15?=
 =?us-ascii?Q?MSAb8aAFKcbjLgvLjtcdWigACEskn5nYIF1vrAc9MZvMdLiimbtzQefXtr19?=
 =?us-ascii?Q?kAOHVr2c+fmZPXuosqfTMJ0uS/E5PwVOu+rF4ahIWl/bAQq9iJWMJcN7nLWi?=
 =?us-ascii?Q?v6dWuGv0EBymIeiM1uI4sK1aDcSl5BBxrIoyy0nyOMrX812kqgsbqFvoj9sL?=
 =?us-ascii?Q?AHonIlkIJvWTP0PVrD2Q1/HmITfTeDciTXhkQIR7mInpcJOaQ6HqZoacpTsI?=
 =?us-ascii?Q?nGr4iv+Fv2tJl69fkl9tiUhchk+n1PY/gcUJ9agIpJipZh5Oy5bT0X3Oa6S8?=
 =?us-ascii?Q?Oy8R8yb2Ax78a1IcsEHeag2idpgZN09UcVwUVlvyWIdP+vJpiKk3+HjbgSob?=
 =?us-ascii?Q?/GSjn5aTAb7z8NOAF8GSf8lcbAqQpiUlY8opXU+v3jvzqYPu8elfNMTRR1dR?=
 =?us-ascii?Q?PapJUOS1cxw+gvhNEYJUO/Nb+IQSfuT382ckBBHmvNd8COHCReRCBsW/R4yn?=
 =?us-ascii?Q?KlVU8X8rDPtISBPk/gihu0FLCP+sHcJ017EZkLoGZtH2HrUoHU0Nw3tIiRQG?=
 =?us-ascii?Q?NJfHckTczS4vm7uWGj+/h2MPluTCSREyoicLfiCgdsFYbw6vrJQCcPcskkYQ?=
 =?us-ascii?Q?GQhCcTuIvrs5/h2DMgBwYeu2mw/Re4hNB59zdzRZlz3JfCh9BzLzdLfOgHBL?=
 =?us-ascii?Q?fCLwp8e0Az0SfI0vW71VIfxwkeUa7guCaJ2JTcL+HFqTvqxkykTPom0ByfBd?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f1ad79-4f4a-45d5-1307-08dd1270eaaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 01:30:33.8535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ud5GkHogrXZzJyxgaCZkhtNG84rvQVdrWVR5qnhgOZ9kcbDAuo3xrkwwqOdzNgwCFC6b+3aNvvUC8iCWnx3+LnyVRUA102i8PjQxqvCEgVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1133
Received-SPF: pass client-ip=2406:e500:4420:2::728;
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
> From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Sent: Monday, 28 October, 2024 9:58 AM
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> Cc: mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com; peter.mayde=
ll@linaro.org; JeeHeng Sia
> <jeeheng.sia@starfivetech.com>; shannon.zhaosl@gmail.com; sunilvl@ventana=
micro.com; palmer@dabbelt.com;
> alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com; db=
arboza@ventanamicro.com;
> zhiwei_liu@linux.alibaba.com; gaosong@loongson.cn; jiaxun.yang@flygoat.co=
m; maobibo@loongson.cn
> Subject: [PATCH v6 0/3] Upgrade ACPI SPCR table to support SPCR table rev=
ision 4 format
>=20
> Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> The SPCR table has been modified to adhere to the revision 4 format [2].
>=20
> Meanwhile, the virt SPCR golden reference file for RISC-V have been updat=
ed to
> accommodate the SPCR Table revision 4.
>=20
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/=
serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
>=20
> Changes in v6:
> - Added Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> - Rebase and update the build_spcr() function for the LoongArch virt mach=
ine.
>=20
> Changes in v5:
> - Reverted the SPCR table revision history for the ARM architecture.
> - Corrected the output of the SPCR Table diff.
>=20
> Changes in v4:
> - Remove the SPCR table revision 4 update for the ARM architecture.
>=20
> Changes in v3:
> - Rebased on the latest QEMU.
> - Added Acked-by: Alistair Francis <alistair.francis@wdc.com>
>=20
> Changes in v2:
> - Utilizes a three-patch approach to modify the ACPI pre-built binary
>   files required by the Bios-Table-Test.
> - Rebases and incorporates changes to support both ARM and RISC-V ACPI
>   pre-built binary files.
>=20
> Sia Jee Heng (3):
>   qtest: allow SPCR acpi table changes
>   hw/acpi: Upgrade ACPI SPCR table to support SPCR table revision 4
>     format
>   tests/qtest/bios-tables-test: Update virt SPCR golden reference for
>     RISC-V
>=20
>  hw/acpi/aml-build.c               |  20 ++++++++++++++++----
>  hw/arm/virt-acpi-build.c          |   8 ++++++--
>  hw/loongarch/acpi-build.c         |   6 +++++-
>  hw/riscv/virt-acpi-build.c        |  12 +++++++++---
>  include/hw/acpi/acpi-defs.h       |   7 +++++--
>  include/hw/acpi/aml-build.h       |   2 +-
>  tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
>  7 files changed, 42 insertions(+), 13 deletions(-)
>=20
Hi Alistair,

These patches were submitted last month, and there are no further review co=
mments from others.
May I know if there are any concerns about merging the patch series?
>=20
> base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
> --
> 2.43.0


