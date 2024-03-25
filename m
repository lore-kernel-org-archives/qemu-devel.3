Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9075CD11BF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 07:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roeVm-0007FN-IQ; Mon, 25 Mar 2024 03:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1roeVk-0007FA-SR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 03:12:48 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com
 ([40.107.243.50] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1roeVi-0007Mj-V3
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 03:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/Q/q95OXLGxXz5HzPYPHKVKSf/9DN/gbWwldMGb8HUyEHLvUc59/JzCDmqJVD4QQY9thfMLYBJu5NyDHjvOin0RnNMUr4mdE92wDPmAsqgmojR+ERS2C7tIIuYJea1zhznNEj8ljlC2W5AbLBpONp8ECYxvZXNJi6Kj9dMMpo9OaCy6rGghlQMMOu9sIpXsf9nMlXFgifLa54ihklmtIYuUJJPZ5tWHmCCITmYSQ/EVOoyO0X9UmJGNfJdFU9ryumUX75R/FyAAZNWJuYzU8KEUZFpcndZqjtH7bC4tDgXt76/cboDpJv6lQzjX0/CdveoH+23CyMtJBmUkqc0UQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVxQUM973S4wOXqAzVBi7SSJo1ZveGTrb7vadWXx2ig=;
 b=dkCe36pnWlwwKEi6NvMAkmHoA/uJ8vsSwNW9Yv7XYmjTwJDiEJ3TDh8FrXm6y9hQ06+9flDhk2xXszqvJJWD4NVEf5QrlLua3GIly7ups9QVzbnZi6B3j1xWryG4+YRhT5YtqQ5sxCTy/+ow3Rl6ge5NShkaw6Z7j+hAHb91ebu3lPcRIYtRYH4u6rJUoUMW7VN7ThQc0DE+rjraDhQBHOzKKdhz7L3eZaefpRPSUBIEcUs2aNsFWKinWM8inUPk63jjCOU/1KUK/WGWekMIndTiY9lVUp7XuAolJyCjIYZFQ5T6bpm29yNR4ZXi30YXxNhtE+ICONEH/d/iP+19mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVxQUM973S4wOXqAzVBi7SSJo1ZveGTrb7vadWXx2ig=;
 b=FnC4czfzB7rG4wQvnjmrCAgGtoQNCyanuwbsJxIFcSf5Lx1msblEND69Las4jao0E5yp6IlWhD7HSiKRSFx/wFI1sV3Xo4Bdl67yv2qE3gxH7ZVOzW2FHqd2TlgsH8G3WPwwlAnEvmHYqagXi9iq+oHuos99t7+2BdtKGjo4Kic=
Received: from CH0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:76::33)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:07:41 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::69) by CH0PR04CA0028.outlook.office365.com
 (2603:10b6:610:76::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Mon, 25 Mar 2024 07:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 07:07:41 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:07:39 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v7 1/1] virtio-pci: implement No_Soft_Reset bit
Date: Mon, 25 Mar 2024 15:07:24 +0800
Message-ID: <20240325070724.574508-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325070724.574508-1-Jiqian.Chen@amd.com>
References: <20240325070724.574508-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fbb072-c64a-46ab-434e-08dc4c9a4336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMwnoDhT1SOn3x+9wd1lnJZFJAvpfhYeq2QNs8EW9CUVkeusPnHTkGORnfrk1kiUMntuAUbPK5J6ZJ5Wi6EGu5KakbdgcILhyRX8GKy/Urx2d6Jtnu6/4blmg7G7pC6P+2qODx/c9yXfV2TzAvWgt3/Mruw8+hJfs9Ckp6GKFN4WAUOwKmPbtqUiVVeZ/W3/VvQaw9Ru4zlyTZrJ/HqeuaT8OhEuhI7i5HeSDxTgUmOgiz4WVpHtgm4Kdci0ZbHE/syBt47EbPjTblEnY398ot6TKKWApiFbTBgSHNOC4FldJ7ecumqngioRNLmADsXZEgBdZx8xunz4dORGPdzH7Zu3mTNs/Goy78h5To9sIYFbu1IaLrOM3e2KRpHBTdcG9OnlcFtoaNSEakC8zBj23++2TR5RylVShG98wdr0y2GCfApCr9j2fzCcdR4GQ49HuROXygMosBmuJRsF3dXK5rL/idRh3qZbBdL7clpwkALKQvL/6rRhH7ckTRo5vYsbCEPtQ4Egx6FCb4h5RJlOQccKRUjOHw3nnphjJBqg+m2zSMIjgS0LCDlTwg6N/G7TrkLqZl9Y4KiJZHtqvt6vg+chv1yIJ57ln2nM6pva4+A+0odgdA7TFe3Ikg7lJhAYNeEVv70K31lsca9ubVgnCgv/KMo0dlA5YYAsDTXW19RGUwCSmGdR2/PdRbIuAEEQkZfnixZyDQwKsgky1hhveGLvEA+k8dPNsNknBpmo/waL8P0nXVL8jywe1VEBwK+o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:07:41.5446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fbb072-c64a-46ab-434e-08dc4c9a4336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
Received-SPF: permerror client-ip=40.107.243.50;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

In current code, when guest does S3, virtio devices are reset due to
the bit No_Soft_Reset is not set. After resetting, the display resources
of virtio-gpu are destroyed, then the display can't come back and only
show blank after resuming.

Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
this bit, if this bit is set, the devices resetting will not be done, and
then the display can work after resuming.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c         | 38 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c68..daafda315f8c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2197,6 +2197,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
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
@@ -2259,18 +2264,47 @@ static void virtio_pci_reset(DeviceState *qdev)
     }
 }
 
+static bool device_no_need_reset(PCIDevice *dev)
+{
+    if (pci_is_express(dev)) {
+        uint16_t pmcsr;
+
+        pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+        /*
+         * When No_Soft_Reset bit is set and the device
+         * is in D3hot state, don't reset device
+         */
+        if ((pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
+            (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void virtio_pci_bus_reset_hold(Object *obj)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
 
+    if (device_no_need_reset(dev)) {
+        return;
+    }
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
+        uint16_t val = 0;
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
+        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
+            val |= PCI_PM_CTRL_NO_SOFT_RESET;
+        }
+        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, val);
     }
 }
 
@@ -2297,6 +2331,8 @@ static Property virtio_pci_properties[] = {
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


