Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83381C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmM-0005z6-Ea; Thu, 30 May 2024 07:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmK-0005ww-1k
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:04 -0400
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2407::600]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmE-0001RS-T6
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSzBCIsil9SHOHRU93RJmulD0zkSk2HgBz7j3mcWevowwczEMpZ/+kemd0B3iQCgrALPEDUnI3leS+CG8mInGTEuSJ6r18cPfOAsWn1Axi++Oeh0VYJ+BpJD3zAXUi94+GpXcj+fxCG/aXaLNNxTOOBFAifcEQIDwyfPQZwWJ8FgdxBJcBT660S6aboFwY6bSO7VuL95VbzdEju43SPfJHf+MbJ9nEfwsBcccyUyywxblG5O9iWAK/ugcMhmdbulovJvRwGB4qCeDUsgk7jiWsUAYF8SPRJ9hI8Uj10zlqF4X5MziCRyHr0ZmHXLQU6beWk23L1x+GR9vCVkXgEToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AsKJ/rgkkCDkjUvL6JMGrlId+MVOcgn7iEWTgFrJeo=;
 b=YTXRWw51uW2tUD4G1+lgornRfaEbzS+YLSC4djn0X5x4oxs/7Za45JaLaoaAUxht9rLFuAFpXFTxmviVehz271OIDf4NmrdDXr8aaeE2UUY2oEughwHLaTH+PbD9FsujjU91D2nEg7pNawsP6XF8Z9YiwZbLafMb9/Zj4v6nlxUYrtwAzeNEyEnQi1Q7TN/m4TuZnqSEqudQUegqArVFQJ+GY+HUJcel8Dz+bC6xjl41StuNyGWNfrvzi8WwL+XaxFPfoCw7sOJ39NwIzNfqtrQnPz4W9Xxj+ktWdMOD+fN3IgtCqbgClVFiEYv9+qiTHhN8L4akD9/fbmX9egjzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AsKJ/rgkkCDkjUvL6JMGrlId+MVOcgn7iEWTgFrJeo=;
 b=ecg5kFXktMShrHUJxoapTgNyFjG/CrjXp5kQVzw2DUat+Eq2Hc2jP9OJOPMnZ0Fd2byRcyVDwBJBZlLn04xpPxg2GwuqrblkKX2HupB2jhv2z36VolCYvTOeTSRCgH8/gTQFI51HQzcBmuBS6tUhrbc0apHqIk7K3OdytJ5S2Ic=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 11:16:55 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::94) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 11:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:55 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:54 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 17/31] i386/sev: Set CPU state to protected once SNP guest
 payload is finalized
Date: Thu, 30 May 2024 06:16:29 -0500
Message-ID: <20240530111643.1091816-18-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4fcfdd-5688-4ebe-1e4c-08dc809a03df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DxorTXMApDvWirNZOeVL2LgXvZCO9EWNaMqu1PLJP3iCeug+lFTide30Tb+o?=
 =?us-ascii?Q?lPAJBjz6wTxepBBWfwY0pbn67qEIcx9/6dax9yjNIPtMnV5Ne3hPqZYs61c7?=
 =?us-ascii?Q?xVla2Ug1AJAvMC4XlvUkLTcZYhRfNxf3inO5d6u6QxYuGvbtxUf2koeflu6z?=
 =?us-ascii?Q?ASoGLZeW1kIhJXtWKMpITYwFZs6stI6UgtlSGkotG83m0KcwQeUtuCXzi9da?=
 =?us-ascii?Q?H15wGm/urAIfJZeLjfaQRf6Msf+12bL6JjkCP0YvMgFJ0C3YMd0IjhRO2EME?=
 =?us-ascii?Q?LWgH/mDpWxUxFzZFKgr4q23lXyPO7zQUrEIIt/O3jlKCk8fAHzaSNojxFCbn?=
 =?us-ascii?Q?wKO1dctTaDSxv44SS2KtOxoe1mr0uzerMzGXIwGRpkGYdAI20BQrrvIA4MJD?=
 =?us-ascii?Q?14wP6CrK3G5fZ6s2MVUAbk8W3MdhPODadAz35bWRcPzV65BzgVWWJMl1u5eA?=
 =?us-ascii?Q?pvrjojhEYwxmLPVK340vUiJbtFh9lvaO1O5GXfEBTidnsWjjvn1hwH+WOOKJ?=
 =?us-ascii?Q?GE/KI4uA2RPv/OYIDplzBTIgD2skRRxmOjpSf37ZnLOvD8VouNDjbLzwq4+r?=
 =?us-ascii?Q?Dczg5vtCIkrJ6AcD9XLFl93Yp7jb5Qkedg9tdr+cDRCnrhD+qGObq8DfnzdX?=
 =?us-ascii?Q?Mw5/po556NgCIqZUiVktiMQfpyMj9cF16tVXhpOQyZOYZhyKPsj/di3SccTA?=
 =?us-ascii?Q?frL3Z3iKWVbptUhH2X2G1H803phqRIIZvOkHji7bgZwk+09EPWYKhQcLxGmg?=
 =?us-ascii?Q?sQSjrwEEEQj9vEes7ZlFf+rXFHpyzISEEDhFKuE1XJutyWbxIGo0Fb1ISah9?=
 =?us-ascii?Q?mhnW95K3bMo8qQ7wfO8e9Oz4MuAE3brpYxXyOIhd4vV+p1JcvxIV1LuyAiQ2?=
 =?us-ascii?Q?9HyWSqWkfOVCAaQlGIXNuqk7UBieGtJcVM1fHc8pP7Y2OURPpLLrCWNfTKJi?=
 =?us-ascii?Q?Lf8UI7OdEoXJR15aruYrzdSPw1cjqTDoZvpqv1SKy9NIPTV+YZU0z4O4BV7M?=
 =?us-ascii?Q?Hh2Jgn5ws1mwDLAXNKq6qaBdmgtJ0WHaTwUTu3iW6SwzlcFURHcqg1UHCDrX?=
 =?us-ascii?Q?zT1cG97wBFujwyvivi9LK6DikQa/oNVUXlwG4fDnYlEfbLtweMTFuX5hOiwU?=
 =?us-ascii?Q?kamcblcO3BMmKJewS0eqWdmmgXzZJCx4L+O93tGfHBg7Lh6+0Hl6AbFNVBmV?=
 =?us-ascii?Q?GqJEYoiSZYysKdX4tze+rVeHWfQ8qj7s9cKFHVQ+0igf/rbHV4yhirxOafoQ?=
 =?us-ascii?Q?fvm+PbwxQXK1t3azQmyNBLc3r10R0YE8NQvbSeWYeiTuyGCRSHxTKy56eL/p?=
 =?us-ascii?Q?/LUKq1By48RPWglP/VqPZdL2v2s8UVDqnCrnfxZ2TaaZTAiL+4x0Z/f6GmRf?=
 =?us-ascii?Q?YL16OMjvS0qaj70lBP1AMTC/P5eI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:55.7571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4fcfdd-5688-4ebe-1e4c-08dc809a03df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
Received-SPF: permerror client-ip=2a01:111:f403:2407::600;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

From: Michael Roth <michael.roth@amd.com>

Once KVM_SNP_LAUNCH_FINISH is called the vCPU state is copied into the
vCPU's VMSA page and measured/encrypted. Any attempt to read/write CPU
state afterward will only be acting on the initial data and so are
effectively no-ops.

Set the vCPU state to protected at this point so that QEMU don't
continue trying to re-sync vCPU data during guest runtime.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cd47c195cd..2ca9a86bf3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1011,6 +1011,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
         exit(1);
     }
 
+    kvm_mark_guest_state_protected();
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
 
     /* add migration blocker */
-- 
2.34.1


