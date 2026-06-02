Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C01CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfMv-0005zJ-8L; Wed, 03 Jun 2026 02:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUfMo-0005va-GI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:46:18 -0400
Received: from mail-southcentralusazon11012044.outbound.protection.outlook.com
 ([40.93.195.44] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUfMl-0002RA-Uz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/obftpXuRbCSTW1b4cdsRUWHnCb7ZhZBn02xSjHlazDA0g7ngxdR+KUQQeOW1Dt8iU+IF/OjpY5BCNac70TKsmwslxUi2YeO/aBLEcIvQ7KNOYMm5qrf3+tINdrEYzIAlBeUsri9zMNbwv2n429GFfwWyOoG1/PziAtQBZNDNXj5feBQaOjemf/IUhzXTlxDaEAz5k+D0FjosOYYGUjf6HC8uJLq5p0Z2K9qGv+WQNTR/Boc8YyaPxFBE8ryStXN31A7sZNa4zDRodxaBp0eUzgKnYqQdmuR+LxgIDhKqP+M6qtx80KDiBPBRujlaaWltTmqTJGldkXchpTKoiFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0ZaOnc/u6kdAnddlByIdcfN68PQvkxOlm7m6djFNv0=;
 b=B7zFsAiLKV1oxtFLwzL1oC5d+zhLHCz+yiU2awgvuJMVqUWDaZbb7P74fR9BiI2Wp0+1k2umj9gF430AcJ7Iyyo3B5eAFiCFPl16+55D8Fn8KPWt/a5h0FYixoiTt1X9DWjc76wWC+vJoLX1r2phJEwsLme5e0EshqoKSF3KSFa8lW7kuYdGm4J6ysgX8GMgp92XnuXBLMsmWuWIk54MEkVoBQxnATVV0rbLnt3LumsSb4dEI53Ans2yiPMpO7AwsaDQDbcosQN+Wp7J/4jD3AgyQ47Sc2PuxBG7/k/rUNjLm6KXhKTmL9E1rZ6I8cWcsJgf3ng5sp6q/MVLNR7ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0ZaOnc/u6kdAnddlByIdcfN68PQvkxOlm7m6djFNv0=;
 b=HSTG/mycE+/gSk5t4lSrvPsYCbqUrfGWGunzrxBhE9zJj27l5UOZx+D58yRYQKRCfSItyPA2ad5M9oIjh/pp6PTdHZjmaT4SnEV6v8t2hKIVwmSDBo+L7CTSYqteYW4SYZOldGER09mc96m/AJ8SrzGTn95AL72mOA5wLBJYCF0=
Received: from SA9PR13CA0093.namprd13.prod.outlook.com (2603:10b6:806:24::8)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:41:05 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::65) by SA9PR13CA0093.outlook.office365.com
 (2603:10b6:806:24::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Wed, 3
 Jun 2026 06:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:41:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:41:04 -0500
Date: Tue, 2 Jun 2026 17:20:16 -0500
From: Michael Roth <michael.roth@amd.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>
Subject: Re: [PATCH RFC 00/12] guest_memfd: support in-place memory conversion
Message-ID: <ivlldwe6rllrgq6l3sxr4pifihz3woy56r6ottcuf5476zdl6i@de3fkp3e5kdi>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <04f3184d-58f5-45c3-b5d4-5485e68946ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04f3184d-58f5-45c3-b5d4-5485e68946ae@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: ddac33b5-f2ad-45d4-e1cb-08dec13b167a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|11063799006|22082099003|18002099003|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 5Lgu+WQsfPWFpx+91dJIVahqcHWecQEhEM4o6mqV53+eWXjzXrwYi4+PigJgyQ8EZEGFDRmrVKS3dFMV9Tup7UbM6Xg+7Azh9qMd1thDGXsSJZ/3I1+z/O0lArRKKBlzqjAB4pRQFkAtMgdIbqOUiWG32uYiGs32VumEo0/0+nqF6/XYSl3gr9xZlLPOkzYp/qNO+K2nNWltDrej1f8tdkaJaebiaWE278Gu8GEUFOn1iomyCNS26U4eXLZVc8Y3ULCQWEwVHHhylN2Vbw6Z11yDiOSaYw8DXthI54wd+qU0Y0oE+wNJHm7RPQAiLW0iqJwJKWCuMlNzuBzLKLeQo90OAJiX0TiR6JStcIguNOkfOVhY//flK+ozQigBvprWUjReDTi917qec1GdUbue3nxJGzMA4hxaPqyU/0SloK1fwKmfffbA7EiEBtxYg8dvgM9/AbXwm1/E8KLQJCFVFlwDBBGtOKPVrEz7Am/Z7SbjSB635q80lYZ1ie1CeSsbfn8E+6IxONaTZCSiblZAkyTMOB6WIkSlIZOlrGbj6BJSM3k8615RRPCyH+uZl2+F12AcGT7txsJkSQyoKKp7T5iN1hZP6w8quCIWRwCn+Vw188wPtkF5WZ1idWCL0qkz1Mkj9PYAqCZQMf2AqlRUcfkwLVZHx/yU2SldNlVVUGT/Mu44jMEXQe5WWqPJV7ajfUMxvvgQGW6nxhVkX8dQyfFiLXHUKqGB/6Hx1lc1LfQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LizsSvXcGfYDLHpwrbqQqPYBjA5t8MpkDeniTbr1HKFfVCZV6Tnxn459p/X8BlH4wlrp0sd3NrVAYIdlXLLPPctZGHArcSsBq25ZP0UC8oIxAwu6DMMCvvymx//2kwRPsSLoVUHnOS9lqmJbfwGfRgt41FQfgAUdxJKsFtdZHc/1pzHXIvjxYoLvfyKIi8sA5V6R5FSFM3GjfOVYNhZP61ltYhTZPMu0MczmNsZ8oRn5xk02u18GNRPz505+VOulQGONeWewD06SD/0R+1NGj76NlUDbtfcI02NdZ4/RAst+4Da3UBm6/t5ETb/nJmH6GUczpo0locP/M6L9sk6hwMquhbpSvni2diBr08O3i4nCz/LdTUbRLnatZS6cVJGw6Lsqo0BH8+FiBwuy4NyjIYUJF1ZypOKOClwmexIoBAC0OXy15898RRZInO7oJFRX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:41:05.6909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddac33b5-f2ad-45d4-e1cb-08dec13b167a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF
Received-SPF: permerror client-ip=40.93.195.44;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, May 28, 2026 at 01:44:39PM +0800, Xiaoyao Li wrote:
> On 5/28/2026 8:03 AM, Michael Roth wrote:
> > This patchset is also available at:
> > 
> >    https://github.com/amdese/qemu/commits/snp-inplace-rfc1
> > 
> > which is in turn based on the following series:
> > 
> >    [PATCH 0/4] "guest_memfd: Fix handling for conversions of MMIO ranges"
> >    https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg07547.html
> > 
> > 
> > OVERVIEW
> > --------
> > 
> > This series adds guest_memfd support for in-place conversion of memory
> > between private/shared, and enables it for SEV-SNP guests. It is based
> > on recently-added kernel support for mmap()-able guest_memfd
> > instances[1], which allow it to be used for shared memory, and the
> > following patchset[2], which adds additional guest_memfd interfaces to
> > allow it to be used to perform in-place conversion:
> > 
> >    "[PATCH v7 00/42] guest_memfd: In-place conversion support"
> >    https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
> > 
> > That series also introduces a new 'vm_memory_attributes' KVM
> > module option, which sets whether memory attributes are tracked
> > VM-wide by KVM (vm_memory_attributes=1: the existing 'legacy' mode),
> > or per-guest_memfd instance (vm_memory_attributes=0: the new mode
> > which allows for in-place conversion). The latter is intended to
> > eventually deprecate the legacy mode, at which point in-place
> > conversion would become the primarily-supported mode.
> > 
> > 
> > MOTIVATION
> > ----------
> > 
> > Today, SEV-SNP guests (and other CoCo VM types using guest_memfd) keep
> > shared and private memory on separate physical backings: a userspace
> > memory-backend object for shared pages, and a kernel-allocated
> > guest_memfd file descriptor for private pages. KVM_SET_MEMORY_ATTRIBUTES
> > flips which backing the guest sees for a given GPA range, and the old
> > backing is typically discarded / hole-punched on conversion to avoid
> > doubled memory usage.
> > 
> > That model works, but has a number of downsides that impact certain
> > use-cases:
> > 
> >    - Each conversion involves discarding pages on one side and faulting
> >      them in on the other, which incurs allocation overheads in the
> >      host kernel for every conversion.
> > 
> >    - Some use-cases, like pKVM[3], rely on memory isolation rather than
> >      encryption and rely on in-place conversion to pass through things
> >      like secured framebuffer memory without needing to bounce data
> >      through separate shared/private HPAs, which would introduce
> >      unacceptable latency for that sort of workload.
> > 
> >    - Hugetlb support[4] for guest_memfd will rely on it, since things like
> >      1GB hugepages with a mix of shared/private sub-ranges would generally
> >      require 2 1GB hugetlb pages to remain available to handle shared vs.
> >      private accesses, which quickly causes doubling of guest memory usage.
> > 
> > Recent kernel work[2] makes guest_memfd mmap()-able and lets the *same*
> > physical pages be used for both shared and private states for a given
> > GPA range, allowing the above pitfalls to be naturally avoided.
> > 
> > This series wires that support up in QEMU.
> 
> + Peter,
> 
> Peter had the series[*] to enable the mmap() of guest memfd and allow it
> serve as unencrypted memory for VMs. I believe there are some overlapped
> efforts.
> 
> [*] https://lore.kernel.org/qemu-devel/20251215205203.1185099-1-peterx@redhat.com/

Thanks, I wasn't aware of that series but it definitely seems like a
good idea to take that for base mmapable guest_memfd support for normal
VMs and then rebase my inplace-conversion / confidential VM patches on
top.

I do think it would be a good idea to introduce a dedicated backend
however. I brought up the discussion in that thread, but I think that
mostly only calls patch #2 from this series into question and most of
the other patches still seem like they'll be needed for confidential
VMs.

Thanks for pointing this out.

-Mike

> 
> > 
> > DESIGN
> > ------
> > 
> > A new dedicated memory backend, memory-backend-guest-memfd, allocates
> > its memory via a guest_memfd file descriptor obtained from KVM with
> > the GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED flags.
> 
> A quick feedback:
> 
> The design choice from Peter's series was to extend the current
> hostmem-memfd backend to support guest-memfd instead of a new dedicated
> backend.
> I think we need to evaluate the pros and cons of each other, and make a
> choice.
> 
> (I will go read the other part later and provide more feedback)

