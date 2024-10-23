Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94114D2E016
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 06:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3UPL-00060j-Mx; Wed, 23 Oct 2024 01:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t3UPI-000603-BU; Wed, 23 Oct 2024 01:59:44 -0400
Received: from mail-sh0chn02on2070d.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::70d]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t3UPE-0005gP-RI; Wed, 23 Oct 2024 01:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaaoYZoUBK7WGFlE7TCJ1HkB7qaKe3qWtlyTfqtHADtg6YpHrkOZGM8myqVXK3G1s4mJXbl1bxaIwvhN9tLiKMlNhFJXDseLC2beCB7dA3bVUX59TqEfyXs4uSMOp/rD4wgvr0AHDwpbXhexwBVSyBCXD9+pFnjBAB5wtEFFsOg6UZhhdMzeiff9Y8PqnFDDevSnd8rw6q2s9+WBv+axPHFGBFV6d5Un7dXcHEVTkOHBABDRZ75rpH0VmSxvz9rSoWE/MutYYqT6sJZb48k+jCjdXZbMY/jNW3P9RS3r70+XCaH9hRjJ7m9dod5Y7vwD6f4sJEgl4eh0mhgDtvxdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QMa5cHrDuZ+TER/mNwgao+Q5Xfcwug1Cr51qU/FMvU=;
 b=jgdr8D9xhzJFI5kZMP5FVqJo87HCXg4aNKe7jRGFyPHVFC2QdAHDu62HeiVYXB7zzuStsAgCqrspaI9wZ0707xcWrfE2d9bHdSoPuRevaljlgubjcIlJpuGaxJtq4EzP5iadfKKBiJL5LiDc++HPc5meyNffBkaWS0sBYzE48IRhoNA4Va+EPOpCx6KGV9Z9dYVKf+/yFaFliH1PfLpqd2sMN5At7zp+mZTVhHQrYEENBl+W9SvQHhoBWNGpNCmus+fyzSrUhNGWsRpQsIGCa6IGb9pwcN9p6KW9G3zIB4lhMqA78+eCAz31wg5ekNT23Nm9WF9YHCVuPIpk6xDfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Wed, 23 Oct
 2024 05:59:33 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%6])
 with mapi id 15.20.8069.027; Wed, 23 Oct 2024 05:59:33 +0000
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
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v5 0/3] Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Thread-Index: AQHa+bcVlvBbjnDuK0qmkfSNTtMG1bKULR7A
Date: Wed, 23 Oct 2024 05:59:33 +0000
Message-ID: <NT0PR01MB12789AEDB0B8B5E32E4A7EA79C4D2@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB1023:EE_
x-ms-office365-filtering-correlation-id: 1a325a45-d2aa-4b50-6cc2-08dcf327de01
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|41320700013|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: bBur/rH61TXDoJQmebywBhxjDwzM+PDP22SFbH+C8vDWSq9hsAcOBS96/okFWcjtGUGdEbudkv+iftpE0bb9OaPfJhHzRkwTPNvqZHWODhOtH4AJcPcdMpBSJPtz6rTvaglPA4JZE3t2gsUdLitzjSWagMxg+mDvllPZsShO2MJxKF1C2SaLv5Fx9+MiOVMezG0m8CxB9QY646BEarRmVEtzOpd1A2Bk5F3Ap/ePC8ENe0ixO+rWjufvlBQH6DJrDRAj9p9erYSF87XzY0wk1qI3YOMKB1DPCQ7i5+rcK7HjHBXYs15yXEe/uqXG7wYNCw1aq2eQww8LTzmVfrJKzjmpdTlzDgLXO36oSBup/UASjMsYK7Y07e6QIMu3JvYiWC6KIQNct1+kA2zxZwLH5mcaLsrgsJX9/wcJjbtWpUzu1SA9WCjvVMaUcIM4ln+NPju2OKdeelG9gNGE60ksK7X+M9rdG1DO+5gmFQN+CFu92YCCC92QjyOt/rEvxyR57JwqMFidmPhLa0MDZv2Yna5/va6E4BuWjEMAuhP93dee4+qhJE8r7pKpPdQE0l4su2SqTXqDeialKr2X3BlTORJpCN40+5CJNq5wepW4BayEYUmMZzeMnF0oV7HEjbVI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?asssEYPWO+Mwo8733nUAt6ndGfUztflf2ApIyzzumO1GNfQXWiJ9HK1EpXdh?=
 =?us-ascii?Q?3iPZTpnfbe6vmE5MRhM+HFYRW4fAivdEQ+PaVBIynGH2TTqiJNvskQ//y6rd?=
 =?us-ascii?Q?nkj6R/ymyB59kjiU4+6uCeLq7ezWDiDgZl/HhT9uWYNTHwleyRKUXTE+kbv5?=
 =?us-ascii?Q?4PvNk+aGvScQfsGmB3XIWl9xS6DPUlOAvlyTWUVRkuqDxsRvaxaYm8SG4eFk?=
 =?us-ascii?Q?8YOsUKWH+SSR54mOabq+ZP4SCbwMUtjNJr/HCvSRtRB92vx4Hs6/hoGlAvG0?=
 =?us-ascii?Q?it0a/bdj2M+XpvI1fJL2L5l3U3qwskQs2drHSa/MpTB2aPrK6E/sRql1LCP1?=
 =?us-ascii?Q?cwGYXdA0QXxJgCzx8sJVX5+hfpkGNj69oWgqrVGOmJefAIwAd2Zdnq/zyr49?=
 =?us-ascii?Q?0OGejMKstnRRipi+hB3/yMlQ7ofx+t9gziQrfMq2x1MPyiXlv8u34rg4ka2F?=
 =?us-ascii?Q?LJP8lPAwh7raqaFgRInH5QyiKsanY7EzSN1nFeSw4IbwJTSpl830oqGAIqtX?=
 =?us-ascii?Q?/gadqWqs1h6FU6u4wr2E4p15g2NYyANBfwMiyutgdo+sFiuxY0TVI65fr8uz?=
 =?us-ascii?Q?S7md2JKpQTwrhy5rDLeoH6DPBxsIBacgmtq/OLtA/QClwOECyggisHAOK97K?=
 =?us-ascii?Q?Yb5v1plfNwICzm4DBn/V5RzJlcqCXlkihX8dKwl5cGhsHOHnoMYINhjQDFw/?=
 =?us-ascii?Q?ozQxmQ4FN3rydemDQmRtmUZZofsSCw+AHuyOjHFv35BRC8nS5qGncN/vGknE?=
 =?us-ascii?Q?yEhzD8ijQnL/SVmg2OM0cuLWqPfi1xifCLbilq0yLdLEgovXctkV2GIduQ+K?=
 =?us-ascii?Q?paRdcHwhiG5EXkmK9+uGslFemG2c7BbWySfzvRXz7+E2bcf2SmLOGIfOjlE0?=
 =?us-ascii?Q?Mvij2+ZLg2KMX++jmLyx71oDT12qtuKBJek3epvFz1CmwAH1ww8DDe3BkWh8?=
 =?us-ascii?Q?2okd2NjfnSbVf2AkX4F4aa5XciJjlj4MZWcSzDLjZDy5tofsuumgd8BAl9UG?=
 =?us-ascii?Q?oT2fQuK3fi0CrH/Zf7HbapqvQ1AXFprJMvJTz6lvsjT/dvTvYja6ZOaMFEzw?=
 =?us-ascii?Q?3SI80Uv+behwBA4jTbBNENotDfCf6HNKMfcx/XOIszSbYmofkueN/2J6C/At?=
 =?us-ascii?Q?0XMihsHu2yMyoXLWKl5+M0v/Hs+twZeYDhAzK+CjBMpsC/tv2p8Ix8Y55dHS?=
 =?us-ascii?Q?ECV9tZyLRB8ZYxo4bvMev0fwf4lAJDbv7lFgWL29whVVU3BGU2MUDBqVagLm?=
 =?us-ascii?Q?MtBNLeJ5fWXuz/PRUOYox7vwYQ/erzk/IcjNtG3/4LTBtd86V+ilWGNyzCsf?=
 =?us-ascii?Q?+Di3SBgSFCNezjawrv+4r4bkvhlmyJtRdRI3QW0/ETxrf9X7dXCr5z49w9JW?=
 =?us-ascii?Q?KbjFude6q3yQAWSNxGsC2oLVbpCTEEkZKI6wII1nPeL5RZ+el9CkLUD/uwk5?=
 =?us-ascii?Q?djb36+pny3MeAdXB4ChjLy6jpBxL70YwrmasJwK777wqUU4yaqvBFTodwVI4?=
 =?us-ascii?Q?UBTSWNe8nep/PdnWaPbI87OYFsVjwWqtdgl7GgEETZYT+HGfv81rBOwGA2hx?=
 =?us-ascii?Q?7FPgCvLUDJQQoryO1VyUZXeXSEq/M94rYzIi8D5duqqV99c/lK1dPUEbpELt?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a325a45-d2aa-4b50-6cc2-08dcf327de01
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 05:59:33.3481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFEbmU5VmOHu2wBXDKHzDVLh9a9RNXmpUWDuiRGc/a763/VWlne1TIyWzSerUV1tWsEt61VLSR289f5+4h8fivk8K7J3sR5E+lda7x4/AU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1023
Received-SPF: pass client-ip=2406:e500:4420:2::70d;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URI_TRY_3LD=1.997 autolearn=no autolearn_force=no
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
> Sent: Thursday, 29 August, 2024 9:59 AM
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> Cc: mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com; peter.mayde=
ll@linaro.org; JeeHeng Sia
> <jeeheng.sia@starfivetech.com>; shannon.zhaosl@gmail.com; sunilvl@ventana=
micro.com; palmer@dabbelt.com;
> alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com; db=
arboza@ventanamicro.com;
> zhiwei_liu@linux.alibaba.com
> Subject: [PATCH v5 0/3] Upgrade ACPI SPCR table to support SPCR table rev=
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
>  hw/riscv/virt-acpi-build.c        |  12 +++++++++---
>  include/hw/acpi/acpi-defs.h       |   7 +++++--
>  include/hw/acpi/aml-build.h       |   2 +-
>  tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
>  6 files changed, 37 insertions(+), 12 deletions(-)
>=20
>=20
> base-commit: cec99171931ea79215c79661d33423ac84e63b6e
> --
> 2.34.1
Hi, are there any more comments? This patch has been open for more than 6 w=
eeks and has not been merged yet.

