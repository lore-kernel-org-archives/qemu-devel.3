Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B41CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXA-0000BX-T7; Fri, 22 Aug 2025 11:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWO-00080a-Qw; Fri, 22 Aug 2025 11:17:41 -0400
Received: from mail-bn8nam04on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2408::61d]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW8-0007Cf-1T; Fri, 22 Aug 2025 11:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmSTM6Xezz2Q03ZljZ9RvcsOZnze1ZZoL1dvT4ezh9GietoSJO+e+R7tPy6I5RIxZBy/i9oxse+0oKRole+7kPYEL84yzR2rXbNntONL1ENrE9ut9Dr+p1/mRThK/nL8J+QZj9PzE9RJmOS0LOFoIV5nB8rVn8f3jOxZjbGC8JJDTfzwUiHbHkEQVO07lOSpWdJWV2kcFKAfSnya7HIcg44GTJhCDvPXiYMmvThuDVjiyH5W3GaDM2nzndInJAoRNmCLkVoJ7TFgMb0VKWXOnSNO8lGEUQC4H5uwkhRXqo0X2AkJPrgRZTdbY6D2gZOe/kfaX7jQdQ+LZQ9rlxYcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0emQF6DtgD64I9/rZAkprB5IyxDL12HqfcRAyGCR89M=;
 b=ailvzpHNo9FNUy5fzhzbr6VHLsm0tvYyBbittOwKXg9dI3DR3K9efHWLcvmrRMNkYsyAGEziJ14H4ptMYkR/xwQ5kOwH61iRlouehNYcvgNsD2hKjTXN75qNR4g0mDGLMIHrcSX7gzpdKnKxWKWd06qOVfUR6iuPZ89Gde20EQUmetdtusgng29SMvSUE5BVAaMugHKAO/CR75N3w9ndNeVYptosO4557vDNdYMX6lHb2kXchmiXFI65LojwFDaBLvlB1wLYVW8X4fWIKdooFtYmDPEGuMPTBdRtYzMHrnzxfQ6PNSvEqvHGHKUVMy78xKiWEbuwo19+b9PIjwxgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0emQF6DtgD64I9/rZAkprB5IyxDL12HqfcRAyGCR89M=;
 b=hprvF9c6GTSWCSWGsgk1EtL2oyx8MsTGTKBAXi0DsirxN25exiQCyAIwaim27AvK1pd9FBfP0AFB91bbcpTDvgbDO6v4jCAfZf93nsu3bARGEMa4Aq/jqANvzXBLjPLasZgr7dDFqBsVJOlHaEjAYmd5bnQiVIT570x0DhwOAQE=
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:17:14 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::64) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:06 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:04 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 21/47] hw/arm/xlnx-versal: add the mp_affinity property to
 the CPU mapping
Date: Fri, 22 Aug 2025 17:15:46 +0200
Message-ID: <20250822151614.187856-22-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: a44e2bf5-9639-4aea-c4d4-08dde18ef994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MgghOIaB4D6AeMv2EV6PmVKGwxNETmttWqMaZKFEKy8cPNBlR9ZTovDvezp1?=
 =?us-ascii?Q?482OIqd+/BsHOm4CY+bn6lN1jHhJGJgZEfYtQIO0Z8xlQLZBRQmjoD4mriV/?=
 =?us-ascii?Q?XXBctAMyitUuVyf0W1DBsfegh+dzMVGeaJNKiI2l6IESsG+9SOMw012mOTEk?=
 =?us-ascii?Q?K3qcxHfJKvd1CLmfryQERVDVS/lh0WGe27Pmev5uSv2DTSun4Prn1O/drRxy?=
 =?us-ascii?Q?cifh55woSVuiy1SWn39JlVmJ169r9zfH4szgFFKGIUZd2dorG9E/CcLxyVcw?=
 =?us-ascii?Q?22cKLbjxjqeQwb4kedGIWwpSTNy3CIA8pIoKCLJ3ufKo9m23wusbN2hevabJ?=
 =?us-ascii?Q?h0oMejLIuFwF5T38nNdGX1bDbairrzgYU6rx0AAJtsM7PMB4MxNIXbH6bnIF?=
 =?us-ascii?Q?CVP8PcUW99I9VIxaoKfgdScpC3n5DMDt/kW28mU11yzHdm5mQ37WRRtWRHcH?=
 =?us-ascii?Q?h6s34yKUd93fVAzUZSBWtFCYpSMX5VTqp7kXiqtRS9ZeIGvXAg6wSAi+ucnU?=
 =?us-ascii?Q?pItZ1Eft5+szc2lu6zBldKblPZB402IF8wmbAKvP5HrrVrswIl0jp9f2CGqa?=
 =?us-ascii?Q?eIrsf0lmARESsjike0KZyC/uuAYaTssKICCTn1g4q3ajzcQDDsrKdO67vyzv?=
 =?us-ascii?Q?ayTuEngPn4VX0xIg0CJ7akajBsd4s1E7sx+/aZ9xFd5OOr6x5Izqegd5voUO?=
 =?us-ascii?Q?XSdXdtVknbWXcdMb2Wz3PhvSUCO2lU1t004svDKzdCOfoGpluIYQm3U9XWFx?=
 =?us-ascii?Q?uh8V4vDpxLxpttx3Vmfwqmp6H9wDtg5iZRbAazGhej1YyFFjrplrmIOFRo7B?=
 =?us-ascii?Q?xi+3KYxzbx+jU8aN/EG91FqlZ4oYMZmH6vDRh9opojrryqqwwkWOpzvLTA9N?=
 =?us-ascii?Q?EcEX4LDd6fxrM8ZxEyPB5O9yZHhEONUAsH+IqbSw+1lStVIdTcL2lEXue0ka?=
 =?us-ascii?Q?UASaJwF/GTe9IAwmDaM41aVTDy/LSYTf9Bh+zoZMMhELTzM/GUxb6Qw4d0Mm?=
 =?us-ascii?Q?vjlOS92r99LsWvafvdZU+z0nHokbmR9v8a1jSJS0hokkuVro+HcKfVZeW1CO?=
 =?us-ascii?Q?gCEgkVDbs8ZgGmQyeUUWIyQN6M4byXSjtjVQSgZYVAvpZ2p2vfZkPqpDTOGw?=
 =?us-ascii?Q?bYrzzeXjDHCyDoK/mGnCtXN23KqEqUqvGt4mgaS8NJqiKlaw5vBe28gLYecG?=
 =?us-ascii?Q?Vyt9iHMEJgnen8/ZrHIugE8ZXnEcWZTgLabYLWfEYRoU+MUUlxNBjVP3qQZw?=
 =?us-ascii?Q?M3VwMyHfU1jKGpSsTnvld4J3/PhzBtv4t2n6KYE+GrO2FB0kMwP9wIABPJzX?=
 =?us-ascii?Q?qy2QjzW1p/Bd9Y/qwTgDwIKMF5xmhg6pqf0/dqjgPJtQgtLLmlw4IM6rRJ6j?=
 =?us-ascii?Q?OFgq8zG0GPRtHecND2VNcLIWZU4NXH1njUBptrFaVqoeNLVtpsbmee5Qnrvw?=
 =?us-ascii?Q?L952l0HJPsdj3jojZcdf40n1/IzKgBclexNhDqmbVWLwmIAOQXByBrLg741J?=
 =?us-ascii?Q?E+nxai7S7YSciemzNMaDs0eX54AU04CGo9cB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:14.4006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44e2bf5-9639-4aea-c4d4-08dde18ef994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
Received-SPF: permerror client-ip=2a01:111:f403:2408::61d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Add a way to configure the MP affinity value of the CPUs given their
core and cluster IDs. For the Versal APU CPUs, the MP affinity value is
given by the core ID in Aff0.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 78db27f3574..b87ffa56313 100644
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


