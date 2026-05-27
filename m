Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB88CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMtP-0000od-9Y; Wed, 27 May 2026 18:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMt8-0000nc-RM
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:38:12 -0400
Received: from mail-westusazon11012001.outbound.protection.outlook.com
 ([52.101.43.1] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMt6-0002S1-LH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNyWksO2B3Rj3Zj/u8hU4xNAnM/IZ8ukwwfIh5lgn3RqhCuoA2LYioRWbOybsJD3J4VFkPPbW96I/1CmZdahGJZteX2H0uzEDgdYXfANtMW3sO2S2ilkKEIDcjn+7rTlxM66jzz81aI9GJVYOix83ZG/XRoBdEOKk5UKgLjgxbDHRXPUYSStWgszHj7XrrTYOq1yLo3VTtnAt3W7ALMjvSCCwmRsReG1qvg5Nz0Y5UnvzNtMemzXc4ra4ylJwpTQVgw4JQ0hcl/eb3jAWlIk3lNPdi+VO2AfdsdDZ4HzPv8RynmxWDT/hfdchCrU63288HzqpgHkLHA/TNDu274tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6sjWP17lKxRUlt3KnpJ9PXbX1DqFAxFFH5Gq+eD8Sw=;
 b=nPYuMGhMpUdpASe9r7u10oVo4Q+6H4p6LkzPEPTxwgqf2fCA8zdt/kNVnrX7j7mHFDgI7kFD+bijLUC82kC0SS+xleyKySDUPazhottwCDfP+ifkRB4eJW6KkX2ARwuKDiY6TtJua5SlroMP+yt20dje0rMbNGBLM8ArpGRwMBDeIi1lSY41qq5Ull+xGHuQIf1qNQ5YlYw85GVCEHJp/5jCPQ7v40bq/DRmBqhGZ/ZcWXENUrUebu/ms37215KTPB6oIN57hHwsWyULf7EMhEb3ml7JdnzM3oSwgY5XRX0oKMMRzmXXZ6drtspbJuMFDgXfV4bn+Ckh91wXNxFiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6sjWP17lKxRUlt3KnpJ9PXbX1DqFAxFFH5Gq+eD8Sw=;
 b=bB+uNyCF8EK6AsPcMjQfrQLTiK33Sz1RhFRN2irNYWvWLEQEVj5s8o+jHq+VzeiyfCVaPm2gKjcKjAMZbbYkedNZHBjwSwfsoHayArC4PVTxWRG93kYYT9TItDgwUGsKW0r1+1iUYIhoycfrXGdNzp00YqxAfDuE4zcDGBkk8Eg=
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:33:01 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::45) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 22:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 22:33:00 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 17:32:59 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>
Subject: [PATCH 0/4] guest_memfd: Fix handling for conversions of MMIO ranges
Date: Wed, 27 May 2026 17:28:23 -0500
Message-ID: <20260527223036.4614-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb8cdc2-3fbc-4207-2393-08debc3fe8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9cPPim/zWg0JSvy2A9xkWG2sXF3AsqX/nlEP8J/Nmrehr+W2bMt3lUJC+RmTbbRmeZo+wSQcQ9s8gZM1zVqQPgNEGoRtvaixMTVDGXjdjus/okUZ6u3d8SkkI0t1OJ0kxahNRDNntdtNT1tZYQsyxIRUEL5XqVREpUkUS9sRR3APy0872SqHUgQ19FpuCdAI4X8MaLDMG6FMhB/l/cMKeBZdoxr1a4vjf22dxHi3XTWkLMHUvHVIfiVuTGaj+NgMvrwvC7s7B+2vKOWuWjKgKEeXM4XDxND9d+T4TaT8bCqqaDaOX1LAIglCfHbIJiN5cDsIYG/RnYf65be8O3agRMG51cZ4kcmV0jdOhgzVYwpae7xXqdi6DmDh3Fq5sYrcRKPM1Gew+Pvj641ZgFQkFwu83UfheqSDXY8RCkqO8tZRSdak729Y7SNA/zDyJEjOuiJVDpdudat47MqrFlmMawz6p81J8mQA1r0rPSGA9sOFdtNYCPr37x6OrQphs+uG+smHaMakpa3teKqw1hgFAvyph4vBWlPPdeDH89sQ2RU4KQV68JA2upl3u57Aw6b4xuq/f9r3GPnnCQIFfP146/Yk2H7OqRV8Wp4zrasfS6MFSXIC4mRHiTVUdhHxha9I1hbaFDJzjVnE40jh+D0LmdDGatf9FcUdr2TFg6UxvxncKX8UmqBXvOROl69p2oZEBNJBAsAz2nokdFvXYCRvwm+G1S4sfEKeTkXdpEW933c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(11063799006)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F9iIktgpInudwFdSHQ09BSdkKwkUv1nApLWPvPQVjSzv3FC1XEKURAYaBzlVwFtKrESyBFkhtfI0CgqLQTJY2wCDrjtbh3/l7RHhyU8vF3NCZ5zOIgUynxQOxW7Q0JDM6eWil3vaCSPFER7Sf0wgyl8B9hXTcBq6PT3Is9SNh/oGI3QFMjE+o/BMpvHbiImaHCbOHWWOWB8uDeSvoaSxNl1Qh4rVTq/Z7hknW72VfgqNIYDyWoKadVbRGiP0bciFTcDg/r0fz1SMv6gTMzU0d1mjv8quETpIoHUww2rJZFi/KZYunS8Pf7VINmPH2Sc6XN2P8xUDv/wMybiD7Q3R5vLo1kMaIapuUQKS/vqPhZlGgdd32nJgjdWwiDgzc7m3/FzOAW7zswNcLZc/Qo8mGfksJs949xLpBVoR2wSEBuPmOGP+Ck8K+Pp4V6wn+kNv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:33:00.5053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb8cdc2-3fbc-4207-2393-08debc3fe8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803
Received-SPF: permerror client-ip=52.101.43.1;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This patchset is also available at:

  https://github.com/amdese/qemu/commits/gmem-fix-mmio-conversions-v1

and is based on top of qemu master (3f89b5de5b)


Overview
--------

Calls to kvm_convert_memory() currently only produce the intended behavior
if the entire range is within an MMIO hole/region, or is completely covered
by a guest_memfd-backed region.

In reality this is not the case:

  1) some ranges contain multiple regions (e.g. multiple guest NUMA nodes
     backed by separate guest_memfd backends).
  2) some ranges contain multiple MMIO holes (e.g. a range that contains
     2 non-adjacent regions, or a single region followed by a hole)

These scenarios bring about multiple unhandled corner cases that this series
is meant to address.

The section-by-section processing is also heavily guided by requirements that
will come about when enabling in-place conversion support (where memory
attribute tracking will move down into each guest_memfd instance and further
require region-by-region processing of each range). That will be posted as a
follow-up series based on this patchset.


NOTES/TODO
----------

- If TDX folks could test this that would be appreciated as SNP guests don't
  seem to trigger some of the original cases that were introduced for TDX
  guests and I only have access to SNP systems atm.


Thanks,

Mike

----------------------------------------------------------------
Ashish Kalra (1):
      accel/kvm: Fix kvm_convert_memory() calls crossing memory regions

Michael Roth (3):
      accel/kvm: Add helper for handling conversions of MMIO holes
      accel/kvm: Fix handling of MMIO holes at start of conversion ranges
      accel/kvm: Fix handling of conversion ranges with multiple MMIO holes

 accel/kvm/kvm-all.c | 167 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 125 insertions(+), 42 deletions(-)


