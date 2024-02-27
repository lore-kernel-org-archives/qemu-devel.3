Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8295CC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf62u-00054u-H1; Tue, 27 Feb 2024 17:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62s-00054V-OS; Tue, 27 Feb 2024 17:35:30 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62n-0002gE-CD; Tue, 27 Feb 2024 17:35:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm6ZV9cotxjSIyNFs42BshwspzJWiBFMna/EMEYUKSVfKil1kdn8ODPi9u3HNLn45wPEdISvITgJ0X/T1uk8ROcdi6gQYn9xA1YprD2nJQKghz2wzBPIN5yTGxLgvApFxo6XfaZsEMgcDjX6JjoL1lOCpzgdmziIMfhUyRrvVJyr6qtLnenlxf2GSisz6WHd0QsH1nqHcSgRsYLuAQC485YFwcqyOTOT0nN5TwciAstSM7PHumdO9egZewSKXh7G04pkXhq8J4abHMKTvSKPC1bGRdhOEeRzGc7zMboPoGFnLR9R2PaKzfqaKvodg72tHceMvzknqh9e1WIkogVfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoLg09T18TlnO8EveohQaV184sMpVMY3kcXDRqWQz1g=;
 b=mdDc9eAYsCijFi77u4diG71A0IO/hQlCSzmjcIGq8O0dq4TZpcpuXB857GC8wscS3d8Tgx9wHUHr5syQAWuchSwnbXabWW/729tRJNB4Vh47QfZ/jWeS7iTu9fCgZSgMYYLd1m81yPJ1H9jrTDIpWu4DjMzMRaX+S0MrXzXH36xAHQ1eRvL3xOk8x9R+3vtjMEXGMWBbp6S+tqQomwfvK/m2vc6VtiMnJV1ONdf+R+wgpGSHe/GROl2EmkCrgHHpzUa1k704dnAkg4ZnrLx4oeA+3jd9bR/6/6EVY+Ra30NWX0Q/mFU1M7xlO9Wg/j9sFOTUQe0SrnsZiH3TNngPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoLg09T18TlnO8EveohQaV184sMpVMY3kcXDRqWQz1g=;
 b=OnTSj5559Gb6MMO5/UtKyEmHTmNlCrJ//qoiHZ+ZusfSiEzO2GTiksbnkH/vHGA8YwJDxnfmTPFWgZXdI3KfgISYR4o3KjrYXwh9uAFaWl+aXqDgY+Eq0kzL0k+4IeyId0opqBilVy2A42avm3U3zTNqOkArDtxGvhjo7ZRJND4=
Received: from DM5PR08CA0035.namprd08.prod.outlook.com (2603:10b6:4:60::24) by
 MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Tue, 27 Feb 2024 22:35:20 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::d9) by DM5PR08CA0035.outlook.office365.com
 (2603:10b6:4:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 22:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 22:35:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 16:35:12 -0600
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:12 -0600
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Peter Maydell <peter.maydell@linaro.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
Subject: [QEMU][PATCH v3 7/7] hw: arm: Add grant mapping.
Date: Tue, 27 Feb 2024 14:35:01 -0800
Message-ID: <20240227223501.28475-8-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227223501.28475-1-vikram.garhwal@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vikram.garhwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: c59e752d-36e0-470a-11f2-08dc37e4612e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8gANANz62pCWrc26Mn2NOOQjXOmBET7yPfr7UP7wQ7Uc/lHpFdT0+wWAM6A82wTDBrx6z8dB0mil4YnqSuNDgSOXTopsaVLcJYvx12jA1zo4NtIzII3VzU4knccRqOlpQvYV5AhDFBbVPxKwNSkd8F8rPrAwaT2agIHvR93WfP5wm1oB4N71QmeGNPETgdrJsGdYwoHgFT2YQl7E46J1X1hUBwvKG0OnwWSab1SzyeyHu6jcSQBGA1ribKdA5rrEiqHkyP8YfEVOgrAdlmUb106TFYgzP+TQU+oGdD0PeKSPjXIctlTYjXzWPL5fM4eQajsgXAWifhSoIVghC8I7dqX/44UnFAptpE6PXg5BS2jar0pVo2xrKD2kUQYZV1BnGMWpUxEvDTnoBF0hLbzSSGv8Pp97ntiOVg8b5o2C8LxJ/fbv3ucXYpagpn2V9Tnqk5gR8FXy4f6B2nDf1IsBPXeEBHtse//GCle84jcGIxyrQm4HRZDoHYgvOHakOfNuTpU8z9g8OzsIs4CTIy+G3u1hnzPp0kcl+EHoO5OOo1+IZmIXptc50iXV3tlzLakZSxLiZF2or/La8c2W5ERnHfRUpMYboKpESACCaGBC6xGsTr40BdZTKYTtEmYyfgmDzQ3w2tEpCZaxmotN6cvy/z2oINglvLx5f3b1z8umJj1To1FAJsn8eJfzbychkhcaOe34ZLmfItsF1NPURAZV15pXo9PVu6AtmwnQclZalNWFLZ+4cd9631Ra9+8MZ4P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:35:20.1310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59e752d-36e0-470a-11f2-08dc37e4612e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Enable grant ram mapping support for Xenpvh machine on ARM.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 32776d94df..b5993ef2a6 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,9 @@ static void xen_init_ram(MachineState *machine)
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
     }
+
+    DPRINTF("init grant ram mapping for XEN\n");
+    ram_grants = *xen_init_grant_ram();
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.17.1


