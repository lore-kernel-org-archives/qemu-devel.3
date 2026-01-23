Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74D6D6CFB0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 02:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj79M-0000V3-Ie; Thu, 22 Jan 2026 21:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vj79B-0000NY-HC
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 21:43:42 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vj799-0006kJ-87
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 21:43:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpIDY/CrBILXY6qhHcRAOGzBEltpew89rTBLw4jKew0wvSLVLe+uJ9M3H8Z8cnF6Dcrtqx8B9npL/3caUqfR8tjza1uTGH878Ht02c4J6SRNyvz9Qt1oq3TTwy2vskStqJFnmWSYmHFY1CuFeVhnghsL0qRPuaojWbipaHmbTLE1w5gh6b+RhJa4JfTtMLgmO5SemaMwADpWg0mUNef497g0THV/vSxgoVAgGnsQvlwSReB92z4L/ApjpL4N+SYVRn6ahNtzHzzY24wZHnr/XgxQggpb+8/t0KN5Va9W/XU4vQyZk0NXPgqlca+jZ9AzYrVKh5PcD7cujhhjQtrUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbqDUsjhyMCtsiQ6eQSUu1cCHfEGjv3cTUXnaKBrZl4=;
 b=lrnQI6ibstUNLm8e8zRKEmxFR4p9XkCBw16xNH5ZwxbOTMipKOzq06YIO54vTQINtub5xFEsty98OqZRO/80ProokKHtQe7wxCdQX0ZpkQaavJevnOHLMvSu2d3SumKYlPCP9XvKjC4Im/cc/sZNN0eElKlGtTxvCuH98mGKFqt71xt595WGBTzOSeoXQSyft0hzqov6HCfky9pQzx5ugf254t06bYkAK/l2w2qZVKtLofIinxc14jZX9WK4ZvviDJjfXhgDfE1eeZPbukBho47/QtC0Z9lf9L7rOl6dz+vYmpQKwlfzxLiV30s1kpkCfOylqgRUslqYMHN4CdNamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbqDUsjhyMCtsiQ6eQSUu1cCHfEGjv3cTUXnaKBrZl4=;
 b=YJ+nV3GHPj++9M6lAqU6k+jEjc8r4Jlq68pyCLkGBpYgNHsYEwtBlBRlpmh0LU12nfm/TJMMnkYnDRFgjzGl4Bec5RzymUM6dWJgd6m0DehapJZFic5U9JyWjVexj2PtwXfrnwc4pd16N0qBCNgAV2GEZTBoPsqcJ3JZ2Ub0ixg=
Received: from BYAPR02CA0007.namprd02.prod.outlook.com (2603:10b6:a02:ee::20)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 02:43:31 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::c3) by BYAPR02CA0007.outlook.office365.com
 (2603:10b6:a02:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 02:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 02:43:30 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 20:43:27 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <jonathan.cameron@huawei.com>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v5 0/1] numa: add 'memmap-type' option for memory type
 configuration
Date: Fri, 23 Jan 2026 10:43:11 +0800
Message-ID: <20260123024312.1601732-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d45c017-567a-456d-8250-08de5a293198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YsWo1q0e9MKiM+NG1MX4Ex79tWfySC8Dbg6a2SrXlEKjkprS58CS1ZzXe6qa?=
 =?us-ascii?Q?grYtJ5IGD7SGz0Y62p1hrxf6Ys5WL1ftctjlnOpt1Ntpd2z5UmQaGXuMVTLy?=
 =?us-ascii?Q?+I8aVpRrawe6fPcI5gQTZaotGeNFVw9k4y+lhrN9LwGFPqggkMR/4IOAXX+W?=
 =?us-ascii?Q?AT2Tx/nrm3tBLnpOkDEqkNaJ5qhgflcxo8wA6vy01lydyyKaknIGZ+KVscp7?=
 =?us-ascii?Q?jmyIFep1H1YXVIcrSI8Ivz7j7jUFPeVv0UGCvoPv/U2u7bkPEmiKTV+XevjD?=
 =?us-ascii?Q?/v1mJR401pWtPbhRvx0INmPV8SORQyVJfAeUCqcNqhWtDxCtAcS/C88h25nx?=
 =?us-ascii?Q?eHrMfbhuco8HHt+4BdbZhVXqlEPS79FbHQlqsM3hArdxsqvZ96DW/wtxewpo?=
 =?us-ascii?Q?Gx5pFEQRRENX+8xTZ9RcTmnGBj3PmCcyWfwx/9mIBs41N9JCwK6QAc6wm7XP?=
 =?us-ascii?Q?Nq24p/4kTcuI0Rof1j/0UHFQlkq+/0mhbBi2QxakOZksWpZ0zXIVfNpjuHW1?=
 =?us-ascii?Q?oQ1lEDwy3J2EUSuzXlfgW30HK0YVllu3x8V1wmzjSfFFADo2E7uisbSRvjgc?=
 =?us-ascii?Q?z1Jqpru00YxS+AkqqbWAHt0SeMX9okBTbDaOqgaaMvrDaXIGvQEHEScxLe18?=
 =?us-ascii?Q?9RlxhQx2PX+Xv+P/DZTfwFJH4WORt6l8zzm1c7ZgvfWgKqIPhTgdlioo/FvP?=
 =?us-ascii?Q?ENZgSi/cMk/cLALQwBjsvlQoW6mO6kS4cxKgfu93fbQsQ6nVFGdsTY8VPUOK?=
 =?us-ascii?Q?eeBCq/Cd1/n13cPJQfLpjipsahwVp3/mNTRy0jWh2FA2ZuZdwEj4OSVSRV5e?=
 =?us-ascii?Q?QSl4+qfPFelBX3H24MatMR0lSEhUHBYm2t6526Gyrp3R8vQLXNpnBIBy7kbw?=
 =?us-ascii?Q?H+6vEyk1lNk2qEO8TjIvKZKBMNpF2jkq4ZgNdEJUA6eutjQwBAQX9XuuWxVa?=
 =?us-ascii?Q?zPQpNTTVFdFGDn4txUlra03FKY6ZYSuOYIOgpJbC4VUFTKJBP9KmRuHOGklp?=
 =?us-ascii?Q?W/h+5dBeypNVu1JqNMAuZ7EAvyl280t+L/W56CJC3Zk2Hhz8ZUjVwSbE3bVP?=
 =?us-ascii?Q?NvKLpvCVHFKaKnzfPnA3iSWfa77uzUUB7MwqBc4WniLSIfbk4nfbcU4Ry/Sz?=
 =?us-ascii?Q?iafy0vK+GetYkZS0mr6EQRk7A01SIanz20HVFaw4wQkz9BF5yG2XHVzy9mAF?=
 =?us-ascii?Q?LBsoVqAQ0WDJdZ/cJGP7RGT/U+rVCn0jfq1itj+jRs48EAFgjsgL0x1WJFPt?=
 =?us-ascii?Q?D3UGvv+YcdpOAa2KqTBKQy7hCDXxxyxHmuNAkzWw99/sGzoJiZz/mHZVzxoh?=
 =?us-ascii?Q?jnroVL7Ks5zqZk+5B2IErS/cy17dkgGLbJmH03pQWKIRQUTGyjxyDAQQLgM5?=
 =?us-ascii?Q?uO9itrRFVpH98NLK54T7FG8ai9dh7c+AFyR+gj1KfDCJl+uNFTN7yccs3amH?=
 =?us-ascii?Q?mW5Mcgy3RgchimPWI98krV7fqIUsRGFoF3ZqHn39P4e2EI03+ovHDixjBxGC?=
 =?us-ascii?Q?i+gkPslm+Yq+WM4kcDu93NHIdKD7dJjDA4O5wPQpeOnp5gC0ECQdhD8W5cFa?=
 =?us-ascii?Q?YRKnVZQ5+a+F7veiPlFjDNElJ9ssoWdm+2bhjRG0L5fQkmXKl+Nreu/AkPEE?=
 =?us-ascii?Q?9o5rx79VzZL1Yo/N1tIXqNe3cB97IShLuQHF5DWJSZd+OQHbQukCV5ACvrv8?=
 =?us-ascii?Q?CE/GYntMUZNe/cuSm16OiWrc5Tc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:43:30.4590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d45c017-567a-456d-8250-08de5a293198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
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

Hi all,

This is v5 of the SPM (Specific Purpose Memory) patch. Thank you for
the feedback on v4.

Changes in v5:
- Renamed 'spm=on|off' to 'memmap-type=normal|spm|reserved' enum
  (per Gregory's suggestion for better extensibility)
- Updated QAPI schema with new NumaMemmapType enum
- Updated documentation to describe SPM as a policy hint
  (per Jonathan's feedback)

Use case:
This feature allows marking NUMA node memory as Specific Purpose Memory
(SPM) or reserved in the E820 table. SPM serves as a hint to the guest
that this memory might be managed by device drivers based on guest policy

Example usage:
  -object memory-backend-ram,size=8G,id=m0
  -object memory-backend-memfd,size=8G,id=m1
  -numa node,nodeid=0,memdev=m0
  -numa node,nodeid=1,memdev=m1,memmap-type=spm

Supported memmap-type values:
  - normal:   Regular system RAM (E820 type 1, default)
  - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF), a hint
              that this memory might be managed by device drivers
  - reserved: Reserved memory (E820 type 2), not usable as RAM

Please review. Thanks!

Best regards,
Jerry Huang

-- 
2.34.1



