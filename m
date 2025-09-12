Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F51DCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eY-0001qZ-AF; Fri, 12 Sep 2025 06:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d3-0007X4-QJ; Fri, 12 Sep 2025 06:03:50 -0400
Received: from mail-bn8nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2414::606]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cn-0001Op-PV; Fri, 12 Sep 2025 06:03:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmQEb1FbsUAn1+rqZFRfVocDeh+HckMVjkVFlONVWuWhNbmE00qv/iV+XS8edFUu7XFreiiXQeYT/ZIevjLVGxNYMJ7AxnITIaAoTvbWImlBrlqEa5H65gOVwVBTwlTKf9wWFAZphmBQy91SfMV5bvhuy1vjpyARrQ5IKOe1tqNnGipreCb2An+1P35JKUU1vucPfsia0OejgEbwZ52yABSBs0mwarJHsLGSpOUVDgl2k+OUlnjd81DG9BzWHjG9qoaj6OIyk08WuBbPOp15JyqH8WAz4NMndm6wmCQyDgHsuVq0LAGDh4XKM7PrmnQvHN/bq/5dJT/8fgc8iIiJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8OMNhGInTKENhLDzvtiBamsHFw5alW8aMmoK/MoXxI=;
 b=i3Gxurplkihagp8W+fSOdNZWIPEpvHNyMHHtrSlDUnOAHZoymq1zUBvkXECwCZzq1VWLLN6aqqTGaquC3Tj/dIcZ+LJSGeKE8sn+pfOUu0wUl+xABHRSicA1vMKI9j/TjwM4JOsPeGPOn6R/MRyHbPsfgW3iD0f+4esA3ECbqmRaJMlvZpcQc/+SYR+M46W6gPBxXvG8QriAVwJ5TxJHIH+/srJA+AVg9xsAiIRAYntHnBVI+JGYXIA9JopTHeNhxGw/Z5DqHh/92DQbhfgbwmLWXMQ3rEo5dL0YAmAjx7HVXjDX1HQ+9GRuqSCCy9NTRDerXsoXpfSWZxk+Rj0E3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8OMNhGInTKENhLDzvtiBamsHFw5alW8aMmoK/MoXxI=;
 b=GNP9Gawsbe3VzMBRs5BXxpFQDoNIa+wehBEF8Vvwt5Ir6WF2y40R5nUa8WwvTo1aLhcjQBt1IW92vb5SQIVRzw8EpxeAKslYQrzK5tZV5aSOewadbD6MWhSV1B/iU2VNEr2H0/tioJ6gxqk90Id6z/QZ2QjpChSkP2pVDLrwQlU=
Received: from CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::28)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:18 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::ea) by CH0P220CA0030.outlook.office365.com
 (2603:10b6:610:ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:36 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:36 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:34 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 42/47] hw/arm/xlnx-versal-virt: split into base/concrete
 classes
Date: Fri, 12 Sep 2025 12:00:51 +0200
Message-ID: <20250912100059.103997-43-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d31082-b6c5-496f-9a3a-08ddf1e398c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uyjTio37pg6ddgflkZXYx63qXEfx/sWU3NJw/Yg3X9r+QdlXZzC+Yy9PV2Z5?=
 =?us-ascii?Q?dkzIv6Eullvt26S9Mye8huyu/lwF8hwf1+3gwntzPDfszTLzajDk92ArRgfn?=
 =?us-ascii?Q?HryZPVs9ggBM31tBM66qgSIwV9AS9R/ydbJhGB0RUzIXAhDKhBeKO+pj0tzg?=
 =?us-ascii?Q?pOFLh+naAFCFD3eF7AfwSXbf3VXl6epLRI9dwMCeMe5krwiTGj/iOkotSI8R?=
 =?us-ascii?Q?ubBIRNACleSApa/5Agw7FsImd1kPTCZ9/sBvZM7Bn3Lh/BsWgoJYfUX+w0og?=
 =?us-ascii?Q?7WBT8WomHDmONGdyA5x8WTOUhImvZs7pRJ0Q0TpxusNIRpnfCnUzOxYDvqyc?=
 =?us-ascii?Q?eQVQZPAZHkw4+S0FZpOv6yfU2UYKK1EMdfw18Y+JVLAv4/XDOKMFQwUC/ajI?=
 =?us-ascii?Q?t9rpTc9FchIubiNUFzNSY0wn9cnOQUfYQDVT/rp+5mLlvPXH5xmtWNjvz2yT?=
 =?us-ascii?Q?BkaQ+0tuxFkzpF9IRL1HuAG6jSMLGiBZfAdhLjFEWCBSCzViAr4o+9gsG1Mg?=
 =?us-ascii?Q?oVhlQc3DV3s+HbKihCYyyKg8U92K0afc1yqCCBpfwzA04FErjAZJNkHLwIeN?=
 =?us-ascii?Q?eSaj3Ge0qBLSWpov8J6FekduyIpvlp8d7B4OtyYUjZg3ju5o0aEnt7q/avPZ?=
 =?us-ascii?Q?0r5SusYj54ZVoXRNNCxct3gPS7h+UwqSpD0bdBaKYIrtAjsXkOJvn+1Jm72Z?=
 =?us-ascii?Q?5k0CEQNsjKpXUjFro8Vg1ih7D28aaSsZ/yXx9qrOML2k1ZkAyZ3mcmcToddf?=
 =?us-ascii?Q?ZN0Ehx7I9Az/0fFeeAVTbVWUubwxxRcr2K4EMmki6bsUq0LN6b97NF9rv/2H?=
 =?us-ascii?Q?qjq/lnV3dlk+h7XkUSgpSxWNUFY+Nh+hQlR0bJ66LHmhZJK2SiaDywJ2usia?=
 =?us-ascii?Q?0R3U3AbGWMuxdbWwmCrc07SVu0hCpwGET0krN3NSNf6ymFPZL5rvYcUVrIlX?=
 =?us-ascii?Q?Lc9BdslTnykk232bdr2iFiE6VU72cM1e5uA3/gTzXTTdFyeHXnSQsaed2bQX?=
 =?us-ascii?Q?GEaR2UvSapA936j4bFkmvRRutDsc1/1tvyHsozqVsiWabxutXMdQzmb20ppE?=
 =?us-ascii?Q?PeiOH2vozewnJ97/C4HShgfiyPUShEJ2wRHHh/utxyXq8wEz8N9XT8O5s7Gl?=
 =?us-ascii?Q?OdYT/QcXrAlG95pJQPgWZ3jezXTNj3Z5PSSaHdZdqkoWJJz9H4eoBrGoMuFP?=
 =?us-ascii?Q?QwXv33lKUpPUBhDKCMa5EkFpl21GR04Lq0BZ+0nY2PHbrAaxqqg+BkJ6W0+O?=
 =?us-ascii?Q?3xrjMa4+AipX91aO2Zm7AKC8T7/xe7eeWH9GuC3UV788B7CxeL2Btadfsva5?=
 =?us-ascii?Q?CNHahMEG4n3LmbvDK4ipu7El3Dq69YiLWm2m83kNNYnGLeMfl3cX4Txd3LjM?=
 =?us-ascii?Q?b+ujY5tVSM/B1UkwWzcurFL0/FIVEuMhVXZMdTbx+eNQIJ4GvPr2Y3SH51MV?=
 =?us-ascii?Q?tE86gwAcC+BDIurE+ZqPn+IcvxeoM5P91T6ChnJVqXtWvGC/ypKsSKainzeK?=
 =?us-ascii?Q?WUPae1ZW2dXYFRj5go2oWBORdiw9PcJlI6p3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:17.8895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d31082-b6c5-496f-9a3a-08ddf1e398c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
Received-SPF: permerror client-ip=2a01:111:f403:2414::606;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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


