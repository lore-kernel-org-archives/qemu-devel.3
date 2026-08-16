Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D9C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaiC-0001fv-Si; Sun, 16 Aug 2026 09:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai7-0001bJ-Aw; Sun, 16 Aug 2026 09:15:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai5-0005Tk-OQ; Sun, 16 Aug 2026 09:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwrZkRY+cumDy7KwSd8wQWSCQlpqXUw5wX0pgUfvX63BcbnsEr/bAXF31+EzqIp82vrE/kVIWyzwxD9Ng9Se14ooDYc0uAnIohcu/qhK0pRtdXQPdu6O3DMZhV7cmVRoCp8HYcathkntbWyb5+AYMAgaKZ2P8FJYQa+p51m/Att0lwNMDCn5wRk3Tu+GUS9OmZY6oYNAkb8km8lcE1BSsftuhqlLl8WK0U/vnfYEnzvAjv3ikb1LIkiKc/WsdsZugUlvzfjy9KWcazZpXwjYFTYc1SF49zYCx2SilN2QIr6cqBkIxwO1zXD61vZta4MkEwcQaNMq5VigF0/z2jg3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6OBoPXCRXWxsrpkkMrNPCgNfT4emr1+yZJEQf0Dk6c=;
 b=zTYlDni7H91XRnceuWoAA+v/XLJex087p7goyGfbF0tzPO1rMtEK2M67VH6J4IxQu93m+pCT5hl08LRT8z5xhTWd5ewpdcZnM57HzKeJamBRth3y58HyIq6NWlLN9R2lWAbqBnYlN6P+ZVubKeskRTWgjTvrAWYN7KViCi1Xrk//h4gB4/JzrUAkTqt3wkww04jOFHDIudIZM1PJ52w42RZAW0jcKmkZ1x79u+CaiJ02YHwON3bKjb0IV1zM+OC388DnVxwDeeEaMRYIBiaQKq2+zQGYeK819jkwQkqlynEnyaokAgqUswnsczDV3W6XFhVYzX64LbsKC63kTiTxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6OBoPXCRXWxsrpkkMrNPCgNfT4emr1+yZJEQf0Dk6c=;
 b=UHlFCvPZiV+MgD7gAeqc5IluejSxZSnxktY4NZilPzc7y4v4b0YnpiXpRIBYHCtjM7sQJNlE5eTbHQaJt+o3PAcznQZq/oAF4aE5KLIe3Y1rczflLJJojvljgJ7Qc/ai4F31gvnLM2ZYRaAYCEN4UmcGgJI0WgKL4DmF4FOtHAHxNABACPzRRSdGLFbqVhrmnHnn8kTIO292j+yDQHLPrDik7A0WFO+4K0Z+WG29EKe8PjF0mkitFmmyIYYmD2P9+0u4EaAr1VB14BEgaL/orxT6X9iRxL0g0I0dwHYgTicBuxw4jNPr6Ln4KpJ1BRl4Xn3OTMPUsV7MPB3SDR1SXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:26 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 10/20] hw/arm: kzm: Store boot info in the board state
Date: Sun, 16 Aug 2026 21:12:40 +0800
Message-ID: <20260816131300.51799-11-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba84ac17-8618-4c24-197b-08defb986f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1xX2gtzBm2uq7htrkEpEwmAwSW+r30ZM/ZP09aknzj/nA8uPpNb2OpWXA098f+tgNa1lSN+M8ZTZXRlEGZ/eYy6mCE2bYNnihWA4/mc5elxy3FG9mItcLiIh8kSIGFuj5y+TyLd/fovVaYac6m20FpPPf/2oZfI/VaHP/v5O76BIMJUeKuZtfHoSs1vx7x+C5F4c7kDcvkuarlwdi/9Ezmhl3sR3DW5VxJlbIdGapuzD0jIz6LNN3H4YVVeUm342sAdzq8UH8EaS3hu5oauQYhE5rWDUC5aYgqAd8PrkVrg0Sb0zL311Fj10+UIBsEIiZGU8UPg4Jd/g+uDtzah9JdIn4Ic5Zq99gZ2YeegTwBV6wcUX1irqB5VWQp60o6EmgWhTtoF51PMCjGq6fL4I3oBBYJOe9iLdBj7Kh+DJzbe6HC0NnBF5bJl+3NDwskZrlI7QhiCx4PVfxTdNgY5N6cDUFlavryphcvVZjB5VKPCZqgFlwE4QDGC7L/bNsRGa6EHlCK9+L9eL4jwF3gVbUk0FNOdkzL1TVPawaud8188z85bgk28i5a/ZM3KKIjVg6BJGIrXDizx3qub9bObhDU0K+3f1pFkq/+WkqL9YvhZfSiUcFmCIhxQ4cjJaNbc1KFz+OTszn5qqQ/0kR2srnNrh0nvio7J9z1MUxjXzmZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yLNBtvNpHXfKbKlNn5CBgdrdX9GtRqqUQ/uI/wFh+T2AqwHHmsMq47uCbbrl?=
 =?us-ascii?Q?irvqWF3X3WAPKZKLHj2dbzjO4RA8l43kEtZ2JWoKxfWm3/+O4HUIGGn/Q7Gy?=
 =?us-ascii?Q?n7YhR9HPOmTu9rhjuSm0q6G7joyJ2y5evIqucmv/KVBtx8E2iRWJTj5Xvrfq?=
 =?us-ascii?Q?ZPaoMH/hXd5c+/Qw+LHSx73SiTuD/0g3HWB5YXNp/ZpMZReUINaQY/fyXbII?=
 =?us-ascii?Q?70KoFdaTgBTBUOPz/cY9+wR2QHdAjlMNUlbHSAeUD5I1MYJuPywfZTzqL8sb?=
 =?us-ascii?Q?DFMh0e2Iv7Q63/MugblAYiGwwxLbSR4DLs9fNKKjs8izn5GQ2300VN3bV4te?=
 =?us-ascii?Q?fn5A2fZTfc/GthXVDc222ptv7W3X6CVjdf980qSbPFaQwiKpFfRcuV86d9xs?=
 =?us-ascii?Q?4fjfllg9ZzxJ2gJ5PsXOpAjkh5Zv6ONvRXHb3qqb7CLQ0oGlANytRZolYvE/?=
 =?us-ascii?Q?l5nH1Msrp4DQFgEyS5mGR4G1Ejmi0MzqcoPdOGksHd8Y3TsjHuYrpYFPhSmr?=
 =?us-ascii?Q?38ZtL2j2/mTDYKc0RhYuD082pXdOWe6IKK9bxW4a1DihN2PjYTp3+QRiK5sk?=
 =?us-ascii?Q?mMMGM7PsvSZjFDXsS0O+7zZXR74+LHtJPkFIQHmFoj9Fsv5aPDK+WLQrSrgB?=
 =?us-ascii?Q?kaczVzUfEl7wmJV1LK/uRyJGjPt3reE5zyZXTBVBP9hZVyr156zipjWWNxLs?=
 =?us-ascii?Q?otD1t2ccohhh58SQwdBRHUyTHLIV7rywh6kOWH+oIbRRQhOkwYCuIZFj8yCV?=
 =?us-ascii?Q?VthO5qZsowS1IEkgZrr0nXrHwR0Vp6SnKHo6wX0vt2lzXhEg8ScLAwmPV0uZ?=
 =?us-ascii?Q?BPxpKEkcAmQjdakwyyqxlmUSVdvw2Zl4E7ji3m+733iHHHo0jZ9SUHtvtL1t?=
 =?us-ascii?Q?D756HRJ4IygdxfC2eWu4AWinKMkk5ZgB98nnPnmokv4+r6MDxXPLDxsl7ZYY?=
 =?us-ascii?Q?DnLqqyy+LGU6CAYjvF2SewPmuPGfbVL2fBmX9x51Y06W5F+ViGxkpSQxkdrX?=
 =?us-ascii?Q?1xlX7fsO7qwYoA4YCgn/T1U5QsjdQ0wUuUogjAl/a3IqfOgNK8r1XWqxfy9x?=
 =?us-ascii?Q?gm7kG8E5waYCKoHhteyh41azaZENCBirTKJyzf8HHM3zF8npdMKb/1Y9uKop?=
 =?us-ascii?Q?e2MXRZscz8KTQtdwuqswO2Vbw9c4JvD0DmmK0zA2GzcuD8HeepuXs5e60JG+?=
 =?us-ascii?Q?5qlr5+8c2X0thb8oAooKFeiVhhriQ5rZ3D9XfzH3SO6PO04iBuV+pqJLCZKS?=
 =?us-ascii?Q?mfRwZTAw7H1HXwRIo1K4ONa9cGvI10LTKIVjAecEQXfcnay/2xPfgu0klPxl?=
 =?us-ascii?Q?yOb1g3VuPL4tJjXo3eXBngp3BQbQxq0oqdPQqFAooLYvFUPjQBw/79DJLDfK?=
 =?us-ascii?Q?LV6yCzoqt9wnt2NxyYf/KBk7ezp16s72FSpjvvtQnix7b5RPqkcjkW7QBVJw?=
 =?us-ascii?Q?aOYnDbISOhGRj1+Xmw5O2eIEDzs8CVhw4IpRs1OVAMukxs6Y6yf8R9/ZgAOQ?=
 =?us-ascii?Q?CH64+xyhDeDVks4d+VDVuDGYCRhAWo8apocJO+eDBucI13MLdAIsa5SE3Wua?=
 =?us-ascii?Q?+K0ci/ENyl7+/qlbdb3QNZL46fhm1l4M6v6eQ1V9DRJkvcu5AArbWrt8xzIQ?=
 =?us-ascii?Q?0uuYeQzoB8yEmhBq1XTiD3o35EKwU56wJTPgFTfXkTQzIWyeA7mH13LCyesD?=
 =?us-ascii?Q?hmGY1eVZN5m6icJMAE5jRnjpAy2X5H2yYOGv+SwynbZZS6IXSQ1YCSATIQ1w?=
 =?us-ascii?Q?fAO8ZskrJhjxW5vabXuunbEEhQhhEgM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba84ac17-8618-4c24-197b-08defb986f87
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:25.9259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ6G0Pu95ZYa20KWycf65rbuGQD6zNLL3ekQ8fXBUmqp5NxwKkWoeFzvxHVm1cF37yhTM8tYgDCIkmPJczX3ArYltRUEZvsq/c0Mnt+sssU=
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

The IMX31KZM struct is already allocated per machine instance, so
move the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/kzm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 168ecf35d0..1aa5b49de9 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -54,17 +54,13 @@
 typedef struct IMX31KZM {
     FslIMX31State soc;
     MemoryRegion ram_alias;
+    struct arm_boot_info bootinfo;
 } IMX31KZM;
 
 #define KZM_RAM_ADDR            (FSL_IMX31_SDRAM0_ADDR)
 #define KZM_FPGA_ADDR           (FSL_IMX31_CS4_ADDR + 0x1040)
 #define KZM_LAN9118_ADDR        (FSL_IMX31_CS5_ADDR)
 
-static struct arm_boot_info kzm_binfo = {
-    .loader_start = KZM_RAM_ADDR,
-    .board_id = 1722,
-};
-
 static void kzm_init(MachineState *machine)
 {
     IMX31KZM *s = g_new0(IMX31KZM, 1);
@@ -125,10 +121,12 @@ static void kzm_init(MachineState *machine)
                        14745600, serial_hd(2), DEVICE_NATIVE_ENDIAN);
     }
 
-    kzm_binfo.ram_size = machine->ram_size;
+    s->bootinfo.loader_start = KZM_RAM_ADDR;
+    s->bootinfo.board_id = 1722;
+    s->bootinfo.ram_size = machine->ram_size;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, machine, &kzm_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &s->bootinfo);
     }
 }
 
-- 
2.53.0


