Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15449C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhV-0008Gb-Vj; Thu, 13 Aug 2026 11:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhT-0008GH-GV; Thu, 13 Aug 2026 11:50:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhO-0001rl-RW; Thu, 13 Aug 2026 11:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFBAExnjduaBh5fR+BhaYUTR0KPFBvJtX8mdaiHLj7COiq/JDt0vfKnRLZfBkfI4WiOvGre94KrIJBbReWzIVmAcJDf3PB91pZsToab6cdVJYuVbcNWAkb7T/0ShxpENDwX7zlpLrXgho/qhZzFzNQ+ycOWywt6/iqemptZQfYho5nWGwvRxA/T3JbyobXT74Ve0xrNQqNQeGLQCJs7IylHmHgOzBoz+wVPd6Yq+hlWSF+g2JhcV9+b+7V98HqT3LDdRfxFK5C/pWPpCtOBHOTi1+MWwlmONgUsJr1b5StuQnIh6yUIPBYpDTH5/nLd157OAeGCF35XwFhveGmjbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLHBjZ7VjmMIGrOCz2xXzQaj47Zv4Hp/lcFm0AE597Q=;
 b=QOFYqm/Ha3LY8RKJig7E+kkwjVtjO0IOX3puLmNR+hdDC0Dr6Uk3iXNauou/Pp7QGHqYy8aCnL0Kit9RijyFJqemoSsqwUJF8kHslEnMcaSeRKkDxnSOd9QmaKLFVqEbKhtHtJ/RJcRG3I1OcI0VgpVpvOYx8GFBUmzK33tJpCRtbby0vUbieKL9kWvXT2S/gk5OzOeA2G2UFaHaiJB+vJNJlNeQtHA3FzD3oXU9cwcl9BkVdFeqKmxUT3U4UfK8Zci/M1X96IW6wQPbtkaS8MgFS9G2CsNV7PjT7Fxg+SMQzruR3ro7Hh+affvbLRAfzWr7M9OAzwxtxfRd2Ipcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLHBjZ7VjmMIGrOCz2xXzQaj47Zv4Hp/lcFm0AE597Q=;
 b=NXoyEhA5h/ITaygYgUHZYpdcVfjF+r/iLPmqWdHoaClfooZkYeraflPHviP+doq0MaaruH5229otmixqfjYqv+DJDBKYePFkLCX9s0cP/6eMOq3Tfv9CV/pvMW/Hz+591LfuM01J0PJU9apwGjpMtih1cGrb1ZOnX/7bWGUasdTLZv2xZ0ZIG1LakYr6n/i+3mpzhjaCX3iYkVeOTEKyKZi9aoKyN+Jv64hpyDM4ctwQyPtC7DWvgGo6LbqiQljwHrAdhGPxP8VIxxSE1F8wLTVwi6/HADpzqoYZBhFF8dJuu5ZVbtxsxTptldsQV2prul8V1wWeGkWU0cksyrEHuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:26 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 07/20] hw/arm: imx25_pdk: Store boot info in the board state
Date: Thu, 13 Aug 2026 23:48:55 +0800
Message-ID: <20260813154918.996812-8-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: e00e72fa-b441-4010-2438-08def952980b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ra7jt7XZsyofI2Imtzi4dP33PJLiKuWX3/hJMZ5+/WCxbNhmsxHnudmjH54mxZA2oc9tz59Vl6GuabxmnzF7fPYryfDzjwsZRw+LuolEhqsV/f1L3u2bPNy/vfDU22Oa9fqvhziD/nL3dZPccNSv0NlJy3gwLaZwJG/Y5lnEq8s1ijehQzUK5NFr/o0mllNQAm+vHB46C5faTd2HLCmnNM9pi/LfXSdM70pUZAyFOAPl4UWmMKsb7Q/CL2gRZqGKYenuOIhDsfIimWPGA9gMKOTsASGPtdEuVep7wvcxBLFI4Yz8At50EA1uOjFJK+aBlCOWxUCNlo49Pd1iF/qVtT2uX4xwrfTC3GcazyVqKBqdjgYJ+R1/xICX/Z/R33TfmPl90DK7DWR7x3/77j/pr4gKQ43lK0kf0nYzCjB0WsLLDRDQJLN3LC948xgtwS2b2VNtrkxAMnI0StMhMXK3ie9mNlLTU/hoXrJ01Dy3awJy5evVwsxPomoqxgYeTUXS90YKNKQH6IzaS9+kfCv2FjlE8qPF9Nyl20846L9vOn5PPFmjiy3EOH+c/sRya9rBYSP1Ws/r75ZTHW5QoJuD1z6+hVTm2Qilsv6dA9yC0MII9eYm+V/3rNygjcWIa1Px0n+G2cHcINHD0G6tIJxGddjljzKClamSZZj6s4fszV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zrWlJNRugLoPiLaL3yfKOqelMzJLzXSe3jCSOWJBltgqIzlvq8u20ECv9s21?=
 =?us-ascii?Q?PPpXJLwmR9vLpckKZkGumtzIQgj3I4JABuTxkmekg1XduXZaK6S0bGBigEBY?=
 =?us-ascii?Q?6ft4CHNOdpHsmwytg8rf7IaHiuQy4cMZtbG4tDRIVKTohY2FbBo/+OUwnY9X?=
 =?us-ascii?Q?2KEU1TFBTiG3haF2XGn8ofwvYEfHhW1WWQ7kSI96fFqS7oNZ7g5Xj1rmwK+l?=
 =?us-ascii?Q?b58NIX3vIFaH8D1UW5YP15kgLEkKsV9xKoH9S+bmsnJcAUjjZsAj1CjsHe7I?=
 =?us-ascii?Q?IT3+ozT8V1qFXlRFSTz9uMSXScV+kKdT0QXAgo9IEBpUDd6+bn0k3+5h9Sc6?=
 =?us-ascii?Q?d28Zwc9XyvTWHKGBMnHRFdVZVOS5BroLECQXBuFWCQJTVBU69FrBTsSu7WR+?=
 =?us-ascii?Q?M51SykdapPt7bUwBEl3b6iKpWOpJSjI8gwXzs6QvVj3LkoMbhCihQSG/9uuW?=
 =?us-ascii?Q?G78GkqAHkWotr5eHp+eXkZnfT5crQ5VRsZu0y9oexTDlIqYGV56dofyO8zZ1?=
 =?us-ascii?Q?Y+dljygpKyeUEhT9J8+Eg49BYIJ0ZqGFaEBfom14DFcnLiOB1tZdQnyQLCpo?=
 =?us-ascii?Q?xk3vuweXM0nzlz5I2bQLfA3Zk08ceSdqdM2wWMoRB93Q41GYp0X/rvtyJbqz?=
 =?us-ascii?Q?cyynUke1C6GszWuAPeYXN3nO4e8HhziQFJhHVKP5VIZVSQJHE8FtYTfDfJfm?=
 =?us-ascii?Q?fTIydsCJA8KV8llhMlspn0j2mTciGZt2HfGkJLqGYpgJSJNvkY0Kbxw2NJ4z?=
 =?us-ascii?Q?+prqBwAR6SBPIpKcfa68MuZxrghvGFLwRFQ3LAShgMA9tlCenitfSbEgcjby?=
 =?us-ascii?Q?uSuOO4K75NbdWmskYiHoVFilDJlSm1mk4fas4t9B7n/CYDg4TOW9cyK4EWbU?=
 =?us-ascii?Q?jysn0z4tuoLtQPuCrJK7rJyhzBuj/WivSUyyCfwhvQApBOA5rf7MaAilqNE2?=
 =?us-ascii?Q?/dtQhmbYuYWyC1r6x/owsPe/xO2HQv3vrAArdP3X47iQsi5FxB4YeIhfzdmo?=
 =?us-ascii?Q?JvVWibEQsaUOV4La1gscAcTDwFMgOHhk5QPglwzl+d37ABkNdUJGrKXIrsp6?=
 =?us-ascii?Q?FcrDPR6NUUPD2iGVNpCRZCNUFDwmo0zHW0YQdLEqmxFu2kLr0FahGg4Qe9Cp?=
 =?us-ascii?Q?OSg54gJ+jYg2gNY5F0jvnNndVqhOlDGXxbgfmB5lM+XFX8rmNjZwHVWEM2Vj?=
 =?us-ascii?Q?GUyPoAYnelNcfCZNC0F9f072OfA5XqDCdA+ONi1/mDtlBFY5F/L55vB4hzV+?=
 =?us-ascii?Q?bfgrz7/bF3fTlJSrNeiuwbsI9JjnZWGW4MvoI0zGc8rvnvViCeqF53Cn+eam?=
 =?us-ascii?Q?nsrjwCh3svnwLTONZ+fMsanLkNEJOyq8IvE1j3wvfeYfIJMheKxuQyTK6kdj?=
 =?us-ascii?Q?QxrdJd15ofPVkJDfOXUQXGstrZQxdg3yacI2+v0+orzmHESI4QKM5o6xLQKg?=
 =?us-ascii?Q?fdUHTM6Slwl19ekxy32WMXomUVPWZ1uvsX4l65ya2AyDpR2smF+re7PNtDKL?=
 =?us-ascii?Q?lB2nsSdB3+xV9PsU8UNj9x33TLOaJxZ1NsbkyL9HjRQrEcalw6f28qSLfvLl?=
 =?us-ascii?Q?isDKhwrpw/RQmOaFL1GsiojBTNzcafpEokHLBm18wiPa0PehoCfRtPbk67UW?=
 =?us-ascii?Q?EBxWHkecAGQsWMi9rlQK2XbIaZLz5MvMYB6r2LHvJzN3Wa4xWV56hL9O0dCR?=
 =?us-ascii?Q?ALoRH950QLwrJ/tCRO9/QQZnOpCdXJB3JiV8xIWWE2tbtsfrJVCqjJUYujH8?=
 =?us-ascii?Q?NNALr//mLb7T0ahIW5zI4dni4w8e/rk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00e72fa-b441-4010-2438-08def952980b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:26.7542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TziZANaaMhuTXqZ1vMwxWsGylOpGIrwLQe5NTq30raYGAKwSXEYzvU8C2Caz4vKynArdvBr/D0oDfcLfWshaCAzvAlrvdDLGfh0Ht+rk5yY=
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

The IMX25PDK struct is already allocated per machine instance, so
move the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/imx25_pdk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 7ebd6c8eb9..f7a51481af 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -61,10 +61,9 @@
 typedef struct IMX25PDK {
     FslIMX25State soc;
     MemoryRegion ram_alias;
+    struct arm_boot_info bootinfo;
 } IMX25PDK;
 
-static struct arm_boot_info imx25_pdk_binfo;
-
 static void imx25_pdk_init(MachineState *machine)
 {
     IMX25PDK *s = g_new0(IMX25PDK, 1);
@@ -114,9 +113,9 @@ static void imx25_pdk_init(MachineState *machine)
         alias_offset += ram[i].size;
     }
 
-    imx25_pdk_binfo.ram_size = machine->ram_size;
-    imx25_pdk_binfo.loader_start = FSL_IMX25_SDRAM0_ADDR;
-    imx25_pdk_binfo.board_id = 1771;
+    s->bootinfo.ram_size = machine->ram_size;
+    s->bootinfo.loader_start = FSL_IMX25_SDRAM0_ADDR;
+    s->bootinfo.board_id = 1771;
 
     for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
         BusState *bus;
@@ -138,7 +137,7 @@ static void imx25_pdk_init(MachineState *machine)
      * fail.
      */
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, machine, &imx25_pdk_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &s->bootinfo);
     }
 }
 
-- 
2.53.0


