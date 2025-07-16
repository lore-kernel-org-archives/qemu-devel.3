Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F6EC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysz-0005Dk-Eo; Wed, 16 Jul 2025 05:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrp-0001aY-I9; Wed, 16 Jul 2025 05:56:03 -0400
Received: from mail-mw2nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrh-0006dM-Lk; Wed, 16 Jul 2025 05:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ8Z0Fsg2AUfsACbZYHW6SZ7918EdrfmaPAEL7PDhDr6a4nwIVwVAQk8TWBNLEsgcQIn9qkrINRtaYbcBuXUXHYbKP0J2DN+1a6BnLAZ9FX5HWXmdPwOsPsLwOeY7Unrz1GBlKskuh2Smu5ipnQ+c3P80PpKHImKqSA0b8PDwud8U45m/WaYGXiEjS0y0z0E81mpdjjvqMmdjoFuhytxdneW5pwFEvJ9FB5PzFsOnlubf8TFuO9Ct4WtMk/qzA1xaEkKCUiSFhMBBQN+sgUeL+SoPY4MAKOw5cQeiTy3sC/37/cdxUhWzAbAA5pH4xW5htVkUcddEgzEkhxHIjTQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5GR6ckIX1bACMexpv7eIS8ecSA4bGYs5jZcPFoGnrk=;
 b=awNFoNwCeghZzV0tckT1CmibbrECvEJp/I+p7jlYJzPF47X79XEQYV3fed4pFhlTq2f5VCwjTX1mrBjJYsGo1Dx/mUqOqxJJ41V5SsNMJUBQvlms3gxMW3C7yKIM/ThmTkZHn9RzOGZIZbcp9olYsMyEHEXDUPv/0fXV+5ARFCh7YGOrxzFDRAavSbbHXgB3frwc+X6WZAURBHt41tHDLbEdzm0TUrT22EicJLbYPS/UrgPjjc9bRn4qZ5wy0PhdlWBMm7lpH+ADxxq9KgkMNsqOqdPijFR/ZrBEYbLrbZ4/SISRt1azaJBnSUWyQDdfqBxEalngkSvuJStgsT3OKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5GR6ckIX1bACMexpv7eIS8ecSA4bGYs5jZcPFoGnrk=;
 b=NHhpgTqcX4/aHrYFLTfOLNO7paZjcuSEG0R5e8TRONXRknRraO8F3ulTdgb1ZZGu8laYWrqdJRN7AaA6dR2i87WC8vkkGhvGO3uV7peG8z8/2YZlE/nDL2PCjJmS776mvE5AonNvSnUkdM3bdCVxDQJU/yV3jZkUjX++A9ky9yU=
Received: from SJ0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:a03:331::11)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:55:43 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::a7) by SJ0PR03CA0066.outlook.office365.com
 (2603:10b6:a03:331::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Wed,
 16 Jul 2025 09:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:42 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:40 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 22/48] hw/arm/xlnx-versal: add the mp_affinity property to the
 CPU mapping
Date: Wed, 16 Jul 2025 11:54:04 +0200
Message-ID: <20250716095432.81923-23-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc874ad-984d-4b20-b9f1-08ddc44eee04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CeK3Uk27MCqqXM+kgU2Ac1OSOOi3kpJVU3qLUuG0xlPjtwjz/PMeAKk4zgRN?=
 =?us-ascii?Q?6SLT0ZCDUBFSle07tlZTFOvcOtC/lsg8IZoliVvzorqgUR+ALbPb22dTCSWP?=
 =?us-ascii?Q?LffVVqrQovMAAxYWyLHHTp+97g2S4mH9VWMt6A/x84WeyXn9d3qvXEB/MLgH?=
 =?us-ascii?Q?z8dT7IG8EI7xrb6E0dSfnBULDgNR7Nj9tWJadBmpBWAp86W6JpUovm1BK7hM?=
 =?us-ascii?Q?WchRlEBPRBtf3wkZjy0Etd9ypiREdXnSdg04HXl8kw5n1jAM3cT6y+Mapvr4?=
 =?us-ascii?Q?5wA0loamGm9LbStE1T0I2sO24lrhJnqi+ZN9u5eidi90IjsNZwm23KVCWilO?=
 =?us-ascii?Q?r+73t/ReeKkQ+Eqm6yOGCOetw+U0tD7OklXyMSFNkrXPWtOwsXK1pa8eoNAO?=
 =?us-ascii?Q?KuiuIDzTqrq5qLZwAxJxmnwlkYwxUGdLIKV6qHwgMt/tRPXM03r9yJqQFxjz?=
 =?us-ascii?Q?M4YQCLD53WZAZRqmry4DoY19WfMJZ+1S/r/kG6sctjrJpiE3piwYeoRNxwCM?=
 =?us-ascii?Q?bAOu0gkLsYvzpsfhb6vuc8hVgaDJaTAwWqZL26WF4R8kGUY55OeysLqFGdid?=
 =?us-ascii?Q?VQ8X88llGX0+2Mh7j3zDFAHv/eGPVoDbNgtWkgPIqgAvhl8rsJ/hRTJsoiyh?=
 =?us-ascii?Q?IHHC4KjhTWlfggsbXchvd7c9B8YAzVIIUjS6gdzKuADUUxQNG2Sws/tbn2mh?=
 =?us-ascii?Q?LJQJ0ejeW3ZvJj8BmDiWarJYjQ99uqKZsrpQaIsQDHQB06u0BzZggZTq01CF?=
 =?us-ascii?Q?3eTX2Abhp/iDVuHdWAqTS7sAs2VxACpP/9MpCab84towXEsCyZ6bYGVn5vxp?=
 =?us-ascii?Q?JxSBmg1QUDgsGlboWZbHchHlt+OJPbJkFHoAmb5eKniiY8I3DD+K2SlCk8xo?=
 =?us-ascii?Q?PtXt+SfattTGrcJYMKIc5xBo+5iuxaZbm3RC9MNA6VNvP8g3mvdtoOwELocV?=
 =?us-ascii?Q?RlS1+yIqwLrOKbzFSgCGf1JWuu58yydQ36LkGh5DHB8fCoG5TjmIya79Iuc5?=
 =?us-ascii?Q?UViZMBVk/jS/km93tk+IL8uUqLluYDw3giYSJyOzT+Y/fyfSdBMpWcBJLvFq?=
 =?us-ascii?Q?dSZGFUpGRXW+VWCXJdlZUKL1jMdxvm4yNEev/tXfiBp9opxvuzNtC1cBYV49?=
 =?us-ascii?Q?Yc3Aog8fnRPyHTOw5ozYH5yFEx4S8yfeMg2NSy+EnRzuuMg0Gy5ySwncvZIb?=
 =?us-ascii?Q?uIax1fxVF/ZOWyY7AFw8BAO5lK6e2QmLcf1cJS4jvyk9aQIuK5UUKXlCOAI5?=
 =?us-ascii?Q?5JBQFtPs0+IQzYXzjtvFT3aZ7Jkd9yscAqzA+hpA6ouDSVtWfdo6I47IS4yG?=
 =?us-ascii?Q?N1owSn28hUVoAAlS17yQOiJfKDOaAs8HPtC2HH6ocj9KE3VvqCObNndNk9h8?=
 =?us-ascii?Q?t+uzRvfBYrLD1YystPPCOwlSmYrD2yttqiJ6e6EBse8vwUNS2Dzc8aSLRdfb?=
 =?us-ascii?Q?q2ED7vCvRK2AgQb//siz7LhYpc7TeTItoxoXtXnwnlx7xYpKBXJ9WVlooIeh?=
 =?us-ascii?Q?Cpnsz6R9kpsQSZSv8zYql/u532and0MQssgw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:43.4916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc874ad-984d-4b20-b9f1-08ddc44eee04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
Received-SPF: permerror client-ip=2a01:111:f403:200a::62b;
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
2.50.0


