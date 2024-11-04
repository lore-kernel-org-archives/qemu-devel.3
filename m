Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D016CFB422
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7slO-00011g-08; Mon, 04 Nov 2024 03:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t7slM-00011W-62
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:48:40 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com
 ([40.107.236.59] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t7slJ-0008Nb-VE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:48:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaWaUj8OnXu+gLwOcTR2jet3YzhmbXG4J6vnNrQ31r1ACXTjpDYxOpiUszaL4P1+0vT1wwn62CdwpDA04vBk7akdm7106bePpQ8C04liw8N7kOqLv8b6GCXm49U0HapanWVk56/mVM+UiZBXlR69OfkRcUwS9+SzCRq8kaoC4MM/q0N7vEO2+5zf4KUDOWno12sgxoDEVPKAvUKX3yj9PEpOuLaGsUUF4YiDpZQYmnN5LTOhhsB+wioPTj69qcPKlYcLJDA5D2KiIoN7CVgkC7dJQCezgcRM9Ch7MRIoGKujzRxeKWi4bEWivoJekwMMnQll0s9+IBk0n/j8CHHXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdHwisL3o5+wS+mZ3HC0d8D2jatAiwPa2dAlOEpwkEc=;
 b=Xt2f9bT36Oc+o0l+7xdhRuF7qXHuDd6wI6L0B5Bbes2nef4GGP8fLZnVHEoCQCOI0mmj9BIoQ1roTvpkTrY06A646k1P69R9IYrUH1Z4UWH68NkZzn2m8eWqURrw6V7hVp8KvtoBJlRsaiWes7dq2dWq6X1pdVAx/ro29avWmrAvvl7trctzCgbg2P7QRqg1T0sDNt+QQqzv8sTt0FOno+7cgHk2BSXgG3XR69RFJQaSDdwBj6wQRKBsOvyxqpfwmW5ZE1NVENt8FTbv3sSbqV4/ltc3nVKGMqD8Oxe/zjQwfjm1+viBmEF1/IBp/tkZzV0MKuEmYO0To7mIwX5hTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eik.bme.hu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdHwisL3o5+wS+mZ3HC0d8D2jatAiwPa2dAlOEpwkEc=;
 b=S6oWpTSxaE5HMJhMGnzbGGmlnLT5jaDhd5zOr8gxXDuOCuc40BesN9d5lKKLtm68g09LX37LVaQJW7dcDK8Xc1YwTJDxHNk4wxeqCHj6sg/P4bDVkVoAm8jCN07N3BodytI7YlAeae/YTiuoIcihEc4EyKjAKn5cvY4HZr9wJPo=
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:43:31 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::9d) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 08:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 08:43:30 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 02:43:27 -0600
From: Lei Huang <Lei.Huang@amd.com>
To: <balaton@eik.bme.hu>
CC: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>,
 <pierre-eric.pelloux-prayer@amd.com>, <ken.xue@amd.com>, <Lei.Huang@amd.com>, 
 <hsp.cat7@gmail.com>
Subject: [PATCH v3] ui/sdl: Mouse event optimization
Date: Mon, 4 Nov 2024 16:42:55 +0800
Message-ID: <20241104084255.1721-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 25afd461-805a-46e0-45f6-08dcfcacc260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1nqNAVIjyA0v/yiIlPiKIy0Lt5FxATRtQZo02IbxEftyRarNNjtAPFWteMXz?=
 =?us-ascii?Q?CbB8QF/B0Y93izROCXH3+EeDrnBXxkb+uO6d4IYt+FSlmOyNcPMDOno4Ksa7?=
 =?us-ascii?Q?nq1YPlyULtmL6HSJT3r7I8f9OfAToLyDcnQuCb48EJcG1pT8Rvt9UID39FOz?=
 =?us-ascii?Q?KYkDbMjsT2Qahy6NvqeWK/07BR+F5ycXxLOj51BkOO0uiWyTp9ZKDps0wdhJ?=
 =?us-ascii?Q?I8Y0GpIjyALBAryggtzTbnBtd1Jk9wnhCGsDUKqEq31Jpb+fPZ3kOTCkxVYm?=
 =?us-ascii?Q?HVUsN7hkjXT1yT4fiolvFoaFKhidDByr6C+Tv8Aya8JazEtchsx5qzElWo7O?=
 =?us-ascii?Q?WM5RfIJabPOA6oMN3YVdZwOfKUNTzDbE6N4bnBlQOwgJ83hm1/iT/4f1mLSc?=
 =?us-ascii?Q?ANNv6AuxWgNsUBZMZu77/swFy11H3nE/0XpSZ7xJXQRvUFIjJnl2BTMLOwqK?=
 =?us-ascii?Q?vGcYvSXJQ0C7Y7AL5Ab6qVkWa4p63Di/cLxT6QoFoIPNVi1Xby6coy8wo2cv?=
 =?us-ascii?Q?ABPRIekA87XOonO95rtRh2BYsV7zyDBiX5ZHnueuk6uZQbKzyVW/e9bnso1L?=
 =?us-ascii?Q?6J/72Rw4FgBfuSwMXdOMb4SHCLRnZi8GOHdsj95UDC1tcHd5qc+gRkSVv2XL?=
 =?us-ascii?Q?EoiMRK+ViqlmxQPBJvMOfi4CWDbFRrOZNpwwDiXxe5CglyZdZHVSeGf30DhS?=
 =?us-ascii?Q?YnkmujL/6gQRx2wu1nX1KZIfWWV4b6ADgqqoEx9egZV1g3ZkZOjiPs/ABb+7?=
 =?us-ascii?Q?qHOHm/gFW2rDcaWCJxdHgDOAmjGCztB/UZdKV0UtVEdLDxobtxToVtQtv32n?=
 =?us-ascii?Q?pVGtWqRxy42F+6CxiJ9eSfBWadZavEMS4bQU8j9CFVYG5EMA+dpA05BYOnIK?=
 =?us-ascii?Q?YRCHyt83nksLi2+Ik/rHesGNNmWR++Pn1e5A5Xsh2NXaE+aumyOAd6wfW+Nm?=
 =?us-ascii?Q?JUonFSPidsvdlqC0VR57WRp5FWMgRtGkPS+8HqtFWAa5rZp0TC5hhI04L8cW?=
 =?us-ascii?Q?30M4TDjona4xJZt52KRnGZxPSugF8+eD3fEP+tQKb1ipIcCY4Xh3Gem89pBG?=
 =?us-ascii?Q?3RlKSuMaFxfljnYow1J86WldoKN6nUrz5smYaSSiZS59jbil2PtlNAgJMjsa?=
 =?us-ascii?Q?Vbe+ETKaHqxVAXawJNzjGD3XQwixPiNJ171N7J4PrrGT1Q0Cwin40HrQ2yTJ?=
 =?us-ascii?Q?+ah4XuGpE3Re6o57Nz92XQ0sEh09WGkOuVk10RvugiZhw8ZpUR8gKkZ+TuU2?=
 =?us-ascii?Q?j71w2Gg9jGMfxzQCpU8DEbfMvCxUS1161s7VhGFXyjhA2M+wXZD733wijOTa?=
 =?us-ascii?Q?VTVHO4ATYtlu012IarDBdMjhoIYy2eC/6mQUxQkLDf7QVz0zWBCA7IOFtQhN?=
 =?us-ascii?Q?+4sHWuNQK0clsXicMLilNJUjJZ6XaY2TGUeb47zkreAuKeu6Bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:43:30.3869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25afd461-805a-46e0-45f6-08dcfcacc260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
Received-SPF: permerror client-ip=40.107.236.59;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use a convergence factor to make the VM's input
global coordinates more closely approach the global
coordinates of host.

Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
Signed-off-by: Lei Huang <Lei.Huang@amd.com>
---
 ui/sdl2.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da14..7c815d276a2 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -303,6 +303,35 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
     }
 }
 
+/*
+ * guest_x and guest_y represent the global coordinates on the VM side,
+ * while x and y represent the global coordinates on the host side.
+ * The goal of this entire process is to align the global coordinates
+ * of the VM with those of host using dx and dy. The current approach
+ * aims for precise calibration in one attempt; however, because guest_x
+ * and guest_y are non-zero values, they are not accurate values when
+ * they are counted out to become negative. Therefore, achieving perfect
+ * alignment in one attempt is impossible. Since the same calibration
+ * method is used each time, repeated attempts cannot achieve alignment
+ * either. By introducing a convergence factor, guest_x and guest_y can
+ * be made to approach host x and y indefinitely.
+ *
+ *           QEMU                             VM
+ *    calculates (dx, dy)                  (dx, dy)
+ * using (guest_x, guest_y) ------------>input driver
+ *           ^                                 |
+ *           |                                 |
+ *           |       update                    V
+ *           | (guest_x, guest_y)            input
+ *           |                            dispatcher ---> WindowManager
+ *           |                                 |             |
+ *           |                                 |             |
+ *           |             libdrm              V             |
+ * display device <-- drmModeMoveCursor <-- compositor <---- |
+ * (e.g. virtio-gpu)  (guest_x, guest_y)   calculates (guest_x, guest_y)
+ *                                         using (dx, dy)
+ */
+#define CONVERGENCE_FACTOR 3
 static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
                                  int x, int y, int state)
 {
@@ -327,15 +356,15 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
                              y, 0, surface_height(scon->surface));
     } else {
         if (guest_cursor) {
-            x -= guest_x;
-            y -= guest_y;
-            guest_x += x;
-            guest_y += y;
-            dx = x;
-            dy = y;
+            dx = x - guest_x;
+            dy = y - guest_y;
+            guest_x = x;
+            guest_y = y;
         }
-        qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
-        qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
+        qemu_input_queue_rel(scon->dcl.con,
+                             INPUT_AXIS_X, dx / CONVERGENCE_FACTOR);
+        qemu_input_queue_rel(scon->dcl.con,
+                             INPUT_AXIS_Y, dy / CONVERGENCE_FACTOR);
     }
     qemu_input_event_sync();
 }
-- 
2.45.2


