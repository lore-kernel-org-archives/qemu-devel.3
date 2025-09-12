Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E07CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0dV-0007tN-KR; Fri, 12 Sep 2025 06:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cb-0006UJ-Bx; Fri, 12 Sep 2025 06:03:13 -0400
Received: from mail-bn7nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2009::624]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cQ-0001JS-QR; Fri, 12 Sep 2025 06:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPfulumnXgf1dhsg/OUP2BAlxuYdgoChLi8JC5M6NNKT5RsUdlstHdrj55Z8y0imPuDYL9zepINl9/joR6y5E6v3kMqb7w2KrjrGni5lTZE5LfKUI2r26i3zYGrTDS9xMk8apwBVWFiyeHdqe4+p1cihjub3a21jLKfAmdk4jxqKfxNDLNYcAk3Gg8Q/rqQBazefO9jQIJNE74pI0RmvsOfNSWEpBHt0NZoiZvFp171HrzwV/MHv9v4j5JaydLfxrIIOHELPndx19ZGLGCcbY5Lwwfw9Z31wZVmQd85bahtHqaFLb0U3Z3/rd0qJSouVq65wm28Ss1hbtWVUI2rcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPOcHkjD7eHofjf4RdSl3J7zMguZ0bXdxdI4fSZeZNE=;
 b=pdx7Gw9aRVoRfF9a34jjOwzVJ4mnEIotb/1cWh0wVdD4E1Dg+QlYPMS92dMJ7wHbI7SRlR090dXCYGBmKOtHEB+ZBqJXa+TOl03mZvF1I1YTzoJ82ROtEuY4SH4tKHT4A0SUEQEn99shh2SteSt3RfJK2yADJW9DtMfjXJQEw/Jyzn4vC1hIS38wqpx6cqDxH2WvSpCGAu4oD2X4JsScwBSfJ+sPMxzQwXJTi27nkFq+7RWoQX2JvurQpgpfRINPSL2zuY8/4VurUlLUVrCLY263vPRB1kGCjaTT17os7gOzejlpGwPNVmbn56nLnbwOFICdxv2nABwitdyC0wnQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPOcHkjD7eHofjf4RdSl3J7zMguZ0bXdxdI4fSZeZNE=;
 b=fE9cNqWkPRKFv/q6K7fPzIK5K7D6YJrWFCi5ApcONTkzE24ND63ItPQctHm5IyM9hKR4wt60Beqdfg9VqPKG3XNWcpTo5/OY9TF0/9MwU+2h7b0OpPw92ArbQyburyz840h7FfwrqWw/866eUEvMAzvOWE9ITZ4yErlieOlLen8=
Received: from DM6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:5:177::24)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:54 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::7f) by DM6PR02CA0047.outlook.office365.com
 (2603:10b6:5:177::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 10:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:59 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:59 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:57 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 21/47] hw/arm/xlnx-versal: add the mp_affinity property to
 the CPU mapping
Date: Fri, 12 Sep 2025 12:00:30 +0200
Message-ID: <20250912100059.103997-22-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d8ffdf-e2e4-457f-f841-08ddf1e38ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ClBO6Y9vSB7TUTTnnK/G0AhISIqM8WOUg0K8JO66brcnXw7NrXhgKQKgQv6d?=
 =?us-ascii?Q?/ig8w4JqzoME4I/N18fHO1iwI2T2QuAExqdJLTbIpw1PENipsh36rAYJcwTf?=
 =?us-ascii?Q?J3wSD26KSh3A/3EqyTdYad+a+hjGLtBYY5TWFkInJgYPLuFIAtC4Oz6RncsW?=
 =?us-ascii?Q?Unpb6qXWIqv+LChJXS2sKAjfK8cgOhz8Cws1aZAUeL92eCiy6TcI1Z/2N5ri?=
 =?us-ascii?Q?hdbcPUIVP/8AlRTjBtY+S2rsGibf0UZSC32UGdb2dVjixAFgLQbWg9Q5838o?=
 =?us-ascii?Q?Q2wkXN9P+pXWA1FFfnFBhyUz19FO1b/rlL32U6nbEEvEi6ZjqAQ+XJ7ahcGV?=
 =?us-ascii?Q?IfHTtv7Lyr7ewxQuKEW3vQtUN51msRu4OKqgDKUiWp+njXzW0WGmFmEmwEPj?=
 =?us-ascii?Q?kNCS5Za4PpHaY4BQ3F+dlSd6AyBUy60o/PNqW2MuyjatCZVNIIHDgO7e+cdz?=
 =?us-ascii?Q?FFaWaenm79j34fuOPF84gQRzchqEypEu00VRcwgID0I8BC5HWzfuqaDmbv4a?=
 =?us-ascii?Q?KSj74nqG1u2llUyyThvnk5EXDQGTex5LMcJBAgNsDJ+OZeXOXFBiD9/N7IJM?=
 =?us-ascii?Q?HPMqOhsVgrc8McaX4yCaHduQ5+Ns6wj5O8z29Je5qou5xNwtoxygWB1DZr9z?=
 =?us-ascii?Q?GBZHAPKoqhsndIPesuabBf87qN5QkEvUea+8duebbQMiW4kQPahiUpX5sL9Y?=
 =?us-ascii?Q?y7lvw4bYe5r4fmcuytXmsZ2hSaFmIk9RcB43weMcPmxWqRBpTiAx/ZnLfnaB?=
 =?us-ascii?Q?/6hKpv94mQY5CJOnEsiBN/Y7S+yavDb/shnruAcJUGGWElIcdyt71q9IKK2m?=
 =?us-ascii?Q?Oi2h6KUGkfQqgLt1RW6iPgKK3BCP1h2Ha6YCOjEZ04sicB06ChlWbXTDi9Mb?=
 =?us-ascii?Q?W/j802jZRsQZXrdCHeQYoEiWed01n8D7FRF1ECzU6xOJ3HRQXnd1UOYcWykV?=
 =?us-ascii?Q?kFoYvefrQYC8P0JX1fST0byO2rNOBMU3oRDppBaiPQw/Y1ggExrKyT2pxyyT?=
 =?us-ascii?Q?5VFlRLjWxpHcXtdgpUlVG3g3XrE+KTmMS2WVUsCd0PH4rbOprpSMc5W9Sz5U?=
 =?us-ascii?Q?o68w0LVCnuq6veuJvAPINBwkmsUsUMpyH7Radw51RHboFQK5Jh7C+1rkA+4B?=
 =?us-ascii?Q?XosbI2onqRPcYYjUci/qO9GCdBizCaP5zSPFWobR65wmNAGpxr33oG+VOQa2?=
 =?us-ascii?Q?Sw8pxWbdq2uiCEHys9WzLla34s5T/D6q2AyuijSG1XjJ8m1nUWWX9l1Ty0J/?=
 =?us-ascii?Q?oJK8xusj6T2r50qXO/maXlWQIltgrXk0lOKKhPNINMY51ITD7Ij7r+Gu1RgT?=
 =?us-ascii?Q?VxP8jkoms6hp9yn7fv21tCrIcj45fCrveC5vZHT43MYvT1903T1UMLYAuUtX?=
 =?us-ascii?Q?780H5oiqfH7WSLWcVMGpN1/TMkAxyggAac28nG53/Kxhw5BztaTk5BF9mYCQ?=
 =?us-ascii?Q?+veXxlAO2bQh4/Inp8mShElvUZd3UU56izb4jKtb8+U/gDtEfGVuDPH8icd6?=
 =?us-ascii?Q?JzkaMbTB6pnCFBsBQmy28Dh9dVYZuYumqtwU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:54.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d8ffdf-e2e4-457f-f841-08ddf1e38ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
Received-SPF: permerror client-ip=2a01:111:f403:2009::624;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Add a way to configure the MP affinity value of the CPUs given their
core and cluster IDs. For the Versal APU CPUs, the MP affinity value is
given by the core ID in Aff0.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 56ec03a8b9a..f4b9f419728 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -88,10 +88,16 @@ typedef struct VersalCpuClusterMap {
     size_t num_core;
     size_t num_cluster;
     uint32_t qemu_cluster_id;
     bool dtb_expose;
 
+    struct {
+        uint64_t base;
+        uint64_t core_shift;
+        uint64_t cluster_shift;
+    } mp_affinity;
+
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
     VersalCpuClusterMap apu;
@@ -196,10 +202,14 @@ static const VersalMap VERSAL_MAP = {
         .name = "apu",
         .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
         .num_cluster = 1,
         .num_core = 2,
         .qemu_cluster_id = 0,
+        .mp_affinity = {
+            .core_shift = ARM_AFF0_SHIFT,
+            .cluster_shift = ARM_AFF1_SHIFT,
+        },
         .start_powered_off = SPO_SECONDARIES,
         .dtb_expose = true,
         .gic = {
             .version = 3,
             .dist = 0xf9000000,
@@ -565,23 +575,29 @@ static DeviceState *versal_create_cpu(Versal *s,
                                       size_t core_idx)
 {
     DeviceState *cpu = qdev_new(map->cpu_model);
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     Object *obj = OBJECT(cpu);
+    uint64_t affinity;
     bool start_off;
     size_t idx = cluster_idx * map->num_core + core_idx;
     g_autofree char *name;
     g_autofree char *node = NULL;
 
+    affinity = map->mp_affinity.base;
+    affinity |= (cluster_idx & 0xff) << map->mp_affinity.cluster_shift;
+    affinity |= (core_idx & 0xff) << map->mp_affinity.core_shift;
+
     start_off = map->start_powered_off == SPO_ALL
         || ((map->start_powered_off == SPO_SECONDARIES)
             && (cluster_idx || core_idx));
 
     name = g_strdup_printf("%s[*]", map->name);
     object_property_add_child(OBJECT(qemu_cluster), name, obj);
     object_property_set_bool(obj, "start-powered-off", start_off,
                              &error_abort);
+    qdev_prop_set_uint64(cpu, "mp-affinity", affinity);
     qdev_prop_set_int32(cpu, "core-count",  map->num_core);
     object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
     qdev_realize_and_unref(cpu, NULL, &error_fatal);
 
     if (!map->dtb_expose) {
-- 
2.50.1


