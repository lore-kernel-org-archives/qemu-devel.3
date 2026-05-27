Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AF5CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMpa-0007dO-Qh; Wed, 27 May 2026 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMpZ-0007Yl-BV
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:34:29 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMpX-0000u2-Sf
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pc0/eV6qsSNwhYXJ7x9k7mFQFtoTUuImkEIJNMk3nDufK+g9TDG5R0AyjBP/RYFvW/HH0X83UTB8D+wvUoXPZ08im/uwCR8J799z82DJIJRa06k3nHsq1q2F911I9s7q4msX4v82HCwhOaAe0jDj+T+D1uhgXI+3toLhOLwmceMY6hMgkHI2umBGSMvSN6hgn+7Ow1eE67JUR4pOw3X6rwDj9c5F3PyT6ZnWYB2PRTwMO5u1to2E4+bvIIze/+pxsuAOiFbECkOf81bE3+xvuhA9J4GXLtMqwRHN71VZINOndYroYfQBzdvttdUHlcZZ9Fw8KzRjCzn3qmT5xcbUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn0QaOHgfxFEwNtaDZU6DdicPc1tgKHeaBD3g/nw2AE=;
 b=pmRIq9TcGDkt/IlBhP1XAtZ566+eR0Z0N6y2olKPyosi3fBON+QUMxJ96UXSCigGVxrD7XmLFEu51+M2Pi5sLvX+JX2ttC1Lz3S+kOH+iWu6WLbuthglDzDMtMjPeyXtLXAO2aC5eZEFzWpjoKzyvlPXxJ7x/R/M/Y4L6QpRIAydETst6uz6ml11niYRHUyvAvX3TOQgLedhs+edYbOfDsI5FFH/3qmioMrcOg33FXZyaRmyutSjVvjMBJCpUUnpX0RUIQM8RROUMQxL6QKmSFlZPJPgiiRfjCHrKy+XszIfishNjEmdFqDfmFtQ/zT7/U0IAd2Z1G5Kt203LAwM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn0QaOHgfxFEwNtaDZU6DdicPc1tgKHeaBD3g/nw2AE=;
 b=0wqroaWVt8jJ0j940cczn5qAVRjFMz/EyVMkUMu4UKPnJOoSLd88JxL2LWx6GpZACR9pMyQHVAHQ4vU5o597o8QFJrlKbXcXuT1kMCcj88FafXeW74o0Frp5wqwcoruUZm9dHpuy/Sv815M5SNcpZ9drddG2F1d3yTQ8DOQXyhA=
Received: from DS0PR17CA0019.namprd17.prod.outlook.com (2603:10b6:8:191::8) by
 BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 22:34:23 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::93) by DS0PR17CA0019.outlook.office365.com
 (2603:10b6:8:191::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 22:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 22:34:22 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 17:34:22 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>
Subject: [PATCH v1 4/4] accel/kvm: Fix handling of conversion ranges with
 multiple MMIO holes
Date: Wed, 27 May 2026 17:28:27 -0500
Message-ID: <20260527223036.4614-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527223036.4614-1-michael.roth@amd.com>
References: <20260527223036.4614-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: be54258b-4504-422e-dc1b-08debc40199e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pa5bY5WzIWrZqqIiK6ld9A3sKJ8rXSEhgl0JghPtPYgCn83ps9I15qFKWseV0k4uvE5Vtqo2N+a2rBATFHFmxt7GarG+kLB3Alj5zKGE5HWO+AmGIT3E0l4DFNIyuP3Dwv0woCRM4BGvj1KX7ct4K1I2yvvAZN3CYsi9wmYfTOBikrOGaAQg5bG9qAprYjTEJOh0HvDC9LvBZ1r2x+O/YQuNw8brSKFg5QOqku/RnayseF1sKjPBOdJzojrChzigh2HMMciyOt+QFgaQtwh6XNgaxKW63t9Dw1bsk/Ez4cpv9s7HQFCn14MRCZs/IiOt8bu8BwQ00Jt78Y1AEu8Dkw8ed27/V+lqS+p5zzl65rdRa/AXbiki3ihbMDit/I3fgBiglvM2ZTuiPy7g9wnRInNBI+wqU+gLBUcb2VLC+ZjSEClTLNfC/roqGO9Wm97f6xuaDhOSlOgKS7taqkumxolvMaDIMceKjch6q5uFWpkPzfVgqLsM506X4nWYGf6C+pY9VbZrUPUP6J2V/+92Kh4eqYBipifuOUFoBErcTAtXtYUc22yZYGTZK9tQjqkgdQJ0lEHH1ARpnbc7s+zSUA86FFPWnjeL5aAafoLVTzeRH/jGA+jRiGUx28t+BwH6LC9nPEAF9quyWO/SLKY8bowDH+DSkpodwHJ76ouU9YmEi6iVzbCZHlBr6BZr7+PTCRFX2nwq/1gJUWT29tWfp+jhxANNB598DCIDk+O/9w4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jL5PtM55Fqb4ymY9Dk5RLemWLiw4WFD3ART1p427fSrHw8QdVticW1HGCtwgWP39rrE20qBf9tY8LnJSvqJNzv2YXFtAUfBa577QbVvCRtiz6LSH9BjgOxKeYOYaLxtYnnei8PLzy+PmYyzbPm7lRScdXU+4/myHqGw18EfcVjulErK2o+kC2KTAVBHfDUNcdNof/PR6lMStDlDmI2wnKKjEIu8f9LISh6h7qcMZyaJ88hWndIlLl2AKEoyoFifAkUG7unnSc9gBazXpgebaAa4IBVyTfuBjSYLd6J3plr8gclSnhTHvekVIE+HkAqrmpQRE0lz2anzD1Aum6zeg1wY3AjFAcNyP1V7y4wn6KUohuZEKj7CuAgqlsGYA3Z+LLNkFwFLlKbfAxPl/B2r609mt34uzSmitW0+u7QWoeYFrDlYMIjSSprYF4U28Skm4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:34:22.6611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be54258b-4504-422e-dc1b-08debc40199e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The current handling will properly handle MMIO checks for holes anchored
at the beginning of the conversion range, but misses subsequent holes.
The current handle_memory_hole() helper already processes all MMIO
ranges up to and including the sections found at each iteration, so
handle this by simply calling handle_memory_hole() for each additional
section/sub-range.

Fixes: c5d9425ef4da ("kvm/tdx: Don't complain when converting vMMIO region to shared")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 609126b847..585f1cea35 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3497,7 +3497,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         ret = handle_memory_hole(&section, to_private, start, &skip);
         if (ret || skip) {
             memory_region_unref(section.mr);
-            break;
+            if (ret) {
+                break;
+            }
+            size -= section_end - start;
+            start = section_end;
+            continue;
         }
 
         ret = kvm_convert_section(&section, to_private);
-- 
2.43.0


