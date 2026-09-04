Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7885DC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJU-0004OA-Lg; Fri, 04 Sep 2026 11:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJT-0004Nv-Gd; Fri, 04 Sep 2026 11:58:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJR-0004Pg-BJ; Fri, 04 Sep 2026 11:58:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8e+mlRwbYPYRebUziR0XUg4H2LS1vEyLHvi6nFw1bGcnQIAkkO11zRkuw0YK6Q4902UZiNXs+wPq6RR5EGDF0ZtAfqdBmJOvuQ9CjeUnWNAQjleanW1h4PcwI5Jx+01LQrTenHouGSNpJPd/Yes7iZG1+UT6s/PVUSuM7O7ekb6qXS1jf23Y+HAXWD/si1MsuWSuLaGQyaOeFBWQCJbmqVYKexE6JRZ+6jV72HJyEPR6c+oTK8gD1apytaopO8NU0doo6A249x5qpRqNiH5VYUFS1h+CvgWem+SbytjddZ8Vq7sinmPmhN54UPsTTnfh6uEilMrwP0QudLLxz7LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZLhfhyvCFTWqYdNf8kxpgruLTaphHdfTraBUZx444Y=;
 b=W8mnXPH1F6bcOMb+lbcK15alrDQfYhVs1efZSxOWmLE7M8PZbjqRyEmI0NxUIX3JD6T7whlSbnq/Stfkvf+1UYAKLDkIJRQ8zo+581TsLpOWlGYyjApVntkeH0dahg1ganvfLKPUXyoAgg9ypk7QDqm5iwikZKNR0CR6dUF2e7C7GLjUAx9WwKRztGHxhJHdmaIuy8LzWgW1nyyYhebWHEBlmgQZKH/ogCHvBCEengAYh0f3H/l9YrRxdWPQLRm5yL78XK3djqHpw9dDfbET6ldApdhJ4U0uLySmj16k+Ddj2sV3JCiaCgGxACIyIQNgzpXUX/zOSJV/s3O1LRwMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZLhfhyvCFTWqYdNf8kxpgruLTaphHdfTraBUZx444Y=;
 b=FlWMJ0tMXV3u9LM040Z+WczBNNDVEO7fEacR+GTXVyjytJado05DuaWqXINIt7WOX08ABycZNEDhtNZ4VMeus1v6BXVnBi00UABeBXwTrXgEPWH7w/nktwXy3H8O770sab0KPU2nhakmAFhxBCEt1lgkKp29t93kvCrcSf77QumQxAAuca1NRQHvwRmYOgj8UzO5VC9OFHgPiwSRfh5VjGaYWGV5Mlr5cTH009eW/kD9BC1JMi92JRWuejxFKtbMVt3I/XrqASbPXupX4XqMKMpjRSmG10OLLdQBJ9jhXY0xL17EQs8vGaIW78vSbaAVU2edbn8iSJEmefXBnAvtVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:32 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:32 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 05/24] hw/riscv: pfsoc: Couple L2CC to L2-LIM
Date: Fri,  4 Sep 2026 23:57:24 +0800
Message-ID: <20260904155758.3833179-6-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 705bf99a-7131-4184-b8f1-08df0a9d5ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r7IGd/6i9WYRPUh0lWJh7sywvfCpxtTqbmy8Eo4cxEkbYZtQDjQQY0RdKlSqj3S5MAZ+fHsDb4TIHmmQ37eB0oOgdSHO+oJlLczPU93EZJT1wgmkguuuDvwHHj17oeGwxZH2yOXb127H4D7LW1hfeYH5sghVHerMGAhOZQ/5VNODc2/XN9gsoGj4FahSBUk98Bmyo3hdvE18Ys6xCbJE/KgYO9VLN6DOcIpCsBlGMgh5Drnq5moSM29Dfg4m8NcBlzmTEOM7lu6TemRiX2PvmTgapRcAGsDL0IsxtyFhyN1tpUYTMQFBcdW2RUliF4yPsrSx/5rvivSI6JFLoMCg5ktqqanPCw747D68Jwj2TZTqwsvaDIH4Vy02pP3xO+kAu9aKp1C7rgzDj11FfpasKcqyv/lz7vpHAswZ9FZa7fs71RqyJOc8jozm+euMxJArwo7/4BkuLkP80l1pbX0mQHRqYTcOCbP2iAW1E611npd0j68bZZmVEbSgl1cRGwPkpdIEKLTewz8royfkvyDZCqugMAydoXzgizDrCVIkQvoVk8ygs5Lq8AAm81C30iAEXRjewWoIXuY/svNU28AM/6X1RYQqIcLQFCcfXjJSYG2rqEW4M/DG35A98MlK5+Iah5b2y4UoI+SQNxULkAndAKyeAgIrRKRUUbcIIDrTX2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89PXeqGG5EUp2u3km81hvugVOaMGrf/bBtmDuOER5clj68te8szvgo4p4UuZ?=
 =?us-ascii?Q?uMejvksyHFU1xy3QYVsheKsS60zTbvxHWaBHkMWi4S/CSC5qj1BNehDPPznK?=
 =?us-ascii?Q?2qTY91apAXAFSrY6F2U8xsmibUwbBGFg7+VpeTADmv02Eg39oB6kRgY8263d?=
 =?us-ascii?Q?9tt+trsresQL09Q3pXerH+P+c8zcy4JCMe2N+IQsu/wWtyG8yjDxBEpd98QK?=
 =?us-ascii?Q?Y5CC2Ngl0kQooBsymszodBBvb2Ygf9k5xmrdL5hgw+WCdcRX+hvdc+KiVw4M?=
 =?us-ascii?Q?uGCzYqxi1JV7LETrBGgL1lbHzcEb0Ice3yRPXmIirOv4rZdmZKAEUBuDhMY+?=
 =?us-ascii?Q?snSJNEkx8T6buIWHmXhKMEIbmvhO2kCS/tb3MYOBWsgGXPEg/i2G3kKobGSV?=
 =?us-ascii?Q?DWOoJRvRgpXMaB8743a3PJw55Tuqrd7MvpnAr9bM9cmPc6DDk6gcI1uBTBum?=
 =?us-ascii?Q?ET5BQ0PZCAaOf/7Sj3KjRbgXAi1lTLrGF0zavC6fSuIzHoGur/V3ZeZhGAZC?=
 =?us-ascii?Q?zcIsp3irufW02HKgVvZC3VtxsroAWGyIy7UbpxrdA/PVj2eDuho9IPFh5yLM?=
 =?us-ascii?Q?36Ey5VeE/Mfpw47DaH2NiPOtB3IeMdU/g+rpuB0/jITzoCGhgljGP3185Q6E?=
 =?us-ascii?Q?NQ74q2B/R4cfg4hYAmM1BttEgYPpIbz5qsf3TQFy7GaBoJ347wEvFoEwLY6u?=
 =?us-ascii?Q?eWPecNAJLncfZRPRB+81SEk4GGa/x41RQOFSanSdjshB1NJHBapHVziieIaa?=
 =?us-ascii?Q?SocfDPzxWACnrQmJrWQbvDi02mlf2Sg3Pl4PWUHfBf6VMHbcJ0ReDy/ie7T/?=
 =?us-ascii?Q?JFGWjKcWGzeT4y2HxkcA/C15UxvV0JZU4wfqVjLmAMn6sxq1lihuQ1AEjA8J?=
 =?us-ascii?Q?+q2+OPVB5XrG+sPe42/RVbIv8mgxNkEjPA1fWJ39HV12TDm10zP0PXuUsxkm?=
 =?us-ascii?Q?J/XtGuGgd4RDinKMtBxLRlyjkfYTKaG/nchX42WRZZS+Gud71WnLgad/WvWj?=
 =?us-ascii?Q?LwyTjFFq0r8rNPLsdDYyQx2IVYibPq8w4vR/0/dQum7C/5YkH313W3jjPVLb?=
 =?us-ascii?Q?Mj3oB1Pwrd+wbbdihA0XvUS1/TTreG1GjWpQ97QqN7AYkvBLIaE7BRvm+hKP?=
 =?us-ascii?Q?L+4pqXg3teMQS7bEegx6u0ccV+JvmXG2pPGqAVoe1A5HcQ4vplBXmnHZRcb2?=
 =?us-ascii?Q?0cWAmUDR6RHmEsCdjHVPv6AIe/cWlrw9TpWtb5D01sSBbVLUCj+zIHWoetN3?=
 =?us-ascii?Q?lDpKrMHJnTuq5d6mqpvRJDuJmhtiSwg3Y4LmNCiY+Qab+/daQwpctihcanWd?=
 =?us-ascii?Q?b+E8MmOrs2eKDEDJmYzfiCgpLsXAewWCx8iglH6zB1rqMCVb2LjHk1L3dLDj?=
 =?us-ascii?Q?C+aHhYB5YBP4h4qPpq2QDM/5ea/S4w3YoEUo168tLqvpop18j6EZ89Wgxanq?=
 =?us-ascii?Q?LIcIjRX1U9nmICYw9AzKP4VpaVfSFwpsKM+fdZbKaxyUazgvMa1Jk8O2f7dq?=
 =?us-ascii?Q?fqg4AmZGT5x1faJnmbm6OQn9QjklwTj2iXQzdA2T01fsPSSSwATNcdaUxEi+?=
 =?us-ascii?Q?KTDf6UZsuzVODnXgez5mDwun06gy7ipKSZw9h12yRLqJCLWnJDfDHUMtzjDP?=
 =?us-ascii?Q?s2q8+bmADJaUw5V7mjLdKLxTg14PdDaan3PJx9ELGeZ2MmU0kQFI+Fupx400?=
 =?us-ascii?Q?XZaIADF/A3ukZ5ELC7tme6Kj0EbEpuiPZi/QKn7d+XRTdx6iCK4RRTmvY0IB?=
 =?us-ascii?Q?L+/EraAnovSyiC15tz6B6MfZzbMwngc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705bf99a-7131-4184-b8f1-08df0a9d5ea1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:32.6139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb3qP4KD4nsm9mqb2bnKJGqN7VtLR7HdqER8dbLpR8J2SDfHXq2z/XV7CAOIjRMp5+9rjdI7wH4lHNMg2CE2j0lbPvlNK71iItD6iqPe16k=
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

Instantiate the L2CC in the PolarFire SoC machine and connect its
WayEnable register to the L2-LIM MemoryRegion. Back the complete 2 MiB
aperture and shrink it by 128 KiB for each cache way enabled.

Keep L2 Zero at its fixed aperture because it represents a cache
allocation window rather than the remaining L2-LIM capacity.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 include/hw/misc/mchp_pfsoc_l2cc.h  |  1 +
 include/hw/riscv/microchip_pfsoc.h |  2 ++
 hw/misc/mchp_pfsoc_l2cc.c          | 51 ++++++++++++++++++++++++++++++
 hw/riscv/microchip_pfsoc.c         | 23 +++++++-------
 hw/riscv/Kconfig                   |  1 +
 5 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_l2cc.h b/include/hw/misc/mchp_pfsoc_l2cc.h
index 1b5b3888d5..3a175a6340 100644
--- a/include/hw/misc/mchp_pfsoc_l2cc.h
+++ b/include/hw/misc/mchp_pfsoc_l2cc.h
@@ -22,6 +22,7 @@ typedef struct MchpPfSoCL2ccState {
     SysBusDevice parent;
     uint64_t regs[MCHP_PFSOC_L2CC_REG_NUM];
     RegisterInfo regs_info[MCHP_PFSOC_L2CC_REG_NUM];
+    MemoryRegion *l2lim;
 } MchpPfSoCL2ccState;
 
 #define TYPE_MCHP_PFSOC_L2CC "mchp.pfsoc.l2cc"
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 612fd2b69c..0aeccedf77 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -27,6 +27,7 @@
 #include "hw/cpu/cluster.h"
 #include "hw/dma/sifive_pdma.h"
 #include "hw/misc/mchp_pfsoc_dmc.h"
+#include "hw/misc/mchp_pfsoc_l2cc.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
@@ -43,6 +44,7 @@ typedef struct MicrochipPFSoCState {
     RISCVHartArrayState e_cpus;
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
+    MchpPfSoCL2ccState l2cc;
     MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
     MchpPfSoCDdrCfgState ddr_cfg;
     MchpPfSoCIoscbState ioscb;
diff --git a/hw/misc/mchp_pfsoc_l2cc.c b/hw/misc/mchp_pfsoc_l2cc.c
index 979d904676..4b87c963fc 100644
--- a/hw/misc/mchp_pfsoc_l2cc.c
+++ b/hw/misc/mchp_pfsoc_l2cc.c
@@ -11,6 +11,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/register.h"
 #include "hw/core/registerfields.h"
 #include "hw/misc/mchp_pfsoc_l2cc.h"
@@ -39,6 +42,25 @@ REG64(L2_WAY_MASK_HART4_DCACHE, 0x868)
 REG64(L2_WAY_MASK_HART4_ICACHE, 0x870)
 
 #define L2_CONFIG_RESET         0x06091004
+#define L2_LIM_WAY_COUNT        15
+#define L2_WAY_SIZE             (128 * KiB)
+
+static void mchp_pfsoc_l2cc_update_l2lim(MchpPfSoCL2ccState *s,
+                                         uint64_t way_enable)
+{
+    uint64_t l2lim_size;
+
+    if (way_enable >= L2_LIM_WAY_COUNT) {
+        l2lim_size = 0;
+    } else {
+        l2lim_size = (L2_LIM_WAY_COUNT - way_enable) * L2_WAY_SIZE;
+    }
+
+    memory_region_transaction_begin();
+    memory_region_set_size(s->l2lim, l2lim_size);
+    memory_region_set_enabled(s->l2lim, l2lim_size != 0);
+    memory_region_transaction_commit();
+}
 
 static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo *reg,
                                                      uint64_t value)
@@ -48,6 +70,14 @@ static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo *reg,
     return MAX(current, value);
 }
 
+static void mchp_pfsoc_l2cc_way_enable_post_write(RegisterInfo *reg,
+                                                  uint64_t value)
+{
+    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(reg->opaque);
+
+    mchp_pfsoc_l2cc_update_l2lim(s, value);
+}
+
 #define WAY_MASK_REGISTER(_name)                \
     {                                           \
         .name = "WAY_MASK_" #_name,             \
@@ -66,6 +96,7 @@ static const RegisterAccessInfo mchp_pfsoc_l2cc_regs_info[] = {
         .addr = A_L2_WAY_ENABLE,
         .rsvd = ~R_L2_WAY_ENABLE_VALUE_MASK,
         .pre_write = mchp_pfsoc_l2cc_way_enable_pre_write,
+        .post_write = mchp_pfsoc_l2cc_way_enable_post_write,
     },
     WAY_MASK_REGISTER(DMA),
     WAY_MASK_REGISTER(AXI4_PORT_0),
@@ -157,11 +188,31 @@ static void mchp_pfsoc_l2cc_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
 }
 
+static void mchp_pfsoc_l2cc_realize(DeviceState *dev, Error **errp)
+{
+    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(dev);
+
+    if (!s->l2lim) {
+        error_setg(errp, TYPE_MCHP_PFSOC_L2CC ": 'l2-lim' link not set");
+        return;
+    }
+
+    mchp_pfsoc_l2cc_update_l2lim(s, s->regs[R_L2_WAY_ENABLE]);
+}
+
+static const Property mchp_pfsoc_l2cc_properties[] = {
+    DEFINE_PROP_LINK("l2-lim", MchpPfSoCL2ccState, l2lim,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
 static void mchp_pfsoc_l2cc_class_init(ObjectClass *klass, const void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     rc->phases.hold = mchp_pfsoc_l2cc_reset_hold;
+    device_class_set_props(dc, mchp_pfsoc_l2cc_properties);
+    dc->realize = mchp_pfsoc_l2cc_realize;
 }
 
 static const TypeInfo mchp_pfsoc_l2cc_info = {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 8106dbb3ad..114567867b 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -174,6 +174,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "l2-cache-controller", &s->l2cc,
+                            TYPE_MCHP_PFSOC_L2CC);
+
     object_initialize_child(obj, "sysreg", &s->sysreg,
                             TYPE_MCHP_PFSOC_SYSREG);
 
@@ -260,18 +263,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
         iks->clint_timebase_freq, false);
 
-    /* L2 cache controller */
-    create_unimplemented_device("microchip.pfsoc.l2cc",
-        memmap[MICROCHIP_PFSOC_L2CC].base, memmap[MICROCHIP_PFSOC_L2CC].size);
-
     /*
-     * Add L2-LIM at reset size.
-     * This should be reduced in size as the L2 Cache Controller WayEnable
-     * register is incremented. Unfortunately I don't see a nice (or any) way
-     * to handle reducing or blocking out the L2 LIM while still allowing it
-     * be re returned to all enabled after a reset. For the time being, just
-     * leave it enabled all the time. This won't break anything, but will be
-     * too generous to misbehaving guests.
+     * Back the complete L2-LIM aperture. The L2 cache controller resizes
+     * this MemoryRegion to 128 KiB for every way assigned to L2-LIM.
      */
     memory_region_init_ram(l2lim_mem, NULL, "microchip.pfsoc.l2lim",
                            memmap[MICROCHIP_PFSOC_L2LIM].size, &error_fatal);
@@ -279,6 +273,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 memmap[MICROCHIP_PFSOC_L2LIM].base,
                                 l2lim_mem);
 
+    /* L2 cache controller */
+    object_property_set_link(OBJECT(&s->l2cc), "l2-lim",
+                             OBJECT(l2lim_mem), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->l2cc), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), 0,
+                    memmap[MICROCHIP_PFSOC_L2CC].base);
+
     /*
      * HSS decompresses into the L2 zero-device window and executes there.
      * Model it as RAM because QEMU does not model the backing L2 cache.
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..85b535c7cb 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -18,6 +18,7 @@ config MICROCHIP_PFSOC
     select DEVICE_TREE
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
+    select MCHP_PFSOC_L2CC
     select MCHP_PFSOC_MMUART
     select MCHP_PFSOC_SYSREG
     select RISCV_ACLINT
-- 
2.53.0


