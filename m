Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839BBCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eq-0002qP-RV; Fri, 12 Sep 2025 06:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007RA-Ui; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-dm6nam12on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2417::618]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ci-0001OT-Bu; Fri, 12 Sep 2025 06:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbAWetEe1c5rS2YkckjBp01CaMEvsO7/1DjUeCKypyLTAb9UTeJCVh6sKo84ijHq53njzgV0uqFUnY9odea85XwwIqYwTQ7oT5EGInmnPfY6FK+qT7FSc87YMK4S48/ODvbiRkli9qeYxU1TcXxEbh/ymFzQlnQ8P3gZABwMImREX9UvkTPKUGhxIWwNrdkY3CiC2f3zlQy3GVE4/kmX4FL5/AVL6udMpbA90PBoXEuY9re7SOIg4NJEjSpkcdGb7xxawlcSPnc0GpiXuw+UPSY9ogiSMUfppXAU7PQLLB4FOZ++73rsiapsHpHZBbgpCuuSZGi5+/oG5WA/XJG8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7SGNdH8vHvR+Rf/xGFqc1DtTA23qavHN6QD1fw2rMg=;
 b=lRfGFhRrcOBDfszVuL4zTYWj60e1Dx0NuHOY8shQqIFjfFhMyNHEs9S25LL1pl7j3nmlXnNvDxI2eS/7NOJ5c+KwPVRUI99Cc029cRg8zsZgEsMFwqzM8CAmuRmFaomPzUL0qJezgJva6VVBK4qPTnXziZO/HV9JZX1S/H2CxogmqMSe5uw/YnvCFkodB4Ht32+LhhkwVEya661ihW9laFp6vSdu+PVDtWdB46se5BPXZlqF9+jS2CjauZvVf+qYJui/Lkn1D1oQ7jd+4PRyCSZHlrIlpg9jlnE0opJJ3BSuIK7OJD6LMhRWpHylcUqkhIPQ7N+uAqCaZVkadkXBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7SGNdH8vHvR+Rf/xGFqc1DtTA23qavHN6QD1fw2rMg=;
 b=PNsEIPsx7rhlF1VRzZyggWnZoISxQwJL9AE5cMuCw3NFNh4+mlPoOaIXrnCRiR4CGkA85yxdKDSy1KN0ehCO3p/2ZCQsxaQ07EUs2caUVWgt5xbzKW0SZazZTQ3k63C52BdsljKoVy+JkU1pHiNJcpH5fNmCzfXx/AjkVRJj8g4=
Received: from CH0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::9) by
 IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:14 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::89) by CH0P220CA0013.outlook.office365.com
 (2603:10b6:610:ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:27 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:27 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:25 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 37/47] hw/arm/xlnx-versal: add a per_cluster_gic switch to
 VersalCpuClusterMap
Date: Fri, 12 Sep 2025 12:00:46 +0200
Message-ID: <20250912100059.103997-38-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d3a025-3fe0-4f60-e01a-08ddf1e39694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1JMLzQyMzhwV1g5MDBEcE5rYXBWQU5JNzNBaVN1cmpOaXltSjcxMWRWRHda?=
 =?utf-8?B?ZzV6SmJiWWU1S0kzNG1QTjVhUm5BTzM1Yk5ydlhKVjJlZ2h5Q0xqY1JaT2sx?=
 =?utf-8?B?N3ZBNU5PWmRIeDJ6eFJPUFpMZkRmOWVkSWJYaDZ4WHNnNFh6eHdib3R6dVI5?=
 =?utf-8?B?VGdYMElFMDJPT2dDM2lTcDNmaUU5ODJWNTBBbVU1K1h3VENrTk00R0VIWSt0?=
 =?utf-8?B?bkxVZ2tpcHNGcXZuOHZLN1BPbXg4K1JkT0RoSkxMMjlsZjc2ZllVR0YwSWJE?=
 =?utf-8?B?eTRCd2J0VXJ3bm1NZlNmWk9KT2ZsOG52dGVFaEt5NEVTeDNiQm4zZHUzSWVV?=
 =?utf-8?B?R2xiYkwxNXBhT2h4eFBIYTNyeGJzUWE0THBYdit0ZkF3L0trWm5RcmxrK0xG?=
 =?utf-8?B?SUh2L3BRMXpGQUxYOXF0NlZLSjdLZWx6UXhaWnBVcUxpSjRleE5WZUlweWx6?=
 =?utf-8?B?VkFBcTY1QmJQN3NSMWlVdXQzanhRU2xWZXV0QS8vbXNVcVhTSk9jL0RFazBD?=
 =?utf-8?B?MGhDOVNLeG0vV2cwb2JtUEJncHJkQ29acW1rSnZobmVGTUpaM3VqSDVpWkps?=
 =?utf-8?B?RFI4ZnJZaDUwYWticlI4UktCMXYzalhtQW11a0VnTzcwOU1PWnpTaFRBN25m?=
 =?utf-8?B?SUFnc1Ftck5DSHZoVTArRkhPOS9sblJoU2xocUlNMThTNDFNKzFBeWQ1UGxF?=
 =?utf-8?B?RXZFbFVSVDRQWkZzNE9pQkRnQ3lsSUpmOU1OWDF0Q3J2U2NnV05MU2RqYlI5?=
 =?utf-8?B?WDRtUUVJd2xHWmc4MTh0T25WSEtNdS8rRi84NDU4bDU2eEtsVnpUeHZmbDZV?=
 =?utf-8?B?bEVobml0WXZoaFhGZFlIVVVzc3pwV1ZBRUJkYkZ5dnJWb3lXZGZ1Tm1MZENz?=
 =?utf-8?B?NXk1WitDSE1WeWZXcFRBNGRoc05mRkVXNWFHZjluVWtaWTZqSCtYc1ZQSll6?=
 =?utf-8?B?aU5teHdjWGJoc0hCcmc1bjdoTG91MmlyTEluWVJnOXZNbjhpUEdzVzIwTDFP?=
 =?utf-8?B?dk1ySTBRZGMyb0hMNTFIYlVSd3BmcTh5ck9TZkh4dlpIRi9tZ0lScHFoZEFU?=
 =?utf-8?B?cUhoalhtdjkrM2ppeTAydDZyeFZReTF1L1lhTWwrTmtNN3FrdHpINWlwSllU?=
 =?utf-8?B?ZVE2blZYSUgvdzRIbHFETGx4UkdMN1hBNWVEbndlNmZrZ2tDa3lOL1lqRjRu?=
 =?utf-8?B?djdGVnVDZCs0Y0JmVjR1Ry9HcElFTzdJcHVJSWN1Nnp3TmVrRXg2c2NHcjAz?=
 =?utf-8?B?L01aeWlTSnUyZmw4NHFTMWJLbFJ6YkRHY04xZWtKUWdiQTl1UFY2bGVJZ3dz?=
 =?utf-8?B?bnd4YVFXdVk2RUlZNHBHd2NXZ2JvMm0vMDd1ZURPY0taMVlHcWdsT1RsWGVV?=
 =?utf-8?B?ZFlObTVjSVl4S1EwamtSejN2THF3bDdNK0htbU5tWjJjMFFidG5QVFZTdGNq?=
 =?utf-8?B?ZllWcldNaUpiMjllQUo3a3NRK2ZBT3M5dXRqRlBZSEdmbmpBR0pCb1N4REpJ?=
 =?utf-8?B?OEdydzB5OGxWeTFNMEpHc2ltZ0ltWk51MnFPQTM2NU5rU1czdkUxanRFMEJS?=
 =?utf-8?B?QlVxVy95akdSdzZMVjVvMm1tZ2tTcFJLd2lhY2JQbUxxNGJtYVNFSHhsdk5p?=
 =?utf-8?B?czQ1RWFkWmZhd0d4MVp1VmJVdFJGZFVqRnhzbkN6VXBXdi9VTVVla1plQjJU?=
 =?utf-8?B?T1hYTFFZbHdSMGwzcXVzOXkrWFllY3dYQk56bE9iUVZGSXQwbW5xQU4wNzMz?=
 =?utf-8?B?aUNOV1E1SXRHUndTS21PdEFPWHNyUUFNZElDOFEraXdHRnQvRi9Vd0RudzRz?=
 =?utf-8?B?bFUxNVNaRi9jaXc4N2EyamY5dTQ2MlRMWG8yL0cxUFFwSjNMRlI5aDdyQXBU?=
 =?utf-8?B?MHk2a20vN3JuRG5zcm0wakhIVkl2bHI5SlM5dXlYRWZJMW5LbDdDTUhBY0Fy?=
 =?utf-8?B?VEJHRmhXZnpiSEVYYjB4ZEtPSzQ2a2xoL3dkWUFhZklUcEFTTTVlck5teXky?=
 =?utf-8?B?aDY3RHFHTVFiMmdGeDNKTDZZdmRJS3RYVE13aG0zNDlZZUtuWTZEYktGVUZH?=
 =?utf-8?Q?RkGEU7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:14.1882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d3a025-3fe0-4f60-e01a-08ddf1e39694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163
Received-SPF: permerror client-ip=2a01:111:f403:2417::618;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Add the per_cluster_gic switch to the VersalCpuClusterMap structure.
When set, this indicates that a GIC instance should by created
per-cluster instead of globally for the whole RPU or APU. This is in
preparation for versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xlnx-versal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 19ef169e11a..bf474bdf37d 100644
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
2.50.1


