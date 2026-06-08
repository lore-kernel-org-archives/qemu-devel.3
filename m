Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A989CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWeVI-0000Sc-78; Mon, 08 Jun 2026 14:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wWeVB-0000OV-QY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:15:09 -0400
Received: from mail-centralusazon11011024.outbound.protection.outlook.com
 ([52.101.62.24] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wWeV6-0004QG-Gh
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:15:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tW3x4QZ/JRRN2LfOVxO9TUMgzK573PcCc3WBusflMy3988UxHaAFAj7HtDuT50USRy5qvngEP3LE4lrFqVzHSQAn4QpiaDXiSgL7/oZL3L9o7bk1UZFjugqdTXuE1LtyVzMCwLGAfLv5ErZp99gMNzKuhp73UvvSt6EWna/hWT9Pw+8gjhgdAf8u5mxdojTvHw9eDZKB4FdsaveeHJvSAI3EdCnBzhmH/il5HNAUUB9PbsCtVq7XCO3Lmp7qTwVdO4zfh262rDeTMVBlpQQ+rZzQR9n1NvOCPZSdNGH0AjcaaZ5b8X/zlWe630PggAgAMOqEchn5uBU45YW0SUkQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXDXi8Dl7GSIdRc9ber1t676nOIeQ+YaMGudYY9E6Wk=;
 b=duYhvORUK8h3Kv9T2eNr9dY3RvI9PBwCx2hxNv+CsevCvbUW5iwzaaTlizitQFiIPHfZt0Keqtdb6NK8PYKz8G4pha/MY26XrECJN5fXePlEfZnm+0Dk/PMhT1bOc4TnUX+GAodHEHkWq7OMofeDc6PV26qZtuNSG5utDe9s7fNib4L+2XP6xK7dZvbfM88HRe5JoG5R3GJkCe/ZNLs9tIP/FV1Hzhd6lyJICXXQKlhK1msv8INTfuUWo2lNRHGBHc1BPXTxViWUPw29oGHvOnxET/WTGY11j0GyR9QamyBYAUtu0LjqiZr3ZpGwfL0dTeNtrG+kansw/2URlv24rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXDXi8Dl7GSIdRc9ber1t676nOIeQ+YaMGudYY9E6Wk=;
 b=dSgjgYBYEYigS4s7RALf/+4Xbs5jCVjSK5oN81ykKKjVaB1a+akUXxCjfX5S7hJOQXxMvYEMP1Q3E3KCpQ9XnBuIxh03CslKuYB34F2PyVynj2FlrssWnlKuI+k/LuO6d8VzOgJtBqOPTfJc/EnMsfMlhuiu1C74m8EdpvVvpEM=
Received: from BN9PR03CA0427.namprd03.prod.outlook.com (2603:10b6:408:113::12)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 18:09:53 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::95) by BN9PR03CA0427.outlook.office365.com
 (2603:10b6:408:113::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 18:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 18:09:52 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 13:09:49 -0500
Date: Mon, 8 Jun 2026 12:59:55 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <osgeqdz7fukls5irhg2e3zi23yl7ej4depttlrphhinb76zlws@5gtyfdw4u3yu>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
 <aiCAFWKEAHkPLCO5@x1.local>
 <lpkcfd2crgparcd64ydry3ocryx3sfc5gj5pzrrms4nwvw6j4c@ulc3wa3rmefo>
 <aiLj3o7IIixCvX2A@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiLj3o7IIixCvX2A@x1.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c87e168-4c54-4b35-764f-08dec5892327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|6133799003|3023799007|18002099003|22082099003|5023799004|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: x+hqtUepoMW5vhV3YnkGusJRby/X3ntF3zYMpdfduqg3MmGXAOCzqP6to0He5nRhzmhj2Nh0ku+aUYukkuBehtbaikzcnhdU4TJHA7rHvBhN5A6LV13kgFllJuVoAcHmJFP0GTjKDrvNgfUK6RB6Mpto+c1THUyWW8KEoMiMYNvJjLIRHgU9xM2JSxrIGJiAgodJc7ZL9i1HLv0nz70SkTfrSqCMMW4IZNN3ESXP+tZYaIjaQC4mc0LYXSmmbmSiVh2tq/9R2QtJPpGeT3d91kzUIx+MGFr2yuYxhUxtL0ti8dHP1vVSN+Ff/wRd0+JXOjooEfz5JuhrsbZARe6uOjWHG2yVnV1BYWGW3nwrrJd4dFqFpd+xOSTIieDaq05b0lUq6gnqZqlfdG6zxOZGzMwTV+1gAkirkvCn+j765no5DaZeGTD6phA+v6f97L1A8bVTGl/E65wsUxP36lEHWg+sB6BPs0o4m9rd0bYQN+cwpmfpOXkc1wdGcIqdsdnClSygNVM95avP2KV/hrHlWGyHyBYv8sK3FvD36707Kr4GSRzUIyTPCZN4vshGgRsHRWYTQuQsgFKcNhLMkaVFk91sgzclvIliQoEuNKp1eJlof/pG/rNPqrQD/X7d0G9W4xFboJzIbpPbUQqAiphiqbNo7ZV6qm1Qg2Rf+PaOGN2m8Tpvl4JiLRQJt/L+OUWX9LdBgdtRfkPFTDOUvclcgGj6eW7Sc4bOYorj+xZJi1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(6133799003)(3023799007)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EodNGEUpxOXRru0sBi8WVfMdl5NB7vLMD7mAuieX2hSD2Z1MLU0xhUUxRhiFVz4gCEaQ5z67ejysXcQtYq46n2tNttug+afNLSZE/b+NoQloteKb+Zxox9+KVVUXMdakpAW0pSfcB+0OaETQ7pfIxcdCCJvkPGnnllWUOVXC5enDE75VvoNYqKZsAaWgslGpGp7i/SKhkPSD0Miqlu3Mrovukx3JR8Rg11uuP3VW6i1ZzXU7sEhxQy82MAJjAtuBl+ORpR3VK+YdSUtCuZIgGqr0a/0ZJ/bCXTuy6ucUTorRjrvOnYVa5lqjIE4cxPPPMUFmyy8RRfcmmMoLEZ/3ybJ3ZIsga12CSwxrJZR59TqqJO93q9xvH3y3QDHj60ndkEYnLFFEqqWX91irUYs5/c4agScwfChWqj9Y3353BZoT8JPTES1yw9EawNQZxrhl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:09:52.3742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c87e168-4c54-4b35-764f-08dec5892327
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
Received-SPF: permerror client-ip=52.101.62.24;
 envelope-from=Michael.Roth@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

On Fri, Jun 05, 2026 at 10:57:34AM -0400, Peter Xu wrote:
> On Thu, Jun 04, 2026 at 05:36:42PM -0500, Michael Roth wrote:
> > > IIUC it's a matter of if we expect future property of guest-memfd that will
> > > stop applying to memfd anymore?
> > 
> > Yah, I think that's the main thing to consider. There's a few things in the
> > pipeline where the options associated with guest_memfd might diverage
> > quite a bit from memfd:
> 
> Thanks for all these contexts.  I'll throw some random questions below,
> some of them may not be directly related to the current discussion, but
> please bare with me.
> 
> > 
> >   - hugetlb: yes, these could potentially use the same options memfd
> >     uses, and I'm guessing that will end up being the case, but one
> >     large gap there is that shared memory is always split to 4K, which
> >     we've accepted for now, but if you consider use-cases like DPDK
> >     there can still be major performance bottlenecks that would drive
> >     us to try to enable larger mappings for the shared ranges, and then
> >     we'd end up with guest-memfd-specific parameters intermix with
> >     normal memfd options, and our related documentation would need to
> >     covers these differences case by case
> 
> The first thing I thought about is mTHP and how it can also be similarly
> applied to normal memfd (now, or in the future, that I'm not sure).

That might work, though for some architectures the shared pages might
benefit from a wider range of hugepage granularities than private. For
instance with SNP it might make sense to expose 1GB hugepages but then
limit them to 2MB granularity for private (since private pages get 2MB
TLB entries anyway so rebuilding from 2MB->1GB is a waste)

https://github.com/AMDESE/amdsev#prepare-hostBut IIUC that sort of support will likely depend on some mm/ changes
are refcounting that probably won't be completed any time soon so it's
hard to say to anticipate what that'll end up looking like.

> 
> Before that..  shouldn't the whole concept of private mem / gmem about
> reducing the area of mapping the host (including dpdk, if we're talking
> about things like OpenVswitch)?  Can you roughly describe how huge mapping
> is expected to be allowed in such case?  Does it mean the guest driver
> should also be aware to allocate huge continuous physical mem for DMA only?

Guest drivers would generally end up either going through SWIOTLB to get
access to shared memory, or convert their pages to shared directly prior
to use. Optimizations for hugepages would work roughly the same as any
optimizations that have already been done for the non-confidential case.
Shared guest allocations/conversions at granularities smaller than the
backing page/hugepage size are where confidential VMs start to pay an
extra tax in guest_memfd and potentially with the security architecture
(e.g. extra RMP table checks for SNP, not just the TLB/TLB misses).

It seems to be in everyone's best interest to have a common shared
memory pool that gets initialized/converted/replenished at hugepage-sized
granularities. Here's one patchset[1] that takes the natural choice of
doing this through SWIOTLB. Not sure that's ultimately what it will look
like but I think it's safe to expect some level of optimization.

So with all these pieces in play, what I would expect is that DPDK
applications could access these shared buffers using hugepages both in
the guest and host-side as they do today, since the whole hugepage/folio
will be homogenous with the above guest optimizations... but that still
requires the above-mentioned mm/ rework for refcounting to allow hugepages
for shared ranges so this is another thing that we probably won't need to
deal with any time soon, but I think that's roughly what we could expect
it to look like eventually.

[1] https://lkml.org/lkml/2024/1/12/65

> 
> >   - DAX-like stuff: there are some proposals for making device memory
> >     available to use as private guest memory, and since 'guest-memfd'
> >     is generally responsible for managing private memory, it will
> >     likely end up being extended to handle this at some point. One
> >     proposal/PoC[1] would involve at least needing additional options
> >     for the /dev/dax path, but there have also been discussions about
> >     having a general notion of custom allocators that can be plugged
> >     into guest_memfd, and some of these might have overlapping options
> >     WRT things like hugepages/etc. But at a high-level, DAX would map
> >     more to memory-backend-file than memory-backend-memfd, so we'd
> >     already be crossing up some wires there.
> 
> I have no deep understanding on this, but IIUC we used to stick with
> memory-backend-file for dax.  Why switch to memory-backend-guest-memfd?
> Are we still exposing a dax via a file path ultimately, even with CoCo?

I touched on this a bit below, but I don't necessarily think
memory-backend-guest-memfd should handle DAX, it's just one example
where we clearly need to think beyond 'memfd', but are still potentially
in the realm of 'guest_memfd' depending on what the API ends up looking
like.

But I agree with your below point that we don't need the backend to
match up with implementation details of how guest_memfd works
internally, and that the core point that memory-backend-file might still
end up seeming like the most appropriate way for a QEMU user to specify
a DAX path, even if internally it's still using guest_memfd.

Though going that route, we'd still have a
memory-backend-file,...,guest_memfd=on that brings 'memfd's' back into
the discussion. We could take it a step further and rename the
'guest_memfd' backend option to 'securable', but maybe this is ends up
being that right level of balance between 'i need to open a file that
can do guest_memfd-related stuff', and 'i need to create a guest_memfd
instance can handle a DAX path'.

My thinking was that since the hugepage PoC already implements the notion
of custom allocators in the uAPI, and that there's been talk of 'pluggable'
backends for guest_memfd, that the kernel would also need to do a reasonable
job in creating a consistent uAPI/documentation, such that the hugepage/DAX
cases would end up looking something like:

  memory-backend-guest-memfd,allocator=hugetlb,pagesize=2M,...
  memory-backend-guest-memfd,allocator=dax,path=/dev/daxX,pagesize=2M,...

which is firmly on the 'i need to create a guest_memfd instance that's
back by a DAX path' end of the spectrum, compared to the more abstracted
approach you're suggesting, and so for the most part we'd be passing
through the kernel options/documentation to users vs. abstracting it and
then touching on it case-by-case in 'memfd'/'file'/etc. documentation.

Personally, I'm not sure at this point which approach will end up being
the more workable one. But it is harder/more-confusing to start with
memory-backend-guest-memfd, and then go back to e.g.
memory-backend-file,guest_memfd=on later for future extensions. So I'm
start to lean toward doing the minimal
'<existing_backend>,guest_memfd=on' thing for now, and then just
deprecating it if we really feel like we need a more direct interface
that memory-backend-guest-memfd down the road.

Does that seem reasonable for a starting point? I feel like we'll be
better positioned to make a better long-term decision once some of these
patchsets are further along.

> 
> Note, here I want to differenciate two concepts: QEMU interfacing and
> kernel/KVM interfacing.  I mean, I have a gut feeling that for coco dax we
> could still stick with memory-backend-file, even if internally we can still
> use new KVM ioctls to set them up: there's no rule to say only
> memory-backend-guest-memfd can use the KVM ioctl.  IMHO they're different
> stories, and here I'm focused more on the QEMU interfacing that we're
> discussing here.
> 
> IMHO for QEMU's interfacing, any memory-backend should play one solo role
> which is to point to QEMU (as a hypervisor) a backing store for some piece
> of resource that can be used as guest memory backend.  It doesn't need to
> have any implication on how we implement that backend internally.
> 
> >   - live update: there's work[2] on enabling preservation of confidential
> >     guest memory across kexec by preserving it through guest_memfd. This
> >     one is still a bit mind-blowing to me but I could see us needing
> >     some additional options here that would really make no sense for
> >     memfd.
> 
> Could you elaborate what kind of parameter you would expect?

I was thinking stuff like the metadata that would be needed to rebuild a
KVM instance with the same GPA->HPA mappings to the pages previously
allocated by guest_memfd. It makes semse that each backend has it's own
associated metadata so that each can be restored in-turn, but yes there
would also need to be some common state like KVM itself that needs to be
serialized, and this would probably have separate options. So in theory it
wouldn't need to be tied to the backend, but IMO it feels very natural
to imagine the options like something like that.

> 
> I'm not sure if you have investigated QEMU's CPR approach, now memfd
> backend is really the core of supporting such infrastructure, where fds can
> be persisted.  For live update, it'll be persisted across kexec and kernel
> switchover.  For CPR, it actually also works when with cpr-reboot with its
> own tricky way to persist memory.
> 
> In general, what I want to say is, I really think they should play the same
> in term of live update case too: if we need to register some fd for
> persistency, we need to register gmem, kvm, but also memfd if some of them
> are attached to the current VM, right?

I definitely need to look into this more (and intra-host live update for
guest_memfd/in-place converison in general), but for guest memory
persistence it seems like we'd generally be relying on
memory-backend-file=<path> as a target/src for serializing guest memory
to persistent storage for normal/'memfd' case.

But for confidential VMs we don't just need the data for a particular GPA,
but the original HPA and maybe details like the associated shared/private
memory attributes, which is why I'm thinking we might need something like a
separate path argument for that, or maybe QEMU abstracting this out into its
own user-configurable format.

> 
> >   - directmap removal: these[3] patches allow a new guest_memfd flag to
> >     be set to unmap guest_memfd pages from kernel directmap to help
> >     mitigate speculative attacks, probably would involve a new option
> >     as well that wouldn't be applicable to normal memfds
> 
> Now the question is, do we want to remove directmap for "some" memory
> backend, or do we want to remove it per-VM?
> 
> This is another thing I want to make sure we're on the same page: I want to
> make sure we don't introduce per-VM setup for memory backends.
> 
> Say, "init-shared" or "in-place CoCo", what should we use for one gmem fd?
> IMHO it shouldn't be a parameter in the memory-backend.  It should be a
> parameter for the -machine or some similar per-vm setup, which will apply
> to all gmemfd across the current VM.
> 
> My understanding is directmap removal is similar in this case, which seems
> to be a per-VM (rather than per-memory-backend) attribute?  We can still
> operate on that per-memory-backend, but then it'll be internally, the
> backends need to understand the VM setup and do things properly, IMHO.

I think all-or-nothing would be most common, but it's completely
controlled at the guest_memfd inode level so it would support that sort
of flexibility if needed. One side effect is that setting it currently
sets AS_NO_DIRECT_MAP which can have some performance downsides...
maaaaaybe that's enough for someone to want to fine-tune 'isolated' vs.
'non-isolated' GPA ranges?

So I think it's pretty safe to say we don't *need* to expose this
functionality per-backend/inode initially, and if we end up preferring a
global option then that's probably fine too. So we can probably set this
example aside for now.

> 
> > 
> > It could also end up that even memory-backend-guest-memfd is too
> > generic, and that some of these would involve a more specialized memory
> > backend where may they can share a common base class for some of the
> > core guest_memfd stuff but otherwise be separate backends with their
> > own specific options. So to me, starting off building up
> > memory-backend-memfd seems like a potential misstep, whereas we don't
> > really lose much to start with a clean slate.
> > 
> > [1] DAX: https://lwn.net/ml/all/20260423170219.281618-1-dave.jiang@intel.com/
> > [2] LUO: https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/#r
> > [3] directmap removal: https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/
> > 
> > > 
> > > > 
> > > > I also saw you were open to having someone pick up these patches if you
> > > > don't think you'll have a chance to get to them near-term, so I'd be
> > > > happy to pick them up if that's preferable.
> > > 
> > > Sure!  Indeed I don't have bandwidth to keep working on this one in the
> > > near future. Please feel free to pick whatever needed into your series.
> > 
> > Ok, sounds good, I'll pick these up for my next posting and incorporate
> > any changes/comments that might still be pending at that time.
> > 
> > Thanks for getting things to this stage!
> 
> Thanks for picking it up!  Juraj in our team may have some future
> exploration on gmem over 1G for postcopy on init-shared, so it's great the
> code is moving closer to that direction.

Nice, lots of interesting work ahead it seems :)

Thanks,

Mike

> 
> Thanks,
> 
> -- 
> Peter Xu
> 
> 

