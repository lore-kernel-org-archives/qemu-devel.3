Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E995CFA766
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNte-0008Rc-Ni; Fri, 21 Nov 2025 04:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1vMMhY-0006Fa-Q5
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:41:10 -0500
Received: from mail-southcentralusazon11011049.outbound.protection.outlook.com
 ([40.93.194.49] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1vMMhW-0001Es-VC
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:41:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyGnNffPk+VdJ+mpf4PrY/w7gUmFEFgyHgCSEznp0abWZ1DgZ2hoQs9cOa//qCz8qP9lZkcxMLhNDOt80BL149YyR2OEDXDrTsSqROLiVJv9opNFyeWScE03LrNjkrE+r0oNFHfg6b+6XOWIA2ovse/Muv6ImH/okt5PS6Me+30JT4/XdquHUM0CvUNbzJbPHA8r+3JKFVhZlvRtaym+ETLg2UkHMdWZbegucdSOMSySvFR9XgITsDRsF0CgAlWwlesQU7s3AoSZQBZPGKXH36uF1iooZewCUVeusF3+M6ql5UET7Kyczpk3Zjj1LsM+0Qb5CuOMseG7vOYwz/Nmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui9wLeLEoaZ7YJTeqzOZoUA6YtLQ0SBVuWYFoFLvLT8=;
 b=bRfx94SC0sFEYFX58W37iteuySxCNd7/bbMdF0MxGKvFS/BAAOb1HktaKjaCJcFym8Z9m2qYNnGvSSc3/tjaY3GcmntQTHgbLBChXM9RSY7p9b3wkNVXFp7Nc3CMbjLLgo0YGlMBpY39KPXEaRD/kf1Qk4kDQB001kVGNlqkMWqSwFqxnSnxmvq8IJNFstpDwv9Vty55NKtH1RdwDlguoJgEVkkmwStenFDc8n0/7/XYA/FRtHLrUhBlkQ65RlvyPhTYg/LM6e5VjPHU+aaaaAZWnArHQnBiPIb9LNd4ziv34l2B3CdoGnx4fXmphGojGXNHo4Y7DQsw5FWVgrcEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui9wLeLEoaZ7YJTeqzOZoUA6YtLQ0SBVuWYFoFLvLT8=;
 b=A1K5KkIERPwCtvtn/Wm9sfCiobud05PClOxGwcH20+CQgc0muN/MyjcMf/Am/CDARMnLk00YoC1bTaqQqn2VtmzFGA3R9muXtfzbs9FBjA6/+OFCEzla8RXsMMjYQnSPHPSxMLLclSCBLPMLQvgXzPkhxfuepagl0iz9ktWx2Uw=
Received: from MN0P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::16)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 08:35:58 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::db) by MN0P222CA0010.outlook.office365.com
 (2603:10b6:208:531::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 08:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 08:35:58 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 00:35:55 -0800
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>,
 <kvm@vger.kernel.org>
CC: <qemu-devel@nongnu.org>, <seanjc@google.com>, <santosh.shukla@amd.com>,
 <nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <babu.moger@amd.com>,
 <shivansh.dhiman@amd.com>
Subject: [PATCH 0/5] i386: Add support for CPUID 0x80000026 and Bus Lock Detect
Date: Fri, 21 Nov 2025 08:34:47 +0000
Message-ID: <20251121083452.429261-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 706bd63e-f75b-47cb-8ac1-08de28d8feb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3EtgqXTlt6G7a1EEiEUkpqmbFqPE+yk2oV+/wJbqhfU/3N17ocASZ0UQRG9x?=
 =?us-ascii?Q?o9RgVJyEx9CFivSCWstOmTtPVVsR9+eSdtCZRaL1zEqPEUAwnbrlbePUqYf+?=
 =?us-ascii?Q?T9qeyLt+Nz7DK7KasNfl7xi2HisCxfmlSrkplMUXNzn66h8dGW2G1UEhvD9A?=
 =?us-ascii?Q?OxspmnFelxTcrG2bxrzlQvy6991jA/Lb3V9EvvYShmeiGOP8zH/DZM4JpwLe?=
 =?us-ascii?Q?YeshHFAYlfE4WTBWr/rtY9qawQjdxHOvTgODCYJd0sVqA0X3aRxW0BASxQR5?=
 =?us-ascii?Q?wVcz+UBU9J2JX1NgZl/GlQRYHbZDzSKL7v5FcTZykaK2T0mO3lrvGv3fS/K9?=
 =?us-ascii?Q?u83W2feCCGiYFQ0eGuPKnbFON3nDdRoCesfDz+BIUgwMYU0DNMOeuzZPrwEr?=
 =?us-ascii?Q?83Mnc8VrdKFrJ5p+6tT/ZYuZz2go1p1WCFsCWBY8VxA9lqSOT50XZuHDB8/H?=
 =?us-ascii?Q?xW9bv0GOUnjkobXQRWvstIKno1tfLQACkMKcwuhrAwQiKECcQQ7BgOdmp/Or?=
 =?us-ascii?Q?vpZJfa3f+QvYvDYbdFX1cgdi5aFCKDTpOmcA73OXIPzr4zSanwAp4u2ysDpC?=
 =?us-ascii?Q?leGQj8Ltvo9rrhX+gK3L7LIFu08M+RlH8h9jm+DIhzPtDfE1BOJsL4Pdr/Y3?=
 =?us-ascii?Q?b+4O5xbJCgQc3BCawENL0VrhijY1wCklO1PtUXer82PbfNAgfpFyEguOPxlI?=
 =?us-ascii?Q?8ZwRTynrMusJbM7F0Lr/QbF5V44gcXa6rcxbOgx0ZYguSaCY70BHnS0pHzp6?=
 =?us-ascii?Q?kJx+z2Uxo2STejOUXz0FpCupMz8L/wXlJHhwz7rWtuOyQ/xgWzvD9wMYXnki?=
 =?us-ascii?Q?IXQOch6N2pxwGC10JcP/XX+NA+4YN5uJJ87x0D1LubKoGs3MGEMgiQdSJHUo?=
 =?us-ascii?Q?Kght9qMvxA3LvlrpjRZd//Sif6FRdgIYH0ZIo6GnY7K0fYvbYBKkTqc4Fe5D?=
 =?us-ascii?Q?sa4gFHE6ZMnYaHsn/dYuSpejTc39iSkvyYWORz3tx5lRQzddCkkq7ysAVzGt?=
 =?us-ascii?Q?yHFriQfzzPFxM0ZBtnatgsyHo8rRpZrNw4qUlfsy7n8nV+r3ad1vsSitA8a5?=
 =?us-ascii?Q?tbSVSm4nCskN6kXe4CBkf0PulgnEG1sitYC8pq4BEv6QTqeVtD/THxnDckuY?=
 =?us-ascii?Q?SEXJAPpsnyxoEhk2kDhw0JaBNcAxKMS0bMp1xYMYuPzqkDbE8W69lRXZK7bb?=
 =?us-ascii?Q?HQi4LpwlDGJ5VQ1xkWsMCpeAamVLPJFJG8hxqYVAYYi8punWzx35PY4u9gmP?=
 =?us-ascii?Q?7RrqaOW6wbE5MmXTT6+jDUkVC85X52+a6tTZ4k2dOTSR7s2mvlT4EdUooY9T?=
 =?us-ascii?Q?agPoHFCIVq5W8d3tmMKRZMY/z0nkAaBI/u9OJ3Z7PISiE1H7BuX7EnySZeBJ?=
 =?us-ascii?Q?y+u7Q1A2wknZetXEs2mWcpkvctKIILmRbHus9neHjp2gs3pHB9+RxytsbxiR?=
 =?us-ascii?Q?LwR+9/SQEMoQXLVi/2lBNp1n5eHCSchQdTsLn1HW6ZUW7CVGJuDn8M3fAYEe?=
 =?us-ascii?Q?HT/1Y3tCZZMK3tlFSLIvyyP+uS3NbDYFRPB0+SQBKm0iaPaJAKZzlrUGwqfV?=
 =?us-ascii?Q?1nsA4QaXkIInZgW9RiI7JenJ+tNQweEkn//LVfS8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:35:58.4124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706bd63e-f75b-47cb-8ac1-08de28d8feb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
Received-SPF: permerror client-ip=40.93.194.49;
 envelope-from=Shivansh.Dhiman@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Nov 2025 04:57:39 -0500
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

This series introduces support for AMD's Extended CPU Topology CPUID leaf
(0x80000026) and Bus Lock Detect in QEMU. 

AMD's Extended CPU Topology presents the complete topology information to
guests via a single CPUID with multiple subleafs, each describing a specific
hierarchy level, viz. core, complex, die, socket. 

A new CPU property is added to gate this CPUID to AMD Zen 4+ CPUs. New
versions of EPYC-Genoa and EPYC-Turin are also created to include the
property. Tested the VM migrations with both newer and older CPU versions.

Bus Lock Detect signals when a process has acquired a bus lock. It is
enumerated with cpuid Fn0000_0007_ECX_x0 bit [24 / BUSLOCKTRAP]. It can be
enabled through MSR_IA32_DEBUGCTLMSR. When enabled, hardware clears DR6[11]
and raises a #DB exception on occurrence of Bus Lock if CPL > 0. More detail
about the feature can be found in AMD APM[1]. 

It is enabled for EPYC-Turin-v2. The KVM patch enabling Bus Lock Detect
for SVM can be found here:
https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/

Patches are prepared on master (4481234e).

[1]: AMD64 Architecture Programmer's Manual Pub. 40332, Rev. 4.07 - June
     2023, Vol 2, 13.1.3.6 Bus Lock Trap
     https://bugzilla.kernel.org/attachment.cgi?id=304653

Best regards,
Shivansh
---
Ravi Bangoria (1):
  i386: Add Bus Lock Detect support

Shivansh Dhiman (4):
  i386: Implement CPUID 0x80000026
  i386: Add CPU property x-force-cpuid-0x80000026
  i386: Enable CPUID 80000026 for EPYC-Genoa/Turin vCPU
  i386: Add Bus Lock Detect support for EPYC-Turin-v2 model

 target/i386/cpu.c     | 103 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h     |  19 ++++++++
 target/i386/kvm/kvm.c |  21 ++++++++-
 3 files changed, 141 insertions(+), 2 deletions(-)

-- 
2.43.0


