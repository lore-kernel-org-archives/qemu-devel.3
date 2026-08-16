Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18353C5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvai5-0001Yt-Mo; Sun, 16 Aug 2026 09:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahw-0001VG-KQ; Sun, 16 Aug 2026 09:15:25 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahu-0005Tk-B2; Sun, 16 Aug 2026 09:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEZdLCZTVwsUZHQgkYrd+DeGllgmoHKrZ8zWl7oVQfYgo9ofBJO6zxqLFqiO6qpHX4dbzrfKGr4nvmq3q7JNEAGdmRGWNoyH4lwBvZiEIX+D+tTptvT6zKp77QNwJkciwJa4hTs3T2Ch5JOfXg5Q2PgHSClxYR0AzLW+Z3UXma9I5O6uOTCnECRc0LPYl3UEJGHxYXWbI+I+yZWT94WHgnmXgQjVl8wQcH2225vpDdnzTilqnT58rhrq4rRLxWDqlOmikIH3SPmMWYkkvw1HQjIO3bXzFvF1Tc01J89u0ryg5kwrwOwIbnI6CwIiAtaEB6X5jzz8MsyjIS0JYFOhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap0YiwASlT8E5/SwyI3UdsWAFZw4m/209KDm3mqmbGs=;
 b=os3jy7l8fZEDDZKE0te74HlZ/JCn1kasxCWRmYWA8SFTCwUE7RyCWACrEeKUyH+whugFjU1XJS0EjP1k2GHLmV0CU099uYx/H7f5UdJAWdLhyq/tukFSdC1X0Cerdzdgex7OfcLmo/WMsws4jG11607Q1EXiDU3I+Ok+mKpMrya7xvhKLRa4OwwQ6kR0UQ/6t9T8LggOfI/uQeqZMxvipTyr7yDU72HZdp5EiQbZHww8+skedRUNNHQmABSKgSU68pdaxanOxlL5LysWnmSRVtZjhljOt7+4zDlVI4TkukpDBH5xmhY205wRtKpMIK9vtxOVLM1ljw+GCQXaWYajcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap0YiwASlT8E5/SwyI3UdsWAFZw4m/209KDm3mqmbGs=;
 b=nLRjsD3DCjObz0hHqN9OIbjWwhXghIczYgQ4DvtwwzDs/qkvyjHlvQcsnYB9P+S9xzqXMBBMYI9ilJQvTaPP5dIBW4/hsGPwecZwnmGxMACt0GEgaOvcnS+Bh9HSeXxHruj13ZANVhnWNajshIognuRJQTDC+0wXyKq1HSCov4196QIP3j1u7pUD7VrrPP91Mb7BWkZ151vHVcmzfSQKFlgUAFnLfjuNbaAXpF4Ofu5MttDiQcgeHDS9bxofAX3w/iGquK2ucJAxkvgmrHyr7BUn3A41XjlKERrina7BULq4pYpv0qpoD6HGxZtWFc5ltmcLXwjfjNDBVpW/IaKaCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:08 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:08 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 01/20] hw/arm: aspeed: Store boot info in the machine state
Date: Sun, 16 Aug 2026 21:12:31 +0800
Message-ID: <20260816131300.51799-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816131300.51799-1-bin.meng@processmission.com>
References: <20260816131300.51799-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8a5a03-fdac-4c01-07c5-08defb986557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QKc4zeJv5X6QK32xNDLSp47nw+y2yKXqIYdS1soF2imdxd9RdXbEq4mOkgp0yr8vDzxbqs4tWJho6YKSetKlwnKOsZ4jaSMZ0i8a1b6M+2p1tyfn0ZZoJrPJkPizLvaoySvRct9sI7y2tbb++hL+FfswxrPK+hm2Kp/ysDus7pC4tZdMVhEUtXE8PfBLRnX+L4YGBdTKcKJVYsurL+sLbqXuLXbAa75g7UcoK7lrLgllGmez+8S2McVM/Omnd5WuyosqNhH3EF2rORbfhkrEsE1RJTuqMgARa5xbb4FhRjOn5fZp0ePhhXTRmZdff+61bFWJQiq5HEDCyOnHjqRi+ew7nwX6NMTrhI7SzE2h2atn9Z6ttFKWCYwWMBm0d9Aya0jjt+153tASqS+PJaDenwqP5w+ECH6xwDe56nDzSvqrQZ6po8D3uP74l4iITBpyEp8EKaKeUXGkPb1/tkWwG5rwyGL8Y24K13h8UPXuJIlHXxPrMeP8wBT2jWmUUKPla2eUZRN70kRIb1bRHjwyxx66ozmcg4yxD0j7mti6k7gXVuSn4r70vyKyHd/zIP6Uec7V3ZrgkD0xt2jjBnXDMFS+Yo1ogQ2lESenIQ769r/VpTXIHABGk0KZmW6g9VbDSKGNrelwrGeYf+RdzKiqSY+Yr0dhB443Bu+BtzRoae8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jD/jZIlq5q63/66eLRNsyNc/AeNzsF9RWNPsrPvprBVOFkaM16HYqp9D6OiL?=
 =?us-ascii?Q?JTzPoNJo5SPPi17SrtHZ0VMs3mmaf4Hji7z46yATcWBmzUGfos18lIILEhVF?=
 =?us-ascii?Q?CUf3zjQXBiTjmxLz+vDTUOgEEZU/8zyZIqYMiwKkL7+OTEVVq4JPUenEoQkY?=
 =?us-ascii?Q?ONNYzNQGDwqKiF7hxJVFHLhfKtUvMQcexzVXmBUC9ZxX/1MRCfVmDcr83ckI?=
 =?us-ascii?Q?rH2f74NIqO+GdPWLrO67C5Z+7T+3Ecaajd9iqMP+6IFUKD483wH71HGxirtD?=
 =?us-ascii?Q?GlmoO2/btwngCh6/YlWTgykZl4JH0VxuNLx7d1xSs+vAX5zeW4sP005mdWHy?=
 =?us-ascii?Q?KB5vy+eQYty5COIrCe7UPms6/jVouhhuZMq1usB3Nq2BUBt5SbhIf1owwCiM?=
 =?us-ascii?Q?2Z1yXiKKtxJld4gXGquz06wCeC+/lOtLXNYFOZFW+Lqj5soDnVzbmiHnSZHJ?=
 =?us-ascii?Q?KdkKLvZB64AhmvQCeT7vpHi/1YVLOutltHV1B48x1leqiWmw2koqBPQNhaOl?=
 =?us-ascii?Q?E/hCcTJj0If6aCRLgwC3oNVvaMOCLHXveQIAwbkEGfJIxAx4ywhILQ2ogF/b?=
 =?us-ascii?Q?I4Te+KFvY+8KP95G7QFhehG2TaUPRT7Cx/8IijLzcCkwJP26k4NzXi5BnkrQ?=
 =?us-ascii?Q?cxywdZ95FCvIXgYuK11EToBqsODko9iNbCDAAdp4p4HWE3ci+ptpx2e35gRL?=
 =?us-ascii?Q?X7RXFKfOakQraypKScXpd9YbsOBbEcNEIE6/dMoV8XAjVsIfPDpDF/7OEdEG?=
 =?us-ascii?Q?yWj9QPc4LW8HwHbzPHl+Y0QZeV7RwXER1bRn0YsVUkVz20Lz2CQXzWI0U4UR?=
 =?us-ascii?Q?cYOXTP50Wu1v5aI6JQHyZet4d0NwQFsEERv3FSIsRfV+q5bfYC+diRyQHjV8?=
 =?us-ascii?Q?IBB2jqaj0cZxpwbYHApwvNdy1P69dDAnc9G5VFUUgAdNkrtYIV4In4emvQQ8?=
 =?us-ascii?Q?xvFhhk1U17GJz41Moitt+dVgtefoqYVCmmycVsWzZ+sAeYDTLoStLzAwozY3?=
 =?us-ascii?Q?ubmOSX32JFusM9PxS0bJTwYN2yZvSOxjkih4g49xgkjJLFsEMv/7UvQ479xO?=
 =?us-ascii?Q?vAkcCj0jCVWi6cc2uTzALKfYyRKotM7aKwM84sdeN8WCSRLEoLkuUKOizczx?=
 =?us-ascii?Q?J7xHq2A3D73KfDm+MculDMMKzvmASJWBx0i0HzMJSEKM1FYZwYMJ3KcjpM2c?=
 =?us-ascii?Q?+uxLiXpgbNgbuZOj0P6t2hLM60icY8KB+O4mNiyz+S7vVn1oVq/xTIObae/+?=
 =?us-ascii?Q?IFdDaisK7f7HTh63aDT+SrDDPmoIKaD5coeVNI0IlK72ZlIm+1PMfZzAW3pW?=
 =?us-ascii?Q?z/Kh00LGqeZ2OtNdR9GiIgCRrqG8kyQ533TQ1RhO6iu4epNpPyl9YUf2ONQk?=
 =?us-ascii?Q?xrE7DGeMwV2V7BBhP0bU/StN8oYA/5k8Zb8JN2lG1lrW+HY6qHYOLNFkVfL/?=
 =?us-ascii?Q?Re1yJCdFXRVFZYkmkKYUmOUvrW+/KcXXqPZP9R2Sapa9MOkHeKnLABmw38Ky?=
 =?us-ascii?Q?GThRz5hVgvyARdR7IQa9Z42aMuV01Ajbh+8s8BY6Df+7ORgnlqvrY21tAkhC?=
 =?us-ascii?Q?cWLTAlwW9lDHxZNAvp6jSoek1WznO1rTM56IiJ9oN1DSEDSNL+p9e2itxCXZ?=
 =?us-ascii?Q?DLah0RYPRivRjROnwsADo1hGxGpUBbBaI9pMjHFPFEQqRQns6cSrwhL4Z2Gi?=
 =?us-ascii?Q?tQZRMoAmnFYT3JI010XCZ7iz+9FFPX7pZmTExHQyDLcTv2w41zmsnXy89YOX?=
 =?us-ascii?Q?69KzJ+MwD3UtdpZXVbPA7DYgGfbe9MA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8a5a03-fdac-4c01-07c5-08defb986557
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:08.8631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu7WYn8eoHy3kShv2Pt/ViQvE60hvIrIkEDMN6gTUw1qOMZbfxKw2jMMMGL2mfVBUFDU3VDs6LNhjpcHf++ghRD+/ZTICRtMLAyS07+z1CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move the boot info into the existing AspeedMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/aspeed.c         | 17 +++++++----------
 include/hw/arm/aspeed.h |  2 ++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a9238e6217..8fa16b3831 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -24,10 +24,6 @@
 #include "hw/core/qdev-clock.h"
 #include "system/system.h"
 
-static struct arm_boot_info aspeed_board_binfo = {
-    .board_id = -1, /* device-tree-only board */
-};
-
 #define AST_SMP_MAILBOX_BASE            0x1e6e2180
 #define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
 #define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
@@ -206,13 +202,14 @@ static void aspeed_machine_init(MachineState *machine)
         memory_region_add_subregion(get_system_memory(),
                                     AST_SMP_MAILBOX_BASE, smpboot);
 
-        aspeed_board_binfo.write_secondary_boot = aspeed_write_smpboot;
-        aspeed_board_binfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
-        aspeed_board_binfo.smp_loader_start = AST_SMP_MBOX_CODE;
+        bmc->bootinfo.write_secondary_boot = aspeed_write_smpboot;
+        bmc->bootinfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
+        bmc->bootinfo.smp_loader_start = AST_SMP_MBOX_CODE;
     }
 
-    aspeed_board_binfo.ram_size = machine->ram_size;
-    aspeed_board_binfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    bmc->bootinfo.board_id = -1; /* device-tree-only board */
+    bmc->bootinfo.ram_size = machine->ram_size;
+    bmc->bootinfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
     if (amc->i2c_init) {
         amc->i2c_init(bmc);
@@ -248,7 +245,7 @@ static void aspeed_machine_init(MachineState *machine)
         aspeed_load_vbootrom(bmc->soc, bios_name, &error_abort);
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &bmc->bootinfo);
 }
 
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index a00238ed74..54f0d7643d 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -12,6 +12,7 @@
 #include "hw/core/boards.h"
 #include "qom/object.h"
 #include "hw/arm/aspeed_soc.h"
+#include "hw/arm/boot.h"
 
 typedef struct AspeedMachineState AspeedMachineState;
 
@@ -42,6 +43,7 @@ struct AspeedMachineState {
     char *fmc_model;
     char *spi_model;
     uint32_t hw_strap1;
+    struct arm_boot_info bootinfo;
 };
 
 struct AspeedMachineClass {
-- 
2.53.0


