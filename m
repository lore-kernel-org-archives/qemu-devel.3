Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A38C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaii-0001rA-36; Sun, 16 Aug 2026 09:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiA-0001eN-50; Sun, 16 Aug 2026 09:15:38 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai8-0005Tk-Ew; Sun, 16 Aug 2026 09:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoJGKJ+PwuMV6tx/RbzjDSFObeYHVVLHxJZPRxd1tBsUWqPUqpsCw14J2nPbQljx0w2bjVxcet58lnG5QwL7PeXQkQOcZzHryCv3MisH4ZMRzKPBWChTMm+1Lipg2HOlA342iO53SpP38jpktZ7M2yQNrRui1TxgRrI/uMI9yQNiJPgPbij+nvqa8PrKKq85KTsHj/WTEqc8Bb7MGpfGC6Yxevs831SAQkeGUvrwwqF/OESZCdeSxgzSp5pbo8ZZdNKAqcTLDCVe9jiH4GdRYXIULorpW/yA2c02bBkjfrAn5RnOLjXAT2uTPh6+4cJYlTE9QN9UJr0Js96+67RGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB88zqiS9Exbf5EIH/gqmq9O2iYEJarvItcZThDqntg=;
 b=YLonmK9CrLeGu5mp17VRO7FxxSByE6g04LFfjp5x48a2QmKgYeNYbrgZRZmrBoa677TBVNUCqW9IxLpo5vetmoLB7SJDjtzl3vi5zKnrWyZt0lmqFmxpyhinVy1QnyyOUzPSNt0N4WYQkDLPhq0iIc6wrFozKflMUFWoo6p43EcsenXAomb71QrOLDKZgyeeJUYvIVxgv2ICqzzlIb+TS5vbuDlwhS5iPQHh06UvxY7d5gjoCEDcpXiy2sx+OsO/yXbU5f/KclQePwbT4hl04U3grDNBIG7poUI2FVoPc49tlOBAYo6QjOmU0xelviw8tdtpnOt7josirIwPR8VGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB88zqiS9Exbf5EIH/gqmq9O2iYEJarvItcZThDqntg=;
 b=nUvTJ9GJp+3Z6mBa+pvbZS8qFBjWO4Ek4Y7e+3Dkvu8Lwf1NNOKnmHW9HkdtmQCWrhDact8P19cGT0c3TlqjmnEqBfcHJ9tAzBG8E0j0n+b0Dpkl7+HAw2KNI7ajVnmPB80y6YSuy7jvHDH1zRNPRJMVtKctxiLliAdqchp7Kj2KFJvS9cqs1bZi2iWYXQRMQfndxGuAIp1hEbYjulMt1RIwkwfTjoOkRanJ1K/4LwSbQK0Xas1Tgp49YBWN1dXZ6qnnHxPRI/p+JlfXoXLBuVD60Tqw+D8+zUK8UtWFNSqJPEn75jWJEvF8H62F5U5EBwt3I7TQmKW4W0ZCSiCu9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:29 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 12/20] hw/arm: musicpal: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:42 +0800
Message-ID: <20260816131300.51799-13-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6706c468-775b-4b42-d9ec-08defb9871ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VvMVCuBDtgfEmrX+7IF4wvy2BTJClkFZwtfxxk20Rf3HHPZVNUObyyYGjSlFmYhNfNrzugijah8FAQWrZz9FpHwGtZy2GwmiRSBy8roardQb2PWiWOzaRwN/1iSvxVD6aOSkwEJ2Fk3PJuETsps0K/90MWzioLoSsLcCP8zcwgAPhmw/fYCDwUYTV5wBGg4qTGZ9F+yQyQhqtNazQC225YgRqdvlRmbAH7k9U3GTE5W579s05IWwp+mZX9+919Mb/uc+X31cSDVwYygVxthBLnPhsDZWWGIxV3+4g9APh4//zzraJHuCErugtTzAkJFJLjhIqDWh4lGjG3iy3gKDqTnr8HP3JC5J2/7Jz/CReIbhj1Kq9H/uP7V2VN76tM04T6HkvzkU8w/VJVcXINjr8cETIOUxY3oUbOGHxtrlGUw3inV9x7eGEzpdmkuPguBEeEEjeVH5mllV5iOJoHDRfqzz72bn7d7kUyJMwfDrRq8u9bADmHO6xWkqokokOozEpl6cSiSiivQVBu6mk74ACWIJmITn+zYaXf6IbxIODEQgusG1eiGGRVUTb5+9VhDfrtVYeTm3hd7kC2Is+ED31kbJtvH5n3+DxrASiJvwoxIA7/G40RMnVmvxMfOVK1JRUTwweaVeHjDnYM5AVS+/yJT6Pk4V/xSt6A70iRbQwVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fRuA81Fbz9GhnA8B1wGvm23iiSlukU64l/+f0c2dymeGgxAAo9GpA8Jr26SB?=
 =?us-ascii?Q?XSLfnwudMeg539QREwaAdIz9GqvWODlmYxV4G+VgGr64KCeXJNxtJ07JFi01?=
 =?us-ascii?Q?zYYNtb3UQDUU+SARhbL5CBgvHO7QCHrocNOTyY7A5ExFUO1sWE1Jz2dgYUCD?=
 =?us-ascii?Q?xMY/w5B7IBFJQcWhtF2S9OgwaMbsX6H9EA7QNvxtrlvDupCPml77A63Ti79s?=
 =?us-ascii?Q?FKrjXZwn6Nbg6cLe4Dqo9VPf2YYgmmCqGSpLz6NuDEP7U1S+WgUcAzQlOd+g?=
 =?us-ascii?Q?O3nlu9qYI+I1GP8QQfu5U+mcrD9OJvuuewgJrkJ6sPbAWG6Vrz6PSlE0FtgE?=
 =?us-ascii?Q?Bugmuc9yJ2Mt7jRhuO4zPnw8Vw1J/hHjdZYNAbhPhC4Sa5vVrshE2gI46Mzd?=
 =?us-ascii?Q?W/afS7LVOxMzPNtMR7lHIVCWQDS/VfLrn4UQYjSEohDnuwS2tY2AuBjlLWdq?=
 =?us-ascii?Q?bPELTKJo8Ac9efnL1BwHU3mAQHbIWStrKQ64Egq8+jcghFWtuHxaw16UyNsD?=
 =?us-ascii?Q?8SaSXS13HEd45m8sDn2fkq1ZaIcn4YuDa5RIY3O0Opcu7j90tqrUO4bQUt9M?=
 =?us-ascii?Q?XtQP9FUwcy5HgpvXhG0xmg2DuUX78Gvha7XQau6WSHbrOBnoudXjHHq7zFq3?=
 =?us-ascii?Q?hJOj1IMKq/yq+Ha8u4lqSSOQMdhzwklp/+umMV93g7Xr9FTNi/+J37PHjUof?=
 =?us-ascii?Q?Rz50lBQGNouzsp4NI3QWnF8LVdvVAJjgm5kohF0xNhI/NJJY1ByoTtz9b7Hh?=
 =?us-ascii?Q?gBGuvAaXODq/gHeg6yN33AcQ0xFYNcOIKWEAhmiKtYglIFcNvxJ8C1CQk1MI?=
 =?us-ascii?Q?I7Bfgi3eAlJl3nezq2TUcaJKoPDvxZ4e5IfAMYwyB4hcD0aJoIqSNXAijpZL?=
 =?us-ascii?Q?kGaxkW2aNHmgwdXAcbxf82V4fDz4QP3PwcJkigRhIVN68/c2B5ctt2yxkpE1?=
 =?us-ascii?Q?vUVHrCol6DqV7U7yylp2+PAMuDeBBAlYp/NN0V6QNLvtgRL2UXMIZ7a59Gpz?=
 =?us-ascii?Q?kuvhk7A1beyr2fwgFtyCVhw233LhlsEbeyzJZmZ9p8f+7lXjZ4JDHBMBhURn?=
 =?us-ascii?Q?IOd9fa0tPNllSwnPD22pMfxHitXrAnB884GxmX34srG2GcXHUoQkp3Cw++jy?=
 =?us-ascii?Q?Tjs5bbs72j8JaMB3CAO79ZahhUCkxwUme67xbbyeeVaC8FGit3AJkMQGwx5R?=
 =?us-ascii?Q?O78P6mPx8jPg/hugnsg3hZm0LKp23j4a5NKoj3ykd5H37yk/klALWmJc7CWn?=
 =?us-ascii?Q?2/KTP2oinYNQuyc8bkmrpKYRqAczsPsoso1bD6HRHfZQIbinjSgp+px95ml6?=
 =?us-ascii?Q?pBA0FpHzMrTCnup9V2B3SE314gsSe+C28QNaKgge+vKcuYBIubh8pvKbxQGX?=
 =?us-ascii?Q?UYqufg91Tximm7zO9OOcjosXzU7psy9L0/9buskGKj3ZGw84LMIEhCVXJhlK?=
 =?us-ascii?Q?dutrLCQNG+n/tJoPxzx54mhDkFGos6K7ai0/avH+1YdVcQLOG2w+bizr+b0/?=
 =?us-ascii?Q?FTclq/su9qwgKgNvRC5cJrGFKY6xMK9SFDK3bhwjKa5WbeRCFuS8+AKi171C?=
 =?us-ascii?Q?fy3RhMZ4tJt6Icgmpr8r10RsL2mpz1u/mk46TmMfBkslBGMNt+PaIjV0A1Gm?=
 =?us-ascii?Q?wWv6oFNtIgVwLEV+xASkVsEXT1x5OZnBPBzFBePnz9hoVCE19bv9S+10BZo5?=
 =?us-ascii?Q?eHWcGegZfZSZAeD9an1WE2T0qn4LoKHlGJFQmmruZxmk8olHoJxs7sjOzPvf?=
 =?us-ascii?Q?SiO7v82Favul7KN7ibGfv/swmkjgLN0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6706c468-775b-4b42-d9ec-08defb9871ab
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:29.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRzuR3apdAYrTKRBCvHRbzrD4wyJaNpzL3zo9W9laxgaP0OKTY4w7gaqJ9ftZkhXCc1LrHjszUQXS4xHjfVP8wPkaZaXwGHLJIrqY4yWMEk=
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

Move it into a new MusicPalMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/musicpal.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 69e83bdd97..8a70ed7377 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1200,13 +1200,18 @@ static const TypeInfo musicpal_key_info = {
 
 #define FLASH_SECTOR_SIZE   (64 * KiB)
 
-static struct arm_boot_info musicpal_binfo = {
-    .loader_start = 0x0,
-    .board_id = 0x20e,
+#define TYPE_MUSICPAL_MACHINE MACHINE_TYPE_NAME("musicpal")
+OBJECT_DECLARE_SIMPLE_TYPE(MusicPalMachineState, MUSICPAL_MACHINE)
+
+struct MusicPalMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
 };
 
 static void musicpal_init(MachineState *machine)
 {
+    MusicPalMachineState *mpms = MUSICPAL_MACHINE(machine);
     ARMCPU *cpu;
     DeviceState *dev;
     DeviceState *pic;
@@ -1341,8 +1346,10 @@ static void musicpal_init(MachineState *machine)
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(pic, MP_AUDIO_IRQ));
 
-    musicpal_binfo.ram_size = MP_RAM_DEFAULT_SIZE;
-    arm_load_kernel(cpu, machine, &musicpal_binfo);
+    mpms->bootinfo.loader_start = 0x0;
+    mpms->bootinfo.board_id = 0x20e;
+    mpms->bootinfo.ram_size = MP_RAM_DEFAULT_SIZE;
+    arm_load_kernel(cpu, machine, &mpms->bootinfo);
 }
 
 static void musicpal_machine_init(MachineClass *mc)
@@ -1357,7 +1364,9 @@ static void musicpal_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("musicpal", musicpal_machine_init)
+DEFINE_MACHINE_EXTENDED("musicpal", MACHINE, MusicPalMachineState,
+                        musicpal_machine_init, false,
+                        arm_machine_interfaces)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
-- 
2.53.0


