Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA1DC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZo3q-0000eS-Ld; Tue, 13 Feb 2024 03:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rZo3p-0000e8-8r; Tue, 13 Feb 2024 03:22:37 -0500
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rZo3m-0002cR-NH; Tue, 13 Feb 2024 03:22:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyBnv1F2HlVkmcWpLZW3+jIiQy8LmDU7eHWU95e2h/ZhsQN4wDH3NBzB4663fnMUNMeKs5RkXS9bo9+KOmf/o9iFo8gSLjLQjlVU6uAI7XcG3vVhWinaMXc+R2qYz3x0H4vaUHW6vfwmioi8FZsXZcsPH++McWjn261Ki1rErZHWvA4WPmU7B3qhVM7R283HKrW5liCPCd32Brf9XMpO1MnWTBMjqUrqChaUnB10q2dvfPYSYb6tzCJ65zNWZQzt3twym5yMRfV2rIMlxuABlPxtvQRKRbo3TR6myUftc18IGMcJCP/IhPjKJSi2kdfLP+pWUjfk2HlKpXKrK/oL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFSF+J+ZYSITdqlDhl9Cfky96JCt+BheB6vpDXKkfNs=;
 b=TY2k97ZKib0W5Chceyzim/WpNFiwYQmUcGtXQCIzabWcyDJSTmTzrk/RoNxUqkc+6iqc+MpA5ly+hV8e+eCcTdFAYQfmAGKSEnLbgegVS6m58FwJsMNRAKqO9NDCTCvVoGmBuTznCASo1YMtwYwK8ufr0Euo/qyj/CQhrUhxMd+lh1+JYi2ZPvH/hwcVkiW65V/epZVbeYpeuE1R60Bl5lIaDhirQgZ2H6auSCttXHgGfjfDd51YQJKFRW4oSh0L5nilAiSFt7fptF8qU53UtPYRxnAb+frlbawgOLby8i10UV2tYl/9KK0uVkQluGCOWv/Lmfdy1ma2Ow3mwYkf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFSF+J+ZYSITdqlDhl9Cfky96JCt+BheB6vpDXKkfNs=;
 b=EEVLeK6aSKGQuGsmO4/ZzhoR7R5786vRNoaBdkGZG6RCqTRJvo/+zgCp8Hhq6B2MGFgtaaYz3Ph3IJBBE28KRAOTRnyrSWdPTMmZztuNhXblCSyGsmQ2o9HfcFWyDwBaiVb1DFZ7euoAb+fXH95ny3fikvinBqP3GFdE52iiZlE=
Received: from CH5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:1f1::19)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 08:22:29 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::42) by CH5PR03CA0003.outlook.office365.com
 (2603:10b6:610:1f1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 08:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 08:22:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 02:22:28 -0600
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 02:22:27 -0600
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Eric Auger <eric.auger@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH v2] hw/arm/smmuv3: add support for stage 1 access fault
Date: Tue, 13 Feb 2024 09:22:11 +0100
Message-ID: <20240213082211.3330400-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ccec07-03dc-4b7d-b46f-08dc2c6ceadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQO3NoxLHZ2D2NuKYd1vasIMCCEgfroN7Gmv41RsQJCL1zuJYVufJ9SljRiVqon+PAxX0XIzOK4qc63ORgdxF5DvoWOA7GRW/koGHU9ikzq8uEBNkQNne3Gdc27nmjp7whRjB7zmWeIeXYrg94DyCKgHi70JHUtER/1muLDHycpMC7K9+khb4bU4yW5Tct24JyoeaktXRxOzRT5Z5DKLZCiL8gM50RYquvFMyDl0IfCnAnFK87g0O5DEqxyp0J+QXPzc8FjIfbFJXWRCa7sp4tZ+5j5QS6AQyd5PT5pDb73ybUPyGa59Kv3904pDoe8tfa8yB4Ka6EfKzNITFLEQcLK3ioC05DVlnoanVKzKiB2W6k4KTsMKDccNwQ+/Mlsjsbg6RWwAZyYaB+bZhekSS2fSg0C8OdIy9kxqtUdCVD/ZlYk5TmxoyPdE3XCs523tNFP/bYoNsK0BxYKeLAglnMoqKhows9kJVpOpd8wDHzBI9Qdkhd/ZtA6jna/imzwRxQHsTe1s9Fcd+hvAmPJxK3WkD3hj/U0zqDt3lwu8pfKoLoLm6UeIIXf8vLK84ttsTPFk8/4cS8PyFmYf2payoeOq2rY9qUd5kAZ5hXJN3fk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(8936002)(8676002)(5660300002)(44832011)(2906002)(4326008)(54906003)(6666004)(110136005)(70206006)(70586007)(316002)(83380400001)(2616005)(336012)(426003)(86362001)(81166007)(356005)(26005)(1076003)(36756003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:22:28.7631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ccec07-03dc-4b7d-b46f-08dc2c6ceadd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
Received-SPF: softfail client-ip=2a01:111:f403:2418::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

v2: drop erroneous submodule modification

---

 hw/arm/smmuv3-internal.h     |  1 +
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 10 ++++++++++
 hw/arm/smmuv3.c              |  1 +
 4 files changed, 13 insertions(+)

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
-- 
2.39.2


