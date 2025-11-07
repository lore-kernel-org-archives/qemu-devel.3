Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D2DCCFA1A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJda-0008VJ-D1; Fri, 07 Nov 2025 05:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdY-0008Ui-8k; Fri, 07 Nov 2025 05:24:08 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdV-0000qz-Lj; Fri, 07 Nov 2025 05:24:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqSUwDWSSVGoOBUpYeEl0tJEIJcoJzqOEFpNDaay/F4SsdQ701fK7Chf3xbTSwY0UC3v92DdzVJWl7fx8woi7EuivvcyRHkiQSxJZXOzSCG6dyZZjllJX2VLpcbKgVrZRDylQuqY4ofUl9NyGdQUg2T01CMX8CmuuEK2kCL0uioR0eocdqZOiIMa69dBTS0mSp5tZXnQm7Pc3Itg2ylDBU8pSYO3LbDCGi1QMZjRPJdwjvZnf+VS+Z65aH35OHFbQsKOKmIOdSYBECQiqRbDrqyPbvDYbAjVRGdKUXQwGk0YRDPmPUdU0UTftP0TDXRrfsByW91Ih6icsquX3j76pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54H3ruafHcxFwaxbPBI9keacdZV92zgv0BwZqSbzQCM=;
 b=YbgXbGte2A3vj55EN7uSdtZWLrIeR6rAoB3nG+6VPD3zlbPPTiRFFj6qEacx8REVuX6IIzIIsx/gX1NnwYGqKMMdqGPxosf+xgh64naYUNuWcbeHpn90JWpuTVu/GUycZ6vSh5og2ehfMr+/I5Q4naWor1EDFcz6swby2eDU4qPBuOUO+oXzuI9GBQCFUC075nPsmlZrc14d1zkMBfW3tiwvaRMwJOqDEkhbWoER7Dtv3LRdNBcfMOZA+6y3+iiPR6vMt+iASpgtvwcJH8n1TFzS1IQNwCV7Iffk5oEC8A8YNuDWqLQ2t7cD6/0PAmaRgrKUjlRMWPYqmxoAFasiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54H3ruafHcxFwaxbPBI9keacdZV92zgv0BwZqSbzQCM=;
 b=ifE+Uu/jLP/OP70+WoBTF+LtbZ9pHbaDW36WbUg1MsCkB8rnpgsBwKvYXkBeDAhFoncHWmJZQBMM4lFromIpTCf3S8jFxIutzfSep2MWlQA2hlE0h0Zj1yAsxDnqqqgC6AKErUpQ8TWZ9yg6AiyrHpkpj3JATfpKKYN8WYujllE=
Received: from BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::16)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:23:59 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::59) by BN9P221CA0001.outlook.office365.com
 (2603:10b6:408:10a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Fri, 7
 Nov 2025 10:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:23:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:23:58 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:23:58 -0600
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:23:57 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 2/9] hw/intc/riscv_aclint: fix coding style
Date: Fri, 7 Nov 2025 11:23:28 +0100
Message-ID: <20251107102340.471141-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a8e50e-7b78-4411-3f24-08de1de7c3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bh6HMaqtWbAx2v6O9T0BXHqQZ6Gb8NOpxXF9ynjw5NCet/5NSf6lTbHcJwSA?=
 =?us-ascii?Q?hcfjz09d0+7rQAUVOYju3+4lCmpefiZPKs8T8U4Ar0FUdFyRYW6tt7xNT+Q2?=
 =?us-ascii?Q?nGrF3hoaVNOvYOrq4aXIokX+u1KAL+x8pEryGnTyOSIRbHB0739VYXSqbNzT?=
 =?us-ascii?Q?J/fYK+hbIVUN67aW62V0LBmZ2uNVI2ZyMXYBL4gpJDta5YNMhp5LVJxa/YrX?=
 =?us-ascii?Q?q8PwmR4IqPM0rWluuMb53x7uSt/FgQiUb7bc0cUn77NoE4wU9phazhezy8vv?=
 =?us-ascii?Q?YxvFh/sJd9G0upRTGmv4CzWfHfYKNjoin2joj09yvM23HY41vYY8asQhNPuT?=
 =?us-ascii?Q?vFiXbc6NEIk5ercmksDn6EoX+3VI6gBmCgduvemhhbCv7Dn+Mm7sztENm2U/?=
 =?us-ascii?Q?BTFhrdjunf3LbGwzsFTwtzeKFDSN1PA/K/PMS5nDJCNRq8JFJfEUEal5uY9a?=
 =?us-ascii?Q?VzWAQykLRhvcfrRKDO5Yz5sS120/G+qhotPOw8xY0s+M3NgbNQd1COCHtgHp?=
 =?us-ascii?Q?oVtlkdixBZde1Is7MCliP99dUzMMxsqNAkf5sdXCYorNkMImF2hcxhQBhjJu?=
 =?us-ascii?Q?ILFusYyKUdQ9TH+rEKB3buqeAW+UQChERVKMMI1AT2t6BcXPvKL/A20HLItH?=
 =?us-ascii?Q?higmkSl9b29tSPd6r+Zw/B2K0A2sPXc2oUAWJEBq7+TP3ByTVL4PwC9E/vGs?=
 =?us-ascii?Q?itXJrdLRwpD3QcLBivvaiesoh6CtQJBpmpLkPsgWrNuXpuybZwHp0X/OSzVq?=
 =?us-ascii?Q?CVReDYUJsnNJ//izYEhNC9cZO/s7SLZFjatgl3U+g3vrfErt175R2vzyxsS6?=
 =?us-ascii?Q?tqNZ2gHPnzHli+JWBHywHp1ByA4iREyuWhFyHekA8J/VkWNm4BoWTKX5+6y6?=
 =?us-ascii?Q?GmJeLUMDqOqx5tS0xXp2Q8BbVMQUGYdMz573iw6Vz66ZM5mK8W19rzzFslV7?=
 =?us-ascii?Q?5xhl8c8g/U3MEAoACe22EA1otYtQp0+W2/K651bKhVdZKEpzgEcahwYSABKz?=
 =?us-ascii?Q?oExYiLkoXAswUkfNnrXkN/BUgJWWFKdF5Vy/ckmZ425X8a50N6sYIBpOC+Y7?=
 =?us-ascii?Q?mpZdt2hPp8fXCdYUhF5VuLxrZtti2t93o5IaFigs9J4VW8Z7/53ektp6kJN7?=
 =?us-ascii?Q?rQ2cJiGIteGY29wL3l9QffuNIgZx2MkFGox5i83x5MXNZCve24Hbku0o8dEW?=
 =?us-ascii?Q?wxbewpHNJ/7nWt95M2LclxEyw7G0jK6IP82zamBuhockyCN6HDbHKl8PeCpO?=
 =?us-ascii?Q?L8geNLvw7rd+TOgoH+eaZ8z7UJUP8TobOGKU3ovmuiTN9oSsDq16Y42rUZ1Q?=
 =?us-ascii?Q?vYHU43pJ2fIqHLEQurTtv0yiSZSY4YDf3DwxlQei8fxi9LLYBiRNLhsqNybx?=
 =?us-ascii?Q?JpJW90cRV/OFil+FX5MjP+QQ4q9yuVpXTH4xmNNL3cmolJLtnUwnYa8HvlKI?=
 =?us-ascii?Q?z3N5adNUL0Wf84ft/fQVQPSJH3m1JyM7a0/FAybDjxZmmSe/ywBQZ0OxMW8+?=
 =?us-ascii?Q?/OjvLTFNYrWvMY5Z0ve1VMyGnZTBp3RjwtbFo5JcmEOVL2bXBvVUwzNtojnK?=
 =?us-ascii?Q?S/wG1v+ABqOtMt35ig4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:23:59.2474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a8e50e-7b78-4411-3f24-08de1de7c3ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix coding style in `riscv_aclint_mtimer_class_init' and
`riscv_aclint_swi_class_init' functions.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/intc/riscv_aclint.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index c6f13f647ec..5f5ffc61e80 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -342,13 +342,14 @@ static const VMStateDescription vmstate_riscv_mtimer = {
 };
 
 static void riscv_aclint_mtimer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
     dc->realize = riscv_aclint_mtimer_realize;
     device_class_set_props(dc, riscv_aclint_mtimer_properties);
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
     rc->phases.enter = riscv_aclint_mtimer_reset_enter;
     dc->vmsd = &vmstate_riscv_mtimer;
 }
 
 static const TypeInfo riscv_aclint_mtimer_info = {
@@ -528,13 +529,14 @@ static void riscv_aclint_swi_reset_enter(Object *obj, ResetType type)
 }
 
 static void riscv_aclint_swi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
     dc->realize = riscv_aclint_swi_realize;
     device_class_set_props(dc, riscv_aclint_swi_properties);
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
     rc->phases.enter = riscv_aclint_swi_reset_enter;
 }
 
 static const TypeInfo riscv_aclint_swi_info = {
     .name          = TYPE_RISCV_ACLINT_SWI,
-- 
2.51.0


