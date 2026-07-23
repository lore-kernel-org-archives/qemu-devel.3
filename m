Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7002BC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvCx-00046e-Ss; Thu, 23 Jul 2026 11:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCw-000468-Rm; Thu, 23 Jul 2026 11:19:34 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCu-00081v-SC; Thu, 23 Jul 2026 11:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIyBlRxD7Z/vzL1cjoP+8oWgbfKeyHUEC4vsJbaQL8GeuAQD5txLRRlnZiTkfUW83484hagkl8Tf8TgB/mHiQ8ZAstz8BHHFRUgghyC0H43BaN6g/h6V9ZRR73C8od60qdptXFYlKEzp2C91+PeVO0gzEQZqq8Hta4HxhfVkXLhUsoz/f4mXEQEynlX8kbfagG7GDTNiu3mw61q4pe2sO5X7u7lNm4tuxW3MflhElSdcX6cR8WA7F2oawLX8+voi6aAeY1/8gz2wO+HMwO6c2sfqGQYMgmIZB6SVIUgACdMbyhafbmNZ8uh788aNYTbDHoTIgQjmD2LfVMnfB6NofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFzrRGxHaFmnCV5Vflq4Sd4iOXxEK8wqJHpvb8aBwIU=;
 b=bxt5+JcFCDaH6k55/KAjiMg1WGOpK5G9pFwUIQARZokbRTjGCbZeDzP/TwD1O7UJz07KDW4T6TYRFJ259us+zTt4u60Kwrw1W54/2snnT7XXNL8B6ayVu38f9rnEZ9cuKH9kshbu0q5x+sWX9Ba2PC3veYWNEnVJZ2rr5ZNcs6S9tFI676jCiXuQ9QUgX5kdhTFcsafaG+uoLCqOmYLIbK1/uaTiqm10zhd54oQHmViARk8Q2f9RZ0QgX53jVhKRgMsYWOYLUqPFBSjnnTGD57QSXna6zj3tBPUHTyqDoQwVQ62pvqc1YW1VUhbSdOj0acxVzbO7JohsvoFprFuIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFzrRGxHaFmnCV5Vflq4Sd4iOXxEK8wqJHpvb8aBwIU=;
 b=Fr8Tz5Lz2DdjPLn4A969q/j+da0sVvNTaHkU6yIebdQGSbjxPfkR1jjf5VedWyKFUPOEl892sVRkidnogJMXSLW+JaDR33PlthUIbq+jNa8mz1WMdfm20aslsFfnFhlE1MEpWSiH/1rFnJlqMgb2/KuFeBHD/AZtAmhr72CLJ/zj8biMuBUNXDbCb6R/a1DoieRHQU3/G7OcmIKxJXdGsX30vwTi9W8e9tQSOzku6eCPlOi/DsjrlQKM6KAfJccq+Huh+EMFsDj0okRX+16dTJqXaVieHAshqzmuhqo7pBMGc2ekdfmalESfs50ITNIHo50y/lB6RADb0dwr2OaD2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:21 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 05/26] hw/riscv: pfsoc: Couple L2CC to L2-LIM
Date: Thu, 23 Jul 2026 23:18:32 +0800
Message-Id: <20260723151853.2143177-6-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71df33d8-d56c-45bd-f8e5-08dee8cdc536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|7416014|366016|56012099006|10067099003|18002099003|22082099003|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info: HI91bvcoG5pigb62b1U/5OOsE8cpQ5pZG41bnqtjHpcsBz0Rb0NiKlVcxuzPB0Cm86ODcyOtnQd71z0oDaT+YpPwgw4qoNpft9JipSyDaZFUEnq3Vsr8eiNUsXy91aYpEbmjLADdY0RcuVVghpItiS//AQ2qt8r/yLVK10mEYtwoP5CjiAKGaxZUJSwE/guK008bFv5b5VR1PnKtN6eHD29MMg0H1fPJdCPvUqmbAhsqmqot6VcEQA3HX3zr0uh5HQAojN7m5XYE/5Pmn3wxMj1Bzft8WvLnkU0Dfbli2pgP7VCX1HeByzLu+ZXFfslpjAyATeghv+yXDGWZtcSOo5EDYtISKZJcQbD853cYKlgB8WB2c6RFR1u/LkNCxvJMqq8SfbwENcjyD6ZYHV74fOGcQdXejoPcYjcJ8Po/Wowh6tsaAlnTUtTxOg3APcuP/m0iOh5qYZRhfQRtcVORBV+b+cTePc1QdWiUPkDTQFiEO7qLn2PJbKq8QHlE+pJBtzxL3K9kp7xNltl+fyIGbp6gABMOvZPRivn5XXxfkv5zY713VMdi7wJxIK1htnOCr4WqWGr10Ixk6PvM0cZmnNHFXAAgcmum+jlNtlkC5tTIVxE/checPryBzQnrw9Ql0f20uzACbBVUIK0gagajSWIjCewRFu7J7qY3iWgXgbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5XVBcDQ/9MCq+09WRDX0BAHWOiJM9gV3Ftb1OdE1yaZ6gI96UYgdbdSf90X?=
 =?us-ascii?Q?tbf563/oLALN43BTeFWdyncKKJCj6AmsVy1uaHGlvCTq8hXyqZIJ157/9/c0?=
 =?us-ascii?Q?C6N1jsD3/wP04CfXe87hQyvnhkN8XNS13eKxT5Z/WNUzB7Xe5Jwu6mDzd9ec?=
 =?us-ascii?Q?Csy74aqFKYSWFfUQNBZycebJKfg5P941i1taPWRLWLwD1jPj8UnKfAl482hn?=
 =?us-ascii?Q?GsYsI58nBww+4EiAMiI3hrXS5kGZY0pQjI0Sq0yL+37uv5Fkt28V7e4AmfZF?=
 =?us-ascii?Q?COy/y9Idb8nHrQxyMwwUuaasZmM0o+VCNK/7/tTm/zQknIqUhsLyzCTtBPzs?=
 =?us-ascii?Q?mHi8RgVANPPw6kxJsVQbrp8L3QC1RRxTaO4dVGWFjlGY+Uo8K+uwsMtUi0pj?=
 =?us-ascii?Q?vrlPspbnlMjQhcMeUdI/alupvqmWUKa2b08IRbqWzz7iNubC+wsQNbetDoOA?=
 =?us-ascii?Q?VlYnKN67wE1JWjnQIS69ooBgwQ6pwm0FMhz3T5ac3kpNkWDXFlsu45IlUMZy?=
 =?us-ascii?Q?9csDLV3VNZYBL/m4CyQ9YbCoKHB/juOOKRPoN3IR/AZ8KavmiEVrxZEgwfZd?=
 =?us-ascii?Q?PKsEy5bmoc92jhfgsTZJ8lDiorrZ3U/Ps7zSwAWROh+3+TuvQu5+xRKsdp+O?=
 =?us-ascii?Q?e7qscOrczMtg2rYQt7JfkyJhII3RRTVwfSoeJMcUzJfaXanhyqmAWmIaqUMn?=
 =?us-ascii?Q?y7W7seCk8J/01RcR2U7oOtIvWSn+2b+YL4MRvYb0xSN97JPAqHhR9L29gwwm?=
 =?us-ascii?Q?pOyg2vtwpgGoWxm64oAuWgbN6cgi+1M9qjAioCLZPGdpArci/3RGhpKmlnwd?=
 =?us-ascii?Q?ASYQMyGh7PNcXrl94cL03vHpeuva3e6oK27cykfuUV15vb+7/hDfyF7vPujO?=
 =?us-ascii?Q?pwyZ0JgkGI2Y+JEZqqFRjB6Sq0K8/3Q1dNUwaFMj19b6sqjzZ75+L44FzUuO?=
 =?us-ascii?Q?LmCdCr7W53uA1aMG7DY42aGCDqCzOworsSxKq+r2MWR8uOPmS1Rf1JQxT/QB?=
 =?us-ascii?Q?01+hPe/xFoNOYzbOtiuIsqhJAPMbwo5dgIK8ahGXX7wvCAjMCmXg6ooPRSIn?=
 =?us-ascii?Q?cDBUagmX8tWHvDKB6sptZV2fFMxxnoeX9DIxD1a3hXojxgEd/AIiP7WkywXM?=
 =?us-ascii?Q?miYUSo/+bQMTfgW5II+TmSbzSzRasImDjwblEUYUXFf4lj9AwXFTHdVCJWZf?=
 =?us-ascii?Q?1KofLMWMtdGWifY7fZG/ScRphSp7t7O2bwWT5Wayxyb3CfknaKDmWfszPeXR?=
 =?us-ascii?Q?dJ3mgcc4voVv9S9iSmXvcnQLqINH9n7JwRDlMFACJOjuE1A7Sncimih73alU?=
 =?us-ascii?Q?EVztUMfj0aPSBR9QkMEz6qeRECbnNtISI4EpPuhUjzdFCBe4DsWD9r1QbR27?=
 =?us-ascii?Q?tomDM2Doy8THvv4ziscicvrTGZOMelHmGqe9KkDewi8ZXz7m2rDbek/lMmeY?=
 =?us-ascii?Q?zUWA/AvwC/+8Vb2FZOXvj4gAm1Gg48oE7LUY4Wgcs+kwwQT7LQYoQ1GEL6Ml?=
 =?us-ascii?Q?sx4UET6mdpFFz4UNBCyRfQgu9sEeovGsN7v3oGk4Rhb0eE8SdJyH26g5VZ5Q?=
 =?us-ascii?Q?kkgCZS0I11eeHlNa9PyDhnbYB0TZFjc277I5INc2tUqGVJVdEYXD04GgyvqV?=
 =?us-ascii?Q?8yiw8xj94BxCZ8NWHkCMtMEV8FP/wAsS2fhLkytnaZ7ddcnQGYPaMdHGwqId?=
 =?us-ascii?Q?LgOQv7gNxR42pY2nvhvGlNyJij8o+XG8htJz7REb0oPSHBOPIPff9LeZKoKy?=
 =?us-ascii?Q?lGj/RB/d4MESwMwj54HVBIaJzA6ZGzs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71df33d8-d56c-45bd-f8e5-08dee8cdc536
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:20.9638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO42f95U4Tek4cbo6fMacZVVvLwZQ1DPw8MZpG52lDYWeKtaHeY7uT2hxJg24AYfOtpMmwm5NsffEppl2F3GgV3FGutDX3bbqr2XDbECLGo=
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

Instantiate the L2CC in the PolarFire SoC machine and connect its
WayEnable register to the L2-LIM MemoryRegion. Back the complete 2 MiB
aperture and shrink it by 128 KiB for each cache way enabled.

Keep L2 Zero at its fixed aperture because it represents a cache
allocation window rather than the remaining L2-LIM capacity.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/misc/mchp_pfsoc_l2cc.h  |  1 +
 include/hw/riscv/microchip_pfsoc.h |  2 ++
 hw/misc/mchp_pfsoc_l2cc.c          | 50 ++++++++++++++++++++++++++++++
 hw/riscv/microchip_pfsoc.c         | 23 +++++++-------
 hw/riscv/Kconfig                   |  1 +
 5 files changed, 66 insertions(+), 11 deletions(-)

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
index b320356572..7f3c2672c3 100644
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
@@ -157,11 +188,30 @@ static void mchp_pfsoc_l2cc_init(Object *obj)
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
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, mchp_pfsoc_l2cc_reset);
+    device_class_set_props(dc, mchp_pfsoc_l2cc_properties);
+    dc->realize = mchp_pfsoc_l2cc_realize;
 }
 
 static const TypeInfo mchp_pfsoc_l2cc_info = {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index fd28ee75fe..248de4d022 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -175,6 +175,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
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
index de37c08cae..22619481e4 100644
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
2.34.1


