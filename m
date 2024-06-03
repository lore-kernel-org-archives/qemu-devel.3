Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C523C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDZ3-0006r6-BH; Mon, 03 Jun 2024 15:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDZ2-0006qx-3P
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:41:52 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com
 ([40.107.92.49] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDYz-0004YI-Dm
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:41:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q55Iy6WQUUjZDTm79EfG5L346tSqL+dCk0bu1kkZTBbrseVJa//5I215KXR+Nj04pt8Vy17bG/J822yV9v3lAh4ZFI6l/GVF0e3B07CeR329740GWQ6hIyc4KKWGRX5tBxan9zaQZmOTT7he+2wSnqiIhyPeq2KNKwY3jOiagkqYeKZ+BkqR5kfr8fg3DnjJk/tIikJLvZQ0oWPWbCM09YY/8hfgNzRdi9vbZhDhE7sRVndOQ82l6636J1exzsXrxx3vrWObilyNCj7ZLaKCtFi9N+GZ7s12ErSmWyuvZRt+HdQoIzxlhLNvDm71XUVgJNVh9gk3hAoD0UM4TLOUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COqnukF+z3BDN5pxDIJXBSYaWre61rZltvXQcA9SH1o=;
 b=i5S47LvxIoK/4WRMzDS6eWmnFPYkY7HFBqw3OCynJCgjuuHNvk4uumAxwOYnDPVgLDMi/yHykmR/l/g/UMAmV3zFTuQB92A7/lXhaWfetu++izyKDrQ97UW0eggJVAahZMOqMPywc6Kv/5KJQVYRwqCbmtpaZLZ7zNVcxy8eiQksTNJALb/2e7se06qb3uNkL01Om6oT4kNcZa/F221Ez/s3QbGbfOvIhNmD3zMyubGDaIBmRSJN6BEtSih/ZRL0Orp8xUR0zwtAi5qsza9misLB0nf66/HNwNWspMF17AcKOzqPZ421wphnplGCqTO5wBsLmwm7JNF0N2NzXz/COw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COqnukF+z3BDN5pxDIJXBSYaWre61rZltvXQcA9SH1o=;
 b=4/8ltbEEFcwur6FasYmWrThtWdF3eFYkU1zviQkWovHtkzUs4yh0sDjMH363RMCXGUqB72RgrVKndRLMYfOI4rQ2jiwyBVLeZ7K9wYOCVOLDSbsebotRGgzrIIRlQi0BiR17qjYjNy7gYrVTYTmKY8pjotdO53SMFXD6s/nUqCo=
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 19:36:40 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::c9) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 19:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 19:36:40 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 14:36:39 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <pankaj.gupta@amd.com>, <william.roche@oracle.com>,
 <joao.m.martins@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, John Allen
 <john.allen@amd.com>
Subject: [PATCH v5 0/3] Fix MCE handling on AMD hosts
Date: Mon, 3 Jun 2024 19:36:19 +0000
Message-ID: <20240603193622.47156-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: da045b94-939e-49af-6355-08dc84047d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P5p9dHc5CkGJdFfvE6YCsefN2XAhi9YPdC4nyeLWrBOoH/kKn30NpaYuhHgM?=
 =?us-ascii?Q?1n0Sh6FB7Lq6xyWyz8J97gGTwZvkPcsaK/I5X0nihbk4lzahKxEuhg7zg5hw?=
 =?us-ascii?Q?3jF/Rkg444ZXanPWdezoMpWUoWS3Mn39+Gj1+eVKxLmd3syjPZruAv3zrqvc?=
 =?us-ascii?Q?C10GYF6YIph18b99mstlVKvh6UlO9GhlRIggbvurGuO6xGVaKp1jskpZJAhi?=
 =?us-ascii?Q?miPxmwhGZNcl3VlYcyWUm2xN8hWQovW34ho4Y3msKY/kDdOgkGo6qOB+2CED?=
 =?us-ascii?Q?nuf0ChmT8vBOdPCoHm6SZiw+nfs9D0Riq9psboexQJPYIIw6hRZ+8WZfjWwj?=
 =?us-ascii?Q?Cef378gFgioq9uQQdsf43udxeGaZCtg35Y9JxSIVBYI2hh4T3PL5QWSnDICw?=
 =?us-ascii?Q?H9c+4GGssDWJz/lol/aEubJQfPf/PwSdBEPoVtD5Tj5LHbQsJU1OXwxBngB8?=
 =?us-ascii?Q?JNhkMYDeupWkvr8Bwh+uC/k3e7Js2pGZehUVQmOyhlLg58RXb3oqZdJfMdty?=
 =?us-ascii?Q?F5NAxl/VIOjIEE1fGqjZ5/gxHCNYqDewD8zgvG+3WSTv2yXRn709JUZrj0SC?=
 =?us-ascii?Q?WNG6pK0zjfpLQp6a0cw3a45mtwYA2hvjApAnKpXvBLr5P/aJlmg4RAu292v3?=
 =?us-ascii?Q?dP8sqjPNue7upyE2AtrEbGAdESdidejrwTBiLuOLdLMufTtXmakg1+UQ2LYx?=
 =?us-ascii?Q?dj5F4VmXyCtRVsukBOJvk/jbi11iKA+0N3zEs9M6mosBw4flQNOjtEf9FTkk?=
 =?us-ascii?Q?pNKfjJxmC2mu+KDq9BkhdqG9WTGbCj5XZapfzmtJ4yOmqwmibTtl4kyJ1jLv?=
 =?us-ascii?Q?/wfJPvhpoFUZf8e3TyIDBPnDSo/eInFr5NAEvmolgTyHusO7puJbXmrvBpnp?=
 =?us-ascii?Q?400kOj09MBKyqa74s6K8wH3Zv1C0NNdRaKCSFEbfnM97mSHkRo34heVrterE?=
 =?us-ascii?Q?nrux8hqJUsw/Af0SxEU70F3F2BmetdISDCy7HdObLI0P2YwF96qk2pHII+4j?=
 =?us-ascii?Q?RemvGo83S/R4+clseul4bJ9EeoDD4Tf9OSL0Wg0GXpC/70hNKibNngkJGqJo?=
 =?us-ascii?Q?rS8cgKW8Wbg3hg+V6C0AlUJSD2PvabQr/A6JnTHfpps0zvewDUupAsmKAYMN?=
 =?us-ascii?Q?3s4TRFFCDOglGNKkFLz9meQVfAC6XZmX0EmTFHJryDU4Kf4vsF8SMmNNbx3z?=
 =?us-ascii?Q?N//QAG/ijiUDnIMyGbM3brtF8Ofu18acXe+Gn4ErSel9qL5FSrHXKGDCkVgE?=
 =?us-ascii?Q?Yo1Q8IZLhs1JlgLk9PerADeyZ0P/eEjiawgri86dNJND8ewt67uAfa+ULE11?=
 =?us-ascii?Q?oWjNW9QN4PBgL0j/nPI5Fy20O0+NHw8syG/98pgRdzkOIjNEkUeutY4utuEu?=
 =?us-ascii?Q?MvO+8cQnhpx47BxAWsePI3CaNNwU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 19:36:40.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da045b94-939e-49af-6355-08dc84047d99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
Received-SPF: permerror client-ip=40.107.92.49;
 envelope-from=John.Allen@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the event that a guest process attempts to access memory that has
been poisoned in response to a deferred uncorrected MCE, an AMD system
will currently generate a SIGBUS error which will result in the entire
guest being shutdown. Ideally, we only want to kill the guest process
that accessed poisoned memory in this case.

This support has been included in qemu for Intel hosts for a long time,
but there are a couple of changes needed for AMD hosts. First, we will
need to expose the SUCCOR and overflow recovery cpuid bits to guests.
Second, we need to modify the MCE injection code to avoid Intel specific
behavior when we are running on an AMD host.

Version 5 of the series differs from previous versions in that it
handles AO (deferred) errors rather than ignoring them. This is made
possible by in progress kernel patches that utilize recently accepted
address translation capabilities on AMD platforms to translate
UMC relative normalized addresses received with a deferred error to
system physical addresses that can be used for memory error recovery.
While the bulk of the address translation code is upstream, the code
to use the new translation code in the event of a deferred error is
not, but can be seen here:
https://github.com/AMDESE/linux/commits/wip-mca/

This adds a new wrapper struct for MCEs and uses this wrapper to store
the translated physical address in the following commit:
https://github.com/AMDESE/linux/commit/76732c67cbf96c14f55ed1061804db9ff1505ea3

v2:
  - Add "succor" feature word.
  - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.

v3:
  - Reorder series. Only enable SUCCOR after bugs have been fixed.
  - Introduce new patch ignoring AO errors.

v4:
  - Remove redundant check for AO errors.

v5:
  - Remove patch to ignore AO errors and introduce proper deferred
    error support.
  - Introduce new patch to support overflow recovery cpuid bits.

John Allen (3):
  i386: Fix MCE support for AMD hosts
  i386: Add support for SUCCOR feature
  i386: Add support for overflow recovery

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  7 +++++++
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 41 +++++++++++++++++++++++++++++++++--------
 4 files changed, 61 insertions(+), 9 deletions(-)

-- 
2.43.0


