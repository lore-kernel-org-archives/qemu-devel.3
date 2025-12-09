Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C5D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzaD-0001oT-Vl; Tue, 09 Dec 2025 10:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vSyqy-0006oT-6w
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 09:38:12 -0500
Received: from mail-westusazon11010007.outbound.protection.outlook.com
 ([52.101.85.7] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vSyqw-0004bm-05
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 09:38:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqZXBaz5ZPkBOfLZQTTqUTHFVKhF6wyq6dqyG7yd1Y1cHHZgxsD7lWqNMnxMun7tquALPF9ma0S89GYK20QU7xv4bKNfK/6VFbZQypOm88g0gnEpdPAt5NduLITggswzarkq1Xl1ojkSNn9EWV+QphP4wUJzESpUl0NsVL5IoMfp82mDo7kjUsXpSRFt3C3y/mp/qXUS7t5FiP9NfImqMxkfM9Qf7eO4TXXdxmDez0gtr2/zXNPKcyoaQPpkSco8Y3nJEK/8603Ftm0069/I1EaFARUC8d95CoRla/bgoGKHAdhjmTxOA/SJmzXpQYecW3avvfXVrw4V6FF1Dccb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3TvdjgH7kFQlJ5KYBw8p9sXqdsN3kguRNlyGljqN2Q=;
 b=NzW0p6LkDo/WHe+z26MgdeVGhRvtRHQRrWTM1pI+ND2KJ5HfVgrbsKGd8sJ9qs3Q/W7dsQ8AqiolSBUeTqukoH8/V/O3M+HLVeyv1vt3lFv6j9PWLgTJznsqpYkoxSjkm7vNOT/Kq0LmuDwNNnjgJE8WwamUljJh0RdZ3cOAshtALeIXkqW8EC1Z0JazEEeJu1VlC+hrg4M8hW68zHuSdJCgvtLudOocK15DVl2NFk69vvUua1Rb2X3OVZzmaTANUeahVE39NBqZdTL4TOx2LLOO7Z4RDqBJOABij1tmlE5k4kUJ3JkXqlWDuL4gGt25fu9LPgrT5FFi7HfeNCLWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3TvdjgH7kFQlJ5KYBw8p9sXqdsN3kguRNlyGljqN2Q=;
 b=QB1JMMokJSnLTB3HiHqp058NSBY049qw6O5fa78HsTDOSozufDTDZho76D9dsYmvQwKPc16T55Li4/AjEr3CZucb05gvey3D/yrzoirkA2czazb1cKwYqcuD9lwqZeehVWZZPBaICa1FXZHyKPyZ1kaJgWpLR15nVUxm6UL6pls=
Received: from BN0PR04CA0206.namprd04.prod.outlook.com (2603:10b6:408:e9::31)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 14:32:54 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::7e) by BN0PR04CA0206.outlook.office365.com
 (2603:10b6:408:e9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 14:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 14:32:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 08:32:51 -0600
Received: from genoa24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 06:32:50 -0800
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <nikola.prica@amd.com>,
 <dejan.andjelkovic@amd.com>, Manojlo Pekovic <manojlo.pekovic@amd.com>
Subject: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Date: Tue, 9 Dec 2025 14:32:50 +0000
Message-ID: <20251209143250.714546-1-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d30fa7-d850-4db5-3e65-08de372fd66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LSorSkm/NNzckYsV1k2zxbgjEolQrNUnZY6/5h4dbp7JmtDwPLFHXhNp4QBE?=
 =?us-ascii?Q?Ad87xmWYWoewwQXRoeFZxiwHn/r7cG5nn5mIggLpRcIUAQtwmLhQfxJvuDVJ?=
 =?us-ascii?Q?5mV5UVNNc4Ghj5fehRZyL7Pw1PpDF/NWQZQq2dkU5lv7J/vgBxkOGsQRKbH9?=
 =?us-ascii?Q?NnP90cDPJngBc7emivps2Dl76N7yIpeJ90X2E/g1R+Le+prn7Cy78Py1CB23?=
 =?us-ascii?Q?k9W5GfYse+brr4fgnooGiTHF7jZB23f1fI5sDyzIi/xO2RWM0SH+7eroBple?=
 =?us-ascii?Q?GJY5jq5oU/CbapWNs7AdE8g//mTB276nb+1ITYgA+t/XUG7nRMJQYq6bwKi4?=
 =?us-ascii?Q?rr7nzxfCa/fHeXWFymNHEyFb6WCXfjCuQs7Wmwos2j+JIdQrQTY/660J1MOe?=
 =?us-ascii?Q?zECm/vBk3SdBzLu2LHudnTTWCA4OIyh61/NkJBRb8tHU4JAbPnoJn18s1XFu?=
 =?us-ascii?Q?Zxw5ET+Sh41csRPPsrtpsE4u2P0Uv3Od4ZaDdXGQ5UzuAWihcAu2Do2m4iEp?=
 =?us-ascii?Q?JZter/DbWAImYFJGkt+xZeO2Fod3GAJgVRFUnA2xOAaTuzjfe8VM8rIgsLWY?=
 =?us-ascii?Q?6OO4Sp2W3kNtwi6LXpx5e48kHSzjr9C51/5BVK5DA2m/r5uQFa8fCotiS01k?=
 =?us-ascii?Q?f+nK0zZm8uFTYXJYGYB0eIesP/LMAbLRfC6JNsByhjcrm/PsO8IWWFhfY6PV?=
 =?us-ascii?Q?PHh/vmBsDpf+VoQyoUY+1Ush8pEVH+QfQk+5oM6iJmuc5PDY1vSwRfidOZgC?=
 =?us-ascii?Q?sBOHP24eRwZ+ZZ+1p8C3TdZLTXEfVYr//p/wPZRP7uPY71L59ZrGmNJWUCiU?=
 =?us-ascii?Q?N9pwpcCoO1lcqoihI7PXaOOZtCA9csrj6QealDb/Jbe+xbHaL+5D1Rr9a3xB?=
 =?us-ascii?Q?edRstMHxeVLYNFW3TgHCdYhlQ0Yqf8g7KFLpGAOwfCoA82La6ACihICHy+ur?=
 =?us-ascii?Q?cEEiBkCxJbn2IllwsqvqNjUNB1cjVK0jkkjNDFMNDfNrw6HjUKotZTNM0FhT?=
 =?us-ascii?Q?E7CmNCewMuHZmqOhYFC5xabAf1wkNTDsOFNJnTQ7tyCucz+D0TOg15BEnaDH?=
 =?us-ascii?Q?Cfq8tNcxD02VOHtg8t2EyERmb0BACmrELNUUBmvxGEfDo5v5CULELd5OtWko?=
 =?us-ascii?Q?gFqPZt0hfnY/BqdhF/MgpbW8VyUS0fMv4NiRTTgbtnH8+9FHXfjzjb8lFyUM?=
 =?us-ascii?Q?DrQtLx79npORmtrys/jxr12D13M5V3e4XwyGQ+tRoXNYKvklOI7B2uDEtHno?=
 =?us-ascii?Q?cdnZB+/UK12LbAm9uvPPE8+rSdDOBXYr03eHksWBWazGvZzBDam+BhqRU4I1?=
 =?us-ascii?Q?rNNo8zrccWHjS+oatqMI2r4QsqOL354FwSnaRl2p7D6eZ4diIHxgPo1k9g/e?=
 =?us-ascii?Q?Z+AdqtYkhqunmFuVA4VeSvXMglkJwOprLqE/gm+xUzDWpuXwBxyFunm9FT0d?=
 =?us-ascii?Q?EuX8fxRK+mIZ0kODfQHJbIZUPotFMnuXYROBCJ1WbfMSI3KVo7cZdqFEyv7o?=
 =?us-ascii?Q?+SiIBufDygHAuHyINXiG6AQ3bcH7e384GLGWi57dspKGgBQfqXd8+6nR3qzd?=
 =?us-ascii?Q?NSEzo5isDTUYFY51ocw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:32:53.3035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d30fa7-d850-4db5-3e65-08de372fd66a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
Received-SPF: permerror client-ip=52.101.85.7;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Dec 2025 10:24:56 -0500
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

Previously, PCIe Atomic Ops support was only enabled for single
function devices due to potential conflicting capabilities between
functions. This patch enables atomic ops for multifunction devices
by finding the common subset of atomic capabilities supported by
all functions.

The implementation checks all functions on the same slot and
advertises only the atomic operations supported by all of them,
ensuring compatibility across the multifunction device.

Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
---
 hw/vfio/pci.c | 104 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 14bcc725c3..9d1faeabff 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1900,28 +1900,88 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
-static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
 {
-    struct vfio_device_info_cap_pci_atomic_comp *cap;
     g_autofree struct vfio_device_info *info = NULL;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_device_info_cap_pci_atomic_comp *cap;
+    uint32_t mask = 0;
+
+    info = vfio_get_device_info(vdev->vbasedev.fd);
+    if (!info) {
+        return mask;
+    }
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
+    if (!hdr) {
+        return mask;
+    }
+
+    cap = (void *)hdr;
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+    }
+
+    return mask;
+}
+
+/* Returns biggest subset of supported atomic ops of multifunction device */
+static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
+                                                    PCIBus *bus)
+{
+    PCIDevice *func_dev;
+    VFIOPCIDevice *func_vdev;
+    int slot = PCI_SLOT(vdev->pdev.devfn);
+    int target_devfn;
+    uint32_t common_mask = PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+
+    for (int fn = 0; fn < PCI_FUNC_MAX; fn++) {
+        target_devfn = PCI_DEVFN(slot, fn);
+        func_dev = pci_find_device(bus, pci_bus_num(bus), target_devfn);
+        uint32_t func_mask = 0;
+
+        if (!func_dev) {
+            continue;
+        }
+
+        func_vdev = (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_dev),
+                                                            TYPE_VFIO_PCI);
+        if (!func_vdev) {
+            continue;
+        }
+
+        func_mask = vfio_get_atomic_cap(func_vdev);
+
+        common_mask &= func_mask;
+    }
+
+    return common_mask;
+}
+
+static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+{
     PCIBus *bus = pci_get_bus(&vdev->pdev);
     PCIDevice *parent = bus->parent_dev;
-    struct vfio_info_cap_header *hdr;
     uint32_t mask = 0;
     uint8_t *pos;
 
     /*
      * PCIe Atomic Ops completer support is only added automatically for single
      * function devices downstream of a root port supporting DEVCAP2.  Support
-     * is added during realize and, if added, removed during device exit.  The
-     * single function requirement avoids conflicting requirements should a
-     * slot be composed of multiple devices with differing capabilities.
+     * is added during realize and, if added, removed during device exit.
      */
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
-        vdev->pdev.devfn ||
-        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.devfn) {
         return;
     }
 
@@ -1934,25 +1994,15 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
         return;
     }
 
-    info = vfio_get_device_info(vdev->vbasedev.fd);
-    if (!info) {
-        return;
-    }
-
-    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
-    if (!hdr) {
-        return;
-    }
-
-    cap = (void *)hdr;
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
-        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
-        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
-        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Only process the through the root function
+         * We get through here only on function 0,
+         * through check vdev->pdev.devfn
+         */
+        mask = vfio_get_multifunction_atomic_cap(vdev, bus);
+    } else {
+        mask = vfio_get_atomic_cap(vdev);
     }
 
     if (!mask) {
-- 
2.43.0


