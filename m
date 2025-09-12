Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB929CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3ln-0006Lr-Th; Fri, 12 Sep 2025 09:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lingshan.Zhu@amd.com>)
 id 1uwx5a-0007w7-Rf
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 02:17:01 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com
 ([40.107.92.70] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lingshan.Zhu@amd.com>)
 id 1uwx5Y-0006JM-Pz
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 02:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsmVRFT7/++C897IHO438LBjkBHsLLVtWPW8nKkyrsGvEWwV95xkgoBdRdmnvFymKTEkl94IESk9jyek4savZaxxR8YyGn77b6Fj/11vcm1OS9Glb/wlO7b7kuiu3Wcl0TEu1v/XGK2/dazpFgCXSA03le2WVrcTL07+Or++KkVvrrqdIUPD0UbqEP7GSuIhVHSnSk3xhyKD+KfQv/u04de0mNbfWLvWZZXqJesTQ7MInoKt4pADyL54ZZJ7XitObbM5dGdcecHsEYwt0ncOcOEwbHl//WVJH2VulEM4ff6DM1sDMe/h45iWZCuFb9/8FlsOAGLk3hwSt8Y6w9mUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6auPqG5hPxwFsrp7yZSOW+0r/UOmX244ZQIdt7Kfp8=;
 b=ZYgQEhiXEeEN8HtDA6JptTahasXHZF3HMGZuQuS5gi9HCnhF1q0om3r8W62Yg8Bbm3/SDJiLnZ1D0dQQX4fviU2gAOCEkfZaz/OqyI4quD6k+FBe+E/4W+68qCI1ysuTlUmnY/a9ZqD/i58zl1C8uzevBlmH+3vVOsqOdr1lCFWOZ9szz2v+m90NEc4ssh3baXvvnk5Jy6AisoVvGOXZuMfUL3/TN/RWz+s3xrQRS2RuU3n1LlewuofpkE2BZTGYnM4DbObAOv6dSfcqXc5w0bbcZ0XzMVDYn7gxcLNf0OcC1v/FwuDQO8raa47Hq5z/PYW+YGCEi/sqigO7KT8WLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6auPqG5hPxwFsrp7yZSOW+0r/UOmX244ZQIdt7Kfp8=;
 b=SdCkCtUeJYmmUNNnYQLN68w/rvRAr3oMsvY4xZpTFgNHg/UJYCtO0RtMC4b3ljDK21HQyzUKF53JLBX8j2J5ayZKZt/SOmfdr/VUi9IBhdcnDqX2oUA5jvdSZmE++nLugTJnbiAKeyqTOEahYF5BZVaUqgoWjnFpVm1PtXMh9rc=
Received: from SA0PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:d3::12)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 06:11:44 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::48) by SA0PR11CA0007.outlook.office365.com
 (2603:10b6:806:d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 06:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 06:11:44 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 23:11:42 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [RFC 0/2] virtio: implement suspend and resume feature
Date: Fri, 12 Sep 2025 14:11:23 +0800
Message-ID: <20250912061125.262457-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a280d0b-f462-4b82-5d86-08ddf1c33f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0/vqGjt/xDEEAMX8LydPE9RRlQ94rf5S0tpqfi6tE+xPWKlZR8T9SBPZWp5k?=
 =?us-ascii?Q?bZ+t56amCXXtiJ9f0q3H2q1OrcmYvd3emQlnwiXGKP6qcy9mnKxqU1yNVv78?=
 =?us-ascii?Q?NfAVy8oCwWV0e5dKxpGnORfRxofKMBjDrrunUqWOze2nRttVLMFe8rmRIgh6?=
 =?us-ascii?Q?aFXZghC3wK+KTVZrHCLVaBYT6411JC93RhsIcFM99s3qQhn0yYyzcwr+joCH?=
 =?us-ascii?Q?GPLDwop1hmCe1g3W6sSW53xCDip32/G6O8YCi7NYVTTHkbXyd8tobWpmwx2X?=
 =?us-ascii?Q?rF9riK1k1duziQkAlS63vSyxQbyEToydEqSR9DvZ/UncAyhIsvArJJ/q6OTg?=
 =?us-ascii?Q?6Ve8NnB+hut9FGX+dvdxrEMJk9fMy8/+ftwaNnhULQBdZd3y7MESprzN1BeJ?=
 =?us-ascii?Q?Yk0suzTYkLNQVNY9kK+tE8mMuyyg2PMZzDbEaqpjOFngQK2ZYzIzGC/86z+V?=
 =?us-ascii?Q?R2xa2gRMOTouIhzcb2lptAzWMWca9pNol35tQztxM0GpZ/5s+3zYs23wSbxt?=
 =?us-ascii?Q?y/zw5eha+5DFuOVRa2KIhBP+J/KWsdOOMPfye2Our15fdr9Xt5FH/Q+arF4T?=
 =?us-ascii?Q?zL+GMsGdehS6qdzXbO9RrgZM4425atJDFxe9DoB8cKTe4+SWgY44R6acOcWZ?=
 =?us-ascii?Q?tpXBsZK9zClb4O2LW+PsgBbxBlYB9eKIdPE7HknS6Jpz2JuHgC40cH8bDMJp?=
 =?us-ascii?Q?d3Oi8gVM29vCF08ASuA5sEzUbZcYVgvw0y8kBVlVXPfwBX5u1eGwz2zp3ZY6?=
 =?us-ascii?Q?kwQG5plgzHqfzkcycdLz8Anu4DhDJmiFrNXtiafAQRNkI3IG71jeJ/iE8DFL?=
 =?us-ascii?Q?Ddu1GPcxEKm4h7VQ18yV2DldwbJYdhvfqLzPlefCxuHcZ4/bCOSiYIgmtn5L?=
 =?us-ascii?Q?J0cX3U7bhnmGwc42yum2VqfMUlBsELhuSjk148xuBb2ysYxw7xaK4rl6qasl?=
 =?us-ascii?Q?QcEePIEgGTtJCtJ+kGiH2KuqLWeypqPR1R9sEWRCl0pjvNjZe/eQatBpuOFY?=
 =?us-ascii?Q?eIXPJmvXOr//BxuQEZB8+6cdzWlg9LcNfnHLVbkn3E40c9E3bmBD6TAGlgBc?=
 =?us-ascii?Q?Ani7XzaBC1SP3kdAWYuoxBtfAcUvzj6oH9VRkBTQ/Li/0qQMZdUSs5zsiuzZ?=
 =?us-ascii?Q?GRqj8REYJvgsvQh2AH9+DZIgNXuWRLB1Imf/sXU7Hf9v57NbnBRQUnserzoH?=
 =?us-ascii?Q?wEwxZ7hsdV5N0gV/ylkTzygSx1gVfJ9g1Zk90nxdg9o+XHCdGj9X0JaAGyUr?=
 =?us-ascii?Q?XANhB4VbrIyiEPWOsO6WFrzccXrldx1XJcsr9E2aLcMcYJHiGZjU+KJDpBLq?=
 =?us-ascii?Q?tW0E9Li3Dyvn66VBXiVp2KiaTZ2gosqiMWJQezLwDmuu16frW3MZVH3Xi4Kd?=
 =?us-ascii?Q?9n+s1qvI1Qm6aJL9MJLnaOUfxSIgNDDXlwc7GwE/gQhaE1ortvUiFwRRjmfy?=
 =?us-ascii?Q?TqB52jyij8a8kCoQVsqdsezuqZu5VgClVS7WW2h7V25Q6PtUE3GGXyWq1Nwy?=
 =?us-ascii?Q?A+eAfyomUrVCM0M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 06:11:44.0915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a280d0b-f462-4b82-5d86-08ddf1c33f6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
Received-SPF: permerror client-ip=40.107.92.70;
 envelope-from=Lingshan.Zhu@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Sep 2025 09:24:40 -0400
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

According to the spec changes[1,2], this RFC series implements
suspend and resume facility for virtio, and a reference design
on virtio-net.

This suspend and resume feature will be supported on more
device types after the basic facilities settling down.

Plese help review, Thanks!!!


[1] https://lore.kernel.org/virtio-comment/20250704101739.354522-1-lingshan.zhu@amd.com
[2] https://github.com/oasis-tcs/virtio-spec/issues/229

Zhu Lingshan (2):
  virtio: implement virtio data-plane suspend and resume facility
  virtio: implement virtio control-plane suspend and resume facility

 hw/net/virtio-net.c                           | 115 ++++++++++++++++++
 hw/virtio/virtio-pci.c                        |   5 +
 hw/virtio/virtio.c                            |  24 ++++
 include/hw/virtio/virtio.h                    |   1 +
 .../standard-headers/linux/virtio_config.h    |   6 +
 5 files changed, 151 insertions(+)

-- 
2.51.0


