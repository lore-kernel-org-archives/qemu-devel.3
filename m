Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A07D6A22C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgaG-0007NK-Vk; Thu, 14 Nov 2024 15:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tBga8-0007Kv-Ax
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:36:49 -0500
Received: from mail-bn7nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2009::625]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tBga6-0001Di-1s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:36:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0ZZH/b23h2LRB0ajORQIjjm7DLAQ8aMUzp6rBZ7+RtsQvOywoiEkBH6ki/PESSyjfiSJcP3jncly52H/7X6xmd8nMA/mkD6IyDkJIAtTsS3Wd+ceWf1Xq3kABzUR8pJHlYvu5tlnUe/CbUrYEKkV7JUSdjKVB+louKuGzchomdWXGl3BVL6CQGJy4qQR3m973GpKT8Jt/1L825YzDsVxKdEzwydDKCvc4TcVtc3nnDRQYeF2HdvQVXkM8kLy3DfQ/QYz29KsBD8cs1JJoItnTS2KrGRDplk2C61QygXAdchDy0akbPXEzRxpnSmkM9iqM5RIdLw3EnboTjnwYf8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO/u+AQkXfS3y7pp89CmLgWcFfYdYu4Gp3LhA4keC1o=;
 b=pw/lUx+I31Sbp+EQ1cQ2s3K0REBd1rAyEgxJihqAfE96MvUP0NVOi27DrxkGgBvhNuhpfD3ivsW1AeIBfzFv2rv+6KTfCLsE8aMiYVGM1MC4JB/FkjMQx1EUjLOBUTrFLKzHZrC/FxaLyTTQ6dFnlWtZFooD9zBJ3Fyn6REo5O8nL977gXt1kHCWxVF0RjNp+qMLrzDcgM1b6DBOUBDRCPM9GE9H3Mi6yJ1RgGDXPW7rPCGRxCG+8uDdNnQBGHkQ1xLsup/JZnz8iyNWL3PChxVaGVPr/X4dBFY3SddSzjvxyIfpN5jt42+RvYWZs/Lm0qp6F+6wJ4o5FxbSf+HqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO/u+AQkXfS3y7pp89CmLgWcFfYdYu4Gp3LhA4keC1o=;
 b=BvA4yaLidk2zXu8IzAJLToTeFXbVFloshCEQ6YcGxGT4shf0ijtCJCpjw9aIfYBQho9NjJlBmcKhUw1dJeOzLwJ8Lbf+df4WefA9RRyJx+fgB92aZNajUiTuphp4jDdNJW+Ukkp/l6E+MTkWtUYZOhgFjGNz+V8tJVzGljAOHdo=
Received: from MN0P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::27)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 20:36:38 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:52a:cafe::3e) by MN0P221CA0009.outlook.office365.com
 (2603:10b6:208:52a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 20:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Thu, 14 Nov 2024 20:36:38 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 14:36:37 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <davydov-max@yandex-team.ru>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>
Subject: [PATCH v4 0/5] target/i386: Update EPYC CPU models for Cache property, RAS,
 SVM feature bits
Date: Thu, 14 Nov 2024 14:36:27 -0600
Message-ID: <cover.1731616198.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2f1e0f-8311-4aa9-c8df-08dd04ec0a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4iJOfEaPh3hM2luvStgN9MFER4KFJgthtrfdmY3BsBwV22HQaPDfgdNvaCuW?=
 =?us-ascii?Q?SiK97N4Wipdig0qVG/n+cydKOMKC8axm/kiXJdcdEUPmDUxlRo+PilxNcfa4?=
 =?us-ascii?Q?XhDNeLPUmpAT1Ve5XCrXLrt5SFwx4s/TQDNTxHJGWk8MnN2FkHM7KQHxtNZP?=
 =?us-ascii?Q?ji82TEBHL1JiL42AvIapG+vGb+C3mEX8sUfbffJ+rCMzksnSAyqVXTpWTRec?=
 =?us-ascii?Q?uonNwRvv6kALxQETMPu04yYLrfnO6fxdSbiEE1/PLl+DXmR4n7WK+mt5eBAE?=
 =?us-ascii?Q?MdLFfid+i2BBnogt4nBlehg0vmY3d5zmhZKgV9q1U6drtFBuZ3eQ5Oskw7I5?=
 =?us-ascii?Q?SKn5LCwM9IrgLjhfBpdpW6PtEy/Jg0Q4ktIuDzf8bvUOfWsb2rxV0D5+b5k0?=
 =?us-ascii?Q?QUXpJGgCc2gdhzX3iuatfU9RWyoOaToy7mVu628CSOP/psB7XQO4LjUvbtrP?=
 =?us-ascii?Q?jCTrBkXVuK3RysMT5BEsnjvOTm5kK931NlyDS1s0eq4rVXE1u0Mb4uMLU9/B?=
 =?us-ascii?Q?d9+Gcz9nx2nxI50Qr5GBnEm0V89xkhANmiQ/r7brJoMVTCV5iqekypt9ESNL?=
 =?us-ascii?Q?PCqWSFAkigVeXQPQex+DiGZgpJsQoBH2Bn2VzBxCa3LU7VWMu3rcFOfVeNJ9?=
 =?us-ascii?Q?yyk458JTyf/QCKlyC0tZfWPPWlxZiZlieTjnWjkoTsXPO4+tLzoSs/p7rEXz?=
 =?us-ascii?Q?dbjSIMz2pqdd3dJ+GvMID1f9TeoaQ2pgiMxNFqDHYezAYl9uHVfhWJj3eBAt?=
 =?us-ascii?Q?1w+dhUDlo/p4qsty1GNBq5u8UYHza03W1YqF7j0QJ9A4++8zhcRS3UjIvQIt?=
 =?us-ascii?Q?VhFKg1tR+bwnhIJ07Lb1zSsiG1gagvEP1AByBuqQFK7sTbrqlQmhuq3sjR4K?=
 =?us-ascii?Q?+n5OsChtbHvb8ggGRCoZWQMCZy9PdcSQFqCqQ5YyypAvz8DDL0DEg6GSAlBT?=
 =?us-ascii?Q?LTsP+uVxdWMbQMsY6p4AxyxkV529zyXY0bAQwfyVS7yMfy0jjwRMRaqq8g37?=
 =?us-ascii?Q?MbOSYGdjCf6Vu4AoYEN9FChSf8MRNXYPuy+2hIrsYrrmZWFLcW7e+vWEa1La?=
 =?us-ascii?Q?/4u10LnTv57TYlh3bfeciMoBfjg9qQJZ2Tc7tGwF30PQ6hTln6FpTb2NWkVX?=
 =?us-ascii?Q?SU88X02vL5iOkexAfd9lPCTfbH4cKM/F91coxbhAJNdkXezjWSrPImvVw+UJ?=
 =?us-ascii?Q?RTSJQx0dvHR935i0lH43ejCJhRf5jkPax+kfc5za75NTw3yUCew+3ERBgFDp?=
 =?us-ascii?Q?D7b9B9t6g/xqevWRcMMyz4dsddSiVfMF9v/Rtun/Rz4Jo/XF/6q1wPC2bMzr?=
 =?us-ascii?Q?3wwskmg/Abk2G9Hh23yfyNh4SaE24tiGg6gtF57NqqIM9YA0B8xbs2/DH5K1?=
 =?us-ascii?Q?sWykNcI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:36:38.3363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2f1e0f-8311-4aa9-c8df-08dd04ec0a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
Received-SPF: permerror client-ip=2a01:111:f403:2009::625;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


This series addresses the following issues with EPYC CPU models.

1. Update the L1, L2, L3 cache properties to match the actual hardware (PPR).
   This needs to be updated on all the EPYC models.
2. RAS feature bits (SUCCOR, McaOverflowRecov).
3. Add SVM feature bits which are required in nested guests.
4. Add perfmon-v2 on Genoa.
5. Add missing feature bit fs-gs-base-ns(WRMSR to {FS,GS,KERNEL_G}S_BASE
   is non-serializing).

Dropped EPYC-Turin model for now. Some of the feature bits
(srso-user-kernel-no, eraps, rapsize) are still work in progress in
the kernel. Will post them later.

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
---
v4: Some of the patches in v3 are already merged. Posting the rest of the patches.
    Dropped EPYC-Turin model for now. Will post them later.
    Added SVM feature bit as discussed in
    https://lore.kernel.org/kvm/b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.com/
    Fixed the cache property details as discussed in
    https://lore.kernel.org/kvm/20230504205313.225073-8-babu.moger@amd.com/
    Thanks to Maksim and Paolo for their feedback.

v3: Added SBPB, IBPB_BRTYPE, SRSO_USER_KERNEL_NO, ERAPS and RAPSIZE bits
    to EPYC-Turin.

v2: Fixed couple of typos.
    Added Reviewed-by tag from Zhao.
    Rebased on top of 6d00c6f98256 ("Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging")

v3: https://lore.kernel.org/kvm/cover.1729807947.git.babu.moger@amd.com/
v2: https://lore.kernel.org/kvm/cover.1723068946.git.babu.moger@amd.com/
v1: https://lore.kernel.org/qemu-devel/cover.1718218999.git.babu.moger@amd.com/


Babu Moger (5):
  target/i386: Update EPYC CPU model for Cache property, RAS, SVM
    feature bits
  target/i386: Update EPYC-Rome CPU model for Cache property, RAS, SVM
    feature bits
  target/i386: Update EPYC-Milan CPU model for Cache property, RAS, SVM
    feature bits
  target/i386: Add feature that indicates WRMSR to BASE reg is
    non-serializing
  target/i386: Update EPYC-Genoa for Cache property, perfmon-v2, RAS and
    SVM feature bits

 target/i386/cpu.c | 299 +++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |   2 +
 2 files changed, 300 insertions(+), 1 deletion(-)

-- 
2.34.1


