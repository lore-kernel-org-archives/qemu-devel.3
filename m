Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5769C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXiB-0000Ku-H7; Thu, 13 Aug 2026 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXi9-0000Js-Ah; Thu, 13 Aug 2026 11:51:17 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXi7-00023y-Qn; Thu, 13 Aug 2026 11:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hINa0b0KGI1TTFtSo4nIyaM5QD+Q+UdSOkaZtTlHZbYWxmFQnrKoMk142pYpq0DrwFaImoKunZyOds1UlSxr0aYcru4DPgzY58hN1kPJrA1zcYL/xLoZlw5KQAZGg4mD5mciTsFF/0bd7Wh5GGCGaMHSLDaHw27QCp8DGz2wCG2Ocs21u9wAmqACucQ1E45fCV7pA9x3TqlhciJw79A1U4y+zVBpcdl1lRm0EJa5IOGeR6rRRbRuUowNIfNznlFQc7MyIFcAYSQCbYiNvCGSA9bP7FwCAwcEDaUWw59bJ1kkfieFBlkqdYuNt10n2KhG2TXMInemWrUYRjvzebC93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oEqVpIMoqLkvWmwuUQ9+HABT5D06l9DLfIiPCAREyA=;
 b=uMH427M/Ft4eTpLmFtJkMQaZbZG/HS5d9TBLEJGob5DpiXNCcJxk0eFw7lckAHtA+qgUvuM6fUaMBLhXN1i1ecVAZgC7TNe1vExoPGbIqacb+gvn1UBKc83Y1CSIaGa3P8bM0vQDmAqCGiPhoUieg5yb/54Hi5P0Kc2pEh2e6plBAHnuHninN+3sbehD733NY0bi8QykNPJofr/pAE14Si5GR4lIdjuF3NsQJjOF8TSJ0/4aeb4XXwcutjagA1xm6FGVSGJy7O/R62APBjOOLzlOxP5KIiRUYFreXzoOqEO1dB93az5TQMBU7DY6D7btbd9VghQXKpqqs6Igh28wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oEqVpIMoqLkvWmwuUQ9+HABT5D06l9DLfIiPCAREyA=;
 b=NvldZUHGxaLT9vEcgSjCeJmaf6RVMUr8n0Pcm21tG8hem+VDWTvVE0DN0iwh40k5H1b9frRee9U6bsfzAZRfBNQxb0R+qk9OVTNd/DloVuqKAGN+5nijFBF9SUwgugDgmUF5/rKYbw8Qy3uRAkrQm27uo4D8Oa3YrjhpkQ7QvGs9/tqrQz1OeXqQ+9oRWKv3BtgSUJj2xANOLx7ctnIwogFZe8a6l70nnGkNTAHxKVW5AI9o8ovSEOQ2XG2mE/6cGTZXdjkPMQMshmsV5luCX81/ATISQrnFkd4KwmBp/Nd/5Uks/L7zrjPsUMVJykbezqXylumDDa3zRYnAPwcw7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:51:10 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:51:10 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 18/20] hw/arm: sabrelite: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:49:06 +0800
Message-ID: <20260813154918.996812-19-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 4842dd8b-c75a-49d9-c9ce-08def952b1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iZkw7HYU4TigP3DNA7FPfg3Ts9l/yh1Wrq2GJXteRzHUxblF1uP0CwMR8fPH5MIcpphagN6mxENIIh4UHWGnW7qj80j6wVsMivSQksmkga+qpwykx/IoYRA3+KQHW6+3hGD2849V0dDrPt/2IZcYKtZdjyJxRJpeavqIAi1OYosEwNWKLsl4ZJKW4Yo4hZlpO2gVluJ9AQZrms6QRiORN0KIcV1Jl0A7fMPfUCi9wQf+Cx31OseBexRy0K51YGxirTN2vWD+dJQDI0OCQ4NPXJzs70StPH21Q04pLZKrwCGusev3YsGuuzI3CChW+6SMn0x7Phwa3CcPfqHdq2PhQAYBlAWsalHPihN2iKeSTu4rjq9Lnd7O30I0ld1E55HUm/++jBb4Fo1lJwfegQ9CP7uLI6R1X7GnlUG9YQsCBnslK4Bd//i+8bGmRwaCC/zc1Jon6vNzdLYZaaOmnomv/N3WWUiplwPUdSKxXfLwfTQHNUHUfvkgLdVq+ZuMhv6e57z+qJLBW4+mE8TZOR2Q3wPsTKcWwkIb/4Jw8nM0zsxTOkH9MIpGxDa7du8aA7F9gjJXKR5dYLptx3FP6m2/Yrd5dPFTuUn2JtFtbKxoXJ/di3mt72PBueuofwLspGDnw1JlS2z777NnDC1T77owptrW/vP6yHnj4ebZMzIppt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zrZ7l57VUWCdmNzmZxBcW9eqbZ1bEs5Je4xZkPrR6OUA8eDOrBYFkzfuRFn?=
 =?us-ascii?Q?T02VjougBX7z79nqwgo4zzbAhspBcNLJWRv1raR6vQLWNN+NUawAk1VPr7LJ?=
 =?us-ascii?Q?E1ZZpRrhS6aco/cNxvNfjeMv/MIJc/T5sGQ2r+4G3VIE71oRf8vixzRPjSYV?=
 =?us-ascii?Q?k3GKedWrAh4iAxbRmW4r2HYyippZjDqcKzlPkyPIrd6gp+ilJaHNqslC1uvA?=
 =?us-ascii?Q?PhOpJItkNrqNLy4DvvQT1BUSE8hOWh+Cb0tkoDDqJaIH6x9akWnALFZ+qhAg?=
 =?us-ascii?Q?dUTAxY3I5bfd7zOupmNEHHv98t86orCidKnCxsg0M/UNTgzymTlUsiB+M7yq?=
 =?us-ascii?Q?l3QNO/qh9YVGvuBQ5+Ppq2Txbh4g6B1zVAyOFZi2Q9gIap7rW8jk9ZpP9e3p?=
 =?us-ascii?Q?mP3+wFi+lt7WE2kANUHqE9RPZ+ftNoFJC6zipuDb4yuNS7/JHEzf2Y7+DY+H?=
 =?us-ascii?Q?vnoGVPEVua69E4Yg2PUV54JAThazX0fTPqYwLAjXJigi2dDij6pGnfLLkp9B?=
 =?us-ascii?Q?t+pPBogSPHnFQ00BPVW3jXb7+0DLSFLkhJFDzFdgNeFHg37pRo4KdQGHfqP6?=
 =?us-ascii?Q?VIj8hb3tdRxq7E8Un+7mV5P0Me+hZQs+Qq9AiJTP+b659QFgyatuT/E21ACn?=
 =?us-ascii?Q?pbvw7Ir3Zqgd+EPxItcPAjA1XhSy5sugmgDt13rHdtygChx0vrmbL5w/1ueL?=
 =?us-ascii?Q?AcRehuKrINOG4975PKbL81ycuUkmRUQyqagGcfzA1V0IXdb1DXCOGal0nq2D?=
 =?us-ascii?Q?B+nbFgZ5k2y1K8un8MLJl3PvLY45ug1l/PRaGV6l1DzDTf1pdq0QFZgG9M9o?=
 =?us-ascii?Q?89YCyJlxVoFFGCaDVgNgSA2EyWVe3M0BpCQv/eOl4SFF0EnF9kVSQ+Qn3nzF?=
 =?us-ascii?Q?/zD2Sw7OSnuM20/C3sDgahZHqgV91If6j8xusuxbD9XACn3HABdUpWKbXFSL?=
 =?us-ascii?Q?k1IJx3Ba3oi9HdHAyNY0zMC55IqTJRlAhnJipzEELzjMFSJ1IByUhhXQ2PDv?=
 =?us-ascii?Q?WO7NnawP7Rutg8Appjs6VWx1VHSxgZLbpSwxSMGHGiD8mYhP0JEovMjqPaqB?=
 =?us-ascii?Q?jzCHg6U6H6xwEWi9br/IkMkXA6uqaU0BPxW66+A4XyZklxxyElo7VVScRFw7?=
 =?us-ascii?Q?ZpVMBn9ulvcxQVeC/+qe9elLOLLNAdwWjHrjXuO2T2Nr+m8DsJdi0RG+cEGp?=
 =?us-ascii?Q?mK28Je3SWo5prxjD/EWOveI7avMi6aViz8JsB0byl5QopD+RQlPROsQtQ8Yc?=
 =?us-ascii?Q?PnS/9JbkXpoRdcFQhth93b73yU6afwujRlsMggU4ij8zaCrYKzYgvYZ6Tv6F?=
 =?us-ascii?Q?mdeXTMBThHghwu/EAFNzTnhu5VAJC6XcS2LOOcs45eoA+EQbk+m3gYpqJN6A?=
 =?us-ascii?Q?9wM7hNmskwenIvCZkloBK8uMflztzzQ4oJN1X7zqdLegq7eKsTLYJCqxjHs5?=
 =?us-ascii?Q?Gm3brfWVYAuNKrRLoLKrSD8rpXLfy84IN3P0Ty9r+YwXTlRTUdvFO2Uti9Tc?=
 =?us-ascii?Q?5bf4oeL/wTJcjI/2LPQ7txsz4vg6s+ebQngybvpk8UjF/bRsEL2dT/9mRRTO?=
 =?us-ascii?Q?PCTwkGfw8hEyzLQm6sq+LrQJOl2DNi5HTRlgiiPfcp6C6ejZyNUOUDoPm/sa?=
 =?us-ascii?Q?dPAw5EVTTq29W97Qj/IYTyR7rn+5+5Piz8NZptZWRLwWH2QipyTdcFOCccSR?=
 =?us-ascii?Q?XJkTJmAZXMOwGBrYDonZfVKebGPrTEwpAig+PD4VqWqw7OcFUF2BKf9cgx4i?=
 =?us-ascii?Q?P7QfXQkFeDmxMfUorCKar0bytt3UAKg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4842dd8b-c75a-49d9-c9ce-08def952b1f4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:51:10.2740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWJpz+a21EKIQHRFbJzSGmhKvBWSYvkt0yeBr85LQfmVV5q0j4TwH1Y9CvK3T6UMiMz+3qSwLGyX3lWGn5rtS3y/UPrPcFqu0P2SU6PIyg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7537
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

Move the boot info into the existing SabreliteMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/sabrelite.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 84bbc2f979..64ebcc140d 100644
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
@@ -110,13 +104,19 @@ static void sabrelite_init(MachineState *machine)
         }
     }
 
-    sabrelite_binfo.ram_size = machine->ram_size;
-    sabrelite_binfo.secure_boot = true;
-    sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
-    sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
+    s->bootinfo = (struct arm_boot_info) {
+        /* DDR memory start */
+        .loader_start = FSL_IMX6_MMDC_ADDR,
+        /* No board ID, we boot from DT tree */
+        .board_id = -1,
+        .ram_size = machine->ram_size,
+        .secure_boot = true,
+        .write_secondary_boot = sabrelite_write_secondary,
+        .secondary_cpu_reset_hook = sabrelite_reset_secondary,
+    };
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
+        arm_load_kernel(&s->soc.cpu[0], machine, &s->bootinfo);
     }
 }
 
-- 
2.53.0


