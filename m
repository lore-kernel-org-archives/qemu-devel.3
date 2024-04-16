Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E75C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 07:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcuE-0005qf-10; Tue, 16 Apr 2024 03:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwcuB-0005ph-DI
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:06:59 -0400
Received: from mail-co1nam11on2069.outbound.protection.outlook.com
 ([40.107.220.69] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwcu5-0001xY-Qv
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:06:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzZo1+m1vJ5EVxD9A1vrYal91/BTJ2x/+ziRaOsFW+mDdWlllL1MCDqrxSvuAqqXVcXixYtpuibIAhFAtrYhlUuvK22GgFesz7XATporPwHJ4c6gC17x6J364jFFo6fTVTiJ+kZ9RGnrqcxO9btByEkEodFJ8i5YzOB86T9nhYzPV5ESAsGsEBOxAU6bfcZUk+YrL9Gbj3XcgHQQHKyLZloEfVDG+yshPdSgjHn9RH/ghHXpARAYqZggdclWmkg7olNOqUzalGsnSobn49puUdu5kK/peviF0mVw9r1Q1mio10cE2wjK2+nFyWe6ZlpjkDaZCWdY5gpytf8zC3P/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kQni3ZQ2l7RCb+eKaAYhYCLiZRX+H7MX3EV+uvBWSI=;
 b=UESaD0DrMpLrojVHW14QHoz/fxPmTQuw8HsnrLS1zAiWzKm+p8znlNvUTDRap+kLn8A+DZW22dja3xkDS04WwZ7/w3FLncrvLojMD8271b65WXfCMTWtb6k8epGRT7fyUBuijeaEQkMgAUAUS6CpfV8Ta2Z1Nh0Dw6AMo3j6V+YTxlT7So6afvtHAE9SobZOKRCSCaPynOPUEoAlo58ptB1EwynlHqfTogpyDOTNAQWeNaZF0qguIYxJ7S7yZnBGMrwVS580yHhhbcMAfLyWOMjROZnKhw1J8bOpeK2Hy64tkwfnAm3akbIaYcSu2gyEXvxIUCSAyM+KJX2fjKHWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kQni3ZQ2l7RCb+eKaAYhYCLiZRX+H7MX3EV+uvBWSI=;
 b=GdZpT3EOZx87Pu9cSaidgATYpQL2F6vgkWOmPxHOOB/kbIOfWnKY2OGMknZPe15uM/aw+MPhB0paQ/Ok4c+f8icPfUhdsXrtbzmD2GOVEhg6VRpXl0CTfY+mwZEezjUUptVCxHA+spSDYjHlPK5m6qHbJxp8Gcr3w/eezwe99Kc=
Received: from CH2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:610:4c::33)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:01:46 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::2c) by CH2PR10CA0023.outlook.office365.com
 (2603:10b6:610:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 07:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 07:01:45 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 02:01:43 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Huang Rui
 <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v9 1/2] virtio-pci: only reset pm state during
 resetting
Date: Tue, 16 Apr 2024 15:01:26 +0800
Message-ID: <20240416070127.116922-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416070127.116922-1-Jiqian.Chen@amd.com>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f5b15a-b190-4697-21d6-08dc5de31442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZK1x8aaHYZ0TKWpLMVgsSV8b/adva61qklK4RFHPBSgMrNP1+UVMUQhZAFDrTUpvSMFH/SvCk0euN/OJyveA19XzJIhLyCyeG6T0CqJPeNLprQK7aHTcTL7lrGJr4OOP3BG5ijRAzb+tR/Sg2Gd1kUpnsTtwvvHtJoettI6O2fCUEld2AaGttnrQqqhMdXxU+tMY/2uwoQDOSPUTTV2VnUGxhy+SEk75s9YJ7TPHNbPeNVHSObZbXzwR1givxykoEVmPx2GHsqNUxF4ficLsrlZUXYtJsSvEoPgP7UEggTRTGnngtyAT0ghndwb5defSbqUQt9oIAOGCKuTg4k8ibj1bKbw5MWezZRa4sPr+9QS84EhFYTGvk2tpPJnb/j8bhPH5Ac1I/xgUjTRFc2MqSUiabOKZLvcPN08xSajCRUg6SRbCwnY/Lwz/ekR48F1GdRDYMpu1woQZM93VNMOn3WwxmtwMZrbQHnrOEFiN5WcyWxh2HjhUlobzsFDnVTavrr8prqRkt1g/BZZ1MsJ/fErWtU99yiQYQghtTuDyoJV/+nqxmAtn5lc9tdxy1IsW+U6mJatptyQLOlofIwEnmyLCiEpkBlEjUJb1zJ1zduAM8eTDTvFMtU9zupfMHKrUX5HieGwqe3rh76tMXwyXnn3t97wcaVmJZDXUPBy+EFRfGv0i2cB47kZrcmE3zx4uXBpbIqUkYJV+PiSuMFxaZeo8x1V0NdIsPjXAiF6mxS+41MXEdKr16vUPO8ASBFyA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:01:45.7824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f5b15a-b190-4697-21d6-08dc5de31442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
Received-SPF: permerror client-ip=40.107.220.69;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

Fix bug imported by 27ce0f3afc9dd25d21b43bbce505157afd93d111
(fix Power Management Control Register for PCI Express virtio devices)

Only state of PM_CTRL is writable.
Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb159fd0785c..a1b61308e7a0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2300,10 +2300,16 @@ static void virtio_pci_bus_reset_hold(Object *obj)
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


