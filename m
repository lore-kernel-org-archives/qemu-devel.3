Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C292DCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGrgd-0002Ro-Kt; Wed, 14 Oct 2026 01:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGrgY-0002JJ-JB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:37:55 -0400
Received: from mail-centralusazon11011040.outbound.protection.outlook.com
 ([52.101.62.40] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGrgW-00037v-S1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:37:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8KseCJMWfH2KcK0FjfiQP92fmOWFkUHpQFCt0EMMEnQJKD9vyBrcUZGNxyDg6ZY3VVSXPgPxE5g82KxJNeH0Z9MooZ9cRj3EJ4I+oqYaQwmUmOA5UpnP1p3L0XkCtJ1gyeIv3a09FlRTgZr65IEbFMCErL4hqyEVrwxnklekq+epibA6awMXfsLWX0ACM2AQ65h8bOrPw7WjxtyF5Sk3JldCnlyCUuku/jvLzeD1A5W3QS0P7RBcRpm4ihwXvI1CGGceh2IpHTBPZQNpsynzi3J9wJf5qAHhTt2Cd5I/+V6BtE0/MGKQUUuo1IkOjci4WanRb1wv7KNYehHrtpDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3k6w3Pd3BJeAybw9ydvHpcos6rbnIAmD000irU0FuI=;
 b=i2b47qLFV9c9+lxkX/5V2ztYQMJ6fjjVKf50fI4uXkiVLDdk4bIzNoK3yeJdNpcPRgmw56K3Uv5mRSWYJbpb975B9p0ZEq6J0wzteYlXswT3M2MRsysdFTeHvaFZPd2dDcQa7WTOm9sy9A9gtfpuSYGc+X6X0Aqavh7MiW6OLe1nZlQ3FrM1QwHSeyHcTcRc8jCh7C/+mpMo+ASzo3ofIrwpTWQZ7rhIx6M/YuSCFHxDKAD/608GoWZEHyNL75nMMPYwHhmIr95ghnlDiD2pAgMV9PAZuPwNxPJyp6jygREVxvugaFMTf+KjSobveiCd0d75ykeQU0PoG2yCt6/2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3k6w3Pd3BJeAybw9ydvHpcos6rbnIAmD000irU0FuI=;
 b=44DNw1L9R3dkh/gdDl5VD65rr6U5Zv/CayKUQdzJGAwRBxdoX8J8zXQa7W+fBwQZNVm24BpzQshZKs3TtkhYrzO/vhldTV1/oCvgicl04smQM6t6n7JwfdbW17PHDTV5Ey9ydQbGPHRpmUDjMBLVO1q0hNiiZOZFXNdrIqDivKQ=
Received: from SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16)
 by SA3PR12MB995558.namprd12.prod.outlook.com (2603:10b6:806:511::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 05:37:00 +0000
Received: from MW2PEPF00014675.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6f) by SJ0PR13CA0101.outlook.office365.com
 (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 05:37:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014675.mail.protection.outlook.com (10.167.249.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:36:59 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:36:49 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, Yi Liu <yi.l.liu@intel.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 6/8] amd_iommu: Introduce root bus
Date: Wed, 14 Oct 2026 11:04:31 +0530
Message-ID: <20261014053433.24564-7-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014053433.24564-1-sarunkod@amd.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014675:EE_|SA3PR12MB995558:EE_
X-MS-Office365-Filtering-Correlation-Id: cb255ce8-16b2-44e1-d85c-08df29b52b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|7416014|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eWZvlXiUxs5INciDTvTFRTzJWcoE6CCj2wCRA47wtlTSk0bIOpO5vESp1+qIMvKm/gype9S8ou/WM5eqY0uzwfy+pC/iEp3qqhZfzFOHYQuHGArkLKDIOCnfgU4D7P3aCGvg6bmHapLaqYU/tnP2syx/ZBGbQK82r10bustu1Hab1j6zJR0ZE1K4N6/82upL2Fa168DucondnTbvQc/QmGyI6YS+fyfthLpvigeBNTzne0La9WvjeiKfyqwovuUQqbUHMkAbhPUGy13D/TZWdf+OtVkbdDo2NN1j4DDO+Ec/eTsn5f/FLBYJMPAREP9Od6bsYrRkNGbFZTpAJpyba0Q3Zp46opGm3nE7i4upheYuM7DvAQFTwMEIpktsH91os1yOVm5WQaZDyP/PL1Odsdk61aQr7Cyaze4YFExvifpleEAFoV9QLo2aYDLqQEG5BkfTFwhLXuuAYmmrEwXaXoP7Kb0hFiadmyg2oksF8/5Xe7lVaybzMQyt22cbluyNcKvDc3lh8am7yFYL4CGFKyhzY5L79PV6fMWDFzSAh/P97q3swnsLu5h0fDxnLZmyzmZfpri/YSPw9XMfj35750WTCOyppQiZL7Md9sGu2RjGUIJmE44p9hbcJPygN3mvd+RyffB4ibwq9aMRPzc+i0+kEhE8LQauwvC00IxQSCOKTI1zLonPjOyRXLDof3Hi746hCREo/+vMeWuKQpPbSoOomLJ2nYXzzWv+IsdEopfRRudysQu+80qX8rP42Xq5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(7416014)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x2wDkIjZNGlM7Ixd1/A5XtozzXUtpnJ1NhgBobx01Ez3KgVU+AXx5QnJh6ERvlqUIy6ol0jdnN0GjDlqYPsgYh/UrfrZnDETbGrKsS/Xus0AVgnPLIWlH8DppjkIqPLbUgt5zlETSIhEOVMsPgeqnOM1SdtaJmF6UUfwrArj3yPnj+ZxWnjKXeWTcdFVeJg4sST4LnwlICnV2aZbndpgUp4jLHgVNTh7XcUOghi8TbEBURXzjyKcslbEs4wy5cotehbT4MfMKEFT33gt6TMXqsBLa550xvX0aWeQ945JBGKqtk5Ugp6sDX/hzWWbGsLSg0RLn0qJzR1puaANl5AzglsorQYtb/4JAjsS8hV7q2prUTIKRO7cmUM5VcySNaYwsLluKe4pbulfwhOmEih2hNv9fRyCaUgcIEWD598uPTmqx81I/AKyT/pMGO7NTAtG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:36:59.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb255ce8-16b2-44e1-d85c-08df29b52b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014675.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB995558
Received-SPF: permerror client-ip=52.101.62.40; envelope-from=Sairaj.K@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Following patch will create IVRS entries starting from the root bus

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 2 ++
 hw/i386/amd_iommu.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5c1fb0879c0f..5e4d5d1f1fcd 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2713,6 +2713,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    s->root_bus = bus;
+
     s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
                                      amdvi_iotlb_equal, g_free, g_free);
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 687691ec1cce..04a5bbd33740 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -373,6 +373,9 @@ struct AMDVIState {
 
     /* DMA address translation */
     bool dma_remap;
+
+    /* root bus to register IOMMU ops */
+    PCIBus *root_bus;
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
-- 
2.34.1


