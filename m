Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC75C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhl-0008NA-Ph; Thu, 13 Aug 2026 11:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhk-0008MD-6c; Thu, 13 Aug 2026 11:50:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhi-0001rl-K9; Thu, 13 Aug 2026 11:50:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrGi36nHa+UkXh0j2e7NAw9z2+CySdcpiusy5e08QC2H0qN/WIsKgQCAfFjReQY34PSBlXnNejqEaRnIu81+fL4YbHQ6XKSpG2I9hvwozwB8dNqMzjK0omLYTgeqRRxXmXTOQZcFLXk4mZYovQcZfPe92a67d9D3zAGv+L4VfhGV9lrwNGHJS1Cv3zp/Py7E4rzlSBWTbvoF+AOENDM5YNgGBEI5cw4WoeghGjRrDIKfJaOhTYVxtHB62wHPIylxxuuBY6t0eTc/VYsfOppCPMaot6ZzG9OtN8frvy/mNy9Blt5P9utt7I0rCXUF2m0551t8YfPyY1lS6Ky3bc5QWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19Bw+RMIYTnqATMJj9/SYXtw7VkM+CbPt9ouj/bhMNY=;
 b=HBj60U3q6Yl0x1ulimNoNS9uSQgDhgB4ByKSS5ljnPZp/e2k5X6M9KyTmGjcya1bOEne6oYxInXnIBeyvFyc79mtlQxpYdrxjzCvG76zYBXLW06V7i0UgVFoOewmNZvsA6g2kkCpYoFcz3IAsQaiwW4VVuPY2hdQrgMIRp8/vUkdWLFZXddt2awvj4mxyQPyZRsNF/kQo5nPJTOTeQrOA7eqnbvZEG9e/W3pvnT9DLBSJ6cgUzoEMGBrme1TlsEpnJOrv+HqvI44n4ZAnr6I7WMsz6Wxts+6Xaj/Sc9//6vznJMd1XhO728KKz0NS9L8Xz3UvX+woum/35sqmBIhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19Bw+RMIYTnqATMJj9/SYXtw7VkM+CbPt9ouj/bhMNY=;
 b=O+leTCiab+spg7nTfyQPhIMEf0K0AhZ32ehhr7jummJl+SfK+D1EzVLCblJMQVn+jJ26jnOlXHOtL6grsI8db4Lwpe40FHtRUZdVP8HarS1DlhEhotUr5j8lcRyKopGy0vCaNEdPTy5A8j+ZQ/IF466rNBRBcjaCqMdR0rNEdFsgM92f++s7tWIh5dAWlM13wzrE6BfOWWby9G5hYPYZfLnrlFfasRTkjWJOSibUfCCnFKgLrXmTHlznh0kJXhgaf6XqXH+OnjEgsWymjxrJmou4IGO0L2JzM73Wut3jq6smPlVlNNy85IBkHE+7abARAl8gj8ZkLe3PA5fGUBAa0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:45 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 12/20] hw/arm: musicpal: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:49:00 +0800
Message-ID: <20260813154918.996812-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SI2PR02MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: c394fad8-1cd2-4466-96ef-08def952a33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pU9i1g0WyetycOrNCiYxExYQpA6u7MEe1f3KbFJD3zV/JNIjTxDNsukF3g63FJRqKLkjUW+q4YrwydgYVVANbQPNXANGA8DXJzTIfJ9QuPm1STBuYsWOiRU5waRjz+kDYHK4k24gbWyAPGjJu2PhN4x1jI45ipXV5+Dlk2mDgjLzepziWX7UwFrGslzL/Yhj1GWGlYADvb7j9TrBg+R0SBduaI9x9Vb3x/NPWm0gTku4Vunozo3YPjHTWK6BX3ZeDzwMmhUr5vPfmJoI99uJkY5ThRH4/+SNPYhrQbL7kCMKoh2k41ki0dX+mK30L+ROHWEeKgyznWpg4GjbPSIu+fdH5CyLSIR/9PAigyUCPZCf0E7y26cZqS4TBV00fPqa95Dm8djpXqzdqs8eLE0rY0hrKpcRmE4iYwmUjRFJ3wxE3j4WpPB6Kqi7EuggATkfUycTzeOzrtHGfsxImvY3UsvBARbI48S+lkSW5/wmQl3FlMBbz3eo8vtn9x7qQPragxYtA/VWUo793ScjpKyz6j8305phU9azcs1p0MkeeqUI7XICAtPrL7jC37Yes7rUrOZoDTXpGOL+5GjRTPfhf8Mg5WyFlBGP+RZB7r4hjLO0Q3+nIJIImNCKr/sEujbidjaqPY+EVvtkNgMkTkVzgx33Yqtjeb7PiKS7nP8BCRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IfP0epvlVgOilbwHT7cZYFtEGbKkkooSnEOt0c+MzJpiB/g+KE3scAxf7rQ?=
 =?us-ascii?Q?RESEotEU1zzCgvqp6gwC+QL42oz+SKo5xI4eISrfpact3PTXcF/DTxsQzvaS?=
 =?us-ascii?Q?wTkDC1oaWUKKagreBtsOZ4n7J55dwELn+HGm10Bz+YVGdXQHAcq0o+ZsXl4y?=
 =?us-ascii?Q?O5h19kQD14Xju2+Wn+ksgpBs8mJ0Pk3b6b1MxA7BZGzGrDdSGMcbCGhI6KV2?=
 =?us-ascii?Q?jVVobV7Dn/t9GOpjElvbTQU4AeCBJ7Ak5lSEpj1K5Cn4eDr/l2vpmIY8oKjF?=
 =?us-ascii?Q?eKB6x/KOTLsZ4Hcmg1yOqeeHPgFPsFlkwFV9xbGFmkZPftYTyintj+htesTN?=
 =?us-ascii?Q?kvjjaotkZpMSCiaGEua27npjMT1yCPUqI1OXwsEFsDX1vZjShHCm6oRGl0Nf?=
 =?us-ascii?Q?nyNhk43QAC5Mq1OkFuU+jXK/JZd139QQQc6uMAk+RjOqT7rsM4RcBhFnbra2?=
 =?us-ascii?Q?v1uBSyiTzZYUpsyBz/PpvyDBeU4OuGbSNx5oXRCDYxUpIBBY7a83eA550Qkc?=
 =?us-ascii?Q?a0h2CfmwBe4zOum6wp0/oKonn6gQrimiQB1NNWAVrrzBuPjjGavfyoW2LdDB?=
 =?us-ascii?Q?Iwu7kAwPX0oViRFeGT43bN6S4zGwqKjQJm/Pw2oyT3qdh2qk49wN98NZX7kX?=
 =?us-ascii?Q?LgZqxY0PDJdtxagzAVgzl2nj0jy3Oo3QqLC0ASP0XAFkq2jP5HeAPJnyxKEq?=
 =?us-ascii?Q?UIM5HhB1UwKrglQH+TgREdlIsxN4NQlnlQVjTPGfXV3sie1Q5QaFhyv5MX8b?=
 =?us-ascii?Q?/cyUd/hUraXS2OBCNVydQ1uBzZ2cYfUs2n/kWcnLO5T3oG2/vQWBtoeocoDz?=
 =?us-ascii?Q?iOZoG/J1dM1HSuOGwRmJUzht+o9QXOQJ51Zd2ahHdnebNFZy9jO1CmRNcjnv?=
 =?us-ascii?Q?cPhKNfhvnL2L/b1qY70QYs2j3Tta/3tAxVcxuHDvYjp/5sKQzeM3ipQudAlI?=
 =?us-ascii?Q?8HcEnHly2KSUkkd2HfrG0U6JDl/XCvyRgBDKpg/UoZz+3VO7wLMcZ1Jdu4pT?=
 =?us-ascii?Q?jvaxnZQO+ozov+GejLY6nzqUDbqm2CH46FCAyzZfF8XNAlooX9C/D7RwNMkw?=
 =?us-ascii?Q?1rMozWObK1nby4Qr376O7VQeR+Z3s2yPSyts6p4RZYbM6tzmdjW/f0JGDhr6?=
 =?us-ascii?Q?w9poN7OQTmbm+8Xpn+qWGgg4VeFnXAVUGBsWk6TBDNPG0t0jNfNsV03UgphM?=
 =?us-ascii?Q?KP/5ZDInoM3q1tCwZli8pJpIRG+wKVAaQy3n2bL3wm9XkIXOcT50Wh8Te9C/?=
 =?us-ascii?Q?CT3syU3xJvqLSZbV+b1lei5Q0kOyz4VdIWcoKdA8YXbU7Co1L0fWbL7j4Kta?=
 =?us-ascii?Q?jF7Ocb5/ij4OTDbJuZRz0L8UmgkZoqY1NTmCszP8UL3OIuOe2LQRA0jZ44mg?=
 =?us-ascii?Q?31obrIoqPUNaJiIML/caCwgrq6QtJAiHXfudWuFek/Kao13i0Wiq1RupPS3W?=
 =?us-ascii?Q?Ozn0k3QFgc95uQxaV8t7CTZkkXTnF5ZyzvZr7mgjMUng3iHaSMqz3yHXKnRa?=
 =?us-ascii?Q?TWL7WgEH3a4f2uNeLz+KYj9hxxK4KlPmRmaiAksD2Vqn7MgjUhhFeNniXShn?=
 =?us-ascii?Q?rApPARXxr7R3TVpqJ1FqdTP9d4KDdTJgUcbzt+6Z05DI1UJQtRxOlztRKm/F?=
 =?us-ascii?Q?av01hf/bq0bkszS1RoG2+RtQbwsrdzeSjLcIcnwf2osllDOlggksh2G5SiPW?=
 =?us-ascii?Q?3RJJoRDrNpt5CybrXtJuQrLCEyZM3VJCr+q2MtEA4XO3QsPY5hQFzO9v6Gst?=
 =?us-ascii?Q?GgoL7Xvzlq+HsZozwpwwU7tltLa+Vpc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c394fad8-1cd2-4466-96ef-08def952a33e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:45.5664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qhTcmPh45T+T2wDAi2TdHqTOh0NJ1PbP6fQ6fY4S6C+VMObAxw/KM8wCaPWV+MKX538h7EPLxgqs1w22BMO7ZHceSdumhLYGD+iKdk2/hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
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

 hw/arm/musicpal.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 69e83bdd97..158a3ccae4 100644
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
@@ -1341,12 +1346,18 @@ static void musicpal_init(MachineState *machine)
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(pic, MP_AUDIO_IRQ));
 
-    musicpal_binfo.ram_size = MP_RAM_DEFAULT_SIZE;
-    arm_load_kernel(cpu, machine, &musicpal_binfo);
+    mpms->bootinfo = (struct arm_boot_info) {
+        .loader_start = 0x0,
+        .board_id = 0x20e,
+        .ram_size = MP_RAM_DEFAULT_SIZE,
+    };
+    arm_load_kernel(cpu, machine, &mpms->bootinfo);
 }
 
-static void musicpal_machine_init(MachineClass *mc)
+static void musicpal_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Marvell 88w8618 / MusicPal (ARM926EJ-S)";
     mc->init = musicpal_init;
     mc->ignore_memory_transaction_failures = true;
@@ -1357,7 +1368,13 @@ static void musicpal_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("musicpal", musicpal_machine_init)
+static const TypeInfo musicpal_machine_typeinfo = {
+    .name = TYPE_MUSICPAL_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = musicpal_machine_class_init,
+    .instance_size = sizeof(MusicPalMachineState),
+    .interfaces = arm_machine_interfaces,
+};
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
@@ -1383,6 +1400,7 @@ static void musicpal_register_types(void)
     type_register_static(&musicpal_gpio_info);
     type_register_static(&musicpal_key_info);
     type_register_static(&musicpal_misc_info);
+    type_register_static(&musicpal_machine_typeinfo);
 }
 
 type_init(musicpal_register_types)
-- 
2.53.0


