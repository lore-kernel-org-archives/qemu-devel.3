Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580D4C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 04:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgGOO-0004N9-IO; Thu, 06 Feb 2025 23:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGON-0004Mw-SE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:55:03 -0500
Received: from mail-dm6nam10on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2413::619]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGOL-0005Qy-ML
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:55:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDKGLRXKBjba6YOhRV6COmb75pReUXjNGKWOYYM34d3I9jeRZShAhEcIYbVDFv72zS/pGk8UTxuyf2ZvBP+7Poi2qr41f2HmzHVC1LPXr2jWTrPuQrQeYXMB3wv+he6ql7CaLol/1YzFsXa6b5bgy0K1d8+E+ghec8k83vKBcUWL2Lhin1520eK3j99656To/3hGSiJi4Bx7JyMFtutz1q04whoqAHlKfpWVNYPc8YmQ+Jr6Y9WGZblxuZkNn1YRz1BbyaV8wZ54eWNqKTeVi4sKN0k13Sx1YigwJFif7D4NNyJRT/4XbnfAexDgvINBwoTMQcXzmHrH9OLKQ+6jVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04kWd7D9sheeFc89gAjYxtFnJatT+ijzhZHKWbDVUw4=;
 b=fb1s3j7Jq4OEOwLBwHO4cnGWHbHTrsVrp0zQIDzTHUqJxEvFxTnQ/43us05DIhHH5u5Npv+IfceCpoU+G+xoi0R3tX2vq4RIFPJtYW3+4vYLXRQ7MxnyO8GnI8THu+E78h3tToZco0WpziWAer/A5qMb8xVr1jgng0q7olBCD8x2LuGwJ2Uqzx23BVit1fd5xMnL7yOMrGC6b2P2RPKTVxitnSf6yALit+SRbicSYl0+x3kwLiyajX0NrEfwVVR9/MWnrmiSA8+0ECTMSjOU6V7BA8tqQtjabplnFOCZjJuWI5ejn5zGIoK2oHMIUWGQf17qe1UL0CYSYt3h2OlEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04kWd7D9sheeFc89gAjYxtFnJatT+ijzhZHKWbDVUw4=;
 b=n91+6BVURN0Otnrwm1OLyq8EUL2ALKhBTnqii60R9YHzg5R/n3LmFRV079lNf0ZyRGmvTix2dnCAYLnhmE1qT7vQcmbP1PFa82uBsQok5roX5SXNmWcvcuefXtLuuuuy9jMHyv7lxH571EwADbkOXr0A3SHkqMgU2086Ocfy3cA=
Received: from SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 04:54:56 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d0) by SJ0PR13CA0124.outlook.office365.com
 (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Fri, 7
 Feb 2025 04:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 04:54:56 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 22:54:41 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>, 
 Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 1/2] amd_iommu: Use correct DTE field for interrupt passthrough
Date: Fri, 7 Feb 2025 10:23:53 +0530
Message-ID: <20250207045354.27329-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207045354.27329-1-sarunkod@amd.com>
References: <20250207045354.27329-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c4135c-13e1-461c-6f6f-08dd4733916e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oH68NjYld/OL7gJLBvF/H7sXlXaGCVupM5Bzw6hQrOIxN1dXebMI+Ndhjwao?=
 =?us-ascii?Q?19pKCj+t5iV583w71IW1u9NRb80UpsXJ0PCcnnIeg5qh84GpisFt8iKkS0Vv?=
 =?us-ascii?Q?ZSKdUDQG+k7P0n5rSlgxB38wJkbqylUSwd7ITE/sIeHn0E6ydvum0bbXfjxF?=
 =?us-ascii?Q?UC6iI2vCzf0RQKr/mXwae3UPZMOgXD2WUghHSKPxR4Rr1tUuGJaNMWXBUjy3?=
 =?us-ascii?Q?1gfhvJbRvDWYZ9HNglVMclQNhio4n7fekBVcxzL+0EdvouNPN2lZsw8S6Fzi?=
 =?us-ascii?Q?SzhyKPkjpfvApFffPdrhxLq+/vqhMuBSOh4o7fInEVuuUNQEcd06wzNQRMnN?=
 =?us-ascii?Q?ARVOM5rINgUnRKKRv6yQVK0er1IbI0jqjMIp9kRnc13EbtZ+o2I+fnNHoxcR?=
 =?us-ascii?Q?0ivayLVlM44nnVbJTd/3OIHrxpmGwBAd7JpOrU1Z72LrfG1UQ1bLw/RfML55?=
 =?us-ascii?Q?fiKNWz2kssQ8y4JZgdjUSMVYuRPiQNUaKePud25jbbOOLlq7jdoXvYVShaUE?=
 =?us-ascii?Q?PXijssbQ3M44HwvY3Qjn0uScW7xhvdBuRnLA1UfirdAPq5WzQzXek8Fb+R3H?=
 =?us-ascii?Q?KYfG/gjBN+YjYxRG1nMtFQ5DNoT11aPAV/RBYs+Y2mlHw255bJfsLpnFRJtC?=
 =?us-ascii?Q?nvyornQFwJNQxemoY8Yzvr0M80OdPs3WAvCkEwSUS/DdeP/xsK106rScSjj0?=
 =?us-ascii?Q?esnoqZWibnhvGSHrvHrRCE0S3C2MURTyUb46cuBjuaBM0/cnHdASFr83eWE+?=
 =?us-ascii?Q?9CCVFt5DNtC3L2Q/QG2vTic08RKohEqj1mQjoVyw0NITdsYhh9z5XHJoUGUk?=
 =?us-ascii?Q?nv8MH2MzOQAEtnVCwh1eoQx12zhx94fq0OxHZbjenw9OJOPj77yd2cFLohG8?=
 =?us-ascii?Q?O0wAKio9W4Tj8yrsXN2Ygp/I7zUZo0eRvo9xTUZWhVGsHwYygRtICYzLN6Ca?=
 =?us-ascii?Q?2PPGqrfckc7k5oZh2oYouTjMW5iVmNOHLkohmtAHmY+qK4Ey0o8472LGagqU?=
 =?us-ascii?Q?bU0Xp7gR+2jQzYkFGnhcCvqC4FB208jkmRJr+rEszTVcWZIMjveNU0IJ8SsN?=
 =?us-ascii?Q?A00M9L69d5jyBZUzrnBlzsDwoeuFmRli2j0JnxGNl5x3Du2YPfOSTP5CvGXP?=
 =?us-ascii?Q?4IqbWc2rr7rqOFVYis2vxQBRwxWKWcU2XXnQD9FBGQhBKPDMqKRIu1jenrOG?=
 =?us-ascii?Q?r6lGipDBCeGFSXLwbgb9b4eZ7f/oOZGL4Kij90kfRQ9BNgXN0qULZ2SkrCun?=
 =?us-ascii?Q?PhqLgusF1s4wOglz6tfPrYxw6UoQe36piz1Qn5bbWGc07IeqqLwh1v+NnLAJ?=
 =?us-ascii?Q?3NgP+VagrXuNpmiJ05tD7JPIY7U90wzzlO271r+xSXa63zvZrUyOR6s0lfo5?=
 =?us-ascii?Q?8py3tR0PnqBGEfGbn1WKCcKFKupClQH5vFkI22DqrIq2yNkqEuKlJNzlsChj?=
 =?us-ascii?Q?nYWEOrsN7dCsZUWP3gOECWS9Mz3oNTbPdcNZvjskBxnCOLBoKUfW3iKiM2L6?=
 =?us-ascii?Q?lI2mX2N/aYpCQ4o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 04:54:56.3753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c4135c-13e1-461c-6f6f-08dd4733916e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
Received-SPF: permerror client-ip=2a01:111:f403:2413::619;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Interrupt passthrough is determine by the bits 191,190,187-184.
These bits are part of the 3rd quad word (i.e. index 2) in DTE. Hence
replace dte[3] by dte[2].

Fixes: b44159fe0 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6b13ce894b1a..98f1209a3818 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1309,15 +1309,15 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         ret = -AMDVI_IR_ERR;
         break;
     case AMDVI_IOAPIC_INT_TYPE_NMI:
-        pass = dte[3] & AMDVI_DEV_NMI_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_NMI_PASS_MASK;
         trace_amdvi_ir_delivery_mode("nmi");
         break;
     case AMDVI_IOAPIC_INT_TYPE_INIT:
-        pass = dte[3] & AMDVI_DEV_INT_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_INT_PASS_MASK;
         trace_amdvi_ir_delivery_mode("init");
         break;
     case AMDVI_IOAPIC_INT_TYPE_EINT:
-        pass = dte[3] & AMDVI_DEV_EINT_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_EINT_PASS_MASK;
         trace_amdvi_ir_delivery_mode("eint");
         break;
     default:
-- 
2.34.1


