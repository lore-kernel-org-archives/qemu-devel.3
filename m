Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68042CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pl6-0000uK-0O; Wed, 24 Sep 2025 09:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1Mtr-0002yY-Sp
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:39:04 -0400
Received: from mail-northcentralusazon11013040.outbound.protection.outlook.com
 ([40.107.201.40] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1Mtj-0007TM-Mo
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdnFuNbwTdpT/DJbERLChpgS+1AFwzhPX+SZAMerdDA+Bo88KhLjmb4q2778Z1idRfDDdzzg4Kqm5875fpknO7qDe6eLJqMbZs3WIvvGzqTOGEaYCwMjPkMuCd05Bv3acF2pCl6Qo8MlbjU/re2dYPziKOPGMT7f5LXnT04My5wdYt8EpxW+WyOQXFxz+18Yucg+QEcqLkmdYxLn6IVf5UwTkMYArATYL3ULcoxOJlDgMy+ZNW5Kf9XO2tZJZu/vBxQeMsXmy6K3RnUh9TiT5CNJFABgEqmiFaJFnp4U5nDRinZp9jXnkLj2xKuPxp7q5MgW3t8bRogJkfEr39C1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnhgkfcW+ymY+9s0VKEETt4HgrAAo7OEJHXJTtZ3KcI=;
 b=DeasmFAEQHxJcsfcL4+Ox9rckrtF77aDH1++uct6QNO6xRWhn6TlKhGALbh3ufI5RkL7TpNRhoiIuiH04BELK7JcfoOiT80jsOlgDCnojRlOM12BoimUGwYAdUvvixpMJrldL4/xE4z/GjVsCpvs1mVOr3NDxeqwwCor01nXlLem1JARJ5bZn+PQ5BA8kTAH2Vj4EE56BTZAzmYgWIdLXGFde2shyleMRPAtEPIIXRrMcZOt6hnmHHFIIj6h4nxHzwOUYJ/HBnpKkAL6p8rSzGslRpC2EoBbwWkBbTIXjnmNg4gpYhmseiavy3JSq3C8lTB6hpj2M27geCqQjGqpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnhgkfcW+ymY+9s0VKEETt4HgrAAo7OEJHXJTtZ3KcI=;
 b=JzlYGhG0lDLdM8IGJCT8fMuswMJf40066/+G/9Q11TUbC7t2SuXTmmqPUG2J5tj+JOje++H2nBRxWeZKybv/oQr4LXtkujyOhWWFNbm3WGLCsosMVT0EiGTN4yroL3xahIrlhM4r0TmFR7ayCnhGPF8eaJjs5Mmxi3ei50Hot4g=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 10:33:43 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::f8) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 10:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 10:33:42 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 03:33:40 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <FangSheng.Huang@amd.com>
Subject: [PATCH] numa: add 'spm' option for special purpose memory
Date: Wed, 24 Sep 2025 18:33:23 +0800
Message-ID: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 571c1153-7703-404d-b62d-08ddfb55d546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TrsFY2QGXhIzHP5vTwdkyxP5Qp8LSR/rsMh22cpkKS07TzUmLXj1tVzTrQ7h?=
 =?us-ascii?Q?09iT0NqMewRg7NpHWPhQbibEjkD1lX4i34KWuuqvTcaUrUPBMzb04vSPxtuH?=
 =?us-ascii?Q?V/deuPzeI3jRz1DENP+ypaInUjdzk/rQ/xizZduBoQ3rK/D1oVIJmsOGTqYx?=
 =?us-ascii?Q?QXHw5uFDneGGRf2bOFXMGc0wqiiVfPmZ/e2+RQUraT0XU/8CGdz42K9H6SPh?=
 =?us-ascii?Q?qiOHiiH1fMBQSOatJ1c6LIaFQ6VahJ1YkW0Lx3K8vXe+qrmXlbiPcQqb54tV?=
 =?us-ascii?Q?gtp4CMN2LcoFprgB3WcjmRyGCE/RN+Qwf+eZy9WYPzZeZyiSZwtqnGBmJ1ar?=
 =?us-ascii?Q?YPs6xcG6LEh7p+yA1mmmzL1BYvRpUUPfjBUnbt2uTPep2MO73v9gM5bIHe1z?=
 =?us-ascii?Q?GKo8bBFVhDcLNmWCRQkXxGeE25JHwAdPa9jKGU/9f2JXVTmHTKPrPrdpaxgh?=
 =?us-ascii?Q?T3hwGx6CtAmKHeclznacxZO6bKrbrmA1NMt31AgAaL4gAsgAR4vu7Em5tzeP?=
 =?us-ascii?Q?1812naEhNsNmkqq4hOlTl+R9sR0X9yuaYe+OaianhfiIOD9eIKMziQF/f0bJ?=
 =?us-ascii?Q?3elZp4oc9ki/+u/nr86GN5jFhZpYyr57zBPWiqhIUOoXus9v+8EVyiQrqKoq?=
 =?us-ascii?Q?VJa+GViVvELI1cTtwAbRaWopqBCtas4upzOxs7VNn36rQZnLxfTzHnm+bJeq?=
 =?us-ascii?Q?Kv2gay4S24003Q2gKYrNjc48YFrVr6j7gIRbcJL13mSLAjZYqRaCaqZxe95Q?=
 =?us-ascii?Q?3VHFzyGpoPeEK/v1o1UiQTW8AwzqukqTxSPEMWruL78VVQrIutIOLn1VK+KI?=
 =?us-ascii?Q?z9OZMLwFMgtVrh9rvxTSeDNoePFd735gAHaSv1epUNyNmYjCW+dnVIrwXD/P?=
 =?us-ascii?Q?4JGVyWHmJXQ0AojMBS4QNLj0Hl0Dd3+ZScgAgZ4BgqSETmobkpBk/57b/2zk?=
 =?us-ascii?Q?q+IDTj0mCiHx3OhJUYx2BrDArlVZ+qWV0jACpbyAaablHKi2YDYt7AnubzF5?=
 =?us-ascii?Q?Aw7qj00128vC4dhjK7GZDngevJEMYUCJeholR4pV11Yl3f+tzhmrbOgxCM3M?=
 =?us-ascii?Q?reLm+Qqf7kDX39BqU84a0CGnYAXeInlzIJlYOaLhT+l7sTn+1fnH9tmY5ntg?=
 =?us-ascii?Q?6ggdYhtqiJTMWGdJGckKAuteL7R1V79sB5lguoUrlTvu8im3GgLpjqe2PFE3?=
 =?us-ascii?Q?uKZqI+IN+X87DwuuKZlKKPY0UDKGdZgW/8t2Jw+bu/TxaKUHSdlOM//QY38V?=
 =?us-ascii?Q?/6Lkxijcwpgjok4mZVNuatOqcL0jERRDkVd71eN8KD1+nAUYQ40xtvwpEi0/?=
 =?us-ascii?Q?nyp8YTOPgh6c6RZjTejTPqcLEC+4A3OVgzSf0JJTzr0trw2Ew/IhBZ3dehBG?=
 =?us-ascii?Q?f7ErwkA85prlvIcu5J+JBjLQ9Wy+DxCCOwERj9kMS962kuW918kxXNdyTF+D?=
 =?us-ascii?Q?ELevxx5/y0cdOwZSQnnJIo8NxnR8cyFaaUzIw7riwwXYidgS/ZoUfcVDEX/Q?=
 =?us-ascii?Q?kgNbTxldNHFZKSNjuW460NfHKfA2+zrNj/Ifn/CVUXVZTY+55muYFJTIiw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:33:42.4117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571c1153-7703-404d-b62d-08ddfb55d546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
Received-SPF: permerror client-ip=40.107.201.40;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Sep 2025 09:42:06 -0400
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

Hi David,

I hope this email finds you well. It's been several months since Zhigang last discussion about the Special Purpose Memory (SPM) implementation in QEMU with you, and I wanted to provide some background context before presenting the new patch based on your valuable suggestions.

Previous Discussion Summary
===========================
Back in December 2024, we had an extensive discussion regarding my original patch that added the `hmem` option to `memory-backend-file`. During that conversation, you raised several important concerns about the design approach:

Original Approach (December 2024)
----------------------------------
- Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
- QEMU cmdline example:
  -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on
  -numa node,nodeid=1,memdev=m1

Your Concerns and Suggestions
-----------------------------
You correctly identified some issues with the original approach:
- Configuration Safety: Users could create problematic configurations like:
   -object memory-backend-file,size=16G,id=unused,mem-path=whatever,hmem=on

- Your Recommendation: You proposed a cleaner approach using NUMA node configuration:
   -numa node,nodeid=1,memdev=m1,spm=on

Project Context
===============
To refresh your memory on the use case:
- Objective: Pass `EFI_MEMORY_SP` (Special Purpose Memory) type memory from host to QEMU virtual machine
- Application: Memory reserved for specific PCI devices (e.g., VFIO-PCI devices)
- Guest Behavior: The SPM memory should be recognized by the guest OS and claimed by hmem-dax driver

Complete QEMU Configuration Example:
-object memory-backend-ram,size=8G,id=m0
-object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G
-numa node,nodeid=0,memdev=m0
-numa node,nodeid=1,memdev=m1,spm=on  # <-- New approach based on your suggestion

New Patch Implementation
========================
Following your recommendations, I have completely redesigned the implementation:

Key Changes:
1. Removed `hmem` option from `memory-backend-file`
2. Added `spm` (special-purpose) option to NUMA node configuration

I would appreciate your review of the new patch implementation. The design now follows your suggested approach of using NUMA node configuration rather than memory backend options, which should resolve the safety and scope issues we discussed.
Thank you for your time and valuable guidance on this implementation.

Please note that I'm located in UTC+8 timezone, so there might be some delay in my responses to your emails due to the time difference. I appreciate your patience and understanding.

Best regards,
FangSheng Huang


