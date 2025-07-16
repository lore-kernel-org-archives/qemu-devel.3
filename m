Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1CAC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyuk-0002fP-Sg; Wed, 16 Jul 2025 05:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysP-0002Jf-1F; Wed, 16 Jul 2025 05:56:39 -0400
Received: from mail-dm6nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2415::61c]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysM-0006ny-DQ; Wed, 16 Jul 2025 05:56:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg7UyyiohLO/wHRmXQDxdM6MqTh88I8UL4RUkEZ9NqFqWp81NnYiMwjibM8rk4PXRfq9w/uW4Vb1HZIDnYq/X6JBzVvWCWF3H50JMisqMRUgWm+mXvhEgWGWcBOO/VF3PFhg9KEsAqgm4/ruWCOM89HnEDgbRuW/+iOoBffDlaRo+VbR2eEsq6rvDLcTDQZ7MvEI8xu/h3QYXP6c2ACnBrkIv1yIMBnWNUNyzUf1qfHq07K7xdl9C9NtYTRY5IXtsCKUV/I3onJ2UqfUH88ObPUpuOekVFHUlbUJ3uw9y6r252e/SplXtomHRnm4BxpRd/p1GFbiGsKo0LvTRUVWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb7G5Fa6Gs1zvhnZfGDDLsOlew36761FPH//JYQQ4/M=;
 b=pT0mJWFZqMFZ77xL2o/Xj46KAFY5M8CyIA4TLmhjVzSkUsHh+SzsPrJAyMGxyum3T0+5QU3Q0GL28S/d776yEpVa9gTbB4iLEYdAs/jTrH0LC95Yi25iB3y2AtuHEErbNKFxO7/iDoJIuClEq/8ApS0WQA1U1X0380aeclSyP8vs0Gv/vGFuckbjpXqSoEbnznPwD4Nrqzi4eAE03lGuS8O8AwiqK+spJOsBIuG08NTFLqnFLCTQ+YV3qieDexS02ZI1o/7mb0iutYSQv0GeKy1VX0DbbCKkvrVrVP7Xc4vuAPovssyfAtgRIXJmK+/2IAC8L7oTBX3RWjr/U+dFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb7G5Fa6Gs1zvhnZfGDDLsOlew36761FPH//JYQQ4/M=;
 b=oOoJ0sSyxJbP435v1D3VbOy/t8vaNcjTHBXdtRbfpX0cnCX6D3QBQlQvNG0z2AdJh1x3UvJDA1h2K1ORF20l9DbY/2l+QHmnNP45TYt1mIMYJn/HAE/U9zT0jhMxnG6gFcsFSZMSCj2A6wqZp5WiwmP7JIyKkrh3CwLTK+vzPDc=
Received: from DM5PR08CA0056.namprd08.prod.outlook.com (2603:10b6:4:60::45) by
 SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 16 Jul
 2025 09:56:27 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::bb) by DM5PR08CA0056.outlook.office365.com
 (2603:10b6:4:60::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:25 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:24 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 43/48] hw/arm/xlnx-versal-virt: split into base/concrete
 classes
Date: Wed, 16 Jul 2025 11:54:25 +0200
Message-ID: <20250716095432.81923-44-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 4892c81e-712a-403b-27e3-08ddc44f080c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a8vdxvr8fWP7olgR76Q6zd5CBe4GLZDWoJtILqxrsHkXgklRKlULC8QgbDIK?=
 =?us-ascii?Q?CsTUgdob2scLNArvWyl8xBVFL6vcYDHd/Sw5s+bnC6WaMEtYAz7E741Xopcv?=
 =?us-ascii?Q?BXwubag3odfI47hRZ39WT+LpmouI+Y6emC9+e8YZX+Nq9oxR/krSWmKPZswB?=
 =?us-ascii?Q?CV3TtuBYDNqSWUm5yXvP+omEGp8F5WNHmoM6Eb6mr0pvY11XAnfszuG/qB66?=
 =?us-ascii?Q?zX+Rq8rSD1RdG0ml7ahFJxr/nsm0a59ZxPTBm09cDFyNxQrQ2p3ZBtmEg/Om?=
 =?us-ascii?Q?ap3CxOejiC54yC5fsiLd4Cs3pdjg5e/fmhmyYrXUmRYH7q/Z8MsBzfmz4Rg+?=
 =?us-ascii?Q?tCJBaPdHIKkvmco0+lJcJ84L0QRgaJu/NKn3VbBU3qrmiyV+CjD+09Z8XvGl?=
 =?us-ascii?Q?vUMOPIqrDQHdLIcsNyYQcpxQKbGbq1gMCoW7u0/hd/PQnvTMD3ZHjSjSs/yw?=
 =?us-ascii?Q?t760CLe9elB34Zn9dmPOzXfxNt24PLQ6EIaVC59b94GkvLDwospfBuew0A8r?=
 =?us-ascii?Q?cNH/KgYm0Rvqwp+AzRe+f8qHhQbd7KeeiuogJRW3LK/KsWxp+18LHwHRAte8?=
 =?us-ascii?Q?VypkmumdFibPQqPmv2SlteO1hN1KAbET/i2nmg5krdJPVrpcxz7LusOQwVcy?=
 =?us-ascii?Q?j96RhmkULveT6gDvfxWZmXuoL9XDfKyOWk45xt3CkserWdlACfWmiwz/PSII?=
 =?us-ascii?Q?k0nLeLb0ytJl09mrATpnvdHrcNgfAfM+Ku/yQuTzJpDgbTPnWPBUSJxpERt4?=
 =?us-ascii?Q?R1OojnzJpPs1qJ9Mbz8hFM6I8xpPY7bWkXC8gRRN0y01MKnZA/LLogceXmUR?=
 =?us-ascii?Q?K4RMODUbOMEmTku86EQ5TmLXrkScoBn57Ftg0Ew88iCPqKpTVXsva+J/+55z?=
 =?us-ascii?Q?Q5g4u/iaABaYiJM77e8Dvx5gTA8dawuLw8v8Lf660nmMnlj3Xr9EEadkciKj?=
 =?us-ascii?Q?otyEWZuUlPdjx8IjINGmbHXmaAXzQHnM+tEtxyiBsiQFyGO8IwjedMT8Gfx2?=
 =?us-ascii?Q?F+GbvTP6dt3IUV4lwsLt7wCF131cSNN+iyLR1mHduypNyHkj1TPGC6dqLs3O?=
 =?us-ascii?Q?Abb51cGujOjytc9CxIq6SDHSj7pqZ1d2sd/cCoiVAyQL4vlPp6YGar801IkP?=
 =?us-ascii?Q?AXiMKSwp/hndZUfHlouWj8dC8dmugifvC3mgMiz4hX8zDJuexnszZMbWjUqC?=
 =?us-ascii?Q?j91crCIPbNQI5qNszo3y7WHzbMW2HgjAOeQgqR6o4CcGMqDHIVcIqivl1gPR?=
 =?us-ascii?Q?F6Rqog8zZthnHpRh381J3puishQmRB7fUnvaPDcucHiENO0AZqNMnQw8Nzu4?=
 =?us-ascii?Q?KCed2afP2nJIgvo8Lq2i2qXTVBHP/loLnsrsjkaMkCpFvUHqYbF6G9rvuzLi?=
 =?us-ascii?Q?m9fKd+zbg5hgyReC2CdP+PBGBHuk7ejet9ORr/9OAL0nxJWOQmVP3ymOCSYb?=
 =?us-ascii?Q?UAQ3T+tZsCiot4dACrp8lW3USmiG1xdqiEeqAa/49//BEQDH2qVcTz7iR81S?=
 =?us-ascii?Q?2AaMZnQvsfQ+uwS/ommDAE0NbOmdzupa9lau?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:27.2165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4892c81e-712a-403b-27e3-08ddc44f080c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
Received-SPF: permerror client-ip=2a01:111:f403:2415::61c;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Split the xlnx-versal-virt machine type into a base abstract type and a
concrete type. There is no functional change. This is in preparation for
versal2 machine.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 74 +++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index daacbfb984e..9b20aef8b07 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -24,12 +24,15 @@
 #include "hw/arm/boot.h"
 #include "target/arm/multiprocessing.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
+#define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
+    MACHINE_TYPE_NAME("amd-versal-virt-base")
+OBJECT_DECLARE_TYPE(VersalVirt, VersalVirtClass, XLNX_VERSAL_VIRT_BASE_MACHINE)
+
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
-OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
 
 struct VersalVirt {
     MachineState parent_obj;
@@ -50,10 +53,16 @@ struct VersalVirt {
         bool secure;
         char *ospi_model;
     } cfg;
 };
 
+struct VersalVirtClass {
+    MachineClass parent_class;
+
+    VersalVersion version;
+};
+
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
     const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
 
@@ -191,27 +200,28 @@ static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
     versal_sdhci_plug_card(&s->soc, idx, blk);
 }
 
 static char *versal_get_ospi_model(Object *obj, Error **errp)
 {
-    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
 
     return g_strdup(s->cfg.ospi_model);
 }
 
 static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
 {
-    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
 
     g_free(s->cfg.ospi_model);
     s->cfg.ospi_model = g_strdup(value);
 }
 
 
 static void versal_virt_init(MachineState *machine)
 {
-    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
+    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(machine);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(machine);
     int psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
     int i;
 
     /*
      * If the user provides an Operating System to be loaded, we expect them
@@ -239,15 +249,15 @@ static void versal_virt_init(MachineState *machine)
     if (machine->kernel_filename) {
         psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     }
 
     object_initialize_child(OBJECT(machine), "xlnx-versal", &s->soc,
-                            TYPE_XLNX_VERSAL);
+                            versal_get_class(vvc->version));
     object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
                              &error_abort);
 
-    for (i = 0; i < versal_get_num_can(VERSAL_VER_VERSAL); i++) {
+    for (i = 0; i < versal_get_num_can(vvc->version); i++) {
         g_autofree char *prop_name = g_strdup_printf("canbus%d", i);
 
         object_property_set_link(OBJECT(&s->soc), prop_name,
                                  OBJECT(s->canbus[i]),
                                  &error_abort);
@@ -272,11 +282,11 @@ static void versal_virt_init(MachineState *machine)
 
     /* Attach efuse backend, if given */
     efuse_attach_drive(s);
 
     /* Plug SD cards */
-    for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
+    for (i = 0; i < versal_get_num_sdhci(vvc->version); i++) {
         sd_plug_card(s, i, drive_get(IF_SD, 0, i));
     }
 
     s->binfo.ram_size = machine->ram_size;
     s->binfo.loader_start = 0x0;
@@ -316,14 +326,15 @@ static void versal_virt_init(MachineState *machine)
     }
 }
 
 static void versal_virt_machine_instance_init(Object *obj)
 {
-    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(s);
     size_t i, num_can;
 
-    num_can = versal_get_num_can(VERSAL_VER_VERSAL);
+    num_can = versal_get_num_can(vvc->version);
     s->canbus = g_new0(CanBusState *, num_can);
 
     /*
      * User can set canbusx properties to can-bus object and optionally connect
      * to socketcan interface via command line.
@@ -337,47 +348,66 @@ static void versal_virt_machine_instance_init(Object *obj)
     }
 }
 
 static void versal_virt_machine_finalize(Object *obj)
 {
-    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
 
     g_free(s->cfg.ospi_model);
     g_free(s->canbus);
 }
 
-static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
+static void versal_virt_machine_class_init_common(ObjectClass *oc)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(mc);
+    int num_cpu = versal_get_num_cpu(vvc->version);
 
-    mc->desc = "AMD Versal Virtual development board";
-    mc->alias = "xlnx-versal-virt";
-    mc->init = versal_virt_init;
-    mc->min_cpus = num_cpu;
-    mc->max_cpus = num_cpu;
-    mc->default_cpus = num_cpu;
     mc->no_cdrom = true;
     mc->auto_create_sdcard = true;
     mc->default_ram_id = "ddr";
+    mc->min_cpus = num_cpu;
+    mc->max_cpus = num_cpu;
+    mc->default_cpus = num_cpu;
+    mc->init = versal_virt_init;
+
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
     object_class_property_set_description(oc, "ospi-flash",
                                           "Change the OSPI Flash model");
 }
 
-static const TypeInfo versal_virt_machine_init_typeinfo = {
-    .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
+static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
+
+    mc->desc = "AMD Versal Virtual development board";
+    mc->alias = "xlnx-versal-virt";
+    vvc->version = VERSAL_VER_VERSAL;
+
+    versal_virt_machine_class_init_common(oc);
+}
+
+static const TypeInfo versal_virt_base_machine_init_typeinfo = {
+    .name       = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .parent     = TYPE_MACHINE,
-    .class_init = versal_virt_machine_class_init,
+    .class_size = sizeof(VersalVirtClass),
     .instance_init = versal_virt_machine_instance_init,
     .instance_size = sizeof(VersalVirt),
     .instance_finalize = versal_virt_machine_finalize,
+    .abstract = true,
+};
+
+static const TypeInfo versal_virt_machine_init_typeinfo = {
+    .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
+    .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
+    .class_init = versal_virt_machine_class_init,
 };
 
 static void versal_virt_machine_init_register_types(void)
 {
+    type_register_static(&versal_virt_base_machine_init_typeinfo);
     type_register_static(&versal_virt_machine_init_typeinfo);
 }
 
 type_init(versal_virt_machine_init_register_types)
-
-- 
2.50.0


