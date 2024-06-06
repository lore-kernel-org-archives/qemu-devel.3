Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE645C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFALo-0007OI-6A; Thu, 06 Jun 2024 06:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sFALm-0007Lp-4g
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:28:06 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com
 ([40.107.92.44] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sFALj-0000WU-LH
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4VpXeZf7ZfcQuFYK2fSQb1cdAhFWttUwNf57vtEdW8K+u1jbb+mjYYFiQ98Y3EJBbgnx4cXUQSDwOgbOmMJuE338nyu4/55GeLMlC/j6oDIFuVDL3cknAhiijYKHw/30xeyeNnEZbvpng5kN+weDtDtPo+QReexRwfCk8kEopEd7SrBS2Jtva5wEAjTjTQpSAzBrzzYDWro4KaAkIQpj3kTYcRgFnNoPTQQaMQ/bQLndmx/6UjdkbxhjWUOd1PSz55aRlonawAVIQGfPHAtL9hFQ3xgOFfiKiFYyiHPDw10HDFkvDqgqCLylmae5KTRoxazMPInS0lZpFb7aYnSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUGbHRjWycdkLV/D8WwsPbHacKHp3+1FIaxr7WW2hD0=;
 b=c1j+7XI4G4WwkWy2/7xo+jr8t2z2kgPxvKoTrm7+JNoitk5e+YcbafN2lVWBQVOVWKbp7PMJnAwQ07AvhoAQOs3C0W4hQ4way1D2In8LxysfG5jv4Z7jT03pbLf26qPRAGmxCmOEqq+JMAWpFdmaNr2Y6EWl2bovDig6lBYE2Bvr0n+7vJGOypJix8cI+G3yxXD9IRaNSPwaVq3tyH5pleVnpjdHo3tsZ5ez4Azs5aivJeCZHZ/dtGiAp/bKd1uRtXDBZF1IyIbSNvgYGH5jq3fvM4w6h9Pdls0i1L+Y8fDi86Vgj3UYPjghwEWYD/5AHRNF7gnRnlCZlQ2rea4Zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUGbHRjWycdkLV/D8WwsPbHacKHp3+1FIaxr7WW2hD0=;
 b=UHVVL8t8kAq7y97+SgymjKeyqcAxEKLK8pViYhuIZ5Ws2Wq1t9UXlnZx9szmzKSxyhX7Cb3/izYNXspOzxhf2ay71bkNDHxl32HL6mNft8HKhUfNKs0PjE6KS4YEwtZwmPNZ8EVuqKZL3yVlY2ntj++mRPuSF2ctHfEtJGkk1i0=
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 10:22:57 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::55) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.19 via Frontend
 Transport; Thu, 6 Jun 2024 10:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 10:22:56 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 05:22:54 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: <qemu-devel@nongnu.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [PATCH v11 2/2] virtio-pci: implement No_Soft_Reset bit
Date: Thu, 6 Jun 2024 18:22:05 +0800
Message-ID: <20240606102205.114671-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606102205.114671-1-Jiqian.Chen@amd.com>
References: <20240606102205.114671-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 58640988-28e7-4e75-be13-08dc8612a24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R06OZc/uoZOGvLj8SdAATE3LbfGbkhWyq/Bp7OH6pNmgGuchhfhIn4cegptJ?=
 =?us-ascii?Q?TSiE2So1uAHeBHopfvwnnufsU8BPJiFNy2nFEWcDL/wpqZvEbHal6m4ecrkm?=
 =?us-ascii?Q?MtQmglhcC0TJS331LzMkfPNuOA4vlKVUtYUCmWo37bVKQc2wv2rJnnMl15pV?=
 =?us-ascii?Q?g1Z6yx4W2Pauhf+HZugxOlNUQ774suJa0rcRi7Ux23XSjaS2Mudyc09KXvQ4?=
 =?us-ascii?Q?VxM0+QTOXM3PLutiUnnWMyryOjU7V904E6jF8duNqX+LJJMyr4yW+PzfNmYv?=
 =?us-ascii?Q?Fod7oc87iAFFABzcs5C+OYva1T1y0lNrAYBsoDPr3HM1D/12RfOiOL6FzYha?=
 =?us-ascii?Q?RPxZaJkpxRPEUMxrM7YARABDDHnesVEp0VeJ90cAqMe63dibjai0HDhJjCVa?=
 =?us-ascii?Q?uKDe0YbqObgci/OhPqJWv8RUMwBGyi57PciE8M1ZNP84gOV1kfApsiRRXaX5?=
 =?us-ascii?Q?jjzIpqsEGFsVlRCG62YgDRyjkf8rwHQgvdXP9+lC8YbOHPGNaAp14TUQfWZv?=
 =?us-ascii?Q?2ECqXnTMI77pEqPZ06jH7u5ACMqEpxDYgh3ffKtrhLnmV9AOq+xJzp3A3Vf3?=
 =?us-ascii?Q?KZ3pGAlXXdF27ScDa00k/q7XlSb88zXDm3+ls+RK+H2dj/eLWKf+vSsqw4dO?=
 =?us-ascii?Q?TvYKard95O4zvTl5ns9Pwqi7dN8iH/N2D/1g7m91o0lHPhkJEX5vUfndEnkH?=
 =?us-ascii?Q?QHLbQt+WVlSfqSBFbgQwO3NYBWxzDOdJEnVRcwo/stcKhsWgzzMaoSru88ve?=
 =?us-ascii?Q?B6Ybafc5vPbHl6oMAuf7AcUfgSZGzP2rQgnL8o2EjIabkooqShEWgfBblEP0?=
 =?us-ascii?Q?TmWHrGZMJwoYfGs4+U48K7eIIsSzXV6jKtIuQCmAYfp1yvnTAFxJ39pT2+/Q?=
 =?us-ascii?Q?EjXVULkEWKa2VLmdoLErGAGcwuWfXFAV0NSJvh4OFtVPXfOW0ic+OJVu/8FU?=
 =?us-ascii?Q?L4GskqtfxeEAYK3bKx0Whm/86cdzYCZhVlrsjrgfbPSQG/92cdj9LpWdHLsd?=
 =?us-ascii?Q?PqzapNBQAzoIOkZveDMG1GFyKyEf9MpivDO8WcgKtsmeIYto6vFpJRP6IyMr?=
 =?us-ascii?Q?xbqHWjW0KHQLmC9ybpyyXnvEvCVeKkEVQC60s7NgHKoturh4ON/t50PLVhC4?=
 =?us-ascii?Q?Cbql6OcvwBYEQBYhQAf/dXaZ9c+RfUY5tLzjPZrJmiOQENYn58/LkDdeRp/J?=
 =?us-ascii?Q?vVfZu/hzngtyZetvMceDp9L7e0p3v3dsReYi3Xv2otmW/kjayixkvPJD7sEF?=
 =?us-ascii?Q?wUz1LbnN2q8fW94fvDTQva/iNACv3ylpsiZS6UkjhJRP+mkDvLIGrSMujIkD?=
 =?us-ascii?Q?E+BlxBCNW6O+Y4n70VZOB5D6d1u4kdnd/6AbN90i3sgf6TjUByQdus4G8Gb2?=
 =?us-ascii?Q?RDcy+IrgziwtCVFDiIhbZ1AAwXRqr6idU7T5ARE6gMhI9SrWMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:22:56.8858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58640988-28e7-4e75-be13-08dc8612a24a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
Received-SPF: permerror client-ip=40.107.92.44;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/core/machine.c              |  1 +
 hw/virtio/virtio-pci.c         | 29 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-pci.h |  5 +++++
 3 files changed, 35 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 77a356f232f5..b6af94edcd0a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,6 +36,7 @@
 GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"vfio-pci", "skip-vsc-check", "false" },
+    { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1b63bcb3f15c..c881f853253c 100644
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
@@ -2292,11 +2297,33 @@ static void virtio_pci_reset(DeviceState *qdev)
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
 
+    if (virtio_pci_no_soft_reset(dev)) {
+        return;
+    }
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
@@ -2336,6 +2363,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
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


