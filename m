Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB68C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYNhw-0001HE-C0; Fri, 09 Feb 2024 05:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rYNhl-0001Go-ML; Fri, 09 Feb 2024 05:01:59 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rYNhe-0004JU-0M; Fri, 09 Feb 2024 05:01:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi2f42mFDW7UC6cGcDfdxkMfS0ovJoCenBn/dcJ2MNrAV8SSsXLzd+sFDOVelwXF9G0y6iD/cjY+7Nzj/Vy40K4jA9z7nYk9OW2KENTUVlp/Tip9cNAzTKTMAS3IROnMCqWhZdUXYGsGSy0jNcUCj0Axi2WLvWOvEIGJjTICuTIM1yv0qLQC9ULETxGJW7004L8ZG0lJHiTjMi3xGb4bvUWFToSqr+9j/SRj9uW8HUukfBffr6ZUnU+now5nbKBsIpO+PR5xkHBtjj3Zd9zGkWBnY48IWukcjegzk0AIIXzShfYhJf8evNK8e2U+2RI+Qhj9gapBjWJLFH1GfbJQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHRDIhNvq2dLxlbiRi/N+0ycFHcjg7Lo272ubtl+kZA=;
 b=TjozXjJmbm5EgH+812DxBF6xbAc1jzHMMArmSsZay9zP40jL2aJQ5AL99txtRFWhKIco8APJJfk6LwFDIVqv8oFRedoBlENoh0LTdwJWSHZtBrzhEiiA+gYOnKlXOjft2F3GluhOWJa0lw1HEre9cPzYyNHfIlTPc2chvJRhRVNp0BKOGQzmiFHsJIyYKTunSTxX1ggyM8lx+k9GaOumhfMGtXiJP2Qu1Lp4nNW1JothcmNA2Lh78uucsY+Inz5vpB4OvBv7efMgBYeKkPdBFIYGOdit0MU1GIQDYYBAX+yZqjJXOVcHOPJnrOrty+TciyJJTrwFIyD4657y5JMOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHRDIhNvq2dLxlbiRi/N+0ycFHcjg7Lo272ubtl+kZA=;
 b=MABJXdNyfLZmdewbBIk9hVeGcSyeUYkKP8JTbUhXByMT2wcKH6HKR3BvICGiM7UIy+6Xf/C1PpVC6dYuTMFubSrV1VS+LOwz0Qqd5oC8KJtWPRu6Nq5+bbcSxCVnKVW7iY1LgOkpYnpQkdKtkc+mGHga7ZRiwm2jk/2nNSRrefo=
Received: from SJ0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:a03:33e::33)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Fri, 9 Feb
 2024 10:01:42 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::f8) by SJ0PR03CA0058.outlook.office365.com
 (2603:10b6:a03:33e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Fri, 9 Feb 2024 10:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 10:01:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 04:01:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 9 Feb
 2024 02:01:30 -0800
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 9 Feb 2024 04:01:29 -0600
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Eric Auger <eric.auger@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH] hw/arm/smmuv3: add support for stage 1 access fault
Date: Fri, 9 Feb 2024 11:01:01 +0100
Message-ID: <20240209100101.3631468-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 04598c4e-25da-4a4b-712b-08dc29561d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6RtlOyIiDu+VxFFM+m+fIX1BWW9Iu3MJUBZMI9n0CzGQv1TUV9qqaZJXXLb2pp1LATDSJtc1Qvzhb14J0Mz8vGRgfWA/4nvdAClQWCpz1F7Qx9wIxZPyCC9XlyahXp7lTjsfSMfudVa6FQJQWGkf49ufJWtlxnnHcoIa9ptjsq17/aGiNH9o1dJ21icsrglbn6TKDftN00i5jVm4E0e9wv7v2spyf2pkPg86s6CfvswWfqUb5MEdBKQPzqNFppnKKhlYabvo0XRl6ViamoHOTU8dsJlrefL0lXQEd7LmjOWR1jtuUCyRsasY8fTucZKXhBYXPCS01syk2otuwC6A4NnsTUO15xwhn1UIgHlzA9wHqQMqzlfPF0oj586EGpwD2jxnUEFO8UC+mt6e0Y6yqdpCYkELKM7TBACkv54mqIzwWVrKbeOUUpc/HoAlPrD+8GTcW7TeebX7+yoNGj70/0w4UgFEJ0OSzvZXCd/urQLC/H+JeYsDHISnX0FP3eOGixL6UpCbuGlfqXx+/1bjoDg8RkcMmfRSoajvKqzJFgaguqn4UmMxM/wCHbCSo29ODGsfgkHDcbhmxV7wPZU7mbKudCKoCilUoT+JhEGCMc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(83380400001)(1076003)(26005)(2616005)(41300700001)(426003)(336012)(44832011)(2906002)(5660300002)(110136005)(54906003)(6666004)(316002)(70586007)(70206006)(8936002)(8676002)(4326008)(36756003)(81166007)(82740400003)(356005)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 10:01:41.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04598c4e-25da-4a4b-712b-08dc29561d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
Received-SPF: softfail client-ip=2a01:111:f403:2414::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

An access fault is raised when the Access Flag is not set in the
looked-up PTE and the AFFD field is not set in the corresponding context
descriptor. This was already implemented for stage 2. Implement it for
stage 1 as well.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/smmuv3-internal.h     |  1 +
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 10 ++++++++++
 hw/arm/smmuv3.c              |  1 +
 roms/SLOF                    |  2 +-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e987bc4686b..e4dd11e1e62 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -622,10 +622,11 @@ static inline int pa_range(STE *ste)
 #define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
 #define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
 #define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
 #define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
 #define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
+#define CD_AFFD(x)       extract32((x)->word[1], 3 , 1)
 #define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
 #define CD_HD(x)         extract32((x)->word[1], 10 , 1)
 #define CD_HA(x)         extract32((x)->word[1], 11 , 1)
 #define CD_S(x)          extract32((x)->word[1], 12, 1)
 #define CD_R(x)          extract32((x)->word[1], 13, 1)
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index fd8d772da11..5ec2e6c1a43 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -90,10 +90,11 @@ typedef struct SMMUTransCfg {
     /* Shared fields between stage-1 and stage-2. */
     int stage;                 /* translation stage */
     bool disabled;             /* smmu is disabled */
     bool bypassed;             /* translation is bypassed */
     bool aborted;              /* translation is aborted */
+    bool affd;                 /* AF fault disable */
     uint32_t iotlb_hits;       /* counts IOTLB hits */
     uint32_t iotlb_misses;     /* counts IOTLB misses*/
     /* Used by stage-1 only. */
     bool aa64;                 /* arch64 or aarch32 translation table */
     bool record_faults;        /* record fault events */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 9a8ac45431a..09ff72e55f5 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -362,10 +362,20 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                                         &block_size);
             trace_smmu_ptw_block_pte(stage, level, baseaddr,
                                      pte_addr, pte, iova, gpa,
                                      block_size >> 20);
         }
+
+        /*
+         * If AFFD and PTE.AF are 0 => fault. (5.4. Context Descriptor)
+         * An Access fault takes priority over a Permission fault.
+         */
+        if (!PTE_AF(pte) && !cfg->affd) {
+            info->type = SMMU_PTW_ERR_ACCESS;
+            goto error;
+        }
+
         ap = PTE_AP(pte);
         if (is_permission_fault(ap, perm)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
             goto error;
         }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 68eeef3e1d4..c416b8c0030 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -682,10 +682,11 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
     cfg->oas = oas2bits(CD_IPS(cd));
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
     cfg->tbi = CD_TBI(cd);
     cfg->asid = CD_ASID(cd);
+    cfg->affd = CD_AFFD(cd);
 
     trace_smmuv3_decode_cd(cfg->oas);
 
     /* decode data dependent on TT */
     for (i = 0; i <= 1; i++) {
diff --git a/roms/SLOF b/roms/SLOF
index 3a259df2449..6b6c16b4b40 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
+Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
-- 
2.39.2


