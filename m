Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F6CC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ai-0005t7-EO; Thu, 03 Sep 2026 07:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ah-0005rT-34; Thu, 03 Sep 2026 07:26:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25af-0006f9-G3; Thu, 03 Sep 2026 07:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLiPZvaE5drNNCWX4BSh8UFpMW45J8F8bOCL/yR/PAbrZ3yAmSslVoVIMK4TapgPGx+Oorkv4ACi801wsIIXFHjIDBuzbPcvNSK7PMQYUx5xXtUJI158G9EcGqAa2wWfcj/LB/IBpjS6g2UzOYX/8fMrIQidM7G6aCYR+ifqdwurpPZq+azB82kvSI4zFNRp5i3nn0rK1hShxLvEHuiAHDtfWJEnA30lUjkeBEr6+wXScMkK1lBvh0iEZdJxxNq5zN5hPqMlU3s+bzblOAxjnvKVRJEJ8Yn5XHUj4tR2zeiGwU2s9eVTikdb2qHD2XZtpiH5+iTfl8WvknmJG0C/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMZtu0XsHNr6XoDBG3mjHuOwjWp7tTI+GuK281sj0Qs=;
 b=vJ6CfeWCRWDzPqKUTdvyvPQ3vTRbUprD4AJMYYBigD/v/NK89PAEGb7HS8Eazqs+RnVbgCeTZXpC2LV9kJky0YVxFrvvhT2MBUDghllv6JMLs6nv/FX3Dj+vnzwwJRb1ZttHJLGKhEDG51W4tVKhBA3xh0EKp2G7qQRKlMvkHnDxHvZRDl2YEqFF2UvOSuP4uXP/BGQCsqIidyQ+g4aYuLvmndogBuCnONzLj04Q1VYfy+uIKa1nVS1dmYIATuHrskvJyv4lghKei6BqLGb5d7AKwf2VUhndI15vzUavUcmPvRNOugIVvqyrO3mrPIKUbC/xa0SgGm9ibwAB/VWTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMZtu0XsHNr6XoDBG3mjHuOwjWp7tTI+GuK281sj0Qs=;
 b=p3nhjkrNwPe1qJ/Jd7AdR/UnQztwvgXaEl+Z4oobwterw/ZH3jHB/fEZtMctv6e6rkVw9QVCVZxu0e9BcoHWmOH4NLk1ER7SA/ciz5ZNlfFsRYCk8pVWYvgqvRdnXrGaGZ9YLtrGChBLtJrtPH+/rzLAxKfo0qvIGL98smqllgZa1ux01Wktm6h0QzEIF7L0tKVmJx0B/AOeyarhWj/tEm4KKHlZLsQiNUqoslV5dOBiODbvkEiQq/wkSDBFhJlQhhNPMdMzaWjlHSIPECPt3F3KT3Y9h+Ix+NpL8qlVGuNjYG5bwpy3IEs9/uCbRmV8ewcBisLbHYhuVheivZRhHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:14 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:14 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 12/33] hw/arm: phytium: Connect the Phytium E2000 MHU
Date: Thu,  3 Sep 2026 19:24:52 +0800
Message-ID: <20260903112532.3276678-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 6040c5f1-ede0-423e-bbd4-08df09ae2a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 9rv0rnHTE9lDKqOWTfJ7WMfk60k9R4UnY0+fZADjaHCo8JQqYU+eCZw7TuUFXiOXdkwWUL6Qw8oqr3WKN+xA1d7Ey9mXqPjiJIKy2xcsg5xcn62sohtMw7J8rAz6Mn9VfO9APY6AgfqDttQYmKp60Hsf5sFUqfLEE9La0UHsFErBP5WDXNNs/XjQcp6i53LshRxXLr1OLLoRRqO2Ap41m5+/QfyiinZRjUPxy0uzRhexaWhrKVLs3fSIqOppuxqBCPyoXXobm5880VJRWCVoCLphRHyQOFbWnK0LCd2Pk6tn4J5QhkADZtBjrLGCsa5AokQ7spVGgs2hnYZVX7p2HhxLRO9QfqllcJcOd9jpH8duy+YMZ7q3FCLWZf/8eUrMG59/Xc6Yo5WsVxSVNcCw/BpzQvBpeimhiHS5kfGh7Gj/d43wiGL/PQ73cl3MA8PxYUfS7xBjEex9x62+klJghV6NkPZWWKp2QzHdXvJN6FkHPhkrv9aIZ47VM/WqogWSSWxW2EancSmxAFotPJkBsT41pPPJHavbotlQraTpthFnW99GDo3TurQquReCf214Q6QRSEpXZh81ahSkuaGFEPuOltjIX1oO4vhJfIcz0hQJb/lp3d3Om8B3duvN9de7xDcNF+n7CrTqaf4q3GoNy/t8kkLvxzh+l2lm8EsDuhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjsfOMqZNBGVrDn9bAqVQtwS4xo8tsFHp5Lxo9rPbhM3aRsnQg0vqWwuEAs8?=
 =?us-ascii?Q?Ef77lXck8+eEjZR+9JJHBIko2/UDTooEU9pEB8UTQlHg3njGGjusG82LZ/sk?=
 =?us-ascii?Q?JK0ln/EvX8M3i9W90bZSyT9LAS46qAERUtwR6bDkcYZsyrhaQOIE1Ei15VXr?=
 =?us-ascii?Q?ZTNEYZbAHt2pXfnLM6kujoFpNHbV/EzGChaFFv4AdTvxcsUnifm4WCvkRfBv?=
 =?us-ascii?Q?7nAaIzGGcx9RQ4CyIsRsCBBA1gJEIA+2YNkjnaJYADm5+lWfNK5wdb8Hql3T?=
 =?us-ascii?Q?Uq3PKLjF3J4gwFSbYUaQy9yU4OxKoiJ4Z3CjoNxsASyR09H3gzIQbelnsLgE?=
 =?us-ascii?Q?pNUSk5OEqmsdTkvxzuR1+JHWC4L68bEBKXo6h2fZslQeV9fS6d8EJVO1mU3S?=
 =?us-ascii?Q?XuKrpjfDZI09nIA0BCGduNaXbqNTuFAYqYC2rWhHtR3RAicRAMYXsCVSDGrk?=
 =?us-ascii?Q?IFSKAFHDldiU8E+5Q0gogPIt4qFiNGe0gul47J1xrYDXkiCRChlGPDvgxtMD?=
 =?us-ascii?Q?ZEqFXAYVXTUesC0awgfHq0IM7Z9Am+p5nfy3APIECdi1Huk+Jb/QZifX3UBl?=
 =?us-ascii?Q?cvWrHVPxXaJ3TQCA/QrxCxTiSh2ZZu/nP9n21ue9a0CfCzP7sDS76krf6Wwt?=
 =?us-ascii?Q?AeYM2gplkRZAduqCLeBJWS+HzkEk2EjsN+y7Ofm7BfqcJ6S5O1rT1x/Ly/U6?=
 =?us-ascii?Q?hfyNbT6bObotjWX02sTszlFoginHveATGqTQodZj6QpigJk1uXZiCfLNSYwL?=
 =?us-ascii?Q?XuJoWlJ8ZUDlXtsOJBT4rMSt8pSjT3Hi67pMl04fYwmrmoGUT/0pWFbDgCsv?=
 =?us-ascii?Q?lNFsrEpWbbD3mzBpCPHEItjr/h6P5OpF8zzgLHHpWvX7przkt6f1dG3/5pDQ?=
 =?us-ascii?Q?75w3L7jnl3MIbA58XVq3O4QwfK0xjZzzKHv7HaHV7OsOgPhssQrEHxYmyszQ?=
 =?us-ascii?Q?xDTIRdEAIRi96EnLBfi/lAENhK2rvNR4nI4X66ViFq1NZNVc9iBrQCnj9E5m?=
 =?us-ascii?Q?ABtvrjDCzOwrKVZbWd5NdUbJpTbWOEvrtrjN2i+i/z08IxpDVNkIZUrx/Qm5?=
 =?us-ascii?Q?UFK6p995Rfm289AH7a9MKpUlotEGohEHoIIy8yyYCiSXEP21KGIMCja1cB1R?=
 =?us-ascii?Q?m1xs3H0on4IFTsaPF0kMdVD4SBT/mucnBwYo6vlJJiQdTywah4dzPIsTemEx?=
 =?us-ascii?Q?PhAlY2ROCp1u/yPydukCajnTIIVMeHZztwEFDgMq34+kmgx5IaIKFQXToBSG?=
 =?us-ascii?Q?q8ql3LjoxElMucmD9j3fFp42Pj4XfPmKruVspgQUJF5+yPi1uggaFsq0e3c1?=
 =?us-ascii?Q?v5gSD49U51K64PyqCqM5uxa6ZqYHzUM5D/FOej6zTsFwcyQk09PgBWopOBmT?=
 =?us-ascii?Q?TpFrKmLlrom8cmqYx9Nn/BYClOXf49ufKHwmjbsJrPLn0g8+Xokqk0Q7VXSp?=
 =?us-ascii?Q?+vhQYfQeFW6xydEyg1g2Kwk0ADkAMFN3J2n5+bZHeyHn2UewgFGgZ4sdYQLM?=
 =?us-ascii?Q?HZs4Bwv0evNK6t8N1D+fwX07wihrEL2dP6GMYH0xEp5TMrtbR5ck+LfD5MGv?=
 =?us-ascii?Q?1Z8FE/8r3qmUCkSh2NOrbR24I9CwxQmd1y8H71yzBCoor6BmSvQp58XG1g6y?=
 =?us-ascii?Q?MYAfO0onCTJs86idLx+LeGgJ9U2kxzohgZ0p0DblZL13ns3XyQPcwlFneSO0?=
 =?us-ascii?Q?Iz0FPmeaTG4xcCStYwJeV5Yybt3eRF7d+XlN6TN+lpOBDubiWK5InCwqBq15?=
 =?us-ascii?Q?RRXl8cz+sEXuh2a3GI8XQKM5iMNFew0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6040c5f1-ede0-423e-bbd4-08df09ae2a35
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:14.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b+InS8gvdlkQvk1LKNPdSqJYULj9TrHZgvk+hH5/CbI1z6XsHKSJ4Qvmq0y5qBMoP9fNnezpvsejhkQtL4pLqWbIiP96qn8BVDqpYZI33A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
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

Add the E2000 SCP SRAM window used for SCMI messages and map the MHU
doorbell into the board-control aperture.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index f586184e51..ff8dd3354b 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -26,6 +26,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/phytium_e2000_ddr.h"
+#include "hw/misc/phytium_e2000_mhu.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -49,6 +50,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000State, PHYTIUM_PI)
 #define PHYTIUM_E2000_NUM_UARTS       7
 #define PHYTIUM_E2000_NUM_GEMS        4
 
+#define PHYTIUM_E2000_MHU_BASE        0x32a00000
+#define PHYTIUM_E2000_SCP_SRAM_BASE   0x32a10000
+#define PHYTIUM_E2000_SCP_SRAM_SIZE   0x2000
 #define PHYTIUM_E2000_DDR_STATUS_BASE 0x32b33000
 
 #define PHYTIUM_E2000_GTIMER_HZ       50000000
@@ -90,6 +94,7 @@ struct PhytiumE2000State {
     DeviceState *gic;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
+    MemoryRegion scp_sram;
     MemoryRegion ram_low;
     MemoryRegion ram_high;
 };
@@ -463,6 +468,33 @@ static void phytium_e2000_create_ddr_status(PhytiumE2000State *s)
     sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_DDR_STATUS_BASE, 2);
 }
 
+static void phytium_e2000_create_scp_sram(PhytiumE2000State *s)
+{
+    /*
+     * PBF exchanges SCMI messages and platform parameters through this SCP
+     * SRAM window. Map writable RAM over the board-control placeholder before
+     * the MHU doorbell starts completing requests in it.
+     */
+    memory_region_init_ram(&s->scp_sram, NULL, "phytium-e2000.scp-sram",
+        PHYTIUM_E2000_SCP_SRAM_SIZE, &error_fatal);
+    memory_region_add_subregion_overlap(get_system_memory(),
+        PHYTIUM_E2000_SCP_SRAM_BASE, &s->scp_sram, 1);
+}
+
+static void phytium_e2000_create_mhu(PhytiumE2000State *s)
+{
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_MHU);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /*
+     * MHU is the notification side of the SCMI transport. The message body
+     * remains in SCP SRAM, so this device only owns the doorbell aperture.
+     */
+    object_property_add_child(OBJECT(s), "mhu", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_MHU_BASE, 2);
+}
+
 static void phytium_e2000_create_unimplemented(void)
 {
     /*
@@ -582,6 +614,8 @@ static void phytium_pi_init(MachineState *ms)
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
+    phytium_e2000_create_scp_sram(s);
+    phytium_e2000_create_mhu(s);
     phytium_e2000_create_ddr_status(s);
 
     for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
-- 
2.53.0


