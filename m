Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61BACAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22dU-0002pV-AF; Fri, 26 Sep 2025 03:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22an-0007DJ-Ur; Fri, 26 Sep 2025 03:10:15 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aP-0006ik-KY; Fri, 26 Sep 2025 03:10:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7KvYEH/UYZ4sYyQSu5DfVw9B2IeBgBMDgOsjHdvhUENvp6ItPYwHs3LHt5ssCTTVi4EH7cY9IOaGxntKee9U+Oi++PvwrW3rvkWDZAzbj+EuzxjPbTbcAlcbtJtRWM7Zf+0a3D3pwgcQAglsq/OwfWydhUlFEbQWAx3ZD1FHTmrOoLy7HvnMQ+QgRa72Bs2Odfw3sKwaEmY3omA5kZH965JXE5Yx2F16t05SHcKnvmbJtu1Z6IJtyzlI9cpLMZ1M7xYj2+qr7nHFQcDStTg/Uzv4Yk6ek58Pyd9iKMtSt1FuBnWjke8oWYzNkzbTA6jO5LQG9vgO9zTxE0JOknt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyGMBUMkIQ8fjC8FYtVtElSrRB+voJ6jOatDuNo+D7E=;
 b=BmZlFaOiY2E3mBVZoApyWIa1m65rApnluex+VmQRaHIumCuN+LlvSQa+8ibMz0CvDc//pyzw+L6zMAHcAPl2J6Q18UJnXkRUoFFiu2z8a9T6M4yVgGRcIdCanWfZQb1b3XXJyDxWFziBIsPPGLoAGNlA7vYBTzTS4iVKZkZ8j33+KW7HxlFj3Et9AAn6ekWFAQk0i1CLHBLRP2lF5Q6YOrHjQ4sI0+Y7Fr4KLZW6IhFFWQdcCfQdyJr5kXGty9AmAX5r29SAhQKmzjNVZmZSLw0KSxNDqpbEKbEVWSJ5CNS/oKSL4cGOHv6It+Y5S7tXKn3jgNP2Wy5uofdw1nH8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyGMBUMkIQ8fjC8FYtVtElSrRB+voJ6jOatDuNo+D7E=;
 b=cEyIZfgbXN4ojkgjo474WuJ6gAmZU5EyHtpw+7qlU4DbKqV7vAo+Zt5wmq8loPr7KYJgzPnFC/4PxD8MR+dP5tfxKySkLZnJ9TISP8LlfuU9EBU5eTmtD059VLu6M5kKr28Jckej8R9mJ/gLPLDBiAnJzNspPkYWRz+U0mWsuV4=
Received: from PH8PR21CA0002.namprd21.prod.outlook.com (2603:10b6:510:2ce::16)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 26 Sep
 2025 07:09:32 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::1c) by PH8PR21CA0002.outlook.office365.com
 (2603:10b6:510:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.6 via Frontend Transport; Fri,
 26 Sep 2025 07:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:19 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:18 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:17 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 37/47] hw/arm/xlnx-versal: add a per_cluster_gic switch to
 VersalCpuClusterMap
Date: Fri, 26 Sep 2025 09:07:55 +0200
Message-ID: <20250926070806.292065-38-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: e487694a-1105-4b9b-364e-08ddfccba414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHRhVDd6VUx4K2xtZkNOcUx2cVA1bXhpRXA2c2J0QjNwQzNmbFZmelhjcS9L?=
 =?utf-8?B?aEZCaHZ6LzBLVjVzdVRqRllxRkltTFhhU0d4dDc2cmZ2QkxBWWFaQi9kRTRp?=
 =?utf-8?B?S0ZzNVBiV084dW5iZjBWSE1DT21aSWUwR2poVXYzbmZmUTd0RUpaU2F2azNJ?=
 =?utf-8?B?V3FxT0xJNklQOVRUM0RyVlFqVDlWb0hnRStLeVc0dzdpOTArS05OcTI5RHFF?=
 =?utf-8?B?UE9RZDk3RzZCT05STk92M3FvTjR6Smt2aUJsWHZKOEJDemxGb1JueDI0VU9P?=
 =?utf-8?B?RlgwQWw0NTE1U083TE14dk5aR2lIemVhYWVqWmRkMkhzUEpqWXN1VHJUcjZj?=
 =?utf-8?B?bnI0YThrd0VONFowQVRoMFcrYmpxT3lwZVZjaGFRclRWOCtBcDMrOWVtSW0r?=
 =?utf-8?B?MldEenNFR041YTZ5Rkt5cWV0TmlXbURjUnZhaTBrNnFYRWpXcVE2cWpzUEQw?=
 =?utf-8?B?eXQweXVqTUdjNzRoY0QxNG1sVGJMWjlRMlo2VFk5NmhLMFFTMityOTE5OEo5?=
 =?utf-8?B?bEtiTlNLczkxc0w1N0VtRkpGRWFFV0Rrc0xIak1MOG1VZDR6cE5nMjdEUTMr?=
 =?utf-8?B?bVVhbG8zMTFTTGlDOTRYVWF2NlhVeFIrTXZDOHp2QWhIMDk0eWFsMVBDS0Fx?=
 =?utf-8?B?amRBNkJZYjY2WVZZM0tYMVlhQkRWQVpRclNBVXlaMzNxMDdSZURXdzFOSmNo?=
 =?utf-8?B?Q1k3bEJwQUYraWt2U0twemNEN0pDOWtHMGd4RTRGTFhYbHpYbjd6ZGJrbnlI?=
 =?utf-8?B?c1hxUGdoaHl0c08ybUxZbXlYUkdOdjkrSjVadWduOGFENTFXVVdPQTUxcUtE?=
 =?utf-8?B?RmwreE9GVkxqYTRVM1cyVmY1WEtPa1RrMGg0bS9UbER5Z0hxeTNSbHhHYzAz?=
 =?utf-8?B?ditNcWVtbmhQSXFqUmwxLzVRMktDdHdxay9FUjJYM3FYMHBVYlB4TUNIUzgv?=
 =?utf-8?B?RWVDaDFmUWR3VlIwazh2czhNOXNPQ29jRHRKdE5Gbm10RVBXdmxHekc5M2dK?=
 =?utf-8?B?MnJ4WEFkWG5WRjNUN3JuTFFBODQyZ1ZwbnpKaGhXeG9SSGxKdzVsdmhLVFFQ?=
 =?utf-8?B?NGhmWlhlQ0oreUg4WlR5M0R2cmUrL1N5RGYvcVZ0N3A0R1JYQUlzMmZaeEI0?=
 =?utf-8?B?S21VNnZkdUN2SU1NU2ovUmVXZkxadTVrRG9QM25kczFBQUxkRS94U2l0eXdh?=
 =?utf-8?B?TCtIS3NTOW5TaHo2SGJDUmRyazNOWVU5UDV6V0hrOWRYV2lXd3BwS3pyRWVT?=
 =?utf-8?B?aWZZNkQxS3Zpai9xUVBHaGE0S1ZBR2JUakYwR0VXcmxjTEJZbXFXd2RHVFRR?=
 =?utf-8?B?RHdQN2tzVTdWeUg0clZUdjlvTjlKaElGNWVPSXhiUFA3ZWthTE1XcGdQS2lQ?=
 =?utf-8?B?cmZuYnlnbldvZTV5bklrRHgva2pCQy84aW56SFJUQ1JxcTF6Ym5GZlIzdklz?=
 =?utf-8?B?MzFMaWtJWTNZZklnTFVFSU5KMUk5Ull0akNiMEJzYUVrN0J5MEFWZlhqend6?=
 =?utf-8?B?aHdYbkxoZWtLelZycWlsbzVnYUtaSFJad0VSWkh1WWNVN2RQZWhBY2I5ejNK?=
 =?utf-8?B?aC9jV2l4eFhzcWVySzFXTlFtUnlJdE10RGZ0VEV4VGtNRXNsOFJoNkk2YXVM?=
 =?utf-8?B?S2pMY1JRVWc5TVdIMlpYR3cvNDJZRUdTOGxyd04yY3VmUWlyb3RpMDBIdTA4?=
 =?utf-8?B?SFNiZ0U0aU16Y3hrOUs4azNyM1hOb09HdC9McnJZSDc3ZVYzWVU1clprbHZi?=
 =?utf-8?B?b2ZTWStiZjl0NmkrYldoTVJIUkpRR2pzWi9LTzFFMXF3c2ROd1JCNnpjb2Vn?=
 =?utf-8?B?aVJQNHJaQlRTQ2NjTnZhbHF1bEhFUEZpTkRLQ0hXN1BCcVBOa1JjMDFsdGJR?=
 =?utf-8?B?VTB6b0RjMlJVbWZsQVdWMkVFRTVsUkpYNmUvSm1yQ1dldHd1UmNab1BxUDUr?=
 =?utf-8?B?cjl0a0loZE9ZZGVyVXlESTA4K05ldDN6Y2xHenVYeXRNQ1lQZUJlUUN1RGhi?=
 =?utf-8?B?bStoQnlwWkltY1pSSmQ3dWtxcnlaZjBYSHMxU095L2dUM0pYbmJIY2dKQUw2?=
 =?utf-8?B?b3FkYms3N09UQ0lhVHJBMmZTdmJ0SDRLb2VpeThjOU52SWNCNXhaNVEzYVBD?=
 =?utf-8?Q?dq/Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:31.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e487694a-1105-4b9b-364e-08ddfccba414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Luc.Michel@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add the per_cluster_gic switch to the VersalCpuClusterMap structure.
When set, this indicates that a GIC instance should by created
per-cluster instead of globally for the whole RPU or APU. This is in
preparation for versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 49b5b244403..3d960ed2636 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -86,10 +86,15 @@ enum StartPoweredOffMode {
     SPO_ALL,
 };
 
 typedef struct VersalCpuClusterMap {
     VersalGicMap gic;
+    /*
+     * true: one GIC per cluster.
+     * false: one GIC for all CPUs
+     */
+    bool per_cluster_gic;
 
     const char *name;
     const char *cpu_model;
     size_t num_core;
     size_t num_cluster;
@@ -823,16 +828,22 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
             DeviceState *cpu = versal_create_cpu(s, map, cluster, mr, i, j);
 
             cpus[i * map->num_core + j] = cpu;
         }
 
+        if (map->per_cluster_gic) {
+            versal_create_and_connect_gic(s, map, mr, &cpus[i * map->num_core],
+                                          map->num_core);
+        }
     }
 
     qdev_realize_and_unref(cluster, NULL, &error_fatal);
 
-    versal_create_and_connect_gic(s, map, mr, cpus,
-                                  map->num_cluster * map->num_core);
+    if (!map->per_cluster_gic) {
+        versal_create_and_connect_gic(s, map, mr, cpus,
+                                      map->num_cluster * map->num_core);
+    }
 
     has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
     if (map->dtb_expose && has_gtimer) {
         qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
         qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
-- 
2.51.0


