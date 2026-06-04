Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD6FCD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 22:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVGlT-0000pE-KB; Thu, 04 Jun 2026 18:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wVGlR-0000p2-9V
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 18:42:13 -0400
Received: from mail-centralusazon11010059.outbound.protection.outlook.com
 ([52.101.61.59] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wVGlO-0005Nj-4G
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 18:42:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXeCSoqMi7GomxcUtR+a0nYIjAAK1cPAP684fdQGNhINaRrelfGKl95J/clVwCQtjdAZlSISpH4ciPAVrYZpPsvy9OXEIg6qpGzWmYBlfWkrQE+LSTZSZKVHTP10umavP0+A2vEZjnE36eDC7riJzzGREXSRlxBicdDd6ahWyrWqZTYB+bh9pes3lXXf3k9LLzACGPAReFAFyyEEqodCDSkmFF3IgmeJUCKX7PsZQyM6CDhGv8AM5tChXsuYZzNNo23yku/Jq30DAa5QTp4IJ5cRbgktljmFPezUmIXkAzoARslLjOF2Nh2+yev6fxQN17x9qMGfydiNdyu7ckfLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i76HvKosNZnntzlx+mKj5RrYNOkvyxS3sHJCdtQZ2oU=;
 b=QRFFrZM/TxSQMEY+T6yOApYLG4E1jQR2V9dwAwOcFYPlzGGP2rBYSYMzKmddzKHipw0wgRGjjr4ObVvGtzNBG3gUWo+0YtOQeflFPnY6EDDy8sFXIYELaJieLgM/f69cdTreUc80IhTNoadNtwbYzt58BHbJuOxCTUgf2WPKeqvqq5XWfHFVLw5L+tOe21XpfZUSCm0RizAX6hktBerF/RCD6FH64LKAq4gLYK2HSxtH3bzjwqlwCnQEp2LopLAr/rV/DoZEnHUxz7zXDvo29Ro1EKhy7nySQk7ldyrMCdKrRaGI4jj9Fmu9MTeRsbZEo+iSLTQgoVaTx7TyCm2RWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i76HvKosNZnntzlx+mKj5RrYNOkvyxS3sHJCdtQZ2oU=;
 b=0cUV7enwA7kICnQUOhn8kQzSWpYJAng2l6uxUEN2sQSYXazQTNf4/+uWpD/ZPankm8vEXcEquisD1QwXCZ1hgJt6BgF4vfRb7pOhii2dU8/BSTwAwF0SEc7SR8fMTFjN5o1UPC8ISjxFIPVCgN0TAC9YKb3B809o/mKfrp0NojA=
Received: from MW4PR03CA0329.namprd03.prod.outlook.com (2603:10b6:303:dd::34)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 22:37:00 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::8d) by MW4PR03CA0329.outlook.office365.com
 (2603:10b6:303:dd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 22:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 22:37:00 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 17:36:58 -0500
Date: Thu, 4 Jun 2026 17:36:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <lpkcfd2crgparcd64ydry3ocryx3sfc5gj5pzrrms4nwvw6j4c@ulc3wa3rmefo>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
 <aiCAFWKEAHkPLCO5@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiCAFWKEAHkPLCO5@x1.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfc9645-af34-405e-fd3a-08dec289cada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|4143699003|3023799007|6133799003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: iHamGyKX3bGnQ/lYfhwxt8cD4Di+UOREE9pHpVieAu1XqCvW5azJlTRHMhUvImfvw6m4XZr9X19XEEYy2fOqLmgFOgCBZb2VL+/m4TITuQLXqzW1ti1pK3hGjfUcyqExg8DrzEG68ooFt/YEiN2izXddcv6BczZpm8wpmWsMdf5GR6rS7yaJFjRhD111bsxUjaxkNRpsnz6x3FYjbHMim53lc8Bfe/MCUjclN4sDr4MovXXRtEHvlcpqRFID+g1+eOMzMjcaV/07EVwXWFJ+YPj5xdgwtKLtVPuU53Stra82HCDYAtmgGG3NKSdUg1zCrXn2cqWnTMcnx4ht+nQU92X2fdkrGcwR+ROQ4/Ny/6Pmqk10/ht/1NzSeYRTpR29ZsrvEZTm3jjz8ji3+WepdD5BAOhaUywDTPFr62F6k2/7mZSXwsxoOzhlfC1TOWI7AausKrxkcLKnNNye7IDTxSvB7rX0kH36SBkguruNg5Ezq0SCBajx/2H6tS156OxSD8bIRpMYcjh0hKHEZlWghSHSpHFW1zJdJO8aRkrIp+sGHwN/NUPYJqWLj13V5D9r2QD4DvLSxZmj5W7CdDQFKwOqouKfmvPqoKDlPvptSGdKxfIlnTKwQ49zxWtpDiJkFPa9FkmGUhmueDtlBGgqvrFxKVnaa3Xa2R6Yb95Yz5Aojsqu8dt979+F/U5S4oJr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(4143699003)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cSku/hjqAe17cFTAxdBSNV4rKgx/AaGhFEbj+5qPWP71VacSw15lR0jDGH0Q+9bOwEJXAcqOf4ckuScvOvpEuiShUg/6eEueDDfpqXYV+PKJVdHWvDP8Hw6hYRn1CKxvLAd+lm4LX4yu51nt0E723eTFrjJ4xgDjcz4+jLmlRS5jKgrVar+qXqqLa9WKarCJGbChrD2dh42EVGBsObuwje3KikCd/dO1q2CXbn/Ju8fjSkX3fh5dmkHZbQAlMeLEjDLcvB/yS+8B3QURm8D9AaExS4br+D1yzB+z4zx4q1KpGj1Yq1e2foZU4WEA0P/Nh6npbDAhMgdD+z1vvWIazUrifSf8zhpDP5RLBzGUAuI/MamzIoFjsinJAhNDkZ7+CCujDK5WOrdWpi8OEfyyDMv4iyShvwI07XQ/NIBpIsAmLvLYjEFYPQo0cD+bsrls
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 22:37:00.1513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfc9645-af34-405e-fd3a-08dec289cada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
Received-SPF: permerror client-ip=52.101.61.59;
 envelope-from=Michael.Roth@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

On Wed, Jun 03, 2026 at 03:27:17PM -0400, Peter Xu wrote:
> On Tue, Jun 02, 2026 at 05:02:29PM -0500, Michael Roth wrote:
> > On Mon, Dec 15, 2025 at 03:51:51PM -0500, Peter Xu wrote:
> > > v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> > > v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> > > 
> > > v3:
> > > - Collect R-bs from Xiaoyao
> > > - Rebased to 10.2-rc3; no dependency needed now, as those got merged
> > > - Reorder patches, touch up commit messages or comments on in-place misuse
> > > - Added patch "kvm: Provide explicit error for kvm_create_guest_memfd()" [Xiaoyao]
> > > - Added one patch for renaming machine_require_guest_memfd() [Xiaoyao]
> > > - Added one patch for renaming memory_region_init_ram_guest_memfd() [Xiaoyao]
> > > 
> > > =========8<===========
> > > 
> > > This series allows QEMU to consume init-shared guest-memfd to be a common
> > > memory backend. Before this series, guest-memfd was only used in CoCo and
> > > the fds will be created implicitly whenever CoCo environment is detected.
> > > When used in init-shared mode, the guest-memfd will be specified in the
> > > command lines directly just like other types of memory backends.
> > > 
> > > In the current patchset, I reused the memory-backend-memfd object, rather
> > > than creating a new type of object.  After all, guest-memfd (at least from
> > > userspace POV) works similarly like a memfd, except that it was tailored
> > > for VM's use case.
> > > 
> > > This approach so far also does not involve gmem bindings to KVM instances,
> > > hence it is not prone to issues when the same chunk of RAM will be attached
> > > to more than one KVM memslots.
> > > 
> > > Now, instead of using a normal memfd backend using:
> > > 
> > >   -object memory-backend-memfd,id=ID,size=SIZE,share=on
> > > 
> > > One can also boot a VM with guest-memfd:
> > > 
> > >   -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on
> > 
> > Hi Peter,
> 
> Hi, Michael,
> 
> > 
> > I'm working on enabling support for this, as well as enabling in-place
> > conversion support for confidential VMs[1]. In my series I added a
> > dedicated memory-backend-guest-memfd to handle using mmapable
> > guest_memfd to back normal VMs (and confidential VMs with in-place
> > conversion enabled on top). Xiaoyao mentioned we had some overlap and
> > potential inter-dependencies between our series so I took some notes
> > on the differences which I've included at the bottom of this email...
> 
> To Xiaoyao: thanks for linking these works, and also thanks for answering
> other question I raised in the separate thread.
> 
> > 
> > But at a high-level I think this series is further along in implementing
> > guest_memfd for normal VMs, and I would plan to just mostly rebase my
> > in-place conversion patches on top of your series. However I think it
> > would be a good idea to go with a dedicated memory-backend-guest-memfd
> > for reasons I outlined in my notes, so maybe this needs to be discussed
> > more.
> 
> To me, it was just natural when working on that to reuse memfd backend,
> because conceptually they're really the same: I guess guest-memfd is named
> as guest-memfd (not guest-special-fd etc.) also because of that.

It's true that it's a 'memfd for guest stuff', but that 'guest stuff' is
becoming a pretty wild set of additional features that I think could lead
to some 'interesting' options that will never have any line-of-sight for
normal memfd's.

> 
> I don't have a strong feeling here, hostmem-memfd.c is tiny so duplicating
> isn't a major concern even if so.  It's just that I don't yet see when gmem
> will become special.
> 
> Say, all of the features that memfd provides can easily be applied to
> guest-memfd either now or at some point later:
> 
>   - hugetlb/hugetlbsize being one of them already, I believe we almost know
>     1G will happen to gmem soon
>   - seal: I don't see why we can't seal a gmemfd too.. maybe it'll come, in
>     general the whole seal concept can apply to gmem too.
>   - cpr support on memfd (or anything about live update in the future to
>     happen on gmem): I believe gmem also want it..
> 
> IIUC it's a matter of if we expect future property of guest-memfd that will
> stop applying to memfd anymore?

Yah, I think that's the main thing to consider. There's a few things in the
pipeline where the options associated with guest_memfd might diverage
quite a bit from memfd:

  - hugetlb: yes, these could potentially use the same options memfd
    uses, and I'm guessing that will end up being the case, but one
    large gap there is that shared memory is always split to 4K, which
    we've accepted for now, but if you consider use-cases like DPDK
    there can still be major performance bottlenecks that would drive
    us to try to enable larger mappings for the shared ranges, and then
    we'd end up with guest-memfd-specific parameters intermix with
    normal memfd options, and our related documentation would need to
    covers these differences case by case
  - DAX-like stuff: there are some proposals for making device memory
    available to use as private guest memory, and since 'guest-memfd'
    is generally responsible for managing private memory, it will
    likely end up being extended to handle this at some point. One
    proposal/PoC[1] would involve at least needing additional options
    for the /dev/dax path, but there have also been discussions about
    having a general notion of custom allocators that can be plugged
    into guest_memfd, and some of these might have overlapping options
    WRT things like hugepages/etc. But at a high-level, DAX would map
    more to memory-backend-file than memory-backend-memfd, so we'd
    already be crossing up some wires there.
  - live update: there's work[2] on enabling preservation of confidential
    guest memory across kexec by preserving it through guest_memfd. This
    one is still a bit mind-blowing to me but I could see us needing
    some additional options here that would really make no sense for
    memfd.
  - directmap removal: these[3] patches allow a new guest_memfd flag to
    be set to unmap guest_memfd pages from kernel directmap to help
    mitigate speculative attacks, probably would involve a new option
    as well that wouldn't be applicable to normal memfds

It could also end up that even memory-backend-guest-memfd is too
generic, and that some of these would involve a more specialized memory
backend where may they can share a common base class for some of the
core guest_memfd stuff but otherwise be separate backends with their
own specific options. So to me, starting off building up
memory-backend-memfd seems like a potential misstep, whereas we don't
really lose much to start with a clean slate.

[1] DAX: https://lwn.net/ml/all/20260423170219.281618-1-dave.jiang@intel.com/
[2] LUO: https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/#r
[3] directmap removal: https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/

> 
> > 
> > I also saw you were open to having someone pick up these patches if you
> > don't think you'll have a chance to get to them near-term, so I'd be
> > happy to pick them up if that's preferable.
> 
> Sure!  Indeed I don't have bandwidth to keep working on this one in the
> near future. Please feel free to pick whatever needed into your series.

Ok, sounds good, I'll pick these up for my next posting and incorporate
any changes/comments that might still be pending at that time.

Thanks for getting things to this stage!

-Mike

> 
> Thanks,
> 
> > 
> > Thanks!
> > 
> > -Mike
> > 
> > [1] https://lore.kernel.org/qemu-devel/20260528000416.8161-1-michael.roth@amd.com/
> > 
> > Comparisons to the above patchset:
> > 
> >   [PATCH v3 01/12] kvm: Decouple memory attribute check from kvm_guest_memfd_supported 
> >     - similar to:
> >         [PATCH 01/12] accel/kvm: Decouple guest_memfd checks from memory attribute checks
> >     - to allow mmap case, both defer error handling to ram_block_add() + RAM_GUEST_MEMFD path
> >     - pros: adds nice kvm_private_memory_attribute_supported() helper
> >     - cons: my patch checks/prints error via kvm_create_guest_memfd(), which
> >       makes it a more re-usable error since ram_block_add() isn't the only
> >       caller.
> >     - IMO, I think we should merge the pros of your patch into my similar patch
> >       and add your Co-developed-by, but also fine to keep yours as-is and deal
> >       with anything else needed as a follow-up patch
> >   [PATCH v3 02/12] kvm: Detect guest-memfd flags supported
> >     - similar to the kvm_supported_guest_memfd_flags / kvm_create_guest_memfd_shared()
> >       additions that are part of:
> >         [02/12] hostmem: Introduce dedicated memory backend for guest_memfd
> >     - This patch could be treated as a common dependency of the above and I can
> >       drop the corresponding changes from my patch
> >   [PATCH v3 03/12] kvm: Provide explicit error for kvm_create_guest_memfd()
> >     - Keep as-is
> >   [PATCH v3 04/12] ramblock: Rename guest_memfd to guest_memfd_private
> >     - Keep as-is
> >   [PATCH v3 05/12] memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
> >     - Keep as-is
> >   [PATCH v3 06/12] memory: Rename memory_region_has_guest_memfd() to *_private()
> >     - Keep as-is
> >   [PATCH v3 07/12] hostmem: Rename guest_memfd to guest_memfd_private
> >     - Keep as-is
> >   [PATCH v3 08/12] hostmem: Support fully shared guest memfd to back a VM
> >     - alternative to:
> >         [02/12] hostmem: Introduce dedicated memory backend for guest_memfd
> >     - pros: re-uses infrastructure from hostmem-memfd
> >     - pros: less command-line changes vs. dedicated hostmem-guest-memfd (less libvirt changes?)
> >     - cons: less flexibility vs. a dedicated backend
> >     - cons: more risk of memfd vs guest_memfd behavior/options diverging over
> >             time and having less commonality (e.g. if hugetlb has special options
> >             we wouldn't need to muddy the existing documentation for normal
> >             memfds or introduce alternative options alongside)
> >     - IMO, a clean state patch only requires ~90 lines of potentially-duplicate
> >       code, and that's offset to some degree by needing less special-casing
> >       throughout hostmem-memfd.c (e.g. this patchset adds 55 lines on top), and
> >       it seems worthwhile given some of the advanced use-cases planned around
> >       guest_memfd (hugetlb, DAX-like functionality, and persisting userspace
> >       across kexec) that might require special handling/options for very
> >       different use-cases than normal memfds.
> >   [PATCH v3 09/12] machine: Rename machine_require_guest_memfd() to *_private()
> >     - Keep as-is
> >     - (all these renames are a nice cleanup/prep and will help a lot with making
> >       in-place conversion handling more readable)
> >   [PATCH v3 10/12] memory: Rename memory_region_init_ram_guest_memfd() to *_private()
> >     - Keep as-is
> >     - (all these renames are a nice cleanup/prep and will help a lot with making
> >       in-place conversion handling more readable)
> >   [PATCH v3 11/12] tests/migration-test: Support guest-memfd init shared mem type
> >     - Keep as-is
> >   [PATCH v3 12/12] tests/migration-test: Add a precopy test for guest-memfd
> >     - Keep as-is
> > 
> > > 
> > > The init-shared guest-memfd relies on almost the latest linux, as the
> > > mmap() support just landed v6.18-rc2.  When run it on an older qemu, we'll
> > > see errors like:
> > > 
> > >   qemu-system-x86_64: KVM does not support guest_memfd
> > > 
> > > One thing to mention is live migration is by default supported, however
> > > postcopy is still currently not supported.  The postcopy support will have
> > > some kernel dependency work to be merged in Linux first.
> > > 
> > > Thanks,
> > > 
> > > Peter Xu (11):
> > >   kvm: Detect guest-memfd flags supported
> > >   kvm: Provide explicit error for kvm_create_guest_memfd()
> > >   ramblock: Rename guest_memfd to guest_memfd_private
> > >   memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
> > >   memory: Rename memory_region_has_guest_memfd() to *_private()
> > >   hostmem: Rename guest_memfd to guest_memfd_private
> > >   hostmem: Support fully shared guest memfd to back a VM
> > >   machine: Rename machine_require_guest_memfd() to *_private()
> > >   memory: Rename memory_region_init_ram_guest_memfd() to *_private()
> > >   tests/migration-test: Support guest-memfd init shared mem type
> > >   tests/migration-test: Add a precopy test for guest-memfd
> > > 
> > > Xiaoyao Li (1):
> > >   kvm: Decouple memory attribute check from kvm_guest_memfd_supported
> > > 
> > >  qapi/qom.json                         |  6 ++-
> > >  include/hw/boards.h                   |  2 +-
> > >  include/system/hostmem.h              |  2 +-
> > >  include/system/kvm.h                  |  1 +
> > >  include/system/memory.h               | 27 ++++++------
> > >  include/system/ram_addr.h             |  2 +-
> > >  include/system/ramblock.h             |  7 +++-
> > >  tests/qtest/migration/framework.h     |  4 ++
> > >  accel/kvm/kvm-all.c                   | 33 ++++++++++++---
> > >  accel/stubs/kvm-stub.c                |  6 +++
> > >  backends/hostmem-file.c               |  2 +-
> > >  backends/hostmem-memfd.c              | 55 +++++++++++++++++++++---
> > >  backends/hostmem-ram.c                |  2 +-
> > >  backends/hostmem-shm.c                |  2 +-
> > >  backends/hostmem.c                    |  2 +-
> > >  backends/igvm.c                       |  4 +-
> > >  hw/core/machine.c                     |  2 +-
> > >  hw/i386/pc.c                          |  6 +--
> > >  hw/i386/pc_sysfw.c                    |  8 ++--
> > >  hw/i386/x86-common.c                  |  8 ++--
> > >  system/memory.c                       | 17 ++++----
> > >  system/physmem.c                      | 37 ++++++++++-------
> > >  target/i386/kvm/kvm.c                 |  3 +-
> > >  tests/qtest/migration/framework.c     | 60 +++++++++++++++++++++++++++
> > >  tests/qtest/migration/precopy-tests.c | 12 ++++++
> > >  25 files changed, 239 insertions(+), 71 deletions(-)
> > > 
> > > -- 
> > > 2.50.1
> > > 
> > > 
> > 
> 
> -- 
> Peter Xu
> 

