Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA968CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91Ek-0003T8-NC; Wed, 15 Oct 2025 09:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91Eh-0003SE-IV; Wed, 15 Oct 2025 09:08:11 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EX-0000mj-AP; Wed, 15 Oct 2025 09:08:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ti1/n6c2fhSITp06n2BwagEpfOiAP7AqwBXNzw9w/VX0zFQNBcuk9gg+v3jDccNT0Wa8yED3PO3tfhOD2kT/y8RUPIoC9vEjOJ51cWXqF2jwwOlZE+970ZF0iU/rllbahKinjw25s2jZMgAkv5rv+TqJOzzxjDf58nFgk/dkYWlPNYpI/L37fUDII/3Eo/AV4x2fC1z5+sJ1TucBIbXNLE5qV5r0XMmj39ka9u+NY22MyQP2pzR5pUizGScn42EmvTs6XXd6iGIoYzqoz64dtWF4JfkpBfjtmz3OBGIyntVlGRxvx1UJEQDry/bFnFHiJ7dqrpORARIpX7gH6J4M4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=apOURiWF7M9As0Kd7svT6GATDiHf94KJXBlCKxhorhUVHNQUj70HMTlHZizUQgzH+m1D5qK6wBXEYHyajx190icolzgpLADnk47//zp/IZh2st3inZEqWXC6N9EYwPxz4chl7fH9WqbXz317JH46Jw6eQGIJp78d5VA7VUTRcRNSpl+sCZ112oVdcmo7p4K8ggUnWfydCLnNc8wUQDraqsjMunl/+aNe5EKd0rcFyu0J2ku1HI12nIcGQBaOLtk0kYkmcVT8Iod33CMDTIJ8WdyOPnl2EZx/V1e9pntUoGigpvAV6HsOcviC9VTPEPrKMfMJ5I67A9qKdD8Bz+Febg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=LZTPmTd/PFNxzQ1hKdR6aB/YgMdrAOQTXh4Og/+VFe8J1La/PL3HFKZDpubrxwQO27Q0QRxtAOTmxXRUB3ULPAIeDMrip5OyjSfldfI9h78S3ZBC6YdTVh2ytn3XQKTUAluLsz2ZMhOf2AnTvXrXE1gqhp1keYBNkZoPyf7hE6PsofMwLcgwqEUBADGsDym7iEdLFf7m7Fc/1fBdylO/b/aXHNQhJQeiUeaA9WVQeNFVJkdS6tNgNGalY1CDEnv0FJ0x8gXD4VMUcyzX7Sgg3Cg1OItjBvgWh7k7SVu3gcH4b7CpqlQbE2A0p3x6kYuVoeE2fNJ6wUgfGQqpm2WXuw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:08 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v12 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v12 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcPdSc6Rl15BBJekGQh29qdPj8NA==
Date: Wed, 15 Oct 2025 13:07:07 +0000
Message-ID: <20251015130657.571756-13-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 7b0bcf14-5e37-4980-a04a-08de0bebbee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+eNMK41XqejfFLIjJyRKonfpDLsRFtXGjp82NBvaiFC1hY7+z03mlDIkd3?=
 =?iso-8859-1?Q?qOveLXeawuQaF9IbU/ZZeCiNJf5IF0hbMWX3q2ejFi+NZnaeZR5PHpsWYs?=
 =?iso-8859-1?Q?eJKrm6ybJkGYkCMZLmAj7SmNHJ9/lhm+58POp2kI1Mln8uc9Qd2inPjG7U?=
 =?iso-8859-1?Q?cQ1tkchtNi0OmqR/O1bL/zrPaN1Opjj/GEnrLe3ed9B+QSvyiIM6oEdvxp?=
 =?iso-8859-1?Q?orO56Gjut5CsdhT6/f21cvffNy3o+J8RbPRcEX0358NiRFxj0IW7l/h2c6?=
 =?iso-8859-1?Q?0viF3LX0BtiF732HE4L0w+xBdGEp2oHg1kuv0b8FqHOmxm7D076x5LMIpR?=
 =?iso-8859-1?Q?wsG75TgOOvvU+pRZ9UwDdNo/4B4sAFd2AS/OTb4BzE5OQIXxlXV+qRrlE3?=
 =?iso-8859-1?Q?mLrp7fn8bv7vJEuayio8dy1JuQYob16qIM+mIkJqKP0a59ssWdvjr4LJu9?=
 =?iso-8859-1?Q?M4siW41VzfUVKV1M0+4Y/7omTZxPM/Gzmcx+6vAT/fB+rRbLg5pBJBo0C2?=
 =?iso-8859-1?Q?4FtYLO7HSMFbr5aNwZ+Ih3vVGZjtOgan0kD4qC6U2VDBYhV07hrFu4vZJi?=
 =?iso-8859-1?Q?AGS7FM4xE1WGtdilq1X+ObAbcJaQDXwL7Hvrs0F4RJnTzGKJ3VHzRhq2ND?=
 =?iso-8859-1?Q?WHoEdEL8kOjwWzJwZ5vCtVg18GP8BOQ7k2X2eiy5SeFs0rqXCUKYmvo7TP?=
 =?iso-8859-1?Q?xxBY/1lsh3srd1S/8rvgahUdydxiWuHXY8AF9xW2dVGlQw0fK/eyjUp5Nu?=
 =?iso-8859-1?Q?Sk3Ci8Zpbfh/a09S0y3GA91beEbZjcQftnUmUY4omtp+TPEV5VZhAgpOan?=
 =?iso-8859-1?Q?MNutm3PW5UGtCnTAiHshxkPd5Mh7sAWXRJzzuPCAiwPaWr9muPXqWBBqbJ?=
 =?iso-8859-1?Q?FuccPOYk+XPqYSR4zguzpnOfn757szfFUOjPnzztfxnGhL6rno2DqUpxTJ?=
 =?iso-8859-1?Q?QkLylI9y3xtDaEnHsKyzEBOQ99xIL1+67CNTXmxzwnhqCFiMwv7Ly9qX9m?=
 =?iso-8859-1?Q?kIE+Cd23z0mq4YEazsvvfqSsXm/Ht46kRu0G7yJSS6p/lFTEAPgZzkqmJS?=
 =?iso-8859-1?Q?KZnqzXrrTrYMoHaLmRJIBBmqa0ZbgqspLYqw5WokDAABLec0QPmInMTbla?=
 =?iso-8859-1?Q?CQ/86u7kJU7sg815huwfiIBLmq+eyeYR6VOHDWKy/cfp7AXpFVQYxOaWnI?=
 =?iso-8859-1?Q?HSFYsFVcDf9hvQ0X8h7n4V9X3JEaQ27DXMrI1+b30cHTcjsfSNbucKdiQG?=
 =?iso-8859-1?Q?6DVLCVfIouFubi5S9hb2l/SMrMNW58Naz2/FCoemdBsPCtIhhP9WqfHfjy?=
 =?iso-8859-1?Q?SAmXYelYHNmXukEGdJKjgjJkDnXYbp/eE2PGJFPWYCx0WEtNM4jMLkfww+?=
 =?iso-8859-1?Q?EwJUOWAPQY6z06eETvm1QRAqUfF0NKYCusjoAwGYgQNYwQ5TPY+eRdGA4s?=
 =?iso-8859-1?Q?Mdz1uKuHABFhhY4fQGIUh6poQDMTp9xQm1egIFTGW1j5tio2vBnRoxbPnX?=
 =?iso-8859-1?Q?tENYgY8tWrS88xFBtXzIrWsQNc7cyqASyXvcGJMDptvGSn2N4cwLVI9LyD?=
 =?iso-8859-1?Q?Wle6hldvN2ZtBU2GE9hVh9kKQg4m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LabASeGBrZcy09TgojduZT3L/SK6VhozKmkn85Ag1BX+4F8sUWMI0AbtvM?=
 =?iso-8859-1?Q?VLSLK31+aooR2ynBJwenWJarICYJqY2J4In/JrWxwrrYAYtIXLGZHG2Pgm?=
 =?iso-8859-1?Q?I9ymw+D29MhiaPTyOLYgKIdw+XiMMWXgMNFXvG+VdJsfPvH9nq7Ga0iDZr?=
 =?iso-8859-1?Q?ZqipCgJNnMsnC5ilUlcEqn5GiZQ3Vvt70Lu0RL65PGUfjTH+ctfDBFoH65?=
 =?iso-8859-1?Q?fGlHdstY1febRWYxH3cuV62HalUpUG07Vp0B6oDNaMipi/r5MdH6D6D62s?=
 =?iso-8859-1?Q?+yB3/2dJcWadpgvMkuYgrQzFVgv2sPt9hjmmj2Rh1feJJFgpGO7rmu9vQj?=
 =?iso-8859-1?Q?VHLsulFQXilGaC3n7nU7jGuJvkHaraHhGrmGM5l5dTBaYk7Ff1QkhA23E9?=
 =?iso-8859-1?Q?d8i9lSVDkMD+S+UyUrjtSHuRqw5cmAzsxkbi5oSFsfs/+B8YM5zET2D+m5?=
 =?iso-8859-1?Q?VTdaOIgHP+yp0aHJfl1faMjkYv40UE+Pa+GVQ1Youb7HS80v0Jjsf79Nr2?=
 =?iso-8859-1?Q?vw8giTPpmWRQk7MC+UtGXrV/6WEQHgDOpZRQgkAWUZk7+xXBbTrwUAujFL?=
 =?iso-8859-1?Q?fix2QS/ceBetXo6mRqp4s4Di9VT3Ayu780jlMBknEKe5Q9iL2D7c9GWWH4?=
 =?iso-8859-1?Q?fOVa94SqGTVos1snk7T7p/g7wrk0DlVyV8qGoI5BtrReKRW86f/OazcuK/?=
 =?iso-8859-1?Q?sCWNNzVP9ABzpWvNGdIf7Lcbow2Ka8PRTdcX5wqX4BrKMV0o0XQHh59luG?=
 =?iso-8859-1?Q?kwXRKRkfc6viVIIaL1U0BltDmdnl+nKggM72v+oOi77dsawDmeHASUTEVN?=
 =?iso-8859-1?Q?x1nvNsn+zQ0U8I0EVlbv0ovTBHBrwlil64OiMpPhxDoAennifnbTA3FaMl?=
 =?iso-8859-1?Q?8YZslnZCEePhGgAWODVC1Rt0WbagS89HDKmdmU6omVoZUGCnUyrq763kuX?=
 =?iso-8859-1?Q?e1hqNeFdy3rS17axTOHY6Z4PmO5nNDu1v6a1F0eAOPNpmLRzKagjling54?=
 =?iso-8859-1?Q?MTKtk2FbEkYlQk4XWl5UBj6QdhknX95HcMCkCalbxCquZlicQyrAcBEARh?=
 =?iso-8859-1?Q?Cdbs1Pl84h4m3lfgyyFTIbJgjvPqrC6S5dq71h2/r2AuOHRuKw0eb8GYWO?=
 =?iso-8859-1?Q?Um1I5ToqX1QfPAi8YLcV1EHXjN29VVe091pr8d3LMYCjKhIDaLoT7DsmXH?=
 =?iso-8859-1?Q?NSl9k7N6WPWjY4KjzzbwLsvrhhIEryeB7MKis+LfwJ65IOGOTY5i/cwFMh?=
 =?iso-8859-1?Q?dBMiUU5Im3/3sa8Xys6KgaNkDqk8Vl+W9YWC84qnhI98EDKRTkUkf9AWSa?=
 =?iso-8859-1?Q?luG6Wb6vT05Z8CdOG7ZneZcIbbPIsZK85nL7ZJNtvDMmRgHVloPFHoW/oi?=
 =?iso-8859-1?Q?DXXDGjLBChpNDa2+GpwwefW9cmLJGI6jSNC+NuuSk/UosNl/Z9f1SdholF?=
 =?iso-8859-1?Q?mMYFtqof4PL+NuPABIMCRdIsOUcKBjHTroa5Iby0zjNLM1Z68G+ISXN7+Y?=
 =?iso-8859-1?Q?BJGua60zcAm0zwTOCUDWtV59MEAj8/7G/V10I/5YMdsb4urvrBtJiZ6gxD?=
 =?iso-8859-1?Q?bQHuF4IK2TOKsSkmKXSoQzMwyf+aDpbDIR9UwKU6KzqaCUPl6o7IiGALC2?=
 =?iso-8859-1?Q?GdlcQBxB9nfhIwqCWLgpjZU91uJvVLqRDrSMGUfxVoJK/Z2X4FYbcyuU9L?=
 =?iso-8859-1?Q?rsk9vBrFPgQwT0T7lsA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0bcf14-5e37-4980-a04a-08de0bebbee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:07.9808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVpPo6XfWp8U0hmkvMI6LzHwvgMaO1I03JuEb9jgWs2GQ9PlLjzNiVav44JmiTeTeE7lgEc3BtoHnfQcy0qTgcr+3UiC1FIzGI29D5QG8Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 7d8b91ef04..44be6e03d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

