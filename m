Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B32DC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 06:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpiw1-0007T1-2g; Thu, 28 Mar 2024 02:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpivw-0007Sj-89
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:08:16 -0400
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2408::601]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpivt-00078L-Kh
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfFpvhBbYSSsw8jSb/rUy8/oVJBqbkA6EcvIVvG9hORSHDE2xVRNS2+PyEDzuOU4oEor1/S+tclOyqldd9hszwzU5k+cYTRm7T3tUziIycDemDj0GlctaG7i78oEby185/spwG2tGu1jgu6zI4qfq9ut5YjDK/7RC7n724hRy7plMTRGLf8xROSBa3NE2p92jY5rVshxWP0eBZMvV+WnMsOEb5jMr16Zoe4YQWn8sRC7C3Lo9TELUpYvv/bn7p7gUwK6/5EiJgrv0ueZYtBoNAYHhjA301TEKFIcEiBvKUMaexpPvQa3Hu0R+yJSpUpb2ivZETkkOSJ9siVi/yJKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iktjCp5GS/8M8W4VEJkInG7sWcP8HxuGqTncJkiWFM=;
 b=Vy5KyVRuMpQ7mZ+B/ZUm4or406eeIwh41yqLNgPKqsjOcAUJNkobRCZiSvwcnAhsROQRHX2jVZnSLJUDU0gs8LoTzUylMS12bZcEBF/kubzzHaOoSEQkSDvBqhvc4Ij/GOJlaJvhm1kgIvoQySVrFoR/4RxW0Q4ZypNtlHqWwfdZC54PwyZpFiEMOteVgrxojH+FJJrReV4Pmawvsmpk82KtQ1UTLqQaRIogEAkFSBs64P2gRMEofDNagH/JyHa2XbExPRVMFiVKzov0LCCqbVW22Ur8CTVhGbFe2jJNMIlAyfCfryO0aAapEooBWiYdgse0YdT50CP+DUgQLRzuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iktjCp5GS/8M8W4VEJkInG7sWcP8HxuGqTncJkiWFM=;
 b=4r3TqM+FOytsD4MHl0NCx/DAukhZdRYXPl8XAPO7GWKm4JmLqDNqW9E9r0ZxtXjp3lDq2eGc7AcsW3mu9ciSS/QwrR6nAMHBoeVCJVL8TTx0JirELM8fT/7wczAX7kEzWiaNfWsaBhVE6OiL2JvgsPS4ZDavba0oBBddtbo7aAg=
Received: from BN9PR03CA0090.namprd03.prod.outlook.com (2603:10b6:408:fc::35)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 06:08:09 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::14) by BN9PR03CA0090.outlook.office365.com
 (2603:10b6:408:fc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 06:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Thu, 28 Mar 2024 06:08:09 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 01:08:06 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC QEMU PATCH v5 1/1] xen: Use gsi instead of irq for mapping pirq
Date: Thu, 28 Mar 2024 14:07:31 +0800
Message-ID: <20240328060731.354356-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328060731.354356-1-Jiqian.Chen@amd.com>
References: <20240328060731.354356-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e18142-2616-4616-208e-08dc4eed7133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFpXLZGHAOE+mjzrmlmfj1lN9OUY3e/hZZZfpRHim6s6Zfmbeo3B4CRE5GtGe0TV0j4TwcGRNIMXXPtWNXEvf0QCcqwGRg7acB0iyBxN1KrR/sfqNUzjjksp8Ov1/huq7dKW4IJLwuiZvq7NpbK2Y4KzIE85mnmgbsaz1KQzpg1cJj2QDACdWGSQsyv8yFdBu9ziL94v1tuK1rc5JG5Vnu+dE4WR8JKcvFAMC2jgGQvz8ybnyfVV3TIxcFdn5ha8CsqWMLohFufOcU55Qi4JXH0BBoVUaKp8TRNcDnbfr3AVywmx8v7i5zib4ffKOoymoYWlnsYdBqqNydNMU4wNKfU1x4xHIIYll5RfRI9Irw9PLDCFA9MJDU/St6Q1twhFBax4bKUHnthTFwRopkCJA2OZicaFzK9GaQRUmVRO33VRyLBJe/D+X0iW1qCTzZagG8ZuTp9cpERUbQRmwcLsEWoj8/LAyxtHIYx7W0OHfJKSBrML11JxzzWVYIrsTBlTWupy3oy+Jp23B9rC8JV+7F0CXlXDXIuxQYhkzTo3oZIjw2Qul/2kft1QzyQKeDO5TkOZarOz9FlYBdyEhrPM77TjL4GkRioK9ANOSfhhz76h8LBcuzUOr2ELQ7CDg6J4aKeue9WnnrQ7mDDp6M7uSKfFksYwlU24QAthE0kML8dLHnHIwbIUnjHoPVW1D8o8htirNQrEtaHNJbVZtbam8BxfUwQLpzN9vJf/4bBBd0oWbz+KcQoalHN79fYE2m4m
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:08:09.2690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e18142-2616-4616-208e-08dc4eed7133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
Received-SPF: permerror client-ip=2a01:111:f403:2408::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

In PVH dom0, it uses the linux local interrupt mechanism,
when it allocs irq for a gsi, it is dynamic, and follow
the principle of applying first, distributing first. And
the irq number is alloced from small to large, but the
applying gsi number is not, may gsi 38 comes before gsi
28, that causes the irq number is not equal with the gsi
number. And when passthrough a device, qemu wants to use
gsi to map pirq, xen_pt_realize->xc_physdev_map_pirq, but
the gsi number is got from file
/sys/bus/pci/devices/<sbdf>/irq in current code, so it
will fail when mapping.

Add gsi into XenHostPCIDevice and use gsi number that
read from gsi sysfs if it exists.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

---
RFC: discussions ongoing on the Linux side where/how to expose the gsi

---
 hw/xen/xen-host-pci-device.c | 7 +++++++
 hw/xen/xen-host-pci-device.h | 1 +
 hw/xen/xen_pt.c              | 6 +++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716a2..5be3279aa25b 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -370,6 +370,13 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     }
     d->irq = v;
 
+    xen_host_pci_get_dec_value(d, "gsi", &v, errp);
+    if (*errp) {
+        d->gsi = -1;
+    } else {
+        d->gsi = v;
+    }
+
     xen_host_pci_get_hex_value(d, "class", &v, errp);
     if (*errp) {
         goto error;
diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
index 4d8d34ecb024..74c552bb5548 100644
--- a/hw/xen/xen-host-pci-device.h
+++ b/hw/xen/xen-host-pci-device.h
@@ -27,6 +27,7 @@ typedef struct XenHostPCIDevice {
     uint16_t device_id;
     uint32_t class_code;
     int irq;
+    int gsi;
 
     XenHostPCIIORegion io_regions[PCI_NUM_REGIONS - 1];
     XenHostPCIIORegion rom;
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 3635d1b39f79..d34a7a8764ab 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -840,7 +840,11 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         goto out;
     }
 
-    machine_irq = s->real_device.irq;
+    if (s->real_device.gsi < 0) {
+        machine_irq = s->real_device.irq;
+    } else {
+        machine_irq = s->real_device.gsi;
+    }
     if (machine_irq == 0) {
         XEN_PT_LOG(d, "machine irq is 0\n");
         cmd |= PCI_COMMAND_INTX_DISABLE;
-- 
2.34.1


