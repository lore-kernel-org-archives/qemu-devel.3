Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E368EC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqCmL-0003iN-5X; Mon, 16 Sep 2024 10:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqCmI-0003XV-Vv
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:32:35 -0400
Received: from mail-bn8nam11on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60f]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqCmH-0008UN-3M
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:32:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgmBQz13vXE0NJiQKX1KeaSrZEbkbADqcGn1BTm3dW4G79K/XC9cP9YwRvYXafwLMo8icTSU4q43AhbbG5sYThwDfe6OxJrv1WRxIZbhAawGOHr67arjRe/ibnK3wkDTkQq0SJFX4ZibiKIbMd6mUXJ2hX7IHcyPmyIE1xG4SNqPLZVijBqrRotoB4zOgnrQ0McMw6q6JT43NBvqj9HsXs2zWzS0SitD7AGyHJJat8YwG7JKNrQPqyu24pA0SJs/uRGE1/VUYmPN6zB/RPKVyzWhwDJtlSI9LZzMc7Iqd2L0RtQPxXT5Jl+jA+hLacRozkrx8tKPwE+AYw97uFcCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4C7q8VTSEPI7Falt7FBjBqENOv47yHHkAjOETJGWI0=;
 b=tPMck11AmDboFJCQzdjZoPj6XqrCviy+fUHOJMiZxCPTe0O1gHbOhE/YlJsMJyAiM5SJWGjmVamAAQxIM0YrfSKSOh4Q6jMqKiQuBesq9OJv5kXs5VEeKCM4OV2AtR6SrjZAzyXwmg2GEMFIHcuTulxHqY2frr4WoR1OR+SgZnO56V5vwWV8H+IDvNQ4oMCdvYccJF1xM+ulvyr/sDksdQ1lyQSjpVIhbtuBwl1feltRm3TxDrS+FXitDzSoNxxfCoVjka25AAiJErfn3J+1c3L7C0pdV89dEFmhWp7u2FgaDJlo3idIXGxl6ElDh2HczYS9LmTZY2H4i1OxfudT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4C7q8VTSEPI7Falt7FBjBqENOv47yHHkAjOETJGWI0=;
 b=BhQ/mz8hVwZ4cT0kpRN5jjUMXdftLTRrbY1M0wF3ODpvQY50WYdQFaA/agcBBC7/BLnOYgSo/UXvZMRiz5TRTzQ/mlVGUXos4IgI3yIDygrnbVFiB+VDSKJ2PpS+SFWxuzFDktF2tNgo1pWAjVcPxlgJ8nzOrYzmUy1mxEjzxzk=
Received: from BYAPR08CA0070.namprd08.prod.outlook.com (2603:10b6:a03:117::47)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 14:32:26 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::5c) by BYAPR08CA0070.outlook.office365.com
 (2603:10b6:a03:117::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Mon, 16 Sep 2024 14:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:32:23 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:32:22 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 5/5] amd_iommu: Check APIC ID > 255 for XTSup
Date: Mon, 16 Sep 2024 09:31:16 -0500
Message-ID: <20240916143116.169693-6-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240916143116.169693-1-santosh.shukla@amd.com>
References: <20240916143116.169693-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: de38d6cc-d918-40e7-aaaa-08dcd65c6161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BYkJXDiy2HFsPdkSttTT4nM2WSN8+gEgskOHA1Wp/aFeimNcO+S2Bt9HYC6O?=
 =?us-ascii?Q?3XfUDDDl66DXOGolHK45yA4iaGMyGlC00eE7Qh5M1/AwrERzCgevuYfoiSVV?=
 =?us-ascii?Q?MyJXON4GIaU7X1xHKhTQ1A0MlfLqFg2qvgrHJS2doUQ80Rs9GPgacLnSg6xe?=
 =?us-ascii?Q?ga8yvAk2u7H157kEhKCKKAQpmkykX8AUaHX7QzVSu6cBIiscd2htSEPW+OrX?=
 =?us-ascii?Q?nkMj/n0b2iKUMJ5sfou1HNlviX/bsvWjCu6oRLBaeNC2HeYd9eT2DoIQ0veQ?=
 =?us-ascii?Q?Ig2ppoYquG1kVZEd/mVl/tDjQhAMNUbAHoAjlBMLd92YpqoYEejjkwIRuXcK?=
 =?us-ascii?Q?amBAhncThPDbtbrhi/D4iKYcTgotL44q6bdqrQg2o2ZYLiUwZKtIVtsJCTbw?=
 =?us-ascii?Q?vHTLJcWAYvqlhUiHXBcnvTfQcB4MZmoJK+XZf/7T3ugWkklbMKsu5tGffp4u?=
 =?us-ascii?Q?vn3qEZIF5rZnqZ5iZAMoHN5Z1NcEcbcGJceIJHZO+Fn5K0BTWKPd3QjD0lUK?=
 =?us-ascii?Q?IkdXUhUB01ZRx9GmUbMKlrkp0LghFsiw1pGi5kUrVOwqZauaUrz0k2p8cESC?=
 =?us-ascii?Q?yJRgNEzgVLOpLxrayPy0zkWoM44BGLte3lGhNlavRQwLkLwXmaKOPdGoAXI8?=
 =?us-ascii?Q?nx1cglxbkuxvXgwCQF1hnWD2ns/n1/0YSWJJkAWeENphK/aZS6tprXsW1rGz?=
 =?us-ascii?Q?pGjakCQ+/MoV1jCWWh4QQSJHS40M7PfC4u7q/pK5tqBXXVc5HIL3rpxdOrQ5?=
 =?us-ascii?Q?5T/otMfdb7iCt1npimkMWMedXZVBuR0tA+BuARA8Ya0KeA1VRYlMBArswLHC?=
 =?us-ascii?Q?9wsP6+VnLW08y5a5RH161Xpg7tNA5V4SQ4zuWMZv+cBzwzr0S//D2bM0yuSs?=
 =?us-ascii?Q?7CGL4d2o5oAcTCfpruCT3bo7XmiIwrrJc51lyBRJmKvtSxIo09AtaxVLHZJ/?=
 =?us-ascii?Q?zWSkz6QgRJIyXT50tIvxqz50c6ZT/H/asbjSdTVS7sHThvf4IuBc4VGM1B1d?=
 =?us-ascii?Q?pQBgcD531SWcQuEuJYbK6r16P62A729LalrZVmgqXUcPMPjGg+HNfh3m3Y8I?=
 =?us-ascii?Q?BBCjYQiMq/Y4emxD85qOiF8S673dKWiTU8/qi0uLJa9joFQuHgBRevv6CRVh?=
 =?us-ascii?Q?0GmgDFvfqkhOp991KymPeaCHlz6NSY6xURlPpwnHkGFG/iTDR72mWfXZHTzQ?=
 =?us-ascii?Q?aYJ9XyzVQtFPxmwgw3XT9EMSItfid+TzxoOWNUNZHLAfUOPhwEGkXP88WZTd?=
 =?us-ascii?Q?+1FT6D60QNSLbgtfBWcm51BZY02Q5u39xicpb36jUB2BYuszG9Podnfxsrf3?=
 =?us-ascii?Q?WLnMKXUd0390I15PMTvc6sos6HcH7Lv+HJ1xtKH8GUv6FdVqSlct5cBDPZeD?=
 =?us-ascii?Q?qKVCYfErAS8zy50T7fQvHsMNDuyYyaiMb+98a3voe17hzrGaeCtZuHJ08R1I?=
 =?us-ascii?Q?TRYfgkjLU7cwVSA5KBaDi0nLsDrxmqg5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:32:23.7331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de38d6cc-d918-40e7-aaaa-08dcd65c6161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
Received-SPF: permerror client-ip=2a01:111:f403:2414::60f;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
to support vcpu w/ APIC ID > 255.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
v2:
- Fixed non-kvm build issue by adding a check for kvm_irqchip_is_split()

 hw/i386/amd_iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9095146525e6..24eebf053df0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/qdev-properties.h"
+#include "kvm/kvm_i386.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
+    /* AMD IOMMU with x2APIC mode requires xtsup=on */
+    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
+        exit(EXIT_FAILURE);
+    }
+    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+        error_report("AMD IOMMU xt=on requires support on the KVM side");
+        exit(EXIT_FAILURE);
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
2.43.5


