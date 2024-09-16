Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B12C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqCqK-0004Og-CD; Mon, 16 Sep 2024 10:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqCqI-0004Ib-Q3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:36:43 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com
 ([40.107.244.73] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqCqG-0000Zh-VY
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNqcM+4db9OgjBsJzEIMrBZ3K6pAM+sr7nN0rBrJam7vDQsF/LO1ps7/t2Uvq57gtmvfdF+DEy9KD5XQZqZ3Lr45eaaJuN27uJhNzxXj8n4h9CzDP6zK51kZY2H+PtSoOn4o6HWpZlNCHLtJ7DgG8SxSk6Tx1ReO1bClqNHaRXMboKwxKE/6BilNgoZ2o6do5r8p0E6IhE4TyVdoheQfgoeGjThzpeZ0jYlEQkKThnBuuoImNnPV2Hfo3Oprp5qWjQbjw7WwVcYnGJxPG96hvH8YvH4xnVKtaAEUxWSAl/lwKzGtTTVSowJmbQbx4ZpJc00sD2z9v1lxtjiwA31jBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h9LSyL+BykPRIEYi6y6r4x/lmN6YxTUV/FAus22FYk=;
 b=VrTpvY8QjhNdflXfSK6KMzIfZ27n1rWX/FPzX82VToN5P2irhbRm31S4/pVgR7gleY4S3uibXnSPpoOxtF0kBpIwZBvxqJZJq+cnh0ZI8lRG2w3uPjiMxTRdwiTiuZ6AmwhBLtGV2eBoooG/EQvVEhNfU0nM4B/1QU7PWHuv+WLZY7OrkiHIcbW5eQhS193IvTNnH9ctpYcF7K0LgeAsmQizPBdBcZNL4AcY4EeIz03KJikxGPxxxapHeOzdOhbElXDp6IUbppQwBAChowmBR5l+coPeXAghdVOSBEOzoV1lXBpjWnEIOqgp6+xuyfLyKblcofw9BSqIadFVm3mARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h9LSyL+BykPRIEYi6y6r4x/lmN6YxTUV/FAus22FYk=;
 b=DAAx6+MuTrlCBzuPfD50fNDdq1taZbBUyeoEpyZIwneSd6L6TAhFuHSpgyzmxCe8dzcyohQiIMKtjw2+98LpjsuvI6dbot79SuC8AcZKAa6O9u0fHTLdrIrqo5ZZB0H7p75Y3b4IsXKnuT3AjZNdYgnBiXv0UDrVflkDK1y4jnc=
Received: from SJ0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:a03:331::8)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 14:31:30 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::b8) by SJ0PR03CA0063.outlook.office365.com
 (2603:10b6:a03:331::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 14:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:31:30 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:31:28 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 0/5] Interrupt Remap support for emulated amd viommu
Date: Mon, 16 Sep 2024 09:31:11 -0500
Message-ID: <20240916143116.169693-1-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 741337ce-3491-49f6-826b-08dcd65c4180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KldR+I2UHuwjC6WP68DBeBjq1isv6rS7HXXustt/MVrn+zu4fv3+glz34NbG?=
 =?us-ascii?Q?s3i8hNNchAmCmoxYO2qvrfPHz47t70+BhkU5R3PKOBpaXVgXJ02JNscu7nDf?=
 =?us-ascii?Q?DZudGl5fiGXUM7PzNNeWRgARf9zeSSZaheb8ZJANOywwDT3zLouiYVQUhTiI?=
 =?us-ascii?Q?ndcZdGXKIc00MPhBsRH9reV6BWMpGt4Y/Du+HnY64loFUn87A59+MdXovizT?=
 =?us-ascii?Q?mNhwTD7skhH9kybMCkTAjyVWUFUekQYUpFQIajuWCpaO8JcOnU7z8KR+40g5?=
 =?us-ascii?Q?lCtsNXLt+vY6RJQ7mABnIZsHTmd9jxWUYEoZtWdnJLXngnUv+t2HrS5FWD8a?=
 =?us-ascii?Q?JeiziIKfoSaBMrzgB8D79ezv8rLS2BKHRF/AR89E/mLwvbCLzTWil7frhQzQ?=
 =?us-ascii?Q?iSL+pPUuS8yQUbWHlUNtvB2M6Iye6U7CkhfwDjWJp6W1Y8LVGr/Z6KSReAlQ?=
 =?us-ascii?Q?JoluOtlXiCzGdgfqQQHlFqDpCCdASsdIqtwIenouJXI+MSABF7sbmIGNSWMX?=
 =?us-ascii?Q?346tq5/iK5DdTwk9JUJKOtWGKk8c4xMNInpGv5KU+oL5p6RIfDMAXCjrnIu7?=
 =?us-ascii?Q?MFAHqjDd7HvCbRyR8pK3T6NdIdi+8W3vWkoHarDMnwdVMHlMIpBjUnyJNRTW?=
 =?us-ascii?Q?c2EZvuMkEksNyq2eZrP5jy3roV1nzZQjRXVJXj1t8NNa38j+S0tjNxG7egMm?=
 =?us-ascii?Q?6eUtF34jVp4rcsIH0a90bu7y9io20hJK338OiN7V6vcdedScK+n5Og90Xrx6?=
 =?us-ascii?Q?ZTOBvQ3diaHbzryPyZWbOvoHq+l8juJVurkt5aUiX3x4u06d9t5Cgo+9whVy?=
 =?us-ascii?Q?lmmvRzmwPbO8i3S+WWv16oqeRO1v4R/18V0SuGznTB05XXN4ZEB6KQ+62vMB?=
 =?us-ascii?Q?LOdgS/YkDmyDSLslHFjFrqzSyX8FW27ev/o+0UorlBc2loaoJD0IurHMwfYB?=
 =?us-ascii?Q?RSpFrL/iVrkpXg+8XGgph6//xDs7jcnBVbR+hv1n0ARoq482M3OEhxtT4LFe?=
 =?us-ascii?Q?EjkRMmPacGkbdpTP0lf8+d3F6c9VWitLAV99+CDojclhSQuZ8RZMKkxLkVam?=
 =?us-ascii?Q?rzmoBrXQeYvRINUT+9yMZ6dVKkXlZFE1eyQGpZLq0fAc7QjlZoqnOF7NErrL?=
 =?us-ascii?Q?0aMLSf1t3vzPcA4u+FhgR58TYQWtuOu/MphBEpKbbKlLP7CzzGbZgZiFVbRQ?=
 =?us-ascii?Q?ojw7W9D8TPydMOnWBGdrna3GX2I+8PB72C2/tLnqH+0F+noZyCm5RD0/0WQh?=
 =?us-ascii?Q?x+T44LFU12eZWxSEEfto0qrAyTeF78Ti44aMP862DlB64tUF1Is8SjCBwo7u?=
 =?us-ascii?Q?CXBMHiqYVRrUhVW6mHkvWzdZ3PeOmZ0TLSqb7595ZvY9+DGMK5I9j+80FPyG?=
 =?us-ascii?Q?Y+1Z5BV9VC1DnpcZ2iPcYW+a9yKciJb6mpSlbZlSDANKXcZ3iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:31:30.2637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741337ce-3491-49f6-826b-08dcd65c4180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
Received-SPF: permerror client-ip=40.107.244.73;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_PASS=-0.001,
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

Series adds following feature support for emulated amd vIOMMU
1) Pass Through(PT) mode
2) Interrupt Remapping(IR) mode

1) PT mode
Introducing the shared 'nodma' memory region that can be aliased
by all the devices in the PT mode. Shared memory with aliasing
approach will help run VM faster when lot of devices attached to
VM.

2) IR mode
Shared IR memory region with aliasing approach proposed for the
reason mentioned in 1). Also add support to invalidate Interrupt
remaping table(IRT).

Series based on ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a

Testing:
1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
enabled
2. Windows Server 2022 VM testing for > 255 vCPU.

Change History:

V2:
- Fixed non-kvm build issue (Reported by Michael Tsirkin)

V1:
- https://lore.kernel.org/all/20240904100257.184851-3-santosh.shukla@amd.com/T/


Suravee Suthikulpanit (5):
  amd_iommu: Rename variable mmio to mr_mmio
  amd_iommu: Add support for pass though mode
  amd_iommu: Use shared memory region for Interrupt Remapping
  amd_iommu: Send notification when invaldate interrupt entry cache
  amd_iommu: Check APIC ID > 255 for XTSup

 hw/i386/acpi-build.c |  4 +-
 hw/i386/amd_iommu.c  | 98 +++++++++++++++++++++++++++++++++++---------
 hw/i386/amd_iommu.h  |  5 ++-
 3 files changed, 85 insertions(+), 22 deletions(-)

-- 
2.43.5


