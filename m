Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13B4C5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaix-0002B9-0j; Sun, 16 Aug 2026 09:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiQ-0001jl-SU; Sun, 16 Aug 2026 09:15:59 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiP-0005Xo-Da; Sun, 16 Aug 2026 09:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2Uit/cGu+ZaaJMSj4ZXWp4XQgGJ6BaC2ScTUNhZlYLgQ78vYCNOSRKp+pXVjNzqbonmUEaz3Gu26lcGKo5AxR+D+RCV5EJJypnKtFi8WSPufgeEncNU34R0/VR/PukJJjNs6MQvohGzsxlZY0jhEumuDFlZwZpkiXQ9KWUid8ZMqbHyx2/z9cIk2JLmtIRI9lxF1Sjj4T2IFuPQvzB27JX7wQ+aJb10H46uHHta9tB/8ER/I1UVuAclxtvSjTl2Nk6d+He0TLgGk/hKgn3GzAUlRLdpJ2PuWoQKnhrtjsG2bTylqq+heT4+y+YeNAi2Fd4RzVr0ZHQtDOjyYSowEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Aw3qLbDKlEdDOsX+7vfL8n0ouA9vszP45caSOelb4=;
 b=uXczM+qXU+tdwcoq4BXE7iAvHEb3etLK6mTIaYRTNZqJcrgSgDAYp5DA+oWh0EL8FSHyLEn6z+bzN7HjolcTmpQnggzh3dVTU+DhtWw72nct1UdL5fiERNW4RwhqoDQtNFjpYAtFhF7u+kSq6WD84b9J7Zxjr/+DTvw2PrRIxV9O/AcUL8mwL7OFdWwX90f8MPbbnZ+r7DHorTnF7Y0IE++RL31BeUNNM140bZLQyAIvTm4wdT4UdBT+Nmq9GxBC1V0ClToMjlw7MK8cPv2MFeMrs9xiQgeVMjtpI/Yg2wP7LCYRvhY0z5TapgKcAUCZgSu0rQdHjRg6fPPlAcsN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Aw3qLbDKlEdDOsX+7vfL8n0ouA9vszP45caSOelb4=;
 b=V7F45XdYH076vacChxbdWXLAWI2SjtZptiolqg4tXT2niwlTE6XLrpiZaVhmY3xo3eJIpuyCTy+1hND6fF9ccpIwOuJZLxfa0rAfkiJVifOHxxWBLX1wlgqR6OgiWhubNRMKiwRlZeVtnb35VmZzp+b5ZC7GAxGCmL8ymm8ZABOuLyD8rPjYOeAcEQxroQ9u9zox45hR6nwfUGwllOuZgg/HpOFKkrEvLL7QR1WK7fr0ygt2i/wFnN8QGS3LenSG0s2N3lZDWp1vt//SI53FqaTUrGgeESzpq+CfPdnp6vwUtJwQnSW3apyU5peSbUsF1OXHxB0qHB1JT3L1Ns6CjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5475.apcprd02.prod.outlook.com (2603:1096:400:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:40 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 18/20] hw/arm: sabrelite: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:48 +0800
Message-ID: <20260816131300.51799-19-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7ecbd8bf-9a6f-4208-4bbc-08defb98786f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5R7TA4DZrDqD30MuFn/hPMkxBAiT0OzLIE36Ir2/8q1n3kXY3vS8XxAgqFs8HhNPCUh+YwJQgfu9bqeAGLDOn3Y75AGzxYdIXYQC2iu99U29iEMw+6CtPi7hi6kHsiR5vWpT2/B3fdPfzE3jwMSHFJxtJnEaNKh5/bC+Vdp8hoHlmxsF/xDKDrFkGgpB2JQ0dA96JiRAo/xd4LtnYIeHDkXjsORge+Gu3jIt9ZbX81orTmiMSXR76PDiWrorLIeKTC+X35uKfrwCSTzgYEDHyFJvIptsEYtg/pVjBXkCLmIssYL4j3NDzpHEG9vYJcjqXiZ5UjfMpfXMeyhz6ZNj7Nu5OZOGA7c4n14N7kZ/5yV47yg5wWSfmCeF5DChHhsDy9WY5RgBCFCa6njmq0LN6EnLIQOsFNEnfqj64j5gzbLNSfQfFXpik9nISFP4X8onvuq1BmIij+VPVAOgTk+gqGMYmc9jRzXuQnRISgbfT+2Uzro04h3Yz1gcwz0p3q+iHgOa0wMKtlqFPJcTj3BKr+uPSA8EJlAQRYDLJTJg+TWPlNvYMmr0BfymZR5ckK14qI7hi9IyWGMlUeeJ5dtF4IpH+s9Uds+MxdogsC8wCdg8PaM1GYsWF30981wsj8cRDTLfaqVAe0LW7zUB7GjYoSrmoXKrxS05o5NIT0OLGMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InBLk3qhE1QJz5qi8t1CpLXpE6St/7tv4TgppEqzdu/GdVBLJagHHS/6IvZk?=
 =?us-ascii?Q?n/t8hMBfcMXsnLM7FxvrPjLxYEEmRkxyLFb8ce/W+MyXr8+KHLFuI+sf8Z6K?=
 =?us-ascii?Q?OP4qNdfNkou6afp9DMFSuEvtGF++2uxo0/Nhez8cctrexZTAnJJyiD+BstWm?=
 =?us-ascii?Q?Fb8S/PaUKg7NWS3J1LnE3Na4athUL+EKWaBNx4WB+AOP+dtjvE/UsRwjT24I?=
 =?us-ascii?Q?SgGvKM3SgDoOzmuRlYybmEqTLvkNm7tBlMbNOW8Fll+5QOGdHK7hT+U/iFFT?=
 =?us-ascii?Q?8SRsGTtGavf7WV+YrpSV481reh2njRdrWk2Oiqxh9ZWC76Qu69LJk5L2iKN6?=
 =?us-ascii?Q?Rhp/Z/VFWiaGIhH1t5CHDtL3FvUXMAPd4Ke3GJEpHp4VxnF2CAJPbCrG+HFS?=
 =?us-ascii?Q?VO/S7PHPeeG+JKrWgV9bkchTm3GfiMi76dPUOZwZ+/45YpOuYxO+mXMjA3Ry?=
 =?us-ascii?Q?2tWTgEGUgU1lPLeBWlkIYQHgSq5Jp12mgDAcRZflF9QxXRzwteO/RUmQiwzL?=
 =?us-ascii?Q?laf/I7M/MOpeTKvO9hEgmipH1IeI8lQUxJKnVIn0caFAXR0yBMRyoM4/XaqK?=
 =?us-ascii?Q?1Msrl3q3i3jMGicb2iihmhcZ6TZmT+Onnlt4pLyKUYUhLm6vI4rKEp4Hsyjw?=
 =?us-ascii?Q?3rAJUws+AcFC/Jqdul8a4aGAn526ykdMvxYxN+Ye/hOv6SePPL6HKLqBnrhu?=
 =?us-ascii?Q?gcGqK5KnC0HthAanugpd898epgN6vPg2VsxV38RO3+nVzA2HI40kuDSisath?=
 =?us-ascii?Q?JajoOd0p9WVuKbIJ/0XopWpaiVFnrT4G3ftUVDgdz2pekq2DYK53zspZGd+H?=
 =?us-ascii?Q?rV/dYhiUpw7WMRl0UbRTUnwXsaY/v0ND0vMLVKd7vO9fzUP6uFTqo/iCvLBt?=
 =?us-ascii?Q?dmrMEnFG/OI8QK3JJAnMEXmN8tP1wO0Tg7A+jpUB5Gi0W3JLyHyceXuK33Nt?=
 =?us-ascii?Q?V7MkDLtTDL4nS8mF3SkZO6urxso7LZjstf3HSx3CfKHhgeB+bvN+EElBORUZ?=
 =?us-ascii?Q?oBsvb30slhGUYz9kf+HbnASZqrPUi2m30uQwDe/1c3/adQhERWGHG5wgngZT?=
 =?us-ascii?Q?RdJsPaqQu+7/mVpD2+4Pa3iC6INNnsKq0cBmc89676P4SdRm7r4wfqaJF+g/?=
 =?us-ascii?Q?XHv6okYGgbxMvqiXOQy8wmXfMrckQTGjrem6v+GFFykujm62yAIGtjCFkm+J?=
 =?us-ascii?Q?2Uf8ilDF3JOFqXbJMsRqYm6Yirqzh8x3vXAWmbW9E0JFRMa11QRjgCS5jAy9?=
 =?us-ascii?Q?hwZ7FkUvxVVwLBlXxX1FchDT6n8a7yZ7tk3OLAp8UbuhQ/Nk4lxdFaozbbPB?=
 =?us-ascii?Q?BRKQHQ45Nj7Nj/n3RX71PmPVgl01vNBEabLK3sfFeZcmITaBscYT/BwBJqng?=
 =?us-ascii?Q?DT4ovAsSUZiiITeS14WFVzIpSjekD4+8gi5mIgi8io7njgrZ+ROQ5qivMIFz?=
 =?us-ascii?Q?zPfFAi5DcBB0zcYXyGrc8Yy1kziNCxHVLOKJuXnjkAebdQ34dYL7hQjLQ9ht?=
 =?us-ascii?Q?A/siT5YQgOPF3bBi4k5frV4S6Z6oDPuTDVUvZN6uxAFQDIBQTKJepBssC3mu?=
 =?us-ascii?Q?frAB4n2ehYw840aM8EJJmdt9zWL05PlYnP4L5/8+4L7aJO0X4/4v6ho7seQ1?=
 =?us-ascii?Q?23Qbec69j8ksazZYh6N/TSVRQauWrcDbvhNfEFgeyJoBQtvBLbt7IsWhPztT?=
 =?us-ascii?Q?tKvg3GD36VNw7N9H7YJQKbY19ARGHBaN/q8xgHts3p8oQQDDBz+3nFJMwBj/?=
 =?us-ascii?Q?ttgGxDDxKg6rhPXB0rSQi2jg7U+CjiY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecbd8bf-9a6f-4208-4bbc-08defb98786f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:40.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47j3vFn4qepdvJjk1gckRJ+WM4FGEdQ2mUpRwFfCO/nR7HFqPXOpDfUpm3N2YMq255TrFEDUU6lLzyWBGslvbntIv7hrVeabIEKcnboHikE=
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

Move the boot info into the existing SabreliteMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/sabrelite.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 84bbc2f979..140b2ecb9e 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -25,18 +25,12 @@ struct SabreliteMachineState {
 
     FslIMX6State soc;
     CanBusState *canbus[FSL_IMX6_NUM_CANS];
+    struct arm_boot_info bootinfo;
 };
 
 #define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
 OBJECT_DECLARE_SIMPLE_TYPE(SabreliteMachineState, SABRELITE_MACHINE)
 
-static struct arm_boot_info sabrelite_binfo = {
-    /* DDR memory start */
-    .loader_start = FSL_IMX6_MMDC_ADDR,
-    /* No board ID, we boot from DT tree */
-    .board_id = -1,
-};
-
 /* No need to do any particular setup for secondary boot */
 static void sabrelite_write_secondary(ARMCPU *cpu,
                                       const struct arm_boot_info *info)
@@ -110,13 +104,17 @@ static void sabrelite_init(MachineState *machine)
         }
     }
 
-    sabrelite_binfo.ram_size = machine->ram_size;
-    sabrelite_binfo.secure_boot = true;
-    sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
-    sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
+    /* DDR memory start */
+    s->bootinfo.loader_start = FSL_IMX6_MMDC_ADDR;
+    /* No board ID, we boot from DT tree */
+    s->bootinfo.board_id = -1;
+    s->bootinfo.ram_size = machine->ram_size;
+    s->bootinfo.secure_boot = true;
+    s->bootinfo.write_secondary_boot = sabrelite_write_secondary;
+    s->bootinfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
+        arm_load_kernel(&s->soc.cpu[0], machine, &s->bootinfo);
     }
 }
 
-- 
2.53.0


