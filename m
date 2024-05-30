Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456B1C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmY-0006A9-7I; Thu, 30 May 2024 07:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmW-00068K-7G
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:16 -0400
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2417::600]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmU-0001Vs-3i
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRTqGNfZsv/yiaSCx8CamY+5hcv+ObNtLHdFUKRwBO575RfKBZxDdGHaMt4A7U6FKgnOf8kPsSW+vkW0YIgBY5kyez7znxoM6LUMrIRS541IdtDcKpbtopP2Ua+fHqOdQsMx9S8gdlAcc58xu8OntICcdCq4vymq5DUIcfukRcjBHbNcdz/tam2/Ud7XkZGj9zD75UCLqv2z0Lv6y8OKtxHamvuSqirsAHW8YipPGDc0XyQxwk6RJg2LBC6gAvxcv/vwfDElwc/8weCYzJByrNMY3VyJBCh2U+bz0Z+X+jfLVXXDym3WBYlJidx52lobf8BcpC3A/qUMzY8murjWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30NN+Noba7skJcAXk9WnPHE7RGKVP305PPHVASSr+ys=;
 b=FupDqEpbOUHr0trDtWnoXUKLyTi+qG3d1s/vdBthPV67lEbrueGdQIJ9mkgqmYTI5zoifsw/l2zwsg+YFn1tgIMk955bGpgMVx7SCdulxQwkehPfcLbcEtB1WaxzlLKiwvQmhhYNSeBn/Y/27Xv1XEOIqkuzmayULWG4mN1cbxJGauJ9+mIH1K1JI/pdYc/5QfC1B2gfbyck/hiEOXwbzPkESjpKj5YyzSk6nCtxw964PwxR+1Xyoyp6Lop3sAJPjGAaja7T9b8NIXLEDDRr7iF7iBGL3EqDD4Thp3ry4XJY50gU3dk/mJwMWkFGpb2Ix4E+hQUOVi3KnhmHLtgT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30NN+Noba7skJcAXk9WnPHE7RGKVP305PPHVASSr+ys=;
 b=wLeSwyiJIUXkezFTuPwxNV1qz6k7jhNd07Lm2s93w7gkbYrQA8I0cMLOOqVOagQgh6qaJ799j4XnvwyZ/1nqhynEKG3V04CZXfWBlYZDKwu7gPwWFGnPlAlw0sa4hLLYyTV8qEW/jJBluUD4TO7HA632ceJeP6gj6qch59oGm74=
Received: from BN9PR03CA0566.namprd03.prod.outlook.com (2603:10b6:408:138::31)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 11:17:09 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::96) by BN9PR03CA0566.outlook.office365.com
 (2603:10b6:408:138::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 11:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:17:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:17:03 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:17:03 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 31/31] i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP
 guests
Date: Thu, 30 May 2024 06:16:43 -0500
Message-ID: <20240530111643.1091816-32-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c85b27c-01a2-4ceb-83b8-08dc809a0bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xtgjdDYCcJBhveDNUVV25tdKaoAVxQkKpUS3VWn5V7AbPW9SRx14iV/vcm9W?=
 =?us-ascii?Q?vM+sWBELdPR73TIIM/MyuvaELO10wSV5PjTovQTaqX8PpDpV/+Lb063+caZP?=
 =?us-ascii?Q?Wx3ZqIMkwWPAAm716js1JAcBcXXWJ2u+cizl8NVkFW2OT56jzFt2ZUqPS8Ts?=
 =?us-ascii?Q?RKqU5GYjts/WPPv2jxPnXpVQ5WRUscGN/QaHOUvKoCbmS4oMFpBW2Eh/ZCrD?=
 =?us-ascii?Q?/OF+YGKBPSAX4menWOyzDHgOHm9kiV/zOGgTXjTbZ33mvKSRByVdbyTs2p38?=
 =?us-ascii?Q?MfRCt4ags1oRmEQCgq94HkIZ9KnMr8Iy8mDcOaPalzIQVwhy4Umwd8wuoCiQ?=
 =?us-ascii?Q?E7SC0DC3L/l5xJqAj6PdOaatRhwl9eyLGyLsYgn6+9G2d0xcbPUsp/xo3J+D?=
 =?us-ascii?Q?rSs69X3yK86yMonFCARap2fDGpSpyvJYocYsiwsyueCG0JvX6yBsPOX/uAYL?=
 =?us-ascii?Q?aXvkKErcBMChLwRD1iSEyH6KcaDxGsWqaD4ARlPAzLXC6VMvQNLpjuHFN+ra?=
 =?us-ascii?Q?GduYfycfEEjUyAdJuK+CFRL0Uw9jIl9tcuRzsxt3d80z+u2+I57GxNglou0E?=
 =?us-ascii?Q?5HGJc5cGIEWixrZw9+8cL+qL+aP85W0m0h0aT3EbdI24Rt6Ht7LuHrL9ioVG?=
 =?us-ascii?Q?vUdRdERSh5Dq8FoO6kZONgzGhh1vPnjiSUDZsNvbGVVaKtgOtSOs08SJv1eB?=
 =?us-ascii?Q?EqEpgZAMaMCsSkJhqFn96YL5ryYEEEjzrPmdONEBb8/dVGsLu3SuQOr+4loU?=
 =?us-ascii?Q?XnDqgfUlpSdmzf0PnQwH0c1OJZUix1cuj4aN8Ihr9Iw+3UgdzCUnIcukGmas?=
 =?us-ascii?Q?uV8kmC4s8Zudn5HdLMdQumynxy3vtS9KmUQZrgid8aDWY/RHp5QGwLDxFdz5?=
 =?us-ascii?Q?UkI4ggNLN0OCoPuq9Usre+LWOTTcR0ow4Hhd38MeDQ9kjeLubXE/Atct9upw?=
 =?us-ascii?Q?3pgjWUc6gBjOnd89Ubenkx1kxp4tdJSIAg02+cnrHlWKZ4tXLRZk7IFQ9dXo?=
 =?us-ascii?Q?+Bb79AsYKL3w7ZcOAHKEFCFg4JIdRjianEQHZx7f436Z6QGjIEjD0snLbs1m?=
 =?us-ascii?Q?JJVc1qnxyiy0iEZl8O8ZzS1VBvXM18DGSlQ/j1WDZ+YDmW1qqf85qf6yWUbT?=
 =?us-ascii?Q?RLS8iYrqm26nBrqhoYi9yrSKg80DEUJVDDtoMvynwOfqR84MFzq1xCi4hp97?=
 =?us-ascii?Q?nC5qpFDbR2ZoUfZCw0hzbTsc/crC6VstXLmqdazVEsERishjOvKiKIrjBwwZ?=
 =?us-ascii?Q?/NLIW/jRMA2DSsjAgMevcNLwPCrwzdocOzfD8o6uzh2PvAsSRh2G2AnSFWiK?=
 =?us-ascii?Q?nhiDKej6W3BpAWeEhyTRsXQ+BqV7JjL3/vu0QhU8nK4RWqxO7KF7chYJoYoq?=
 =?us-ascii?Q?ieH20tFXep21Awr+M1YQuztYpQbd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:17:09.3322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c85b27c-01a2-4ceb-83b8-08dc809a0bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
Received-SPF: permerror client-ip=2a01:111:f403:2417::600;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

KVM will forward GHCB page-state change requests to userspace in the
form of KVM_HC_MAP_GPA_RANGE, so make sure the hypercall handling is
enabled for SNP guests.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7d2f67e2f3..c1872ce3a4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include <linux/kvm.h>
+#include <linux/kvm_para.h>
 #include <linux/psp-sev.h>
 
 #include <sys/ioctl.h>
@@ -774,6 +775,10 @@ sev_snp_launch_start(SevCommonState *sev_common)
     trace_kvm_sev_snp_launch_start(start->policy,
                                    sev_snp_guest->guest_visible_workarounds);
 
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
+            return 1;
+    }
+
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
                    start, &fw_error);
     if (rc < 0) {
-- 
2.34.1


