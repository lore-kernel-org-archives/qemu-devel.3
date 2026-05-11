Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE1FCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 12:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPxE-0003WD-PW; Mon, 11 May 2026 08:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPxA-0003Sl-V1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:45 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPx8-0004JG-4N
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLjKx73tm7NB8ZbMXeWruhzms4QLuYN6gly/omSSqNG7OS3xFDd8LFqGaVjcTJnLfQpBfZ8IbiXj2C6RkA/biPP0gnPbIhPJcy5PxVdPntpMFi6qgaTbBQ0Pt4P5UBmDOu+oiQA6ZkW/ClhTBbT3apVG/7OAPZrY7m60LOWCLZum2UrvOYx0fEBR8YOIHRe4wiuUxhQYFihK5N1NXYo3+C2XPRSo4O0mFKOAJolZpoyXiyIpA+raM13KL08Eg5KI8nj3xQkCP1nIPchKaN42tsfqMKD7JjnEWK9YQb21OluszzUrLAHOfFjUd8wd319xXEK6YT498RXH7RImMZT7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZJCZ1/AhWRwqOIoyC6/6VoGBs/moaqlF7Cm0AqjtUI=;
 b=o3q8Q+G6dcJ7Uyjdxw9eoorxejlJlmKQ8ildw0uv17o6lyCHGANlc7EErCZtHVVY6Yk9UD5AXf4D5YAW/O6zdgnPQSeY1iTImA44H0k2xds8Zh/kF6dzhERS566WRO1eXNx4UcQTCilzUam8mD8SPs0evFbEk80vWFRrC1zCvvhqsqXrVMShwvVDn9vpb/K3IX1oo2kxJPwS9kOBfOsBZ1eHX032nAxE3Z9qGc6vGU8Qcr/3rPa8uKWQZ2Vy7cHLKv2Y/8nhbZsnqUcCWTXg9AboNrahU4KzC9Mlc2gtggoRI/wU+Ol4q91sDFxqCRckvbrXE5maM0F5aMOtLknbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZJCZ1/AhWRwqOIoyC6/6VoGBs/moaqlF7Cm0AqjtUI=;
 b=Ug+9G+BV9TXKFHQ8klRKZ3A5vFcNaDbb3937fjJ1dSLK1UyJlNniRFdKjmFLsQdI5GLzaq2Vdltf9PP/O3mWs75/44HDrROsSapuIwJsxcGICQ7VqJ4zuiYI97QKuQ98tjpbsrrSY1d3rjW6LXS007K8a9Kt6cZpmNstgBzvoiw=
Received: from SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::25)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:41:32 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::22) by SA1P222CA0112.outlook.office365.com
 (2603:10b6:806:3c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 12:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:41:32 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:41:28 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/8] amd_iommu: Return empty efr for stub call
Date: Mon, 11 May 2026 18:09:32 +0530
Message-ID: <20260511123937.32743-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511123937.32743-1-sarunkod@amd.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: a3724ad5-2624-4f5c-9503-08deaf5aa196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|56012099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DLWHDDx/YbIxq0t2SFlvbwBGim3MyOhTIMBvJ82MaWJcFo056ygzVkksOyaAZC5raoAtVAiobzhYpbiCol08G6MlpF1PSkr/HX9VcfSf91Jd0xS3HmtBVH6gxsGIc9QY+pfYvSMH8Iif06MHT/j2z5k6uQuOfL3wrb7GishrcgIRt05Exjbur4+mYwObLAGi1EC2GAupZtqzYMGZms4VBJdfvHssY4vaYe5XvXYcQjMDx5a9evF+IH9CJHa2ytCdzZV9Wn2ch8j8fgzpT+m4MN/1cDvTugDtQHtlxTF8E6xuuHZe9UrYQtU3ywIWX+4/GEXdie7PArj1KQ8m713pTo9JS9/aLUPLvPcBKHt3sa+ZSlqMu1gjV8JiaE48MvcKB1lKxhrLva5VANexho2HfsXIc3R9ykk8HD0+F3KK8scMiGnNME+znimSVqB4L+e3V8jcEMBb0rvfvHS1YW4GA6UookiY0rQlPDUX+c9AKjeWZUkcXonO5W3jHh7/AKf33fvjNIcSXUMJcrxR13EWLwvuzZZ+/9tPADHYBM8BXEMRUAStyoYrfaurl0ilNWuJreE6/359L6VBX3rmqIQJnOYpOvaF0QNeDZx4JCzg5CEf6C1nRQEtjcrBmUxtRPStachgY51azFa3rFAc/vQ01K7cCsvpy5O/bTNzo/MQrNPChLw2YAn6C9vaB6OiM9qZfVruQDfR0noLRCA9cq2M+029Rf65pB/wDMljH0meU4BndSgv8ICiy0gvJzaYAELIaEbIKtmp8mvb8lvVvnKZQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PB7aOaeabw69cBOrQqhl+kRpu/TSSoYsStNR7kFh8xub18pWmvN07b5p850bS3AwfdRTgcEdqNzkPZjrf6iKh3wwk4jmQ+q3TS/aaU8TlKb7Krbfw6ztwNCWAjLzId4mmOWkykyrR4fJyrocrVbZequ5vBQ3sJtpc1jTLru6+1eXNOACHWLVWwYTDruvgEfK+pPHNm8OY99sFEKfgmmNun2sDNQYEmhpoYaUBWkV/t68ri2UYHTeF04pRl/RsJIAtQScNJV1+rtV9T+jEZjmR9rEe259NmuenIxEgedGBx1EN9Q+283Cyay5/sQv044z8WJRVc3xSoPXZQRDr2BQwtVHM2rwH/nsM8QiQ6dADBhvh34BW475QCchQHROhvSK+6c3uJv/m27FdIVUCtX/QJtM+3LoScHDKT19wpBt1gdE3Ppd0OQDpm/mi8FKXYOW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:41:32.5452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3724ad5-2624-4f5c-9503-08deaf5aa196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Sairaj.K@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The stub call should not return normal EFR as it is used as place holder
when actual AMD IOMMU calls are not available. Hence return 0.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

---
 hw/i386/amd_iommu-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu-stub.c b/hw/i386/amd_iommu-stub.c
index d62a3732e60f..fb36dee903ee 100644
--- a/hw/i386/amd_iommu-stub.c
+++ b/hw/i386/amd_iommu-stub.c
@@ -22,5 +22,5 @@
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
-    return AMDVI_DEFAULT_EXT_FEATURES;
+    return 0;
 }
-- 
2.34.1


