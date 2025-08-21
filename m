Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE8CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4z0-0001rc-OU; Thu, 21 Aug 2025 09:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yN-0001Xp-Ti; Thu, 21 Aug 2025 09:04:56 -0400
Received: from mail-dm6nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2413::618]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yK-0002xm-NO; Thu, 21 Aug 2025 09:04:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyTYrfFuxktdsCfrZpoLX1w7a7BR0qMyz2DoHVVyyv5AF7DqD7FM4MBiweDaHhxuqBfYOvXA5C9ifMtg5Riqjn/k8Asir26qn4rc4rf99zLoutJEj6v1Vd7mfM33G3UYFsir3YtqrpDAxRkHN6dxammC/ofEC1n3STuZTK35jIStxM9pCz/ANYHrcZqWLDGbqSChTxEQR1Xq7gooSMXRPvwc9Gyho2BJFbIkJi7G9DWJ/WyWbnLR1qebfVw+P/7GdQ63JNQdq55WmaIobz4wiGiGjVYzB+Yr16oYgVRYrQIsO3DqT9IybHyIBGim4VCI5jpC9vbFKEPQxuRXoD7HKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkknU6JLnDU13Vu6zCEWm9U2yCps3CjsYnKTsNbYBZY=;
 b=QQDZ/9mGbRQswSVl53WGoXkYnXx/a7K1SEFxPJqIxQhRcSuA5upUHar0Pk3dIRRJGMbyTrseJFcY3GLX+EIdg0gSg07zPNFME2AyIRSRnAcIzSJtIVqRExoNHnq4R+o9GD6HjronGoUu2Rpla0ATLNuyaFDQ1Tk0+h1m9ejf8n0QSN/B0lgU9lxVJqplly3PJNrWbhZvEWKxOjuYgssl7ASWTnDWn8U/Nc2qXtPFW1iMBz9BgMatHwERb7cgrI9cm0QiB0fzJqdvgEqvNy9Nl1d/bAJrhP54LE52jGhcYMhSAlJ6Crb2VZVnbDIk0pMknnbigMMxuI99pM0iis5mPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkknU6JLnDU13Vu6zCEWm9U2yCps3CjsYnKTsNbYBZY=;
 b=tMEdY1X9tIvi/ZGDxP/G9uaH96XJqCyooSvL+tK3Dvbu0pN/Sl6SwkojkHKQTORZblhAp+79Z3PjExAiP1hfnR9ZLQwWtOFBGqP7V/UrAluv0SdMSMO0tKUb49plLzdL9oebvZoM9gPv9IBK5xBQSSVqTcSogShwezTGygMpdcw=
Received: from PH7P220CA0100.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::14)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:44 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::41) by PH7P220CA0100.outlook.office365.com
 (2603:10b6:510:32d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:41 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:40 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 21/47] hw/arm/xlnx-versal: add the mp_affinity property to
 the CPU mapping
Date: Thu, 21 Aug 2025 15:03:20 +0200
Message-ID: <20250821130354.125971-22-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: ba810613-63aa-417d-d93c-08dde0b34c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9XEj/MfKN96CSdHM7/SLutwWip4cFuJsb2J5ntlh1ZbEkUocygImHYW1ztpT?=
 =?us-ascii?Q?zZBj7fkbhwe/dW9DxQv41p3FLZHBixmhIxfEzfTGC/Z9gjUc2Wc5+dPQGtBz?=
 =?us-ascii?Q?zdfDGmhdjCdxL7kPOg5bRXC4pXlrHicOrRnlgN1z7VCagZTi9k5xOxkZwhJO?=
 =?us-ascii?Q?UjSgTNmkadN2Y0/V0c6AQoCWVDmHJ4AVzmAtzfsWh744rBJ+GzcnaIBP7l/7?=
 =?us-ascii?Q?FLaSn0+Uqe+ZQSzhA2uuWuScI4Rq/lay/zSzvxsJZmeu9QRrM2FcIO4/XyDp?=
 =?us-ascii?Q?QHnaBRkkqfk84cq8hCvj6d/VaNphIOIlk+LwIaW0USsVXl+k3QnDnCv0uXcm?=
 =?us-ascii?Q?U0ZgUWlBPhWrqMYiwlCOUfTB5K04TQTRp3VeLbHE0ojY/5YjLDkxz5C+1Shw?=
 =?us-ascii?Q?T3aD29Xm3Hi8Kv5SgnYosxcRM8Qf8p3raLFiM3WzorlWs3XMv8X6xBWGPUIA?=
 =?us-ascii?Q?Mga/wJZwlDnymYYTc3gtNtEAxQkM9SM6l81c0zv+3wHbtqo5n4aHr3S4LdFj?=
 =?us-ascii?Q?qrxyd9ligwbvp7qH3WaoFIE024dNZaUkhamdLCoJ9j9JqwL66T/mDbjehY6f?=
 =?us-ascii?Q?UD3edTO8/WSzwE5YVfBZY9Eqq2YbHBWHev6wz3+N/ziNvXWWqM154WHl8Kmq?=
 =?us-ascii?Q?wXEF1SUCoWmLUKaGIRCJZkfUau5TZKBAiv+570q3OVX+Sx+UxHjkftoa59qZ?=
 =?us-ascii?Q?8jitW+a37AWQZLFxpTtz15zhs5+ADseSrKa4DeeuGdVYuv/dvdn689ml2mYX?=
 =?us-ascii?Q?wlZLhVyo4OdPjCI01fqjFglFuQbfGTjz+eO+qa6k044WBn+qQbQbvZpal3yG?=
 =?us-ascii?Q?lwd9uEjjZnJdxr4cobGr62HpaDRI4bNXhvriuOlBf+H7vwuTEJ+i2T65mAS2?=
 =?us-ascii?Q?rkYHzZslhsSIo4DG+YwKr+/VR1ia/zNG9RryB5yvzzeyxEnacwoMrp/K8h6C?=
 =?us-ascii?Q?2pHTgSEs0awrbviOnfBmpceXW4ITWNF0b2ulG14jb5s1fK0qtB6vFZgmJPnT?=
 =?us-ascii?Q?LiYVNWO2nCVa9jmwnokuqD1G7qXsWNEJpuAF5gLYKV1rHTatIg5HSltUjZgS?=
 =?us-ascii?Q?TwcuJnRcSqQ72eB1NTccWytaxk7VnO3egiLZ9av8U+kFoi+Z8PKR4GUQNMnF?=
 =?us-ascii?Q?FY7zooAn4xsg2Zq5JgJg2K66bG17S8M1VdzgIA0Sf49h/hrXPspaGRv4WdIN?=
 =?us-ascii?Q?vEEpO2lRanp0bb+MmBVk/DYUexBDikQlS19e90QunbT5OdflkXVETlbop9Bs?=
 =?us-ascii?Q?ZbcTrFvL4UjOgQg/VyjjPOeAIjdE7pbjMIxP5ycSzTW1udloe+ydYIGUfEFf?=
 =?us-ascii?Q?USKYdCRzpSd2HOhlnJiyKfYYsSDgUW/AoQm7IZExvBlnaFokBayKb2yRVjdI?=
 =?us-ascii?Q?n7j+GuMn035iA+x7xXN1IT7BrM+h7QxrKf0msQpDJjZOxqSFUtv4TKvK2kIy?=
 =?us-ascii?Q?E4V7ZlO1HLMpT/hCs1SIvmF9LNQ3okRJJYbF5rWzTQ/TNTN5+iEYBU1s+8QT?=
 =?us-ascii?Q?mtnl3G+TnOPJy5Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:43.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba810613-63aa-417d-d93c-08dde0b34c48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
Received-SPF: permerror client-ip=2a01:111:f403:2413::618;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
index b7cbd1379d4..6374a8de4c7 100644
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


