Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC5E87843
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIVc-000288-Lz; Tue, 03 Feb 2026 10:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIVa-00027W-Bf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:40:06 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIVY-0006QH-Ep
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:40:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNyHxiwJwn5aS6jTIangJeFZplewXcPNZ2hPZ9mocugHlP9gpsg5pqxL5mDN2dttY2hompTmV9aM94q8w/L4KbyAwPsYk46OoGNKcG/ni3ztTMpeSs572EYUNNK2AyLwQJGcnOkXXFV/0XAGAvybK9lakFt5AxGw/ifF8ou3igVvgAN9mz0y0+gzaCoSiZWpEC73ze9bv6kSwkEHhodzly/zbo+4hrt7MakCeYgjfbty+hrsPT3eXxYHQCgDCAKVZl3inhm+80v07IgVyTz+xgZcOSBH03xO+tvpGN16fJ3fscOMXzXpDNJ6Bx8lavQuZvHt2Eb+Li6Qcne5xBABbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK0uj5uL5hCVEIoa/i282agID3NaS0NERB4FS9Oh6gw=;
 b=dBuE+odAa8d09i7moC480li3fnfGkafE5mH6mxTi5IldKTHuGNcez7nnzIGm9+y1W4COwvrJlwyiHm2pjuCebu4koy/D89BHwmtSFG1hpTiRIoblxdPuR9fP0vwqwIOaC2ni6Vwjtj6c2HDKcG6QVyr2npm0+AceF4FFgxY2rxsdrowaKuAiApk0+Bb4XxcmExl3eMipZVfq2/sfvIomXfcnkQN4n9U2n+dqbtZcuh7LI3qwETWI4f+HjQd65Bca2W5mkB0nJc5cNqUhkkzkfn1pq54pIzgrdJRRI+fS81IffONW3MRWDX++sPqZyP2QxFlTQlzfDvJNRbmjlUdIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK0uj5uL5hCVEIoa/i282agID3NaS0NERB4FS9Oh6gw=;
 b=m7mEVgJYFRb/YP1CceVmxLPzI3ieFZyz/2jXR4I8BJPXNG9k0t4Qk2XV9gdin2KHdnSnhHluf1HTx3KcRg2e1UD2HnvB3cRT7q3/p1aWlgxp5ccRBhHytd8KIq1kKM22f7raUenscd04K/T26GJhB8xN9Zqmui/15o8BtiGCb0I=
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:39:58 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::1d) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 15:39:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:39:57 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:39:56 -0800
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <mpekovic@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] vfio/pci: Support multifunction atomic ops capability
Date: Tue, 3 Feb 2026 16:39:52 +0100
Message-ID: <20260203153952.1337-3-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260203153952.1337-1-manojlo.pekovic@amd.com>
References: <20260203153952.1337-1-manojlo.pekovic@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ed89b0-050d-44cf-6872-08de633a7c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vlYPub2oXarUps2/OjX5NS/uGKF1dqg2pVwMTNBEwSVyQGp4lAd5Ax+VmRVP?=
 =?us-ascii?Q?CgmUzL7L8ypIUNBhv6M0bfISYgHxUuTzacdffJJjlPM7cOItJq0CVE88HfRs?=
 =?us-ascii?Q?vAOKEkZ5dan2JKMFR3oHYOLMoczyFDgy3al1VQREvhaq026sGlAiyjq5x7es?=
 =?us-ascii?Q?8JuB2os04K86hBbwwTX+Urbih4s9yaluelL7/OYxxNE/R97JWNN3cSXtuPf5?=
 =?us-ascii?Q?u/egVLPAw3qJxzBSFYGMSFchnw/Hjjyc3c7FIg0UCsDxGdDFEn75P6QaBifC?=
 =?us-ascii?Q?YYvfk3XXmnVyFmj0qPVbz3w8AA0OyFrMECZH3OOI2huLqMmahuWHpzHxMgRF?=
 =?us-ascii?Q?NR1LDQ4I2ulDkuOBkjgJje5eRJK/nO0x5eMYrL6/ycybtxNpM2BFN+2+5gXB?=
 =?us-ascii?Q?OMfrReLbmNRi2sbR9MFYPBa4K68LLvuJ8M1xj9H2UjPyb2mpN4C9gbzogO8P?=
 =?us-ascii?Q?52xt2OpsAK+KO2+nskAH/7XaSfLnnZc4Ve8bWksq/PKsS0l6SvTFnXGULXGq?=
 =?us-ascii?Q?K630ecq1uxGGUaWfHNI0QgdbTz6lHfMXu4gob2iD0R9jnnkJrb3ETkyAs6LN?=
 =?us-ascii?Q?HOU05eVElLAZGjmwrsrPsIoVXBzJlZuJK9cO8MfMo+2uT+r6mnpckloiSiv2?=
 =?us-ascii?Q?BbWIbUUfTurUZoZiiXFJc5snliJEbHVZs73sfGKEN2tMYv9YZHbwxHEFVscK?=
 =?us-ascii?Q?wbWmB+s9YGMAbfcLrhTi1WESkJo2Cb8vf5x1q5MF3wg0+Bb/hbpfOCDfsNEX?=
 =?us-ascii?Q?8b7egaaRepva3UBmB+xD98u1+CZGFur3pIhilVR6AAynJnbWRcYC6gnJ84Kt?=
 =?us-ascii?Q?znPrGQZgaadyIIvWt+DShNfT3mlBeLJiKwQrlOHQPd3Yb1/Nu+kwvTe4VyX7?=
 =?us-ascii?Q?KDAgACtMfRCM2CWw8ajsLbR64QFmi4GsTUfbHZBd2bbYcZULc9KTbuhB+MtB?=
 =?us-ascii?Q?1u6GUwK7WKItwHL+C9157pQkHR1feAmJ5LvcChaSeQgBIG2kuGCwBE78nR8m?=
 =?us-ascii?Q?xk7sTA+re5hi0xI00UT+llXh8zRSl05q1pulsK/LDwjaYViJ8bNPvRXByJZC?=
 =?us-ascii?Q?b2APqwWPGJ6svBg1Y3qA7vRDh5Es9eNzhkSbeMaX4tnNFliNGRwWkaewyf1V?=
 =?us-ascii?Q?vdZvUyLF5bm7zbO2OilIpguOYYLWnyLvykA2Zy1Gxb2dhT3X4PKSk+7HFSlH?=
 =?us-ascii?Q?x2xgdHTb2b8a5JdC7lWpeNdjYRBd6sog1lcEq8M9nHqYz/UGNF7jDkPf/GwV?=
 =?us-ascii?Q?mDlIFYvCv5xYd3xRrfxe7iII7wwENv8LJP7NyQn1btBLqToVmsSQEn5ZFo5i?=
 =?us-ascii?Q?Ri1gkyBjTLDkPMuSVV8mb/skYTH+j3y9DEM+o3Yvoa6ZD4qIFcP/UwEcbJY1?=
 =?us-ascii?Q?KTZ/lKzSEA0B5oJzx1wVG9S/crHkEuI56Rl2HqW1A+WN2+rKXU9F8B2DtkvJ?=
 =?us-ascii?Q?oF73xceEy9j3kJuNAtqZHcVE9W+vhfLy0vh6aRZ5YE4iSnKxfr1kuqZzVl8Q?=
 =?us-ascii?Q?JSc7ZTID3sP2BTz1pFLUsOhaPs3zsHVacnZ0BFbnxloEbAgQeBa6VhZxPz+R?=
 =?us-ascii?Q?wMpFa8SVbmONiEUu340yzYbThU0daR4pcv8WFIQ+5hr9qRCIhLMF+mI7JFWk?=
 =?us-ascii?Q?tubBIz15hsqjXTsLzi+hqV1h8QSa7ETTELydjhfy6tCBK3BjCNZyBX+PMfrk?=
 =?us-ascii?Q?rEzUDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cBxBoDVIukkBXJlugvZYyv5diKRrkQx+snztHOvLxeKF2HmsxsfHqzGLnpN0zkD5jVJEcc+QOkTgUqQeskzB5tCA7OuRzj0Cj8i08cgrgTfry0wo8mdLHjaw4Isg9UorikRNL9X0YKuzKUIcZNKTE3xSEiEbZrYIQ617bnpCYYxCw5VOsBGB5XmQccS/MnOoU/WfxrigeL+AC6ylRDKIK0GVHVIJakSwnUzDSoUmqeaDfMpD+nfI79SdPd0rhi3OvxaPqcEMOJKQM+lhAjRQMZuUiYtZFtCuL2Ih6/0S3hq7OacVPWUXcUsJnsxi7HpSE90Ty8fbgOovViiFpZqAstC+pQ5lOXi+hd8ZhtJtfJXVE9jPmLk2b9mnnQSIZtTKmB08m+LWnoE95g4ydWt8n4KdO6onAERfwPdkuXz75/gboC/zydiQq7UPQF2Wj9yn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:39:57.8404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ed89b0-050d-44cf-6872-08de633a7c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

From: Manojlo Pekovic <mpekovic@amd.com>

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


