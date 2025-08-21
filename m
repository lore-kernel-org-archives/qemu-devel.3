Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044B0CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50d-0005AZ-Pg; Thu, 21 Aug 2025 09:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zB-0002Sl-31; Thu, 21 Aug 2025 09:05:45 -0400
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z2-0003Ff-NR; Thu, 21 Aug 2025 09:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6qqjs6CgcGase1fqUrkWrXdunjwE7KnkadSX19L3BUKg389Z7ybjQL+tCUJDW01rS96QHluTIZL6+zi+gt9BLJsMAohV5MLmIQXq2N0kVOBjTnhM4uoNfDN7pdrZcCqAxP4CX6bs1rEUqnP97FEpN5AmUiYE1ML+QGV2xqktz/vTEdNJXDCepDxbOBHZoEosxpbqWxWKzU9OOIc/V9hd7C17VcgtyBIYmvgvGX12awIq/4UWDIGXj/GNwRtPp+kGmSpEckU/5BZNZZn2xJa0l57XU7ALFsfxKG31K6IipDJ6lxOVCwx/iKWV78UxhnTp/+mnAAeRTxfQ8XhqQEJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJDKCJKOfFmoaSyF9n5K4QWhlTiOwVYZGvkbfy9QhHA=;
 b=kLDhoWJonr5ljTp0+xpbnaoj+QbcnxZ8xFeQRafzkWfd/y3xdvaC9TytdUzmAQEewD0/DRIkzg3LlQAU3TIKihY1E97owdbfiO9nlj3FOSmEPayY+UQL2W+Uoz5BkjtXjkSdQhpMQkplUjRyxHwBLeemG1WWUz5nakNJgNagoUGFy1tTkWRWJxuG83SednIfGKOWYamDXW9EN50mN4Zueq0yxc6plgVdnNfoAki5qBhZW4G9KX8+uPoiwscVB0KlDbeWpMOc0wivo5gPhzjljCs4RQ9rVfykdTy/niIz+fjbwHuXdsvRo5Zf1vViPu94NkPL6AoLiMtsPTpxZrVIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJDKCJKOfFmoaSyF9n5K4QWhlTiOwVYZGvkbfy9QhHA=;
 b=etv7MSjQ1OcNCXBaOc+pqovHwvcp+sxKCIHeAf9qdPUG6BcCXOupqIOd9q/aKkLpTbPVYD46p2BFMViQkYddiljRa1nsNA02MZjuUetoKZC6WgkpG2UaztYreEeQVnqLmDIha5VXHZ2KjN4ooDNHyCZQygEPEuT0ie7/XJJpJxs=
Received: from DM6PR07CA0086.namprd07.prod.outlook.com (2603:10b6:5:337::19)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:05:29 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::98) by DM6PR07CA0086.outlook.office365.com
 (2603:10b6:5:337::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:22 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:21 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 42/47] hw/arm/xlnx-versal-virt: split into base/concrete
 classes
Date: Thu, 21 Aug 2025 15:03:41 +0200
Message-ID: <20250821130354.125971-43-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 128991bf-1705-4d31-b6ca-08dde0b36773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s1W5djbpWgsyZx9RDDDODQoTr6ZPJS6L9ts2hHtzp4y/BY7dF7P4RsoX4RZp?=
 =?us-ascii?Q?ttLTxJfrRJXOOODPPabvMUEBZti8mVgX5tvb+c9Apm5Ydyv/+pM+eMdqz5Co?=
 =?us-ascii?Q?N7wXkF03L5hgIKXhbdMiXmY3JorsDHZ7sXXdMVi8FQQioWF5AmDqMHNGkDj/?=
 =?us-ascii?Q?lbA4j1mAagMmQWQGGQfzb9iZWYA8Nlg0fE9hA9BowhLeUc9Xl7ASp8PH71lP?=
 =?us-ascii?Q?uWpHZkQq0OR0aWJg6/2LwqBsijTalAvszRUlH/ISoTRdoH7Co74x0RhA0dss?=
 =?us-ascii?Q?mI6B44WnXKEMh4ljynm+bpSg0QJ+B44P69Tj7qWYRJEV+szp95r1dQNYBhBX?=
 =?us-ascii?Q?3rVcyyKr6TkzCCP+YGfF1NCtYpGSEnf39GtV9r5U15SbfQKe9oMo10aYHTla?=
 =?us-ascii?Q?DWHL2pUGdDWIpeMOY6n8efnA0042S0B+p2u4/XSTu6Y1LUOkXGRCNJxEiNl5?=
 =?us-ascii?Q?ZMnBKtP5mj9rEw/o7cKqKf/GmgoNoyl6XMjqIljDRUToo0T8QGCIsjUCn61B?=
 =?us-ascii?Q?Mdc0QMCX6S7+RpXp0yFb+yiBAuSp98M36WVs8AUmN7QEQVDahAyfzGutXNY5?=
 =?us-ascii?Q?M2weD1X2czgcwJ3muGD+u5PScGH2OodpmE+icSmtG+UovKXd74nwl87jpL62?=
 =?us-ascii?Q?GljHxA+l0EXARFDzRxuf0MkCZoBtlq8X4IdsdZdJ2ScvJMYJSDQ9fnBwEmD9?=
 =?us-ascii?Q?y9M5y5dCcL+OCaUZSX1F6S8rZ7fkFGB2NSZ8yp3lfntHsrQipsyTjkJ0o7nE?=
 =?us-ascii?Q?qqOzk5NYRDUmv267YhnmuPUF9WbYLiU2pQxjRxjZXyHB6r9Xw1uEg5/AhG4M?=
 =?us-ascii?Q?zLEwA0ijjGMB2lycFpUKTIHOcrYf9y4v0PcyfZLreCFdF/6fb3mtKi8mE/OH?=
 =?us-ascii?Q?vWbGNLAa5o6hafVvtmDttC4mL6mR53B+htiGtj2bM0mM5kCKWUjb6csR6hJ0?=
 =?us-ascii?Q?97Np++Vo1HMYOqMuadZrQx9RSX2FZHqVbZ+m9SvQC3tS1xt62DKDWLGP25Si?=
 =?us-ascii?Q?d5JJ9HbDKqNhssC9HhbQYd+aPHiE4+zkhiVtGiACY3jzHlKZ/LWyvMBeCgN/?=
 =?us-ascii?Q?Aoi1doBeLhotCjtsBGJdO81k83OG5ABfp6R25VVv7C2YlkiX5Ez4w9KfPONU?=
 =?us-ascii?Q?CoQmNczYKGo5J6HHwA6OsFouij8O8S11QBdjqLK+vV5u8pvF/YlJq0kpRHXH?=
 =?us-ascii?Q?eLgELQ166d+3B4cZfbh+si6ycx0vCvMMnHkyOOZIIbU6vxJTz6GZ3ghiz7AQ?=
 =?us-ascii?Q?Hu8c5Ud47XaoEiTLojrvprN3rgnpqOwvPnUkhq7n7g5zKGVbtbWnpHWkwgXX?=
 =?us-ascii?Q?RXTfyko1mJG+GRFlqtPFU1Mx0n3sywJSbnwxjizLn010cJAwt+uNC9Te5/Ln?=
 =?us-ascii?Q?vFZ0Ymwc4d+8/MG2AQwY0953gToe5/OsIC9FXVOgKovsn+3E57Td4DhKFmyS?=
 =?us-ascii?Q?1Es/9sSYc8tXhmWRshFuUagbiz+p/2KKkiXtwAV5sTE+fKbuvIjq3d5ejq+I?=
 =?us-ascii?Q?E+BFE5lKGlHHU/VtnQqTXH6izkmPTipGle+M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:29.5071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128991bf-1705-4d31-b6ca-08dde0b36773
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555
Received-SPF: permerror client-ip=2a01:111:f403:2418::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
the versal2 machine.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 74 +++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 53987db4cd1..40ba053bd08 100644
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
2.50.1


