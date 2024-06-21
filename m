Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B4DC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdre-00018U-Ke; Fri, 21 Jun 2024 08:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrY-000123-0X; Fri, 21 Jun 2024 08:59:32 -0400
Received: from mail-bn7nam10on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrW-00013E-1P; Fri, 21 Jun 2024 08:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFq/84e+LQk4IL+mmCe/xGoWml7BIBginqOlhI/78Uhf8O5j+O4CQ+noyLrdbP4aFLj4o0LpnAO9j+hb2VBeqSvjVWFWYprHVVphFs5SuJE2hpxZm8vblSIPcupTNMULhkcThn90SkZQPzA9dOV+ElqyAmLyirGnHauOxxGFA7W/BcDbKFVrsBP52Dj5/Kmaf6z6pUL+GzSv/tz0aYvQngBJKCThCY3XQRG0V50+v31Dl2Xf3m6hMZ/tkuxuoZHNGvZ1TTXF9A/q4PJXEHzWGFgteec7+qTSl9UIqkW5zqqiZP1bQc0PDXcWT/8LMrfBrm9OIcq124T0MjMXP5hDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ6n6nZoM54e8HZCrnceC2U4DysPCWXSlPZ3QhACs6w=;
 b=ScFYh0p5vMgQajvAOv6g+kDJSo98PpN7boiWOouVrwXBvZdM4BekcYyhEWU4w/lMAhP9/ApBj3E15XNsrYHay9Yo7tmJPT6MMKm+t2jPIrfkzVDMv2Jha3emCTTcPpicl3JXaJIrzp07uL+o3JU2y/qkr5cN//t+qFqVaZ3JdnpLOnhJuYeeP+il5KN+3/2MxLVsL1aKZuTVPZRmBYhE+LpnI8qLpzfM/5X82gW9PZKkPai6ps7s/UeiAxLyOhvjv8g3jlxgvVMILyiXteYkhnimFWkZ+c+G3y4Cf2xCF79eCU5507MtHfqM+Gy6QVgFkPhOLH2EFy668ygrA9xT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ6n6nZoM54e8HZCrnceC2U4DysPCWXSlPZ3QhACs6w=;
 b=MfPSw3/NuSKyzGL1py8WV5+8sievnwR7f2JTAO1MPbvIjtd0Yrq4Qr1sHnXyf5uojf2CfDpRMLRDR6C3clQIT7sXtI6ELMTgdpTbJoVpw6tjMZ8gZxhCvmPeC4AemHD9t0emN09zbmELe+VmJ9p8TDTKSfSR2HLe7KSMvf4xZjc=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 12:59:23 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a6) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 12:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 12:59:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:21 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 21 Jun 2024 07:59:19 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>,
 <sai.pavan.boddu@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 2/3] hw/arm/xilinx_zynq: Add boot-mode property
Date: Fri, 21 Jun 2024 18:29:05 +0530
Message-ID: <20240621125906.1300995-3-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
References: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 184162ac-68e3-45ab-48ee-08dc91f1f912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qp+orFz4vMuETUekul6yznNpampYvMbRAVGJxYo/rq3Dqt34boMQ7RSIXkae?=
 =?us-ascii?Q?9ptiQnGBQ9o8oFVHy5IeP5a3IIeiICib98saH9sI0j2zlxvid5/eoe+uLnTu?=
 =?us-ascii?Q?0HSsrVEieZA3EokJNPVggWLKloH4Sq/l8deaMTPSUlA9Xlvuvrwoydwpm8dY?=
 =?us-ascii?Q?nRhi5dbuJBjxUPkzhVeE8XwtsHPJhXADzwOTez1RYVi3RywrHHwiNoO/Y8X8?=
 =?us-ascii?Q?ip989Ll1ZjnQpNjYTySvcDpIk3+/xrkPnDEG+5yUXQh74+R5idMXRAoxKqNw?=
 =?us-ascii?Q?WXDls8ZDwrI1vTMaqaN5RrFSBh56PXPN761T5Ii3T3q2r6JM5rWIOJ7/7APt?=
 =?us-ascii?Q?ruAlhlMktlwFVthodpgra/qBnlIJVCO+tsYjR62jHYQaqydo4LRwfwc9gLIv?=
 =?us-ascii?Q?C2nEQ0zM3SZ4uERnQgRndC/fowLb/7BFBCh8JKNwPdaZLdbtbV7WgFNn/nZp?=
 =?us-ascii?Q?8SLsaAq6v2TG3W3YPPMsU0OMZ9W4HR87BombgPW6ZnAWFmFzeWV1lAeXopyK?=
 =?us-ascii?Q?edijDTEMWl8WwLrwTD9LvINNo8iDyp6L2ckDXSibfA1n064Y+KopvigxtA78?=
 =?us-ascii?Q?SRxtG9sz2DtTDt6a4QIEaIrS4a/XSBZM+4io1issjML1TUFWXUylr00T6Yj0?=
 =?us-ascii?Q?ifchSdTfGXRNLhl9G0fUcf/Xdf99hi69+VgdOyseVc6I391dIBRb3QVhJOBR?=
 =?us-ascii?Q?e4SGPjxcyXfh9nCgqLKST8ZD4dQgeCvHAPgM3WgMoRxqfyBBmiDu+SWcoxfa?=
 =?us-ascii?Q?ynvWuDWvCkhhLwl2bbfr3dSjRGLBmxpsTMXfXg6HgkBwtKZRKXsediVNqjpR?=
 =?us-ascii?Q?A/ryqh3t/Ie9Zbto+RxMnqZeutCptkE+UgKpi58BFg/B2EpsuZ+DN64OPd9q?=
 =?us-ascii?Q?dk1tEQm7/joS3s75bTy5xybXuUyOzGKErRXNzW2ip92z8SKX3seVHushwOE8?=
 =?us-ascii?Q?F7KUUr36e1z3H6it46bSxm0Ue5Qzlxhj1UD9GaZ/Jd32vzWgY2adkTkemnSo?=
 =?us-ascii?Q?WzAw4L7QV+FC6+KoCG+S/cnnh2Lbh1gXiYdPLgmNDuukjGegHDHeJWfSB9pD?=
 =?us-ascii?Q?6faafEXCsTNK6/DE8Zm2O7loWOlSDh00dbASCjfofHG7+mx1AmOSChKYfhWb?=
 =?us-ascii?Q?NuC5xJmtorEMTXcIfHXLDADPE1s9gyvCgS2J8krH6cP0uKZmVkZyZFnRz4SW?=
 =?us-ascii?Q?ZLV9zf6Q7ZFeMWWo2LzSlmipTOTVSRVINMkqEkNlalf4XIoRu5xxvGnQrSyq?=
 =?us-ascii?Q?1Le7IpDq2+vagdFiN+jkjkiGUCXTNodQRmTML2F0qj4qh6Uw+JPxw4gmwRAT?=
 =?us-ascii?Q?8aNkokysSzrUAIJCC7syic1CcMB0OeADF/88wkKa0URbbey/R4mU9rP2hiTt?=
 =?us-ascii?Q?JE36i9Rmq5wV7q4SIz5yF+AVeN85RBBd9qFcIYztEExSn7J3lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:59:23.0232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184162ac-68e3-45ab-48ee-08dc91f1f912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
Received-SPF: permerror client-ip=2a01:111:f403:2009::61f;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xilinx_zynq.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 7f7a3d23fbe..97b6fd8e35d 100644
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
+    uint8_t boot_mode;
 };
 
 static void zynq_write_board_setup(ARMCPU *cpu,
@@ -176,6 +178,27 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     return unit;
 }
 
+static void zynq_set_boot_mode(Object *obj, const char *str,
+                                               Error **errp)
+{
+    ZynqMachineState *m = ZYNQ_MACHINE(obj);
+    uint8_t mode = 0;
+
+    if (!strncasecmp(str, "qspi", 4)) {
+        mode = 1;
+    } else if (!strncasecmp(str, "sd", 2)) {
+        mode = 5;
+    } else if (!strncasecmp(str, "nor", 3)) {
+        mode = 2;
+    } else if (!strncasecmp(str, "jtag", 4)) {
+        mode = 0;
+    } else {
+        error_setg(errp, "%s boot mode not supported", str);
+        return;
+    }
+    m->boot_mode = mode;
+}
+
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
@@ -241,6 +264,7 @@ static void zynq_init(MachineState *machine)
     /* Create slcr, keep a pointer to connect clocks */
     slcr = qdev_new("xilinx-zynq_slcr");
     qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
+    qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->boot_mode);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
@@ -372,6 +396,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
+    ObjectProperty *prop;
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
@@ -379,6 +404,12 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
+    prop = object_class_property_add_str(oc, "boot-mode", NULL,
+                                         zynq_set_boot_mode);
+    object_class_property_set_description(oc, "boot-mode",
+                                          "Supported boot modes:"
+                                          " jtag qspi sd nor");
+    object_property_set_default_str(prop, "qspi");
 }
 
 static const TypeInfo zynq_machine_type = {
-- 
2.34.1


