Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAEBC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaio-0001zC-68; Sun, 16 Aug 2026 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiV-0001kG-EA; Sun, 16 Aug 2026 09:16:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiT-0005Xo-TA; Sun, 16 Aug 2026 09:15:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxHVaY5VY7QwpYqTI7FHyFH8ws22OGALrvNumRtpCVbsz5dbbFl/mSHdBHu5f/pYi1NtnBEfIRnP7i4ObnRVDdi08mfCUpjy0RhWR/Jvjjr4Iy9HostN6DaKD0IRFw43dfSbfRIaq1a7AyVZiTZ8pBFn8OPOMqDFaBTOUM+yVjAIRUCAlxHPTW61ut+2abj7qkTqN9dNzGMP2nvYzf1gHC08kABLgg92il8DYJDJ+a9y/qC1dsMXoAYpR+3P9HBe/f6POyttRPfJWAp6hWOJ6BgXSiKf2I6vN6qn60V1VByd6RjausSjrJnCE6Ke54dq2/HDQjvJS6XIpZ17ae8tKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkHyTcOXTss2+piTGG/1amapZT6tYT9NKgB+5zFGmLw=;
 b=bdxPbA3xtNsJRv8MzNkGGnrAxqXPTBcVTvHjN8cA8JjHjKXcoUBe/+s5LsRUoTeDomO0h8p5QXnwCtR7NpFXjPaj4PGNAR8cNMM01QplmMbmdgMHUAHsPCQbE0s9RsJkDnnh+w2bYzKdKCym7P0FViuggfRMMR6CZGSn4xGBGQBsJAHWJ5kFTm5a5534q/bsbDZvOFsSVHq0k1HBAZUG4dKoJkoc+llI8alf+R7rAsznubs/vq2GdgkDMr4OoP7K/OZK0OUe8kByw9w/DMmPS6JcB2rx3zWDTZ64ov219m+iW4+tL6J1MKs4SFaFa8dFmWpIj+di1JkAo8GZgkQBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkHyTcOXTss2+piTGG/1amapZT6tYT9NKgB+5zFGmLw=;
 b=JuvMxdfcgbSHaU1kphDGPqjRXT13XAz1V5l3UW4e7kiWiWLKZOWbw2CfMX9mM43o4l6LZS8vHBBUdHw9bCljV/Ebiuk+lkQxllExOpj9RxBFWsO2v1Ytn9+EGbt5fqVuA9bpNH7pE+JhJ61P7QsOO93RMm6QjkeFJfUaZuJ69Y0lwAs9JKQ+JS64ZEkPDDht95czxQ0Blm3xxHc/HnSdvWmqe9qh/R0MyoOxCunxpkJAp1+VeSBmLFhK3ZbvE6lTNZmvvZXm3JCr/YYn4+b37X3fzRhN5b5vIkT8umTEL/H6AMMGCXLdtOgYzdXVk/XypdrMKceoHCcH9TgDdueF5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5475.apcprd02.prod.outlook.com (2603:1096:400:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:44 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:44 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 20/20] hw/arm: xilinx_zynq: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:50 +0800
Message-ID: <20260816131300.51799-21-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: cfb11dc5-608a-47f8-afa8-08defb987abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GpvOPhDl6Ku9qQAs9TwrXCIpyIScO4c07hBh3ZvgOA3Y+M4KCnlEzmMkL+9wd41ZXCDkgP15+mV3Hmu3fHTMs/cjv4788N9Vv0OzwTAdiM1ls8XdgqsjtSyCbPR/co6iKkKH/YJfjC4SleVHbympYbMdtMy/jMnfebCBFV6KItvVu6J5d/Rvnng5wWoCX+LfjfrRSSpO0ZzPw7h3Mebyxw8WovBmCoFrOAwf5i3Krzf3u8D3lQdyxkVk8L3dgM2aXEAVltN4Jz8QXPK8NwKqEMZTclMTnrvulnfmXBk058LpoCRCxSMy5gTbsiW4b7zH0ohDjgNOc34GvhQAgQCJWsXKLxaORCcMoRgbHqEHXUMyqy5rMUC4rHje/98dL5gyMKbcyO5fu3ymhgUKjsMRd2/UEgU6VpQV3PTorEB9M9OslHXxdYFwPLG7YMBRxMhfHq2KNlNvTwQPnV1R5zKO13MvSCj17OgJx2pBW5H33pxaq1IroEnsBd83j4Nqx2/qmClL9lUEisJlo/7f2rZvQW8SwG0A2h7pLFf6H7rbRTJ1MByY5mO2Y7n6zaC/5CYWIIsqy+0uWMhKKAhxDqq4vep9qkRcJ2tPvR/1rUVuYAQjw0MnQKHMeZWmY5SRH62c/K4i0Ka+s6mAuyOn7oCgDA/KBi/jehrbzaKPAZvGzyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nrjm6LgfACDE4OljiddD09rL2Uv+lYbD6VIkpx/zAsuORb3pO09NdqRbk4Tx?=
 =?us-ascii?Q?2ta1DQrRj/htdxeldfS4FWdsXouCMc3YFhntYrBpaBhFdQlyvoMVJr7VB9rI?=
 =?us-ascii?Q?hos0pnJIPFw/9gi2xLv6Yb5QQbr/38f7CzBM+fv/riu6krYKSPfWc3P8zyfp?=
 =?us-ascii?Q?J+AhrbRgmHVweFWXZRfFc5f/UCK0mJb7f4J8UZowLxu9bzRNFXK3FfBLTBoo?=
 =?us-ascii?Q?ed3kg9poIXnLvKsIrKapoAVZrYh7BeL5isMemTGbIrsUSQtfAzVaXnCmqZ4A?=
 =?us-ascii?Q?99Zex+eCxDFClSy/zmx9rvUZ9ahZxp4Xws4TuLgWgKGPOk0qa9Ogy+NT1Eh/?=
 =?us-ascii?Q?u/QuKcJQKMhOqJ+2M0+ayirRyTc3aBOjS1w87b7soy+adhiNvwaLShikgL2T?=
 =?us-ascii?Q?XAiAWupBhKG0yku1chRdKNv+y0iwYUtN7zYEBnWSxEATk6tkSJ8AIjb6okGN?=
 =?us-ascii?Q?7EAuasqQXHDicwn3lgPGVG/MFqEsx/OHwTL5nMzC5VROk4Fho2UezNPYyXd1?=
 =?us-ascii?Q?fP3dY7B6di8KRGeAa9n6An1mNCdHzR9HDeVi0fwRIo7JWqn3Vw+VeCsFxSXc?=
 =?us-ascii?Q?lwftPT3yweWfx6tsu0mA6soaBz301d3n9H3ynpGLFE/Jg9cZ70d2tPkfnHfR?=
 =?us-ascii?Q?NNG5e/i450YY9VRwUvZM70ApA2hAUZOagash0nNd1mT3rpHLxBheI6hoHOgt?=
 =?us-ascii?Q?NSr3P2vB9O3urbRvY44f53onlvOKRb2jhov6wZ4nuliMdceI8m/0scggoiqA?=
 =?us-ascii?Q?vCNQF/jkQg6g+WXyPQNqFNM+JtkVF5xrBfjgPmTAAgsIFTnq7IfWmAwM4pMa?=
 =?us-ascii?Q?+TdbT+7aX+UEOA6aA2mn4lLtuTZ3OZOrUOVYqbgkfj1tLVZ9TIn8ORxYiwIj?=
 =?us-ascii?Q?CYOVCBVhlmNaxdKBL5WhbBodNQcKJvENVWHty02MO6FnFI2indQ2PuV9uFnS?=
 =?us-ascii?Q?QcmY6ABgY9SDl1DLMxdGZXgQlebEsl5TeX/HHsDnXk4bAPpUNmv2zUqqchQn?=
 =?us-ascii?Q?cksxPG7CnfnydTH0wqgULdkJ8qfAf3a3kF7d+gR2H3RCJskWqQ6axyVY4Cof?=
 =?us-ascii?Q?9jL9Dy/67cpuOGcd/vO/2Cqk4hO/TAipVt2iSPK0Ylp/4D2K6NjYBTuO3baq?=
 =?us-ascii?Q?pydK3fr8PR329zGFy3DmxWplkExVIDPekm/n7+osSac/8wODJtW7n+PoP1sm?=
 =?us-ascii?Q?3/Od5WLzL3pq0ewWZeSxTr5KlD2RmsgMGFs+2uPfEKTPG5w60GPel16LXuK3?=
 =?us-ascii?Q?BKy+lOZjL7CX7bzSiXjwwoNhlTLz3WDFimGXiSaQYTdZLAGjCArxqUZizhfJ?=
 =?us-ascii?Q?3vzQtOf0LJCLcpxxNcgCK0q6RjVRETtfHeTHeVNSzPLeyoTrT/odyD+t6ziO?=
 =?us-ascii?Q?DpDnfow/M+VBV3b4H4cE75P3NT6Yo67/VQ4lrA57qN0u1VXMeCo49Ep/z5r3?=
 =?us-ascii?Q?cLzfoTup1rzPFV4fPa8TNoO/0A0XVxFU16nHt7j7svwCtUf8QVALSt8qVc4g?=
 =?us-ascii?Q?HDJ8uPJFsjIbdaE2h3PuN/MUZWLo0tps1z7x3BYlN6jpyhN7NvJtKUWHIwfj?=
 =?us-ascii?Q?QdiDjaI3SCYqIyqQVIgwlvbWjhsme4HTaZQMEiHqhWELDvk3b3H+j+UoBEL1?=
 =?us-ascii?Q?WB4lk6D3N0xpu2CgH6EdkZ/atjjPGgCBeD6+KLIa0QFE64YCB+zVzoNWgGHQ?=
 =?us-ascii?Q?wPD3WsjJcZSXhQWbzqG2cmcJEXkxoA2jOIs+PfwGgnpcSlIH8xXzbbxcn7sX?=
 =?us-ascii?Q?al/jeco54iXTyljlAlk1/cUkybhzuNY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb11dc5-608a-47f8-afa8-08defb987abf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:44.7607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ki6sCBtJn11m2Xnm0GtXDg56vjf4xozb/xlv20yfGP4TzswjuVINtZLKkwYfMdc8xAHFEp+j363O9yAs6ItuE5+JH35ogNvxjuM1Wqa4Ftk=
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

Move the boot info into the existing ZynqMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

 hw/arm/xilinx_zynq.c         | 17 ++++++++---------
 include/hw/arm/xilinx_zynq.h |  2 ++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6c83439017..f314897540 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -103,8 +103,6 @@ static void zynq_write_board_setup(ARMCPU *cpu,
                        sizeof(board_setup_blob), BOARD_SETUP_ADDR);
 }
 
-static struct arm_boot_info zynq_binfo = {};
-
 static void gem_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
@@ -268,7 +266,7 @@ static void zynq_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
-    zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
+    zynq_machine->bootinfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
     sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
     for (n = 0; n < smp_cpus; n++) {
         /* See "hw/intc/arm_gic.h" for the IRQ line association */
@@ -444,13 +442,14 @@ static void zynq_init(MachineState *machine)
     create_unimplemented_device("zynq.qos301_dmac", 0xF8947000, 0x130);
     create_unimplemented_device("zynq.qos301_iou", 0xF8948000, 0x130);
 
-    zynq_binfo.ram_size = machine->ram_size;
-    zynq_binfo.board_id = 0xd32;
-    zynq_binfo.loader_start = 0;
-    zynq_binfo.board_setup_addr = BOARD_SETUP_ADDR;
-    zynq_binfo.write_board_setup = zynq_write_board_setup;
+    zynq_machine->bootinfo.ram_size = machine->ram_size;
+    zynq_machine->bootinfo.board_id = 0xd32;
+    zynq_machine->bootinfo.loader_start = 0;
+    zynq_machine->bootinfo.board_setup_addr = BOARD_SETUP_ADDR;
+    zynq_machine->bootinfo.write_board_setup = zynq_write_board_setup;
 
-    arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_binfo);
+    arm_load_kernel(zynq_machine->cpu[0], machine,
+                    &zynq_machine->bootinfo);
 }
 
 static void zynq_machine_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index cefb7789ff..669c516ad1 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -14,6 +14,7 @@
 
 #include "target/arm/cpu-qom.h"
 #include "hw/core/qdev-clock.h"
+#include "hw/arm/boot.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
@@ -25,6 +26,7 @@ struct ZynqMachineState {
     Clock *ps_clk;
     ARMCPU *cpu[ZYNQ_MAX_CPUS];
     uint8_t boot_mode;
+    struct arm_boot_info bootinfo;
 };
 
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.53.0


