Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6030EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Fz-0003Qx-CM; Wed, 15 May 2024 03:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s79Fx-0003QM-FB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:40:57 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com
 ([40.107.94.46] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s79Fv-0003Pr-D1
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:40:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2VlhXFQMYOpFBJnC3kgeJHFuBeW5BCQaSdZD169NCseWVYDfpVre6QF6OWpZz9wlKcn6CDpVM1l33Ul3PgnrWCFsU0qKd4Tnk+4qXvxtcjmJnhNZyiE50UzU1JY0fB0azETI/G456YtzM+mAt3NnACCANXFOxdA5OZqVVzsfbLzBoZnmlhZzIKoYhCUat3k+GmtefdZsaf4OiE0S08wxkzP8WdXtDtVigvNmySEkr0SfA7izl+Ovu8RQsyrgeVVr1wEnxWgBGxQ/BqvaBTdzdFuzp6n6y8ojGSD41zkktJkxDsvz7XqObRZWB5nvY0N6SDSi2Owb2YnWiVaB32tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adzI6SwRWiCX4dOhcKq60SVFvOBfBB/gvXFt8Sn1tD0=;
 b=Y0DUfGeZoqQ7hK44RiwpfkZ39P5ZFEgpXdPIbPCdn2m/MAMBtRm3BZCYEGkXCtNNFooIzu2Rue8coSwcNOnyyEKPXZqQwprjht0GY3uEo3qJKH5NegreDV/gp9eZWap+3GFhytubg08nuVprJl2xEuwBjj4BHKEveyBy5hSxIMTB/7qV4NXXrOWlR3yzOzBgiikqIZjJXIZGYrlVNJk0VlJoQ3PRcOE/FANnP2qBRQ2YHE0Cxs6j/Z0SbhmwPVDEgdCDyAGRsLWpC2eXfiv3jnbzvtZDfjHUPubbqVsj6muSn9HMShuyeg5DiK0t3VymmpAAvLNVh2ivQHo57xYAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adzI6SwRWiCX4dOhcKq60SVFvOBfBB/gvXFt8Sn1tD0=;
 b=I+xFTFCst/iWnr5RdhSuTHPnOxQ5LheRiqV6LD9Fdwfv9uHQzi2qzxBWf7KoWKPs3ADsHEjgq4uXqxXwkSz0trkwiWOywZWOzN6gMqM/uem1Ph+qrlIe3/2lRdh5dvhz7JDouuj4s3uizt7PIiYZkDfwB7KkMi/2wLSWRrUhOos=
Received: from MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:35:47 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::7a) by MN2PR05CA0053.outlook.office365.com
 (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 07:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 07:35:47 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 02:35:43 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [PATCH v10 1/2] virtio-pci: only reset pm state during resetting
Date: Wed, 15 May 2024 15:35:25 +0800
Message-ID: <20240515073526.17297-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bff349-2962-4780-97ac-08dc74b1a315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MiF1KZYJCvg04CjEhkPcrc+1blT9WzRLvknOMDAUydrOxT+BIuLWLTWPbxWv?=
 =?us-ascii?Q?rOsbOX03mMNUVhz+ltfugAe7Yc7x/hzFJOippc6gwYGPk/is+onybVxyrbv8?=
 =?us-ascii?Q?KoStQJHUUnSzTdeWT+rUllnZaoEpxwazbKuW0gY9qxYnYFmRGBuO4aip2dvC?=
 =?us-ascii?Q?QbA6Io8qp1JxIiMM6GcZOMOzQZ841ELYiqz5P3Jz22zxUwdr7ttXSsM74BbV?=
 =?us-ascii?Q?Yo9ISKbTI5r1+JUwpZSqqXD/xPk/ZJzidazzJPIN8GlFRT8M99gFrwZTHWKQ?=
 =?us-ascii?Q?hQ1Mcbut+rQQWfugVpLxOze6NzUG5ZHf5wUUoAyMXp+WR5tC05hH8GDAmGoJ?=
 =?us-ascii?Q?3k+4R81B7ZuEj9UoQC/BxK4cd3VAx3qUc1RhttTl3jIrlm7itu1MxsQ711US?=
 =?us-ascii?Q?QaNbNZG/wYldWzWfVh32r5rh45eMumfsiGWMWUts/YBogxVsY3iAFtswGQJz?=
 =?us-ascii?Q?fadcmUfvfBYrjLKUz20zmTGZGRxunr9x1JkkF0BZ/iQH6sPqINAS0mkBtKlT?=
 =?us-ascii?Q?5dQCgpIcMeFA5em0mVjcn5Cy/qJmRQ4IFmzvdqzTIo8g1LvHxgIPw8KjWMKl?=
 =?us-ascii?Q?TkSfs29j6w+1ZFHkmUnrn4vA5PXdY0atia/RmSHuLm3zdj7WsOAbSdQdm7mn?=
 =?us-ascii?Q?FBGysknAl1kSM/drua/H0G7scwbW4UuG6PBluMQjZlKK2tpSbs1j+TDA2/sd?=
 =?us-ascii?Q?u/JC2jME6nlKYzoLF2AKGsh4CamC6HUsMqRVnhn0NA1VKatY06PATwk/QyWw?=
 =?us-ascii?Q?1tWRewHXdLxG+plBOii3UdEyYx4X2A3NQPP1N8OpoS6nCKfzxSBzmhCf0/E6?=
 =?us-ascii?Q?uTpDfq5Dzh/NA8Vj1zM2YJc1vQRRy8nSO3bZz4AixQc857KpsyISytY2fj1I?=
 =?us-ascii?Q?7+74xMXWEUIOUKgy8HMj8fcJN5Av27ETatu8np9mpVIeZkRkH54B9w2MFUHs?=
 =?us-ascii?Q?AeV/irIIxOdxc429e+bS7DwfEnrY4t/6Zgi8q6ROnzFTPAHBOS3wH83JJPc1?=
 =?us-ascii?Q?3gIrC/QSFxpyFFPkGPAPXuOC15PH2Rt3Kvcilr0+e1KukBEhkSRNR9/w4U9j?=
 =?us-ascii?Q?WlgkLHGqgjK/FzqudGFVIJdiEdv0yuGP934ScugGgqJpapm6lZnnqcQAt8wK?=
 =?us-ascii?Q?EYeHrTV2eal1hTelK3IyoDQolD+0gY1C4Mt9mEAuVMf0SllUdmtqPOjmNN9g?=
 =?us-ascii?Q?+WjMN9AyJZaq9twfrmwXyZq6lJhlQmcCvDZ9JLV7CxlzdvrkmHdjlPe5gmoY?=
 =?us-ascii?Q?0YWaVouJGayzOo+Ysj/YKD325AUeVXPz7Scu5HBrMI1wuThoUV4q2PhS9YZp?=
 =?us-ascii?Q?vgFgnmddI40wK7KUIhSiyFg+shb5XJUZFM54enRYuxzzU1UQmTG9xDSri0fx?=
 =?us-ascii?Q?HN/ly4A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 07:35:47.2652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bff349-2962-4780-97ac-08dc74b1a315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
Received-SPF: permerror client-ip=40.107.94.46;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Fix bug imported by 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
After this change, observe that QEMU may erroneously clear the power status of the device,
or may erroneously clear non writable registers, such as NO_SOFT_RESET, etc.

Only state of PM_CTRL is writable.
Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.

Fixes: 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b1d02f4b3de0..1b63bcb3f15c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2300,10 +2300,16 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
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


