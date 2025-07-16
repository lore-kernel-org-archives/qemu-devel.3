Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A350C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysv-0004qT-Pk; Wed, 16 Jul 2025 05:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrn-0001aF-MZ; Wed, 16 Jul 2025 05:56:03 -0400
Received: from mail-bn7nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2009::607]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrh-0006dc-Fg; Wed, 16 Jul 2025 05:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crwpWJOgSU1kIOS3ytixBoGfDZ8uRXJ1iGnLnlZZIKuYU4LRo263XqGvdiH7xivvGwjSLfNNg4K56ZrwRHL+UfsJeuM9XszDEiJ/28rbKw01A4NCs8AcZFJRi9mEh9OHzIsvfFvpyspm4e1BsthwkuE442516R1c9W06QDSJiYbM+WiXOhK54bx08IMIq2XteMl3VJZq42Cxx+DSVDt/Pfyfz42BNgx3+a2iWKqUezm2Dm0Lo91ynWgr3Z2ok+DaX/MhvxcAJmwr/+Aa9obZNrDCzOgV5B2DceVN58llW9GAAVg4g1RUZFuGKsqA/32evXYV9wgp+fymyV7DExz5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y76AYBRy3bIJkmzam4taMXdycqeHz91uhzCM23rSu2g=;
 b=aUQYH+RZwdr0qvWjyInT2cRzt+7ZKacMTbKPOLLbwohKjpaH/tZ2E5wuZZa6nlyc/y1vzJGGEH4VEinF28HVwxuBha0mv65ikXI9FoQI1enpRvgoo3MU5MA+KTlIA+YIX1eIXQEGCOQrmu9S1vL/J67CZF71rJ0hd+56nJK0iK+7j/gykIPoBL8+b5jo1Nha1CpSsAU74vc2n8odPD/CKcMLVsuVTtic/2epo8/ng48zlFJwM7vMpN+PuIk/kh6GMoydBTZYBs/OkG9XAOypp3OE0hC9ziqK90ZrBEt5ZIbd4Terp75judqDtuZJr25l6fDExWtVHmXI/WWnge3siA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y76AYBRy3bIJkmzam4taMXdycqeHz91uhzCM23rSu2g=;
 b=yQqaxrVIjKO7S2Kk+T7ZiDydrgtaU0Wvuap0fpkgVtd45mpylpDBoxnDKMWG/yV+a7HsVpjPpkhzafT2afhsMxByHy3B5tdSdXlVQPQngu7laWfd80Tsuan7jO7c/i0FMUzVzBDngTCxN6W60C1V4HY2ebTxEZLZrs37sqJUIAs=
Received: from SJ0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:a03:331::23)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.26; Wed, 16 Jul
 2025 09:55:47 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::b0) by SJ0PR03CA0078.outlook.office365.com
 (2603:10b6:a03:331::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:46 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:44 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Francisco Iglesias <francisco.iglesias@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alistair
 Francis" <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, "Edgar E. Iglesias"
 <edgar.iglesias@xilinx.com>
Subject: [PATCH 24/48] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
Date: Wed, 16 Jul 2025 11:54:06 +0200
Message-ID: <20250716095432.81923-25-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b99354-60a9-4a90-6471-08ddc44ef04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PKolCJztrtl5a41O+GVmVWOY5+5yEKIPcqJ/5DcynxL6SH5tjBceZgwcTcch?=
 =?us-ascii?Q?RSyxSYw1GSyC+eEEi8mJeaMLeWdjoG42Op/Jr5I8UBcYshBe3QIzRztmcZ9b?=
 =?us-ascii?Q?554ftTAP3UbeD3fDJfT4/t/PZMgBTb+J/ZycAN7BTY0QPBRhfMkzrfjQF9Gr?=
 =?us-ascii?Q?v2c62MJ7a9kvS0aspTpk/NGDhgL7VfaC8JK1p+gzmh+aIhVSRTTNjuYd7FOT?=
 =?us-ascii?Q?xHFBBMO4zm2hXkdlA4FFhiNa4w5htfJujCQvgn4/AbO2wbj+Z46opRVRrNUv?=
 =?us-ascii?Q?K+TJ6uhVUxN7H6OtZUkLuYxZKqTkr6Xzeu7Twf0RlZxvpKHqjXztxarIcBig?=
 =?us-ascii?Q?LUsd5NWcGOqT/tn/u4GczfQV/LZ1sdwtd6+p//zg4+CPlwYBlFpsdYw9Heyl?=
 =?us-ascii?Q?qtsrVRy8g6/NOomnZ0ZVlyNJpGloVL3XpCSUV35XltxBXWBQONbCq65437m2?=
 =?us-ascii?Q?Opel396+Oc3jjQ/2MY1ZZwmLacVhwqd7YbyI9wb6m7k/kM4sJKQdP1M5NXeT?=
 =?us-ascii?Q?15fffLlbSIIXMPbBAB3EqV4X3f3SMsFwf1DEm3QCqvcQ8YCKWK8XTQfu/8u2?=
 =?us-ascii?Q?kCmPZQ88/c2OTGJaJkrRDNla/m85dJVU4nZF28arX56vLFIDyq61vQlRXzBj?=
 =?us-ascii?Q?/kKyqtnNhnnp3+AUVjse+WVPI01MRTMc7ZSWjCYuybloZXzUnXDjWoEi7C7o?=
 =?us-ascii?Q?iKdnPJjf5yD8nXWVUk3jZzFKnzRvh5DhGN8ALIYohWaMmIJzeh3o84UE/I90?=
 =?us-ascii?Q?tGi6qUIUMyC/25ly680N5NEDJNQ/SFRxV7WSCyGk+YJ68Gpsz3Ndva4PMIlY?=
 =?us-ascii?Q?AIykmGo6HrzBBJzJDx5DUvhut8Ug4MdgW+mQuKlq0EgDBm4VVPJHuqeM7lq1?=
 =?us-ascii?Q?VRzozzcedNkeQiNErZ3/LSLlPkHAkavz6xPL2rf5jy+8+vCCJI0bQr/Nw/BH?=
 =?us-ascii?Q?/PD3oEq40+AupJaNIYEyWYHSF+w3n0bQZLP6e+O1MKs3J+SkUqzKLpBpHeWY?=
 =?us-ascii?Q?05ZotXRIwmQYhHfzRyYD+W98ef5Dt2YQrVzFxb5rnGxVe9o6ozWs3DJm19YS?=
 =?us-ascii?Q?pTaO2HrmhDGz3n/pKDIn43ZUUBWLc0zXOn6rRD1jMyZpbxmpSPVYzJR+sLU7?=
 =?us-ascii?Q?FkwrzgnAW6EGSqVHJZrFh1HRChKcODzzMmNswyHiOptJkRvVC9KvixPif8bW?=
 =?us-ascii?Q?8nG/mFG8i62Q/fijFOn369aN0CW0o71cJvGAzARh9l+FMMYVmaSKdmHhJ9dj?=
 =?us-ascii?Q?1zKzqRD2qwhNHt7G9bQwf/1HdVf3GhCNiX7ZvEPqfDXP0wTrhjCXQ4eIe5eF?=
 =?us-ascii?Q?6IM5Kqh6udYd+oGicr6HgGIpkxyXd6SWGcz4Xeivb9H14vJnwpnFRlzJ/e+h?=
 =?us-ascii?Q?plM1JdHmR/cnTNQSeznPjSmWjx5sHc0UASG+8E1ivxU14U1pDqdL5NnfvOcj?=
 =?us-ascii?Q?B6o2SoyR3VQKp3dqhZf/wDo9zLtWlMRso5gJ0OmQXNL+z96ZAR9BfJ4QZQcD?=
 =?us-ascii?Q?Wv1AT35KfdPKbNOFT11/jLdn4xfRlQwbIs7H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:47.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b99354-60a9-4a90-6471-08ddc44ef04a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
Received-SPF: permerror client-ip=2a01:111:f403:2009::607;
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

From: Francisco Iglesias <francisco.iglesias@xilinx.com>

Introduce a 'first-cpu-index' property for specifying the first QEMU CPU
connected to the GICv3. This makes it possible to have multiple instances
of the GICv3 connected to different CPU clusters.

Signed-off-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 include/hw/intc/arm_gicv3_common.h | 1 +
 hw/intc/arm_gicv3_common.c         | 3 ++-
 hw/intc/arm_gicv3_cpuif.c          | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index c18503869f9..3c2ed30de71 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -226,10 +226,11 @@ struct GICv3State {
     MemoryRegion iomem_dist; /* Distributor */
     GICv3RedistRegion *redist_regions; /* Redistributor Regions */
     uint32_t *redist_region_count; /* redistributor count within each region */
     uint32_t nb_redist_regions; /* number of redist regions */
 
+    uint32_t first_cpu_idx;
     uint32_t num_cpu;
     uint32_t num_irq;
     uint32_t revision;
     uint32_t maint_irq;
     bool lpi_enable;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e438d8c042d..2d0df6da86c 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -434,11 +434,11 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     }
 
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_cpu(s->first_cpu_idx + i);
         uint64_t cpu_affid;
 
         s->cpu[i].cpu = cpu;
         s->cpu[i].gic = s;
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
@@ -620,10 +620,11 @@ static const Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_BOOL("force-8-bit-prio", GICv3State, force_8bit_prio, 0),
     DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
                       redist_region_count, qdev_prop_uint32, uint32_t),
     DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx, 0),
 };
 
 static void arm_gicv3_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf091570..1af7690b958 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -3022,11 +3022,11 @@ void gicv3_init_cpuif(GICv3State *s)
      * registers with the CPU
      */
     int i;
 
     for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
+        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(s->first_cpu_idx + i));
         GICv3CPUState *cs = &s->cpu[i];
 
         /*
          * If the CPU doesn't define a GICv3 configuration, probably because
          * in real hardware it doesn't have one, then we use default values
-- 
2.50.0


