Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B43FCF45D4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfTaL-0006bL-61; Mon, 12 Jan 2026 20:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTaH-0006as-LU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:52:37 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTaG-0006Fr-0p
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:52:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihAQr8vmdxjycp1IeP34khwVuapaj56MhLyGWUIjypNXQgqM2qX7E8+/PyYixfZ7hQ3ahRVc4C8VxTcW7BlhKDZwRpOqKbM9Gq09UvNVFc/7p9Rf6WzR/PfcsTvclt26SsryxPvc767MNWA1H7w/AsdvcciP+RogjRkQC0tqFUJYr8UaiZHnLtYwirOxygh9ssM8CDneHZtTrLX+hcdtFX99x4k/gZjl7LpsxAOWIGdeJBia6DxBjSdf7EA41OXaUoValPosBrtSodF4+vAN0hzupoyBmxrT8t+SQsnCBhii68BPhwlod4FCyhq+rjXnkoh4K8yv4O/Yw0AxmpKgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD5Hpd34FY0P6X3616LP/stAfsDzC4bSY35mFFzifCE=;
 b=Iz4WVtT+oprG+Q13yBMcQCIOllVl9XMhMzJNNM0KmrQN/UE0DyvSSVaARVzv742MQsOo/jojx+oj6ln5D6/FZjH3znxRnaJoFU+dGCNXoe6YqGVicr99KFIJ9H06+T6gIlANC7ZgSxLDXEEe2vpE9iuVYbtC3XZ6qJRYOYDwoevqWYPTqZI3glVGTnnvrAXJH9VFot9SIOzaUGzwa8/jofAqq0dHIpomsIKHp0uYGe0HUpPOjKi8ia3rF5uIpkA8UYAcqWvWUOSHt1OOTizeNOI0L8TwLRku409/P7evMnYScTOtkS4U8L5oYV+lWoqP9zjcq1glQt3+JrB0P90r4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD5Hpd34FY0P6X3616LP/stAfsDzC4bSY35mFFzifCE=;
 b=KavieeZWQjkledWTDYHDjys7Vh+G9PJe6F+CLnuhY8zmEh0g+OktfyQhiaxtrWkoeUxW7rYOenb01ovM2VTKeQ5oh6okXINH/NA0nSrDX24Zsdzm44Q9VZW+57g9iNLnTfmOnHn0xAkvyzAo82SZkCNtZoV44iD72L5ctJ4smbI=
Received: from SJ0PR13CA0200.namprd13.prod.outlook.com (2603:10b6:a03:2c3::25)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:52:31 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::61) by SJ0PR13CA0200.outlook.office365.com
 (2603:10b6:a03:2c3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 01:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 01:52:28 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 19:52:26 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v6 0/2] virtio-gpu: fix error handling and improve consistency
Date: Tue, 13 Jan 2026 09:52:01 +0800
Message-ID: <20260113015203.3643608-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2ed0a9-9a27-4df1-0ced-08de524668ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1BQB0am2OGytxhXGpZJY32Tocr56d96X/A1eEQ/WLUQlK0eK9NPyGbLp1nao?=
 =?us-ascii?Q?wtY7qACQhZu/fPXulZSgc0y+08XjPVj4W4YEP5SrF5DH5hKJg2Pw2Wsyn9Dp?=
 =?us-ascii?Q?CNo48g+ls5cSk2Htlx526ERByKc6pDoZm/YymEzA+bn4MXx+q98Ak+fE6SCE?=
 =?us-ascii?Q?ojKq/4m3LMaF5y18TTUokCI4fMhdi31Bi6yAW2UAPt6nWJ32qgh4MSrnyxhS?=
 =?us-ascii?Q?En+sqQaAZG++LBHpkXUETbd7dWV/q7svOsXzYFhb35zNO4cHDjvY4WKPkJwK?=
 =?us-ascii?Q?59LIpOEtkJBklhbpW6wOUpZ/nHh3QT0qwian/1CpRBLeeEaSMnp2h7czYJ0a?=
 =?us-ascii?Q?UAvVu5v4Jc+dCq+ru/QcuXZKM0jx4bs6VJJAT/HXZtTe2pASdnbTu7Q4lZ3Z?=
 =?us-ascii?Q?fFhb4ehHcl1QkT+wq1gW4KYrfqBZ/ABymtrmT3CtBw2DutPmY9k7cRwG3s1Y?=
 =?us-ascii?Q?D3gI5CF4clSPprTYosQS94BrvuWpfWG2n+AYZg/aqXPDfmO9m6/6yYKf5S/C?=
 =?us-ascii?Q?ljMkf+xfB29G3TLQkMb5pBTTnsKufOJ+8r0PPIz2R9FC7XBU41A7D9SwoP/I?=
 =?us-ascii?Q?ZxDae8ybqfeISF6cQKgoKf7tgtS5UZ6xB8gdM8WxBEHQtAetgWAh0qxgf3lq?=
 =?us-ascii?Q?oQ4z619kLIrYogQN7pXHkwfDIk0slC0zgE0qft205+FwLemt+I+ZGZKuzacj?=
 =?us-ascii?Q?bZ3op0/Wo6d3m/c2qyHOpEIEWkgDtU7ebkaF9BuE9P/MMnoy1xvNBSnVr4X+?=
 =?us-ascii?Q?02q+jY15DqBpMqmo+w+6WOMr6W/tCDRjFT6zm3UrtMD/XrCBnBrKH+uDuHs3?=
 =?us-ascii?Q?oAEXbAEed25/AYCdRp6RDFG+Ls6wKd+y7A6rPezWs5G7ViUlM1BgrSqJAzaX?=
 =?us-ascii?Q?OCh5KTps9g9qDk52A1ZSA+fSwlkbTv70rUpllgqGQz2SWFYrS/L2Jv1g+fy7?=
 =?us-ascii?Q?xM5O53DU1EbAkF52lq0SOnZYfhQXqU3KUCn2SFHfWOpolbP8SZ8odJ6k0eB5?=
 =?us-ascii?Q?XoBoTb9hv9OsBP0GyuB/itjMkzr1uZrT7JzX79FX8gR9+/BHZxcp5ZgAsf7j?=
 =?us-ascii?Q?2Rt4sQ6i0GW70CamJNvBXuUOc0P8+OWHzl6+3NOdOM474NQ/w0CCbFsLGPqv?=
 =?us-ascii?Q?ThYuCUBojjLC1VVuLzslofKeGUJrBcwLwVT+XJrOWkNAFbdClkajm1+pZraq?=
 =?us-ascii?Q?cBID3cpVGnT8OH/I3LHpLbk/Rq9QHoBeR30b9m/+TdTVGs0IsmhM80XbAIAf?=
 =?us-ascii?Q?8VZYjD0EC0iBNb4OY6kl95CTP54t6AD4/IWGjJRa9wgbnnwqnMcPUpnDqui2?=
 =?us-ascii?Q?O6EvzoJWsVpM+5Lop2idn7y0PS0x7ebmXgvaOQ4f6IEVOdKqHHu1bk7E4gwo?=
 =?us-ascii?Q?N9y6KTBVs0nP1w2/HpEuHReaOeBDnUKpsR2xhBKG+h2qoUYhEUg86vD3AIIu?=
 =?us-ascii?Q?lSMpu5uVQZQKDra8snUWeVh5kUHYMHD9LV+5lFGFaa4oq+7FgA6TIoEICyxx?=
 =?us-ascii?Q?GXH/BZ2RNAeLWqiJ//BXYKVytcHjKpprVD7+I96+ve6YEYBsNDQzNKuwmw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:52:28.9267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2ed0a9-9a27-4df1-0ced-08de524668ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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


