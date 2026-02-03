Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6091E8783F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHnt-0003f4-Nv; Tue, 03 Feb 2026 09:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHns-0003eL-TO
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:54:56 -0500
Received: from mail-eastusazon11011069.outbound.protection.outlook.com
 ([52.101.52.69] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHnq-0007AB-Rn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0HsHc3z7NYAEnkRbvTxbSf3Q+EYe+2hxwtJn38Gddb4LTJ/RjBwT/gKYmMhuO2XU++z86SNb4eCREQvjeM7uKvk9h3aLlt2X6hUJ6aSIe42vfNuEQy3O0Q52kbQGB3alSrg9cY6SNhQJCI+R2AROP7Zx8eB6UVAY/0GJ1vF+vEpxHdK9HzPljZIyAUrGwV8J5WADtWqLT/eKiJQFjR4NgcoMFAuou8euWzu9+x85zfu4x+bmA+jbcrde91mbAhTgnB5GR+orJGM8iGW+Of5Tw90+DwtH/pq1vMTrAXDRJOKIdLi0W1UZmYX981eLBtHiqZ+scNgrAub4r6jIXehHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DYz8uIF8zSJmc9MOcXqyeaI8V+0psdE9FSyIub+VA4=;
 b=I0+0R+qkbL8vhXXpcyUX74/Cmw8tpwcjz/y5NuhUXqzvieCb1RQHCuNoEffppFawf8nvY03avKZ5GSvgZeGwZfw/cyFu7LgLnJNkUVMZpVw1RY+LwpRr3tyRz8tCMAa1nhfU8sQqT5zX2Gg/N3e1iuDa8PXmRSxl6GzYKj7vYVtLyuXedm3O5d7QewgnbdbaKA5k/S8lPPpymSDd37hXJMG9/ct+nxquHO3D0ri/8J5r33j2mCNqVsIoJ+NBcXYRHo2H+PqqaE/vBZgHerEcGP41+PX91ympep5OeKb1NKnkSq6NXcV8zBX+Fga/AWkwVF5VIShF2NUY9E8VzWkheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DYz8uIF8zSJmc9MOcXqyeaI8V+0psdE9FSyIub+VA4=;
 b=Eynvo59YqLUgmtVAycpFB6AC7iPBp5zjP392diyKul9o3vlLuFxLDt/gQ7TaGX0Nr9SViZFZLL5HCyKkJyXvLGLXbJZkNbYLRLhMpjjMKLL3hB5F4RsQHojHK+WObaBvsRHw5POkBc5hjkHqtxD0uARKHfUMc5EVe6SAcB5Opy4=
Received: from CH0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:610:119::30)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:49:47 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::70) by CH0PR03CA0388.outlook.office365.com
 (2603:10b6:610:119::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 14:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:49:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:49:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 06:49:45 -0800
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 08:49:44 -0600
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <Nikola.Prica@amd.com>,
 <Dejan.Andjelkovic@amd.com>, Manojlo Pekovic <mpekovic@example.com>, "Manojlo
 Pekovic" <mpekovic@amd.com>
Subject: [PATCH 2/2] vfio/pci: Support multifunction atomic ops capability
Date: Tue, 3 Feb 2026 15:49:39 +0100
Message-ID: <20260203144939.49-3-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260203144939.49-1-manojlo.pekovic@amd.com>
References: <20260203144939.49-1-manojlo.pekovic@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a24b8-9fc4-4e4b-aff1-08de63337952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?54MOAsUJ8UY38lILUaOcV6ZdMj+0rOlKKUBBdcyAhyfKXPlEHd1EUhQ7ZDjb?=
 =?us-ascii?Q?Tg/AsxW3T/QF9XdLlIQFhjbNcMwq9+X8Ua4Pu5WOkR9HgBKJRuHTGpGH/Cxw?=
 =?us-ascii?Q?sV4NwxKHX+BjpOdbgOE9xXzM1xaLLuG+hKjOmrptQ/3P2ERxCWUmvqr4m2h4?=
 =?us-ascii?Q?NvBkwANc0pBHvElWucj1GyfmSr/5vlwFOBrGgkWcFy0TtRcHpKaWV4HUugdY?=
 =?us-ascii?Q?cbBohguhklwXDAuyPMaDjDl37SuEJUICazfwQm/PRcsekwMRszju5H2AUJjE?=
 =?us-ascii?Q?HaSu9C+qoujMVFFz11f7bvhD9WH25rylvNXZo/Pz3rG6y5Ok3c/8qWv1f9B0?=
 =?us-ascii?Q?OTnLuvAgxtXNVAUn7A1/b/rbwj/ikxGy5lFWcUlyVE2WnRzZamqpTgrxVmTG?=
 =?us-ascii?Q?geSFmUo6GcNDcM+bASn6xMdKMe4bmRUuE4csyqLfRCWxargRV/Os4agMXYkY?=
 =?us-ascii?Q?/orZFd7zdotiO4YogNq1yTTbzqua3mCzfrlz60FFvGQUfyRawv6Ix1Y9ZAiX?=
 =?us-ascii?Q?7MhZFYpn8RKTIBblwnWu3k8IyalT3SxBnr1HIgi910gRdDK09X3TrqX4SzHB?=
 =?us-ascii?Q?LafK6v0d6spjYYGHR2CHwiBm/OnTRPGOH2fajTCTgABrxBYFRZiGXjfjkUzt?=
 =?us-ascii?Q?eaNMWX5ygbdGMVXFxs9aPhsUbtuibKPenPOhWrHJaDgqLs+0uTOXudHnUmDn?=
 =?us-ascii?Q?VyrE1JDAJsyB5a+4ilmrHHXUvQ4ytfo8zXGexdJvcS/KkcnWCGP2QXdb8Nxv?=
 =?us-ascii?Q?JYCZs9yqO//MT5WdCYLoGm0ofZEzIxEMgERCOnVZ/qz+YBgWG0zau8z0zqTB?=
 =?us-ascii?Q?MNWLnpM4YjQqKvQGxfSOu+pco8bImY14GGYQCYCfZjf2RXEfaAgMSbKmQk36?=
 =?us-ascii?Q?FuzwwTsKIKAJmwRcOszboTbQGytuAlOb9hc3Sd9MgjUQHzjON5L+9Qm7bO8N?=
 =?us-ascii?Q?/lnlcjoukABHKUJInqkph1nU6DMfAReuIrh5pDVDGPfID+X9jVgCE5JpjqpV?=
 =?us-ascii?Q?hDnP+qNrUaPKMmzA0M+yfsFqwArCBNWdCDndBQT7CeUZyV2yWqDzKdwBkDcR?=
 =?us-ascii?Q?IGxxLng4xhRJHPeRjDRxP23l0NyODQWC7IzKwVPzQ7jqgg+QTUOlp8zofcRX?=
 =?us-ascii?Q?e4T16tASkGPFfBTcQDIY3711NuMgqXRUxPhHHGxbP22YV/91xCtSpkDg6i7E?=
 =?us-ascii?Q?FqIzHCmqgCnSjIVK6nPO2R3s8pSqh95LawPQIwUPwLcLicspLiiTB72U9mNi?=
 =?us-ascii?Q?3oT9qg2H0Q8tl/jj+S3L4W9g4Eor3ryMOXngK+q5J7GsOYaCpXcP29V4jcbw?=
 =?us-ascii?Q?pQdaWBZy9u+iDGlsjHV/ZUYJXmYNKde6LEfF/SZQe2nkj7d9uI0g/n5HBzmB?=
 =?us-ascii?Q?CdK0JJ8Hmh/uJPywE2PSj1uFm7LWFII/Q7lrM2XjydznD8scEjpY6NbmuiNz?=
 =?us-ascii?Q?hWym1f+/IO4TCPE6isakMqJtnTgEEYzmQqiWjvaiop0ojHmPC6Jc9zhHMOUA?=
 =?us-ascii?Q?k3K12EwOeKRsNnUGlftQZ6snjECEC4w0fPDz4Q4a0vdbm4SglzOBxvIY5L4D?=
 =?us-ascii?Q?pqy3IwwjTpIYEZzv0gfVR3x0H3acRNLJ0Ach3vKGb/zcz3ymSPBbXgzxSsrv?=
 =?us-ascii?Q?+o6a8JSgHgXQq3/KYDDRGGLiuhwR7c26/RRoSdwAB2uqnP78kLkQdI9XaKDP?=
 =?us-ascii?Q?W2rUMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PAoxjDfLTFdwLAkrV7FnycucvEnuvaRwslYPRxTaNFxy8Na5pUJDox4kMyL5rrUepsjdyu3wCANoEa5yENBx4xkc94ajsvuublWj0+aCQhAXjc+CFRH39KSGc8CQvZsvTSs5OKN/+ASSsGMbQkreyXlXDaCzMhMz7njEbGYsrO+TX+NwQUgU1rRrFV1tafvCSnQlUkkdyLlDxVKtIsoIvXr+SP4zPIEdHCDPy+nW+Hrfamlk7xor2powkRPqt/ByGlvesKNeUU+WtobCgAspDKabmmrh0SIk5e/NCjFxKi2se+Tq9EUK1jGaUzJplMA/n4A3+aQPJxOtesWfl7QNUbRzljEFWlZLLs9Q35Inf6yKwer+POe47Hav3OAuYMrDqeVzpsVaLKuWDNCuS7F8rdGxZyyzSLfXcVXmlDGGa8OL+memo0qoPIfNsEC2xsXn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:49:46.2604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a24b8-9fc4-4e4b-aff1-08de63337952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
Received-SPF: permerror client-ip=52.101.52.69;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Manojlo Pekovic <mpekovic@example.com>

Extend PCIe Atomic Ops completer support to multifunction vfio-pci
devices by calculating the common subset of atomic capabilities across
all functions.

For multifunction devices, we now:
1. Calculate the intersection of atomic capabilities across all functions
2. Only enable capabilities that ALL functions with atomic support share
3. Functions without atomic support are skipped (not penalized)

During vfio_realize(), other functions in a multifunction device may not
be realized yet, making it impossible to enumerate all functions. We
defer atomic ops configuration to machine_done time for multifunction
devices, ensuring all functions are realized before calculating common
capabilities.

This extends commit c00aac6f14

Signed-off-by: Manojlo Pekovic <mpekovic@amd.com>
---
 hw/vfio/pci.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.h |   1 +
 2 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6a6c8f1807..89f171f431 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1931,6 +1931,67 @@ static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
     return mask;
 }
 
+static void vfio_pci_machine_done(Notifier *notifier, void *data);
+
+/*
+ * This function iterates through all possible functions (0-7)
+ * at the same slot and returns the intersection of their capabilities.
+ *
+ * Returns: Bitmask of atomic capabilities supported by functions on slot
+ *          (PCI_EXP_DEVCAP2_ATOMIC_COMP32/64/128), or 0 if:
+ *          - Mixed device types found (vfio-pci + emulated)
+ *          - No common capabilities exist
+ */
+static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
+                                                    PCIBus *bus)
+{
+    PCIDevice *func_dev;
+    VFIOPCIDevice *func_vdev;
+    int slot = PCI_SLOT(vdev->pdev.devfn);
+    int target_devfn;
+    uint32_t func_cap;
+    uint32_t common_mask = PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+
+    /* Iterate through all possible functions at this slot */
+    for (int fn = 0; fn < PCI_FUNC_MAX; fn++) {
+        target_devfn = PCI_DEVFN(slot, fn);
+        func_dev = pci_find_device(bus, pci_bus_num(bus), target_devfn);
+
+        if (!func_dev) {
+            continue;
+        }
+
+        /*
+         * We can only calculate atomic caps for vfio-pci devices. If we
+         * encounter a mixed multifunction device (e.g., vfio-pci function 0
+         * + emulated e1000 function 1), we cannot safely determine the atomic
+         * capabilities. Taking the conservative approach: disable all atomic
+         * ops for mixed configurations.
+         */
+
+        func_vdev = (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_dev),
+                                                        TYPE_VFIO_PCI);
+        if (!func_vdev) {
+            return 0;
+        }
+
+        /*
+         * A function with no atomic completer support simply cannot
+         * receive and execute atomic operations.
+         * This does NOT mean other functions in the same multifunction
+         * device should be prevented from supporting atomics.
+         */
+        func_cap = vfio_get_atomic_cap(func_vdev);
+        if (func_cap != 0) {
+            common_mask &= func_cap;
+        }
+    }
+
+    return common_mask;
+}
+
 static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
 {
     PCIBus *bus = pci_get_bus(&vdev->pdev);
@@ -1948,8 +2009,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
-        vdev->pdev.devfn ||
-        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.devfn) {
         return;
     }
 
@@ -1962,6 +2022,25 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
         return;
     }
 
+    /*
+     * Single-function: All device info is available now, configure immediately
+     * Multifunction: Other functions may not be realized yet, defer to
+     *                machine_done time when all devices guaranteed to exist
+     */
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Register machine_done notifier if not already registered.
+         * The notifier will be called after all devices are realized, at which
+         * point we can safely enumerate all functions and calculate the common
+         * atomic capabilities.
+         */
+        if (!vdev->machine_done.notify) {
+            vdev->machine_done.notify = vfio_pci_machine_done;
+            qemu_add_machine_init_done_notifier(&vdev->machine_done);
+        }
+        return;  /* Actual work deferred to vfio_pci_machine_done() */
+    }
+
     mask = vfio_get_atomic_cap(vdev);
 
     if (!mask) {
@@ -1972,6 +2051,51 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     vdev->clear_parent_atomics_on_exit = true;
 }
 
+/*
+ * Called at machine_done time, after ALL devices are realized
+ * but before the VM starts running.
+ *
+ * For multifunction devices, we need to calculate atomic capabilities
+ * across all functions. During realize of function 0, the other functions
+ * (1-7) may not exist yet. By deferring to machine_done time, we ensure
+ * all functions are realized and can be safely enumerated.
+ */
+static void vfio_pci_machine_done(Notifier *notifier, void *data)
+{
+    VFIOPCIDevice *vdev = container_of(notifier, VFIOPCIDevice, machine_done);
+    PCIBus *bus = pci_get_bus(&vdev->pdev);
+    PCIDevice *parent = pci_bridge_get_device(bus);
+    uint32_t mask;
+    uint8_t *pos;
+
+    /*
+     * Sanity checks: Should always pass since vfio_pci_enable_rp_atomics()
+     * already validated these conditions before registering this notifier.
+     */
+    if (!parent || !parent->exp.exp_cap) {
+        return;
+    }
+
+    pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
+
+    /* Abort if there'a already an Atomic Ops configuration on the root port */
+
+    if (pci_get_long(pos) & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                             PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                             PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
+        return;
+    }
+
+    mask = vfio_get_multifunction_atomic_cap(vdev, bus);
+
+    if (!mask) {
+        return;
+    }
+
+    pci_long_test_and_set_mask(pos, mask);
+    vdev->clear_parent_atomics_on_exit = true;
+}
+
 static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
 {
     if (vdev->clear_parent_atomics_on_exit) {
@@ -3281,6 +3405,16 @@ static void vfio_exitfn(PCIDevice *pdev)
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    /*
+     * Remove machine_done notifier if it was registered.
+     * This happens for multifunction devices where function 0 registered
+     * a notifier to defer atomic ops configuration to machine_done time.
+     */
+    if (vdev->machine_done.notify) {
+        qemu_remove_machine_init_done_notifier(&vdev->machine_done);
+        vdev->machine_done.notify = NULL;
+    }
+
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ad090a229..9182ab0053 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -180,6 +180,7 @@ struct VFIOPCIDevice {
     bool skip_vsc_check;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
+    Notifier machine_done;
 };
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
-- 
2.43.0


