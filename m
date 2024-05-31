Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9140DC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCxfX-0004Kh-0e; Fri, 31 May 2024 04:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sCxfV-0004K3-Us
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:31:22 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com
 ([40.107.243.75] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sCxfT-00074Z-MJ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7DwQ5+NqabgTFkD2kwZjXmWqfnJt0UTtQY+OjGIlxb0x7Zbir/Mwk8HfEiTKhdz7NpQAKv3x0L4HyzlPQtesz/jLTJxxmvXw51Vz9AO1qArFRcYghrjWTkh/G65+6IAdqcjIFoi9iNeqLFrZP3rJcBXE1Vlu3kyNhdfeBpT5Av9c+BNuxc2gpCwPKrYsaRKxjAdUe+seCLuBtWrbhXR5u/KUa76GHOcwgRagiwCeSkCduSoygLqW0fRJcdUzSTefW/dcKy1unQ33tCT6P4BsCYp8KQwmZv/rkoVXfxb4onvs96xX0j15xdkhgRRBs16amiSrQEVTy7OCHbC2hJ7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vVHz4HVcJQe7w+BiHRlSDOh9HoY/2aA5nXn/L1KWkQ=;
 b=TI2nz/UIIMpZY3StCK/R+YoZThG0Ku8R8fDmNUfu7TWil+LRkUdr6I3hObSHYByrP/aZaBjSfT2mX/cpFL22zcdGhvFHK3h7/QEjy+QXF4efOMVtQOUJPZDKC/OmEseP2JiPcF5Fg4rBDTXoS3pghPjDjzAnq/seNulSiszSS9VX6078FwGFMWvGsZhtBVeaWDapP+XJhGQj9aSdr5QLWuX+wKJ08nQXS2xbOPao8KQj47yG1dhxNCHruPU6oKmRGhXnNKL51XNpwKS62hz7GvcPdj5LgP4VQQCHz+NnBeA3KZn8llLLrNq6FQJPiDslHlbUzF0h9lR8EinqC9E4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vVHz4HVcJQe7w+BiHRlSDOh9HoY/2aA5nXn/L1KWkQ=;
 b=A+Y+EzuLF1VKrSu0UwWk/3sAvVIzvs6v7rxpegfjgOPa1rpyJN2/S/BnIfgg0yPcRpoC846qaLXpf8bLMN8lPnYbQlvaFWxFN/w2KBOZ2zbwDvITpMb6VzN+/s8WY03HxDBbTnbGDp96+P+1pn9xoiFTEPV2Mh2UuQIsBrdQ34o=
Received: from PH8PR22CA0016.namprd22.prod.outlook.com (2603:10b6:510:2d1::9)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 08:26:12 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::ef) by PH8PR22CA0016.outlook.office365.com
 (2603:10b6:510:2d1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 08:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 08:26:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 03:26:11 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Fri, 31 May 2024 03:26:09 -0500
From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
To: <francisco.iglesias@amd.com>, <jasowang@redhat.com>,
 <qemu-devel@nongnu.org>, <pisa@cmp.felk.cvut.cz>
CC: <peter.maydell@linaro.org>, <sai.pavan.boddu@amd.com>,
 <Shivasagar.Myana@amd.com>
Subject: [QEMU][master][PATCH v2 1/1] hw/net/can/xlnx-versal-canfd: Fix
 sorting of the tx queue
Date: Fri, 31 May 2024 13:56:05 +0530
Message-ID: <20240531082605.2306976-1-Shivasagar.Myana@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Shivasagar.Myana@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7645ba-2966-4381-4da0-08dc814b5499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?opdOQCZxMQJEFYrDlVKSpouDUEj/NqmzSl+3tFw+PsLCtlk620hv8d9nW1LS?=
 =?us-ascii?Q?ALJ6okFH+eVHeX0mKAPD0XjXJRQx82ChDrZ8OPFwaKNZShaaon6MdEJQUOOd?=
 =?us-ascii?Q?KledWRTaEqGR1uUg9ddcPwKpLwVMUsqf+xx3yZkkue2o/mB+0PJdzczogU8g?=
 =?us-ascii?Q?DJUyW+HDrB2oztLMpfPL7W/ZC7A2Af7gnaxCGmkFeLipLZx8GaI7oseOk78y?=
 =?us-ascii?Q?TTZRiRQt7yS7f3WvwGpFjOaOCRLEx1UaLB/eZ/BGGmuj02JusBCEi3Ta+3kq?=
 =?us-ascii?Q?W7HWKKZg4a09Lj/N6KhEHMF/VdEa07gU21iCY+L9zIdmMmB54NHV75XR9XR9?=
 =?us-ascii?Q?y2uCfX4NbghY+fg6sgqcMSkIBS+el03sTHjiFIrykb1PU6wSUDnRrcIU05ny?=
 =?us-ascii?Q?8X9Mk6/ZroDEEdgFm2Ewhhlw5a/FOaw7CKH0USb5PEOWfIy4XAF25V3yb5Pp?=
 =?us-ascii?Q?unhxLQOQiZu+A1tiQfrbihQmOLZIWWzKlsytqkuaTNc6UUSV1DHTOO2OnQOx?=
 =?us-ascii?Q?S31zaAvzxpKly0e2FJSAQCMZYuyI8ApfP187JxgVLlZ5mt2h8tGyipUKrzNm?=
 =?us-ascii?Q?raZLYAUOidqHMIcyuKhE4HDQVNNixPWC070TitZIr6SKpn2Qu0aWvFAT28fJ?=
 =?us-ascii?Q?Vt53ld+jbk7A1AqygAFwI23cwNwRkEis1+zjUpu/UKyxAvaV3QwM2kGHK1Pe?=
 =?us-ascii?Q?nFW7OHZBEDwI338vdo+4E3M20u4J6tjR1Yj2qSjfaqGzm1NvxqNrVaOWmCbm?=
 =?us-ascii?Q?7yjnr4M4VcykOe1TYd5eB2F2aGhNi+1Hkjo39KfTeLQC7SRW9G5WEHQ5n8GL?=
 =?us-ascii?Q?HVarKPkdA3Ocl7BGMh0gZd7hmjR9WNdgS++Z84fv6582m56KYVchLN01bqwz?=
 =?us-ascii?Q?9AS/fg1qGz+bFzFeyNH4/261dZ8gDpwHXCGn1eDeEVXYCj+1fIAn+2+sbV7n?=
 =?us-ascii?Q?ax62Gd3aTpa7I+Usi9tUwN88oPIQ3J4yY/ketiECQws3ATkmrlICcc1eiDms?=
 =?us-ascii?Q?FuEA3BaLasUx2dz7Tmx2b0I1SbaZt6BkGliuSQEs3euYqKdzb8rNSlVxEx1x?=
 =?us-ascii?Q?9w4LrOvJZBoMTpg3Bpt2vHoEcrWFKu6tJtJ6pYhoah+V3rQqdd26TIoXLqLf?=
 =?us-ascii?Q?QzbVBgbpg/g9QXt1xm6k2GxIpfC5Wa4kLITAk8m96g5ryHvlujjofXs6mQeo?=
 =?us-ascii?Q?TakcYucE4kU1EbeCEQvHkDB/S653sTUC+7evdVE0hoUe3Zt6Pa/QwzvKnCXL?=
 =?us-ascii?Q?j6hIcW8f9bIgvXzindUWYSL6LGg2kbViLBLw2MKO1J1sb1SDH0pZtUH1OwYo?=
 =?us-ascii?Q?71/zGbpZ+KlvYJE83PB5mTgakbfDUYln8ydmht6Z2afFfYaVQhcpvlfi89od?=
 =?us-ascii?Q?ApExDgUDgh0nuOfMzYj70Pd3MGrY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:26:12.1006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7645ba-2966-4381-4da0-08dc814b5499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
Received-SPF: permerror client-ip=40.107.243.75;
 envelope-from=Shivasagar.Myana@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Returning an uint32_t casted to a gint from g_cmp_ids causes the tx queue to
become wrongly sorted when executing g_slist_sort. Fix this by always
returning -1 or 1 from g_cmp_ids based on the ID comparison instead.
Also, if two message IDs are the same, sort them by using their index and
transmit the message at the lowest index first.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
ChangeLog:
v1->v2 : Subject line modified.

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
2.37.6


