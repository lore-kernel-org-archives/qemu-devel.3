Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E0CE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4VO-0007RS-8Y; Thu, 19 Feb 2026 08:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manali.Shukla@amd.com>)
 id 1vswv8-0007uO-06
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:49:50 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manali.Shukla@amd.com>)
 id 1vswv6-0000nv-5Y
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:49:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqqybtsqqCbkluDLXewRsIJixwVjp29tRqCY3YKcaLCX69gXiEYLMlZmSyzkmBeXZTa3CNQJxneeOaLr+MsHzbP8EOLsCCs04UfGma0BAjPbjBg+Am38/aqAvpKJdeQh/8LRWUCzTcqScSgTrkj2bXQac0Il0fCPluiIgZz2D2hvo/MAwugx0aOLEVW5B2EQopldHQepQTK65Wn4MmZO7cyeJzcKiv6i+NA+YRbF0+LxqaqnapGOnGEpJOmri571DUEvTzDHz8iJe8x4LB3bg6Xh+w6faOhf08HYBJwTy/zquW14cwOJCf1K07Hb18BHaLC6WLfUtcZr1z7c/HN3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO7V09rGEZ56SC7jbRN64geoWmPhP4S2erwQLV5cj0c=;
 b=O6rfWHuvG9g+tUiDMyY4iMm8MCzKfVairC07Uh5B5hZ/OrKuFaUH8YZ1NN359YfDTHMttm51zQB9SuG0iAaO0wq83W3jBjYpUOcNK/cN1lOrpwFfGyjcUTdeDzoNLKZYzBloLx91UtZUaDICqio3Q8F7hPGBYDmtNAcdR9AdO9E3Y0rzCx0fjtKDqO9DSlkQsp9FRFqQAmsLXkKfc4TUh9Bx57OR98IETcMFVjhzKX21B/ea5Zv3vleUIKqkCG+Y7RkACy6kVVhcpLysVpUFOEuGJREi30q3hutBUDzqVEo/Fh5aarupmP23YbSZFB3TRQHBxMXfTf16LK7oJkcbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO7V09rGEZ56SC7jbRN64geoWmPhP4S2erwQLV5cj0c=;
 b=NcFro5grGNysw9ay2PugmRHay4AXDcpGdJDqTHCieN3Rz87M2946zL+rHHim3WPhhZh1e48byohYh8KzhFUl55vepX4JoDxugGJ/L/Oy2tObqBpvoLW5vQI5UtbHmvAby/aIN604DqiZ/PhdlWxJQDrGgCV5hf31m48lHcmoV1s=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::997) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 05:43:18 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e3) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Thu,
 19 Feb 2026 05:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:43:18 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:43:14 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Marcelo Tosatti" <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Richard Henderson <richard.henderson@linaro.org>, Naveen
 N Rao <naveen@kernel.org>, Nikunj Dadhaniya <nikunj@amd.com>,
 <manali.shukla@amd.com>
Subject: [PATCH v1 0/8] i386/kvm: Add support for extended APIC register space
Date: Thu, 19 Feb 2026 05:41:59 +0000
Message-ID: <20260219054207.471303-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 266b0791-e7de-4f75-5c9c-08de6f79c8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X2Vj3YNWcq1AArrLIXO6L6PJBJaRjGnftMdowfN6p7DHl+cK1nAD2tw1jcBS?=
 =?us-ascii?Q?UMdSiIRxP6mFm2APCt/qin5RyWMzcVOQ3sqbZCsi/FaapvNglCc/MQMsoS7E?=
 =?us-ascii?Q?FKv8IeGMz8IF/9EG42vHZGhQhhZ3f5e+dcqGAcBlqwMIwvFWpSaGLhWbwgdR?=
 =?us-ascii?Q?5j5Y7YckWafQTnfx9pYutQ5PiL5PMgZpT+MjHBfjIVorZvV1CRnc7Mgn6Qxb?=
 =?us-ascii?Q?+F+eNOll6VnNF7gT5CZkm3nzo9+xllP58FMtMq3GAfTKaUObDIWF9P6v0uNl?=
 =?us-ascii?Q?9XeF0vucg6TWLY0+ERAKdtRml0hePizDkenbVBLEGQ/PQNnNPN9FZw0mlJb/?=
 =?us-ascii?Q?xUdvuoAjc4eXyswNjdeudYOKT9phWzE4A5Zi7IWCpU6FbkJYtt/Zf3K50O1z?=
 =?us-ascii?Q?zEvYwziNH02jmKiKxDvhRzvTMzdbFnMIHFGnU7X2+jvhgxsf1IbJG95yc4Sa?=
 =?us-ascii?Q?dQ4U2c4iWN8qs3bEvcWH0tXv6t41G4LNREWhkgf4lKczxf+KdjmXAK/Z1GfB?=
 =?us-ascii?Q?tcRut0i+ryRT+G6iycbUQnqfrU+a/ptj9nvn8h5aNxF7XRYWKilcoISpM9WM?=
 =?us-ascii?Q?hTINTO17nOfQxSm05W5IfeMDpmMMoCEe5bHamRmotEhcS8Q/ye86e3Kd2A7H?=
 =?us-ascii?Q?QloRwXQR6XZPM+1haVE+0JgxfneOw8U8KZnqWkJEzCkIvd9Y8eHBcAI9c/4n?=
 =?us-ascii?Q?F+u9EaYlqQKRXE36YS/BaVlNC8hMoy14dl67Z58fMjEKOo9syG8Khb0RvheG?=
 =?us-ascii?Q?G9ezF2WOTy9KTZhnr9YnndvXRQHkHuD1jPU83iaWXTSRjNWp8PH4R7iNrkrD?=
 =?us-ascii?Q?bfzcbDoOisEm1kM3kT5MV47hOd65vzScRaEtmvQTdltYOTZENhhJ44+9/z0B?=
 =?us-ascii?Q?OhepTEls/LfHjbFyeYCaIxcH/yDkwD73eS/hBH/Xx97tL4lSUBYnOVEe6TL1?=
 =?us-ascii?Q?PI6PhBn0veNaFUNdohCzk1mhsYX44+eun1aenTahX3at/F6SECz6Y13t8hhQ?=
 =?us-ascii?Q?7RORY+3IAEkG/GBYiZ6cwXPBNVzBFOkHjaVluR3/YiDFmb9LPhz1kdu6bLtu?=
 =?us-ascii?Q?K3rTd/myqTrUgTJb6xEVKClNqSFRaKJr4XlZzXOyDHJHbOaMHaIJJcvwMmnm?=
 =?us-ascii?Q?oTq6ZCuOk5NItLRI/Zo3QWc9+sSAZbsrF3JbgbjK4Rpm83rYZUoMw8lKQG1N?=
 =?us-ascii?Q?jl+F0jwDBvuidRjmJhVhqJdrxujSemoVNoi3SFDobPZNswA2LV5FJOqwEMPT?=
 =?us-ascii?Q?mjtKMFCKAyvThiwY8VhoaYO/JWzIWoAH0W4Tcay5+k3Zq9LjuwfYrwcwGF/a?=
 =?us-ascii?Q?ObBbhfbbTmJJJZASwmaL3qcARXpMILFpZ+rN0NDLypIYz38I8T9HJ8Jh8spn?=
 =?us-ascii?Q?eMicfFlf1CO8QgWPMmo9nvXHA6ePkss8OyXJ8i8Vns6YdN7XTJfakvc7Hliq?=
 =?us-ascii?Q?dTNZqBzQ1RzGs6rXk7PeW45kM7r9KCfJaAXRjDL86aHRxEGhn/Vm2/xrTRJE?=
 =?us-ascii?Q?sRB84tHbBXBhx1jjY0dk+IOeZPLyxesTDOTvKMMId4KHxNwOTCFWYvym5PpH?=
 =?us-ascii?Q?1viWXRw3T/O68oDSF86CjF1Gw+M/Eu0iL5Qr/NA4iKDts2JuXl69YZkF6EJY?=
 =?us-ascii?Q?HCufs/e4MleMrsFPdaqe5VCvwjA9Gg1IU3gbwVtggr/yMYGfM5jJpCfi5f7U?=
 =?us-ascii?Q?AoOdLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pha97ftEORhMlciaIgqGAJ5b7v3x49oYBTbkc56HEfKLVDhlBzl7BiXOr4YhV4+TWKcGkXMzZ0u3r+oBfCgkuazdH4mGexSgH7CIjRKH0TAppoB/+FMC1iZJqRnDmOyxdjYIp61ehDdH0UvEiawXbUnZfEO8JRhhDKTCCg0c7gdURie/cF/dY9FiSgpjxYTFQZEUB1pWIOH+1RrKY48+e0Xx5S4sh+5YcyLoDC9+L281kcAwOfUbPcNChrK3ON6nKqjAe/07vB7QBF4AZunu6M3upe411aOxpXvnTmuDfiyZ2KpNvw1cTpm9HrVzM/rQQyWTs0yfDRPOMbsSBPmxURzwYLcDIjEdF+K+FuxZnNnFuV6UpWkt64SaCzEVghfQO4nBLAp5CA5uRe+DffXf9yySHiv0LPs1+NP85yauLtVGzo+D4e3LncIpifnTuzJM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:43:18.5059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 266b0791-e7de-4f75-5c9c-08de6f79c8ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Manali.Shukla@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Feb 2026 08:55:36 -0500
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

Add support for KVM_CAP_LAPIC2, which enables the full 4KB APIC register
page instead of the legacy 1KB register space. The capability uses a bitmask
design to support different APIC extensions:

  - KVM_LAPIC2_DEFAULT: Basic 4KB APIC page support
  - KVM_LAPIC2_AMD_DEFAULT: AMD extended LVT registers within the 4KB page

The base capability (KVM_LAPIC2_DEFAULT) provides the foundation for
exposing the full APIC register space.

AMD processors with the ExtApicSpace feature (CPUID 8000_0001h.ECX[3])
further extend LAPIC space with additional LVT registers starting at offset
0x400. These extended LVT registers provide additional interrupt vectors
for AMD-specific features like Instruction Based Sampling (IBS).

This series implements:

1. Refactoring of existing APIC state functions to use generic pointers,
   allowing them to work with both 1KB and 4KB APIC register spaces.

2. Infrastructure to detect extended APIC support via arch_has_extapic()
   and track negotiated capabilities.

3. Extension of APICCommonState to store AMD extended APIC register state
   (efeat, ectrl, extlvt array) with dynamic allocation based on the
   number of extended LVT entries.

4. Capability negotiation during vCPU pre-creation:
   - Always request KVM_LAPIC2_DEFAULT for 4KB APIC page
   - Additionally request KVM_LAPIC2_AMD_DEFAULT if CPU has ExtApicSpace
   - Enable the intersection of KVM and QEMU capabilities

5. New KVM_GET/SET_LAPIC2 ioctls operating on struct kvm_lapic_state2
   (4KB) instead of struct kvm_lapic_state (1KB), with automatic
   fallback to legacy ioctls for compatibility.

6. New subsection of the vmstate (vmstate_apic_extended) of apic_common
   module is added to make migration of extended APIC registers deterministic.

This series depends on the corresponding KVM patches:
  https://lore.kernel.org/kvm/20260204074452.55453-1-manali.shukla@amd.com/

Patch 8 contains temporary UAPI definitions for testing and should NOT
be merged. These definitions will be imported via update-linux-headers.sh
once the kernel patches are merged.

Testing:
  - Verified extended APIC state synchronization on AMD hardware with
    ExtApicSpace support
  - Confirmed fallback to legacy APIC ioctls on older KVM versions
  - Validated VM migration compatibility
  - Ran migration tests from Qemu to make sure there are no regressions due to
    the changes done.

Repo : https://github.com/qemu/qemu.git
branch : v10.1.0
base commit : f8b2f64e23

Manali Shukla (8):
  i386/kvm: Refactor APIC state functions to use generic register
    pointer
  i386/kvm: Pass APICCommonState directly to kvm_get_apic_state()
  i386/apic: Add extended APIC helper functions
  i386/kvm: Add extended APIC state to APICCommonState
  i386/kvm: Add extended LAPIC capability negotiation
  i386/kvm: Add KVM_GET/SET_LAPIC2 support for extended APIC state
  apic_common: migrate extended APIC fields
  DO NOT MERGE: Temporary EXTAPIC UAPI definitions

 hw/i386/kvm/apic.c              | 123 +++++++++++++++++++++++++-------
 hw/intc/apic_common.c           |  21 ++++++
 include/hw/i386/apic_internal.h |  11 +++
 linux-headers/asm-x86/kvm.h     |   7 ++
 linux-headers/linux/kvm.h       |   7 ++
 target/i386/kvm/kvm.c           |  88 ++++++++++++++++++++++-
 target/i386/kvm/kvm_i386.h      |   7 +-
 7 files changed, 233 insertions(+), 31 deletions(-)

-- 
2.43.0


