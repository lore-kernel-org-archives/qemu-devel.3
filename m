Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D7CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXo-0001qB-JB; Fri, 22 Aug 2025 11:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTXN-00015q-0F; Fri, 22 Aug 2025 11:18:41 -0400
Received: from mail-dm3nam02on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2405::627]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWs-0007HF-C0; Fri, 22 Aug 2025 11:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfjHg9roZDwYFEiN4j2jHakGaldmiAr47bMy13RuLpZvAzPc2rsuKgOVwopH/BivvKsRE3vSlRTRGrGntOcRKKAX8Eo2thrr3qCaE19rU3FEAixmEKsEbcfsiDwRh4A9xBGoHeHbOa4n1KT0BIhAp5nsoYrkuxUmebKeyjjBJ5DMgDDgDoh+59oDAaziNqQxsmVcYeWfOxAGPqvR/lIAiZFvxDh2av6FTmRydgCZS+EkV/IXxtYSAzP0mCnyz8WC2CdAvXOEPwsUzXYzW18U2jtNhBOLEhTO/xdvRWlY4MFabU+lwpd3epeRDMEK65473eP4Yy8ZkJsX5Je+RYkX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8OMNhGInTKENhLDzvtiBamsHFw5alW8aMmoK/MoXxI=;
 b=RHtqs+ArkdKaK+lF383ANrfxzGQkM/YYH01VkmPkUTfWAC7dVS9U5ztrvHIvx9HL+G/mW78RWbDFXJmpi57FAla2nO21ugLbzhZECu8LwE0Zi5a50/STFhBN+vvbb8yf+8hr1ShfxNkk9t8wmF5XWdrC1KWRNiZVy8nU6npRIhJk3W3GFyWmQ6HrfITE26PPceHpZloCgqbrXVXzmnCEK1Qsl+RgGKoF8WcEwBTP+Xf12GtextlhNnc4olKSsbfBrmkZ3GC5Pj2EX7NAvcgp0xce7K5nOJoCSvsAQ0KnNC1TVynHR6jvD/Pl4T5F3HummKlj6315Da+V4uw1sheV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8OMNhGInTKENhLDzvtiBamsHFw5alW8aMmoK/MoXxI=;
 b=XR3CZhSoSv/9S7fYDPPa5EdyqTCpbScmsgodBGe0tEL1hKI3W4Je4KwJkZk/Nd15XlTMd1iF3fcGnOyEAnSH86KoQrk8DfSTtbTvIFZVw4cw5EhLCISe1OovRcmDwoNbuQmaSPHSqzsCPh9WI+xY98lm+yBst4Xw8fNK4QAvS5M=
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 15:17:50 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::69) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.6 via Frontend Transport; Fri,
 22 Aug 2025 15:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:49 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:48 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 42/47] hw/arm/xlnx-versal-virt: split into base/concrete
 classes
Date: Fri, 22 Aug 2025 17:16:07 +0200
Message-ID: <20250822151614.187856-43-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: dd335152-d6d4-4060-64c0-08dde18f0f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pSIVJvcgVk/TQlUYEAnL8zGDfTp5//bB+GJBNxR+YwetJp5bEuJxJ3Yrg+J1?=
 =?us-ascii?Q?2bOSph3aLFoYjkgas+ZzPrwVzldaF1Kd6VmT38f65LYhUp57pklGHerBQo+y?=
 =?us-ascii?Q?+CK8bP1yZ8sJ32+3lbshzL2BDa9lef65SpquZ60idx9QcMIvXx3mt73ZhvtL?=
 =?us-ascii?Q?OgE/Bmer2Q0K9/RHZ5QGR+nwF2u+epvqxtR/KusxE7F/dCl8AEZheWs8fkCk?=
 =?us-ascii?Q?s5y5TQuW4igCaXQpNS56jQZ3SPjQKVV0LgIDGdt4MZ0M0Wwim6QS7WBy8jx0?=
 =?us-ascii?Q?1BhRggjdxmJyBNG2p0RKaGIuRJUfdd7fTabEy0NSXDssXR3XPyhTWzIjbSVd?=
 =?us-ascii?Q?tdgRFAUE4UEOVARntgqbEb8BfzzuEXrYwn0MY3qM3TlblWhhTCmzoidX2acy?=
 =?us-ascii?Q?FcKg2imYcFYyuPNaJtY1I95gG+CcrUrHA3Tdn+ZbKlkUt94IFKf2ZK3aRQzM?=
 =?us-ascii?Q?LNfV9SXPQ7hwiMICk9eBwhQa6cO6ZFvcz7iQwJYCkZ7EldQQKHHRL6cMkjlE?=
 =?us-ascii?Q?wt5rGibJDVakM2GGEjqyBoABMC1aisxP6Ee5LDzRjNxydfqxABmbIVejYm6A?=
 =?us-ascii?Q?I9x1+C5hsFavx1OUHQ4Lmfys9Mltj4+NEyUy4V9J+DHv5jdXOJRd69gy+0+e?=
 =?us-ascii?Q?c4eSjEPBQoJR9XW2nyjXj91YJ76YEZ9nwG2a1RtizlzHUaxgSLy1oT4B0w7X?=
 =?us-ascii?Q?zvDRq236VvOHFUF5H/v3nTSDpwGTq6JqFNtIFPg4cNR0SKhpjEQN7Egp8n/r?=
 =?us-ascii?Q?NsAwMNwGMAhWj481Cky9YwmIEVI/yxyfusE2Of/NaJ6DBzXkZkqmwPYAQlWD?=
 =?us-ascii?Q?2q4a7j43LfIrksfIq+P3Anliy6L/hh1d28JvcT5brMIyeWqZ1Kpy7nyZFuHi?=
 =?us-ascii?Q?D407LwseBpl2MZqr+mkyHFiD+3I4vjwNvs9kgCzNRnVTMUhGS99nFNrJpDDr?=
 =?us-ascii?Q?iKGAuW4lcnocgYcbqPXWDoZkqq+wdqhmo117sjexIYUBPYikuZd+IcLyXpLo?=
 =?us-ascii?Q?9+5VG7ndlQhFC2oLa+VCd7lZwktKbjiIyV3JKFqgtKZDwOcs4pYC6Q15Tfk7?=
 =?us-ascii?Q?T+HMCCZP5Buv6/rTFZoYxEdTJd7PCTbwQiCCm9we8tmHmjTOU5GxzIYXovzO?=
 =?us-ascii?Q?JyqoCrBjukGHGNu6X5/WPIfh7sQJ2KteNZaxIALvdr3YqOI7hL0vLM6BRb4H?=
 =?us-ascii?Q?V2o0PNX60Q9Ir9pf9x5XhfbNDpgQuby1dZcuYyXY3Kd+Kzi1zSqBXfYAtjeK?=
 =?us-ascii?Q?SuGcbzWunl3XPNoWY8I9zqM+9g8jZzIWieDX11demvjmi57AAQpi6y3QEM18?=
 =?us-ascii?Q?s3bFvVWMiVX0nxHlCXsTKv93xV8sup6t7mzuG7/iadHlP6kH753cXCjwQNNF?=
 =?us-ascii?Q?dbczOJLqSiBdQlfcblV2uSPW+SCXiSpgeelPWPVi8LA8P8CctJABBF/IhZS/?=
 =?us-ascii?Q?i8s9SxPVr/F/CWfFm5HsrauJv9kx6eCZTqOcMUDbmnF76u8nzTblnEilwQw5?=
 =?us-ascii?Q?QYAmNgj8YHMtoTC/VqfzvNVKlXEVRS7PcoWT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:50.3441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd335152-d6d4-4060-64c0-08dde18f0f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
Received-SPF: permerror client-ip=2a01:111:f403:2405::627;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
2.50.1


