Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C95CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMFz-0001VV-Ob; Tue, 20 Feb 2024 04:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rcMFx-0001Uo-R3; Tue, 20 Feb 2024 04:17:41 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rcMFv-0004M0-Qw; Tue, 20 Feb 2024 04:17:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc7UD9uJBfufNftCmwnZM84t2g1MTjnyQCBZjU9eqrkvR6dIKVVL43zaFjnBC+ucM/ehdhBBxyV6MwgoXp2n7p5M0buMCtf3cdBbBI4oh0lhjVu4ebV/3GcRtqQ6bfX5siOazzIDuVrnO5Q9rfV+o3PllE3iJsglYunjQZzlcO331uIVgbohw3yosZQkSBnGDeo2M4/EJbI57XXZe+s2ZXCdtN2tqnFllxl0pF3Bbv5JqpoipDSknNmg0zuv6mHAkzfjzFijsyk/v/QhgyCOknxaNYR5KNah4YDd16LhXDnU/2o1HarCFCEzeZ1xix29axGIWk6cRsS0QpFknnG9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vJKcaJkKs4tEOhv8zStBTduiifpunVPf6JP9nL+yhs=;
 b=Y06lYu32aiQKK3n23/kUyta1SwJLAuXq0FaCXEMweCMTr1/PvSCQnuNVTuKChOrf4KFwWKLUHpIbQmD/ABhcOt9lL3tYLLyzHaBRXZWG2geOz8K2aQsNI+aKAR6CwaSOyNc3nGSaE3jTvuyELnKvcbLFdvYoWbUmV09cL/cUEr3m1nl37q2eujgw40yAyQKxUpEAHOc7kouYeV9hZrCAK2cFWw/CgfI8NLAuCKklCwu1ijKUk/R9RKMpblxyIPK8nJ2e0kcK1umjXuLA2iD2OGOnnsgD9A10CiOdJgcdTyI9anfw2TefXpQKCN9meCz4EE1XQyBNZTOdqacRlyX0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vJKcaJkKs4tEOhv8zStBTduiifpunVPf6JP9nL+yhs=;
 b=yOZOzpRSugRsQF+hSnu0SN714KzsdXNfj40p7xbF6HFxk4F2GN3hGV4ERMICudyu8cpZdl+FgnIp0yqtWMz0WeI9vV6QTCk/1QRdcmkJLPYd9PFpK9ettm7/fuSZeIls2Pg5DxA31Zhcq1WaQi8WmL1vyqhvM9YEOTfkJ34ckrw=
Received: from DM6PR02CA0045.namprd02.prod.outlook.com (2603:10b6:5:177::22)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 09:17:35 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::6) by DM6PR02CA0045.outlook.office365.com
 (2603:10b6:5:177::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 09:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 09:17:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 03:17:34 -0600
Received: from xhdvaralaxm41-docker.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 20 Feb 2024 03:17:31 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias
 <frasse.iglesias@gmail.com>, <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 2/2] arm: xlnx-versal-virt: Add machine property ospi-flash
Date: Tue, 20 Feb 2024 09:17:21 +0000
Message-ID: <20240220091721.82954-3-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220091721.82954-1-sai.pavan.boddu@amd.com>
References: <20240220091721.82954-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fc1f09-322b-4d0e-5146-08dc31f4c67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oSNFgeqUX6rYy9SQGlBceQXjCsM6hsBuPccVDxgZwzziyZEI2qupUCrwvktN4a9W6P9IrnQFWkYmsKy0XHnMKAq+OO024WNTmihWLSdYMfjTE/ADc9i6AsKlK2Fh0pTT6QNpFReS2JJARLNbSFUVsS1oppfdeUDIXiqGwLOIj6fbiw6gjWcCUlRO5iuQriTBtU+neTp6hUPNYp0YhCs99a5MhxdA5kDcnlA2J8k+BdLI7VidrYPx7hHJwUBKx4CL0J8D2eAn5Ioviitr8oxwE/LBqQRDztLsakx2QFk36ltjvzWPAs9hWy8BL6MG/HWiHE1oju3B9KGExZ4s37TNWnjlXH6ZM5/10NwT0cHhG1b1/bpwlGaM2y9jyvi70r1Wm8UyZjD+C/011D2+2h8Zcomnu3wLOCkq4Oud8+sntuNjCPOEHB115CG7Myw+MT5sy9GBTiI0JxOaYe8d2iAthkGDArZFptxrgDz6iRXxj0Xjf5ryroRHer38Rf93q4pt69D1aCfH7BA34/JoOG36RqX2xIq0miGQw1kiGnkNraCfzV4YdPVP9BErFyjZ+psTMLHvOfr/t05T8lM0Gxf2nInQuLkc8T6hSkbzDXjcEP1EWaVKQk3vXrcJG5gqsbZ3HUniaMG3iSIzYZiFVj81WIBsTtT+B7KTBvmpQZvNNU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:17:35.0582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fc1f09-322b-4d0e-5146-08dc31f4c67b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

This property allows users to change flash model on command line as
below.

   ex: "-M xlnx-versal-virt,ospi-flash=mt35xu02gbba"

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 94942c55df..bfaed1aebf 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -49,6 +49,7 @@ struct VersalVirt {
     struct {
         bool secure;
     } cfg;
+    char *ospi_model;
 };
 
 static void fdt_create(VersalVirt *s)
@@ -638,6 +639,22 @@ static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
                            &error_fatal);
 }
 
+static char *versal_get_ospi_model(Object *obj, Error **errp)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    return g_strdup(s->ospi_model);
+}
+
+static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    g_free(s->ospi_model);
+    s->ospi_model = g_strdup(value);
+}
+
+
 static void versal_virt_init(MachineState *machine)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
@@ -732,12 +749,25 @@ static void versal_virt_init(MachineState *machine)
     for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
         BusState *spi_bus;
         DeviceState *flash_dev;
+        ObjectClass *flash_klass;
         qemu_irq cs_line;
         DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
 
         spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
 
-        flash_dev = qdev_new("mt35xu01g");
+        if (s->ospi_model) {
+            flash_klass = object_class_by_name(s->ospi_model);
+            if (!flash_klass ||
+                object_class_is_abstract(flash_klass) ||
+                !object_class_dynamic_cast(flash_klass, "m25p80-generic")) {
+                error_setg(&error_fatal, "'%s' is either abstract or"
+                       " not a subtype of m25p80", s->ospi_model);
+                return;
+            }
+        }
+
+        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
+
         if (dinfo) {
             qdev_prop_set_drive_err(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
@@ -770,6 +800,13 @@ static void versal_virt_machine_instance_init(Object *obj)
                              0);
 }
 
+static void versal_virt_machine_finalize(Object *obj)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    g_free(s->ospi_model);
+}
+
 static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -781,6 +818,10 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
     mc->default_ram_id = "ddr";
+    object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
+                                   versal_set_ospi_model);
+    object_class_property_set_description(oc, "ospi-flash",
+                                          "Change the OSPI Flash model");
 }
 
 static const TypeInfo versal_virt_machine_init_typeinfo = {
@@ -789,6 +830,7 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .class_init = versal_virt_machine_class_init,
     .instance_init = versal_virt_machine_instance_init,
     .instance_size = sizeof(VersalVirt),
+    .instance_finalize = versal_virt_machine_finalize,
 };
 
 static void versal_virt_machine_init_register_types(void)
-- 
2.25.1


