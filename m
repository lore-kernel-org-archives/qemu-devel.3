Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8222CC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tI5-00005f-H2; Tue, 08 Sep 2026 06:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI3-0008Sm-OL; Tue, 08 Sep 2026 06:42:59 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI1-0006YC-Kg; Tue, 08 Sep 2026 06:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU380hjQKAexZR5KND/7YJwLU0JMmddP2trP8p2u8pnyQspZzdzlJGDU6GVzA5mQaz9IhERqK7JHvZDuHuD2HdCrnwmH29zrMhQaYvJGhg5Wh3UUoX38vOFCJj/Q+0+u4WtIE3beSqobR3xk5ZFBHZdIhPIuImzV0bHDB2DhiuORrvKgW2pMWOEUgRpJ3omO1vUjTMs9ZDBoN6Vf1vIB3d+28v6xn1/v+EHIrz/BQbXlOjwkHeM/w7iTXD8BbAsgFVyaF5fvCGxhoRPZeCKtQwdrjmdUHGzPBDwrIenT0jl1VF9jIETltjavTlLjTWtZ8Wi5QoDKZ3Y67x3whE58og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWjNHOzWk//HJwjZrLUuv5T7d2ZHeC7G7QUjM1TQlqI=;
 b=dsDjSRQwmat+3TsqQDXpsgceEMQ3+3JPt1Em9tlElXn6jFBhm5nLdaJa3ZfAeD6Ro0l62dp3v657NuEKlUXtoZuB38m0Yy/XrVjT7g57Int8N2T+Y6HZzeB75pjVxJwZb/FklHDVkjArYxCLI5pnN8Z6sUu0hL97q6AdIOYCUP1ZbgSnfUcnXfjbxMta86v8KY2gopkoUGlwA5cXxVbdWjWxzHl7Gokml2tzWTdUhrgagqMjam1uHkCmdphxpszNvso2zxgWfe17eLvtnNhbU4Kna8ddRwNHMO7DbOUItnoLW84PFa3bnF0WJR46iUYkPz3L6XbYFruWviuskPuWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWjNHOzWk//HJwjZrLUuv5T7d2ZHeC7G7QUjM1TQlqI=;
 b=A2/Sy78WhZlZVrj06+P5OUitt/irTdI2qwHdg0P+mILEIcee6cWk3jTiNmBRaUBRcrUi89DDnPHxKzSBlbngKVtlf4Mb9wbSDt3orL0AEpnxNr2YSecR1ZrR9U8ub5gus4gaA61mwywMS5pEcaE6fdGugWW6M/IQO2hrRBKSqqlvCNvF0wdzLBtlA3Xxx93V2TvfpjB9fjXYBxR65DjxCFNi0wrGQwXJ0dH4nwg8QYgT54VetY0/dv+HGXwq6Ohlq43Z2Kje6uT6Pct2uqJSZmoTQicMFapqAPNiZbvjW90x8rmWG3l6caaMCaT95rWbXnK+ynyq4OkiyDBa7tWEQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:42 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 15/32] hw/arm: phytium: Integrate the Phytium E2000 PBR
Date: Tue,  8 Sep 2026 18:41:24 +0800
Message-ID: <20260908104159.1621764-16-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: d3184fc0-9e11-42c5-2691-08df0d95e8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5HtmY0Bzej1d2CFjN4aN6e5clQppHB8PSodCVYmYzjtOkIhE913Z7ew7J2ChRp3hV2HK/kFyGFNRXDuWfjAQx/SKUWuCxqnM5U5L5aNUt2RXuVkfv1HUiT21NAoNK+yC/vlqVge6DT2nHbu0EHS1OlCVIMduX9LFg62O5awMK8UrtgpOUUc1zykmTwqVanF8dgw/Ohp4OzzCtXCjSMfQk7/ua/bA3Wp+F2tIIjDW9S+pUe7E7xtmEQK+bYRqNliOZ8Vxi+gE57l/X7zNqdIyxgDhESuzQxVF2zAOKM9WUeM+gpXO3oJcSkReWCcEDJJQYdQlKNvJgMXso5SnmBfhrM/qZu1YRXKnHmVyiETIgR5/8yheJcLTuxrH+fBsej/8mQw42MBygZNvJBwCgWNo+bWVGKVEB2hCyv3ZJbNDz+rWu9+WZ0qlm2jRpv4JAxOA4x/YWchqDrRg24IhAOoCddUuN5+81k9GODFmdr+VwmXt+nssKrv4ejwQVi8c1hTb0ihPbdOh0kfrM50QLtSAPnCcLlhO/K2XyXwGEDlsQgFiH6Q2qd6+HNj8xBfJT8UfRv81iUWL/ifdMYZ/Vm91LmLCKD2woUMxnGY+HZhJD5KqhOcfVGKa/Kc8ugkiG8ABbgGY/GNPmseFlrWyzLaDruvRymMXs56XIKmMiXPurfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2wn0iwvhdigIde2TeSzB65sLlve6aiv8Lm+17lZsi8JrdhNmU//MotGBXe8?=
 =?us-ascii?Q?h/6+r2QFk/03wdB63i2YUC4QJAA7QFB1TdN/gVlkFtJpuApjj21WDzABFHiZ?=
 =?us-ascii?Q?F47m+xtvqTa17Zx4K8z+gS/oaTJw+rwbInsl7W2KbKMmiZ3j3NMJfdEgjMiV?=
 =?us-ascii?Q?JExXtA8DlhpD4YwxHMc9i4t+yq388Q2zuCOsPYT5fQ3FVwsU4YmcUngFsSsd?=
 =?us-ascii?Q?AWX3JWr/wJBJS3rKeD8WW1Q2cRSceCYOrejf+jShuJYuZDFXnaHUmj7xLZ+7?=
 =?us-ascii?Q?tzF5T+8nmbtFK4cZmYNdoD31bJ8tpO3rtWLfa1zCFNrQrczvR5Wd039WRy2r?=
 =?us-ascii?Q?9V0tqt/WikWRgOIS+WTWRCbA0inqmc0I6+ihjwP+wRYbTvD8oPtcKwdX7+lx?=
 =?us-ascii?Q?IYWVpleeGqTTsDc2bil5MFSXCjNcbYLfkM+2bMHjg0QdhOSOCHKr5EArzkOt?=
 =?us-ascii?Q?OcHnoEY0UN6JxWGlHXqgo23TmzUtQekv6RP/v3iH13JjEstefThWA0P9eXiw?=
 =?us-ascii?Q?a+zVbwgQkWvUC0FhtGuexWlvAS8xRh8vSayRBprXIsIbBoxP+E8YCVtRq+Bi?=
 =?us-ascii?Q?nmMK9QtMTK2oNgesBuDVxWnBGaqli1ZO3hbCHoq1XvQNjjq6e7IBANiDpy/Z?=
 =?us-ascii?Q?1YjTenSOGVzpIUBsA0mhfNjhu2jWM8ASjcfOppG7ATtFGcg2R2AkHIdRgXuf?=
 =?us-ascii?Q?DXnnUEN3EfB9zkgewEZ6Ch7FpJW3wH17s87wUMv1pAhPDJoDstVygYN2+/Sq?=
 =?us-ascii?Q?B1/gA+wikVKEjpJiKRL7PfHhNMBZUMtDPSIjnaGDw6QSSwDoL2fWyu/vrdWI?=
 =?us-ascii?Q?0OP0WLhD2wKl9M/dW5XHyJIYXjP4CmRedrOtIrChPd+FTDrMc+cKlJYGZJqR?=
 =?us-ascii?Q?4+GanRz31LNSadTU61TDQfx+xIwZz1zBotuUBhHTwNLVJXUUs4631do1rZgN?=
 =?us-ascii?Q?W2sl87wxtijsNbnDRBTfC1ZCgjd8XHFe4cyGcW2f5Eb3R8/+7DXCUyFQsMed?=
 =?us-ascii?Q?XS/iajeQ+9uHaIjoeXqhYv6GmKC0Ss++vJ4RuezSzYgtI5z3GtEWcrCyOdGo?=
 =?us-ascii?Q?2n8EpenqRfQoy2kQjJz/3ZSIfpZkGKejLfTgEAm0DiXz8rZKuQS+kJfG23It?=
 =?us-ascii?Q?ILb+VnUQjDvlvfbdwHCHaOll9QidrpoZsxSq3bpxMItOFTJ0VuwSOHPU3vAN?=
 =?us-ascii?Q?CEwMYp1HfT+RX0O3v/RRaNd2SY1/ZgpO3zgahccVR1EUzChR5Kjy9Mqjr5t4?=
 =?us-ascii?Q?xoavUlHyqlTxKZ/nRoCDeiRY1bwxqNnjL1cj/FwsL2mkHK/1RoITm8DrE7hn?=
 =?us-ascii?Q?RytCC30I4bKrzhTkU72WIaQPrdv686kHDAkPtj7VIkO1cLCMUqx82BvZgAUi?=
 =?us-ascii?Q?sDquKR77XEuyDrADEeSeZAqbubK+SPDU+kp3dza09xkPltGUKqoYtPn3w8Ke?=
 =?us-ascii?Q?IW+J6ayJ5c+qIZ2hs3Rrv9egpLESinppPHaT/0bg0Yydmj9zeKN56veCDPn2?=
 =?us-ascii?Q?1vjeP8hDqvBYfNj6DsfMFNyJyGV0kt1+yzQ46Igx6oZD+QU9n/EIZgb0EYnm?=
 =?us-ascii?Q?yBammfYPb5OnN4AEqH8/E0t6+aTZ2Zc/bqfQTJNwW7iusy2/7xWdZZ9B1mww?=
 =?us-ascii?Q?xmicdJzxxAlE7osrtthXsUvw0aONxC4UgwdXIbppc6bbZWE5TP+Rz7C7jpe4?=
 =?us-ascii?Q?w0JVmSZ+60914HdjztW+gJPvDTWrZubhBu6vjHyjv6ZjuIc01furKTWxuslI?=
 =?us-ascii?Q?avobeS4W1EqiK/O2cv+l4m1srr90kiA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3184fc0-9e11-42c5-2691-08df0d95e8df
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:41.9158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSMG88qeEDR+yNaLZQBVsZopWQ+ri3VxPoHNO81bTVrN7LVv3gJqXvotnLJ4XhjR3zcFJbwKGFWdGymUlqZGk3FPrdAX/pp6G49jSu6tL2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
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

Instantiate PBR in the E2000 SoC, map its status and boot memories,
provide the heterogeneous MPIDR topology, and connect all SoC-owned
CPU objects for reset-time handoff.

Have the Phytium Pi machine select SD0 and pass its board backend into
the SoC. Explicitly reject unsupported -bios and pflash interfaces.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Connect PBR to the SoC-owned CPU children
- Let the machine configure the SoC-owned PBR backend

 include/hw/arm/phytium_e2000.h | 11 +++++
 hw/arm/phytium_e2000.c         | 74 +++++++++++++++++++++++++++++++++-
 hw/arm/phytium_e2000_machine.c | 26 ++++++++++--
 3 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index 92b39129ba..6199bb7b5c 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -14,6 +14,7 @@
 
 #include "hw/arm/boot.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/phytium_e2000_pbr.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/phytium_e2000_mci.h"
 #include "hw/ssi/phytium_qspi.h"
@@ -67,14 +68,23 @@ struct PhytiumE2000SoCState {
 
     DeviceState *gic;
     PhytiumE2000QSPIState *qspi;
+    PhytiumE2000PBRState *pbr;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
     ARMCPU cpu[PHYTIUM_E2000_NUM_CPUS];
     MemoryRegion scp_sram;
+
+    const char *pbr_boot_mode;
+    BlockBackend *boot_blk;
+    uint64_t ram_size;
     unsigned int num_cpus;
+    bool firmware_loaded;
 };
 
 void phytium_e2000_soc_configure(PhytiumE2000SoCState *s,
+                                 const char *pbr_boot_mode,
+                                 BlockBackend *boot_blk,
+                                 uint64_t ram_size,
                                  unsigned int num_cpus);
 void phytium_e2000_soc_cpu_topology(unsigned int index,
                                     uint64_t *mp_affinity,
@@ -82,6 +92,7 @@ void phytium_e2000_soc_cpu_topology(unsigned int index,
                                     int64_t *core_id);
 ARMCPU *phytium_e2000_soc_cpu(PhytiumE2000SoCState *s,
                               unsigned int index);
+bool phytium_e2000_soc_firmware_loaded(PhytiumE2000SoCState *s);
 void phytium_e2000_soc_attach_sd_card(PhytiumE2000SoCState *s,
                                       unsigned int index,
                                       BlockBackend *blk);
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 3e30d112f7..6818d081b3 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -23,6 +23,7 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/phytium_e2000_mhu.h"
+#include "hw/misc/phytium_e2000_pbr.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -224,6 +225,17 @@ static void phytium_e2000_configure_cpu(ARMCPU *cpu,
     }
 }
 
+static uint64_t phytium_e2000_cpu_mp_affinity(unsigned int cpu)
+{
+    /*
+     * E2000Q exposes one core in each of the first two clusters and two cores
+     * in the third cluster. Firmware stores these MPIDRs in its parameter
+     * tables, so a linear CPU index is not a valid affinity value.
+     */
+    g_assert(cpu < ARRAY_SIZE(phytium_e2000_cpu_config));
+    return phytium_e2000_cpu_config[cpu].mp_affinity;
+}
+
 static void phytium_e2000_create_its(PhytiumE2000SoCState *s)
 {
     DeviceState *dev = qdev_new(its_class_name());
@@ -483,6 +495,39 @@ static void phytium_e2000_create_qspi(PhytiumE2000SoCState *s)
         phytium_e2000_memmap[PHYTIUM_E2000_QSPI_DIRECT].base, 2);
 }
 
+static bool phytium_e2000_create_pbr(PhytiumE2000SoCState *s)
+{
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_PBR);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    uint64_t cpu_mpidrs[PHYTIUM_E2000_NUM_CPUS];
+    int i;
+
+    for (i = 0; i < s->num_cpus; i++) {
+        cpu_mpidrs[i] = phytium_e2000_cpu_mp_affinity(i);
+    }
+
+    qdev_prop_set_string(dev, "boot-mode", s->pbr_boot_mode);
+    phytium_e2000_pbr_configure(PHYTIUM_E2000_PBR(dev), s->boot_blk,
+                                phytium_e2000_memmap[PHYTIUM_E2000_RAM].base,
+                                s->ram_size, cpu_mpidrs, s->num_cpus);
+
+    /*
+     * PBR owns the status snapshot and both boot memories. The status block
+     * overlaps the broad board-control placeholder and therefore needs the
+     * higher mapping priority used by the previous status-only device.
+     */
+    object_property_add_child(OBJECT(s), "pbr", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_PBR_STATUS_BASE, 2);
+    sysbus_mmio_map(sbd, 1,
+                    phytium_e2000_memmap[PHYTIUM_E2000_BOOT_SRAM].base);
+    sysbus_mmio_map(sbd, 2,
+                    phytium_e2000_memmap[PHYTIUM_E2000_BOOT_IACC].base);
+    s->pbr = PHYTIUM_E2000_PBR(dev);
+
+    return phytium_e2000_pbr_firmware_loaded(s->pbr);
+}
+
 static void phytium_e2000_create_ddr_status(PhytiumE2000SoCState *s)
 {
     DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_DDR);
@@ -572,23 +617,40 @@ static void phytium_e2000_create_cpus(PhytiumE2000SoCState *s)
                                 config->mp_affinity, &error_abort);
         object_property_set_int(cpuobj, "cntfrq", PHYTIUM_E2000_GTIMER_HZ,
                                 &error_abort);
-        if (object_property_find(cpuobj, "has_el3")) {
+        if (!s->firmware_loaded && object_property_find(cpuobj, "has_el3")) {
             /*
              * The generic-loader U-Boot path starts after the EL3 firmware
              * stages that normally provide the Phytium SMC services.
              */
             object_property_set_bool(cpuobj, "has_el3", false, &error_abort);
         }
+        /*
+         * PBR releases only the primary MPIDR named in the firmware parameter
+         * header. Secondary CPUs remain powered off for later firmware or
+         * PSCI bring-up.
+         */
+        if (s->firmware_loaded &&
+            i != phytium_e2000_pbr_primary_cpu(s->pbr)) {
+            object_property_set_bool(cpuobj, "start-powered-off", true,
+                                     &error_abort);
+        }
         object_property_set_link(cpuobj, "memory", OBJECT(get_system_memory()),
                                  &error_abort);
         cs->cpu_index = i;
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+        phytium_e2000_pbr_connect_cpu(s->pbr, i, cs);
     }
 }
 
 void phytium_e2000_soc_configure(PhytiumE2000SoCState *s,
+                                 const char *pbr_boot_mode,
+                                 BlockBackend *boot_blk,
+                                 uint64_t ram_size,
                                  unsigned int num_cpus)
 {
+    s->pbr_boot_mode = pbr_boot_mode;
+    s->boot_blk = boot_blk;
+    s->ram_size = ram_size;
     s->num_cpus = num_cpus;
 }
 
@@ -613,6 +675,11 @@ ARMCPU *phytium_e2000_soc_cpu(PhytiumE2000SoCState *s,
     return &s->cpu[index];
 }
 
+bool phytium_e2000_soc_firmware_loaded(PhytiumE2000SoCState *s)
+{
+    return s->firmware_loaded;
+}
+
 void phytium_e2000_soc_attach_sd_card(PhytiumE2000SoCState *s,
                                       unsigned int index,
                                       BlockBackend *blk)
@@ -643,9 +710,14 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
                    PHYTIUM_E2000_NUM_CPUS);
         return;
     }
+    if (!s->pbr_boot_mode) {
+        error_setg(errp, "E2000 SoC boot mode is not configured");
+        return;
+    }
 
     phytium_e2000_create_unimplemented(s);
     phytium_e2000_create_qspi(s);
+    s->firmware_loaded = phytium_e2000_create_pbr(s);
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
index 7397c58a78..3ab82c5fff 100644
--- a/hw/arm/phytium_e2000_machine.c
+++ b/hw/arm/phytium_e2000_machine.c
@@ -53,6 +53,15 @@ static void phytium_e2000_attach_sd_cards(PhytiumPiMachineState *s)
     }
 }
 
+static void phytium_e2000_reject_legacy_firmware(MachineState *ms)
+{
+    if (ms->firmware || drive_get(IF_PFLASH, 0, 0)) {
+        error_report("phytium-pi: -bios and pflash firmware are not "
+                     "supported; use an if=sd,index=0 image");
+        exit(1);
+    }
+}
+
 static void phytium_e2000_create_ram(PhytiumPiMachineState *s)
 {
     MachineState *ms = MACHINE(s);
@@ -83,6 +92,8 @@ static void phytium_e2000_create_ram(PhytiumPiMachineState *s)
 static void phytium_pi_init(MachineState *ms)
 {
     PhytiumPiMachineState *s = PHYTIUM_PI(ms);
+    BlockBackend *boot_blk;
+    bool firmware_loaded;
 
     /*
      * KVM cannot provide the heterogeneous FTC CPU configuration applied to
@@ -107,20 +118,25 @@ static void phytium_pi_init(MachineState *ms)
         exit(1);
     }
 
+    phytium_e2000_reject_legacy_firmware(ms);
     phytium_e2000_create_ram(s);
+    boot_blk = ms->kernel_filename ? NULL : phytium_e2000_sd_blk(0);
 
     object_initialize_child(OBJECT(s), "soc", &s->soc,
                             TYPE_PHYTIUM_E2000_SOC);
-    phytium_e2000_soc_configure(&s->soc, ms->smp.cpus);
+    phytium_e2000_soc_configure(&s->soc,
+                                PHYTIUM_E2000_PBR_BOOT_MODE_SD0,
+                                boot_blk, ms->ram_size, ms->smp.cpus);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     phytium_e2000_attach_sd_cards(s);
 
+    firmware_loaded = phytium_e2000_soc_firmware_loaded(&s->soc);
     s->bootinfo.ram_size = ms->ram_size;
     s->bootinfo.board_id = -1;
     s->bootinfo.loader_start =
         phytium_e2000_memmap[PHYTIUM_E2000_RAM].base;
     s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    s->bootinfo.firmware_loaded = false;
+    s->bootinfo.firmware_loaded = firmware_loaded;
     arm_load_kernel(phytium_e2000_soc_cpu(&s->soc, 0), ms, &s->bootinfo);
 }
 
@@ -167,7 +183,11 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = PHYTIUM_E2000_NUM_CPUS;
     mc->default_cpus = PHYTIUM_E2000_NUM_CPUS;
-    mc->default_ram_size = 1 * GiB;
+    /*
+     * PBF/BL1 relocates to 0xf8c40000, which is outside a 1 GiB RAM window
+     * starting at 0x80000000. Two GiB is the minimum useful firmware default.
+     */
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "phytium-e2000.ram";
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_SD;
-- 
2.53.0


