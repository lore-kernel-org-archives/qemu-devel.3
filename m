Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B865CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 00:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPAQp-0003jv-Mk; Wed, 03 Jul 2024 20:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sPAQm-0003j1-Ed
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 20:34:36 -0400
Received: from mail-bn8nam12on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2418::615]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sPAQj-00022s-Cb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 20:34:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI2VKce8rlhkGhz9UvbOIHb4uC5Wa5z+ZtEw5DxMLIoHUu+WKwMURd32wWDwzuwtRpr40LCPdelu5L13Waf+ESUa712/nH6xlQ/FA8JrJjrbexumc5S6aA1eVFJSkqqhnljsn1ApGqvGpEhkTl6OW9G7yKazX3+Kk16YZVwt5wFP9gNP0FcHAYKxrL4Sl04ZVz8KtUL/FZ7gWu2iOZnZ49jru3735hc0/qrf8+hcbJJZhMqfQJ8z0yeLkgMS4WxO96hWjlD4EuBSHeD1YXOkdbuG/dPPMFtcnkrZ5KPibm2Ybn0Xv5fdUApsX2vh5qU8a8Mq+YZsXsFtqITxT0elEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEbpIYn5Ijx7TrqJVMW0ivRJIIPdwv148hG1VbV1F3I=;
 b=QrMCI7f78sqmfcX4z6JR2WEu9fwcJWpwnLBcUnV3fHnVTCFPQ4Typg76iptrflneg+gfdsFcsQqqje0w4czPBzXiGNmH1lz7mMGGseJmf7tMFxO+DY58vKy1Jot85pN2NycWW+xE1aPJKlHmsAIHAvcg/qEW5j5H9jX2XYckYx0M/YaHCP1vxg2ETBbvNlSviOv/IdafPVHB6pAmCUueid0uEyZUiEhBxtxEPgQ4j0OxVqKTc3sizTnuWhFOZc6PAs/w27LW4OXFnznEuEyEmWFWnmLCJj6P0Q9m8ke2ZsCFLTAStzS2Nu233rFVStmfqlyL0TlPBiqb76ZRdDPgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEbpIYn5Ijx7TrqJVMW0ivRJIIPdwv148hG1VbV1F3I=;
 b=E8v5t5/f+uvVlnZpV8QyM6UQr5+snIdjG/YeTs5PkTjlLdRifv4li8uIlo8MYQWH0hOjAiFteyGyvD+FSArAQQQqpNK6wSxnoYeWfBZjB379DE7g67Y0PxId4Ta8n8q0QNHC6lSIN9W19L80C1Qg4Bm2lRJX55lAzep8uURtrhQ=
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 00:34:25 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::39) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Thu, 4 Jul 2024 00:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 00:34:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 19:34:24 -0500
Date: Wed, 3 Jul 2024 19:34:06 -0500
From: Michael Roth <michael.roth@amd.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Pankaj Gupta <pankaj.gupta@amd.com>, <qemu-devel@nongnu.org>,
 <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <pbonzini@redhat.com>, <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, 
 <berrange@redhat.com>, <kvm@vger.kernel.org>, <anisinha@redhat.com>
Subject: Re: [PATCH v4 20/31] i386/sev: Add support for SNP CPUID validation
Message-ID: <20240704003406.6tduun5n25kgtojf@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-21-pankaj.gupta@amd.com>
 <ce80850a-fbd1-4e14-8107-47c7423fa204@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce80850a-fbd1-4e14-8107-47c7423fa204@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 647e99e0-e7cd-45d6-ca31-08dc9bc10e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5BULsSYLPr0xsKtNne7FavOnrLTYqHKVKCCSRSBwFnqrA6UdP6ygu21vDN9j?=
 =?us-ascii?Q?Jny08TwstMSS3Q8Q4CmvpZEMofRUUjNrr1UrybGwOroLqfgJRtqY95BoV9Eg?=
 =?us-ascii?Q?rUiDN5TNivShOjwaBn8n5rSFDpHWJ4/kNg7uHkMuaJ2TH6dStLmnULPkOI07?=
 =?us-ascii?Q?9U4xJ+lnshrS+YDONY6hYkcg1TehRmX4TL7fq3l5eM71T+tlqNvLcjtVaPJC?=
 =?us-ascii?Q?XSEEcwUcEmydwgyG009p180gJSPcuXT/4bm0BYpuPrWidWmHhry670fmcG0V?=
 =?us-ascii?Q?3mUv7y2cN2++fKKq26d9Vm1XQarcMlkkh6DG4MG+TcdxIyivQVRc43sRQL33?=
 =?us-ascii?Q?KTkKiGRw/RlxxOqS6G3ztaDNy/98MEL6UqfmfHlbu3VoTw4cUbfJn8xmN7DE?=
 =?us-ascii?Q?lvlTeX/cctAx/T7e1psd+XBk31r456vaMmOayHX1y+D2DcngydcRqYvKdaak?=
 =?us-ascii?Q?sR+fiLZ52wYnGbb2wCkYzlM7XpH5a9sX2JPDz3qmcP9LRe5BZ/Iw0yernsVz?=
 =?us-ascii?Q?8fFROeXu0KEXDKsy0C1VFWlBdV3JpXk4+QNo3G3UgQNlO1IeZkagRS4ltIbr?=
 =?us-ascii?Q?5V4ZQxATV+snd4l9yYyQotN6rTo+tVl3opuBjrJw+Jyf+y5oHlBkSIF9NF4M?=
 =?us-ascii?Q?zqWn7w+/+QOIbfgubqvmhQWsK6ZwhQg8igWzuKdbNJ1Q/sQHDZYHEa/Mxy3Z?=
 =?us-ascii?Q?uw4xO+RqMgT7YhGngu7HHnqoyjPz2NDg02G42kD8RNvvDDB6dzAbMM+Dr1n7?=
 =?us-ascii?Q?fHr0oiNYN7gf/M6NJHllHo4+Xb3KWfsKCkpv9Cxhy6BKTAnFNZmRu6FVv/Gj?=
 =?us-ascii?Q?zOi3x6T+N9FwEFSk4zv2EQeC6MnyBJGPYTH4U5rPO7lrNUbg7RfgNDU8xba0?=
 =?us-ascii?Q?QqsSL+84b1dMQDbxyVuoZwhdf4TwALrEj55RS8cwJb9JSzdXWeczt/aqUUId?=
 =?us-ascii?Q?mtU2BZCequ2wDLB/pIlLaR8AryUm1Z6WxuN/GhV7S5IN9viihayhIeXOZlRs?=
 =?us-ascii?Q?qRhRZsF1fXXZsqY1mXL8rZOheMyJip1BGjZjxoAJ68Pzn2Vo/OcSwIPv9+z/?=
 =?us-ascii?Q?vKhTy4G95qKqO2pwAW/FbGxF807kZdVPmDRMp/zAq8X+ta+JGbbVY1671/7O?=
 =?us-ascii?Q?FtdIumltZg2VoHUxr/mt7RwxI0eDOrXQSXl2FV0JlhswYcLuxSNJSyFV1Fdz?=
 =?us-ascii?Q?JuzpUM1cJZCvfd89z9qQ5pK0OV9gcld6pQkjMEkV5mKbqFFTkqk4FHbUThE7?=
 =?us-ascii?Q?DNoH7/0UGXTh9ouDVuJpMUs4iFWstdgeppYw0TpHulFqz/rT9VHxk1TfDpGp?=
 =?us-ascii?Q?vjATW/JSr4H9UitzuOU6rFCdxkfP2JEvsSMuZaEA0B5vJWMgqjAn/wkcY7NY?=
 =?us-ascii?Q?mXs9q/zAdJtQVE04UcxBCQJ+JKbdFojmwtT7bA7FDlUhh48+Ll7+n4U1XxqH?=
 =?us-ascii?Q?Gt1DGsAQmRdw93/6vSAUrAUVhHh3512M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 00:34:25.0826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647e99e0-e7cd-45d6-ca31-08dc9bc10e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
Received-SPF: permerror client-ip=2a01:111:f403:2418::615;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 02, 2024 at 11:07:18AM +0800, Xiaoyao Li wrote:
> On 5/30/2024 7:16 PM, Pankaj Gupta wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > SEV-SNP firmware allows a special guest page to be populated with a
> > table of guest CPUID values so that they can be validated through
> > firmware before being loaded into encrypted guest memory where they can
> > be used in place of hypervisor-provided values[1].
> > 
> > As part of SEV-SNP guest initialization, use this interface to validate
> > the CPUID entries reported by KVM_GET_CPUID2 prior to initial guest
> > start and populate the CPUID page reserved by OVMF with the resulting
> > encrypted data.
> 
> How is KVM CPUIDs (leaf 0x40000001) validated?
> 
> I suppose not all KVM_FEATURE_XXX are supported for SNP guest. And SNP
> firmware doesn't validate such CPUID range. So how does them get validated?

This rules for CPUID enforcement are documented in the PPR for each AMD
CPU model in Chapter 2, section "CPUID Policy Enforcement". For the
situation you mentioned, it's stated there that:

  The PSP enforces the following policy:
  - If the CPUID function is not in the standard range (Fn00000000 through
    Fn0000FFFF) or the extended range
    (Fn8000_0000 through Fn8000_FFFF), the function output check is
    UnChecked.
  - If the CPUID function is in the standard or extended range and the
    function is not listed in SEV-SNP CPUID
    Policy table, then the output check is Strict and required to be 0. Note
    that if the CPUID function does not depend
    on ECX and/or XCR0, then the PSP policy ignores those inputs,
    respectively.
  - Otherwise, the check is defined according to the values listed in
    SEV-SNP CPUID Policy table.

So there are specific ranges that are checked, mainly ones where there
is potential for guests to misbehave if they are being lied to. But
hypervisor-ranges are paravirtual in a sense so there's no assumptions
being made about what the underlying hardware is doing, so the checks
are needed as much in those cases.

-Mike

> 
> > [1] SEV SNP Firmware ABI Specification, Rev. 0.8, 8.13.2.6
> > 
> 

