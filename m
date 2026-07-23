Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B770C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvCt-00043M-AP; Thu, 23 Jul 2026 11:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCq-0003vG-RQ; Thu, 23 Jul 2026 11:19:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCo-0007zZ-LJ; Thu, 23 Jul 2026 11:19:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIGeYft2omkqcHwNdS11mKo/3LYJxZITX/OYuFDKAvC++bSzx5j2rDV0FjAtG6eKgEkFMIT7qUt3P9wJE2iaBTfQrEwrX5zvADncDm5K44LL/jUCcUA+BDZpy+rwK66fSIQL27Qi+UfTvSiOICA2whHj4cFHD0F0ZE/W8OOwrnRnP+txcxCqPqCCiHJJUVpPaIhaXDP9G/xck/KWWqYN2BK9ewEvU80JUhrF4yzKljmjgXz/su3J/+dQPzGqidsmoSMifVUz+Y9eQikq4/9yWksCaaAZeDvOiWzXSwt0cq7AmeqAdep/Mh5HWpZM9dzf0s4tRB91ClNb134lp8AHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6RtfaFuncVDNGD1RNqTDJeog9eykOiM2rsSnnHAZvk=;
 b=nvAWslad16RXOfB9FKvkuPe4pasxz8roRujRcRzeL74T87OEhaqHpzjh8F3+FthCeg/WcdUkWmr/0LwYwjP8VOmI58i/mgYHqkO+HXTo9yy0qWHdykftCEkoRpKgKRX2h3up0uhgqVksPjsBkSoym9uIUm50lwy2d7rMNaFQN0kaV8snuFXrVqIJR15AxmXH2Hzshk6XjlURhoTCXy6DngUDZbpMfHCJegUIKW1XuWnjwti0bb6BXSP7jU7JhITGrLFt3XSiYve0eX8/lWau8Nd8ZKzbqoocCSbo7ML4mZXdvmJYpcxc8KqcZCTnLutCP6l9LOE77Z60dR+e1UPP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6RtfaFuncVDNGD1RNqTDJeog9eykOiM2rsSnnHAZvk=;
 b=nfRu5MlK8uTZbDB2DZxAQ8zkSMxOGHwfdjbDx/aAAR+sNYKzYhLHDHUkTaD1YqlZW0twaU0SR2iHWWLrZ4EXEFB2FQgAI87Tvnybek757ztxlVv1wTgUrvyMAQJa5SRtviSV7HWj5KnNNqGnWjsXWasVXuOMfLoi5XUr0OmfJEK8n3N5DaUXvx+Rngpg/AU6yCfBaGlE+VATmroOz75FYOaW7NAteeAIEdsfAq1FjwhwyPHcdpShPqehq4xzDM47MDsTf719yQCMWax5JyW5Hg43I32MxTJse1OiGTspmUITlZ0TGk7xlFsr2JkxXCy/93KOVCbHS+ruGN1h+/WbiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:16 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:16 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 02/26] hw/riscv: pfsoc: Map the L2 zero device window
Date: Thu, 23 Jul 2026 23:18:29 +0800
Message-Id: <20260723151853.2143177-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b5db24-76a8-4893-cad5-08dee8cdc254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: h8T+G4pkfvCdso7hwwBb0jOlduem5gTzeNJk4qFRB411o6QrNFN0lUfjzCLQJW34M+b53S4jG+wy6Y+6buhyieK+qiLcRkbH7UEfpIl4ZLohK/sVYI6C69FocZF+lrbCWbkJMGUx7ymXMMiDxR7h4ehZZ2CifCvWb/CEJZxlJnqfmnk1gjthhpBfxfQHG/3zZPuQ+4Yma5sEbd3rl59JqibbiSVEoH34P5fzp67dzoUz29OJ7bXDilBHoTEHkVtpCE35OH7Y6sXeqnc8LEV4dBZwKvz6dNbk5lQ0VqoAkpc+vm4Nve51tY1+riIGCzG50dAtpBPGU0E4Vg9krMZ+Iso72wrSxS7N65VkWaebOsxDcGoagTWcsIyQFbZVlID/Gtbg3uaRq68SAVbcVbAt66tWKyE2+doIRo2megZ1TELkDfc2oykU0ugud+53YTnMFvi2W0Agsd62nRaU4YSgh0kU2pyXB9EdznQ5qhRSkG1HtLlybfSacZc3nWKraFi/ihwRAu043mV4Bf4XNKkc9HeHq3aGYpCPi8FzLnSZrrW4gckS5dmgdY0an7Q4ingPhJHpQjgoLk0QBipZv16E2Agf9ynGzFIISc9uRSgaHomWYEJBnh7Eo4GmAoXkgXsOCapjKqlxVVPi7U3mIefYvuDyXA8zRhXIxtTjsZf4c1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cnJgfk7/tVXDvWYX8AXTpQXyraTl+Ho2SlhXHJfDl3jzsDrOvNCLbWhdSkZ5?=
 =?us-ascii?Q?/ZlkY7beHIjEnu4biz3/56wO1HhECopQqT0iTiv+z+OsxjbP/+Sh0fIvs27c?=
 =?us-ascii?Q?70FZxC2Gf35n7aBg505bjlvXDN0/PBe9Hb9sbC++elH1XANXxc3sYUpcBgAU?=
 =?us-ascii?Q?OasWVVj9j1nyE0ru1IwEO0Om6GIOY5LMt1E/Tmx6ulbDKOjCtdKxY6SjH3JD?=
 =?us-ascii?Q?Tg76GAw+SY87jB+TQLZVi6KnB6JKodjJz0aY7oI98MckED0GYfrDnVZFbMJ6?=
 =?us-ascii?Q?X5Cz6oksSAPKDTdEW5wq3V4lszhP0W+qLYSOUTqhGA3GXZsDGazZaTidEJqG?=
 =?us-ascii?Q?F1QCG8J+qqXDNeG1Uj9SXgwF6Lp9gMuZu7/4iSpVpRDrZqjEfiRox05sS6gY?=
 =?us-ascii?Q?gldVHHv3Q1pWS1VmW6bEhLlghB2ejfA+vFZCTi6mx/97BMvEiJiI75SROg5Z?=
 =?us-ascii?Q?TFfPa/SuGciaZ2dg48GVWFNn0cT4UZUrhFgeOKn+C/68yGehCe+I2bOeQKBo?=
 =?us-ascii?Q?Dil2Iqc8TD+SsuYd4MtQCrvDAOcdVrLmPz/k8WR/PXr8oqoDYjBkcpbcrvko?=
 =?us-ascii?Q?jd1R/uAWxBdgR8VGIMfyAeMUEP7xzLPlJqz8t7mfOwN7mVARZEEYQogzSNe6?=
 =?us-ascii?Q?ZEOjqX9iuCID0wLQa94hVBFgnr3ERT2t8DtewcTydF8zY1tdzDQoymMWsZs3?=
 =?us-ascii?Q?gDZDFClBN/WyBTIX2VRGwREtzhxeIBi7jYLKtraokyTYIeVAS/GTq5v9s+Bq?=
 =?us-ascii?Q?hm+Si5drm+dVstuJniUGpRZ4O1ijehjc1FtEsqYadMy5P0WFdFYOeKKTTEm3?=
 =?us-ascii?Q?DjMs45s31RaMCi0Uls2AYvwY1Bjb/LQSnxFph23A3VO+OfWbuXGFIcOsplPj?=
 =?us-ascii?Q?kknNAUGu+EYthET7ad+vK590C4OE8cReKMgvMp0sImrJLuhtkvtEOINhzGax?=
 =?us-ascii?Q?uGupaw1eMW+slKqYBUHDgDwtvi4QswYL8lToVKLlQ/WfLN8ecP2kQrlcuh5L?=
 =?us-ascii?Q?wkU/IOShkVbppdY/DG+EB1RCdTt2PToIh+Imd53eVlr4sUfqPBviVbKdaIot?=
 =?us-ascii?Q?76F+Gbo9SFxN+QXsEWjf8rnuD/qDVwTY1MIDGIe80ZuSN68tFvQ4IxldBOP9?=
 =?us-ascii?Q?c4H7drPNLHvHMdXgZh6V8jDY5Zk3yoflBoDbAKegwn/hCb05DCuPAc+n8lC9?=
 =?us-ascii?Q?PrCUSHPq0YjnEpHP+TZwMf9nozC+JRdb7ptuRLMqjkeXwc22gmQNBkmBvBBL?=
 =?us-ascii?Q?y7/JLOpawezkUhF9Mtc3GklSuoK2hXSzbxjCGYubNY0DGYSaiOW4PiU4UVTv?=
 =?us-ascii?Q?b+DjwSFUICfrgerGYP5ckHQQbD+CDhigd6+30cf6Oky22qyrdsjfV0KJzdJV?=
 =?us-ascii?Q?N4n+Ih9uNRcB3pQFTfLk6bjjLpv3WQlE/d09bazApGumd0fCxB7flsKZscmG?=
 =?us-ascii?Q?bqfwogNbg3sX8x0LDhXGy3UvINRohoVeQgzg51hU7flz3Qg0ztemSBEbKgVV?=
 =?us-ascii?Q?g8n3EDAhV6K1BBhE6sQv2t9LFJSRgf459oXD1ZSyXeQkl006RR2MiLD94P8Q?=
 =?us-ascii?Q?s04xc0lfgqT3Omd4oKokEN54qyB18tde8XCFzhsKzdBkIHRC2/mexxDJEiny?=
 =?us-ascii?Q?/ohKeALtVs781Oc4eBjFU971SJKTYwEu4i6i+zpTyrIkvDAIT0Ty6YPF4qXg?=
 =?us-ascii?Q?QwwhdDLSyEtaDCJ0VFg4l/HDd7rKpuOQkpoPRp8L7Z1DTNzGjlWr6ebrf1dq?=
 =?us-ascii?Q?G3FxFqEpySl2fEOTVSpQ2m26dZh2HuQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b5db24-76a8-4893-cad5-08dee8cdc254
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:16.0319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN3DhbNIgzQGE/Tuikoq391WN/h2d7tFvPwRa1VXN2onjOu4E3c6DlVsicFDnwQ0XpkV5Xh2qGtL0bhJKHVTcp6L9Ntam1oezzbgHUGyIHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

HSS uses a window at 0x0a000000 while setting up the L2 cache,
decompressing its runtime image, and executing that image.
The missing mapping causes the E51 to trap before firmware can
initialize its UART.

Represent the window with RAM to provide its persistent read,
write, and execute effects without claiming to model the L2
cache itself.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/riscv/microchip_pfsoc.h |  1 +
 hw/riscv/microchip_pfsoc.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index a30b944afa..612fd2b69c 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -90,6 +90,7 @@ enum {
     MICROCHIP_PFSOC_L2CC,
     MICROCHIP_PFSOC_DMA,
     MICROCHIP_PFSOC_L2LIM,
+    MICROCHIP_PFSOC_L2ZERO,
     MICROCHIP_PFSOC_PLIC,
     MICROCHIP_PFSOC_MMUART0,
     MICROCHIP_PFSOC_WDOG0,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 218cccab69..fd28ee75fe 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -97,6 +97,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
     [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
+    [MICROCHIP_PFSOC_L2ZERO] =          {  0xa000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
@@ -201,6 +202,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
     MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *l2zero_mem = g_new(MemoryRegion, 1);
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
     MemoryRegion *qspi_xip_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
@@ -277,6 +279,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 memmap[MICROCHIP_PFSOC_L2LIM].base,
                                 l2lim_mem);
 
+    /*
+     * HSS decompresses into the L2 zero-device window and executes there.
+     * Model it as RAM because QEMU does not model the backing L2 cache.
+     */
+    memory_region_init_ram(l2zero_mem, NULL, "microchip.pfsoc.l2zero",
+                           memmap[MICROCHIP_PFSOC_L2ZERO].size,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_L2ZERO].base,
+                                l2zero_mem);
+
     /* create PLIC hart topology configuration string */
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
-- 
2.34.1


