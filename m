Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6657C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4qa-0006Id-F6; Fri, 28 Feb 2025 13:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4qY-0006Hv-Ev
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:12:26 -0500
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com
 ([40.107.94.60] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4qV-0003Hp-Vg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:12:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtIkAun8ppghMSZBYgNtXSCSxOUlKZzvcd5suou5E1hh1T8On/mk+Kf1S6cN3BKwaDHRrTjh5CyF1Hv/9vSJvKko1kZ9KDOjj23HH7f/UqbLW+/vPElE5mw8fAM77operLbnQVMd7lsT+RxnreGWFfYt9zuzm1LM3i2P3/lDFpyylVHBTYufjfG1qWDaQYTpAHXg/h4AkJRYJRezhOfs+yu4B3HOU4SGGC6eeo2Q3xDQ3u1nv2yKyZpieTI60/+RcX26m7t/hhZJi+KU2jwqimoVfC8rfk/6vzzEF4IMevm3lPOfha/8JnMo/DIeS0Ii/rInSzI87rky08qCX3j8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2FDTukXAiLBoFjos2fdqXuplt+kJ6XxKQQi10Sb2yc=;
 b=gMZ6zp7RBp8iUZ4iwHUppqVHxUkq/8dKaiyGV0gNlVvhyVBIl22X/KmhW9SahvtmGo8eSxos2yZCGq1TftrWe31pIPWT75ISKel8p+cLaCBCwkWwjbaxHu1v/hH/VlHUL0GMEXCOayGIiFBns49FuvboOk61780gWrYkTWodxkemh0HbUJ7Jxgs0VyRUdYfi+lMZ8+MwEoQ8ydRF8ecl1i09+tEGJxJQbiebkzPoY2E8AxJmeh246kch/9/nVp4Sc/WM0Iv+5hidej2FK8j29ljaMQM1GYcdl+bGjc4JLA2Cph/6MTcV+uN54EHLpRMgnwI9eNWuVk+GbPjACDrqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2FDTukXAiLBoFjos2fdqXuplt+kJ6XxKQQi10Sb2yc=;
 b=4QPPTwMhAJIXFc+KyDL9WesiYTcmq4d8mReq4UqbOx+4weRVJ0OpcnE6yUttXpHC6jQrD/lkzq/Bf0ZD33oxbK/zeaxVHN3yk0ExGPDHxYReWlBhffEsXunKmye11paLrn83pyefJev0m12mPI2nsOe/ArGpHebkcDyMc17j4/s=
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.24; Fri, 28 Feb 2025 18:07:14 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::2d) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.9 via Frontend Transport; Fri,
 28 Feb 2025 18:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:07:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:07:12 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v6 0/6] target/i386: Update EPYC CPU models for Cache property, RAS,
 SVM feature and add EPYC-Turin CPU model
Date: Fri, 28 Feb 2025 12:07:00 -0600
Message-ID: <cover.1740766026.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: b92545b9-11ad-4e97-d873-08dd5822baa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQDMR00maWUgzdwwvExg36jN/ZwhbinW/iCGYv2OLP/tUGnTPW8npNRAIe+Z?=
 =?us-ascii?Q?tzrCUC6DDC3UHF/83uCK+W9gc4otP01iRiRZ/wsMeA9EcFBNRGp5psqxCWHW?=
 =?us-ascii?Q?l0FAAa+NwKLR6I3n+OAMtD3mie8YKmhimZg7SPW0Mrry4qjcx5wOJJTMRDGP?=
 =?us-ascii?Q?DUtsI+wJ3xWMehXXaodzLMIOrWRYcLmKyNOGrWwOIjW7DPP5PDBYcy5aX3u1?=
 =?us-ascii?Q?29ZK3Ls98fPi7sOh5dYwJ2j2xXmS1aDaBWEFKpplYcQxmvZ1oQIrdD7N/p+C?=
 =?us-ascii?Q?DDPhF6GVC+wPrB+rKsJxlG445NJ1PpEYIGectTufBL/xFooQXbOv1KO0UvyG?=
 =?us-ascii?Q?rB7fZ/yDnbhzUhh376sllVlpgA/cNxrG9PaDWjnOmdbABzv2JwPzU/Pb0fOs?=
 =?us-ascii?Q?qT4JcvnVlyMSJL8e1iaD2DeHpI/v7b21Mu+Qo8BIWaFXxZsXA+F/MPGNYmY/?=
 =?us-ascii?Q?Tp5r7xktWz5WFsOcYDhwn8fdZDtmQvY/usga5AzC9lgyS7oQlstBmdT7rrWV?=
 =?us-ascii?Q?MKb8b0sUnjopVE0PMaUtTurn3hyLpZ+e/MJkT6Yl3pJ0vDcAqljoxpNVc8jd?=
 =?us-ascii?Q?9LsG/Qp41Y3SnH2tvNzX8TcnLGZ5hAUlbUBuadxd0gcrG2xsemj1Cf9XNn74?=
 =?us-ascii?Q?lkwEOhP9uNBv3VOjqGDSlsRMzeLfG1OiZ8T4qIE01QMBMzA9uyPPASeTwp3x?=
 =?us-ascii?Q?V55dPteocC+q4FmNuzmhj66KyAO4CQ/J2WLSq7jnYMsrS5cFgOtuZKw2C/ao?=
 =?us-ascii?Q?2ZmH7h48iMBAtpprzk2xdVdhYptKX6hCaB/Lw0tV6pJJNzUgaGomAlhVfmFn?=
 =?us-ascii?Q?XtaDF1qk7RokYkzP1BMItsKSS6qhwACkRq8oGKeeStMAwK4hUmgTR1tUkKgx?=
 =?us-ascii?Q?SirdxPKvwZKaFKMbOF6rB//pL7vSrdo1rh0ZGve4tFLlW1evj2NNFztQ+F7U?=
 =?us-ascii?Q?bIEDaV0TXiWV86tCJvwy+EWfhqy7pmjWjUDrO41TxGysBcS1dVUM2e5/uwnJ?=
 =?us-ascii?Q?1BSyDSbZGz68cQWcwoN7AUx2hTAxRsjQoyXQbMvFqppLpNg4MMj1lFFTq/NM?=
 =?us-ascii?Q?SyCX7f6CIZ0PHpQw8XriEixDEDw9klOeUfDln6LyCLQhhUsMmXGTvrnYSBHr?=
 =?us-ascii?Q?Kx6/OURBdXa2mk8wOTrJ5zmrgbdpKahEFaffDn3PuxJZLctDN7P8YL6kuQE7?=
 =?us-ascii?Q?0HMQcGqhgH+AQzC2EFpe4UwZOQgbmQSa9B+VAqrCkeiCyYxJ97NNMgdGQghW?=
 =?us-ascii?Q?5qIxO6QjJPxXrP/wcdlUc1HuhUDdwcj17Q55Lv5+Vkw/IAQq9SEftjAwrg6s?=
 =?us-ascii?Q?j6iyr5f4kLu+fWEaEEtxER1PZHF3taWNohBxtsWzkOVT5AMUwYmH41b5gGiw?=
 =?us-ascii?Q?DIoHjUALQYleUEtY6qnFhXbIVl4hJVTyz/DYpyCtSKjfTxbEfl/vUJQyhalC?=
 =?us-ascii?Q?dmfF8vzB5wb5Z0357JYvykws8IMTiRaT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:07:13.8610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92545b9-11ad-4e97-d873-08dd5822baa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
Received-SPF: permerror client-ip=40.107.94.60;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


Following changes are implemented in this series.

1. Fixed the cache(L2,L3) property details in all the EPYC models.
2. Add RAS feature bits (SUCCOR, McaOverflowRecov) on all EPYC models
3. Add missing SVM feature bits required for nested guests on all EPYC models
4. Add the missing feature bit fs-gs-base-ns(WRMSR to {FS,GS,KERNEL_G}S_BASE is
   non-serializing). This bit is added in EPYC-Genoa and EPYC-Turin models.
5. Add RAS, SVM, fs-gs-base-ns and perfmon-v2 on EPYC-Genoa and EPYC-Turin models.
6. Add support for EPYC-Turin. 
   (Add all the above feature bits and few additional bits movdiri, movdir64b,
    avx512-vp2intersect, avx-vnni, sbpb, ibpb-brtype, srso-user-kernel-no).

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
---
v6: Initialized the boolean feature bits to true where applicable.
    Added Reviewed-by tag from Zhao.

v5: Add EPYC-Turin CPU model
    Dropped ERAPS and RAPSIZE bits from EPYC-Turin models as kernel support for
    these bits are not done yet. Users can still use the options +eraps,+rapsize
    to test these featers.
    Add Reviewed-by tag from Maksim for the patches already reviewed.

v4: Some of the patches in v3 are already merged. Posting the rest of the patches.
    Dropped EPYC-Turin model for now. Will post them later.
    Added SVM feature bit as discussed in
    https://lore.kernel.org/kvm/b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.com/
    Fixed the cache property details as discussed in
    https://lore.kernel.org/kvm/20230504205313.225073-8-babu.moger@amd.com/
    Thanks to Maksim and Paolo for their feedback.

v3: Added SBPB, IBPB_BRTYPE, SRSO_USER_KERNEL_NO, ERAPS and RAPSIZE bits
    to EPYC-Turin.
    Added new patch(1) to fix a minor typo.

v2: Fixed couple of typos.
    Added Reviewed-by tag from Zhao.
    Rebased on top of 6d00c6f98256 ("Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging")

Previous revisions:
v5: https://lore.kernel.org/kvm/cover.1738869208.git.babu.moger@amd.com/
v4: https://lore.kernel.org/kvm/cover.1731616198.git.babu.moger@amd.com/
v3: https://lore.kernel.org/kvm/cover.1729807947.git.babu.moger@amd.com/
v2: https://lore.kernel.org/kvm/cover.1723068946.git.babu.moger@amd.com/
v1: https://lore.kernel.org/qemu-devel/cover.1718218999.git.babu.moger@amd.com/

Babu Moger (6):
  target/i386: Update EPYC CPU model for Cache property, RAS, SVM
    feature bits
  target/i386: Update EPYC-Rome CPU model for Cache property, RAS, SVM
    feature bits
  target/i386: Update EPYC-Milan CPU model for Cache property, RAS, SVM
    feature bits
  target/i386: Add feature that indicates WRMSR to BASE reg is
    non-serializing
  target/i386: Update EPYC-Genoa for Cache property, perfmon-v2, RAS and
    SVM feature bits
  target/i386: Add support for EPYC-Turin model

 target/i386/cpu.c | 437 +++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |   2 +
 2 files changed, 438 insertions(+), 1 deletion(-)

-- 
2.34.1


