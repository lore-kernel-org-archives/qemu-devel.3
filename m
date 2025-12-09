Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791A3D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSuBa-0004DR-Fo; Tue, 09 Dec 2025 04:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSuBY-0004BW-FE
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:39:08 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSuBV-0006YW-FK
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:39:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTBH1MoV2bF8puG/Ll2LACJMWVponU88WR3rSidmu5B8z2+9KSX8m+kh9Y3Nb8NtTJpoyPS9/5A0oFEjlmytZFh/X2h9AlVkjnucVi2kRl40qyAFj7X4+TwncO90nNTSGU9ukWv2QtENp7d6czaynAWypLuGxAblK9XbT93hVCL6tyUFK10iFEY9pnXatWHtF7Dgfm/ymJpidfe3q/XiiqnKu+gwUxa1hV0ZXNDb64QrxEYIoTEKiyPUROBHpXijeHSPSO5kx4afJYEK313J61A/2iYNXCwioHokfeXPBF4v082e0Gdib4Z8dPslrIjkW61AU+UgWDpuh8IFXFTRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjrC2Z1SVQsTtHagesFnDyrjX4BFUbH6wzfnIteDrHQ=;
 b=MoZxeocV7yMh/R10v3sMLsXPWaROfIEkyXhBnJM8bQ1KnwRQ67QSNuh6w1XHDqa95euhruXBiJ5+cA/RE3j1gpQIo2c2/EehM6PnbPQjXP+hxvvxIF9GmotBiy3vm8+9Fr5Fou+cM6GkkoIcKsIiHLmHXXdYWLXHZEgMnE6t5OrxxGk3yHqmxorS7E80JlX7UGK5Bwmyh8QW9ctw5INN/vg8V2wOpfj0OY1JZCzNnO7ml7K7VsCS3pTaOC1MxPI42Jr5OZjxiwKFv1E6CiHJ53MfwbRYVxQDKWmuf3t9WNnnlZ9jw2qxkjUEOy2yuqT/Mr7L66vmcynlasSGIi2v+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjrC2Z1SVQsTtHagesFnDyrjX4BFUbH6wzfnIteDrHQ=;
 b=uy6t/Ei2dXbc4xHeZMenMgFqHax45eAF01fR4nGk/31H70obgperBCx73Eu22J7d/ybmfI7vqDEqw7Q3PU5qWEEaOTfi3nBK8F1l8ePub9DQyLo+B4033nk/lXFhmXlDLKA9CgksTBJjAE4KqWr61nD8wffdkJn/6yNKbw4DW64=
Received: from PH8P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::7)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 9 Dec
 2025 09:38:58 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::d3) by PH8P221CA0022.outlook.office365.com
 (2603:10b6:510:2d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 09:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 09:38:58 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 03:38:56 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <FangSheng.Huang@amd.com>
Subject: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
Date: Tue, 9 Dec 2025 17:38:40 +0800
Message-ID: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 261b9426-7fc6-4274-7b5a-08de3706c741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gann1gDN+T5HahoDcWCuGz4bZe/0p2RPAHcxqssJDS2DXYNf+BxFKV6E9EQE?=
 =?us-ascii?Q?p89j9Vg2SKlbboH8yx/VElrnosoepbBQebPaffHb/RwoY0zJZp6Yjm+3KjA2?=
 =?us-ascii?Q?pnBKLooygE6UCHvuvyn2maXSAWi5j64LZ0IMcWBlHPAReoTxhROkIlPDF8Yd?=
 =?us-ascii?Q?E460A1BzRAfq3o2cUowvwMXQcZZA6qdeLiUsleU/H2Sm7xtlc5ydPSePF4Jq?=
 =?us-ascii?Q?0P+MeSSn0mbCxWcpC/3awgwE3v9Qcam5XuToPVWYCB8cKp7gQ7jWf/bXg9Ui?=
 =?us-ascii?Q?fl7u8kTlHmqls5jqV/lME8AZsCbi3YMGp2HhbNeCtPcDUYA3JspEWM3spUOW?=
 =?us-ascii?Q?DLdbiyEhG1P/y08RyxS4Yd/6BwpI6/QtuyPZYtzu3+9SrQoHOUENqf7f505L?=
 =?us-ascii?Q?xFIiF3TOyCyb2FHlrv+bfNhcgREZWJK+FHOBqyCzEwMGE02zyBaTUrukX2ZQ?=
 =?us-ascii?Q?4whWM9vWUmwOnJaOWJ5quGcVqOuIHiI8VkHDxc7L2qku7xw7BjrVXJNTfcMR?=
 =?us-ascii?Q?6IeCYtu941l0XJO+0NU5Y3HMphgt7Lc1yBtHt0mpFyEdNkq1rt0f+4BcBHYs?=
 =?us-ascii?Q?iQlNztmi9w+IyeV4qSdRApIJZtGYHrWnm13h1ZZcU5/KGZzO2Bq065T7lVxY?=
 =?us-ascii?Q?ZDf4Ukybe8t7Hz1DafIq1Ijot45qOWOoPQX22p5zOmX0PlQUq41jHPNFPdSb?=
 =?us-ascii?Q?r3gCEZaJKdjW3S1gXKcHK0idL1fcufN4+IHkSHIwSRTOorwXy7bawxcTf/MP?=
 =?us-ascii?Q?2tDKV9nkyGcxIINLkTtA3UbOr7wNk9AxU4baHi7jCSw9cpHsEYxXB05ti7Tb?=
 =?us-ascii?Q?LEo6mxX1J9GVy1APYwgmAoVATCJikQUl86l7IyIgUgwDcPIC7NGtsWhj2NKT?=
 =?us-ascii?Q?2nl0YBxf8ei4vycxPUrqEwlexeDUNrqUhMEuCnSBeET9tYvfabg9ntIjylxM?=
 =?us-ascii?Q?o8FrtsOwkBUYmrxkQ7vI5TOwu+4aQt5PrNYhmRvr/OxG9XWQXh5j0E5T04E1?=
 =?us-ascii?Q?xj9ShAGKimi2IcMSdX8zJAaYJc8N2hOYt9okWET9Nst88gt4PbB0MXet/7/M?=
 =?us-ascii?Q?pEgqvodkt2UMV6vZgX4c8LCSq9kPCmRlUFeFhii+OQzTaQdPL7RVDa4afYqZ?=
 =?us-ascii?Q?OsmuN3Yj1A2rZU15dsZfZw8DYK+MihMF7PxtNHpYt4NzeKSB19y72Yb1DaS3?=
 =?us-ascii?Q?bu9j3DUWTJCPBwHtb0QMEFhpn6D81uDScGl5Xgww9sPEO8e9wLq6Q+W/mAfC?=
 =?us-ascii?Q?AVkzhWWQ2qvZCmYaZnOQDWU9T24MguioumTLAVpq4NMEkWTeQ1igja/Nsi23?=
 =?us-ascii?Q?35c4l6OrsVWo6i4z9O6CH7+W3P6fZbepQ+VvkLG3GHIQ75UtLO5sFZODspQG?=
 =?us-ascii?Q?FdOoLqcHLGVjKCZ60QBt5M2RqQBlioXxubh2SNtGUSElC4eNhSYa1jf33bWq?=
 =?us-ascii?Q?Pz41E0hIjwOKwI5L1w1ts6Hw9pxYAa9k1gS0hLnSAl+ftMPKCDy0hvkcAu3w?=
 =?us-ascii?Q?GuX+yg3DGx4G06zQJe6YEa8AiIZfInB8yQfSI0LDLls1hDOci5gUB2vKyCKE?=
 =?us-ascii?Q?Nqc/D3GSHijmFjckk92hkUebfCdcLzLZbovuB8/A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:38:58.4827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 261b9426-7fc6-4274-7b5a-08de3706c741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

Hi all,

This is v4 of the SPM (Specific Purpose Memory) patch. Thank you Jonathan
for the detailed review.

Changes in v4 (addressing Jonathan's feedback):
- Added architecture check: spm=on now reports error on non-x86 machines
- Simplified return logic in e820_update_entry_type() (return true/false directly)
- Changed 4GB boundary spanning from warn_report to error_report + exit
- Updated QAPI documentation to be architecture-agnostic (removed E820 reference)
- Removed unnecessary comments

Use case:
This feature allows passing EFI_MEMORY_SP (Specific Purpose Memory) from
host to guest VM, useful for memory reserved for specific PCI devices
(e.g., GPU memory via VFIO-PCI). The SPM memory appears as soft reserved
to the guest and is managed by device drivers rather than the OS memory
allocator.

Example usage:
  -object memory-backend-ram,size=8G,id=m0
  -object memory-backend-file,size=8G,id=m1,mem-path=/dev/dax0.0
  -numa node,nodeid=0,memdev=m0
  -numa node,nodeid=1,memdev=m1,spm=on

Please review. Thanks!

Best regards,
Jerry Huang

-- 
2.34.1


