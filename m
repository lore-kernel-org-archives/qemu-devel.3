Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB8FCD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZICI-0003w4-Tf; Mon, 15 Jun 2026 21:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wZICB-0003op-Fx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:02:28 -0400
Received: from mail-westus2azon11010039.outbound.protection.outlook.com
 ([52.101.46.39] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wZIC7-0002TN-Q4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T08VPWMMJ1TR3XVZZgJZLQywtvg8za5qj+MvV1it+XDNEgJKpg00M6bZglRCncnL4qqxEjuPLSSWGXPg9u9Bt//nxwuPnkFevQjSNHixcgHy/c13cwjvWIjstOJ6TQ+z+Ag9r7pMuO8usNpxz1iqebGmmeYHDxAHsyY5SvNdbaYU+BY3Hl6eLro/nVp3aBOyDQlY7KsKxCRDsFhHq40QkH/8L/7vLZ9PMyzLIqtBPIdz5sLAcrmQPbRIa/t7epCn60b0249Fs/afelW46cdB9/NEtfHK70DHC6cBoXP9cl+PmZpqVUe5Gk/01u2sxDdsOb5PXhUdjkJpiMP2qvZ6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epW3gPVDMElEbTjy9b8dqrK9hUMRmsm/0kkzpAos9yU=;
 b=o7t+sLipKJ8h5zsRIKa1nZs/dePUE9vWLBz5QLH0hOdkBdJyXISSkaQGQI7TdBxtVrIyQkRhpLoqHpaGwKBhZn9woBUU8eiUF4QbiijC/W3lLkdRR73hKml31crIJdj3uTNjf2FH2q7QLDMvClc66oqgXymtQPzxsJpd/yKJD2ehVUDwgoNAV2SofW/C0AIeHOLeTi2crqNdit+lyw8hkmmRqQjhL0S+U2Ef+0NwQId9o5pQjT66Z1P4Ryzko6pYtdtH+pbqsqdPrNRlAv9IdPX/TncmMFx1xYY5r5NEzZUdHCVCWSgGJ0/Z6GCAS/n82e1LTECA6jeAJsxv8tTYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epW3gPVDMElEbTjy9b8dqrK9hUMRmsm/0kkzpAos9yU=;
 b=a7eQUS3X8sNGUWl0LuRDxkaCJPH2BouojNlPkaZRIOtWDicEF1r9BtiIF7Oi+4VfoSlkshfN3fMMpVUzWj0eaTlSx5hwxH5j2+BVSAWTYiYoA+ASeh8IOBSCOPnc7SGuWiICAxxgebX2Lj95ycf9rsWYlNaSgcPqDixlk4uB1kE=
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 00:57:13 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::72) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 00:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 00:57:13 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 19:57:11 -0500
Date: Mon, 15 Jun 2026 19:56:57 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <4ypizualim2vacvyconsmyfyliqeqxcnq7csydboj7tvlphs3n@q3prmny6h72o>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
 <aiCAFWKEAHkPLCO5@x1.local>
 <lpkcfd2crgparcd64ydry3ocryx3sfc5gj5pzrrms4nwvw6j4c@ulc3wa3rmefo>
 <aiLj3o7IIixCvX2A@x1.local>
 <osgeqdz7fukls5irhg2e3zi23yl7ej4depttlrphhinb76zlws@5gtyfdw4u3yu>
 <aisgm-Kk2OGxJ5XN@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aisgm-Kk2OGxJ5XN@x1.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: e77d966b-ba68-43ff-3374-08decb4233d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: B++Nt3+nk1YgxuP1dQ7UnxgU7kl5d38N0rL7rps9NZNdLDLyKIQjpFJK0YQcwJhAWiV+JQMEcHoYJjOEj4k7qiBDJVah9OR1lZV/paVd0kieEFC/T0jSo7kIAsML8lHAGUmdSsFuEfL6/N7OEfV9L6gejm8VnrxKq5QVK31p1f9Eq7ev8I2cqUY+qUA8DiMX6FtsBkJERbhV239pNx77vLWvYf9hbNS6EYxu9HU5lCCd9pX0fbGzDYQU2RV8RI4f72znR2kV69qBVr09wNpCllllaZ9DnCDR1Ea1IscEEeglPDNznv8t3l+/qwCZdFAVTP7OK90rfJChp7GfrsUF358GyqMQjL1+D1d3oqkvcLCmpZaszI6WWgrmUY9qljiC8pcuqSe3eRSOt4DlyFooFaGmr5YtOtFfCl9TMZsVIX0vj6Cqy3IFDvrXtV2GkX/rJYVsGevzQihe0OtKkCbd9VoSaPOjiPqDxnsylpnW36vIZMBzi8LEzvYiDHZrJoEUcMz7aGKHjlAe47Ph4uApxZtdcmNk5baM1Ic31g2KipmBYxmZbw4FhCBObQ53Id3Dez7i3UFgB4mkr4WsorAeKiHgYiiEQzDeR70/Gk8bCwM9kVz0kY4WMFfFriDg3sDuYqHI3g/OvjIDR/caq0FjTgsj5hq6MEhoB5K0HS3cZVX3VQZfAszF6ZRRwqN/c3MC+cCzRfua5urIwqoSnlTmssXCUovujFLk5BXPE+x3t6o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zgZhNXDDKlgSMw/yrmyqfOwnZfgxfpUZ7lJVVhrRx1StNShhDEYCOw9i4p8/1JGzUaiulmWdjaR6X1RdjALtONuoYOW0SVA1vo1JrjIsHDupLAP41h48Yn+e/VmCLeOLSxqRGYo4DQYXHvJ6EsU+SAhqz0r+4uFNhVIv7PXyq0qouNvCxHIIt1YPFVLVFrkiwbODS6IKi2i1nMRg0CAEg4Xj1TciFV0CKRD4rir7OorkdCNtbuGiShD7+Svcp7LRGp1JkPfRcmccAJUozGXl83GB8TDFguWqPc2p07daK/q6fS7GfAMS+sfij5RyQQRQaldZjdi3ECK7yNS3/FESGB2gfXK5zE4UkGtzKUEL2Mrl7bSzgjM9e4ncWoVOzapCvIL8FZDFWN6+ZbL/Z2+0shAVKp+MgghqoHpy92x3Ya5cd5DW+5OuPSH96+E5bTYU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 00:57:13.0197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77d966b-ba68-43ff-3374-08decb4233d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
Received-SPF: permerror client-ip=52.101.46.39;
 envelope-from=Michael.Roth@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

On Thu, Jun 11, 2026 at 04:54:51PM -0400, Peter Xu wrote:
> On Mon, Jun 08, 2026 at 12:59:55PM -0500, Michael Roth wrote:
> > On Fri, Jun 05, 2026 at 10:57:34AM -0400, Peter Xu wrote:
> > > On Thu, Jun 04, 2026 at 05:36:42PM -0500, Michael Roth wrote:
> > > > > IIUC it's a matter of if we expect future property of guest-memfd that will
> > > > > stop applying to memfd anymore?
> > > > 
> > > > Yah, I think that's the main thing to consider. There's a few things in the
> > > > pipeline where the options associated with guest_memfd might diverage
> > > > quite a bit from memfd:
> > > 
> > > Thanks for all these contexts.  I'll throw some random questions below,
> > > some of them may not be directly related to the current discussion, but
> > > please bare with me.
> > > 
> > > > 
> > > >   - hugetlb: yes, these could potentially use the same options memfd
> > > >     uses, and I'm guessing that will end up being the case, but one
> > > >     large gap there is that shared memory is always split to 4K, which
> > > >     we've accepted for now, but if you consider use-cases like DPDK
> > > >     there can still be major performance bottlenecks that would drive
> > > >     us to try to enable larger mappings for the shared ranges, and then
> > > >     we'd end up with guest-memfd-specific parameters intermix with
> > > >     normal memfd options, and our related documentation would need to
> > > >     covers these differences case by case
> > > 
> > > The first thing I thought about is mTHP and how it can also be similarly
> > > applied to normal memfd (now, or in the future, that I'm not sure).
> > 
> > That might work, though for some architectures the shared pages might
> > benefit from a wider range of hugepage granularities than private. For
> > instance with SNP it might make sense to expose 1GB hugepages but then
> > limit them to 2MB granularity for private (since private pages get 2MB
> > TLB entries anyway so rebuilding from 2MB->1GB is a waste)
> > 
> > https://github.com/AMDESE/amdsev#prepare-hostBut IIUC that sort of support will likely depend on some mm/ changes
> > are refcounting that probably won't be completed any time soon so it's
> > hard to say to anticipate what that'll end up looking like.
> > 
> > > 
> > > Before that..  shouldn't the whole concept of private mem / gmem about
> > > reducing the area of mapping the host (including dpdk, if we're talking
> > > about things like OpenVswitch)?  Can you roughly describe how huge mapping
> > > is expected to be allowed in such case?  Does it mean the guest driver
> > > should also be aware to allocate huge continuous physical mem for DMA only?
> > 
> > Guest drivers would generally end up either going through SWIOTLB to get
> > access to shared memory, or convert their pages to shared directly prior
> > to use. Optimizations for hugepages would work roughly the same as any
> > optimizations that have already been done for the non-confidential case.
> > Shared guest allocations/conversions at granularities smaller than the
> > backing page/hugepage size are where confidential VMs start to pay an
> > extra tax in guest_memfd and potentially with the security architecture
> > (e.g. extra RMP table checks for SNP, not just the TLB/TLB misses).
> > 
> > It seems to be in everyone's best interest to have a common shared
> > memory pool that gets initialized/converted/replenished at hugepage-sized
> > granularities. Here's one patchset[1] that takes the natural choice of
> > doing this through SWIOTLB. Not sure that's ultimately what it will look
> > like but I think it's safe to expect some level of optimization.
> 
> [sorry for a late response]
> 
> OK, yes this sounds reasonable in general.
> 
> > 
> > So with all these pieces in play, what I would expect is that DPDK
> > applications could access these shared buffers using hugepages both in
> > the guest and host-side as they do today, since the whole hugepage/folio
> 
> So even if physical continous chunks (each 2M in size) are preserved, it's
> still part of gmem page cache (based on either 2M or larger huge pages).
> 
> Then I assume if we want to have OVS-DPDK be able to hugely map it, we'll
> need to support in gmem's fault handler when seeing some shared huge 2M and
> do the job right.  There seems to have some details missing (e.g. I wonder
> if it's still safer to only map 4K by default..), but it sounds working
> indeed.

To be clear, I was just speculating on what it might look like, but yes,
it seems technically possible in the way you described.

But I think there's some related accounting in the kernel that assumes
hugepages will always be mapped as hugepage in userspace (because
"normal" hugetlb pages can't be split in the first place), and that's
the bit where the MM folks might need to work through things for a while
so it can all be done safely/properly.

> 
> > will be homogenous with the above guest optimizations... but that still
> > requires the above-mentioned mm/ rework for refcounting to allow hugepages
> > for shared ranges so this is another thing that we probably won't need to
> > deal with any time soon, but I think that's roughly what we could expect
> > it to look like eventually.
> > 
> > [1] https://lkml.org/lkml/2024/1/12/65
> > 
> > > 
> > > >   - DAX-like stuff: there are some proposals for making device memory
> > > >     available to use as private guest memory, and since 'guest-memfd'
> > > >     is generally responsible for managing private memory, it will
> > > >     likely end up being extended to handle this at some point. One
> > > >     proposal/PoC[1] would involve at least needing additional options
> > > >     for the /dev/dax path, but there have also been discussions about
> > > >     having a general notion of custom allocators that can be plugged
> > > >     into guest_memfd, and some of these might have overlapping options
> > > >     WRT things like hugepages/etc. But at a high-level, DAX would map
> > > >     more to memory-backend-file than memory-backend-memfd, so we'd
> > > >     already be crossing up some wires there.
> > > 
> > > I have no deep understanding on this, but IIUC we used to stick with
> > > memory-backend-file for dax.  Why switch to memory-backend-guest-memfd?
> > > Are we still exposing a dax via a file path ultimately, even with CoCo?
> > 
> > I touched on this a bit below, but I don't necessarily think
> > memory-backend-guest-memfd should handle DAX, it's just one example
> > where we clearly need to think beyond 'memfd', but are still potentially
> > in the realm of 'guest_memfd' depending on what the API ends up looking
> > like.
> > 
> > But I agree with your below point that we don't need the backend to
> > match up with implementation details of how guest_memfd works
> > internally, and that the core point that memory-backend-file might still
> > end up seeming like the most appropriate way for a QEMU user to specify
> > a DAX path, even if internally it's still using guest_memfd.
> > 
> > Though going that route, we'd still have a
> > memory-backend-file,...,guest_memfd=on that brings 'memfd's' back into
> > the discussion. We could take it a step further and rename the
> > 'guest_memfd' backend option to 'securable', but maybe this is ends up
> > being that right level of balance between 'i need to open a file that
> > can do guest_memfd-related stuff', and 'i need to create a guest_memfd
> > instance can handle a DAX path'.
> 
> What I have in mind is, when used as CoCo where we will need to apply the
> machine property first saying "this is a CoCo VM", we shouldn't need to
> specify "guest-memfd=on" all over the places anymore. QEMU should be able
> to identify it's required to initialize everything to use guest-memfd, or
> fail when it's not supported.
> 
> I introduced "guest-memfd" parameter in this series because this series
> still haven't gone as far: unlike CoCo+in-place-conversion or the old CoCo
> with two-layered backends, init-shared is an opt-in feature, and there's no
> machine property to imply anything. It's different from CoCo VMs.
> 
> I wonder if you think that's a good idea.  So I found it redundant to
> specify guest-memfd=on for CoCo VMs for all such backends (unless if we
> decide to go with memory-backend-guest-memfd, then it's fine).
> 
> Say, after in-place conversion ready, we should specify this:
> 
>   $QEMU -M $SOME_COCO_PARAMS,in-place-conversion=on -object memory-backend-memfd,id=*
>   (without guest-memfd=on)
> 
> Then that memory-backend-memfd should automatically notice "ok this is a
> CoCo VM with in-place conversion enabled, we don't do dual-layer, this must
> be a gmemfd".

I definitely like the general approach of handling this internally.
Especially given how many unknowns we have about what all the backends
will need to look like once all these more advanced guest_memfd features
start popping up.

> 
> > 
> > My thinking was that since the hugepage PoC already implements the notion
> > of custom allocators in the uAPI, and that there's been talk of 'pluggable'
> > backends for guest_memfd, that the kernel would also need to do a reasonable
> > job in creating a consistent uAPI/documentation, such that the hugepage/DAX
> > cases would end up looking something like:
> > 
> >   memory-backend-guest-memfd,allocator=hugetlb,pagesize=2M,...
> >   memory-backend-guest-memfd,allocator=dax,path=/dev/daxX,pagesize=2M,...
> 
> So far I'm still a bit conservative to introduce a path= parameter to a
> memfd backend.. but we can hold the discussion until the idea becomes
> clearer.

Yah, that was my original concern with tying "guest_memfd" too closely
to the notion of a 'memfd' because it's likely going to evolve to
service a lot of use-cases that go beyond what a normal memfd would
generally be used for. But it's still speculation on what exactly all
those other things will look like when it lands, so if 'memfd' aligns
more with the current feature set, and we still have options to add
a dedicated backend down the road if that ends up making sense, then
that seems reasonable to me.

And handling the 'guest_memfd=on' automatically affords even more
flexibility for how we decide to handle other CoCo parameters/features,
so that's seeming like the way to go to me.

> 
> > 
> > which is firmly on the 'i need to create a guest_memfd instance that's
> > back by a DAX path' end of the spectrum, compared to the more abstracted
> > approach you're suggesting, and so for the most part we'd be passing
> > through the kernel options/documentation to users vs. abstracting it and
> > then touching on it case-by-case in 'memfd'/'file'/etc. documentation.
> 
> If you agree with my above idea, we don't need to document anything special
> for CoCo.  We support all things internally, no doc change needed except
> telling people how to enable CoCo.
> 
> Say, if we have a command line that works for QEMU without CoCo:
> 
>   $QEMU -M ... -object memory-backend-memfd,id=...
> 
> Then my imagination is if we want to boot that same VM but with CoCo, the
> cmdline should be:
> 
>   $QEMU $COCO_PARAMS1 -M ...,$COCO_PARAMS2 -object memory-backend-memfd,id=...
>   (again, no guest-memfd=on anywhere)
> 
> I wish it will just work all like before, except that it now boots a
> confidential VM, so safety guaranteed.
> 
> I agree that's the ideal case, and I may over look things.. Please correct
> me if I missed some.
> 

That seems like the ideal to me, really, it's minimal cmdline changes
and we aren't lacking any options, and we have fully control over how we
decide to expose new features down the road.

> > 
> > Personally, I'm not sure at this point which approach will end up being
> > the more workable one. But it is harder/more-confusing to start with
> > memory-backend-guest-memfd, and then go back to e.g.
> > memory-backend-file,guest_memfd=on later for future extensions. So I'm
> > start to lean toward doing the minimal
> > '<existing_backend>,guest_memfd=on' thing for now, and then just
> > deprecating it if we really feel like we need a more direct interface
> > that memory-backend-guest-memfd down the road.
> > 
> > Does that seem reasonable for a starting point? I feel like we'll be
> > better positioned to make a better long-term decision once some of these
> > patchsets are further along.
> 
> The more I read into it, the more I feel like we should settle this early..
> It might be a good timing to discuss this.
> 
> Again, I don't actually have any strong opinion right now, say, duplicating
> the current memfd backend file isn't a huge deal. Now, I'm uncertain
> slightly more about the future, and whether that's the right start to
> future's QEMU cmdline interfacing with CoCo.
> 
> > 
> > > 
> > > Note, here I want to differenciate two concepts: QEMU interfacing and
> > > kernel/KVM interfacing.  I mean, I have a gut feeling that for coco dax we
> > > could still stick with memory-backend-file, even if internally we can still
> > > use new KVM ioctls to set them up: there's no rule to say only
> > > memory-backend-guest-memfd can use the KVM ioctl.  IMHO they're different
> > > stories, and here I'm focused more on the QEMU interfacing that we're
> > > discussing here.
> > > 
> > > IMHO for QEMU's interfacing, any memory-backend should play one solo role
> > > which is to point to QEMU (as a hypervisor) a backing store for some piece
> > > of resource that can be used as guest memory backend.  It doesn't need to
> > > have any implication on how we implement that backend internally.
> > > 
> > > >   - live update: there's work[2] on enabling preservation of confidential
> > > >     guest memory across kexec by preserving it through guest_memfd. This
> > > >     one is still a bit mind-blowing to me but I could see us needing
> > > >     some additional options here that would really make no sense for
> > > >     memfd.
> > > 
> > > Could you elaborate what kind of parameter you would expect?
> > 
> > I was thinking stuff like the metadata that would be needed to rebuild a
> > KVM instance with the same GPA->HPA mappings to the pages previously
> > allocated by guest_memfd. It makes semse that each backend has it's own
> > associated metadata so that each can be restored in-turn, but yes there
> > would also need to be some common state like KVM itself that needs to be
> > serialized, and this would probably have separate options. So in theory it
> > wouldn't need to be tied to the backend, but IMO it feels very natural
> > to imagine the options like something like that.
> 
> So live update should ideally work both for CoCo and non-CoCo, and work for
> all memory-backends, am I right?  I'm not sure if it means gmem is not
> special in this case, because they should all be reserved on save(), and
> recovered on load().

For CPR (for normal VMs) it was my understanding that we'd generally really
on backing guest memory via a file that can preserve the guest memory to disk.
So we'd certainly need to know that path of that file on src/dest to
load the checkpointed memory.

With the kexec in the mix, this could work basically the same for normal
VMs, because they can serialize the memory to disk and restore it after
the kexec.

With CoCo, you can't restore the memory from disk, you need to preserve
it physical memory even after the kexec, because the encryption is
generally tied to the placememt of memory in the physical address space.
So instead of a file, we'll need to re-initialize a guest_memfd instance
that will locate these physical ranges and map them back into the
guest_memfd filemap so the guest state can be resumed. I don't know if
this would necessarily be tracked via metadata that the VMM loads into
the new kernel, or if the kexec process itself squirrels that away in
memory somewhere... it just seems different enough that we might end up
with some different options/behavior vs. normal VMs and *maybe* the
backend might need an option or 2 to capture it.

But if we can do as much as possible to make it behave like a normal VM
that's for the best, I'm just pointing out we might need some
flexibility in the future for CoCo-specific options.

> 
> If you put everything above into this picture, live update (or CPR) only
> means: let's do a migration with this VM, no matter if it's CoCo or not.
> It hopefully shouldn't care some parameter the memfd (gmem or not) has.
> 
> > 
> > > 
> > > I'm not sure if you have investigated QEMU's CPR approach, now memfd
> > > backend is really the core of supporting such infrastructure, where fds can
> > > be persisted.  For live update, it'll be persisted across kexec and kernel
> > > switchover.  For CPR, it actually also works when with cpr-reboot with its
> > > own tricky way to persist memory.
> > > 
> > > In general, what I want to say is, I really think they should play the same
> > > in term of live update case too: if we need to register some fd for
> > > persistency, we need to register gmem, kvm, but also memfd if some of them
> > > are attached to the current VM, right?
> > 
> > I definitely need to look into this more (and intra-host live update for
> > guest_memfd/in-place converison in general), but for guest memory
> > persistence it seems like we'd generally be relying on
> > memory-backend-file=<path> as a target/src for serializing guest memory
> > to persistent storage for normal/'memfd' case.
> > 
> > But for confidential VMs we don't just need the data for a particular GPA,
> > but the original HPA and maybe details like the associated shared/private
> > memory attributes, which is why I'm thinking we might need something like a
> > separate path argument for that, or maybe QEMU abstracting this out into its
> > own user-configurable format.
> > 
> > > 
> > > >   - directmap removal: these[3] patches allow a new guest_memfd flag to
> > > >     be set to unmap guest_memfd pages from kernel directmap to help
> > > >     mitigate speculative attacks, probably would involve a new option
> > > >     as well that wouldn't be applicable to normal memfds
> > > 
> > > Now the question is, do we want to remove directmap for "some" memory
> > > backend, or do we want to remove it per-VM?
> > > 
> > > This is another thing I want to make sure we're on the same page: I want to
> > > make sure we don't introduce per-VM setup for memory backends.
> > > 
> > > Say, "init-shared" or "in-place CoCo", what should we use for one gmem fd?
> > > IMHO it shouldn't be a parameter in the memory-backend.  It should be a
> > > parameter for the -machine or some similar per-vm setup, which will apply
> > > to all gmemfd across the current VM.
> > > 
> > > My understanding is directmap removal is similar in this case, which seems
> > > to be a per-VM (rather than per-memory-backend) attribute?  We can still
> > > operate on that per-memory-backend, but then it'll be internally, the
> > > backends need to understand the VM setup and do things properly, IMHO.
> > 
> > I think all-or-nothing would be most common, but it's completely
> > controlled at the guest_memfd inode level so it would support that sort
> > of flexibility if needed. One side effect is that setting it currently
> > sets AS_NO_DIRECT_MAP which can have some performance downsides...
> > maaaaaybe that's enough for someone to want to fine-tune 'isolated' vs.
> > 'non-isolated' GPA ranges?
> 
> Yes, it sounds possible, but it sounds non-trivial to do any fine tuning..
> and maybe the admin will just go take or not take the penalty. :)
> 
> I'll see how you think about my above comments in general, the summary is
> whether we can relying on a machine prop to define the VM completely on all
> internal things, rather than needing to touch everything.  If that's a good
> idea, then maybe we don't need a new backend for the same reason, because
> memfd backend "must" be guest-memfd backend for CoCo.
> 
> This made me also thought about when CPR was introduced: not relevant to
> "live update" perspective, but similarly we need something special all over
> the places, and what CPR does was exactly requiring one global -M parameter
> with:
> 
> -machine aux-ram-share=on
> 
> That enables all internal RAMs allocated (like, ROMs) to be fully fd-based.
> All rest QEMU cmdlines untouched to support CPR.
> 
> CPR hided quite some tricky checks all over the place.  Sometimes I don't
> like it, but I think what I don't like is not the interfacing part, only
> when it hides things too deep in stack..  Logically the idea still makes
> sense and it's similar here on one knob controlling everything.

Yah I think it seems like a good trade-off to handle things internally
based on global options until we have solid use-cases where that will no
longer be sufficient, so that's what I'm planned to do for v2: rebase on
your series, and have guest_memfd=on be set automatically in the CoCo
case.

I wasn't planning to do it via a -machine option, but rather a global
ConfidentialGuestSupport propertly, but -machine could work too, I
hadn't really considered it yet.

> 
> https://www.qemu.org/docs/master/devel/migration/CPR.html
> 
> Thanks again for all the details!

Thanks for the great suggestions!

-Mike

> 
> > 
> > So I think it's pretty safe to say we don't *need* to expose this
> > functionality per-backend/inode initially, and if we end up preferring a
> > global option then that's probably fine too. So we can probably set this
> > example aside for now.
> > 
> > > 
> > > > 
> > > > It could also end up that even memory-backend-guest-memfd is too
> > > > generic, and that some of these would involve a more specialized memory
> > > > backend where may they can share a common base class for some of the
> > > > core guest_memfd stuff but otherwise be separate backends with their
> > > > own specific options. So to me, starting off building up
> > > > memory-backend-memfd seems like a potential misstep, whereas we don't
> > > > really lose much to start with a clean slate.
> > > > 
> > > > [1] DAX: https://lwn.net/ml/all/20260423170219.281618-1-dave.jiang@intel.com/
> > > > [2] LUO: https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/#r
> > > > [3] directmap removal: https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/
> > > > 
> > > > > 
> > > > > > 
> > > > > > I also saw you were open to having someone pick up these patches if you
> > > > > > don't think you'll have a chance to get to them near-term, so I'd be
> > > > > > happy to pick them up if that's preferable.
> > > > > 
> > > > > Sure!  Indeed I don't have bandwidth to keep working on this one in the
> > > > > near future. Please feel free to pick whatever needed into your series.
> > > > 
> > > > Ok, sounds good, I'll pick these up for my next posting and incorporate
> > > > any changes/comments that might still be pending at that time.
> > > > 
> > > > Thanks for getting things to this stage!
> > > 
> > > Thanks for picking it up!  Juraj in our team may have some future
> > > exploration on gmem over 1G for postcopy on init-shared, so it's great the
> > > code is moving closer to that direction.
> > 
> > Nice, lots of interesting work ahead it seems :)
> > 
> > Thanks,
> > 
> > Mike
> > 
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> > > 
> > > 
> > 
> 
> -- 
> Peter Xu
> 

