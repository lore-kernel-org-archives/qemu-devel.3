Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C06C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnAc-0003i4-Vq; Thu, 28 Mar 2024 06:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpnAa-0003hZ-HQ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:39:40 -0400
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:240a::601]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpnAY-0002Kj-Bo
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVbAHwh2Ot0APgFR4b2TiaQW4AnSZ9aJp080rwoAAbQ+8pRyNUaZGq6lCYP99QU4T52+OuEyd6mr7BJCVrr/lsr9DG4pUT6joLjfwCEcJLN4EvUXhhKn0VoxR0r8LrfXevZRwvozvZi+gE/GPB18BI2XZrUxUdJAoH35m1epzJ8PteLgv52cknF1dbyEsTiCQwpdlojRR3baHlcBP4Oq2iVu176auBicQJZNqZQlyYW6+tZU4+5A34SmqTVHYj3B/QjtugxoO7GMUxJJ+vvWxZCtMVfXQmY1KcdrAidPHxO8ppcISFcVfx3K0saCEQbUQhFtKbIKFdbZGUlF2v7PsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTJnvxqnDtYWImFhrK8eKH+qU8mENwX3PYW/yDC6WX4=;
 b=kBFh5LpKdyMQV8r/qeIt91VodwWYX82Me8eFdPbwh4t3idiuIguizIr5KLofmAgz2lWHOCkjAvo6fQBzAJS3jp1P9qIASYhtAEvQvb8cP8ukX/p6hplLIj6vUhP9Ge4hmJiFND/3LoMyd9eU51/Uc9Cg30HTNG6jPg7CH+gGemjHBwm+WN3oWLbmdrQPesiDy9VqfvOJCR2AHmhdhOqK/qHQAfNV79ZADHxItKkvsPHYny1pJ+h1zUC9/rHf2LSf7XpvJ0i0OrNwWyJzwa4ny+awd8Or1S/I9NAg3OlHnSTSUrIaxDe22TlGATf/HPTsSFCPdxbQPhq5HKKHvcpmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTJnvxqnDtYWImFhrK8eKH+qU8mENwX3PYW/yDC6WX4=;
 b=xjxJn8EYgBEpnyo3FdinIpyNuZ4HrcagQfLiSX6ShFtWPy5DvIPfeiIq8qCnMfbGuvga3huXcuwVNee9+D0FZ9q9Y4MqFAXW4/mnjMWEQsGzX0DA+7f8IxYMYttumJB8q/jFJndXk0106bvLPYoixvomRM1FuYmqBv8aNDXenGg=
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 10:39:32 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::b8) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 10:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 10:39:26 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 05:39:24 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Date: Thu, 28 Mar 2024 18:39:03 +0800
Message-ID: <20240328103903.408290-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328103903.408290-1-Jiqian.Chen@amd.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: cf89e3ab-51b4-4f4d-d70d-08dc4f135763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dECbz4qcJh7KcKwE3Tty3GfhWP4EvL8AKoHKz7eaj4KbG9LRWU8w9GmuSEYB6F2dbUah4dF6MwxsAapNQLSPkh95srUJdHV+Yitg7wdYd2qfOryA8XtWVSlkhzDfR1yvrjO9DYdbL0OrliMobdKunantj1upPcBYd4LRpHBggSRQLCI0sRr/90L1Mk4RAFcBLmwgUgF6LxkCiA7zR5D7RgI2Mo7VX8PNnetxpjGkrEd5y1c5B37pm2pdljP3ckMzz3awZ56nhGRcqYrzatiuPiqIyp0zY2snubBYiAQzrCiODBU9+cFiVykOWMRB4h+vOvmOjxuXJYS8SK1NcIbnSwiG9ZaytbJCh9tTHtkoxMMHiAunfHOWI64klRaqlfVbaWyYz0sofjNOCnmYRhtcsaS7A+CIP7v8tARw8NvbJHhsDexqddvmrzq/5jIDLuhHTMre8+Z5JhQ+gt+BrFKV8ziQm75TewPIZ5TLkpR4uu3rsfqbotYLKpfUWI7gNpmJh2WLCMMN1U2NV1M5ItlaIcDQoSjLsOYAVpeQIc/mJysvdkvSsiADOmkUsJyfy0GXM4FrM9lT47c6+dDf5V6Q1md5kEu76JLBD+kTFu4ZgaPjCswVi6oc/MJZOy5ruEE0tZaWaIwAQalABdIN7LFkUfoxwIyaS+J0JmxIWoFwzg2Iq4Ctf0A19wyg8hksM9QzBJufDbplyW6HGnIIW+NjYYxPij74S4nOBvEAdeWj4EnJD62xjR0GMovpucjiDIhe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:39:26.7964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf89e3ab-51b4-4f4d-d70d-08dc4f135763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
Received-SPF: permerror client-ip=2a01:111:f403:240a::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

In current code, when guest does S3, virtio devices are reset due to
the bit No_Soft_Reset is not set. After resetting, the display resources
of virtio-gpu are destroyed, then the display can't come back and only
show blank after resuming.

Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
this bit, if this bit is set, the devices resetting will not be done, and
then the display can work after resuming.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c         | 29 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 05dd03758d9f..8d9fab855c7d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2378,6 +2378,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
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
@@ -2440,11 +2445,33 @@ static void virtio_pci_reset(DeviceState *qdev)
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
+    return ((pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
+            (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3);
+}
+
 static void virtio_pci_bus_reset_hold(Object *obj)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
 
+    if (virtio_pci_no_soft_reset(dev)) {
+        return;
+    }
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
@@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 4d57a9c75130..c758eb738234 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -44,6 +44,7 @@ enum {
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
     VIRTIO_PCI_FLAG_VDPA_BIT,
+    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -80,6 +81,10 @@ enum {
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


