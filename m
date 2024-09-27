Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CDFCDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEmi-00061y-PR; Fri, 27 Sep 2024 13:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEmf-00061E-QJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:29:38 -0400
Received: from mail-co1nam11on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::60e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEmd-0002dY-Ih
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6SEc9R106CTgaJbc4jV9LfkuwKO8WlkYxCp/jUwAnHR6Xk86Pi0ph9ZHCJ1VlGUCh/dutUf9dV00YLA6Q76HPMmKHFLPZqDeBJHWteuJ9ltais95wtEU5RuT+W8DnxLoLZyQJybSlHJbII0os8mVxV2ZL03PvpxjFPC0MkAL73YikkCzygVUxgnrpz4NJq37dYJ7Q07cY0n0ngfAmhEk4hIJUUTuY1aW5DEpHFRNZqFEm1+YTIaxve/+YM85mOyto9OArh40eJWOxt9vhOoMdfUe3xIZImMYCvsPUibpvWGCXw1LayfpxM2LT47TiGQbORN/dFmbJhQxWW1OrLcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=506TJr/hIgLG0b0xZ3zdlV40jZVwnWGQGUGSU/ePYpc=;
 b=ca6w2X/KorCrzM4BhNgST1ESs5L3fUbdhRs48O5WGSIVso2pRaMgu8EQ5so8EzS2+o0sQaLAd+CEt5/AtcVVdvb+1HfR2w5PHkQ3MUjAoEJr34MSsYBx9yEfcOrkRofFs1GefeopeyWkPTkM+4N/kZRc4RPPd03vOox2sXOqJCtVyCvGW4tDEcTGmrBP5ZXmfOpE8YbVDw/KBJpMWoi4edBbu8IV+ikv0HAMxTcOZGupFVoXegLVF2lrDTjnIKyIepbRdhcA73D81NyzbxTnbp0GprmqeGvrPPfK0fTPw+kOJyCdBrrL7Mk/PIX3f1gKyPO/raC58mVF1S4WXZo+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=506TJr/hIgLG0b0xZ3zdlV40jZVwnWGQGUGSU/ePYpc=;
 b=k0BZnGlLCi4hnAnWIIwClt+ZFvlfiSxVCM/QD8U3mL1Pn48bn5XFa2/UPb3DUjmBhI8yeguT16IbTMughDKh0RzVSMyuNEJ33WfViKF89F3+OtQyvxxOeBF+OmkCuUpJRuKXpPys0KqErPoWcS6wtMdTfyCevpgJwUiLqpPkNy0=
Received: from CH0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:610:75::21)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 27 Sep
 2024 17:29:26 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:75:cafe::9) by CH0PR04CA0106.outlook.office365.com
 (2603:10b6:610:75::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 17:29:25 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 12:29:25 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <santosh.shukla@amd.com>, <alejandro.j.jimenez@oracle.com>
Subject: [PATCH v3 0/5] Interrupt Remap support for emulated amd viommu
Date: Fri, 27 Sep 2024 12:29:08 -0500
Message-ID: <20240927172913.121477-1-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: ef67c15e-051f-4530-e3b0-08dcdf19ef25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KqXhBDfAIpRs2CpRlXCuFRM9NDvwqJ4BI8bw4iQfmXvOWlQRdBEWXVa/IPy0?=
 =?us-ascii?Q?3DUD7/LiKlj5OfWcvR7Ls3pFMcjH3UrfkuFr+FVHC1/mxrxbasbOVE6aom76?=
 =?us-ascii?Q?AA+htt0zPHOSyKWwkzJCeI5QY7vwdNtX+2r9VJNsLSnl3w60pJKTgcgqiOcN?=
 =?us-ascii?Q?ga/vdeGrlywcy0+wEsg1S/Zz2a7JlcQeRMFYt3SWdIOZ0HlXMNt6lz6qUSU3?=
 =?us-ascii?Q?zV1BnrYKETomeQ+8rjpOJ62h/AQNVr8NO+JORa9oNdTHJz/mBQ0ebM0EI1Bu?=
 =?us-ascii?Q?3DcUyosp3vpv4uLPdH+7ZaS3Yqoq8EtEHgIUUqvb3OF965aVTMv5XbuqHIDG?=
 =?us-ascii?Q?WEbwUKxpMG7K6tRBaPYgkvIFNBsUXiik+lSk72UbW36ZUVzyPVNsFhrXIQLk?=
 =?us-ascii?Q?iugXyvo00Nod/jg2XLa7DcRFgqXjPHQjFom4TlZApjHAC5k3Ijyd7O4LuD2l?=
 =?us-ascii?Q?r3m90OJH6mgtmGQ6BO/mxaDg1am6b0Qb/q2Qf3vujSn/a1R11m5s7XHnpKeb?=
 =?us-ascii?Q?Fss43kSL79dSgHJ/MgDZ+IwqFfFg7V90FROf8qo7nHslzowHOx6gVvIU9aI7?=
 =?us-ascii?Q?o0bi8TZRb9NFZWZuoN7IiGWU6bZF7Pat0DrEaF8h7XVbGOyI4KR2I5nbl01k?=
 =?us-ascii?Q?V3vP4+2PNaNVZPA2vMIX/ZKjSuhCZeNfCNoQbbCDsilx9zHEXMdaRQcv5uXe?=
 =?us-ascii?Q?xX22fqrASCA7KKqnI+MkeuepgQb8pUsD/U+Q6wLCdrtayhpqiEZdB42GZ8Ls?=
 =?us-ascii?Q?7wOFoEmDhwCzzdGq2oyR5T4jAz8VEQhzBpQ+N6t6jfaQU45H8N8eAEqcUOjL?=
 =?us-ascii?Q?13RwjX7AxNjDSnwf/6NLMWnrnYw08l3/ZJL4bwBRTU+h9c600nD8UBClyEIS?=
 =?us-ascii?Q?pIzOrKEfOgy6Y49dwKNNK/foi7Ow4G99bO1y9whizUpl5Et09MsjFddNXKjt?=
 =?us-ascii?Q?M2aJX6i1z17bu7H50Lr8mCF88dn0pvBUCtNZ4JXIE7dPrdhLsHrRnFv7PNAc?=
 =?us-ascii?Q?iLhXPW2ORPTYtrQ2t74yrjdApQREfFB3nIoHSRZtxSR1QLvvKg31RHd3h7yl?=
 =?us-ascii?Q?tKYOMSimOlfH2V/M4gAb4Iz3Nf2DSYsCmtDLimGY335Z8In0xPYUWc3AFx0z?=
 =?us-ascii?Q?/RPUZdbF2J9gl3ZJv0GmlSKixfZ1wYzy1EUV5u0dCdCC+HPdlunVTBliLjKZ?=
 =?us-ascii?Q?KU+h3zUciKGZyFzdGqGUGV03BeBJ8OjGe/x03hNfMBGNmtXJJteIWFVH5Ywf?=
 =?us-ascii?Q?G4UZ8lyENLrNNPJb15JkwSyI7oTd3M33QM6fnK5mnftCRIS69Jx2TtL0PpKO?=
 =?us-ascii?Q?KhN5TVqBXMG0H8DcDG455JBLRaAloAm4a3zj/eOur8TUKP2PU0foClbawzxA?=
 =?us-ascii?Q?qR1iWIdPLFOgUnyeyYZDztvbn8B/gJ7g+zjc24rGONNKNDp9E+mfWtALgesO?=
 =?us-ascii?Q?ZGhTcBOH85DqsY7Fc2ipFdAFGzXNjtT3eQUnNp2FjX3ge13tf/c+Uw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:29:25.8557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef67c15e-051f-4530-e3b0-08dcdf19ef25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
Received-SPF: permerror client-ip=2a01:111:f403:2416::60e;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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

Series based on e10cd93872c31332b002c933a798ab0bc51705a4

Testing:
1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
enabled
2. Windows Server 2022 VM testing for > 255 vCPU.

Change History:

v3:
- Incorporated Alejandro's v2 nits comment.

V2:
- https://lore.kernel.org/qemu-devel/20240916143116.169693-1-santosh.shukla@amd.com/

V1:
- https://lore.kernel.org/all/20240904100257.184851-3-santosh.shukla@amd.com/T/

Suravee Suthikulpanit (5):
  amd_iommu: Rename variable mmio to mr_mmio
  amd_iommu: Add support for pass though mode
  amd_iommu: Use shared memory region for Interrupt Remapping
  amd_iommu: Send notification when invalidate interrupt entry cache
  amd_iommu: Check APIC ID > 255 for XTSup

 hw/i386/acpi-build.c |  4 +-
 hw/i386/amd_iommu.c  | 98 +++++++++++++++++++++++++++++++++++---------
 hw/i386/amd_iommu.h  |  5 ++-
 3 files changed, 85 insertions(+), 22 deletions(-)

-- 
2.43.5


