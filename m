Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D63C5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaio-0001zF-HM; Sun, 16 Aug 2026 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiK-0001if-JM; Sun, 16 Aug 2026 09:15:59 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiI-0005Xo-12; Sun, 16 Aug 2026 09:15:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffnWhXS0EMe3jQoItp7rrtJn8qKf2e6+GOP1P5PvnmITON7m/MYc02CeodUKpwYTclfTICU7ca7MRaZHxxxda64MILa1VV2pUUXxNF3ENiCYxEkGIv3Jq7rOF8hS7f+HUqB2oKPqqPMp9DZCcJtOIgWHfoz7ieAG58MDO7/sZzHhSs++qGHwA3l4nOavRN4c/uwmf5jrVzKIvT1do8uhAWCj9xQKzL5I9b+DleMtyCWjf4h3JIbLZ3VsbcEgR2KBi0hGtTHVqIp09q84wIIT3HJJr4WtsU0l8NGIKol60zY0FBv6A/d7knI4ttWjQNbMEQu6ki+cInVMfD4HYNTy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpFsRVr2kYH4MyeGamKl8t/cHXCoO17zBgj0mucnpgM=;
 b=o0FduPs4xbUQI2NSZ9TUpeouLmMYJa8gsbvbugvD4Vy8UKPfGsJLyBcNSntlYKv1A61nBwqZocvcOnPMVXU6usfjUeeWD4XEJ5Ron0zngfinlpQgULpIVIt3GIWetLJvXQiIu/niHfryAIKXxCdbKK2bw8ALtpDvTBf8CDMlgJxTM6n4wv9mwy6P3CKidlSbWgEdiXEJq4Ef31Ny1smNyO0XXGBzeKSzjqvqReg3AnkGDKPNTB3MQSw8Hzje6Qz3gGdv7xcwVMpknEsEsdn1r06iWRCmPQgKZL4ctnKt0kCOqpa/zqMWQgI4UvLsjzhSoSmePYFHNntDZkKUhAGx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpFsRVr2kYH4MyeGamKl8t/cHXCoO17zBgj0mucnpgM=;
 b=riuNsezyJxjIe4A9a0T8j3ZMkY/Z/6XLf/qHf4H+uSnlv4H/DzncQjSvqMyBzAcG5BO7VqJ7Q43z99klZggsVYa7iTZtqF8/q29/C/o/ERyPBIn7XkgPl4tsICfj5bVFlByX7jzbhpxIgrc76rD1RwkReCiO+VbtpnPwzKUyU+qKs7kzQ6dFmcxCayvIcfxbNeZeY1NECZ2KW0JC5Gvueje8Nm+YExL8YkMZW0Uyk+eXo89MQDofkSoGTskjhXHd+8W5LRHuc4Vtuffe53EGGisF5i++N8GLchQQ7i1KRDbSfjyddgeTwWggXPQ/H7hcUwf/QeKHtKsfQPwU9eLaOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5475.apcprd02.prod.outlook.com (2603:1096:400:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:36 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:35 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 15/20] hw/arm: omap_sx1: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:45 +0800
Message-ID: <20260816131300.51799-16-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: ae84ddea-d446-485b-d465-08defb987523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sN6DOcvYtfBsrwaJYO41FIDZ5wO4Id3mehR/lIf3IVSyT8SCaUw376vAocW3IW6jFqdx7nf/t3Dgt7UM3VXbNPQ3iB8RPUMk7/ggXTT/+8AtqN77DeR+CTCPB6bmwVW3Kyd6Y6MblYroRHtNzjDtmEA+ulQv3d5/OcakPgzEsKfXbqwttkLCYfYgGclv5FZ3EIc0OznbOcT2vwSfbn9pRGrnqGTmwi9Bpa2jdQhoslBKpZmROy0AEl67NjD/ZjAOJnpSPHvuQZfSs5MznYG1p/ULqZp2K4zTlmxP1q2Q4Bk/Jzu+/JOS1uVOwA6ggYP0jLZPmIQPSP7Vd/cwLW7TIQoKboTBJCMSZ+njEPs/EWgawDEhQmLofbD4jGQIK29IrAkaQFyLNpweYqhkwoG9O7M6tiGqCNIMKl2rgevfhn4e5/vn4QGQ1w7taKJaZSEut1F7lxGCcmYgBDRf339toVS72SnB9l2PUKbJQgkStJDtYENCBpNX+1amNfZS7z5H/mK+pYOUH9dn0s4+lqP3rS3eKXAii1LIgFL0CvmWWJ3MKpTkVfSUP3XZim6fPn0iHJfnE5PWPn0LDPvbEahWNc3w3JWUxPwKZrIRbMEGFJjPmkJQvKUjGfxWSzInmxd9AWXy2gbUSnLDMV42MDgvMglDP5w0T+QMFNx2x/fhH28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hGI+a3sefCJQ7r3TxN1k1ody1TNWU7hVSsf8SewCUUwi9XYKTjrW5eODgjNF?=
 =?us-ascii?Q?u4Q4RzvqLxYz6ctcubmZIPLaxI3CmhPhJXWZ6IG2cjhdW1vsYwU6wcorNy0M?=
 =?us-ascii?Q?TnwoK0YHXCQjF2FC0Zf+m+25oKLSTD4k9SF+itRMA6D2GxrkY5yw11SKR9d/?=
 =?us-ascii?Q?jWbAUZyORwiicdtWZv+mZChyyIwvZj1xlXWp2Xkl4mXuow6uLTwt3DPjKCYi?=
 =?us-ascii?Q?3EueOSpvYn+kcPMcRtg8t/k2Paif0QhW/z4LajRxEhM9ULUwm6F3lpSgL3J+?=
 =?us-ascii?Q?3rYMBXDGyNX0T0fx2jCuwHMI3JNS51bdQrHp3iqghZKeR/ezCz7inJmcIou4?=
 =?us-ascii?Q?uO/v1GUnd4/FnHHVjymrNvYSA+WTNlV1mgYXkQZKa8O9FHKPOT6L6MieA/+v?=
 =?us-ascii?Q?I+C+LzGW0OxbHVmbx41+2E+QyL7I8e7uT2UjNrrXvwGvcJjvI8PLVw/LwyXj?=
 =?us-ascii?Q?W2WXzOH7Ld4MfDm5Z7hlTAi/ZXhPUzRwyjxfHksMWAwmqi93tSKOYctTOMD6?=
 =?us-ascii?Q?9KQRL7phdCs2V14iUXSJDIEoUf42Y7GDyh7IALTwlz4QMJLLcL5WETKYcY6a?=
 =?us-ascii?Q?MfppXcYsYJ8II6TdkQFfC+PwgaFiel3HyQsy32167hKvkduFlr4DaMcnizgc?=
 =?us-ascii?Q?t7S/xETqQK0O7X7ZExnuYpZjmVgAgcyViFT9rltsQa3v9UzTx9GUqxgsuW2Z?=
 =?us-ascii?Q?d+4JI9lF2emhqSpZyFehjwxcNGFiGxNMJlYZqSoqC5DrRTnvKNyUYczIGRVY?=
 =?us-ascii?Q?NQL2rg3eUsSox1nFESeKyxFOnR91IMTXSc867bPWBTO3eoQLwZwRuaEefGMJ?=
 =?us-ascii?Q?s4TAh6awdD8TqQEcO61eM01+yZBbvNwr7ZKcSiI1Zc+LqKzTtDt3HEokkGDF?=
 =?us-ascii?Q?pHWEGAGccRYpoMZecaXiBMSed4YnVl3WnEdANzgPsBu8PxZKUoD4VX8UtPKU?=
 =?us-ascii?Q?CTFVIQsjEoKs/Ma2V3dkuMZ8q3u/Ob+NOLCt/OavskrVYJpRej80NEETCrM6?=
 =?us-ascii?Q?sue/0JeTxbASuYJrpUJvuFBlZD5+BEfkUvJeflg4aST5k8STXGnoAbDoimH8?=
 =?us-ascii?Q?5H2Bf0WquG8TG6+eI/l4v8mpqgHtWufmv7BKmVpKequ8RA6W+Q8xlZLlKVca?=
 =?us-ascii?Q?/X4nhQ6RXmQ9wy9hDjwGf9f6JHTmf670Xqfjr/xNfwfR1G9kCLGGgxAwE5Jy?=
 =?us-ascii?Q?JO/Levv2Yv+WpeWSiluxeTgIwmOp0f/ZKWW6RvNHjm9UEB5MX0+5hWySHxbw?=
 =?us-ascii?Q?IUz4bDMoeAjxmBMYY9x5H1Bd4lppJcDBbMDK/3WnRNsjq41RiZ1PKV1UD0zS?=
 =?us-ascii?Q?HVJeNDVRRyO5ylU2T14mcd7FTkhLXjraJsf258OHtb+XzLag3DosAjO9Tsr3?=
 =?us-ascii?Q?Ssr0zy/YVzeBcp1cyaBJgWFiT0d3Y1OA5lG/VDifL3XZMTU6GxmSz5vvsA32?=
 =?us-ascii?Q?l+oayz1tumbrSYgw0G9twUKFLK13Cbao4et+u1SfE9NpOQrvA1euKWGwBY9f?=
 =?us-ascii?Q?4/fQkCXQLb5mDUk3FNWy5YOmc9sPA18A6+B8cqkK1Zns2f7YIsCqYLQbyImu?=
 =?us-ascii?Q?JFTmzRn3pl13RFXrpSzeb9VjfHraQPQdNVATMv23Z4l69E8bwR2vqchoJ8Al?=
 =?us-ascii?Q?+e7SnnwCppQQVqjHdNqGmeq1FnFT+TjiOp0XzVzNVznZ5WMgyjtAI59OiAmS?=
 =?us-ascii?Q?ocieFlMRd3widkPQ1dD3d2Ez/nl5/vWF1mS7mvvYZ0htJnbzjGQ1ZnE/qrW4?=
 =?us-ascii?Q?ZM2yRDnQHJsx0u0mfsoR9dppTJYD1BQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae84ddea-d446-485b-d465-08defb987523
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:35.3445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LQ/RhAKFmAAhw4qlo1amfJ8xU7UMNB7RNB1y1NzGG0eTqPjsZ3SKCEFtbebX5zYmQ6y8+BCKAEo/TWnrik+uzUvPOIc7v/qv0mhepku1Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5475
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Give both the sx1 and sx1-v1 machine types the same Sx1MachineState
instance struct and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/omap_sx1.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index bcb7105323..3b628d13cb 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -91,14 +91,16 @@ static const MemoryRegionOps static_ops = {
 #define FLASH1_SIZE     (8 * MiB)
 #define FLASH2_SIZE     (32 * MiB)
 
-static struct arm_boot_info sx1_binfo = {
-    .loader_start = OMAP_EMIFF_BASE,
-    .ram_size = SDRAM_SIZE,
-    .board_id = 0x265,
-};
+typedef struct Sx1MachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} Sx1MachineState;
 
 static void sx1_init(MachineState *machine, const int version)
 {
+    /* Both sx1 and sx1-v1 embed the same state as their first member */
+    Sx1MachineState *sms = (Sx1MachineState *)machine;
     struct omap_mpu_state_s *mpu;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space = get_system_memory();
@@ -187,7 +189,10 @@ static void sx1_init(MachineState *machine, const int version)
     }
 
     /* Load the kernel.  */
-    arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
+    sms->bootinfo.loader_start = OMAP_EMIFF_BASE;
+    sms->bootinfo.ram_size = SDRAM_SIZE;
+    sms->bootinfo.board_id = 0x265;
+    arm_load_kernel(mpu->cpu, machine, &sms->bootinfo);
 
     /* TODO: fix next line */
     //~ qemu_console_resize(ds, 640, 480);
@@ -220,6 +225,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .name = MACHINE_TYPE_NAME("sx1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
+    .instance_size = sizeof(Sx1MachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -240,6 +246,7 @@ static const TypeInfo sx1_machine_v1_type = {
     .name = MACHINE_TYPE_NAME("sx1-v1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
+    .instance_size = sizeof(Sx1MachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.53.0


