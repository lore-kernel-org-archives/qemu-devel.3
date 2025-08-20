Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA7BCA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9t-0004i5-Io; Wed, 20 Aug 2025 04:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9r-0004ew-07; Wed, 20 Aug 2025 04:26:59 -0400
Received: from mail-mw2nam12on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9o-0000ys-Gq; Wed, 20 Aug 2025 04:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdmWyPXqfP6p75ojbeBm97Kg1NmMZUh13Il4Dou7y2La1ZtN8Wd5CKrBaIuyybgdFiaCFzjRQ06ibaRFyAOsrZYRgSgc5Krha68ECemUfOqurXfHAFI4VB0G6DYGOTabXf0S5mnOMdIPd3yD9XruerFXmMq/FwnnyOo/0tMttino5rLCzxysxjZ7+rExNyoKnaSC8/0KKd7081okaFWFrjUzerp1hHvQ0OwV9jwQA6d/lplUfbz+XC2GB4xLj84zWufz0htUtZ67cVOLnCMAP6dOC8CCsIiS5iCGseSBJg6nvDCLOTNaWQ5J2RfrWsWO1liIX1Z8gc5QzzAknjrXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJJnmWiZxG1h+/ckIhIl+er8XoGTPVzrijHMHN2Dwkw=;
 b=D6OKlXk4uK2IHALYK9PWzD/vpD6WB343n39eKuYq7QYZqtC6ysCWsanhUwjFN4rYjWKfwKy6cfRLuksY2rzrbC/8ExDqmlmNcyRb43LVZvVcjnZou7Koa2vk+rsSzk0K3K3Y6gav43NeRzQJRtOkScn9HOibOvnmO8xLcEFkcb5DEjIJwBSVB0kSoiMcnRrfpOv1rbXWzkm4c7o/C6NkWZxUjFFg8hFo23+DCinwNhqrh8NhQBKlMbB02kbd4AjrE1aNfb8hJX28oeBUdqfxVyWg/vmVckQadmFkcfz5xU935yIdjYDGk5Uzh7IjkgPPfE7ERiaB9xCxHX/h7MTtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJJnmWiZxG1h+/ckIhIl+er8XoGTPVzrijHMHN2Dwkw=;
 b=30RRlBMWt8fkoOeyKzC3brSXkz8NpUJgmm73eR0CDVJHeywoqfROkJ7dWM+zKWBnAspZik/COGQafWQTIfZjZsEAFJFnuhoKr2SvDk9312UifBF/LjAX8NhseIJkCU8wOegcywVId3GSjnDL4GKGRekQrPZQLT/YK5gpxl1S2kA=
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:26:50 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::38) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:48 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:47 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 21/47] hw/arm/xlnx-versal: add the mp_affinity property to
 the CPU mapping
Date: Wed, 20 Aug 2025 10:25:20 +0200
Message-ID: <20250820082549.69724-22-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 214f0a51-22ac-41af-234f-08dddfc34fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0wYPpd3C3SgJGPe7NZJ1yBMShh9FOZrHtARDXkJ4GSK76ZAHbTf02hfkJGJ?=
 =?us-ascii?Q?dNKLE5Bm/x1N/fFGL4Nz/dikCfVL+YnKcUoZYlWqSK1orPVBU0RK6wMlxj/4?=
 =?us-ascii?Q?cb1/PjY8UXw7rH+r3kdPoi0gkyBD5AaSEJNX1W17Y6CZr2fJAk7D5f8LUa43?=
 =?us-ascii?Q?ZK3uG50du6OfgOzn1YuNQFSYGhsAikoaxre467QkPBDbjysK8mWMH1n9MjzM?=
 =?us-ascii?Q?3Sat9VZdTCZmTZhLUYfYFdbX6ygKQXSpgAY3XJChPDZ7YsbUcUZDnJmWwQeB?=
 =?us-ascii?Q?/nt+pDUTk0VlVYc5k9jSzs9x/T3vkPY3Y6tnLTKF5/l5V0vTn9e8zBB2z63G?=
 =?us-ascii?Q?jKOxDfHYQaTgRK1QRphUPHbx7I5BafQYJasRiYm3/mMpAGFLsWcgXZgYwJIS?=
 =?us-ascii?Q?8f2Cba3tcxDkLzQSZyucCFfGEzBum2F5kusXDmAt/m32SyrrupaPEqUbhWIs?=
 =?us-ascii?Q?wVFUCX11G/eONyRfQCbnb8mJj/e653R0m5YUO+2O6MBBmpYd97hi7M+nRJIF?=
 =?us-ascii?Q?ZvTrAAUjvJ7dWUJr62Qw8/eDic6PNVQjgZ50ohV0eb+nRJWrnQmG9UxmYZSo?=
 =?us-ascii?Q?Simd9meYp8m3JmbN4IEXBAKty5EyV/bWXSCZUYmI/hsH7zQTRmLaDQHEIJDL?=
 =?us-ascii?Q?l3Clje5N2T+dZQVLUBBP5PYLe5lSU2+soOrN5mR30oXdx+wnb7mii3zQwWDZ?=
 =?us-ascii?Q?uMtm0q0mBu8wMrLZjScQfbNxXtPXp7Dbhe3KsvPOnI4Gr+cIX9uze7imaAk6?=
 =?us-ascii?Q?fxaUn10fS+6Y32OkZQ88XhJlXurhkJLdVp34Y4YKqDkKMNam+TfJZ7GYWv6S?=
 =?us-ascii?Q?wt4uwawOXZXLt2TWMOPTM2Cf6UO/WDWhq/WZPRp1+SE/nlUYe9PQ7D70FAK/?=
 =?us-ascii?Q?qGKZFZvb7uzBej6QebfdwsKTV7ylEA9++wWlM4PLJtu6Skjaed4T9ej5IFd3?=
 =?us-ascii?Q?cKzWsFIHwR/6Vo/Tl13Rss/AYOakXj7zKS6BCbQpQHvMIXgnkiulhTUlWhQn?=
 =?us-ascii?Q?bftXA9xDhbjP/z95LD0NrWIlAiIsNd219JBNuZrzIpXUTu2Zxl/m3mBko+nd?=
 =?us-ascii?Q?o6YrJcnfA0dQOLuUoRsbufLLqesDlOzgLpxCwmbfE3oBPy4bL3shRfRJ4Xg8?=
 =?us-ascii?Q?HAEZp9BVu1FVI5e+SHR+wglU7WpiILj+bWx0s9hQbdd/qVtQzYnJPZK0kOnP?=
 =?us-ascii?Q?0pGLtvnu6y2TYI7EXo59xW+V8N7CqmS99rd/BqCzJWV/IEKJq94J5ByvmkVm?=
 =?us-ascii?Q?sI3CBdJj0oLgK4jEQyNx3TGkQXQ0o6Dn4q36zLsEk2G0Ez0lVRYuN+mCiDYP?=
 =?us-ascii?Q?lrq7l3JPPWdCXP9e/P2akHcClD8AhkwzJmkwuAiH4QfymUb1mHaCvIbA1s0L?=
 =?us-ascii?Q?qhsRoakZqsh21OGd4Imzf4JRmhYJ3Az/PLUy6L/kUVKnQZhzkzcvVIOESCcu?=
 =?us-ascii?Q?hXkKDt7jqum6WJX2G6B/s/VjzJQExGbZD9tSDW3/Fc1o1DvG3ojjSq/pH8jt?=
 =?us-ascii?Q?+CD/pM6KAKO59aQGgfNoxE5kcBX3qZUZrI4W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:50.4619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214f0a51-22ac-41af-234f-08dddfc34fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A
Received-SPF: permerror client-ip=2a01:111:f403:200a::60a;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
directly given by the core ID.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 5a08ad07b28..35c32de0159 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -88,10 +88,18 @@ typedef struct VersalCpuClusterMap {
     size_t num_core;
     size_t num_cluster;
     uint32_t qemu_cluster_id;
     bool dtb_expose;
 
+    struct {
+        uint64_t base;
+        uint64_t core_mask;
+        uint64_t core_shift;
+        uint64_t cluster_mask;
+        uint64_t cluster_shift;
+    } mp_affinity;
+
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
     VersalCpuClusterMap apu;
@@ -196,10 +204,15 @@ static const VersalMap VERSAL_MAP = {
         .name = "apu",
         .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
         .num_cluster = 1,
         .num_core = 2,
         .qemu_cluster_id = 0,
+        .mp_affinity = {
+            .base = 0x0,
+            .core_mask = 0xff,
+            .core_shift = 0,
+        },
         .start_powered_off = SPO_SECONDARIES,
         .dtb_expose = true,
         .gic = {
             .version = 3,
             .dist = 0xf9000000,
@@ -565,23 +578,31 @@ static DeviceState *versal_create_cpu(Versal *s,
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
+    affinity |= (cluster_idx & map->mp_affinity.cluster_mask)
+        << map->mp_affinity.cluster_shift;
+    affinity |= (core_idx & map->mp_affinity.core_mask)
+        << map->mp_affinity.core_shift;
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


