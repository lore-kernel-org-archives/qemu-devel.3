Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545B2C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwdQ-0003v4-Pc; Wed, 16 Jul 2025 03:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwdO-0003sa-K9
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:32:58 -0400
Received: from mail-dm6nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62a]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwdJ-0000Zw-LA
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:32:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiOkWZmcH6L26OFhtw0XiaDBF6nBVOu6ib9b3vWzgiseDdGCue1Fj3BjWOU5nkHIx3MAIpsEjQSMxgSWaYv+vqL+GUEkCyaJojjLbVr4vphVOe8yIuKY2F+m08s61r7pk/0/jxqgl4xVhqVIaColBnPHidEUZNtFi2fCpKhVlLu0pb/1uldFeskk+d7IrE6wT1+WZnsXwUI5iyAzpPRVadl879FULQp0bvTHBdMBjNkob7g+f7nnUFoLjjZ2//wC0YfAPmyD1kqKNIkLLBD/niScWf3wktIV6RPxBEKz8lHNVpL3BNPlEj49KYQ/OEGIEhPa/AMxEaxD7xqFp0Rv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNICQsosgov9Jys/UJLKTASL6d0v3SuAzELv9lIptms=;
 b=ZPWPkgPGbxh4VHQKXrS7BxFyCoG7VzzpWztqe9JQt1GdEAtqeMWMXB6KZ36ayRE9sIRTK8WQc3xgMSZVsNghmedSRM3iJ1Qve0Jl0TOQbCf34xmnCezJBqcLUIzn8fHzP+Dpjja1RQy4hJy8zFf0eTxh7UuInG2uO0zpGrMDJlYwqVRIOeT9SqldxmvPSOAYUvJGg71ZUzeJaMWYXhdvvErvUbe3Fu3GSy10YJqvHJwgYd/Q8Q6JtJK1aR02cKEBb0zFXMHYPwewd28UEb0ok24dniW7Ey2Web4bNLPHC2OjjC/DZIHjDfJgULB9sVAqOm6DT95xcliFqPU0zEOvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNICQsosgov9Jys/UJLKTASL6d0v3SuAzELv9lIptms=;
 b=oT3KlaXONlsZ1Wx1N2kzDNzypkFWPevE6AF4NGxu6Rk2zUJLT0hR6OLn82FHrDg7xbQd2dA25axBd5NR7uLQLf0+07edEuzx0S0KMJj1YYy3V0Ba2ndqmHE3Q7OLE6pW2boGMJY2YaXRPffnCwCON+qGsOS+iA4vZp23gI8q3vE=
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:32:46 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::b8) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 07:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:32:46 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:32:43 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH 2/7] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
Date: Wed, 16 Jul 2025 13:01:40 +0530
Message-ID: <20250716073145.915-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073145.915-1-sarunkod@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d2d870-f742-492a-3481-08ddc43af589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zCNKYeOpuOE638kSFyYhAG8ffxSivUmyf7vtxpc0J7uHFi4ebBphIulEdpoq?=
 =?us-ascii?Q?Wl/sw3bH+x/5dhFXYg7LX5ap6xV1M5s4PkHa/nC1kvtIaq8L7rDEBLDiI5tv?=
 =?us-ascii?Q?D5wBXX/QuaQmdJzLiIpAFXy3axvFV0j8RBobIeC69WphbWyqilA+tCN8kH6A?=
 =?us-ascii?Q?tJ2AswHsHDh3rvveSAHHIjqrr9FzlkfCXvG4KRaqEYhI6oSez1MVkh28Yr1W?=
 =?us-ascii?Q?nqP7XfFDlBEcJ+KH3w6CM5ALjBZBYf1JWZhdkog+/7MPPw8aOmwqDTSApAc0?=
 =?us-ascii?Q?JiKeJYzAoAOhd/8Zixzib2+NOMrozIQdbdlSw2KAnsAogDRTvA8P9kxxM321?=
 =?us-ascii?Q?jE+xmQARNA7NbFIvlz1eWATelkh8/0W8JQS10iNcP9VwGWHTQ60/2VembO/x?=
 =?us-ascii?Q?Dja6fPgYf8ay/4yrFUKJdxFJRaRCBfpBrD3lBeCRcBJg6EVQQjaGq3UzIG+9?=
 =?us-ascii?Q?CW1S1ScN8cDySFWmyuRnK3SxrQLve7OSrbvSCC+XKXRaTK8O67KAIIWvBcZ7?=
 =?us-ascii?Q?5hYgMa7WyCIwi4/WEnLKhvcwdAGfLnNVkMfp1kUJ/h1j0P1iJTvs5DSF7Mru?=
 =?us-ascii?Q?tgjDUH+XwtqnCH7HsOBKGP9ItHkhq7mJ4sf17mLLuZeGITRFf5ZnV7LGDFwU?=
 =?us-ascii?Q?X+1meAkfFXAc9vxDqvLqfXBO92dvrtcwm8Am+pO57qsYfIgKcTgw+ZECn7KL?=
 =?us-ascii?Q?Tf0VZQHpmg8etsL31MS7thivSaXq+UMD4qmm9RhPmrHWEQ8hxhiIbria8Udq?=
 =?us-ascii?Q?JlFBjli9bKMptwk0nBS9vE0vK7U/NnbmTnkqrIOUlQoYHRRm6ugo3GVjWJLV?=
 =?us-ascii?Q?byGEl84WMrXS5QT8Ve03kOsYjuOZzTMV2qYxyBCr2wqhSlHaWc999f1S5NHK?=
 =?us-ascii?Q?TrIg4guptqYgWgWUD7DwkzJn8j7M8xBG2JNq/0pFw5CRhL1pV+rqh3ZvHT0y?=
 =?us-ascii?Q?GwJ4WKPYAqpXVpdiT00Z7hr/4QaGOG9hPaSFNx6OSSsU0bb2cYIWHexqHVCk?=
 =?us-ascii?Q?6ldBbar7upmJ7W0tMTNf4SLffhZ5G7F5M60yc637h9lUnIb3Dp7MsgEKkFDn?=
 =?us-ascii?Q?6s2SJ9fJeed8Hkl82oN/h8059F2eAbZAdfawPagNV4B/CigP4maLnkLCAwca?=
 =?us-ascii?Q?mBjOpAu0UgA9UNR3BhCaXO9nLW5jMdpCizQieKmmTn5xuaLB+/YKzhFX9jZw?=
 =?us-ascii?Q?MP3NnG+mKSZ0O5crGRPTMpxn2JNFrZx5e2x34sa/qCzoWyf/5k8zSspu5FI3?=
 =?us-ascii?Q?5awHl+YGrsjsYPSarSjwX+aEO9uo6A8020D3s3O9QdUy/omhi+WvGjp9Fd04?=
 =?us-ascii?Q?jVWb7xbGbJ07P7/5haqx8D1PDuPi4njDjV7E0oaQ/d80Vy1c38j5xgldkh/7?=
 =?us-ascii?Q?HqTXrtCTCFTD9Nfm+Lu9azMyIUOxm0HYPpPV3YPKpugaWbLgZIGU8OiPw8E3?=
 =?us-ascii?Q?EcTJ/QuE0JiN3l7CUZd3wH/lGkZdh2/+sQz/ei3vP2/YcFPZns6X/T2sDEq5?=
 =?us-ascii?Q?efdm/nk8h2Tsj/9BgoLwUwmpoE4ID+/I0maG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:32:46.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d2d870-f742-492a-3481-08ddc43af589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
Received-SPF: permerror client-ip=2a01:111:f403:2417::62a;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

The ats_enabled field is set using HTTUNEN, which is wrong.
Fix this by removing the field as it is never used.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 2 --
 hw/i386/amd_iommu.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7a9d90f00bee..c8fa98142940 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1412,7 +1412,6 @@ static void amdvi_handle_control_write(AMDVIState *s)
     unsigned long control = amdvi_readq(s, AMDVI_MMIO_CONTROL);
     s->enabled = !!(control & AMDVI_MMIO_CONTROL_AMDVIEN);
 
-    s->ats_enabled = !!(control & AMDVI_MMIO_CONTROL_HTTUNEN);
     s->evtlog_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_EVENTLOGEN);
 
@@ -2263,7 +2262,6 @@ static void amdvi_init(AMDVIState *s)
     s->excl_allow = false;
     s->mmio_enabled = false;
     s->enabled = false;
-    s->ats_enabled = false;
     s->cmdbuf_enabled = false;
 
     /* reset MMIO */
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index fc4d2f7a4575..62641b779ca3 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -368,7 +368,6 @@ struct AMDVIState {
     uint64_t mmio_addr;
 
     bool enabled;                /* IOMMU enabled                */
-    bool ats_enabled;            /* address translation enabled  */
     bool cmdbuf_enabled;         /* command buffer enabled       */
     bool evtlog_enabled;         /* event log enabled            */
     bool excl_enabled;
-- 
2.34.1


