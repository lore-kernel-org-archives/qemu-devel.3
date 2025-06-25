Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EEDC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxQ-00072C-Nu; Wed, 25 Jun 2025 10:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxO-00071G-Fr; Wed, 25 Jun 2025 10:18:34 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxL-00048J-8s; Wed, 25 Jun 2025 10:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcEDrZBQzw2A88fcq7e7xcEjeshk0KW1ZZUYlRMGCOMfur78EJ2/kr9QRlMVCOfuxxlLwtEFC8wR/LDu6TsTg09YUrvwxL3DqyoFXq1KKrAFXSjcniadf6EzaxEIrdnITJys298Hvj7QoHl0L2qdMYqYYDiCSxY966YHiqlWz1OFdnH7zXNUpMozMMb8W2Y+kpG3aTBGukKU/JojFJRVwcfVsrVpU7tVGMPfqr3i+DdQJH84a1E2efq2rOUgSisGRnQOxeAbyHt64KbIPuuYkLAe7Gm8KItor2KUEh0SyV1plfuNlUfgNtyXik81WijK9SPAM0Vqsd7OuAwKW1gl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jjMGj88fifzigverQYUWa12ZLSwrAXNuGVAKDxsJ9g=;
 b=Ly1bBpMlfzefl/8aLXKZfsSq3w/29snOAhMzey5DEUqx93ZnkJkDvICSmM32yaPUY+4oh/Tgi79XCX28DeW7Ggkf9zrrh50U6sdddI6+oA+FODssrv/vR6SUpfjUPAD4DLYgBLFxEbbv9co/FNvqegTj9IEwdCXhogS6P8xCsfSjYh7YmKoU2v7vPXeqcfFV82PKE4oC6KeA75jGaaiXcaO0QfeuJETi8VU1q/02OE9qxjACV27NPx8TEgCmm7vmJIM/tixaIUscYtu/7iIGeARmCf6s+Q36G0/VrAigHEHTnQjT7mGx9oa2ztE/6gX7JNIe/R8gWViDJ5HcfLEOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jjMGj88fifzigverQYUWa12ZLSwrAXNuGVAKDxsJ9g=;
 b=HrdSu7H8/81g4TZ2ZQ8Wdqy7M61OL70obEdZykC+VgPrT2oAfDrnOD1l8Gq5+n3oa7fJc5fgPMQKFfcokIXh7s6w/lFUkFVP8vuv9VUj9pBEWM1hqLyRkz8v9u9dRKXILGaQT88a0WKN/meIrUyLwYTsfOyodRRRi0ccjo86XFC3cHpknUtJOvNfOYa2mshvMKSmF1sqMGIBdZ7Kd9ueesakYrzPDhh7dwnZsuvnSA8BtbZhZdl0hu5QaJ/Wq6Ea8rOTBtu1v+hFGyVrsvCLbMn1F6jzLgE11b/Ewx1U3eLE0fd5K5Ytzu8nd2IVvqmH/LumEBaJ6AMnvkqqCG/Jpg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:19 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:19 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 05/11] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v4 05/11] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHb5dwA6Azhmr4mv0OpUNsgkl8sEA==
Date: Wed, 25 Jun 2025 14:18:19 +0000
Message-ID: <20250625141732.59084-6-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: bd7b184c-8d41-4b70-bc02-08ddb3f322a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F8PbFoI1KBJCd1yiATd0TUNb9UeafXML3HJS99t6Yw2nuHnE+WyWrrlBPb?=
 =?iso-8859-1?Q?dANidUBO7SOTurbv95VC2nrmfMcKuDWVkfmJXsNeaRGYxiVGt7yETieTPk?=
 =?iso-8859-1?Q?Wdn5zhulqBBR1bBcV33duuaL5I4eKtNkXWZ8+uLw7oz2miBvBP+yX/ssSI?=
 =?iso-8859-1?Q?eNk381grx/r1HHTSplHe0jYARk4lo6PoCFCZRVEgpjf2dIN9HXjnYFuYR9?=
 =?iso-8859-1?Q?BltTshQ44/YId978AyMSn6Q0A5sAV4fneJhdDrOcbfCcwehk0sfFGuTG0Z?=
 =?iso-8859-1?Q?SfJzfXPemDPtSXr3R2vIKEaqDBdLJt7bj4bjdxzeKcf7t9vPUepWUgFoSK?=
 =?iso-8859-1?Q?8J4SpeYrjTlJkFre61qD2ydJAnUvp/2c5v6DTbNTUxCxmKHBnFv7+9R8wS?=
 =?iso-8859-1?Q?afRzLrFoK5GQjFln2IXoySM92PMMVEGkP1waj15juwHqq4k7cfYKP7tdsv?=
 =?iso-8859-1?Q?0ltNW9K2EoYbbBub2BtZGS8+r61g22rWE8d/xhv4b88mDjtYTuarn6sEdD?=
 =?iso-8859-1?Q?5in8/6ZnEcu/8nQFqekOGAIMMaHjKCVteS8qqYVd27r7cixNmdZtzlejCR?=
 =?iso-8859-1?Q?vipQ5GPM91Th7rDVQF2d2zdZcBo5LRV3tYxFTXZFYnVpBeIPoTLQuyNtcd?=
 =?iso-8859-1?Q?naxUB5NEj9iR9HU0oq49Aw89egFR6OoObkbagqVKiZJFHrANVU5SCCvTuf?=
 =?iso-8859-1?Q?V0dFqoBC+773NQuiXcxDdzXNUJK+npRgs4oVFeOq/9kXpYzqCs86K+zHBQ?=
 =?iso-8859-1?Q?9D8jWdZM9YV0X206Km8pYXlnRYeo0FoDmaKNRYtV6XwXBm1dETa3pzeCWH?=
 =?iso-8859-1?Q?Rd4eVbNpZZG2Z2ee64tEc+pm0deVHaQQuiqX5ByD53BHaBrw4muobY5s3P?=
 =?iso-8859-1?Q?L0XJqxnvZ1RJJEJLVmNwY5KAeCH/XtyT3deyak3yYx5FeTx54eOkuxBRaz?=
 =?iso-8859-1?Q?q8YKDmQkAdlPBh23n+79NtfBRCLI4MUD/8Rmo380FZxUG8E9dVNF9eQlHa?=
 =?iso-8859-1?Q?6h0AoUw5d+nmRwlTXJ/m/yIy206YajWU3m8nTX//BqlLO+2gUGSdwQR34F?=
 =?iso-8859-1?Q?S1x0ihE+P7sproj3xzk6KJKmJORmf9SilaRZ1uwXbKudVdu7gWooIc74o9?=
 =?iso-8859-1?Q?02t5OBz9KQeNaNeZ91QThEKTB1Mhcj5oj4LSEgsjI2genSjDEf+sKNILxj?=
 =?iso-8859-1?Q?+GwWVWUCfVJVeOeZgnopPrmskXpOUP4fcqaj78Z+hnckRnHAX3o/GcflL7?=
 =?iso-8859-1?Q?wt6a/t5/vpcAzgeM2aGRtuCnNfH0ZFDMfMaVuV6yaZ4iPqXqjomaFEJsDE?=
 =?iso-8859-1?Q?sjn3q+gdh3vmApG3+xHOF0HjVodgSTe1PTEypi3dKllWWshZzR+0o9HSrj?=
 =?iso-8859-1?Q?neNE2ozaV68Hllmk4bJ7+NnwgFMiKOjq95ngi2t54gfIe6mCgkchTO5WLw?=
 =?iso-8859-1?Q?Fnj3xHeHkM/hPo5nQNkcByNL8VbAql/AZ1CXL+WKiw9ihoZDny3bQ5hAM0?=
 =?iso-8859-1?Q?0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BW9+5bPTztdtRGulRDaWSXwBVvA2lGUjw5bix0C2lNO93qLA6+RKheKHRc?=
 =?iso-8859-1?Q?PRMancJya5cGMEZQ6Ow/MMapwyzQgTf6MdgABVSSNo4A8K0v/hWsSZcOJn?=
 =?iso-8859-1?Q?LSxnULXkwELA0gp30nB0GOrcFs0+iBTIbfS2PV6EzqKAIwLdzD5fD2Ncwe?=
 =?iso-8859-1?Q?Af24AvfAOlgw/Dz4AgTzm80AfjI1KWxN/+iA4b945ILFBGsYlYLCyEj2Jv?=
 =?iso-8859-1?Q?aiTEk58yu2Mu1lmjyU7qbq6eKQZMfFVXAJ5HO+JMHUTdBJv8/EkPnWh1hk?=
 =?iso-8859-1?Q?VKkRbBgzOdF9MKlsHwPJdB0pAfrtBu78ANKs1xggHNXc5NTCsB/OStZhlj?=
 =?iso-8859-1?Q?irCXZlXtZ7kot6/IBd7/qYmacmfVn2ftVYCM3WG6ApurUD79xiNoL2kApc?=
 =?iso-8859-1?Q?SJbuWows2BbPM35LA2qZTQZ9Vv4ZjTYVgN8Y4x6NXE4PNQtbLIebAIfsQT?=
 =?iso-8859-1?Q?2D3iblolzYleyQ/l6ltKAUmGjEyXjh8b9GvXO6iLqnZXP3ZlusWXlgqnkE?=
 =?iso-8859-1?Q?CvAJe+Roh2QHLuaeMhS8XH9cH3ytoZLt5yHWTNtg2+f2vu68LiTAwBskdk?=
 =?iso-8859-1?Q?QNd5t79eQC1WiPbO8sxHYvCILQpb5lMMIg74AUA4FT89nX8d19sTW/T/6j?=
 =?iso-8859-1?Q?pyEFzvTke6gQnlVNpN4EWdZME8nedeC7mLWF+Zz6ACedB4fScolEKU/6R1?=
 =?iso-8859-1?Q?XRMqYQ5NOBjLCyZ+N0ZPO4t1nzxmN4OXesFs/Vf26ptUITwlurI61deEnR?=
 =?iso-8859-1?Q?2zOBENqEFgzveqRtISV+fE0g8gU4RI8RB1r5O4K8X01TQDLVeeUbrDlU+V?=
 =?iso-8859-1?Q?OXdzp9QYNEFLYixHPiHtpMhX9gLY8NSh0JYfZU3evwhOXvPVyj3X890Tss?=
 =?iso-8859-1?Q?kHERPDKV5omc7EjIoiZlxpAnxgsLv1lDRdd3sykcHczA2YKqMISdaUmSmU?=
 =?iso-8859-1?Q?ZA07jI5oP9Di9l3fgU/7Sd/0UbO0PK9K5EePuiJUxTfR/903ePk3GSrbRR?=
 =?iso-8859-1?Q?YzYrpLj1HqrCfmhIvDWPXsbTFiK/+0gp6NurUU/D3SQxMtp6LRHzVjwZG1?=
 =?iso-8859-1?Q?AeS+nJbFnBZjw523dS69dnuuIP9hUklDXBv/75OcwGP6IqI+DRK/MBNCY3?=
 =?iso-8859-1?Q?BMZx0jdTVnDt8FzErzsVuLyq65Wwo6eKu9IJ91i2d1SQbUn/sGaHDlTxxm?=
 =?iso-8859-1?Q?5i+YGVcNoKAu5jqTYv5cYtjt+Pt5h6Q9XzIaGJFrkqHHtryuC15F7wVn8D?=
 =?iso-8859-1?Q?DGLN6D4i/yfNYd4QuhiaWgz9LONGKPkOKm0sEIASnOGodGX3fC0qjAdkVs?=
 =?iso-8859-1?Q?xNb37KAWwYSrwMlrbsOpTV60YODZs0NwXLGieS97fyGScYgOBmJBcQqUBI?=
 =?iso-8859-1?Q?bo8LPBhrHJx0Tj7Newz5FX4qcE0wQrs1BbAOhkqOawXH1sBq5eXKPqRCyj?=
 =?iso-8859-1?Q?gOuj1P0VDwAfmglwTYy+Vm/WnclHVDzrqhr14GbQVxwoCGuN00m8JqJ3rn?=
 =?iso-8859-1?Q?3nzjiL2uVTo+cCoMWQYWA2qMtvyTHHJPgpPay+B5Z+4rF2u5OgJCl2EVz+?=
 =?iso-8859-1?Q?r2GWY3uqwPDskrtMYgKtlN5vTp4sxLnC97ULWxFH04CzxwN37YMen5WOZW?=
 =?iso-8859-1?Q?Tjr7UAQIkju4HSvvQelLrA5dwGnSh8FBL9NESo/EJskG7DpK1XRC5pODFi?=
 =?iso-8859-1?Q?vxnB4HeALJ/nCesF8U8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7b184c-8d41-4b70-bc02-08ddb3f322a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:19.5471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjLF8h2mPdenIJxBDYbkkTBpWsdhEJrhlC/pOvrT676DLWihCi1ODCJc3OP8QT3iBg3yjilS37kldYa4jOV85y4vgSPk5aMiQg9z3KNWslg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 ++
 target/riscv/cpu_cfg.h                    |  5 +++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 42 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xmips.decode                 | 11 ++++++
 7 files changed, 66 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9a11a994c4..d48fd4df4e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -230,6 +230,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1360,6 +1361,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3178,6 +3180,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 59f134a419..baedf0c466 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..269b1082a6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,42 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2.1 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fbb6c8fb45..26cd11ec00 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c3fbae7cfe..4841772522 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..cb334fa4bd
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

