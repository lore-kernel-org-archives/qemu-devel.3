Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288A2C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tI2-0008Rr-Br; Tue, 08 Sep 2026 06:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI0-0008OO-OG; Tue, 08 Sep 2026 06:42:56 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHz-0006YC-30; Tue, 08 Sep 2026 06:42:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9aL4n1I70amb59Pe1yHMmg1dK10CO/HtjsnXh05ng4xdJ+AKZ0K1zrd0jKIRgZ0Plc2d0ZkIP6JRvgT9fuCLNQFfJSxX61Syb9Nr4/CxYDlnesIDwoyd8MMghZe9wmtgqyL1Giwu/7xhlTY5AhYPhPqMcNr75q8ktUlvujRPRZ7/F4VtqdgTom7Laj7JieZvEJ0i9FYN5lHkXlagy70YjFhfZXYEemjwOqPjubpqqC7+aFYXSB4ywOWhsWZQl0HPbb2stYs78Af+3VnpiGoFl9am2xDREVm0lcIIjeB2oTFv5u1Oe30Gx4DX8FEgK8zVK7uFAphqrkDIo6w2qITQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4DpiQr7vO4OTgfuNjOtBinrDz7uyHT4rT7CS80PnoI=;
 b=R0iRfXn1R1W930dFO4YdALD9bERxuJdEeT9UFUh9XNNb7NCmpH6a6drwfOdNupdyPaxo4EDb669dyWuItFeFPJbHT7wfn68us6y5DDSQh991S4wl/Mu72dhiTHD9ocCTLXXoxBusFGbtBNXw388YqLsPfOlR1uHaMOysldtIvGyk8RK7Vh9auK/rU9iowyZ87lEoVTYMhu1OHlYes+cGxJlUqTmYiTDW20+N5f6hlmUAaTATdw1BudGYIXcU4PgYD0R/9tH1YG84V28lk6Voe4uiLvN/v5kgGQVdlCTZbbf513Ocm0g0ksFR+tEnDJdEltMEzRbbkiZ043iFeMFKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4DpiQr7vO4OTgfuNjOtBinrDz7uyHT4rT7CS80PnoI=;
 b=lXIpz90u+7O04VW9DmLvxJ4u6a/D/puznXomRpx8SwZdRVPg1p9kscgNS2SPaFkq7SRC7IlHjWPJ4YdnvLL4o7QgojnKttzHoo0r53b6HYh/RM8kciqNIqs7xjIZlEcZmwiNwezXP7F9UB8KtYiO9Cn0/5bulfonPTyDcWgtrY54LjR7MN00RHZosJvgfchGjIl2eyicJstlGtDp3avTrs/y0CNOQgv1ZYCweD0h9Fczmu4OehHg6QPB6/q1xjkd0takmKOS31R6w4X7zLXZ2siqALWr7irU01aYGBEMpkX9+vNOOZ/NRkD91uC9yjruqdWigyHQm+tcWagPliICtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:41 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 13/32] hw/arm: phytium: Connect the Phytium E2000 QSPI
 controller
Date: Tue,  8 Sep 2026 18:41:22 +0800
Message-ID: <20260908104159.1621764-14-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ac4bac2-40f4-4b37-298e-08df0d95e72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9LX0besSCYQM9t6x05H2JugTaTIZznCnEgKxg2KvBCgPlzkl3JrV+EQfvZAb9aPmFgZbi4qn7MSuoaJaMS+//BxNfZSnXQ6v2yQEULXSghpQwIpRHM0lEmj/MMrHlc9DDJvuFSmC3YdTwZyCAe1yNzhRIHb5hQmfvniEEtbx9TKhH/DEwpkGrNHkzfrbduNHn+nObJs6vO4TNTQaJvwQYeGzQAjBts2GTP/S+ClIgOkmicNi0DB6nmaxuclS/ZphkmyhCHwcKmRhiiBbs8dGXGSCRCQmZn0y+WVfu/0j5KoEVGRrdP0Hy1HI+n4tNBB6zBhKs7wZgMTBSW62HNNmrWnsKRpSX/CvKw5FETsvalYZZs4e6FjnaNaMt+WpI3v1saALHhf5Ahh/Fj14WgsIAYUlXYlfxpTfD40W+fbSmqySk3riEUljY1beqEjy7TWp42rlugq7x8t+HulrYj4kUMDVoGcRHmGWj1nxPXbqP2RG3FXlumLhjFOaTqU2I3ML5Gt+JpmQTPgQIQ7h5edpHKi5Gasis+hOY7u27UUTYgpg8NJVQrodHLQmeCvX6AwfeD1OqcaRpGqW8D4k5e8UB1IUNjqoLQ/B/MssVGhGzH0tpJvDrYFulhzYZxqCXCDfJ4VAYQX2ZQi96DGnEE4CSYu6crddXBheDEq7hC8AKtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roVjqRDGqt7Umd2pjv3Oc3VQ9Jg3QplfjJqsSMm/UQJB85OI7igdAdiRCi16?=
 =?us-ascii?Q?kgYOcgIdqCZs1CEhlcc09ZJkZB+JVskkk6b9t0tGoVcuGFfUfOEOIlRNCdZo?=
 =?us-ascii?Q?dGJB6Q9i0miVHB6WSVA8aDzK/q5kcz9i4LUkAm68YOF1trfCiwCanxvvJEdu?=
 =?us-ascii?Q?ZSWknsFTXm1iYvIXwpfJcnoN/IYOXUocykIRbvrYnMEYJHGwxMIdJNOGPs89?=
 =?us-ascii?Q?aKugG4uvRNMwfQtEEOPPsPqF2MvntqEaTfb/0lat1nVBqwklA39nS/AiSUN4?=
 =?us-ascii?Q?fyscG6HRIjb8Ts7wkdcftKcN+WGJVdYFXCbWkM43jT++1VJ8EcN4iV66f0wF?=
 =?us-ascii?Q?FlNuhYaR/ybslNsmxBcgiMoGk8gZs0rsaHeqa1zwE2jom6rUj3roxpp/+dt/?=
 =?us-ascii?Q?dBt6O5uEwIx4jJI/Gc+NitfuVcqkm4bbpG6gfxmOYYfWYFElXI891Lj6lJwz?=
 =?us-ascii?Q?wMDrF738QamHEyhpYRmctO8F9qYpWfmupUx73RU8mJ5OVJHd5AgiyMxhurqp?=
 =?us-ascii?Q?4Dr84fhbgMIZvfmPos/ZP636xsAtvGWk/zxLtw2zCirbESOrhqRena5VAocj?=
 =?us-ascii?Q?s+8p3zI6QRoLlHoA/DrQzn9XNtoaXCspeY85EggAvkP7lZ9f9TgO6g1lTXzd?=
 =?us-ascii?Q?qoHevP9+gvI7ipEBfe0bGpW35iUHDGjWzigN2ihVirlY3pzypU882L/Tx8kN?=
 =?us-ascii?Q?z+uMP47lYN7id5pBi8AgGvNpVj2NgGqNOB7Ig/cK4TZX8RyKO2NkK83wTyb+?=
 =?us-ascii?Q?IRWB2sO6FZFTsMlQfrnX5JpyYa7RczP4LLH/BqgJw+3qvReYOHEOIw1X5Z7p?=
 =?us-ascii?Q?1jlUciW63bnk9SenUY4VSuBDl2yyChWvvDZwBdZb6Cuce/eDa78vxN+mn0+d?=
 =?us-ascii?Q?mwpQMWKDZPAawGnRzNPqK9PuF5FVgJiO4nDf2JLaRRMmp1OM8MARGw9ZsjH0?=
 =?us-ascii?Q?qtjN3N1FLpCGg6IPHnOZVP1ftwN4Dla8ZiDbgYwI8X9Q9sx59zcon/tirX2t?=
 =?us-ascii?Q?d522iEfXZf9SjboMcac+9iDOac6yPC+MD0R0su+ZKUZhiCAc+RVCEZjeKgzk?=
 =?us-ascii?Q?ihMaMDjwSVP1L9CrfQmlOVmusadK002Gs/s5q2O029fGH61Z9jIHVW577+MU?=
 =?us-ascii?Q?IQMj9awamm33OWgWzlaPjoujtHWLXsWxDdioKELQrPONWjtMgmQYESImA4Jw?=
 =?us-ascii?Q?qAwSVb89anI/iK/dc7jfU2/His1/FdnbKxzBOvpThLCybSypTKW1nGQ90gcM?=
 =?us-ascii?Q?AUNrZyApveChNUNHqYuGrG6t5SGSc9u6BfZfX1QZRBL3Zv5td7OmmG9sprbr?=
 =?us-ascii?Q?/8X56vc4XaJODoM36n0d43y+nKm8NYy9IQYGjxGsz8DmLfvNtQrralhBhXn3?=
 =?us-ascii?Q?lvb/fIbvt7rKGqdqjJj1ZzBHfiqi1B1SfalxLvreaXqSpHYXb4B6gyY2K0Vp?=
 =?us-ascii?Q?aG58wDTdbrrcEZtE0fGoN16cWH/E3SjH13o82YY8nndpfmDuDiOrn/AnPSq6?=
 =?us-ascii?Q?mrdJCatyzWhvhbw1MiMDHHCBg9btMxQlFwDf/G8gKZi8o6c3jInufrJRzaoI?=
 =?us-ascii?Q?OV/xqJtEiuR5jPNEeKkObcs1OAzkqKcjjCTke37Ee6hAfo+bcAVZfE1b8n5H?=
 =?us-ascii?Q?TiEiRLYBAsSOouO3y4wkHsk9+Fvujwa/5K5qH29wyBn4BtDC/V1x4nkCek/d?=
 =?us-ascii?Q?GJkKY4oNVL/xEeyKAW5VtjQWnPpfyBosfzqX0IwnOHyXW71EJnKbgI+r9DAa?=
 =?us-ascii?Q?iL/pBOc/WcpTfRiunV22mE/tPTRv4ME=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac4bac2-40f4-4b37-298e-08df0d95e72c
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:39.0419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjnT78mDspFysfAk149baJ9/Pp50sDnnSvhK9BdCF5E9nCDm5EaOfQVcFnp4obwGRproe3H+DQNL0bGAi593B9eR7c257+eQoBB78HPkrmw=
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

Instantiate QSPI0 at its command and direct-map windows so accesses
from E2000 firmware reach the controller model.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move the QSPI controller into the E2000 SoC
- Store the QSPI child with its concrete QOM state type

 include/hw/arm/phytium_e2000.h |  4 ++++
 hw/arm/phytium_e2000.c         | 15 +++++++++++++++
 hw/arm/Kconfig                 |  1 +
 3 files changed, 20 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index 40f91256a2..92b39129ba 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -16,6 +16,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/phytium_e2000_mci.h"
+#include "hw/ssi/phytium_qspi.h"
 #include "qemu/typedefs.h"
 #include "target/arm/cpu.h"
 
@@ -27,9 +28,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000SoCState, PHYTIUM_E2000_SOC)
 #define PHYTIUM_E2000_NUM_GEMS 4
 
 enum {
+    PHYTIUM_E2000_QSPI_DIRECT,
     PHYTIUM_E2000_LOW_PERIPH,
     PHYTIUM_E2000_MCI0,
     PHYTIUM_E2000_MCI1,
+    PHYTIUM_E2000_QSPI_REGS,
     PHYTIUM_E2000_UART0,
     PHYTIUM_E2000_UART1,
     PHYTIUM_E2000_UART2,
@@ -63,6 +66,7 @@ struct PhytiumE2000SoCState {
     SysBusDevice parent_obj;
 
     DeviceState *gic;
+    PhytiumE2000QSPIState *qspi;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
     ARMCPU cpu[PHYTIUM_E2000_NUM_CPUS];
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 95ebf3c87b..3e30d112f7 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/sd/sd.h"
+#include "hw/ssi/phytium_qspi.h"
 #include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
@@ -54,9 +55,11 @@
  * handoff data and IACC is the fixed execution window for system firmware.
  */
 const MemMapEntry phytium_e2000_memmap[] = {
+    [PHYTIUM_E2000_QSPI_DIRECT] =    { 0x00000000, 0x10000000 },
     [PHYTIUM_E2000_LOW_PERIPH] =     { 0x28000000, 0x00100000 },
     [PHYTIUM_E2000_MCI0] =           { 0x28000000, 0x00001000 },
     [PHYTIUM_E2000_MCI1] =           { 0x28001000, 0x00001000 },
+    [PHYTIUM_E2000_QSPI_REGS] =      { 0x28008000, 0x00001000 },
     [PHYTIUM_E2000_UART0] =          { 0x2800c000, 0x00001000 },
     [PHYTIUM_E2000_UART1] =          { 0x2800d000, 0x00001000 },
     [PHYTIUM_E2000_UART2] =          { 0x2800e000, 0x00001000 },
@@ -469,6 +472,17 @@ static void phytium_e2000_create_mci(PhytiumE2000SoCState *s, int index)
         qdev_get_gpio_in(s->gic, phytium_e2000_mci_irqmap[index]));
 }
 
+static void phytium_e2000_create_qspi(PhytiumE2000SoCState *s)
+{
+    s->qspi = PHYTIUM_E2000_QSPI(qdev_new(TYPE_PHYTIUM_E2000_QSPI));
+    object_property_add_child(OBJECT(s), "qspi", OBJECT(s->qspi));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->qspi), &error_fatal);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->qspi), 0,
+        phytium_e2000_memmap[PHYTIUM_E2000_QSPI_REGS].base, 2);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->qspi), 1,
+        phytium_e2000_memmap[PHYTIUM_E2000_QSPI_DIRECT].base, 2);
+}
+
 static void phytium_e2000_create_ddr_status(PhytiumE2000SoCState *s)
 {
     DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_DDR);
@@ -631,6 +645,7 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     }
 
     phytium_e2000_create_unimplemented(s);
+    phytium_e2000_create_qspi(s);
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d9759731f0..e4111eaec2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -136,6 +136,7 @@ config PHYTIUM_E2000
     select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
+    select PHYTIUM_E2000_QSPI
     select PL011
     select SD
     select UNIMP
-- 
2.53.0


