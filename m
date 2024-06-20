Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F73CC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFF3-0002cU-Gd; Thu, 20 Jun 2024 06:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFEy-0002Wv-S3; Thu, 20 Jun 2024 06:42:04 -0400
Received: from mail-bn8nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2414::605]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFEw-0005Y3-S6; Thu, 20 Jun 2024 06:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYW1v8fGo8bk8LHvuvhohHR8bDPa5LXIw6n4Io0Mn+HERVG2a6GMCbfX6/ssq8Jc35akO8uRL3KsxUMaIVfVnPkHBqhntbft5gq0rsUiO5RdyBHUP30tzZYCcvJ9L809D0dpAuXzdNdxeSxyQGO2PeFSGs+S8hgWo4RCAo9dAx8iiymniyeUyyDlJDAhpNAwsyLQfRfZe1oXA7gXloEhUjiqPKNcQaMfj+bxHKaOyyxICxKUSckSY2aFhJkthghJ5UwnthElRkvpVvfmlVudky2FnPxbgrdbf0j+gCoJmjGoad50JYSk1URPwv9/uyXO6hhOK89YgKC+gvUFzySxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/j6hEXsPcVnXJNDyZ+iR/T2sfMvC89VlDtZBGjX1Xk=;
 b=Ytk8W0ecT/nI/P6aj5PKvTiLFn8RgnHbTQFllT+wqc306x26qFFEWm3YtQ485EY8nIZ0y0S8+aI/sHa1B/YuQEZ/S46zmOwX5cvFMvJpJ56q0+u8fRvNKBR+Kbqvw14qnQJcfZjc+R98xm7sV7xIveALnnSamOdOho9dlmsXzxiCjeyd1NduYP61BzadMJQwbWYqnBFHzsfTRXcy0sMsgM2FDAOzTl2S/Xnxx3SCnV1FPYPaMRHm0nndKFPAq6lwrJr+rRAE3Ix6LRPmt8clmYeu7z01opTf/VbHuTx0Zllc3BhC2dJ94I7rNpVnsvsYYCScBSOM4Zm7DFeTLUXj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/j6hEXsPcVnXJNDyZ+iR/T2sfMvC89VlDtZBGjX1Xk=;
 b=QNr0IRrOcHkinGp1PSNQvAvj17LVkhK9zSkTz0e+QZtiP8s5IlcbDIayGrjVwsGNEuT5eRVw7p0KgsWviupzF0Wiumm0aQmmVGH/vQTI1uP8yGxYS6RxTwvSY1nkvFbEdyZRdxgk6rXAydh2hrlFsoOFiKjskFAiKcyctkvXR9E=
Received: from BYAPR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:e0::29)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Thu, 20 Jun 2024 10:41:55 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::9e) by BYAPR05CA0088.outlook.office365.com
 (2603:10b6:a03:e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 10:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 10:41:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 05:41:53 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 20 Jun 2024 05:41:51 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>, "Edgar E .
 Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 2/3] hw/arm/xilinx_zynq: Add boot-mode property
Date: Thu, 20 Jun 2024 16:11:38 +0530
Message-ID: <20240620104139.217908-3-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
References: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6fabd8-7b78-4dc0-0b4f-08dc91159a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QCsz2uJzPxrTRGLarSuzP3Gty7LOLT3bwmCuiHTvfOY1VsNLq7ZsNLv1vrAz?=
 =?us-ascii?Q?xFJ5B0zHkPK81rb+1/3T96BTSQ5CV3FOyiJQ30OHI1oWQ5xMAeNVFKdHXFgH?=
 =?us-ascii?Q?tNVIsnyV2mZ0I5KPeO1Dv9jB6D7Guxe1J5CmPPChsg5HTsXMmkdvxug/F9kk?=
 =?us-ascii?Q?NrPifRNe2Uicz6s4rVbEfJ3onoD2kzgbdNIQDDtoep8RTDDwMQdx8/Wms8fi?=
 =?us-ascii?Q?Mtue90ljG4hwZ/G2Jj8XquCX8tW7yUB0GmbL9yu10zUFiDvdP1qLB+FZNpVa?=
 =?us-ascii?Q?eoqZmBnKV2mSHPnOVdwYqbonvpduzTRWLA5+t19G/OukRb5/e+ScoFjKkONP?=
 =?us-ascii?Q?8fs1IkPryOvs7W+qG7gXzaQotezdqJjdkJAW7p8ioP484PKKAMaqZ8HkitPE?=
 =?us-ascii?Q?hma2gFNhoFY3CLckHPS/yz++93JUJbrqBkDHYvI1Sqz40Zx3dDvqWgOMyjJn?=
 =?us-ascii?Q?tp5p3W03VfsqIAlv+wYnS3ZAgvsw4VsboM5tKWafiZa3HgbRsMHJon4HsY6u?=
 =?us-ascii?Q?6sp7ti8teyF3DEJ0SV8v/E9H2aL+iQxkZUT5IiB/gW46IduK77i9QzjhKmMh?=
 =?us-ascii?Q?3tXDd6YoRCNiQq4wZrSx/bY7atl6PWkUtSBKnpSXHYt/O9UehU7IwyNDGShn?=
 =?us-ascii?Q?WT2jspTZ0+K49aCXDJ35IPNr2jrP+kxkdadV9leegUeLmjANYWm4K7HEXHBX?=
 =?us-ascii?Q?CeKKuTegXOrZvnvCm+v2jRTANbLNWWsGS8wVWFB7wlXAd8MPIq4eaB9iyR4W?=
 =?us-ascii?Q?9VP3S02r7h1XovumbB0EF48vNxwLMwQDrnL6EkpUsLF7+7LYme0BBEiIkXaJ?=
 =?us-ascii?Q?I1V27xpjGJnQzuUcoGPnIxBA1RzXvKjvx3tTFbSed0iaC9MRXNaxAwTFyMrz?=
 =?us-ascii?Q?fZPCPNXhWm+gAS7tGpV9bZNeLn2q8Z8/K9Yp25gLeWvFsebALOl7UXkRE8q8?=
 =?us-ascii?Q?q/xgOGf+UuawnkDrO/c2+uK1dgAjP1MPl0ttA3e2PJ1V6CTjOhuTLHIiUPHX?=
 =?us-ascii?Q?7dozkbZ6aQibUpRuM01Y3eJreKosv7Db6xk+Qnw15MtyvHTBHsivylIAO1xV?=
 =?us-ascii?Q?wxAiN0ypeNTjYFxnlPmgQWNeqjicJC/X2JOPdYUhfsKGSdnKIa2mPjExtFF4?=
 =?us-ascii?Q?l5mhfg17ZrO4bsiXDc4AwT/zfaxZ02qibi5bLlz2qqTDWMZslCuxkMdZ+7nO?=
 =?us-ascii?Q?QZMHFuOGdIW0+VTluJCoDNU+LGqba2uXLvKhn2HE8xAs8e4lFb/UzXyOPV5i?=
 =?us-ascii?Q?VaHAoChvYznkmkNAHOM6xOKmiwpTsueC9Vg4nfN3fQNEm7BwwURRMF9oqD8W?=
 =?us-ascii?Q?EleKJHYNRQ7LYPOjxjamAiy9LDlbxIUb293MNGiXmPd39fgVaIFgHVIkaJtH?=
 =?us-ascii?Q?nS+hXDcgsuije1J6gKOyLZgw2pIdMp94Dlx0AmlXiwIVsuYlsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 10:41:54.8496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6fabd8-7b78-4dc0-0b4f-08dc91159a69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
Received-SPF: permerror client-ip=2a01:111:f403:2414::605;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xilinx_zynq.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 7f7a3d23fbe..39f07e6dfd8 100644
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
+    if (!strcasecmp(str, "QSPI")) {
+        mode = 1;
+    } else if (!strcasecmp(str, "SD")) {
+        mode = 5;
+    } else if (!strcasecmp(str, "NOR")) {
+        mode = 2;
+    } else if (!strcasecmp(str, "JTAG")) {
+        mode = 0;
+    } else {
+        error_setg(errp, "bootmode %s not supported", str);
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
+                              zynq_set_boot_mode);
+    object_class_property_set_description(oc, "boot-mode",
+                                          "Supported boot modes:"
+                                          " JTAG QSPI SD NOR");
+    object_property_set_default_str(prop, "QSPI");
 }
 
 static const TypeInfo zynq_machine_type = {
-- 
2.34.1


