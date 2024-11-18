Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B00FD591A1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4c1-00029W-GB; Mon, 18 Nov 2024 11:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PratikRajesh.Sampat@amd.com>)
 id 1tD4OT-0006a0-1F; Mon, 18 Nov 2024 11:14:29 -0500
Received: from mail-dm3nam02on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2405::628]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PratikRajesh.Sampat@amd.com>)
 id 1tD4OQ-0001YF-JD; Mon, 18 Nov 2024 11:14:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4qaeLga1L4f9Czc3BNsWXSFZG2GFJ9+FapdKs7vmpOiwBMFd2QhfJ8qXcI8ksU6Okg8/WyN9VzGD9MKmtYlx2JFEj4O3lZVQL+e5aa38/aunQLKFJucjrQAFqDOAQ/M9G+wGslxil38S7cEPT1RQ8ZFAurs+neIlKyGv1enn70Atx2gS1FGPguA0jGlq4DXuOBZSjnTws7MsdGy7UBj5wwvOsJsGKByjTPuWyY4F979PgrxKM65mZEQxyw5TYejCFVdk6VtJvXI6A8TsriVFasU03/+Y/6NuViywY0BLlFVgPxCTBRdeSHsKAyFXltB49lb1ptEpozHnLIo35w5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joDLwmcY3/TI0PX0GGnpVSHPJ5jxrW1CZS6PEww/TNo=;
 b=B5WcG3fJg5Cux4uAPZxlBx8MnO2IFjAAAU5f541rM75iMq4UoPw1grjLas7kOXJpkiWC0snjIbjYp+gd+Rw81pa4r4NPh2GNUtJ9tEDJ6NUI7IjMs3MgpC5itRKa7lzbql3jYS69pbwWxy/6gbNSLVedFrvtqtWrn9AN7OUNNgRuZAj+xmF64NH0fftZ5Bvqka05v2eAwqzswbziLYFC90xlQ5xbSHL6O8jM0q2DtqQR3nWgImrru7j55uJYJeZpx4QJywJwwq4CATBrGFVZ9Ow+Cle0MsGg/Huu7Ch7X77YQaBPGFJeKNXaxB5fRC+2yZcyLWOT9pz7c9w0s9ttyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joDLwmcY3/TI0PX0GGnpVSHPJ5jxrW1CZS6PEww/TNo=;
 b=AXqreWlDzRg64brA+jZxJlNxjGDFUJb5zFtWT9s5kumfkDWMz82USMUPkRz/eJsKg8TP86k6eVXFDhTUUdjADYL9GgMf6vlH/HYCVmkxa7XhGixXSelYmaJ8iC1yREhHknyADGoVrRj40f9WWluFHztEwfgtXlgNIhi7mjG+Vn4=
Received: from MW4PR03CA0338.namprd03.prod.outlook.com (2603:10b6:303:dc::13)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:14:17 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::99) by MW4PR03CA0338.outlook.office365.com
 (2603:10b6:303:dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:14:17 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:14:16 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-trivial@nongnu.org>, <philmd@linaro.org>, <kraxel@redhat.com>,
 <pratikrajesh.sampat@amd.com>
Subject: [PATCH] pc-bios: Add amd-sev-es to edk2 json
Date: Mon, 18 Nov 2024 10:14:05 -0600
Message-ID: <20241118161405.208437-1-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 5991a94b-29ae-4efe-1a6d-08dd07ec0d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cVvxPUsxJpLQYbsHv+ht1j/bZJy8h17asp18U67RybmEG17yT1Q42+c9kekt?=
 =?us-ascii?Q?rtGJHdN1+u2D98c5kmyBgNBr+a9tetIxCf3c2foSHUGRrFMTaOxlM5gEccFe?=
 =?us-ascii?Q?xR+TLasP4TJoJkRMnCRt9Zocm5dEhAcHo5GNcgM0ZHYfb9l3yk418oQUJrcV?=
 =?us-ascii?Q?jc8WZF2g2tse8MRm+wAT6pZ7TP3XKRD7lyeRp6nLs0WrL7XfFGad3kZdK4s1?=
 =?us-ascii?Q?XBdKJ8GGSb+jX5ee+42xZBEdxO4HNVu/DQCdLTwOwOF5A1OTHVWOYsqEZd/7?=
 =?us-ascii?Q?T7JN+XFax/SVeAQVw80brald6CDyUoobE/6dmksRS9C7rrrwalamPnBTYeYW?=
 =?us-ascii?Q?z3XTF0tRwIdn2pPOleKOmrAQggNw/WLO3yrL3Bb9I25lPlLJBuupIDprXfNP?=
 =?us-ascii?Q?yZcHDKvM6XXTGTbcwlhA8J2tIY6Brv80p/rldtAepV41OiqvM9nsWXjQlZOP?=
 =?us-ascii?Q?xvWVfdUZZuMoPoNOC8ElPAUBSwpFFhYS9f0JG7/70ZFkYjYaFou27F37c2uh?=
 =?us-ascii?Q?vtPlN735Od6snZ9h6h0QNYwz+5cXMcgybG7BkN2Z5v69zsVO2xE1IEkuYXIX?=
 =?us-ascii?Q?z1GJwRCDJ2wz8W9OZpMStpBDX2CawpyaeESybdkdNDSbgzpqAG24U8FGsSWj?=
 =?us-ascii?Q?7wqwkTMXto0yhC4hO6AOmHwY9BXfUWxe1hoNoTwL8OPG1SxbkGi3fQQfO3k0?=
 =?us-ascii?Q?Zdm7P1YaqAYQs8HSkySzqeyaGodlP6pheGXgik9DmbDg0pGVxUq7uLeB6+US?=
 =?us-ascii?Q?Y68YQWqZLxYglxTFxIM5nWsiE4kQKXyNZhVpH1eOE0+ye1ExL348aQVNh98N?=
 =?us-ascii?Q?f9JOVQkfJxgHAz62sxWgODIoHXKzS003nAyp4uzDwwIs9wciEfKIjf84KrL3?=
 =?us-ascii?Q?NOkol9o/ao+rfuE2W22nk2bgOhe9OOJ8sHnKtbMpxL3ti1KzKIj4tTbbBjEG?=
 =?us-ascii?Q?ZKWsYq/HnV4xwHYJ2KNd+wtvYtg2Du2e7ieAhlPxDQsEo6wF9+iqCDb/LQKH?=
 =?us-ascii?Q?/UO4N7CuXmcWtmojWdAGyz6Gvq6pnJjGWKl8lkRqUQwn8KfkjKJLFO6d0zKg?=
 =?us-ascii?Q?6EBA+28PAjYw1O+rzquKWairKg5ALUNgZdoDVhOVA7kBLBYQgKfyoUdzHC26?=
 =?us-ascii?Q?qABNdhM3Jed/IWAeRBuE0qGkXv3gr8gLModP8fGT4zPbLZr0gaYoCPqtACqg?=
 =?us-ascii?Q?cYVtijLukSz0JetbT/g77PCLPkKSzT5aAaqeDGGl3+gQj+5C0Sp01wLTqXWA?=
 =?us-ascii?Q?NNyN3I2A6VOubIsX1C4IIX5UTfdN4Uh1ZLu4j7BEv682KA+JssCmZnRjz+Ew?=
 =?us-ascii?Q?hlOHK90kQwjc6AUJNldpw5vgF4qIkQVMpIyQ0GbY2vb6x+FDvnwDiPX4gv5w?=
 =?us-ascii?Q?XTRbgkmqV2moOUQnKLKyQSPTHM4h/rxdjeMEye35i61Sbq63tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:14:17.0372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5991a94b-29ae-4efe-1a6d-08dd07ec0d38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
Received-SPF: permerror client-ip=2a01:111:f403:2405::628;
 envelope-from=PratikRajesh.Sampat@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 Nov 2024 11:28:25 -0500
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

With the default BIOS being compatible with amd-sev-es add the feature
to the json to indicate it's support

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
Re-sending this patch as I had missed CC'ing the folks from the
get_maintainer script the first time around.
---
 pc-bios/descriptors/60-edk2-x86_64.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/descriptors/60-edk2-x86_64.json b/pc-bios/descriptors/60-edk2-x86_64.json
index 968cb65cf9..4599c63f14 100644
--- a/pc-bios/descriptors/60-edk2-x86_64.json
+++ b/pc-bios/descriptors/60-edk2-x86_64.json
@@ -26,6 +26,7 @@
     "features": [
         "acpi-s3",
         "amd-sev",
+        "amd-sev-es",
         "verbose-dynamic"
     ],
     "tags": [
-- 
2.34.1


