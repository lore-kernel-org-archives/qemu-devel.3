Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E71BD74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 03:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5zfJ-0006At-Rg; Tue, 29 Oct 2024 23:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t5zfI-0006Aj-34
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:46:36 -0400
Received: from mail-bn8nam12on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t5zfF-0004SL-HZ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:46:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq/O6F9Jdl6i1GI6MeM5q3tZSGGGMJYS+LkhpsotqDPcbLG2t6SqeMNq1BTHi0SWBioQ7+3WTI4UluGO848uz6gDB8H0YWNkvQA31xl+8rD9sDVnCLvbUTc4uE5X21DrHl3IK+r4YZRWDZnToekX2K3JI14NUULkX6LuYkYztgI5NufVC+U7hRZ6YmVcgsBIRLcrQx8vmNV+jgBu+Lk5QX2W8sk/3CdOjZOtq4Ak1jAmfElozoBi8oPQBf/w+FGmdzCfDOOvymjwg8ZxBZAv9I1pfBbJKE5X/DvRv1nxr3KzsJxIWskoVso36YYw9FBwxUrQcjo7LUij8JoO3tChJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybMgaK8pm9IUCREVombtuH2yv9X1g5GCZr+oie9i8nI=;
 b=UknZIAp3yxNg0SzgBW9ODMzPl9zpYk1mjAuao2XlOrgmfFmDLQ8y9XNd6/TVvKKVlTYClvSUGyjqIIbtULlGGh1TRyEUrs0VJ97nOKL/Z1YdXr2bpglvKLPJCloytSDQ+wU9MjrymcQe673zkwGzn1n0L4RxLsNoMSA6MIV20EJc6BEBUlec0ck+T0UJmu0R+UjOMKqr5ntJQXw6iLluMJuxwXzUc0iegWbYCTzJbvljGPdmd1E74RCF79hs4IoufhOxLE+4ur/xtWIWqLlI3QN7uK3ax+lUaOaiQBVWAD2TsKoFavonrZYlXEBQuxJIycglkDPe0kJRvk5NlZZq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eik.bme.hu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybMgaK8pm9IUCREVombtuH2yv9X1g5GCZr+oie9i8nI=;
 b=WtNnLfaiEs5XyZcuL2Y+ThaGCC+mBVBR7Wpbnan32HVz6qsCvt1J5xuKhdYwRP5vaVre91Z3hlBOiudQl5zQuV98UKaMnFp1g8HWlm0ciKk371NZMQl+xkyQonmAFA7f6wJs2/rRPpfGiPLVgD8DkCh7HE6o/9XHVNjZ+NcbLLo=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 03:46:21 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e0) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 03:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 03:45:36 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 22:44:24 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <balaton@eik.bme.hu>
CC: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>,
 <pierre-eric.pelloux-prayer@amd.com>, <ken.xue@amd.com>, <Lei.Huang@amd.com>
Subject: [PATCH v2] ui/sdl: Mouse event optimization
Date: Wed, 30 Oct 2024 11:43:53 +0800
Message-ID: <20241030034353.1588-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20241030032014.1564-1-Lei.Huang@amd.com>
References: <20241030032014.1564-1-Lei.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff33ece-e70a-4c71-36ff-08dcf8956ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvjJrHSVLRwFIly1jRk28m6IxnY8L1sNG86nYyO46NjsSjtIA0dCWujbvSNF?=
 =?us-ascii?Q?ruOmUdXbxed6Nuhhl9Pzu47wn1q4mpLqrFEWPZeLaGZwOWu/AQ+ml2p4j5L8?=
 =?us-ascii?Q?BS+e3ls+ABUpsD/xOldI6r/3G47j2HZH551Pjlvpad0QUwx8IZjT4wOHHDuW?=
 =?us-ascii?Q?BGjfGdQreCeQ++r6/+YnO1k9qm6meTsfKge2JcyJq534vmCaUp3U6WiF2402?=
 =?us-ascii?Q?DKmnDqvdnb3BpJaVr/yMbGu1NYylK6CNQIHV0Pj16ZPkGepkFYB5V3vwzi3G?=
 =?us-ascii?Q?At01yoNFZUL0BaJFdXU0i44D5s/GDEYoCz55gpjVKaOfTpSonCVX2WfjBbZT?=
 =?us-ascii?Q?S12hkqNOrQ4n+5afD57j0TR12lz9x7LxI5GX+dE1tre0Ghqa5/3bD9fcqQSU?=
 =?us-ascii?Q?DrdeWoSO+x6VkcDDPSxpCRMeSdYPS9JNKewgKsfKbkmGphRI1KOyjkBP5cxQ?=
 =?us-ascii?Q?2aavF77S2qtd7BNrmBbv0hv2RgBC4yn7xBxXf1gROso+pqF6ne9pdDFg2PQe?=
 =?us-ascii?Q?sDOEzwWmy5LvjxjdGXqTK+3h7Rw4CvA88vqPn74GulSJu2BdKtcTlIyknXrN?=
 =?us-ascii?Q?1CUky0zZ9IIBt2ScFYUrBAxJpxKx8Tan26TccK4VvUAwm/w7p+dvJjISzDPf?=
 =?us-ascii?Q?yOWxP4HDkIAnaMcJUQAh0/gYinL0e2YqMEAvW0TIsw2b3om7Wb8ts5Giqj4g?=
 =?us-ascii?Q?IXcs1gZZvlVpXfVKQy1hK33oEQzmLNVn4ZRO3GB9zme1TEr4se0dGNTlJ/TG?=
 =?us-ascii?Q?6EAfZrv9R888SENOUEjH5y/LZc9FzkGwV0E1QjCOEr8ldVJPNkVzwBGywPCS?=
 =?us-ascii?Q?fDP2n+N59T8Rta90Avyj2GJeyYEaHc8/CLdvBGK+HLRSoAWrdxzD5jYPk++A?=
 =?us-ascii?Q?qRcc/4KhPoi40riPib8nKr6le2GkEQn006s1a0se69QwPAsQrWX1vmwHpDUp?=
 =?us-ascii?Q?9H8/3N6zUnG6jlqY0twd0QXZpsDVFm7H0BZgSMpOKDcFpYhxdH7NIVOznfiP?=
 =?us-ascii?Q?NvOxRomi7rJzzW4a7vqF+P9Umq/mtmqrpqDEfzjii6RSFltPKdDJe+LYxsYl?=
 =?us-ascii?Q?yPRmEVkURCqedQfpndYOHizcgS0WYv04OMay6K9Mu0shJz5ESnEN2dlfmcbG?=
 =?us-ascii?Q?iOj7HfPVn1pefCG6CcBnr03t/YpPJlyH3inbdF0dFe0VhDjfJ0G1JEFK9xWB?=
 =?us-ascii?Q?Ljl9/CY3zPEJlWKq/aSn/QcZjitMXc0aZelU0SoJg6HQtn3ewYf0N+BtG5V2?=
 =?us-ascii?Q?kQnnRJpFetkxa2GDi0NMyZZWAdXqiv7tZgSor3WZryn5wTUyTFJTthT/x04c?=
 =?us-ascii?Q?sG4OdkNxlI/4pwdzV1wMXq2vEbHDjMf6X/1toD5RiaqoJL0/s/Pq3Sm0bG7/?=
 =?us-ascii?Q?3U3UMf9lCh/ZNUg3jdP6x5ARPeq8cO1ozGaPgQuyPp7+UogmWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 03:45:36.2204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff33ece-e70a-4c71-36ff-08dcf8956ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
Received-SPF: permerror client-ip=2a01:111:f403:2418::62f;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

Use a convergence factor to make the VM's input
global coordinates more closely approach the global
coordinates of host.

Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
Signed-off-by: Lei Huang <Lei.Huang@amd.com>
---
 ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da14..ea3fd74dd63 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
     }
 }
 
+/*
+ * guest_x and guest_y represent the global coordinates on the VM side,
+ * while x and y represent the global coordinates on the host side.
+ * The goal of this entire process is to align the global coordinates of
+ * the VM with those of host using dx and dy. The current approach aims
+ * for precise calibration in once attempt; however, because guest_x
+ * and guest_y are non-zero values, they are not accurate values when
+ * they are counted out to become negative. Therefore, achieving perfect
+ * alignment in one attempt is impossible. Since the same calibration method
+ * is used each time, repeated attempts cannot achieve alignment either.
+ * By introducing a convergence factor, guest_x and guest_y can be made to
+ * approach host x and y indefinitely.
+ *
+ *                   QEMU                       (dx,dy)  VM
+ * calculates dx and dy using guest_x and guest_y ---->  input driver
+ *            ^                                            |
+ *            |                                            |
+ *            |                                            V
+ *            |     update
+ *            | guest_x,guest_y              input dispatcher ---> WindowManager
+ *            |                                            |                 |
+ *            |                                            |                 |
+ *            |                 libdrm                     V                 |
+ *    display device  <------ drmModeMoveCursor <------ compositor <-------  |
+ *                            (guest_x,guest_y)   calculates guest_x and
+ *                                                guest_y dy using dx and dy
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


