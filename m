Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CC4CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slmwA-0002eQ-9t; Wed, 04 Sep 2024 06:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmw7-0002UB-JU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:08:27 -0400
Received: from mail-mw2nam04on2049.outbound.protection.outlook.com
 ([40.107.101.49] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmw5-0007XV-4k
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:08:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbiQJFhqsIPXPqfijy61XyBerC0vl+aCmve2SrNucME6UbFlOLh0mSna8N6+b9gbCxd9ywsPqWoiIrCMngAI41qOu6abXqdJ7NlktpHesSuH7kDlvcCrzuYfd+xFg58TOSNKXnerEheLHPqhuf+LUgeJp3vO/zO1+Ut8Cw2Fkl2F9Zx5qhwv0hQ2yWx2QOM1StrVr/VK+zma4QhKdwSPDfbazy3o+wbJ+qLs3YZA6qQ9EyYtCv2pd7Ch8/HoWg86+D48aQBURiyLlp3j4198TV1ARO8kRRcieOfp+SC2uTnw35Fhc7wefVvDnr1rVLYd3ljcdluFHKlNBz9D5v8zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+hGcP1CRniLJ9P8LNsyNkeyUmpvAREilEiVT76jaRk=;
 b=y7RL8as+50A5tpTNZBEP70ge+GFem4knyM+/qko2yb7oYYjLVJ7nG9eDhX/wBBiDAk5/40I0EAcLPraV5eTJyRF9Vhdd7Atr+hNFJk069aAL2u5iaLvCx/Z5JA+SGLL+ba4TRjVJA7Re8uRpkc5bhI7qiaPvd1prKg8YM18/ad+DwtKvGIUBoH/USWCfha3vJNiNhvgqOo+INVQwvbH8Ok+VpoaCRv0n0M5JqyorBSeo2guHZjFtM5wklJVZm99e8e0ay0J/6TIHhBJIhlWrWlnKCX/lsL1Y5CtSg8TfJUNl1RSvTSUUXA1vmVxFWDvY9ucc0zqTeMR8/bmUsqG4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+hGcP1CRniLJ9P8LNsyNkeyUmpvAREilEiVT76jaRk=;
 b=5ZXFFLq4rVrSDXIaEHYSqOiXF08KhjboRg+9hHST9gh7oMtvW1a7UAdkiUdSJhmYECaR/CpaAL3CU8mdSMrMinsL8tirl52IU4RJBGFze/aPk8vVDIZbSEeDhkF4kuMS3a+xUudFvcccX0f5chU7q9DDkdB1Ik2+MvmOnDgxiw4=
Received: from SJ0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:33a::33)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 10:03:16 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::19) by SJ0PR03CA0028.outlook.office365.com
 (2603:10b6:a03:33a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 10:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 10:03:15 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 05:03:09 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH 0/5] Interrupt Remap support for emulated amd viommu
Date: Wed, 4 Sep 2024 05:02:52 -0500
Message-ID: <20240904100257.184851-1-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e76dfd1-e4c6-4bd3-677a-08dcccc8cb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AFIeLMowtkEp9foMYSjwjzlgprXjVOvgGONK2yacw+sFMr7ODjAfLIvDkdxP?=
 =?us-ascii?Q?BplLfR+PlCGnqKwewKdUUFUJjaIe1rvYctxY5FDSN8UzjGN+XJj6Y4zXatKB?=
 =?us-ascii?Q?vpcYRfFzs8ybbiGC4uHtHNfZ3ysnoLt5h/CcCi04mxFzzfjp5y2Kyv92Ml6j?=
 =?us-ascii?Q?ZGZjJuRtzcTieTEnYfeXt+183j9ZSswXqXZTmNQYIoZclJLlFmRwlyZkZFq/?=
 =?us-ascii?Q?+8NUHe5qyGIPnJh2tqajs9aueg+TvRzkjIvzdmolZdR+uHWkrJ+IytWG6Qy0?=
 =?us-ascii?Q?ttBkhfE1aF8fdyzTuKH/q0MVlg6b893dj65aJRotxvpqvyCqAHlZnEm7nMg+?=
 =?us-ascii?Q?Z4jNlk2sXg/ljlsFstX9LT8vPkPRp7TOq/qwnYf/Jr9PWixBGIVFcrSyHL/n?=
 =?us-ascii?Q?BwMa5df219+pbAKgbk0aPowl3ex9mHeQBy9IxZhscl3+jtG3C9+TNfQykEo8?=
 =?us-ascii?Q?KvGBxtKhuSK/U61fgGW6EqWFO4+06XWbvKop4VQXHA+7H4TtHS78iZ9TjCRA?=
 =?us-ascii?Q?r1/meyQ5McOewCNW8p3Vd5QknssJ9jxCk1duI1hJ5wxjl2m4kEEqH2blnLZy?=
 =?us-ascii?Q?CnnuC2+h+mbcrIs+ARZknsDIJa9GtXlkywDffUWHEBlvA/y/W0qaSVurK4OQ?=
 =?us-ascii?Q?8O276/sQSpXUtHDVEtl1rg+1Chaonli+ROaSZbmESYm2QQMUuux2lP2Ju13O?=
 =?us-ascii?Q?ZpYqP/imhohBV7Rquw4wdVjNkbLN128B+Uyet63QB5ETA4hGysmaFWltAd6X?=
 =?us-ascii?Q?WoTJRnaG5/CBFuBVWRnQ6h4GW7vl+Ai1xTBrLgc07T+ntYh1OHxXlKwNXTDS?=
 =?us-ascii?Q?IGp0B5vP/jjxynVuSAob6n9FpRTOvF8Sl24LYicCcCOi8GRWHzD7FXsfcOi4?=
 =?us-ascii?Q?uPMPaR1zPxld3mazMunYNoveX2d1s276SByfCo1jlPqUzXhcw00RDhhEnezN?=
 =?us-ascii?Q?6blUyPzDEJODyzyhZm8wKXa2PY6EKnH7K4+67u3u55LQH//Ug7EYBe5qHVGR?=
 =?us-ascii?Q?FNC4/ayB0P/c99T6BUjD0XmSYPzpS4P935y0ZuAQWloE+eLl8X3ybEO0/aap?=
 =?us-ascii?Q?HdJiQRRJIUZG4BkB3h5sqwZW1XV6pq3wYbL8WOa5IdRsizG5KQJnJZAHp0YH?=
 =?us-ascii?Q?fD+SJGZM6q3+Qy7xTXoE1X6MxM5s75DJayJVyboncpAHoHF1px+yVq1CKxH0?=
 =?us-ascii?Q?obAb4OKtogwwMuF+2Kp2n5bkCOoIgoherQEfKZqB7Q7nGTBwPsgHVC4WOPle?=
 =?us-ascii?Q?8gPOE9p1fdGLgkJ3DCVG1JxVl+LWaSipL/r1PeAmMSvb7g4R0aU5xYAj8vAB?=
 =?us-ascii?Q?zxZKudqKCMAu/IUXvcllCgl78GngSYnDLK4whF1ztB30k97va5z+gAJI7I9k?=
 =?us-ascii?Q?IGT22SkodEqQvh82HOD00EFfhwW5FdP+u/iyio15zkz2QgTNO4q4H8ZV/Ryz?=
 =?us-ascii?Q?JOguVCEHiMgoAQ/Gv3Wvn1utC2YIAGF8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:03:15.6584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e76dfd1-e4c6-4bd3-677a-08dcccc8cb6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
Received-SPF: permerror client-ip=40.107.101.49;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Series based on f259e4cb8a8b4ef5463326fc214a7d8d7703d5de.

Testing:
1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
enabled
2. Windows Server 2022 VM testing for > 255 vCPU.

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


