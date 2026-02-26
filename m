Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F55FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ2L-0003ZT-Er; Thu, 26 Feb 2026 05:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vvZ29-00038t-AE
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:55:56 -0500
Received: from mail-centralusazon11010037.outbound.protection.outlook.com
 ([52.101.61.37] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vvZ26-0001eE-Rn
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:55:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIZVBaxcGUV1lBz9A61GlwG05nohv7RPIqeUBbW1B6H9kIsOZ7Ob1LJZUR0dSU/+dIB1bJjuka26Rwxbo1zW7wKBSz7z/Jr6zqUjzZl0HgR8IgDmlj3FpzF7TnyR4QCXrPaVgtlBngIKcDqW0dDP8cpWLHNO3eckCB6z4i1JLHF9M5Lrmbe6al/IKF/1u7HyJfSqiNcJ9lgtECSslSEW+wZZzgL2rZ9qykgjAiroRWhOeV3WOgKpfOSsrfIPiNF5XDNonh4H7VRKa/h5N73sfEZgXGAT6MABKoSg7JkeB7/zaWsg4sNu68phwe4wsHrnrcJLL9SwyXKn+3GLyWw+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R0CtrilsFWS1BvAQZWygAP6hJf7kcUZpGbuvIxQmUY=;
 b=hpTyNzXhJYmxfGsy/DPUzxKfflJVkJx1dfTs4JnpT1OxQ60ggJiseZMO+uKeD+7iLfZtgrgiajr8S2oBdkSPWWCHk24s8n6erGbMfziFwbN1nskYzSu9whBvMPAnt855GqOnDsJFXvABjN1rId8Fp1OxQ/BinLh3H+yyHdsx82uaDKRr8GRjpSvdD9t7y58KqWsQ4NvKQ5FgVyqNCsTYE5RwHOludOoJA0AhzAFjlk9mQXnKsk8CC+x+0/DwjIQcH4vnDz8hBrNGzc0Bl3kAsL4QsM8iNyETU5aj24YtXW+amvbsgeCVxhNy1yhCNZWuPtVcRrBgx2qmP9P+brZN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R0CtrilsFWS1BvAQZWygAP6hJf7kcUZpGbuvIxQmUY=;
 b=XU845zMN9NQHd5vAi2q0/Iv/TVzkUlN7rrqNMaH9zgEkWZtqRI2/D5ENF2lvjritgRIIOySMzB56kj1+rfGNF8vpuBqlz9YjY09ErmJa5SxKOHQJzHM91fT57W6l6kqAmyPISXg5yM4/OtT1+f5s66sraatEBiMwWfDcRg1Uu1E=
Received: from BL1PR13CA0205.namprd13.prod.outlook.com (2603:10b6:208:2be::30)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:50:41 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::38) by BL1PR13CA0205.outlook.office365.com
 (2603:10b6:208:2be::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 10:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:50:41 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 04:50:38 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <jonathan.cameron@huawei.com>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v6 0/1] numa: add 'memmap-type' option for memory type
 configuration
Date: Thu, 26 Feb 2026 18:50:22 +0800
Message-ID: <20260226105023.256568-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baea3c3-662f-4be1-39d7-08de7524e269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: dAodVAKf9staHnqXJiqaOR53iqsqYHYSzDddzRzILOMji/Cff9aqMEcagDB4QJ1hX9li0bqt9Be0FaHJkZZjIJur0GmwssAfmwPTvIyB7k57vgZuA0jUtaMw0vcgbbEqM/en8my8CS4g1lJMNkezj5xdixlIRmVeGkNlWhBXgJEm8wfNQHlmEswb5wcUWhza8Ns5I1IwLRN5fABKUPg3lo2BbtXUoJk0dZcu4kpdTdM56//8bC6NqLcfFE95lmHi1H/NJmNCDzdwgBd50WRULD/bvzy+y3c8/eTZi/t8lNUXGfe71CRXbmMDKivGoXUnZDwEzwuI7EskLColeCteuyv9CsBP6iSugR/j//U4e0YQ2IB1sG2+/iwnc0U9eO0SfN4+vt2qaE2+XGEWJxjjtg8yYmHj7JwKaKrHYWDq8blRBklYP3UDLRG3xEULS2loDn4uEx186s9Ciq0O28smp/1/dJMd2VqDAi3VLPA0y+XwWAxAYXIO9OF+WbdHJ3MoKu6zjk3m4Vz7IP0GiUj1vVlDPG5yp3erP2E6OrhfCqKj/UNaHAQ/U2MYLjdeF1cU1qJGVNbfgkSGwlzqU7uWAvwutuIZ0MvNeeneoWNJz9Fm4zxtuGVjVdiH4KC8k5QTVkWy/IumYAlh+0zoNY/C/W5SGtDLMWofRyLV9gy2hGRGu1oiPmr9oXLoE8YQLLt1k5XuSTnnUAPQWNchDor20VaOmMNSSJZRyBKL0LXIEiSQkozJWQKcmAlrNBSibGAmSz4cLTvQsOymUXNwUoOSZu50dGD+1hz08wcYPnMEShGZp7fcagzASzIX4UbmEXxsvMwT3OocO7ZIKeybBNB46a2vafIFwv1KboL6JTnF4bk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O1x2/ZmjHDRHBmwuolaui8YsghNKeDS/h5YzOWmintxEPL2xhAd64gCBYmcllQotGXxPuW9I5diGfKm8SgKT52vbLfMiHqyepON8Vf6yJmSelN7DSYwd0RKy1/bQ/Q2VFz7BnVAv/S+5GWFphBUxG0T7ORoUwaVZo2xewAPHGuu6Cx3TA8zTv0OSsYUD4bEnIc0hqNF+H2EyAOzEe0iOwMfMeIo64z+GajAnPs1u5jp81poiwfncpf3ehzevOJ+uMwtwhTel/nN1EJPfbnn04geD8T7Ci9OG4fmiULuIROIEvuAjnVsA4e+WWBxzvw7mU2FRVp5hcPLGNKEi6GIax6gT0RlQm5DpcLUIP+v9Jzz+EKP53OMUbzt5opusT4MPcRcJsIjtN09Lut6CE0VxtWRyCA//0NSsCOHjU006LUwFvHb+uu+0fLppAw2INFs9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:50:41.0533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baea3c3-662f-4be1-39d7-08de7524e269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
Received-SPF: permerror client-ip=52.101.61.37;
 envelope-from=FangSheng.Huang@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is v6 of the SPM (Specific Purpose Memory) patch. Thank you for
the feedback on v5, especially Gregory's review.

Changes in v6:
- Added validation: memmap-type now requires memdev to be specified,
  to avoid misconfiguration on memory-less NUMA nodes
- Simplified pc_update_numa_memory_types() by replacing switch/goto
  with a direct conditional expression
- Reserved memory nodes are now excluded from SRAT memory affinity
  entries, since E820 already marks them as reserved and SRAT should
  not report them as enabled memory affinity

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

OS-facing test results:

1. memmap-type=spm
~~~~~~~~~~~~~~~~~~

  -numa node,cpus=4-7,nodeid=1,memdev=m1,memmap-type=spm

Guest dmesg output:

  [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
  [    0.000000] BIOS-e820: [mem 0x0000000280000000-0x000000047fffffff] soft reserved
  [    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved

  [    0.042582] ACPI: SRAT: Node 1 PXM 1 [mem 0x280000000-0x47fffffff]

2. memmap-type=reserved
~~~~~~~~~~~~~~~~~~~~~~~

  -numa node,cpus=4-7,nodeid=1,memdev=m1,memmap-type=reserved

Guest dmesg output:

  [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
  [    0.000000] BIOS-e820: [mem 0x0000000280000000-0x000000047fffffff] reserved
  [    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved

  [    0.042728] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
  [    0.042729] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
  [    0.042731] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x27fffffff]

  Note: Node 1 is excluded from SRAT memory affinity entries since v6,
  because E820 already marks it as reserved and it should not be reported
  as enabled memory.

3. normal (default, no memmap-type specified)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  -numa node,cpus=4-7,nodeid=1,memdev=m1

Guest dmesg output:

  [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff] usable
  [    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved

  [    0.042413] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
  [    0.042414] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
  [    0.042416] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x27fffffff]
  [    0.042417] ACPI: SRAT: Node 1 PXM 1 [mem 0x280000000-0x47fffffff]

The results show:
- Node association is correct (Node 1 at 0x280000000-0x47fffffff)
- E820 types are correctly applied (usable/soft reserved/reserved)
- SRAT entries are generated for normal and spm configurations
- Reserved nodes are excluded from SRAT memory affinity (new in v6)

Please review. Thanks!

Best regards,
Jerry Huang

fanhuang (1):
  numa: add 'memmap-type' option for memory type configuration

 hw/core/numa.c               | 24 ++++++++++++
 hw/i386/acpi-build.c         |  8 ++++
 hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h | 12 +++---
 hw/i386/pc.c                 | 48 ++++++++++++++++++++++++
 include/system/numa.h        |  7 ++++
 qapi/machine.json            | 24 ++++++++++++
 qemu-options.hx              | 14 ++++++-
 8 files changed, 202 insertions(+), 7 deletions(-)

-- 
2.34.1


