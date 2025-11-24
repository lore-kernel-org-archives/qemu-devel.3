Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5254CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 03:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNCH-0005N5-3U; Sun, 23 Nov 2025 22:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNNCA-0005Ks-If
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:24:55 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNNC8-0004e0-HK
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:24:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx35cksR59OHEA2Vgw8sUrR/BSDObc1fNazB2LAM38xXbp+aYYG8V5PIHnutHRTJM6yiQskvfM6gmWYHWZuLj5qQGA1feQWv8/53R3dGRgAqRvPwsqX6j13io1AWrA/YWp5PbAKbV8tx917Q6YnL2tcfq4g/Q1Kr12DF56JOLD2UVjEItSYTooFtKcn08EDP6XJQ+3z8QCg8CMmoMsX0STRqUbma5C8u0jI35KM/3Lwb/EFyQAGhSbprnjRNqI+NRnAOcDL3iTRT3hTyHm5CCBVRr8ycKRDt7GhoNNTpB9AW9BZrTeSLVF0f/zZ0m8LK42pK2w0FVkHJv3Vcm1AxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCf1g32sIxYcNpEDeCb9VNg4cSW3o8byB5rqJLp/D9Q=;
 b=feGDg05ei4CttzUBELSW/4oxCX2y4GVPbwyfw9Dt7dYHGafB2ct9IoioFu74ZrsUO+ZTRck0kSTspNDoyH3M8arzcrgaxlYIboPxduuUuXex2ScKtKiDqIx62WHXBACauW2afQNUJieJYgCfFuHOKif8OoBUF1ao+8V3oTyueGPbacXFUKNwWWMN+ZEjvDPHL0KGdsxVPi/Ek7JQSp5I5gT5VOl08kFOPLVUg8oHXL5eVidNYiJWiEbNH2wsJJSTr9jRLwwAjYGKEmhnDKgV2Mi+T9nQG4fumrPecCrwqkINHvpnENiK89CcZs2/d714KW73WHz/kei7dDhdqhcB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCf1g32sIxYcNpEDeCb9VNg4cSW3o8byB5rqJLp/D9Q=;
 b=D1+0aePiat6Zq9W6r32cjNy4dNTj1mzm49agNhUFtalorD+w3jdGE/sG6My/fZkeEIGeOIPv+zG0SamPn8SDkCXTEsNIRtvbdCTcpMDKjzQY+/C0Z+v+bmeZ1qCBrPjAB+uZtFJfbYB+bi54rdB/zI7WT9AAEd8FE0bi7W0Bxq4=
Received: from PH7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:510:339::34)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 03:24:45 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:339:cafe::b3) by PH7PR03CA0008.outlook.office365.com
 (2603:10b6:510:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 03:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Mon, 24 Nov 2025 03:24:44 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 23 Nov
 2025 21:24:41 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v5 0/2] virtio-gpu: fix error handling and improve consistency
Date: Mon, 24 Nov 2025 11:24:21 +0800
Message-ID: <20251124032423.227712-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH1PR12MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: c5635716-d61f-4ab2-4d06-08de2b0903a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LWeutiqAIcI5/I9FcqScFR/IQNM/F2YhKeS7NGBjdczospga89fWHwuXYlRX?=
 =?us-ascii?Q?P3A092lns/ckL8QTaxTnm6jg/E0n113nVUV5CT4+2rUBYKkYZRmnJCQLs7Jf?=
 =?us-ascii?Q?Fo1G7w+t5bHYDBxdtE6WMwg6kOnGZ98V8GMJb7rFkd0QKcgtHN0GqYFG1ra4?=
 =?us-ascii?Q?iyomOMhtB218HZz8fpAGrOFDz5C7EcbUwTdBn1xyP30BHhxuxdFCRt+HXUw9?=
 =?us-ascii?Q?AZV9ZLiidwXlkmemnOe4U2dieNjPTFxDv36TN4Teepn/eg03Vae2gUp6MrXM?=
 =?us-ascii?Q?Ys8BxWG/SNF12k2MvvQKmU6FaN63WAB0ai8jQPpBxaiJXP33i0pj3kQvZY67?=
 =?us-ascii?Q?fot3e6BDhDWcPQ+CJq8NCpLWCCfFZfLLCIhHZ60KCAY45oZXQcgquDZ0Lkc8?=
 =?us-ascii?Q?ve+0/Ln9KZQmbA5RV36SNoIW3NZk4KhGdRGUyjfaVqQZNBAoyKx/rZVqOXei?=
 =?us-ascii?Q?7Rk1cJ90kiBX8rq5bI/RyacuuWcCYJMLIil+zZ0Q5DekO7jluOeWuiFlvfB3?=
 =?us-ascii?Q?Xh1s5gDc1bCKGU9/LUnlGjQg4Ph7NN4OjQgXgQVFutQD0sLIGGbgOQJKiX5j?=
 =?us-ascii?Q?LTqXCLvV/VtygUqKy3TX7RjGyDCl37cspD5b2h9MvkvEItchajw0Mxkc/3zG?=
 =?us-ascii?Q?g6QLa+q0ROphaOpUxw5aUrWJqLOPtD+4hV9gKuU//igLAaZrY+HhFmBQ3ABl?=
 =?us-ascii?Q?K87TFtvBJMlMku1ZkEpSK+7plOYXSQykhlhRVwLDo7eeXdqXo+8iIYvProRK?=
 =?us-ascii?Q?lpomSKzZNRlxRA1ivjffdb9VOfLV4nQix+zZnnx7ow6Ufp3JU41vUuHmmDSJ?=
 =?us-ascii?Q?uo2L2m5EMbuS2/jzadaaL2fsLExuLc2QKeJpCGNuHkTlntc7kQ7f9ioKhVJx?=
 =?us-ascii?Q?B+3xBAfLz6ZLR2lcriuhz9hMlajLdfuGkU7Cxe3L4rfaCZ/Vi18IKSbJHs/J?=
 =?us-ascii?Q?UGSWjGWEPXv99Mhl2fxssIGqmF8l7Rjd1qp/rxw/gHUrKznVJNy/4yWM5KEH?=
 =?us-ascii?Q?q8y2hdqyJ/r1UqYLq0skOPwLjHIrsMo7LFxLiGY5kGG5YdznF/Rmjn4w7QTs?=
 =?us-ascii?Q?c0Ez1lhYDuhMpGM7x+BWd0ZwnKoyAP+5s04mqp+D4v3KEUwWMG5FiPmhyu0N?=
 =?us-ascii?Q?DJPFSuKkQF5QnMUWE4Y1KyGNNgUhuRkZrxt3+yLQY3X4xjSU+cSvNWZtNvnl?=
 =?us-ascii?Q?FJ7RH8c9AqfSL9cWgaVPB06JuR5Ti+CmZWw1KaDzVQQgLFDwGxL1d2J2plIR?=
 =?us-ascii?Q?lXgDVZl2vy/M/iOD6oWydLTfE/drcR/BsNVuVfyOYiNdl09wvxS4Q00oQNO6?=
 =?us-ascii?Q?qPwDQzkdLNB4FRVZhWDtreJvfeslilBxKfXp0CDUsfwp3f7kibFErtPI9DMH?=
 =?us-ascii?Q?PBrkP5e+dKh5CWp1zjFH5JdfGR2teaKxxelbYBm0bTNZ24B2eGsmVJIooyHl?=
 =?us-ascii?Q?eUT3c0eCu5Xybr73z35CSCTEuvPxCzDXyoVUi5mYXV+VkIllvkuv6dr5mgho?=
 =?us-ascii?Q?mr/v6XqMEAtK/4/XXTpyKbsQjfv2qOOgzEgTPrYG6bv0cHhZoHhrpfs1cA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 03:24:44.7490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5635716-d61f-4ab2-4d06-08de2b0903a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
style for virtio_gpu_create_mapping_iov() across all virtio-gpu files,
following the preferred QEMU coding convention.

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

 hw/display/virtio-gpu-rutabaga.c | 4 ++--
 hw/display/virtio-gpu-virgl.c    | 4 ++--
 hw/display/virtio-gpu.c          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1


