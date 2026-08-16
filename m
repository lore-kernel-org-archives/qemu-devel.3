Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981F9C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvai9-0001dU-9t; Sun, 16 Aug 2026 09:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai2-0001Wg-Mq; Sun, 16 Aug 2026 09:15:32 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai1-0005TH-8h; Sun, 16 Aug 2026 09:15:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfFt0NvuMwXnJVOcKd4fEJ8J6H1hS3ssoMewavKImpxQBYFxzLii+Fi/R660HykXvTgPz+InqiPOzVGohX2LA5G8W3Zvw9TG8TULdTqjEP7gws1ap4K3KzRvwBFzVJneJxVwiYRDvBX1VfSVwJBMSD4u7s8EkY1Z6/HQlPmgsdYrVvli8nEk3PctNapTvY+d/Gv4rASFLOCPXFNW7YRcOiWiCkpV5JXpNdBbFSEaqUGb5qHFT+kT7OHWB0w3QYe7X8pwzdjR4stxF3XN6cJ0YLMI4juBfOnocFvjdz3uN77lMf16Nx+59anyOwjqSNE7OxIXYlBwT+f5XhP6PZ7KCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLHBjZ7VjmMIGrOCz2xXzQaj47Zv4Hp/lcFm0AE597Q=;
 b=ZdMtQ7VPxgH9YuWfe2WBKZv9vT/o2YiwtctNggPpCZtLmdgGZ7MLv2k76lL/OM/kVouxHzJPPqHsH7KZwuiFqA4WZUVPGf7yjAkyeObJSjuHmbU2cTg9Ch7pOOtqaXy1DTaBNg9/VuwlCIBoJr+VFxAyn+mAxHloRjU2010Y1OAVRbexwXV5SVYesPOMrOQsIDkQATDZ2T23qMMdBylAfVHIFgiMU78kemV+n+GEXOJ0WdcZJ5lihZJqfLJshph75w/za3YHkn4jU8jR7vdRO30l0e4zpH9x6Z0q1bzyCkbzyXGSnabJgDU9FiYEYRRnfV89bchXnNyeolEZJSbxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLHBjZ7VjmMIGrOCz2xXzQaj47Zv4Hp/lcFm0AE597Q=;
 b=mr49FiHTuznpFeHDeljei5Pws44+KvedMGUdGhK37xokkVKorYz7pmdzksfV4LJfzks6ud0xWwnpu0B3VNvB4keXxbO17cBRF1+5jxwpLOkcVJLNZkggFfsc6MWBwkKtTCbi1WjyvTEVIcW1JEJ7z8mIzXeq7V4xQeEKc7qoqb6rRiZtl3A4IPfQaa8wGDtmkrbRhdO4iAvSJ36JmrtvTyP8TsP0GFc1x8EEy5ri7WPvx7UDOQWWESFpWp98dgRT+L2fKIsf//P3MwdWOBhXpsSPv69P5yrX53fLVA/3ScvbJfRZQ4G93/k5EYeJPUK1F0Tap8PmyzfVF9Atn07m0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:20 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:20 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 07/20] hw/arm: imx25_pdk: Store boot info in the board state
Date: Sun, 16 Aug 2026 21:12:37 +0800
Message-ID: <20260816131300.51799-8-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: f87d378b-ec7e-41e3-fee6-08defb986c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +R4bedxHLdfuoR+5tXdCCx30IucvWsY/xIPcebyqSE/VIHZDBtCiDTnP+c9qbjf4PYMVUzCu3NWYpvUXxkpUMO7KuKNsqreSbxdsF+3Z/hpTJBvqgG5JdQSembqxtXsZq1cfZleujTdk6aJE6AwjTmFG2Qr7g4aMw++aFIt+Yc3oEQAqNq9FZClD4Xd9+1uhezbdhGjnjwtI2wZm9Pp41Hd5DeC9YTmRvBUc1DKXP2/iD+lTpAmjj6Gd/qI8wqAey8cN+PhK5BKllo6VgERq4Kf404q2iP4+W5JWhGUx7c1mgD03e5UEywKfDTEptUfhucEDv0GXC2phbKRtI2YxxiLZhE6cwQiWhwmk/nW6zdjjhOOOBvGZkaUPNURl91y344bH7zE5HqBLtQDWHgZonhq05qd9WoQKMaP52gnLz/vueGfGwUu4tErqHZH7NFufTGXrYcGZ0VvQ2Nqqcv+WtTqb3CEPGQq/OnSXu0f0aVL7UhWAciJeVJzMMd3w07W7lO27Ed9T5gZ2XQG1YD7b0qFb99IYdeNDx7HhlvkaSLIsOJJCwxxFh2C1uPJG6UWZkeFXfjVgfxxjNXwIw00u4m91tV3VmfKIbXBUx2tg76Os6CYQxhr3SV7eeWofVj1B4aXCKi82d2VcPPgwLrd3Plz1LY1OtDYIQlGJFDbmrdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EsVFPN+krSz0OPfZsX8kRWj3/N148Ix0DPWSA4rSQhDP4FpoYSBMCCOaQWc0?=
 =?us-ascii?Q?Ucd46TUpJxIQ/nyktQoWEPZP6TX1Nl8YjBsRNQJHbfo2cYU/bk5Kcib/sBsH?=
 =?us-ascii?Q?TZ/6zyt9uZEp8Fcno0U2ciXv9AlukGkE/0S0t2MXGE2ZfrB4gxwbmJa5ELzc?=
 =?us-ascii?Q?lnzzHWqrXAjgzf1MV2dRtmspg/ADn0XT+U3prGaM1R+MHS/7seVNpESuZM3v?=
 =?us-ascii?Q?0Gzh9GuEMI4sQhyLH6vfot+TDqkTE0SFN+ra23i3C7+4gZY/15UBhRQwYrJ/?=
 =?us-ascii?Q?yMQjiEFk4wVZeYPW1iLVrZO7bLovbOmrne0kH4hxzQ47qZAH/QDot25HyiDw?=
 =?us-ascii?Q?fjWhkDveJ3jBTqbSlQ4bNmoq5RwHRCiuyu/vzD8lrlkso1bWX2Tke3PdVkrh?=
 =?us-ascii?Q?KiFhpv1C6KRQzZkrTgGhuLXepbHxY6rRhrbBd60+FUEjuRji4KhxDCgfMYDE?=
 =?us-ascii?Q?bFpSP0HQ7nDYdZfZ0tN3N+Rpwo/qw8AzYUltUzrGY4zE3hB6GzgPLYw/rK4o?=
 =?us-ascii?Q?KX1hZ3sBvIVuTAlKySG3j+bLQ1ao2VqocR+kD3754enXnbKr5cLHyUDcym3+?=
 =?us-ascii?Q?SxG9yfwykYPb0Sk2hXT5jXcC9pdEm7nc2zARhHdKNPkSiFiC8CV3pUZL+L8S?=
 =?us-ascii?Q?Pg1+2pkYOWGHAOaqyYJyAaWylSGkWBnFLAfAXAUAc/gD7q/Jh3eHDTcTb0Aj?=
 =?us-ascii?Q?Laq/ADJR4fXmJ+MTclhprdLgzSTSoR31/kGN+ipUn6rHLCpI19D7+EwKg0sJ?=
 =?us-ascii?Q?0AfOxjdwefUlBOPD7KIp2s2cutMXl1AsE0p2mmNVgAOn3hS1GB+8fNEKLmP2?=
 =?us-ascii?Q?oGYACwpEgTkX+h3M7FZ5jGdBtDEi88f8FoLvv6s7Riwee20iskmMlO0N+MNL?=
 =?us-ascii?Q?eKYd1sEOoPcscrvo4nAT0YmAKfNjh+c7Cc+PyUqhtWN1L0cBmqexhQOrgzmk?=
 =?us-ascii?Q?mNDtzhZlN1sh4pq6x85L6MXAgJF0UEuD3MQ1XTLI8ERBAGS6VRHbXfq5eANC?=
 =?us-ascii?Q?RNP50imXO4kgNtDGLLcFcDGm7Qlpp9yq1W6FLm1iLrzA+qVkb/uqxhtrWasP?=
 =?us-ascii?Q?3YDrr0swmPcfmDyUIsUhvMMlIGK7PizYX2rZja+n8i4OKDYXBXOAhPQMKOb2?=
 =?us-ascii?Q?HD191jZQZFmFhygFmmA6iEym0oLEYk3SEikjZZW5i3dfYZd3l7+PVOigCO1q?=
 =?us-ascii?Q?2LVoT2YKkGgtxuZZnA05mEprUy8rZcY2YIA3YU2dQjoHHbQLmoJJVJsZOK7J?=
 =?us-ascii?Q?vzN+WCGHJ36eFB43PDv+HSrtCT8Z8qoK5MF7jwTbVL7NBofYK0XI8VjVAaRj?=
 =?us-ascii?Q?vMX/t3Ww2yy/xn8a2VUq6ppxAh+lyxM9u708D2zGAnfVfh9RNPJVS9twaA+f?=
 =?us-ascii?Q?kU18n5sbYGdqx96azuQuHJWUW6zr7fDbW9VEHflvRxHdhJZWWp36NkJe/WwX?=
 =?us-ascii?Q?/jUIwQF9F2s7mVQisfBjp8+e+FMIbcdGiN3IxGrgcrltb8tH1r/wmhzBkx3i?=
 =?us-ascii?Q?o6m5aAwAz4YhA6K1UnvOBq+4Mf3nXsrIF1a3jgB/2m5QGGOD8nWgWow6q49r?=
 =?us-ascii?Q?1+fgOGWIA/NArIOtzBZKVmhBH5ds/xkgUV6kevs+Y4b1nWR6jK7u7c4Y2Wu1?=
 =?us-ascii?Q?RkJ2wXEwvAP+y9cAJZSb7yMGPdpUM4gXzQk5MHIGVifDBki9AYPPTqUN9eOX?=
 =?us-ascii?Q?BuzNNuyRq3MEJeyEgyrrXSHEHTKzrJJFc6DV+qcLt95I9L+riMwEFij0YnOw?=
 =?us-ascii?Q?NzFTfCbzn7iB7tnJDo5NbKp/I8crogY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87d378b-ec7e-41e3-fee6-08defb986c63
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:20.5831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnC3FHt0tM58fMrxEn7VPheGxsGaYzvEFbGRwzCdoMS72hrCCPZdKrAZFeRin5y4bx+YdXKCHYYIZYObU318AyorPv0mOrdhEO8IW6nCUyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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


