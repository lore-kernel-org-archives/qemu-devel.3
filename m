Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A393C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueplr-0007gl-9V; Thu, 24 Jul 2025 02:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uepld-0007TA-FX
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:49:29 -0400
Received: from mail-dm6nam11on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2415::608]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ueplb-0003Sb-Es
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pixokpiZVH0kpl7Dszir8SzLffYyo/UiTmfb3BBw95apsNb3EHDwupt4ahB7pYhDYO1r4abWsCpUv/u4AH7sasbKIr7ivbIkAoeqAsEQYCAV2BcpvqgzPGn5c53hRCiXru3Rb+kecr32rBLAspoNm6jyPRqqs2vJEEQGhRUJz2qCyVHuR/MP61uK5B3CgTl09g13O7+kYIgWvYbwGc/7xtPob863lOemq0tbFvHdtLjSwmtFagaj7/O+oCam1oEjhx27tBImJWj+A3jhxc/GzelsJSF0oHxx6QqHDTkJaiJP4QEz2Q5jO6H7T/MAWF9fYqEl9FyXQ4Gc3KPQaVRniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbwOfif7VvdRWSMK7RhVNMW++0YFvOrRo1FM/srT4Tw=;
 b=rvtFkACTS83KC7Y+wD63ueEbzwsyenu/lx81ZdoMiP+eao1VREFw/5iLLPHbHa3+7kD/4XJ3c9DVQgrb2dJaGg14O3B4X5kWw+doE3Hjv3/x2k0LX3NhQP9+UIFYpszg5yQX0TArGYrEsM/iyfmlUA+iKRq1qm3fvdrGYtSdfYJwxF/6tBMD8rJfQZvo0T4FwNCecO55P52zKC8z0i7ZB5n+msZwLWt49XyNT/plaN5N7IDHXB8+iF87Fnzoe/ONHxo3dCY7dh+jiukA54fTCWwgGSQp1GgA3UZesGp8TDKhvo50DkI5APsehIrzhtwsO5kl0mZHu7Vt2JjzZjZDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbwOfif7VvdRWSMK7RhVNMW++0YFvOrRo1FM/srT4Tw=;
 b=WNnvv4XW1dNy6zeUvM1TmfuuTURcq5tghtZsAeOPK8cuKWOP7F+qQolJ2WoY6hoDXwdCvM0zv9ZhJSV6MWMwH6g/3yd42z2UJ5t4TIWW8bGcViNgJEVama6zzXo8Gqy0OgUBsVNBtwFIWqNEb/IaKOrAjMtHBLkjeXwnznkxAu4=
Received: from BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40) by
 SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 06:49:14 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::60) by BYAPR01CA0027.outlook.office365.com
 (2603:10b6:a02:80::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 06:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 06:49:13 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 01:49:07 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, Sairaj Kodilkar <sarunkod@amd.com>, Ethan MILON
 <ethan.milon@eviden.com>
Subject: [PATCH v2 4/6] hw/i386/amd_iommu: Fix amdvi_write*()
Date: Thu, 24 Jul 2025 12:17:43 +0530
Message-ID: <20250724064745.4091-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724064745.4091-1-sarunkod@amd.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ede8364-b57a-4227-5c93-08ddca7e3373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?thgu5knym+Rhd52fwPhdsd5yudH4i9ZZkQsyZ+5CWLyhlaZInMZHAnN5BM/g?=
 =?us-ascii?Q?g5ymNxXrFzbW+dQ02p/yAwrHQ+fbhGWfoz+bzCuqgxoARZTjjqjHXX+wSoZp?=
 =?us-ascii?Q?U3By40J36ThNlbUkVLM94tPVSNaN+1Gdc+6aJUe5krf2aRvalYLsac8S7MJM?=
 =?us-ascii?Q?tdJawkLdkoJnc8IM17BHvpITRziT6VvtVjc4IPFU0pY2DcW+cpE2Bhzj9xa0?=
 =?us-ascii?Q?a3coB9yunn1H9Riy+yflKL3Eqrz+NnYz7S0c4z+PYeHGatyWJNLTLmxdXIcK?=
 =?us-ascii?Q?/Z6cgi3qUndFwiAisIqoJqrlZoPMjpVLQfMhnH6BgaZRg2Jyq6pV6pwKI90S?=
 =?us-ascii?Q?+EgI7eKk00Gr37RhyE8IZw2XtoJS8i+nJZjnMAlBkgCgafdNjiybRU4MAd8R?=
 =?us-ascii?Q?uTgjFzBtY+Vq1dWx1JEEefBupWm17ZDms4gEXIMvjGD1IdJU3ZNn96OTTY0X?=
 =?us-ascii?Q?jG0LYke8O4m5dS/9FQiEJF/W05yjQKHN+hVESmyV0b22yOjb4GXew1IESxMe?=
 =?us-ascii?Q?mLu8pCBXodQz7SpJ29fdlHkbmRrda/IdCGfQz27PDB5Ly/j6lZyImeRzjATK?=
 =?us-ascii?Q?PjyiEyaLwCsng4xT5CmztglY3pvxWxjzD0341LAU4GhhQFCJ0f4KM/TGKvxf?=
 =?us-ascii?Q?4YJ29NhE3IVEtAv3+xUZaQA4FRSJH0G87wJiJ9pneJutVDFmqxitKovFY6Q6?=
 =?us-ascii?Q?p0F/gqCEMBhSB/5WIPGcZWVi/RhKHyz42RMRbkJftKEtbcTKnk629ZacnDTt?=
 =?us-ascii?Q?oWJXBSohAvYiwURyz9feR/1FEh1tKNX48rvvkd9ebxAkVKjD70tDuXIEgPby?=
 =?us-ascii?Q?EL9x/VfvIx5QnaVyUECelvODt622YSBRuB5Sm+P92HNof/LWyI0xqVy/P1ud?=
 =?us-ascii?Q?z1MMcwyB/mTH0xZCPy2jlv7lo/hQ1ouxt2DbHjpUYATCvmeSziWJcRafYmR6?=
 =?us-ascii?Q?Y4/v3+ZgV3ptpcNMm0qTAo05b2mdkkhxx/FuS1LMAxz/EJfTXLXcppMLVzyK?=
 =?us-ascii?Q?Mgym9Z8tu32J2p0ZIGTe3T/Z8aBzw6K8NRuzfh03Dhgizq104Stz6DoezYej?=
 =?us-ascii?Q?ZnffWgE5HGeUBm7HTSEtMmjTQilZn+vu6TC0ppc3OSenfRVMMra766GRpDyI?=
 =?us-ascii?Q?6RJ32NDhHweD6xIqhRtL6/JOHNRzvu75za5MpEq0aHb5IqE4G3rVf+yha4n0?=
 =?us-ascii?Q?hD0aZ1RqS+rm9HypC6gIhEghKeZx8YH1oAoQNWWwuJPtWD0puN6KG1+eSWuL?=
 =?us-ascii?Q?NnILhNmD+XhyKt7SVOBsKY/ZANpX/RaGIrRdN2mVODZiQWqeiOdvOMkPNbE9?=
 =?us-ascii?Q?Y//W4BAim3+pgYbHNIT97Mt7WdjZ7GzApLGckfalcr3GoToGPCPHQC+Of/tz?=
 =?us-ascii?Q?US7Db4peXrOYZ+BeUYEW327ZP95H9PL+I3pqWvVbNRjEvNlEi74Uo7DE9X0i?=
 =?us-ascii?Q?hS8KWNQIR/+fhZy/OJUilz8CY2d86zJcp290EBRlWeDKizAeMHsIpDaGSHAb?=
 =?us-ascii?Q?qSoa3uw2BHu1Ikp97sD5hp+DBqCJsygO5Gel?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:49:13.3023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ede8364-b57a-4227-5c93-08ddca7e3373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
Received-SPF: permerror client-ip=2a01:111:f403:2415::608;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

amdvi_write*() function do not preserve the older values of W1C bits in
the MMIO register. This results in all W1C bits set to 0, when guest
tries to reset a single bit by writing 1 to it. Fix this by preserving
W1C bits in the old value of the MMIO register.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Suggested-by: Ethan MILON <ethan.milon@eviden.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2183510d227c..bbffd07b4e48 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -124,7 +124,8 @@ static void amdvi_writew(AMDVIState *s, hwaddr addr, uint16_t val)
     uint16_t w1cmask = lduw_le_p(&s->w1cmask[addr]);
     uint16_t oldval = lduw_le_p(&s->mmior[addr]);
     stw_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+            ((oldval & (romask | w1cmask)) |
+             (val & ~romask)) & ~(val & w1cmask));
 }
 
 static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
@@ -133,7 +134,8 @@ static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
     uint32_t w1cmask = ldl_le_p(&s->w1cmask[addr]);
     uint32_t oldval = ldl_le_p(&s->mmior[addr]);
     stl_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+            ((oldval & (romask | w1cmask)) |
+             (val & ~romask)) & ~(val & w1cmask));
 }
 
 static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
@@ -142,7 +144,8 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
     uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
     uint64_t oldval = ldq_le_p(&s->mmior[addr]);
     stq_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+            ((oldval & (romask | w1cmask)) |
+             (val & ~romask)) & ~(val & w1cmask));
 }
 
 /* OR a 64-bit register with a 64-bit value */
-- 
2.34.1


