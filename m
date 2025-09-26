Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E56CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22dP-0002eJ-DY; Fri, 26 Sep 2025 03:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22b3-0007On-E7; Fri, 26 Sep 2025 03:10:25 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ab-0006lz-GC; Fri, 26 Sep 2025 03:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuLJUVzEG7b4BbwXQBxvQQcjUS+P8G+HCaC8bD6YwBrQT8xfnM40fqKZrwItbjpB8GTBx69/i1zamG+gu7/b9epjkLRm6E8z/7FL7q9U1nYNnpBRNi9RqYtfX46V05q+2k50pHgBaadPeMKZ34P1C2YLzBR1DEctmpEVUoovOwrMrDxUoTxrOiF9CfzRip/TflphsXQutfm0AIv20Pzd69ofcArYcDLF89GMFdSCicYxdhLAeUxpKpb5wTsd/Xz4m5XApJuPcrgdLCloztJRPAXYb5Bh0D+WgWBwT+rmBDAGjW6fU+r22L/2HXarxD0nzUIEn4MwYUzaWdAzPcxGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iZb/aLlzlNcGIYWGAJYFwm42DZ1TqAeWTLIrnw8Vl8=;
 b=PE8ejOiYqFv84w4/2UhK9qoOXL15BQ3qfWKk6T8k5ps6X2KqahCNIHPha3nPG3t7UfVGV1s/hpWxmDNoDPSFiKWrKpxMTU3uvDM8Vb1Xio6OsHJ2h20WIkll8kh1YWgeTYyAynbysMtzWz+6D8nFtQ5mo4qG+ulewcYbqvNaeAeGuKPai35YmgokTbmUwN0vT0HONg3Q7f62HITDOGDA4H90RybKnry6oyr8iyz2bVLU7Glq0uSUcWuGcysctSqrJRbaJ1kmhcX/f4JAex3uCCwxkzLobGG7zN02+j9Ryl9tYElddK80GQXff00UVLWPw0245ZsPnBR7Ed96XTfqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iZb/aLlzlNcGIYWGAJYFwm42DZ1TqAeWTLIrnw8Vl8=;
 b=vjb10Mq4tXxTtCe5rs71ijoXNKEsqeYvgxoEYQWnO1/hYbtn62Wg4xG9B8TZ5V1IoXOcOfLvQva/KW4ZK2nEqti3VqGjBTZzO0UmSl5o5+BOggL9zGepFbgnyzYhRxec1Ptjy3XKT/7Ci6hX9nz2DFhsFdmbK5V0zEzciesCFGM=
Received: from SA0PR11CA0179.namprd11.prod.outlook.com (2603:10b6:806:1bb::34)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:09:41 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::f5) by SA0PR11CA0179.outlook.office365.com
 (2603:10b6:806:1bb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:27 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:27 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:26 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 42/47] hw/arm/xlnx-versal-virt: split into base/concrete
 classes
Date: Fri, 26 Sep 2025 09:08:00 +0200
Message-ID: <20250926070806.292065-43-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cedba1-c950-4a91-aa85-08ddfccba9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j1WS+l73+4bQY0Lp03TlWQVXuJmG7bzK5p2erS+hetZg8Ly8a5Q1CluCSk9w?=
 =?us-ascii?Q?4KkFE/jP9JjiuRrpS2lnzwNfxa2ZinE321qgt7z50IOuOr7LApqashNujbED?=
 =?us-ascii?Q?657BOUZuNI3qcIN2svvbZDARp20YB2/MhyECzzl7lHODIiM3UfHj4m2E8Cn3?=
 =?us-ascii?Q?WG1yYS3EDlQcd3TjGViY/S/XK6dbbJPbFFgBTSXadN8jqYald/H0V9zXg2hv?=
 =?us-ascii?Q?eHSCnzx48kEDbUxdjfDmSAjsbPLeWW/VXg6lKiJ/758ysk24PsvzUtwdkVWp?=
 =?us-ascii?Q?8oxnSQX+eb5IE7QTvfzb/CaRQOl56oD0G/Xjnk5oK3PDuONjFX6wRGVbHTTe?=
 =?us-ascii?Q?PTa7oyUSmKcJLo56gUSgJWWhbEfzxVU8UszCNkcbIrJnUENwxzxcPfusdE58?=
 =?us-ascii?Q?wLd9sixI98gASrQEMfy4x5DxHlpjzi9vmyvvchNo03ImVZXzNwHbHD7Y5Bc8?=
 =?us-ascii?Q?JWboTnFWDzRHhj68uvynI4JP1O9lg0Z3vd/TAM2+qDpnhPLbBDuEDJn39dVU?=
 =?us-ascii?Q?hecLahwiZmQmJ663AMMo/I1AEf/BUFW2Jc8G3/qtDqzXf6N4WW0JjLDRZjWz?=
 =?us-ascii?Q?fBjwbBTX+cAk64MO4pRDmQ+MRRthxUsEXsLergEuOU+lLYcd2Ojz8AfRSD7S?=
 =?us-ascii?Q?mHIIRGMayFuSm2hbutIHAknMHK0FbMBlqlt516swqoiM6TvwQTaLMlZvLN+Z?=
 =?us-ascii?Q?TP9GvjvV3JpQT3nJ3psaPQ2pOPsGEDuACw35z4+SY12UI3C9d+/HKDwDZLmr?=
 =?us-ascii?Q?e1lDeftIq8PY70rkr1lnUVASFagXnh3KpuX9Oh3PTa8EMP8aDCEIxD5eIN2y?=
 =?us-ascii?Q?80w0A+lb6Bk0OOfFUor7rjq95xGizdN1Dp5h2iLRLu0cpw347JQT9z+XHeB/?=
 =?us-ascii?Q?48Py+sAvPWUWwJ9Ioi6wCHtQ45RrGapu+dXpHZ1n85FhQE9bIjaiAFcersYU?=
 =?us-ascii?Q?69T348SfrXbUpbm9wmFJjN9+ebBEJlU1B1Kj0NMwtKzikPKI/Sv8ouWLdv98?=
 =?us-ascii?Q?YewizTGddcepaT4aN2N7y1hk8Hwe43OYSSUl0ioCHD2P7G0pbgsD4pZwRFcj?=
 =?us-ascii?Q?F/MXihZtGd51zzWcMYbKBI2hM3oZ4g78uMwwDviHCsn1RGGd1Vm9e496+Y7A?=
 =?us-ascii?Q?DM0oWxjom46gvAJurfCkbFF4SPixeKJiqVM9AK78439kOIz04cmfaACawnFn?=
 =?us-ascii?Q?IG0RFUfv631emZh/VuaOQOReeWad3nQsqKLu24khcnM3i7WgGXCJrx3XPcPi?=
 =?us-ascii?Q?rRCLP8slLYIJfjoy9h10r8DpT6s5X/1uG1Bm+zV2RPQyDNVf20r6MkdfiqOd?=
 =?us-ascii?Q?U5h2qpf8WUXWgR+k0TwR4JfgacLrJt6LYD0g/Uueb7a2kFASJRIRjIp1bN3s?=
 =?us-ascii?Q?ZZAG+MEYCFGbyrwWC0XhpkU2l+sYndmYEZ5eVll97wJfNH6p4vPT0qkWv7/4?=
 =?us-ascii?Q?ygkseSn99L+3Ic8tki0YnRrdpszwiOPG73mbLXxb9Z4aMlZG7vw1B89cXF3u?=
 =?us-ascii?Q?BpFKT5+M1Oo5wPzk2GNFY3DdZt6i8By1tbph?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:41.3714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cedba1-c950-4a91-aa85-08ddfccba9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 74 +++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 6ef56103a75..f9abb9ed639 100644
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
2.51.0


