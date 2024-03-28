Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D78C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnAX-0003hJ-SM; Thu, 28 Mar 2024 06:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpnAU-0003ga-Kv
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:39:34 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpnAR-0002Jv-Bv
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/fqVwOdnpOHJqtXWizLWK06cYDB/m/mySc/v8Cop17rzmKIYT0bzQp7TayBQxhqbVpNk/fa+exorIbRJGvhR647Wf+puqtfPu/drfaV8vQdZUwDaLkKr77EMhPjTLHjDr2iMs81A7kYRDtDEpZcTj+y+a2ZhYmTQNP7qMnVmz+HqVN+CTiUC8Lzg73O6OasG7OLFDpYGqZZAqzaJVMN10El7aaaOfiX7jv5g2lGAtpGKBT2GkdPIxSadv2e+khH63Kz4DBnB7EkgjCJrM0IS9TWQHFL2QMVtFM12jGHhTd5XV7SMowK4GYI64C4ISOfpOVYv0I/6B9chN3WRLIaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbWzlTeDVqDgl4FTjqHptpfgk8WxgiyibX0jkuu8rDY=;
 b=HuExjy5MzwXGNUNudNZZIALjrcs/vAEFTreu4QUaDShlMtXJaTYYRO6nhVrbozv9qrr6xdi+i5VsyrbT1sMwT8OM2VTfKsSikqj30dLCMJiSOPIH1MthCWuraN1YCLBeAcXaSD27hF1CDfdDbeOFVc8pcUmzH2ijYCddhV7lOHHdaZuOC7OhzogRC/hgNuGt7ZJQdvp75b6dlZmMeCMQQ8EYRTopv2WFV4d8ZWcR++3h2HVuJeP+HJsdFvyVcCEOdlNXqs2RlJuw+Vwwgl+R0nwLJnIK23PXq3cb0KjOwxQatYyIiWJskIFuvEYRKOVSgFTB3Q1BTIubQPBLzJG0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbWzlTeDVqDgl4FTjqHptpfgk8WxgiyibX0jkuu8rDY=;
 b=sZiUx3PSWZocc3ZRvXQbRl+SOqj17KxbLpX+kuqiHMqSpAgkh4bUWBWQmWfboWIHzJSNbcRw6WKY9OD6LBO0LVHN6TTj0NA42lkH9knDdogmb2RndKQ0sSI51WrZ5HJaC6Eq9lw+sWbXDWcGAYwG2a+HiGlP+dvVsniGWwAlqiQ=
Received: from PH8PR15CA0017.namprd15.prod.outlook.com (2603:10b6:510:2d2::7)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 10:39:25 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::f1) by PH8PR15CA0017.outlook.office365.com
 (2603:10b6:510:2d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 10:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 10:39:25 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 05:39:23 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v8 1/2] virtio-pci: only reset pm state during
 resetting
Date: Thu, 28 Mar 2024 18:39:02 +0800
Message-ID: <20240328103903.408290-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fcaef2-1ee4-45df-1bfe-08dc4f13566d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffY78j26giq4kKZyGXCm4y17NMX+obQw9qRBpfaaGOCQ1Q8+D8gSq3Mg22PSZMBPNymT+cPHISur1JYzwafpaXA51rK0V8ccgGIvqvfSPUakdx3brb40lMcI5G0zONrGeIlSMqT76SGstTI+O0u6hzUMpNiLVQsDqVuehQyQJKA8YGwFHaHtOsQ4P9XOT9POjDfTHaECMD8wPqIlQE42FM0dpHZw/66+CH1edVMyYIDo6b5TfJVNJYWJKLhfn1XIcW0lqC7lgFN07kxL6D/kzGigUoDZPiHfHIHFrn3tZWMfijZiaLzL1JRGazs4Tlk2Z2FTJl8SFM+H05RkIOVKDO1kTfFPbNG3FUtbxhn6rqNb/spmRWR4tRZispe53rYOy18idG5LZGUb1ldXZ3ifCgLgm5gL55995ZpCtJ2hJao4yzkJFeoU65m11Xsh7HplGhHh47+wRsslrQ3mUnqtOOcYs9+FYcaoOnXs7Tn6QIVJhJlC2jfwnagyXO3kxmA+WJme6rgK7osq513mdWwVift6sDh5WLv5/3apOVdV7XpxOcGaP8PubPfEDCDLxEmCkiKxCEwfVQO3Xa2vYk3VTlFMFTgsboBE6B1XQBJWay27dmC1jbmmcgcka84gRV1Zrq5hUFnjbOmhFwJLQXJI1vIzJCMXdMkMuJxP/UhRxs+Fg/KHoArHQRq6kt6P8rk5XNDux6k63xpGJTjGy+qv0iICBI03OgvV/RVBGDRzWZI1JyPBaspE0oBAo78i0J4r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:39:25.1794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fcaef2-1ee4-45df-1bfe-08dc4f13566d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Fix bug imported by 27ce0f3afc9dd25d21b43bbce505157afd93d111
(fix Power Management Control Register for PCI Express virtio devices)

Only state of PM_CTRL is writable.
Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index eaaf86402cfa..05dd03758d9f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2448,10 +2448,16 @@ static void virtio_pci_bus_reset_hold(Object *obj)
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
+            pci_word_test_and_clear_mask(
+                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
+                PCI_PM_CTRL_STATE_MASK);
+        }
     }
 }
 
-- 
2.34.1


