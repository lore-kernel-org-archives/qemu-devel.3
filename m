Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C73EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Fx-0003QJ-8O; Wed, 15 May 2024 03:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s79Fv-0003Pp-9M
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:40:55 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com
 ([40.107.237.89] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s79Ft-0003PY-4Q
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkzjOVuUVi8KQoZ9u8aHXLXoKvPSYKYN74u4wbH3EvGB8e2j9tOi0UMWXRL5FGJCdx7xw6A0MWS6/u83p7BXLK9Mj6oHI/7PWCKfUYIKaI7S0SvnzOX95LQHs+sMWycpNwhvZy4OAQqgry55YTNvHEwH2zQ+lEuMVFiO29mraiH87ROO9Lk5+R24/MLH/AaRFFGWq5Tgr+Qfp+Itc4nfpOnqYFd+S/TV56Z0J4PnoxO0kJBvzIoG0fu4qf/th0xBpcokIuV0g3XsYJXzM8z2XNJ+9ne7imkge4gp9UdcFKpLvcK3JJulllgPnHvNEmgqWEuR7nbq+XCXmUP2xoo8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNNRj8VumE8Ib57b2DuiXymZz/so4WP9K07/AGpvvY4=;
 b=O7joC0+m7YsXv9MjjEceho4m+LnI5IwPzz06uxS0gZhBYZtE6hDWHjgXp4vVjfHAwa1KzjuxebWFrUwoNGXfnXLztu2Q0QePGzC4BTVPxwRbHufHcR4rhdFGfl+sWBO37vNhvJmyBVh0+9VdS09a0V0oyYifsZ4JfKjwWesjJNeAPSr3V+WIyPC8whD9XgtECa2kTMrEjmOcKC80IgHS/HGi7TU5L7uoEzfLlf6yKtSbguw99U97IW3Xd51slNfADNWeq59mnZVsDCMjn9P0PypXD4zZq5QJG5lbMYXvxcnsbHeDi8yeWHefMGM90MIu4Cy/wM1VTnb/lV6a7GlQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNNRj8VumE8Ib57b2DuiXymZz/so4WP9K07/AGpvvY4=;
 b=m9YrfGYsMSI4K/ulviN/tBmboo44/d5kiiYnj9RNJUjyqC/s7u6oZOWVxFfH7WUMKiGnFMN7YvhUOQRDohs7Aql58jivygB9s7CMCgFDYFPonKunFukwYstQPkVg6Rx5ouwYkfYrbV4Fdia/0Wsu/jY0Y58wDYJf74N8dhAoLsk=
Received: from MN2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:208:134::38)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:35:47 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::26) by MN2PR16CA0025.outlook.office365.com
 (2603:10b6:208:134::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25 via Frontend
 Transport; Wed, 15 May 2024 07:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 15 May 2024 07:35:47 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 02:35:45 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [PATCH v10 2/2] virtio-pci: implement No_Soft_Reset bit
Date: Wed, 15 May 2024 15:35:26 +0800
Message-ID: <20240515073526.17297-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515073526.17297-1-Jiqian.Chen@amd.com>
References: <20240515073526.17297-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6209e5d6-d7ae-4b3e-06f0-08dc74b1a309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M2MbbkII8snKUMXukIaLw3w1VVs0NZIn65+NZRK8kT2jdBRjw4EUB1wrJMmr?=
 =?us-ascii?Q?YgVccNZeX0umQpRSodR/xLN4CdCmtx8hbVkLlPR1ZmnF2lXKT5BEYnQS+NOb?=
 =?us-ascii?Q?aKenvKVWvEeqae/cdHDEKDGXkjowYbmjpFjyZ/bmviseQQPZbz9a5ijeND1e?=
 =?us-ascii?Q?HWaBtemVQ4ZBLbcjQLWH3TiDwlBaR6UiwH176IzuO2CXdzBkrweYZULA6465?=
 =?us-ascii?Q?3VCuqswVbXEpQv+mb0bWt4jv+3s20S2CyKaSJyC67noq2qUKcv/J/yEoTxOE?=
 =?us-ascii?Q?JggLML1FOxzQIvUKYGysdSU5OorptDtJ3wrFqIKyGfq1H3fVqxgLG9SoP89F?=
 =?us-ascii?Q?2i7N39AdqG6X+m7P0Qp2UMY6wLBNXUDCcObqGq+IiNrOMGOSUB98xlp6hz3l?=
 =?us-ascii?Q?kT/IvDndc6Wz8NcgpIvkrSRRORdXk/5ZxfNr66OHHLS/jPTjPc1oYlLkI35n?=
 =?us-ascii?Q?Qt4kUdyL16psWoexxK9gFUVmmbrdAXgtPhJG2l5aZPfeeuRBks3M68mY6aO4?=
 =?us-ascii?Q?sjQ7AcIBQurn8wmiV1K0o8pAfNqBo753bzSnYpA+y8e+Z/GWBgULAuhNCCR2?=
 =?us-ascii?Q?BoFsVrc98sEhJfIBiOAiqJAE7+5m8zF43iIAuKD2Tm7LKV6Kk15MGMSWaRbj?=
 =?us-ascii?Q?J56iQ0ZbObonwrfqb36m7B6p8qCnoiksuPvUALB5Mnvb8R6Yc14t8SrYYmZr?=
 =?us-ascii?Q?TXAjLjjqeKFSY4twwduZDUfxY7aI+pHiWGl2XHyQAfBYzE8dhPjCGCCQNEZn?=
 =?us-ascii?Q?m3MkEHbTjw1qsrb7b+vV0dKrMLaROX+wBMHHNxTYunD5TMCyoJ/aByt4dDZE?=
 =?us-ascii?Q?w/HB64GCgPfjd5aKvTbjgbi4GS9PjWTyNQZKEoQshLLeM3u5GLtD1p/Mwesl?=
 =?us-ascii?Q?mhEp+3jtTLoC6a/xWjKEhBkITxnxe6TTllCQR4dg+PIoi0kCUNQ9T5dF/PGs?=
 =?us-ascii?Q?+H3gIsEw/MFy+1yx8iZad1j/Oe4JBGk5I80kIqlfQSif+3mbpp8w7TmcOkPc?=
 =?us-ascii?Q?IkguSGh/P7YOwb/y3JRJrCCAfeEenIuPeUaeZXVzuyJ5Y9M5JEY9yDWOmcDv?=
 =?us-ascii?Q?fHcxWGkLMCeQkaRSJAyRPNFdcqPjA/7ScoBo0QLj+Kog+wMbPCDUi9ZLtnif?=
 =?us-ascii?Q?JDq0/4nObuFM8zL+O3UIm0m8bWsMOySjzejbtqOssybhOf0qzIkGG9dhz7BO?=
 =?us-ascii?Q?WaSkHyQrfDVimKq4kLRWIdoXiJWkl6rzaNEvlbANenrKQi1Be00emaYTAlNd?=
 =?us-ascii?Q?8fHH19m2NFAkGCcIfLEkaY3x5AqDX2n3tDak6YabOP9ZlkQ2nyUlVLYk86kh?=
 =?us-ascii?Q?wFLu4/msXrYjjoM642s2YBVLWIx5SM5Dejy0R6e2FbDg0kQUpYfmTy53IQ+B?=
 =?us-ascii?Q?6S8SDhjTrcCxSpalE5OQAgzkIA9j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 07:35:47.2610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6209e5d6-d7ae-4b3e-06f0-08dc74b1a309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
Received-SPF: permerror client-ip=40.107.237.89;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In current code, when guest does S3, virtio-gpu are reset due to the
bit No_Soft_Reset is not set. After resetting, the display resources
of virtio-gpu are destroyed, then the display can't come back and only
show blank after resuming.

Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
this bit, if this bit is set, the devices resetting will not be done, and
then the display can work after resuming.

No_Soft_Reset bit is implemented for all virtio devices, and was tested
only on virtio-gpu device. Set it false by default for safety.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c         | 37 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 42 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1b63bcb3f15c..3052528c0730 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2230,6 +2230,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             pcie_cap_lnkctl_init(pci_dev);
         }
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
+            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
+                         PCI_PM_CTRL_NO_SOFT_RESET);
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
             /* Init Power Management Control Register */
             pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
@@ -2292,11 +2297,37 @@ static void virtio_pci_reset(DeviceState *qdev)
     }
 }
 
+static bool virtio_pci_no_soft_reset(PCIDevice *dev)
+{
+    uint16_t pmcsr;
+
+    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
+        return false;
+    }
+
+    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+
+    /*
+     * When No_Soft_Reset bit is set and the device
+     * is in D3hot state, don't reset device
+     */
+    return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
+           (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3;
+}
+
 static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
 
+    /*
+     * Note that: a proposal to add SUSPEND bit is being discussed,
+     * may need to consider the state of SUSPEND bit in future
+     */
+    if (virtio_pci_no_soft_reset(dev)) {
+        return;
+    }
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
@@ -2336,6 +2367,12 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    /*
+     * For safety, set this false by default, if change it to true,
+     * need to consider compatible for old machine
+     */
+    DEFINE_PROP_BIT("pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 59d88018c16a..9e67ba38c748 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -43,6 +43,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
+    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -79,6 +80,10 @@ enum {
 /* Init Power Management */
 #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
 
+/* Init The No_Soft_Reset bit of Power Management */
+#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
+  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
+
 /* Init Function Level Reset capability */
 #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
 
-- 
2.34.1


