Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB9EC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmVc-0000cq-6s; Thu, 13 Jun 2024 11:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sHmVa-0000c0-UT; Thu, 13 Jun 2024 11:37:02 -0400
Received: from mail-mw2nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2412::602]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sHmVY-000201-S2; Thu, 13 Jun 2024 11:37:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY8ks2INJA1ZhxAWNaOyRpLmJ5TRJsIMfGev9Md1N7V1zvPCG896enECXDBkB7JsLoygg+jK4W2AmCoM99j49wcBD9usHeZtddtRvdtFhAEKpJc3HKZM1LGdvnNVsw3jHgm0fMbj0eEdK/1Stg2dRLt5nE6KygfqImVSuh/vNNaQIik+kaLYFQ3MZG7T5spo3vy4gBa4eC2LWcnBeVspc0eXhnVYP9OQrBa7CF2WtCsTkx0LagbbkhZnSuCnrGdVLZDAIh0m1GWMt9d2RdSi29MCgK3Y1fjhM7Gk/vwQwvYRWsbcWrKUra2uzqCb/mq4v87TzKiUxuSWjn2qjEwtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2LdwskvTbmP1FBwAGD1nVT/m+pLU06a3gII7S2/xOk=;
 b=b4aWT7Uv6xiQHVBSPM9i3zCBHNte/2HrV7g011XSGsqD/HzUVA0Rv8Bc7rm8WHxkd4fuGZRQqsisLXcxHYtVCRnAKSEbhiPfXPq+BLeZO5uS84I96NW7G4Mpg/AXT5g/+FSdgpo1KKRIDqu8nrJ5ly475mlrUdLV74tQfdJSkS8EeP2Z7vv4DlG1JXo5mJ36PZaaNZWqXoqgAvA0qEeUJVTmxD6BuVPZLi1nvBIf8OcZuX7Kl8gO0hBqCWta6FnHC81BBM8NhERYveU4G5bNFy/HFXKH54o/vmCeqa/+5yNk3jTxHISfNQq5zRaoFWjpUSza77pvqUUsEtKM+/PcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2LdwskvTbmP1FBwAGD1nVT/m+pLU06a3gII7S2/xOk=;
 b=fdZngdwRE2kCavYO3PRLkxS0GRZ96np66GvziNpXThRtYG5dlwltCZbZTwBOxN0uaSTjGptPa3smTAz0PXQRfCyB2L8LIzImBE8vBcro3XU5GGNHSW3ed5sBYqdK56S+SushbxEsc/wV5kZk79Bt/gDQ1O2XWloNV5ZmQRwaN6o=
Received: from SN7PR04CA0035.namprd04.prod.outlook.com (2603:10b6:806:120::10)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 15:36:55 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::18) by SN7PR04CA0035.outlook.office365.com
 (2603:10b6:806:120::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 15:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 15:36:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 10:36:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 10:36:52 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 13 Jun 2024 10:36:50 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>,
 <francisco.iglesias@amd.com>
Subject: [PATCH 2/2] hw/arm/xilinx_zynq: Add boot-mode property
Date: Thu, 13 Jun 2024 21:06:38 +0530
Message-ID: <20240613153638.3858853-3-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613153638.3858853-1-sai.pavan.boddu@amd.com>
References: <20240613153638.3858853-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: e4838393-654a-44aa-8d60-08dc8bbea6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|82310400021|1800799019|376009; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l1iBFITsVQ+sozwHRiYWTPyAIaJ1Kb1s03duK8/HZZSl8/yRnWWi6Hwklgqf?=
 =?us-ascii?Q?PLyPnBhif6hQyIgGB4qBaa1bJUiZ7huUoqHEokOXxGeN11xtvZ8bQoPvdlFd?=
 =?us-ascii?Q?DVloWzCy0H2vUycgqVjp7WWhjkJjAA8QtdxJjRE8tnNC9DmAaqnfq1xABhIL?=
 =?us-ascii?Q?2UjHdLXxJ2F0YtJxmnzfQczqzKfFgoaM1WE3djIfztNSx03jlf/Yzyt6d+8P?=
 =?us-ascii?Q?3NlhRQG01CsBs5ypde/Lnb3ocqNusgEkSK54IxAofnYAMtfWJmiLmKVGe5zL?=
 =?us-ascii?Q?h8cYmCYle1WSAVCNwbEmV2y+vxVT0VMYAwDMTCftcWKuR9EV7FJFBv+bOUNH?=
 =?us-ascii?Q?B7b48mzwPm9LFP9Ogh8KqB5p6Q0M8AM/oj35Fj0qgrn98CB0wuRLObwwuV6L?=
 =?us-ascii?Q?oUB9MfDzkEFN5RkVfpN4CFMBVdlNhpkPtezVwKy5BcfABtKyXuwNuI9a+Xvg?=
 =?us-ascii?Q?487HATsSwtuH7z/193Ifd00YR5Q9CV+il9ohi49Pa65mOwqWfKjyMG0eRSIP?=
 =?us-ascii?Q?J0dDZn9pWrFFzU4IpZQfAJDQNmSTub7DukA7dB+ygxUvaaUdYZ21q7KfFzZr?=
 =?us-ascii?Q?rjNCpHZNJanf2WJRDMqlfwbWajLYclD5x88i+S6aRuq+y6ep7GLLg+L3Dvtm?=
 =?us-ascii?Q?42BvmQ1b38DKg9VTvTCvZWwzopaJDDpd9Qe8AbcmSv9oXjmoURTfYgZXmU2t?=
 =?us-ascii?Q?iaUlHnilPjLfJYQU7nTN10b04xYtsVHdOTKi1B+tb+TlCFRdx7iX5wpjW/PM?=
 =?us-ascii?Q?sKRTk/K6/bo4zG36xdnjxKuXO99T+EunKi+ZAcIqZQzTS0Z35gxaE3NfQpVF?=
 =?us-ascii?Q?xdDbfWEjctwYfVc0ohZS43QzXjAKoTOMat/VoDhZBlRn8wLnPUAshjwB7aSt?=
 =?us-ascii?Q?ylhR+3spaUnQ0sUMZgHsSJl0nMi+NfaBoP8O+P4kTWNQlq9KWPgYS3JJ052t?=
 =?us-ascii?Q?INWwV9sgDUXBkJ+xYMesAdiPPrcWwKXDvRxe9PlRW4Sa/Qj6N8f5PB/woOkc?=
 =?us-ascii?Q?B/aTo3G8XxcdQHy8ruiRptaHjzgX2vusO+79Wm7ONZTIFffumlHwsTV6CCE1?=
 =?us-ascii?Q?/hRHEV1J+9ML7YiM5tPCbHTRU+zbJLA91cn31lik5EQStvusb0zsLOAhhQXF?=
 =?us-ascii?Q?fYn1IpcyXT9yd0GXEx2Hvnh1GXMBzlsDZeZtrZcEbxoMeB+Am8g4XcTw9wIP?=
 =?us-ascii?Q?jkVMhax1j3Gbqx/SSAfxj/xnH2MnMJU0WKuz8L9FmOLoCxHGAScPaRZAFroo?=
 =?us-ascii?Q?KNDNko6erHmwhoxM6axBT9TqaXNGnAZCyQQVeHAY3DDkkYwXKO7Vl9yheDF0?=
 =?us-ascii?Q?odL3jcMecxBEKVUeenrtZR4ujUt7VUmfif+CjZ2pw+tqg7zyxDr+LLtLM7sM?=
 =?us-ascii?Q?/F+7YnOhkI0mEHIje0AWFLD5zUMaRMROAXVsBsfgggOllMg+rg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:36:53.8259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4838393-654a-44aa-8d60-08dc8bbea6fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
Received-SPF: permerror client-ip=2a01:111:f403:2412::602;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Read boot-mode value as machine property and propagate that to
SLCR.BOOT_MODE register.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 hw/arm/xilinx_zynq.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 7f7a3d23fb..4dfa9184ac 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -38,6 +38,7 @@
 #include "qom/object.h"
 #include "exec/tswap.h"
 #include "target/arm/cpu-qom.h"
+#include "qapi/visitor.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
@@ -90,6 +91,7 @@ struct ZynqMachineState {
     MachineState parent;
     Clock *ps_clk;
     ARMCPU *cpu[ZYNQ_MAX_CPUS];
+    uint8_t BootMode;
 };
 
 static void zynq_write_board_setup(ARMCPU *cpu,
@@ -176,6 +178,19 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     return unit;
 }
 
+static void zynq_set_boot_mode(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    ZynqMachineState *m = ZYNQ_MACHINE(obj);
+    uint8_t val;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+    m->BootMode = val;
+}
+
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
@@ -241,6 +256,7 @@ static void zynq_init(MachineState *machine)
     /* Create slcr, keep a pointer to connect clocks */
     slcr = qdev_new("xilinx-zynq_slcr");
     qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
+    qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->BootMode);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
@@ -372,6 +388,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
+    ObjectProperty *prop;
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
@@ -379,6 +396,11 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
+    prop = object_class_property_add(oc, "boot-mode", "uint8_t", NULL,
+                              zynq_set_boot_mode, NULL, NULL);
+    object_class_property_set_description(oc, "boot-mode",
+                                          "Update SLCR.BOOT_MODE register");
+    object_property_set_default_uint(prop, 1);
 }
 
 static const TypeInfo zynq_machine_type = {
-- 
2.34.1


