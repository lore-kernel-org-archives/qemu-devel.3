Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08531D11708
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 06:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4EGP-0003OE-3J; Fri, 25 Oct 2024 02:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t4EGN-0003Ng-4i
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 02:57:35 -0400
Received: from mail-dm6nam04on2086.outbound.protection.outlook.com
 ([40.107.102.86] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t4EGK-0001at-Fo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 02:57:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQFDnkLsAJmuYnxnseCR2IllQO8KSlg8khiM/XmWpcox5Qqzzdr7mIjIiKwtbNSYvZky1NzHSegORWru15eDcmdZzys8xC/yXSuO5fXb9Ww6YQU2bOh1h+Ww8rutEtcK06hC6Mq4dldXCWdPBLfItsQkietVt2rbnhjXitAIWWGTepdD/bOkGcGNUeMfshOn4rFJmrNwBl6HoUIhdZh6vqdiqjgs9cSqVi0HwUckb5dXzTpSqdkEZt9eica+g07YI9AGicA1drfbzhEB8a28nFuFSzpy8ehjLZhMXjZjP605Jtpm3Q8igG5oKnFJloOmOQCAbb/a+vMLxNU119PGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmfZAhiQRezAntS5cPJlvlFXrCQLMzebwZXuMHKwedo=;
 b=YGbLXFAWX7X28tbKweQVpKiBKLI+EI2bIwdTbRdYoN3Ni9u2NpepCdOX6yJXb0VlJUqR1sgQCoeM5NY+2u7WRbFzMMkHtZqIoVfGdmjKFDigVp/fKxgrEp7BCgKWfRWSWOiG5TJpI56KiKNXhQ63hGgS0a6tvsddpfjfxhs7Zr3wA91rBOxg4O62gM5H2iCT7DhZzexz0xs8Y3qXjVEaWGVO4T0llV9Axwa+JlU3ooJXptOebla87ZjpNaQoW/FDQUSE42urHYV08PBpTJ/MnRDcjTMZXxnY5Tj2CtD1SJROpXc+kgjojuRvkjrmfOORUNlIZezE9EAjY97RnunjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmfZAhiQRezAntS5cPJlvlFXrCQLMzebwZXuMHKwedo=;
 b=TauyYU87bIHAm5KuBxAARkQnZlUL8P/ea6D85l3R7xJ65vib4C3Bt7hWZUjyotWMAVJTqufCpBOQeN4lAS9PX43NXAYnRnLiMQ3Fh044aClx051NerfxZXRPw3E3IYfyqGHjDD6KhHdaoxdkv2nITwBbeA9BrFxKkKVwmZiR8gU=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 06:52:25 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::1a) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 06:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 06:52:25 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 01:52:22 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <marcandre.lureau@redhat.com>
CC: <qemu-devel@nongnu.org>, <pierre-eric.pelloux-prayer@amd.com>,
 <ken.xue@amd.com>, <lei.huang@amd.com>, Lei Huang <Lei.Huang@amd.com>
Subject: [PATCH] ui/sdl: Mouse event optimization
Date: Fri, 25 Oct 2024 14:52:05 +0800
Message-ID: <20241025065205.1222-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d580238-d551-4eb0-b308-08dcf4c1955a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N1DXJUR5/VqG48jAL5EiMjJZ1dAppV0xH8ay9A4R98S8IhY49WvEKxDOiQxU?=
 =?us-ascii?Q?yt3OdB/mZC7JMZVz4pc6bxUsen0zbOxZ3bWfEGLrkgxtXMPKIx69PUaJ0f0O?=
 =?us-ascii?Q?xxxNk4cALDiKJCtIVlfa5/4LHFjxMIf0RaNcoVIV2+OF7OajYsXJb8YorU2a?=
 =?us-ascii?Q?4VwwgOI5LxbbnFYJLD4r5ToCepWhIEyZJYdkQjDkpzuzJD4T4lqXGbkBirQ+?=
 =?us-ascii?Q?jRcRn0ITDy9dYB9VULCDtxP5q8Nm75DY4eqBBvB90GJkPQ0qQicvD03rtTTv?=
 =?us-ascii?Q?FIcFpix59Ms/6LA9iqkjLvetV3/qlG4F4ItxepNJS+1mXWhZxr5WKm3r/xBS?=
 =?us-ascii?Q?KaCktL7xkr817eegglRk9KsGM6KpbnCdOGvGbKfLwTCIXhbcnM1A3dk8Oocc?=
 =?us-ascii?Q?GRwm4+bu9hkGzQekXqMZk10g+4hkJua92pogp4Qe3YooGBypyGw/7ScAtHxs?=
 =?us-ascii?Q?UaJ9w4GCT9ARlOEgK5Z79S+cLBqAaxA/j9IOOFmPtSc8WCGNCMCTAlnvsV1K?=
 =?us-ascii?Q?3ug6C8+asGSSa6UErRqZwqtKQrAgqFcD0uNZbbCZBeVa/pTa0fYQfwt66fbS?=
 =?us-ascii?Q?yqCbGvpm6Db4K7HWCuyn+FA+gwCoNwfsFxrGLgRmcrtXxGRWejOFkEaU9avB?=
 =?us-ascii?Q?Cfw9O174UML/H8vI4DCVKxUuvRKcCOovTA+EK/jOsOYRpAz1hbYz+s6kcVND?=
 =?us-ascii?Q?OLAu4gKE2wQHCcCBXWlVWl9GzMVbpPl7BfnDEpuYx1HQABzxP9C1ZtyDnPsj?=
 =?us-ascii?Q?a1BolEd7NS1oH5+wTo+iFXfQU1HxXrLsJaNODw/bEFRYcLY+9AG397JFRclj?=
 =?us-ascii?Q?iWl02xqvx8ACitXa+ZRv5hpRNMw5DrAwhJtI6AXM2kO+pAPJMEvcRrwPEtS9?=
 =?us-ascii?Q?kEuWUF3tc/bGYoJZ7pc87fSZjEy4hldsM01Oh9IwJDfeP2zeTLqMODrEhRGL?=
 =?us-ascii?Q?AhKh1sh07Vuz0GlElMLrfzmEdTyRCJJv29WHO34uKNISwxFTWsW4AdAcqwxD?=
 =?us-ascii?Q?htwhUD1IZPuIHXi9Y1ZnUCownA//l3GBcQ+c//8EubRsovPbxTfCefBdZade?=
 =?us-ascii?Q?UgRfu8PzMd2sm78/VQIv9cgal2dahZgtLWOulvgwvUHyUxXigWtNfUbQa9/w?=
 =?us-ascii?Q?xsCFPgYzMK+dpQg+LZOh0HWbQ5vlQHMRjCjhYMmvfirPidJlFsbxHh8UoeCF?=
 =?us-ascii?Q?G+FCgGevFnuqMTCEeeISrjeKa9Tty3dGzEViZIJzsuZOe3V9hxirHetYJ0qd?=
 =?us-ascii?Q?DES5CSYS3uJKxmbkNPN8OTtlgL+yRplCJK/rllvFsmZo7WFnoPLwfFgVC4sL?=
 =?us-ascii?Q?/xH7lVj3K253TF6UWyLFTcBdZT1dzwKIlN+8Xi5qTAL7quqZgQi6eO5KkhnO?=
 =?us-ascii?Q?KT2ol/7fUYM4pTHcbRHVdXmLNQ9Wc6dABJ7ZnoVUbaAOCU1m8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 06:52:25.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d580238-d551-4eb0-b308-08dcf4c1955a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
Received-SPF: permerror client-ip=40.107.102.86;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-1.697, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Use a convergence factor to make the VM's input
global coordinates more closely approach the global
coordinates of DOM0.

Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
Signed-off-by: Lei Huang <Lei.Huang@amd.com>
---
 ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da14..8f504dd8727 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
     }
 }
 
+/*
+ *guest_x and guest_y represent the global coordinates on the VM side,
+ *while x and y represent the global coordinates on the dom0 side.
+ *The goal of this entire process is to align the global coordinates of
+ *the VM with those of dom0 using dx and dy. The current approach aims
+ *for precise calibration in once attempt; however, because guest_x
+ *and guest_y are non-zero values, they are not accurate values when
+ *they are counted out to become negative.Therefore, achieving perfect
+ *alignment in one attempt is impossible.Since the same calibration method
+ *is used each time, repeated attempts cannot achieve alignment either.
+ *By introducing a convergence factor, guest_x and guest_y can be made to
+ *approach dom0's x and y indefinitely.
+ *
+ *                   QEMU                       (dx,dy)  VM
+ *calculates dx and dy using guest_x and guest_y ---->  input driver
+ *           ^                                            |
+ *           |                                            |
+ *           |                                            V
+ *           |     update
+ *           | guest_x,guest_y              input dispatcher ---> WindowManager
+ *           |                                            |                 |
+ *           |                                            |                 |
+ *           |                 libdrm                     V                 |
+ *       virtio-gpu  <------ drmModeMoveCursor <------ compositor <-------  |
+ *                           (guest_x,guest_y)   calculates guest_x and
+ *                                               guest_y dy using dx and dy
+ */
+#define CONVERGENCE_FACTOR 3
 static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
                                  int x, int y, int state)
 {
@@ -331,8 +359,8 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
             y -= guest_y;
             guest_x += x;
             guest_y += y;
-            dx = x;
-            dy = y;
+            dx = x / CONVERGENCE_FACTOR;
+            dy = y / CONVERGENCE_FACTOR;
         }
         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
-- 
2.45.2


