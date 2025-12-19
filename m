Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BB8D78784
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 14:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWbR0-0006Te-OX; Fri, 19 Dec 2025 09:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Victor.Zhao@amd.com>)
 id 1vWWlK-0007Il-HL; Fri, 19 Dec 2025 04:27:02 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Victor.Zhao@amd.com>)
 id 1vWWlI-0000bo-Hs; Fri, 19 Dec 2025 04:27:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUJdjJYOjYMHmxlaguH6opEJ8X8lsfMH8v1NcfiMZQuB6XN52YCc4zUvnhidv5/q3qxvSBSVi9VsvsB/mSj6SWA0ANeO0TGAGe2OLUmxCUOkLAS8XQ0A71vqo25zj//0fk2K10a0t2ExdcYR2chij35H2ymZnNWXWrrQF52QOxlvLWR2I0YIE+JV16nFoZ3uimW4DCR7CwjeLpFPmwjT1d0UyQmuse6RclKO03vEaAnRPnUk7iGeNN9fgDzx8GMWQXyKgUqR5nGCjb362Ee1ySgl3Z47XPoTHklhu7SXrG2gvDHfxO4tudur3XerBpRcIhPxlm4hVsOBlox3YqmxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJRmtMasUWvwnk13UjpM5xRDjzumIWG64y5khFNnsxU=;
 b=BUc3cbkD0bYExIV6CMLfC+3EBiUcLRu464oRT9PZJtDf3WnIuPZWZ/1X0LYX5LZXVLGzOA3+Vn2PAXHxxWQEil/Pv5dPpir9d40kwZXS8AOj+NB/r9ogOpz0lldP4dywkbQgSqVSoJ+E2Jxxm36Y5aFNsnjUg2CmRuRxLkYC3EksEBjYlg6QXXHfIruEDpWLud2aNwEIiDrpM/XFnxheA5jhPLPTqU90QSbEXEG0z/zIuxTrJBb76KFqY2QDFV8Ml+JADSv+FGcx22HPyMTyACv7lzlgsSi53yiMlHFa3qBUWWDJpzgOxn4bKAHCOaUAA187vOur5pAdGb+JuKw6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJRmtMasUWvwnk13UjpM5xRDjzumIWG64y5khFNnsxU=;
 b=j1bYUDGqFWitYSKev2CxxRtYTuI183bYwqtl6aglr0XEprPgTs/3gEy8usMyIq1kOxpYgt08XAlZXOBMVNN81zbyh2sAJfK8BTsOH4rbq/Td6Ld7YdkcD7hQdRnC5pASjxVJyWeQn3l8kfqReLqBK0WyKSOuFJHGeJwquFSFtz8=
Received: from CH2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:610:4f::19)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 09:26:53 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::e2) by CH2PR18CA0009.outlook.office365.com
 (2603:10b6:610:4f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Fri,
 19 Dec 2025 09:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 09:26:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 03:26:50 -0600
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 19 Dec 2025 01:26:49 -0800
From: Victor Zhao <Victor.Zhao@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 <qemu-stable@nongnu.org>
Subject: [PATCH] vfio/pci: Do not clear PCI_COMMAND_INTX_DISABLE in pre_reset
Date: Fri, 19 Dec 2025 17:26:34 +0800
Message-ID: <20251219092634.3176885-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5eb72e-7a79-46ea-01c9-08de3ee0be07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W3wh/En5EHLOZEoKarP6mBA+clC6QQ5bP83/w6bJ3Uk+pmq7IXHkr5v8gDC4?=
 =?us-ascii?Q?7kM+bVzqoG1IWtapdY4MW51KVG44jymClolNWhLPCXAzb+hRG9PKgfAUtD4u?=
 =?us-ascii?Q?4RgLqh0QXU0HwxdExe8MRbcVyCTtHyyEHnwaFzChClNKD+dcbYrqfM9J406p?=
 =?us-ascii?Q?x7eWBJqe5J0Gl2lR2jCqqwMBbmAj9rXFppjx2HCupM1XiRHpNfubPoAL5VoD?=
 =?us-ascii?Q?U9Km7IYmdnMMqyP0uJna1u2KM7hZDr6zA4QKGok6VfNJ5githDYf4ZpldVej?=
 =?us-ascii?Q?uo+p+OsDf4/o6akyZYh38wLTzBZqX2l5Bs5tsNHAhGuxKaiR81bc+vD/vUab?=
 =?us-ascii?Q?Wvguh1nl5BtiZMyDcEPPdtkIvnYlNM3Cdff809IYIUN9lKRX8AnGLSk/R6AR?=
 =?us-ascii?Q?5+n2RaRzAfz4ze5jkFT3wACQkTiD6onc72jjX5P50Uil5DZM+xb7DY1uD1xx?=
 =?us-ascii?Q?QdqSgtsVmtbbeIoaYWQ1zWKu5cjbbHacWDNcKsccwJBuEjVteKTScHixfxzB?=
 =?us-ascii?Q?7u2KmI8+tLZcnk8eWJv9/wuH7HqWZVC/HVaWqiSIrBZS8BwHmQkHWghq1wI8?=
 =?us-ascii?Q?YtcCmU/A7jmrdEKk6VOzlcvGCPiZOharslmmw4tOx2mQdYZ8iOLdc9TsCJF1?=
 =?us-ascii?Q?STGQxpXMW8E5B+biq3Mr84JJfTGF4OJwoYT1EdrL24h26kl4mkFteD/qdqNE?=
 =?us-ascii?Q?m48xrc0pY0IcuJv479SfW47og+C7diMlO7QQHeeQfXAPhAF3kelRAUyHqVEq?=
 =?us-ascii?Q?w8y5jFlb7FPumchBiQpEQghEicuPxFShnVOGMDA+hm8au+yxoXn+GxmeMLMC?=
 =?us-ascii?Q?0C63qrjucu0+A9rYivu6LD8gVmvFXXTAifcYXtH0OREEzEhKYuq9a9gN4UCn?=
 =?us-ascii?Q?mClNj8Gwk1Xv9Z93o2QAdIcqQ0KGIfljDVn681we8GFHJqw1Xf5QB7TvAvGd?=
 =?us-ascii?Q?08wpFlvE4R8vydVDI+P/reKdu6qiHGntUDUWNv7ihNCuwVdAV0N1vf6m6vIA?=
 =?us-ascii?Q?kDXvpZH+Zk9YYzYaYZqtlao3nre+McZt2VzH0kioZ+7P1JVbeb7sutRi12/o?=
 =?us-ascii?Q?ffSrgEwCiA99ccXcWZh9ZdTrPY10MDbRNlt7zsvF0pMgEf+OBzb4zKX037zC?=
 =?us-ascii?Q?CQTTwpKIFZIPNrMpvKq6xPyPanX0h+snU/odskAho2n5jOTUmaR3EfkRH2RB?=
 =?us-ascii?Q?xCdhOMZC4MZtcZOsWNznKu5t14yQRGWaJqPg0UtURE108LBOE3XT9RQqazPj?=
 =?us-ascii?Q?HoGVIC+V4QuBV/ZQWXFrZFXNgAfOxHcILnnZtX0zsH0U5o2+sq9tDogV2oky?=
 =?us-ascii?Q?Oz1WlJdDAyyF4z6w+V65Eoe5Lfuof7ccX6zJaPkYWpBj8kULAwtf7Yvc+bY0?=
 =?us-ascii?Q?lE+/koiTT524sQjFjvuHbhsPQ1BV1FQVXUZyIYi1CmAgd1sYK62eRDTslv6n?=
 =?us-ascii?Q?gJkDqFUIt44gvlIYrR5kdLLDZEcreyBGpAR/YDre2wMwSy7iJUVrL/aAB1WU?=
 =?us-ascii?Q?/bUBXjDl+0XRupf2WbO0Sh43wg5925J1V+Esl/c3NdH6j8Myt7nTjZm+NTo7?=
 =?us-ascii?Q?fEPsnLPFoH45fK3c7BM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 09:26:51.4392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5eb72e-7a79-46ea-01c9-08de3ee0be07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Victor.Zhao@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Dec 2025 09:26:20 -0500
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

When vfio_pci_pre_reset() disables MSI/MSI-X, the device may fall back
to INTx mode. The code then clears PCI_COMMAND_INTX_DISABLE, allowing
the device to assert INTx. Since interrupt handlers have already been
removed, this causes unhandled interrupts and kernel "nobody cared"
warnings.

Fix by not clearing PCI_COMMAND_INTX_DISABLE. The device reset will
restore it to default state.

Cc: qemu-stable@nongnu.org
Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 hw/vfio/pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b46b1305a7..1681134cf2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2616,13 +2616,9 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
     vfio_disable_interrupts(vdev);
 
-    /*
-     * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
-     * Also put INTx Disable in known state.
-     */
+    /* Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master. */
     cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
-    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-             PCI_COMMAND_INTX_DISABLE);
+    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
     vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
 
     /* Make sure the device is in D0 */
-- 
2.25.1


