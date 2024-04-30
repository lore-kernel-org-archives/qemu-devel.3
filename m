Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B47C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 05:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1fw9-0002hv-74; Tue, 30 Apr 2024 01:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1fw6-0002hl-3j
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:21:50 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com
 ([40.107.223.66] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1fw4-0007S8-AF
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcke11SzvRoCLLaN8EscTHghdS1uIPsUIoChJJC/zU6mDzaMG6L2UTyKIz5IzPblLyEBWOQCbA5VHYNJqHu1PWIYSSrk0zVoUylnlWAKJycCAqfd+HDUL3ZAMJuWEmbspaBEbpcUGKIJsRdAVOcMEIh3j1JKqqyPIb59eOMkl5pzFH+DKYa1hyXlgu7/9UaeOs6wZ68qenr6qn0A/diKx5QHnKkl00z9ws5/JBn63vIFDPryh4HuQX6W+INUUeVaNt1GZZwn1lv+bAOloNZNCF2pnzENmHZK98JQZ6TE1rI5waHm/kHQNv23LjqzHhiW6bmQqjkROCxLfbf4i3+xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CLNjBwRg4raPBSPnNa+NL369Ykx1Hb7yZgGb2jc2uI=;
 b=Kxb/Zkk2ylBaxKyAV9G4W8aeNZa9fCg64gk9pJXe+4FD5N2JGcfsB3XbJRqschcYRcW70TBB777OtJZozNCJTExaSnsw/akMWCa2RG5xp/FhiMDQPPMzC3g6qFlON4u0VPjG6evMtXMmBSihMwxH0VKJtAYSLmNNyHsnxSeMKoSPdxiUHWMNKHIiCEXMgajqlht27Zhsrz2l71597x8wQyTrWQjocYW4er8vQ2W6GJ/C0knSD3xGj1sEltW8YzGDfDsuG6UUmP66HLGMTAi3n4lviZbqgAgRhPjLFvn4ATlQK/LvMqdFIBs/fX4GRdqK48mQUdmwTjQzi3kjF9Pa3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CLNjBwRg4raPBSPnNa+NL369Ykx1Hb7yZgGb2jc2uI=;
 b=YrxuvQUKYY/FBHtJdH7ApD6r0H/fMBA3vCzVKKmhhqC9YbhYDymxKhLxLspQxrBjPx4FDhMaMKDpKVL3Utu+7KZCQcxZ7ZeEjq0wCKxHAz9t8TvOCj2csuyvzDDieKPHwqpE69Nr4HDPOF6bcNFxWfB1FDkQE9xm8LC2SUvcAc7Q3xJPTTsYMqyGqfBy4w61PwKvfOZQ/LHWWutAggXPhO4pA6Hxmbr4HSCsofRglLlAqeR+tBBB4MkLwozoQWB3qcWFNUGgtPyYem4af2ZLLetpDy9wY+vISaCwE6SBdQU/+vw0nMuE53NXL2NYfsdIwCyV3fkhqcFe7DGMKr4KAg==
Received: from BYAPR08CA0063.namprd08.prod.outlook.com (2603:10b6:a03:117::40)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 05:16:40 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::8a) by BYAPR08CA0063.outlook.office365.com
 (2603:10b6:a03:117::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 05:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 05:16:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:24 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Apr
 2024 22:16:21 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 0/3] qapi/vfio: Add VFIO device migration state change QAPI
 event
Date: Tue, 30 Apr 2024 08:16:18 +0300
Message-ID: <20240430051621.19597-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: fa729d64-3e4a-48d7-28ca-08dc68d4b751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AO6s46qI4ZmtzlZbDG6oLcUtFtRYP6S2uSCib/VcWIG+NX2vfzXrTyYRvUR/?=
 =?us-ascii?Q?bncHG/uchkLsmRTWNjPB2hcJJgAbubW0TSARN7oG8dlr+3WHOd1Cdiq++eNH?=
 =?us-ascii?Q?kDKAAXnSbQqHEyIG9/lr5Vo8ememfgtR4dYx5b76N59RUds58ySxUQaZ+jiS?=
 =?us-ascii?Q?OQkaeLM8fjqrLMvRoxQRElKy2KccERXD1c0SuFfJY45uGrZJ062XfTicJRdC?=
 =?us-ascii?Q?Vx9OGNHkrzQzU5Nl1wBCk6i8KiqO+EqfmZFRyc9vh4faoEQ0ZvmKQkzdhD5j?=
 =?us-ascii?Q?XtMXV8TURLG0TpETD7QzcXcBTCrke3YvsHCpxpddElYXb+F2BP93xGrRhtc7?=
 =?us-ascii?Q?iYO8txTfQScJLfNKiY0v79ZsOpmktBSQLXGMUOIfrq4EpdM7aI8ZqIEErUao?=
 =?us-ascii?Q?OQuJCBwBq7u0PMaz4LTXLaqFRjc6Q9Gj7+bo////0DVdK2otA0UzfTDNYDus?=
 =?us-ascii?Q?OcrGKK74AJcanIzSyYyu1k7NU5Prl6ay0Mkrp1wrbYDnL6/9z7j4DTl6D8+i?=
 =?us-ascii?Q?gPo/Sttjdi+8dEeAtHhD/WvVGUShdqUmQ12flZrJAtO4gStqFhLdx8HIsR6A?=
 =?us-ascii?Q?ccvjGLs1Z3DftV81m47bfa+uCx0CnrzfQM7XxTH75KE4ZNpDAnLOu3ks4kZV?=
 =?us-ascii?Q?69vEffPVCV/5zLC2rPXswp79BhG5etODfljti/Ifjik8yFnjM8C3jzGyUYwX?=
 =?us-ascii?Q?pIi2p/80nB4x1ULczOqW+ubJhkOrdZAmlSPXEznV8CpPOk37wzsSWGxSMWkd?=
 =?us-ascii?Q?NCypHTQlm5RzkCzCjKIRYuDnVRiO4xP+So94yGqJu4iWdYDS7ZVI0ac5uEnN?=
 =?us-ascii?Q?EP6Vm1ccIqj02hLvBTTyTraf6uR13avAIV+/8TU86FPNZ5pW32F8z6FlqmyE?=
 =?us-ascii?Q?OLI3edPy4luMsulB4WC3fBv90+z0CZsciuOCgMeMzmUT324PAGzlQMzOZ+Xx?=
 =?us-ascii?Q?GgNFIn7yFNVgYIVpiWjFyp3RUb96/XknqJbjQwPPBXjrAq6HU5zbkUOPwkzD?=
 =?us-ascii?Q?5KB56rLI522JkYbHzDHX2u/2CLk0o2Ci0e3UlVG58RmN4870DvVK519sSung?=
 =?us-ascii?Q?90YSI1n8/Zwv0pQxz0JJ6ZH41RGSs3hMDwOsfH+VlY/MFg6Lco+K4m3HGIH9?=
 =?us-ascii?Q?z9m/RJ6v8ZA1Amck6BqQHPcMqQKdfDZknax+eGiYBJDaK+e62NJUEgHiihCR?=
 =?us-ascii?Q?jaWaWcFYmgHggVwpHOX6EY+ZDqqfNoiFqFZN6xjhcrbW/1WgP5pCpNHU18rV?=
 =?us-ascii?Q?Z1Ic3OyMfeI1Z4QDvGOFXJPzfip/Mk1N7noBi6OPjG3K+oaNHOMyzAPaSixt?=
 =?us-ascii?Q?NrOyHPA+REC7r1wCBQFSjPFNXe4M8+g1juXOzyx3unxuI/dRvVLoBWHxFmPk?=
 =?us-ascii?Q?NTAeWEk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 05:16:39.6735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa729d64-3e4a-48d7-28ca-08dc68d4b751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
Received-SPF: softfail client-ip=40.107.223.66;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hello,

This series adds a new QAPI event for VFIO device migration state 
change. This event will be emitted when a VFIO device changes its
state, for example, during migration or when stopping/starting the
guest.

This event can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

A new per VFIO device capability, "migration-events", is added so events
can be enabled only for the required devices. It is disabled by default.

Feedback/comments are appreciated,

Thanks.

Avihai Horon (3):
  qapi/vfio: Add VFIO device migration state change QAPI event
  vfio/migration: Emit VFIO device migration state change QAPI event
  vfio/migration: Don't emit STOP_COPY state change event twice

 MAINTAINERS                   |  1 +
 qapi/qapi-schema.json         |  1 +
 qapi/vfio.json                | 61 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 55 ++++++++++++++++++++++++++++---
 hw/vfio/pci.c                 |  2 ++
 qapi/meson.build              |  1 +
 7 files changed, 118 insertions(+), 4 deletions(-)
 create mode 100644 qapi/vfio.json

-- 
2.26.3


