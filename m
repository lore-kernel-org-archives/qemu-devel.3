Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BECCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUXDx-0000Uw-3m; Tue, 02 Jun 2026 18:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXDv-0000Tv-RL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:04:35 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXDt-0007AR-5B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvhFva4/kioqnfDLCL559nE/LXYIAEIX8iTiXeHBy45+0pgIme6F55zhk1GasDOj+w8D5RiX3Qe5IfSYwHwY+QHTGTB4gDbDJCKkgJWnVKBDQhPsxdvsTSvr5Lz4yYgdztmG1skUXGBbrZwcwXCeniooeJSJqSKEHTPzJd3VRGiHsgYmh9l1ULTywFmlVGlxGZ1kupHs7z85f2fc8vFQQF8uOUZOZksgDUiDhFT7vBzoiKXovyCsumDNSVRp28+2yc2rAjNSzyVODa6cqhmtYwa8ikN21bB9Y+m3c432uvpnADvbiFdvM++d4pkd5ZddH6Rv7uHW2uL4+TAhL46HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntg/PIPoxKrneDHmt4qF231DwvHKoZppKhEMBhhQ7zo=;
 b=lI2qwq85eM33v/U5/3FzpW48wR8B8iLjlELi7QWTJmZHYUZz1aUH3eSmWCG5EeuIPRPVwe0gXL1SoSuCtM8mcS+2xAUee1I+8fBzEAkvgxVc4346XldvuVqgrYMtmdwiVkJZELH4wypWDh6rzI1v3rzJOvnEBMbNCmHxQ+j7odinCmGTW901rjzHpxTP/q24Og72cCwI4xb6dLn1Hs4uwVVgtLR2zo0GInLCSaAK1bBVNw/v9ByXv7XnE3G8jEYUXv3o+B5fSTGvHVcJkVLoJvi+LW9Q+d5NW4JXkLHQEaWZv0tU2bBmSyFXVZirbVqQlVsJSdREkhmS/dh9GhDFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntg/PIPoxKrneDHmt4qF231DwvHKoZppKhEMBhhQ7zo=;
 b=KXiGZiH+jw9US8fgIS+4UnWMKbhhtissFtUn9e9eNJu6LMy7HsXmITj30pnaRup6Aq2WSEldSV0ke03XEMlPI+qgiHtjc9ddynmPTApltUMoO6qSvG63ySzBL1d7LUsYDdAKcp2SwjgYhIukeRMK5z1IyS9EdI0/HJp+0LWFcv4=
Received: from PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::6)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 22:04:26 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::35) by PH5P222CA0006.outlook.office365.com
 (2603:10b6:510:34b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 22:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 22:04:25 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 17:04:25 -0500
Date: Tue, 2 Jun 2026 17:02:29 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 133bf528-7364-4fd1-0b3e-08dec0f2e8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|30052699003|1800799024|376014|13003099007|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: O2Q2TMUZQT/wGw0kdnobxLhZqZ1wvDV5pZpw0870aQ1wfzSyzn+PsNTusiAM6cpEjGci+1TSjt1khaZbAM0WOklTO6u8fPnhHzoAr0WysA+AbeMvq2dSqaN2+ths3F7E7SXy8DJx4ieoDDBDCu0UMgpZ4m5e7BglgoXEGqNSwarPVbEvYfisdbpF8nukiOHKl77uxPzEZgIFGp9XpF1B1My1RWcITcjCQsAvfL7xcq4k9YCHetg977AjZCzgcMk1OoTWqP7dKD5RRRdEVVuC/5UyDMQMcJyt1pBRjMFdFWJ6dzjujq5zJTVVZSVTr68MVyL7/PqgurijJuXzzS83iT7K8W9p/X2YelviLsuFrtEv7ekU6a+ehJs/njtWkgySeKb0+I+Gd1EWiuHH1cY3HWyqL6gNQwI58RsEjDbBoR+lUleDnmPKi9aKiIoJgkTuCkuA3uD+dIKXG+75/1GzO63cZTYAoNQXaDtm5X4DKQNzdVL3MuiHxTZDPnWV8Uicu2+iL7s328q8eXn45CsUoVmIlO/QpBOXod8GfHi3KB24RSFAeiwpTm0/7GOFURlTzE6rlnaHcEHt9obMZgtraToYM6acqNjOEOCKWFVuVng70lCq6/G5uG7BZsJGCKi1ULHq3IjV2YpSgk/XPsqyYcLl2r1quIjSet/FljsaWXDc1LmKA6QgstiFXva7dDmyJlpdL2jcl9RCtjX9E2E8c1KwetmoKLgvTzoYZim1vjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(30052699003)(1800799024)(376014)(13003099007)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GyRlOM3dmWJp1i4KS9Znl9zWLfMDSSZwnEg3SiDXToZEoFlbX1sxokrkSaIdiOiPrnGL6kzSQWu28tomavoMvwbTJPnGQKiXOaEmB+n8xhbFxXtckzuv3u6Z40oOkZhKjOp9LD02b3iL83haB5ypRWs5qGsvSBx7TgA+1nWSKAgy8wekiwgcmRF7fu99pWx7DOJ9oj5GUN3G/1YEuSnOTvwMWOwvLDmGk9W0Svdm1jAappmFxkdzdq9AXOIrQUT2ZoZEhZVE4EYL5G85ZTfkprZpxXcNekDJo0ew4QkwW0YIqefP1rpDJ28go7ijGAp4dAxzCSQMtM9UAQsAE/bNkp3sMPcoiqZ/tVYbuofH9q/yv8e5NFXink9VJskjuL8WjjLkyc00FiBFpMN4TCOGGm+uITTe56+JXpJpfW1Q1T3CiGz0TkoEz6HrqGpr7/RI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 22:04:25.4450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133bf528-7364-4fd1-0b3e-08dec0f2e8e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Michael.Roth@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Dec 15, 2025 at 03:51:51PM -0500, Peter Xu wrote:
> v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> 
> v3:
> - Collect R-bs from Xiaoyao
> - Rebased to 10.2-rc3; no dependency needed now, as those got merged
> - Reorder patches, touch up commit messages or comments on in-place misuse
> - Added patch "kvm: Provide explicit error for kvm_create_guest_memfd()" [Xiaoyao]
> - Added one patch for renaming machine_require_guest_memfd() [Xiaoyao]
> - Added one patch for renaming memory_region_init_ram_guest_memfd() [Xiaoyao]
> 
> =========8<===========
> 
> This series allows QEMU to consume init-shared guest-memfd to be a common
> memory backend. Before this series, guest-memfd was only used in CoCo and
> the fds will be created implicitly whenever CoCo environment is detected.
> When used in init-shared mode, the guest-memfd will be specified in the
> command lines directly just like other types of memory backends.
> 
> In the current patchset, I reused the memory-backend-memfd object, rather
> than creating a new type of object.  After all, guest-memfd (at least from
> userspace POV) works similarly like a memfd, except that it was tailored
> for VM's use case.
> 
> This approach so far also does not involve gmem bindings to KVM instances,
> hence it is not prone to issues when the same chunk of RAM will be attached
> to more than one KVM memslots.
> 
> Now, instead of using a normal memfd backend using:
> 
>   -object memory-backend-memfd,id=ID,size=SIZE,share=on
> 
> One can also boot a VM with guest-memfd:
> 
>   -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on

Hi Peter,

I'm working on enabling support for this, as well as enabling in-place
conversion support for confidential VMs[1]. In my series I added a
dedicated memory-backend-guest-memfd to handle using mmapable
guest_memfd to back normal VMs (and confidential VMs with in-place
conversion enabled on top). Xiaoyao mentioned we had some overlap and
potential inter-dependencies between our series so I took some notes
on the differences which I've included at the bottom of this email...

But at a high-level I think this series is further along in implementing
guest_memfd for normal VMs, and I would plan to just mostly rebase my
in-place conversion patches on top of your series. However I think it
would be a good idea to go with a dedicated memory-backend-guest-memfd
for reasons I outlined in my notes, so maybe this needs to be discussed
more.

I also saw you were open to having someone pick up these patches if you
don't think you'll have a chance to get to them near-term, so I'd be
happy to pick them up if that's preferable.

Thanks!

-Mike

[1] https://lore.kernel.org/qemu-devel/20260528000416.8161-1-michael.roth@amd.com/

Comparisons to the above patchset:

  [PATCH v3 01/12] kvm: Decouple memory attribute check from kvm_guest_memfd_supported 
    - similar to:
        [PATCH 01/12] accel/kvm: Decouple guest_memfd checks from memory attribute checks
    - to allow mmap case, both defer error handling to ram_block_add() + RAM_GUEST_MEMFD path
    - pros: adds nice kvm_private_memory_attribute_supported() helper
    - cons: my patch checks/prints error via kvm_create_guest_memfd(), which
      makes it a more re-usable error since ram_block_add() isn't the only
      caller.
    - IMO, I think we should merge the pros of your patch into my similar patch
      and add your Co-developed-by, but also fine to keep yours as-is and deal
      with anything else needed as a follow-up patch
  [PATCH v3 02/12] kvm: Detect guest-memfd flags supported
    - similar to the kvm_supported_guest_memfd_flags / kvm_create_guest_memfd_shared()
      additions that are part of:
        [02/12] hostmem: Introduce dedicated memory backend for guest_memfd
    - This patch could be treated as a common dependency of the above and I can
      drop the corresponding changes from my patch
  [PATCH v3 03/12] kvm: Provide explicit error for kvm_create_guest_memfd()
    - Keep as-is
  [PATCH v3 04/12] ramblock: Rename guest_memfd to guest_memfd_private
    - Keep as-is
  [PATCH v3 05/12] memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
    - Keep as-is
  [PATCH v3 06/12] memory: Rename memory_region_has_guest_memfd() to *_private()
    - Keep as-is
  [PATCH v3 07/12] hostmem: Rename guest_memfd to guest_memfd_private
    - Keep as-is
  [PATCH v3 08/12] hostmem: Support fully shared guest memfd to back a VM
    - alternative to:
        [02/12] hostmem: Introduce dedicated memory backend for guest_memfd
    - pros: re-uses infrastructure from hostmem-memfd
    - pros: less command-line changes vs. dedicated hostmem-guest-memfd (less libvirt changes?)
    - cons: less flexibility vs. a dedicated backend
    - cons: more risk of memfd vs guest_memfd behavior/options diverging over
            time and having less commonality (e.g. if hugetlb has special options
            we wouldn't need to muddy the existing documentation for normal
            memfds or introduce alternative options alongside)
    - IMO, a clean state patch only requires ~90 lines of potentially-duplicate
      code, and that's offset to some degree by needing less special-casing
      throughout hostmem-memfd.c (e.g. this patchset adds 55 lines on top), and
      it seems worthwhile given some of the advanced use-cases planned around
      guest_memfd (hugetlb, DAX-like functionality, and persisting userspace
      across kexec) that might require special handling/options for very
      different use-cases than normal memfds.
  [PATCH v3 09/12] machine: Rename machine_require_guest_memfd() to *_private()
    - Keep as-is
    - (all these renames are a nice cleanup/prep and will help a lot with making
      in-place conversion handling more readable)
  [PATCH v3 10/12] memory: Rename memory_region_init_ram_guest_memfd() to *_private()
    - Keep as-is
    - (all these renames are a nice cleanup/prep and will help a lot with making
      in-place conversion handling more readable)
  [PATCH v3 11/12] tests/migration-test: Support guest-memfd init shared mem type
    - Keep as-is
  [PATCH v3 12/12] tests/migration-test: Add a precopy test for guest-memfd
    - Keep as-is

> 
> The init-shared guest-memfd relies on almost the latest linux, as the
> mmap() support just landed v6.18-rc2.  When run it on an older qemu, we'll
> see errors like:
> 
>   qemu-system-x86_64: KVM does not support guest_memfd
> 
> One thing to mention is live migration is by default supported, however
> postcopy is still currently not supported.  The postcopy support will have
> some kernel dependency work to be merged in Linux first.
> 
> Thanks,
> 
> Peter Xu (11):
>   kvm: Detect guest-memfd flags supported
>   kvm: Provide explicit error for kvm_create_guest_memfd()
>   ramblock: Rename guest_memfd to guest_memfd_private
>   memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
>   memory: Rename memory_region_has_guest_memfd() to *_private()
>   hostmem: Rename guest_memfd to guest_memfd_private
>   hostmem: Support fully shared guest memfd to back a VM
>   machine: Rename machine_require_guest_memfd() to *_private()
>   memory: Rename memory_region_init_ram_guest_memfd() to *_private()
>   tests/migration-test: Support guest-memfd init shared mem type
>   tests/migration-test: Add a precopy test for guest-memfd
> 
> Xiaoyao Li (1):
>   kvm: Decouple memory attribute check from kvm_guest_memfd_supported
> 
>  qapi/qom.json                         |  6 ++-
>  include/hw/boards.h                   |  2 +-
>  include/system/hostmem.h              |  2 +-
>  include/system/kvm.h                  |  1 +
>  include/system/memory.h               | 27 ++++++------
>  include/system/ram_addr.h             |  2 +-
>  include/system/ramblock.h             |  7 +++-
>  tests/qtest/migration/framework.h     |  4 ++
>  accel/kvm/kvm-all.c                   | 33 ++++++++++++---
>  accel/stubs/kvm-stub.c                |  6 +++
>  backends/hostmem-file.c               |  2 +-
>  backends/hostmem-memfd.c              | 55 +++++++++++++++++++++---
>  backends/hostmem-ram.c                |  2 +-
>  backends/hostmem-shm.c                |  2 +-
>  backends/hostmem.c                    |  2 +-
>  backends/igvm.c                       |  4 +-
>  hw/core/machine.c                     |  2 +-
>  hw/i386/pc.c                          |  6 +--
>  hw/i386/pc_sysfw.c                    |  8 ++--
>  hw/i386/x86-common.c                  |  8 ++--
>  system/memory.c                       | 17 ++++----
>  system/physmem.c                      | 37 ++++++++++-------
>  target/i386/kvm/kvm.c                 |  3 +-
>  tests/qtest/migration/framework.c     | 60 +++++++++++++++++++++++++++
>  tests/qtest/migration/precopy-tests.c | 12 ++++++
>  25 files changed, 239 insertions(+), 71 deletions(-)
> 
> -- 
> 2.50.1
> 
> 

