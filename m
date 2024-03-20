Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF01DC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrcQ-0006Oq-Og; Wed, 20 Mar 2024 04:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrcK-0006BQ-JF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:48:15 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrcJ-0000UL-0J
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJyfi5ap23Sd5odO27BHm+NzWSlc4tRrBWViCSkGUrsOQIE8pSyMN1CgU6m2+bRHNDCkS4a/CZBEJbOplC5g6rf6ZS4oJyS92MfP4etlHzoh+x456i6xXrqOhAffAtEfoslnt+syrpCr5XsOZoBCOPte+hM8d2ij1grtQywmdvkMi+nV0oBbRxxcA39s1XY9ikH4OC0RD7gkH4o7/MSL+nbwwEI/71326izYKvNMs8SEIJ3DQths30h4PmEz0jsT22BYCBNp4hqSSQkwhzKJRM1Npwv+9n+FIQ76X9Pm596MLmqYxWO1vABhoctDL95wvuBTRantAQCo1vKU/+on+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAWXeU5FCXZgrtMbCoPGDFMxpIXgXuWjZAR95kDe674=;
 b=HLqTM6C7e6uiGv4ELrZnZbpfikZaaHmWiS2L805fU/dvamG5XdUFjZT9buLyLXVKZpQa58crOEcC0kHYgYYO0dKBz2pCPe2OkHqp+/yejFyAllVDZrn+EAKsdHZoWZS3TsMmMO1axPLR0KukL8wl6EliHvJ/ADhy/VQElxMkOvHKAyzEhLG4CBurabjkwQ2yAH2xTfHhItrmw+ooGj49qTHznykSqcx0gUQNEH71pV7Zq8swxCUzTCv7HrmTCIID2QfSA2aT2ckETu+EGYGzJjibqxdtnq8TWI3PxMemTB2sDRjEfLhKhfzbHpzUfXUnNKbWCOEQcIBrL0lb2SBLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAWXeU5FCXZgrtMbCoPGDFMxpIXgXuWjZAR95kDe674=;
 b=o37/kEG8oEKmE7fQ6ot/NzUY/EfnclDUkFTtkgR9uoWfq0ufyzdf1QCUCaVVyG4eZJZNxAKEcADn1nrl+cgudB8i8JOdcZQyCJeWPOSafBz/e9UfFiqhryeUx1kRIuYogrvg38kSVqx4GJ4c7CHxGPmN/7oE+KX0/h81TY6awrc=
Received: from MW4PR04CA0065.namprd04.prod.outlook.com (2603:10b6:303:6b::10)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 08:48:08 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::94) by MW4PR04CA0065.outlook.office365.com
 (2603:10b6:303:6b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25 via Frontend
 Transport; Wed, 20 Mar 2024 08:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:48:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:48:07 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 27/49] i386/sev: Set ms->require_guest_memfd for SNP
Date: Wed, 20 Mar 2024 03:39:23 -0500
Message-ID: <20240320083945.991426-28-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab5a55b-073c-4680-da0f-08dc48ba770c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUoeTVGEkJrCYS6mEpYRwVUF/KO7QQz+Ut7RVBlibtZTuUlqx/uro4bY9YMoh6WmuvLbm1xtESq+IPq/Ke18JoS8X+mOTqaiTZo5XEZgcai6A6rUC20pMcgcZd5N6qk1IUZJHkvhNUOlR+uZ8mTVuNeAcLBgC0XSQgDXzWIFI+pIyqkKS1LpFJdK2GlGdLX45xYIHKedGwZj6rM8jFuylXaxEN5UsLAiPTX7n6Vtnx3eSKrOy+ZVR2qioC2C15BF+O9jxOSfKqV2wLIRCba1nhUOWk4Ya/innLEIDK1tBL2LCVZ/D8OAHeMg2qgaFyeuNiFsfa8vr6qo/WEEITi3LlI31ohb/pk7n/ekE/D+uZColejN71EEfZgQDw9QxsitvgCPV7jMfF6VLxFVRDO0qoh3Vn/kw4x/y1raBICcSMVLyCHZ7PSUHVj2e3TzLqcDiTAg3+sFSD+EWkMvgeVRVGAl5UXowfbJ3u2cQH4CmkfrWQ9wBKxZQVp0JO/qJvSgEtkA3EiuSVVovokW2Y1nZX6hfcbBmFzbJEGkbeJJinelctQbdyT5WtusXz3Pd0BQvDTcyisV3xU6Ses4VkWbbY2vdvvZK6Qej+bAHube0oc6hF5iVHkHTRMpRAlCMmMT+R26FzEbblWYG4irs7qOpsqBHYKocNfU+JZauTc31LlIZhmpWuzfv2ST5VPRGjWg/bJhJXCmCzpUOl/WnUZ3fj7fuG6+02wCuY7gz8RpXCa4kRC1FCkWrUWI0URN+UbP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:48:07.6496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab5a55b-073c-4680-da0f-08dc48ba770c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
Received-SPF: permerror client-ip=2a01:111:f403:2415::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

SNP requires guest_memfd for private guest memory, so enable it so that
the appropriate guest_memfd backend will be available for normal RAM
regions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index e4deb7b41e..b06c796aae 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -880,6 +880,7 @@ out:
 static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(cgs);
+    MachineState *ms = MACHINE(qdev_get_machine());
     char *devname;
     int ret, fw_error, cmd;
     uint32_t ebx;
@@ -1000,6 +1001,10 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     }
 
+    if (sev_snp_enabled()) {
+        ms->require_guest_memfd = true;
+    }
+
     qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
 
     cgs->ready = true;
-- 
2.25.1


