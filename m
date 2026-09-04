Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56316C79F89
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJL-0004Hn-Jk; Fri, 04 Sep 2026 11:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJJ-0004FL-FD; Fri, 04 Sep 2026 11:58:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJH-0004Pg-Rz; Fri, 04 Sep 2026 11:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4CgwicNmN6rZKkVqap97sx7NcD7466TqMSqM8fKv9EeNzB1KcqT6uvcYdCs8+CRHDjOtUJ/Cp5+J58aIHUp5sTJXw7Urvq7U9fKqtUKzgJA7s0BgwRhRi5h5U+hIMe/JzwnN06TCvT0Qrax4tBznMItkOIjrG+YfvR9G6wWMaXK10xmOEvuKbBPtQORvqW45w9tTGjLDZysUNPN6xT4nLxzkw89KDM/N7+Gbv9S6CSixiNgM7isfhcWel57C6UW1G9gGcditI11Ih3a+2NqOekHTrK6Ip+JdwBPM0f5XWMjWtyYaXm14NmFBP9PYMoAASn9shBWjRC42jTaTWBKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEsWQYphQK4WAq3lkx14st3oXtaoyagMGjEfpUxvuos=;
 b=jnEcgF+q7enWFcTxjcyorsGFhDPX+UoYuyZqmEilB14uIfY20LcgkoUD6yls1di14isLKcNSfUxC58Vs5VGVACJo/fzCHBvbekw10UBdFaFIL7It2rgKDCKWGYD4y5u1h4u6Gazw2jA60aM4lRkl0bfZUJUfS4b5/ZbE4VR1Uc854u3f+FF2rT79xCTnUhG+W9jxVA24w0Zc0S0lekIsWwNfVtBH/PcRC0uxq5kvEwBLCvYloPm8YHg/QOs0q+2jXyJU2qEt12jrlhjNQ3CeSi3IyDu+xgd0d/PfKShjMqIMaN4mkteB50szLe01SWIY3t/Li+o5cRQYQmIfMfKC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEsWQYphQK4WAq3lkx14st3oXtaoyagMGjEfpUxvuos=;
 b=bPpyuMVs/TPwUDi2BdRRTEZIV7IadAwUHxWrFcIbySFjjAQAjQkxJcIrratP9HD9fVt0KgsCWY8B3HdWDERJ+P5T4R83iUatBde6AgMappS1oUafuwOtmSlruQOJIbKr/7yWrwkfX/cPo8CoxJFiq+6ESejrQcx/4bYXPslY6G3HrMPTmUoCgeAaCf/n94r4DJ220T5dSTm23xxMDN8/7gdlw5FVp7IMq2IGf4ZVi5TPk26/rH/v12q/volM2HXN30sgKVBPheesNgO9P0dT4ADPmWkQQ9xbwKZLG9xeyAbTtL+ke/3cvWwOCh21mIkHkm0nShoy/ITisITHTfWPag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:25 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 02/24] hw/riscv: pfsoc: Map the L2 zero device window
Date: Fri,  4 Sep 2026 23:57:21 +0800
Message-ID: <20260904155758.3833179-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fc8998c-1bd6-4a88-a05f-08df0a9d5a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lfud4MJFJpguJEjxabY/J9dI9gjemY6bD04AxYCaYcLFSRHsfbtRU0K7KTZAZxUiFeeyeZ0TnORno9InTYe2DiAkC6ggMQhA2BSF/eLpy07cx5ryZx/K7k8p0GDexbIY73Zv8Rz4TJSxcQgHT6MRnASbm1Cwqx58cZZOlkYXtRT8HzKL4Fm9sXxooYcrhKZZkbt3yxCYrEHZHzdIbikwEC64/w0gV/2jS8mqR+R29ghrw9aInVRi/VzAmel9kHOytCXLYnz3HuT0OV9yWa5h5XNFbAErmcw+k300VRshXxSlNhMhqMsSdaidmlJysgOZhDZh9xYUk8JZBBSkKOlApNRL9Dt0wTgcYCna7OppbDaQ7gDzKV2tW46bEtfQUE7Z9KaovVj/fSpxt57+uw+v65ij3Yz/3b1IvFNUY4SChgs5h0Vs0nYgYo9R/CyNxR4jQ40H4c7pILqYqlx/OxC3+Td14nKKBwFMZptA0O/Kv3WrJMNTbT7MfV7uRnSrmCaLEmV6lE6NvlsrxgSL72R8w99RoLyTEFrDp9a5AfyHvWUbFetj+vH7jKoDNSJ4NEICc/f3IMx0hIAxfpdoloOx7kypCCxoY/rxgFYg60FRpSw3PAK/ogC7sRGH4QXBPdz3UhwGjfu3AZhDJAQIM3TsiALfsIisghtxv89YH0lICBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4lMkl4nJT5hCQGlW3K8rDeZ0X7eSHR0pp+v91u5ihN/zXI4+MlenLadJdsgK?=
 =?us-ascii?Q?DS3Sb/wDnlljpqCAIAMMPTImh76LhypfKRFtSFVOApwp+3LZ8qppzY7H8uMU?=
 =?us-ascii?Q?jPpgpOVgTaN3Ln4pWTMiDWM/TKFwByFxXcUcg3x9xQc2sFMAFJ/oL/+imZlb?=
 =?us-ascii?Q?JUs73u9SygvFtFWqHW53KMjBNiWw7R0HM7hG4hiWddRNKdwWVyoPNlY2jqMJ?=
 =?us-ascii?Q?UImdIkujRcJBfnHoe7luyzQEFHpKjsor+exWp4HDXR3ZEBUIQGJ75E/YlGG4?=
 =?us-ascii?Q?kwqIK0nDPFtE5Bt2NOOWmRzkYJ73Mm86PLvW4w1im1yNM2+0FsFtub6Hu0kp?=
 =?us-ascii?Q?X+TepC+pHBcB+8lwFutfbfQp7tccFYblbWzbmJ9h8dRRioTl6vuYtJmhHNqL?=
 =?us-ascii?Q?BcAG9P2A7ScHpl3iFwTjTqlRjhVPK/r8H3kOqkLiNE7AAT+DSPi1519woMx1?=
 =?us-ascii?Q?hKbRD4QOvLslPQ9IIm+gkYBgK//Wry/0y16ql6N9memJV+Spra1lI6puwp2X?=
 =?us-ascii?Q?c2ewr2xxuAPvnMvE94YweWRN0aBZg3Hh3aL5mrYc+QPd0dG8tjP/kA0Fk0Hs?=
 =?us-ascii?Q?ec4guNViiYFuaHZNVDrK2F09tZM4n8zoUyIr0n7TGCUjWZR8m5gGoUUZyw39?=
 =?us-ascii?Q?wO4h8Dq9DbUX133mfNkDInxieh6OQeBhHvktsRd/gqF0EqqODsfIdrPH8usq?=
 =?us-ascii?Q?Um7gPDKsXJLLFal3W70guNChcuy8arzCFFNSEUn1CCQYEEvQUdARN669CZDI?=
 =?us-ascii?Q?ZdrRSe1xHPG8RdRCPUBiQDIxsiFEOynbk3rfsHQ4wNMdmy41t6XbtV3mR8Yn?=
 =?us-ascii?Q?o2FprEd9qb591hXdjcd/8b9EPRZxYGTBRlnZNgjCA9U+e5cxwy8S4WMa2Hcw?=
 =?us-ascii?Q?wP3koHWHGVPnUDkyIC+lP2EHMrnWhuz9ozn4hrnOw4ffKrCEh7JxQp1eVhtL?=
 =?us-ascii?Q?z2zy5KnpnwiaQyUVlFvcD3VZXj9OYApbSgYpOVdTOVis84CYsl7hD1sTxIj4?=
 =?us-ascii?Q?KtFu2ugG6Zhkasaue/vwGNe+Pt6e1D31sMAoMVCccccCbJLqG54vYfkKj29j?=
 =?us-ascii?Q?DYNYGUgU8GCpbI4mepifJcIKALy4jodiCSfrYoTXC7bYH6KDpW98XqdDb2SV?=
 =?us-ascii?Q?o8US3EUTWZpsj0cDscZReHgpmIQ/3l3Gzvmzshcf5GmJYwAvZq8A57VmKqS1?=
 =?us-ascii?Q?GIxBYvq8OSiAtE57u92otjepUMULzLGHrT/E/RHZSuTJp4YrKBNbj0WGmiCF?=
 =?us-ascii?Q?sIUW0bPip2AawzWe4a+0Z3Ftu45VpE6/8G1KfDjnMtLzePrfxUm2V1/Zx3CL?=
 =?us-ascii?Q?3a3aDd61GAo/i7x2hSlUon/Vaqmbtb0xfNl5C2vNHtfo8JOFyG7Toav/3mLI?=
 =?us-ascii?Q?Q+pCKh7EIYbPMKPiIvFDOLtCKCTTvejEfSI3FUygx+4eJ8kHmx6f+Ssnh8oY?=
 =?us-ascii?Q?fBdkoCDNrcclVKpq7tOFrGptWUgvJnvs4LoPHRqd/2i7rrNqAYjaahpHjPb5?=
 =?us-ascii?Q?Mj0eL7VA1xU3wdAP2c21ir9YbCsZUFMgxrccg2lTejhe/5IhczaSc/fRoSBP?=
 =?us-ascii?Q?Q6LjC9azfMdNCK/EuN3stBExBv90BlWL1BDayzBeIovsDJrlEoJ1l2igx5j8?=
 =?us-ascii?Q?7ZFPMihZZyFzX+VLHw5hWhHeWHunFifRsspO9eGa8OAgOjiNRP2G0ANEO9sM?=
 =?us-ascii?Q?fIQU8ywl8WXhxDxpxgJvFLMVutEA7PIIoL5Za/1uLaI9YtJDZi2LW/3of+bP?=
 =?us-ascii?Q?2ABrb3JWJ42ZBFw6Aj25UK8XgqVk6b0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc8998c-1bd6-4a88-a05f-08df0a9d5a0f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:24.9705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djWC9A0iE8wnmZDA3eUC3cW/OA71ZL2Tm8fzBgY7PyRrQt1zYh/BgcrUO4aSG3itA9puCnfaOvSFzpVBr+X++PLzUHsRAuHDrKYtBLSZvAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

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
index cfba2990b6..8106dbb3ad 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -96,6 +96,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
     [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
+    [MICROCHIP_PFSOC_L2ZERO] =          {  0xa000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
@@ -200,6 +201,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
2.53.0


