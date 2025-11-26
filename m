Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDB9D10372
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 02:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO4rj-0000nG-Ah; Tue, 25 Nov 2025 21:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4rh-0000k0-7S
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:02:41 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4rf-0002ZJ-Bj
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:02:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPRRqyIsdqUTHDLu8SwdilMmfMZdF4oyuGvu2PeAK7oWga6uqcPHLp0zhfan4EU1w4wxB/0bRpTLGHMCWyF3VtNVZnQQQ1AUzFoA25sWqe2evLU4pempCpY/F3sKeT7d5ZS19WSc3vpuLI3G16wA/DVApylX9ZD+wwidyi6KAOnxgxTQIIdvsz9LcuJ2I7vrsggqyngwW57lyZXqFKNfzwthUQMOqvpxjt0yB8xNrgzHrFvlKvrDZJhr1XIHY0yF5LGIpmALA5VBSU1lDoQUranY+jm9NG4xp5CsCReJcLjatKzgvhwTMkO3N6RLowG4/zsbAvvANzXzMWBb7EpZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD5Hpd34FY0P6X3616LP/stAfsDzC4bSY35mFFzifCE=;
 b=INSwYkGByv0PR9ujThYJd04LfF6gimPexEVlURjUZlvWxBV7fsA3OZi8bQGEevR3bcEMHB5AwZNl6O9vU0c3+c+71Q3E+f0xCjYAF9kXsoBYoDDVNAWJS3AQSUOQeQ+Qaw+JEBlChLXfKb3Z5ATaIshDO0AAXq0iTyd3eYR89nY4CvK6fElGUwURWRYUa/c6L7o23qMAw1fa4ATeXqR9l/qr3eLS3n+Y7uzwvuQUPzolrqDMMDXmpO7AGMGtcEr9x57TCCTn2EobEviS5GWlFF+O2r4NyWwwY0w0h9e00faJjmcwXspPrguIGo6dj+8MZnCItQpduW16JnHBpLJtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD5Hpd34FY0P6X3616LP/stAfsDzC4bSY35mFFzifCE=;
 b=IvIiZbT9fPeK5NIu0JN+8ewoxcbNoEzBOk0stU1ZyxoP+EnZBHe7c+8R1LdvTOZ9/b8TXy+uqKPiqnyGcQ4G2E1269G5u/o3287bmz1ArDODoajfqDjsu90cdnnT3Tz5KAevOIdlVo7lvXVMrokVa0LbXDAX9e6DFNdAQURt8wU=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 02:02:33 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::69) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 02:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 02:02:33 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 20:02:30 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v6 0/2] virtio-gpu: fix error handling and improve consistency
Date: Wed, 26 Nov 2025 10:02:06 +0800
Message-ID: <20251126020208.2449414-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: f76062df-7d9f-4bd3-57da-08de2c8fdcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XfGCwgvcpqzZsmwIn2ExgGQqIRRuja/TLHLpPMmjuP+vuPicp/vgFm8O8LFX?=
 =?us-ascii?Q?qwZvZtnVFKFMsJBAwFMe0/3urbSGdBOMvH920aq50JVW2cpm/sVnB82LFKDp?=
 =?us-ascii?Q?1BraAtzjZ1TK9aPyDNUhHSJxKZ6jpV9xVsMdlCJqfCcY3l23Rtx5DMPT3isS?=
 =?us-ascii?Q?GWNFCa6it9wI55trWhaKiBNdSHeXNhIfrrJADChO7rmnbFnJzEH6obhmfvMi?=
 =?us-ascii?Q?9cYdkFpQ7UGq5c8m+U8dME+Q6TorOyc8+zg06nXTM+/ZDKrb420DeOtwkMci?=
 =?us-ascii?Q?zY6FiAoMr/cwcX5/K4+w6MivJEK6jS3s5uKjfx12YKC2HF9T+c4if/p3YCRO?=
 =?us-ascii?Q?HjtRW4CAkC8cUw2zJyFTcztNQp98V5CErll/9Ti4mqUosbr6o3bnQauLxK7/?=
 =?us-ascii?Q?d4bBq+n4xETT9COeLEoDNt2gF1NteGPLhprx/JZIsioiTIhczSsgZ2W1ZOuP?=
 =?us-ascii?Q?+Sdqy1x5D7rxwfl4azXp1+/nvzNzq6sQQWwJVveDp4ulrAEvvoRcAZSQ+QXE?=
 =?us-ascii?Q?Otxpymitx8/MTAxeAyBMG6kCJBYswnwRLMmmqOgdYq/PFjZ8WubqQ7Scci4u?=
 =?us-ascii?Q?MvweH6WdfXS1SZfaMP30l4Gj5saqFJIbbFcnWxcpyO1GRAhLZvClBXAMUfo1?=
 =?us-ascii?Q?tkipwArrkGg/VzvBz62J8njGRV2Tq2iQwdeG/A+TR4/FnRcTZeGY4lCTLnv2?=
 =?us-ascii?Q?fHSAGXkcoa8ve/ALO0uQmoRuX022lJGRH5fjifmbpTCHaQNRO5EFpucURAmE?=
 =?us-ascii?Q?OEZlQ/XuYbyrL5JJyvo2ZA5ad8oSFBpT893KEZFNXIN30+eIvJccPFpoNw0G?=
 =?us-ascii?Q?dsEr1DSoKPGVy/3T3NPelu+7rKK5U/KXcpA3vea1relaB6Aby7FkddvaFvUu?=
 =?us-ascii?Q?1Dyq/pqcI50axW2jN4n+0VVKfCNtNJ1FFrOyme4Hv2v28kRQ49tscwxU0hlY?=
 =?us-ascii?Q?S3WZcrFNLS1kPVHfOHpvWQQfD9L6fowMAO4F9lkvr8y56ti8L5i0Lakf6fwT?=
 =?us-ascii?Q?1m+jZnT3y5sSDnz9FabkTNfuPwYTbWCdTpgOylYbalPGcI/xg+8xKi41YS8U?=
 =?us-ascii?Q?Sf+EzPa5psAGhTRmHiX8EKMpb3kdxMP03M5ZOdc7YaJKHWM4zYQANXvrb89+?=
 =?us-ascii?Q?6j4oZO9g+FGLERWfGVoxDDWTr7CykVxpO1qUYSuhAkTNJWwsIZiS5d1u4BZ7?=
 =?us-ascii?Q?E9+D07pO+xnpARU/MuxqrsAhQL86zus1uLgHLo5DlsyYnLRoeuICAePDZzmG?=
 =?us-ascii?Q?w8m305ZdueoNN0cj0iyguDNIngjeYAVcT8pC6BH9pV3PVx9am1Mrq8sOKGKQ?=
 =?us-ascii?Q?t3Fetq3rZgoG95zsO6v5ZJUSoJLoid2/gvav74RqFeNCjrN6l5JYU1mPaU3u?=
 =?us-ascii?Q?1bvchThG0uAujgDANS/OOrqHrVPlE5Ye25nCvAIiamcp1Jo7bqYsoVacHhoV?=
 =?us-ascii?Q?4JvdQjPlXhSAlj4/5khny6YEtV8yCmq/yQkd5GZbMRNi851rsO7vVghpYD9Y?=
 =?us-ascii?Q?9DIFeRRzLJv+OMJIvRbS4vlI5ufzyNzJRx00Ptt38RxyuFaacUSNaVbGAQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:02:33.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76062df-7d9f-4bd3-57da-08de2c8fdcf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series addresses error handling issues in virtio-gpu and improves
code consistency across the virtio-gpu subsystem.

The first patch fixes a critical bug in virgl_cmd_resource_create_blob()
where an inverted error check causes the function to fail when it should
succeed. This is a standalone bug fix that should be backported.

The second patch improves code consistency by unifying the error checking
style for virtio_gpu_create_mapping_iov() in if-statement contexts across
virtio-gpu files, following the preferred QEMU coding convention.

Changes since v5:
- Reverted changes to virtio-gpu-rutabaga.c to keep CHECK macro usage
  consistent with other error checks in the same file
- Updated patch 2 commit message to clarify that CHECK macro patterns
  in rutabaga.c are intentionally left unchanged

Changes since v4:
- Split the single patch into two separate patches for better clarity
- Separated the critical bug fix from the style consistency improvements
- The bug fix (patch 1) can now be easily identified and backported
- The consistency improvements (patch 2) are clearly marked as cleanup

Changes since v3:
- Extended consistency improvements to virtio-gpu-rutabaga.c
- Changed CHECK(!ret) to CHECK(ret >= 0) and CHECK(!result) to
  CHECK(result >= 0) in rutabaga functions for consistency
- Now covers all virtio-gpu files that use virtio_gpu_create_mapping_iov()

Changes since v2:
- Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
  feedback on preferred QEMU coding style for error checking functions
  that return 0 on success and negative on error
- Updated all similar usages across virtio-gpu files for consistency
- Expanded scope from single function fix to codebase-wide style consistency

Honglei Huang (2):
  virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
  virtio-gpu: use consistent error checking for
    virtio_gpu_create_mapping_iov

 hw/display/virtio-gpu-virgl.c | 4 ++--
 hw/display/virtio-gpu.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


