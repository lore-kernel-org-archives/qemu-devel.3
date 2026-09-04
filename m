Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA582C79F88
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJj-00054w-2b; Fri, 04 Sep 2026 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJd-0004xq-FG; Fri, 04 Sep 2026 11:58:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJb-0004Sx-WB; Fri, 04 Sep 2026 11:58:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGyr09TEjTalw0azUA5JzKcrdqRLqmcuzAVuADt0tcFPbESc6KwL3FeesF/6Vo+ZahFsxFt+JQdHZQ75xBltHVhbKrh610BjeVvtPDnEH7NMBXIArR2Mb1hUPC7gdguEsOLwuvq5MCwohplDSLYJw1XPTcMHGBUD5BcER0XB+x/fJc4kbUe/hBTe62rWv6RVLIgcAjzVtlMYzdOF9CnmTyUX+pgLMUn4FLPgNYFdz2eYlqn16QWHDP0EmNFzCe4pZBejucqjinZLPJ4A6+Ywd4Gyz2XCbJRYoqd70VaicnIt1e2u6S4O7yOrehJouwPZKLUXephPjj2+GzRonecMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul8g/TM2fc+nj7tcVEVqYZwpGgXr+FajkbAzPlMUSJ0=;
 b=jO/23WTkJ/vdsLiw7wD4Dc3XWkS0dxm5OYCJ6gjKxgrRD/Dz0BP+L82V/2Mi2quhbzZjJHbynogxfzM3qZx9Xs6PMQ44wuFBg7hjMlJX2hVeYBuWF1EY7i0iNzBBC4PCO+7/rbYeQTERXnFm8z7GfaA/4behr/ZLP0dQ7DMB+i939j0bwmcO7qMptYNv+oDd8SpL4EgKmlxlsy6/nrGGqE+PXIlDw3Lxx35WFyEOreKTG5Tlzp1hDFNt63MJAlnRlLw55NkfaI7A6ibIqJVnaf8LXJB2q1iVrsdNjgnpUj4U9Kr/utFTid4S7Y8BnogDHvb/0Y+Weeky6HlgYr/eOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul8g/TM2fc+nj7tcVEVqYZwpGgXr+FajkbAzPlMUSJ0=;
 b=MUEO7qsjEB5BfODYZ5U1Xmo4/ALag5HJSzu9fgT6CTv98Ry7j94hW13dgoorsEDXIFoYBPhHA3RioKVuiM4ZxlDjI6VqlfQ+lTsR294Q2lGQmKEnnBtJzANF2+k6VEQq1tKzgUqiRekUf+gNiFuvXnBeyivpheSt8lAtkC4mRc1r78RmnDlnsZzwH3Qiu9Mhax+y3U2i9g7JFIDlbVlpws7xlr45qQwCQeWvBN2NhK+LjKRfPts5JCJRFYh8Es/sKqOfLBY/KEuG9CG4jc5bwFL8HLR934Y9nJg3YMCFZOmAVA/ukTZ8kI4U7lzyzULpYhGYTZRpDh4mMEbgZyGZWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:47 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 11/24] hw/riscv: pfsoc: Enable 64-bit SDHCI system bus
 support
Date: Fri,  4 Sep 2026 23:57:30 +0800
Message-ID: <20260904155758.3833179-12-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: f70f320b-ce67-406f-2438-08df0a9d6735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ++zUQ2Rb69DbvJNLnzXG/DUmR6dzqNFFJngz0MCUeZW2lGU/lsmCzw4jG9/FGS3L7Y4rTBw8Fh6b3ETnI7vCyxnzqviOADuPZKHn2O+ip4G9v3w3N/Jq3zkTQSIs8WyI7d3qZZMtcIO63S6vJyL38YKH7w3FAXeE0ExZmNQiYmbtQbkuYXaTcDnTisMbCi3kslBNjQiIWP37fiyeWjQMe9tHZhtLhIEr58hiwH7MYFTePTesKVhaicWpYi4eDk80egeQ7eMUmfcR9UDEMA6GTMZolESpEfnDUsB/HjxSVI21jFsatPHj24NpKKTLfiCReqzbnXwQOOdakFGY3we/ZHEkLeee4uMplu1WbLRu88muS5I90F1zR0G4LPQblPOqrqZWQRIkjmevzK21+mVeiIj8VXoP1nPH2neuhD9iL/zq2Rji93IbXka0RjCWwhN+5aFgTPS9AJF6LOG3p352O2rXtFsYljx0tR7rHdfDhtcX+TN+w+9y4/Uyp+Wv/WzQgxojlP2Y9SFQA3KyGGsdJzSmSOeZDCWLqEjqH+y5LKuwWD81IqNgybXul3DFKEKX30rXVn4n5gFZ0q2Fi2R/SnLihPNAFIeHN9i8VH2c7ff0VCX4vTjz4MTj1ainiXB0W7KgwepEHFPIQeBKdxLjeTyH0wdn6wSs9BgN+HOnX1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvNGIjyP2XdhdjYS+DEwJuV1PgOlAUMtPeg1mpFQ2r0yJ7/fxw5gB3TOI3E8?=
 =?us-ascii?Q?iY5BccaoJ8y4Fq7Id4jAHHJ1cCFhcOdNFtjfrYFKWCOzs/DZLp6km1nkwZUF?=
 =?us-ascii?Q?6LQVtsVXBabTb+DIVd3TsTrqgoe0iC8Z6QIFVzIbuOuWoPW9QiOiZm29w3wT?=
 =?us-ascii?Q?p2DYR8moN5xs4v/isOwZAgyq+MIGYShXBPlfPI+YVkZGYpEHaRp5NK1XteC3?=
 =?us-ascii?Q?X7kh6GRcgLWqSFEDd96v8jYOQfSeBWjLuGFGMObqkDrDXyeuyoeOkL8ykfMy?=
 =?us-ascii?Q?3+IlyJZtF5SntI+Ji+/yNo0ybNci9Wp7fCJcKDdul3bvvJMDqBrWKPUFwjae?=
 =?us-ascii?Q?fDxwVbh+h45VD6tAm89XDEMkFvEIdhGHICEVNidXDC2cWZfGAoqTAImm2nK1?=
 =?us-ascii?Q?Lf+ecsKs+vs7vhWAIx67p1R+jyzHVzbouopvXIU8mfpLv9iWX6sws19W7SqY?=
 =?us-ascii?Q?Y1G3TcT6Tunu9lLX5A3NpYO5nWUvUm8V/8x6ZvwN3HXyBGEc9KH0j2gPPyos?=
 =?us-ascii?Q?uO12/+INday0TaW/19eKM2QFmfDTsCMlzFUuRKtjFnKTSIx7YE8yctq7uwMD?=
 =?us-ascii?Q?2CT0RUkxFnxxdWEwRAnQ9LO0I0Cixmk9HvmmdgwFZSHfVUkUiLXp0GckJxWb?=
 =?us-ascii?Q?mh8DNGfFf7/5dwalfKsAw4d1ZNjt4Xa01MGFiA416JoRWJI32NuVIq8YNV7H?=
 =?us-ascii?Q?HwWKfQNh4JiF9jTyEPi9c+eswU12PJFk6sFN8Qoj9G235ahOknb863qoCsm8?=
 =?us-ascii?Q?AYYHFIFzi/npQ1cMNRvwbtfP/kC23OthKwRcsI1p4OvHqHVxX/pDEanNjTkI?=
 =?us-ascii?Q?fE0BdO+2LEgUQ3vtrHoHZKTVAPLtypPEbu3R9SjawNvxATJv2DmfH0HWpHI2?=
 =?us-ascii?Q?8DTNndKUMUwfKabfOMj4uCwt4vTb0d1XZCvjtoe9nOvDlqEmrOUJ0+JOvMLO?=
 =?us-ascii?Q?OovTakXFasaCuVMTD8UTngTDl0wrF0HVGq5W6Sk7PuL1FahUl2FQX8D8VLhR?=
 =?us-ascii?Q?98mZ+UITTUf2euCKXUxXU1VFElT1cM2R2IWUjkcd31qSWPpxl5PF4IKd2yYZ?=
 =?us-ascii?Q?lFs4Ldzmb+ZtZ0FnqvOO2+qI09YSki+VZiBIpEOt1/HlBnDqu9H2RWL0w8TQ?=
 =?us-ascii?Q?DHbudoEPikEluV4WvIjEfxcjvRni2bppXxIqnJiuGYeZY4w6XobVDztLQZnj?=
 =?us-ascii?Q?1ipp/2+S2jwVpRWU5O/PhEGl0xaf8WT+/U9Q8aYFOI0kR3GBROZQZ88KeY+t?=
 =?us-ascii?Q?LfBaLuOSnBtazBhpSrvOyIO5yi8Vgp5UpMc7iuDIs1pkQmYY5VsucN2nSjZs?=
 =?us-ascii?Q?bPG2YcKiql9p8IKFSWcU/g5yp0tfJhHwItfQ/yPVEE2yNMZT58vXil9/smgF?=
 =?us-ascii?Q?r0LFv0dP0D5lVYsqs1soYWA69wpryD47SVxmSqfBDFQuUHRAiI9Z+iyI913X?=
 =?us-ascii?Q?vD1ACAo4cVXO2KZQ4RdAZN3o8WYl9OfVXReuTHpXuDa9BSqo9ezQcs0su39A?=
 =?us-ascii?Q?G1tnmhq+bCuNe3pVR6Q7tRaS0dZ863hiK06EFzoDOyFrOuxeL6vvAhdxHPIt?=
 =?us-ascii?Q?JRt3I0eN/S1i/seXr3egwtIsunBP8A+ir3gaop5BKg1RTBtbak84PXZEO1m8?=
 =?us-ascii?Q?obj6Ma+R27hljoEMIEHNp8nAk4XzRFWIlqdLpoU885OM0Jz+K+X6lhXpk9Q0?=
 =?us-ascii?Q?arSycAwlGh+HY6PV20r9UJnuO8bJFVVDYl906pZHTj72yyHrlzLs57Iq17Lt?=
 =?us-ascii?Q?b96MPrP/lilmcrgqNWabY1hx5QTUopg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70f320b-ce67-406f-2438-08df0a9d6735
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:46.9441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKnkz2amFlsW1UN7WL+5aYwYFKHFfLVzNmBZcIN5C+BDJlmplupHKFs4S6RwyXZq36X1J10G508xFmgw2+MzmPcxZhLsbXq+VQ+IWfexoyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PolarFire SoC software selects 64-bit ADMA descriptors for the Cadence
SDHCI controller. The controller supports those descriptors, but the
Cadence property remains disabled by default for other integrations.

Enable the bus64bit property from the PolarFire SoC so the generic
SDHCI descriptor engine can execute 64-bit ADMA transfers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- New patch

 hw/riscv/microchip_pfsoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 114567867b..b1df852ddd 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -190,6 +190,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
+    object_property_set_bool(OBJECT(&s->sdhci), "bus64bit", true,
+                             &error_abort);
 
     object_initialize_child(obj, "ioscb", &s->ioscb, TYPE_MCHP_PFSOC_IOSCB);
 }
-- 
2.53.0


