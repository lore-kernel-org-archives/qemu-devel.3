Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F71C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJRY-0003YJ-Cx; Wed, 29 May 2024 09:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sCGZb-0004oM-4O
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:30:24 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sCGZQ-0007Ez-Lz
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEwAm/8X9qFxCxgD9gIxVDfpgR+1IyeQ1FrjEqaKKZr2gdmV7fCl+JiCzFjgxHQAeyXIaFRyDnwpARn4gVAcdVenu9iyur7mSmKkzqpUDpSqB79FP35kugGJ7bixP9TiDxXIuVpyKp6CdoXu0Ly3o2Qi2AJJGlf8kcwfWz11at4ZLh4MRj2goTiPhiCEGy2lFz6lHboUgdFWgJwfu50Ra7eSpDa5p4XaPqOv+L3WJ11HtnO2W/HlYJy3DisOzMA4Zr1XPrmEJslfUsYiDkT0o3bKDc6z2OF/98DAp4Dz/sq7yhaYU5XsxuwmrbFPQfD9uAkYPZhtQjEa9jeitJDgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBJld2YA7d5lm1aNVoFxJHcgX3vLapkpPB/pM6/EHDk=;
 b=jnjsElIJlQVjV8nJwGTdwn38OdBVxutaAaFLYIzRt2FrfJ8lTO2+Ui765KWFwlslmArGyk00h4NBWhinMyRLEacaQLW1KfAR/MQX1fhyshju1uUxaYhai11kf26/1AElyezX8rbBJ9ug0ugZRoqGCN/8MLlRSRJgwF4kcm+fCFUMeu3Qd3Vo48M1Qh5f1mGo631CEv66FFZH5xOM15Pl0McghjqyPXdlql1O0RqnRifbgtlxdOFh0UOuKxac4h2VDc9en4xSsRxJi5FOZQQgCTJriUj0bekgghZ10JBlJuOkVX9ALjs7dgT9mMb8Rw9Sejb6TJLM0PiEgGAgaH6EPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBJld2YA7d5lm1aNVoFxJHcgX3vLapkpPB/pM6/EHDk=;
 b=ARIeLO4TM5VIuoQ3VY8X7G581GKPHisdyzRtUWYCt3Jv2bQuAWEGPwqE2vGf0h1rKb6BzYZfHaP1HmtK0krBNLcjZnHIMRfz0/qJ1bwSTHHX1JDiTTbB4YZ0Prl/yf8kMPhgB5ACYcMEfn+A5lNXpS/awkCKmQ3QztqbEXSamNI=
Received: from DM6PR06CA0043.namprd06.prod.outlook.com (2603:10b6:5:54::20) by
 LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:25:03 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:54:cafe::f8) by DM6PR06CA0043.outlook.office365.com
 (2603:10b6:5:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 10:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Wed, 29 May 2024 10:25:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 05:25:02 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Wed, 29 May 2024 05:25:00 -0500
From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
To: <francisco.iglesias@amd.com>, <jasowang@redhat.com>,
 <qemu-devel@nongnu.org>, <pisa@cmp.felk.cvut.cz>
CC: <sai.pavan.boddu@amd.com>
Subject: [QEMU][PATCH 1/1] hw/net/can: Fix sorting of the tx queue
Date: Wed, 29 May 2024 15:54:58 +0530
Message-ID: <20240529102458.557522-1-Shivasagar.Myana@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Shivasagar.Myana@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3158c6fe-a89b-4f15-4dbf-08dc7fc99a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZB2iVLCekS0xP0Zp5UGfCxPQlTW3F12PeP2OgNDh0isWqexHenndPk1vty97?=
 =?us-ascii?Q?Ys5sZRqLgoD7QGhXclNutyRgPqa77TelqkasbNoEBw0xA+vcJMF+k/A2h9FA?=
 =?us-ascii?Q?tpe4K1SV5/aLt7yGbGSj4jFdSznf2uL75Jqj9Gmt/Xw4iWCl8fFF/inpD1SV?=
 =?us-ascii?Q?GUyIwK3b7rw4MtTrtZvYcFldkP/XWZrKEbZdCEjv/FwslyqpHGbf+1QyQRIq?=
 =?us-ascii?Q?anwgXAoL9ZDlX7Jj2TE3bVlDyboJJi1T45wFb7dMLoeL9Z79j8iYl5uP+Mkh?=
 =?us-ascii?Q?FKjaoXrnTKmQ736g3FlAfWC7dYEIuj2HWlcNcmmT0+fy2NmMvvhW/YOhe+Pt?=
 =?us-ascii?Q?tgCbCy9iBqRx85A5XhMwyeRa7kuDsoegexIpH1MT6a1lcfyTaAoGWD0tcSFn?=
 =?us-ascii?Q?+9j+kla8r7QuC00e36qiUtJ1piOHel/SP71KYCcMhPUAtaCAcKFH//Jrw/DL?=
 =?us-ascii?Q?+Sh5hH+Cnx5vGHgqoFO+y56yd0S/h/IWXnY90mi9jzM5iJWwBmo8/DJyNG2K?=
 =?us-ascii?Q?r/XkTJDWDSfSq/hMvYeO/J8QfJULh9+MnglEcfuaYZXB1ONPBPi1azjN5DCT?=
 =?us-ascii?Q?vYKz2AQXeZ6kaHzFnGbOGzXg5uKbALzv2ALcRXcOjtwFnf29goAn3v1ZFjll?=
 =?us-ascii?Q?c/sNKcbhPe2RvzGaY4OHhWNvarJH8UBrOZtXETyMJ+iBJCuzCfJyv5MgkVdh?=
 =?us-ascii?Q?iFjvVsfw1pNtzPQsJ64PzQov2FPuT7iZ2LTfL2WDjL2M9ktgu0RLr0l94WiE?=
 =?us-ascii?Q?G5IjCCMCGxnuNg1cjnzgllfFJI1DoI5HyiDR3cMpL+6yc/NGE+OQqiStEQ0B?=
 =?us-ascii?Q?AH3rhpVc66uK2NRpJveu/1lUHrMVXVJXGKQuV4UAxm96KE+2XSQwDAWIuEce?=
 =?us-ascii?Q?8i9xvoOzM5tS2Uu+Fja3dhNbKXvb1kgnEPKtzUhlVf9A7m6MhDFURwUpTrR2?=
 =?us-ascii?Q?6a38dkd+uZI734PSbOfR9qKxv89a675Gj2oTOv/d5V3dSjtonf+XE9UfGjip?=
 =?us-ascii?Q?07G+VBUQiG9SFR1VxlyioRAgscWvbLhNKrzHGTDYileHdcSzjH3MhZmxHUxq?=
 =?us-ascii?Q?D11zw3geOrCm4jAOebnrbAkR2Phe77e9h1K5lCmh2koTXnBUMi7f5VVmFuup?=
 =?us-ascii?Q?8kQPEO5yhIv1KhT+3BCcJWUNvGXLm1VouSb9MdcKm6VO6BiesKWhfUFLXMss?=
 =?us-ascii?Q?yY6pKBRapkKN4I66udpFyM53ncyCcNOIhgsvBTKTo5nGQixH8rEcDyVgRNxM?=
 =?us-ascii?Q?4N8optKcLp/28cPgJ8xhFpWNEciSKlfiHdLMdckdThEi4LtUL9I6URk75VD+?=
 =?us-ascii?Q?x1hxfpVUnGJrSacH6ovIggbP35SRrAB4WkpIFv1w/BX7lk6i1QanLQBOhHZA?=
 =?us-ascii?Q?rXSrk7CzzMF/rrDegvl0beyw/1EK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:25:03.3316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3158c6fe-a89b-4f15-4dbf-08dc7fc99a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
Received-SPF: permerror client-ip=40.107.236.41;
 envelope-from=Shivasagar.Myana@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 May 2024 09:34:07 -0400
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

Returning an uint32_t casted to a gint from g_cmp_ids causes the tx queue to
become wrongly sorted when executing g_slist_sort. Fix this by always
returning -1 or 1 from g_cmp_ids based on the ID comparison instead.
Also, if two message IDs are the same, sort them by using their index and
transmit the message at the lowest index first.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
---
 hw/net/can/xlnx-versal-canfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 47a14cfe63..5f083c21e9 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1312,7 +1312,10 @@ static gint g_cmp_ids(gconstpointer data1, gconstpointer data2)
     tx_ready_reg_info *tx_reg_1 = (tx_ready_reg_info *) data1;
     tx_ready_reg_info *tx_reg_2 = (tx_ready_reg_info *) data2;
 
-    return tx_reg_1->can_id - tx_reg_2->can_id;
+    if (tx_reg_1->can_id == tx_reg_2->can_id) {
+        return (tx_reg_1->reg_num < tx_reg_2->reg_num) ? -1 : 1;
+    }
+    return (tx_reg_1->can_id < tx_reg_2->can_id) ? -1 : 1;
 }
 
 static void free_list(GSList *list)
-- 
2.34.1


