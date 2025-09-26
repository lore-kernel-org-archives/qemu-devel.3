Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F42CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aF-0006WF-Jp; Fri, 26 Sep 2025 03:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a8-0006PQ-1O; Fri, 26 Sep 2025 03:09:28 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zv-0006cY-Vz; Fri, 26 Sep 2025 03:09:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8/f7ARlC51kMW/0VE0fRjgYlBzgR2wXqsH2ew5QX7Q6GQed9AU493GHt423eiRHj3yuyVKLQd2UsPZnkGaUGMSCX+/bjCY/9KzfeMbF7rMnynOmQP4VhhCEeeLn8J5cyLbzmcBH5lfeoCH9t0UHgr22Go1wZdflViLPoBqeVY5ICbIJ4ACI2jVGi81RXW8DWtEIVBTHsON/nxXQzJd9SqBTxA8k7cOz4rZSA9aowlQ3yY3fMDuCSFbO6M8aj3eoAfppuwlEjeilog2EyQw2PQr4g0z/54LNQlM2ZiLFcWj3MCHFUZ20+USP4qJxsvgjRMMiryHeMfQy87KGyaRUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNkAKqZ+Vs2sJGrLfxr5vHLitaUOg9ieJqxxEbdy8d8=;
 b=lK7fH03OO+H3r0q/1sHi/PK4Dh8C0nxq0eBpH2bh5bi5J3CVOyR39MnCWiN+SIBe49lyOk174J0nANzJYYbzF/4nuNar0Z20BbtAERem5ucSxFnV3YgFOmTyzxr7iObVKSWpI9KdAFPPhFOM/xTpjNoNA2pb5PpslUAuF1Lw+x4iJITQxHnXpw+OieMMuiIKsH+BNyfO2EQviFgn5hNyklr8xKs3zw9aHEqZ225Be4QviQawZ5dJW9r/HYpdZCbKGDfpLyrlaSq/F0miygl35hurwlwrtstVesv5JjqdViSOpp1FtT9ltbOoaUhAxMCb39C2evJzKRPUOGZoW3YSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNkAKqZ+Vs2sJGrLfxr5vHLitaUOg9ieJqxxEbdy8d8=;
 b=QOw3QcfdIa1oTzhIh1GMISzNCOrKml82YkaQezd8XMYxJky8VOKOV9EUaSKjJ/DWrJQVJ7IMeDm9TBRByQGgUCWxW/u59r6m0XC7VQSH7nykG/D/NPexLV3oDwubl3n3Rjs7JGlxrOeBdMYTix8v0sBq02BVz+iD4/rPgBeu78A=
Received: from SA0PR11CA0156.namprd11.prod.outlook.com (2603:10b6:806:1bb::11)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 07:09:04 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::80) by SA0PR11CA0156.outlook.office365.com
 (2603:10b6:806:1bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:50 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:50 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:49 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 21/47] hw/arm/xlnx-versal: add the mp_affinity property to
 the CPU mapping
Date: Fri, 26 Sep 2025 09:07:39 +0200
Message-ID: <20250926070806.292065-22-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4e95c2-409b-4f44-fd56-08ddfccb9371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EpxT3XmuOhWgfZ1scg/a0DkcZ9dXYVtfZ8uHeRzSqz+hZZWsGIoaJTTq/kj4?=
 =?us-ascii?Q?zrEeQ34aKXZJUtuUYFVJ8q1T1HdWo1zU9ZA+Om4s2D3tywT4ZXKYeJ6Lk6FS?=
 =?us-ascii?Q?HDJV967r+Ex21XKf6BxzqQOuBoEeB7zBzJ3HqzhlREJqkuqkiwyiIeEnL6qx?=
 =?us-ascii?Q?tgm5VNgU4Rd0S/WJg3vycBQI/qRNRPPT4Xqnx6pbu1zW7yXIBV0FCFqPIf3k?=
 =?us-ascii?Q?sjr13psE6zwxuF04ztg7085aVO9bP7enihhX172EuU8CZ3Wi5AbgLLLePtJI?=
 =?us-ascii?Q?v0FB81157gCl0ZTT1iMsl4Ld/IV6ArcROyGXmKE+eKw7B4W4FEGyQ8Py5PUU?=
 =?us-ascii?Q?yloOt2Jmbo5nOqiaPbjSsc3s0xtn01pZW6Q64L+nldYko3n7GP7btv56OLLR?=
 =?us-ascii?Q?FSdNfhm8g7zV9UPVLkfRm3xRmz2WVX9dmpOJtA0JWU/uLF3MCM0zbZ2Z79cq?=
 =?us-ascii?Q?3LAmtYapdGPmmsIVSFkaNu2II5qbWFPuLad1ayBQiXzOwtyFzwIQIxxuBoh/?=
 =?us-ascii?Q?iBVluvaWcKjBEVKThhk6CesmCw1vcs/+z/G8Cx1QGiDO+BqFXoOOSxHCEvHI?=
 =?us-ascii?Q?tapDjIlpX25xCfi2DdMXVT357iSk5JiObzksnWo5qlhRMqQvpbqs+fhjZbSJ?=
 =?us-ascii?Q?at3r+RzeqM8yJEq+6k9fbXyErK1RInMTiiz67NWwdEv6wkniQ+P90K2tMnAX?=
 =?us-ascii?Q?3aw0kOjrYaAwcS8zB7+um92V25etvgjOU8WVstr8j//aeZtuLZMqQTpUTiMh?=
 =?us-ascii?Q?YEoK4SvdN8I1fKy0XHX/otUfjm9ilV9ANlcbl++zU3Bbu0cxcp+umVGnVaZe?=
 =?us-ascii?Q?HG1OvPVSFTKsATDZ03GdikXrIGZh30N6lzulieRG81UFoIfaFR7jfJbbd1xB?=
 =?us-ascii?Q?kI4pYjC6eZsE7HyTtuirySaYoWSrnZL+6bAsxw+tWcNc7ozHy1i1OzC2Cqjd?=
 =?us-ascii?Q?3PrrVMAP3psw+XjZNQzJYIHW8iv8x2VqO7v8hfbv4Upj7rv20NWJfJiPGKfB?=
 =?us-ascii?Q?2oIqhuaq/N40EtwZ7BQqRNStbhhkMrhIVSkf+0+Ll/cxAl7GEwdtH7kz8q/Y?=
 =?us-ascii?Q?hwB5gZhi2fZynboQ6xp+TR+OH+HcGe4RUllC3aiare6KotDkMt+MVBpF+GQT?=
 =?us-ascii?Q?dUNcRTPVzX32HSSc1A9HsL4bTjnyaMNaUuR0QGFWMMjrLvvq+DEWJssh8jPZ?=
 =?us-ascii?Q?/HT0W6LfyCNTxFd5MT15hNAA0E97vsdAAuYVKXPWmQDIA1ygEQdoF5RZKLRn?=
 =?us-ascii?Q?N9VbYuZpOqz1QyNeFW9JAlrOyj/Bk+e7xO62ACcc7mXLDQI4SDY8aoYVXlzr?=
 =?us-ascii?Q?2Pa6+D36zlpc/J0UPVzTTlBZOkI4gZ1ZL1vw7c9ZNRN8OX+IOX0NVgqAQWBE?=
 =?us-ascii?Q?1Z07akAs0T+rzgrpQP3Mi7JPUhzwWutOnmFd6qMG6U7vVn3DXCm6klK3nk4G?=
 =?us-ascii?Q?qyBEx4ER1KlS6E9RzdmlOnnMY6PQg/j2NFjZY7ysuyeYBgCFokZMzPF/UU/X?=
 =?us-ascii?Q?a4O1XgYMPIEVX6TdjIoagQK/bzk4IUngZHmM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:03.8029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4e95c2-409b-4f44-fd56-08ddfccb9371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Luc.Michel@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index b4cad856dc2..ccb78fadd7f 100644
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
2.51.0


