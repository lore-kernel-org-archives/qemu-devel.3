Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8828C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 11:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riufy-000566-Fi; Sat, 09 Mar 2024 06:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rppt@kernel.org>) id 1riufw-00055s-KP
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 06:15:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rppt@kernel.org>) id 1riuft-0003Dd-Qz
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 06:15:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 23246601CF;
 Sat,  9 Mar 2024 11:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB0EC433C7;
 Sat,  9 Mar 2024 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709982923;
 bh=YaUuuk7Crsl2a1PUUVlftTiGcGES7hvpa0gsLJH4zXA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rl9M6geC4ebyRSg/d2wRXYZOIlzGBGevef0ILal/PwLTfJYHxWnepu1EFQhJSJqp1
 dqKzS8GKxJ+rhJToGRkhboVOZdHt+vU98vtpuGtVx1OYquHCjgIoWOt5kIIIUgUdkA
 zVhFg8xuVaI+nt//g1J0r8SZk/3Q7xTmCC8eOzhi9FBsQ9Y0h+puyEVimWTJnC8oYu
 Y7MxIveJTBKivuvGizPHVxJlu5YPSGFls3TxEPBEiRf30S5/tAKcIhqs0kqyYQkT4I
 tS6X5kYMX/52fcixiE4zhGRDtQidSASFWNKNftwdz9lcEYoKUFz7B7hl+61ijvjwHK
 DHGPLi3zffCQA==
Date: Sat, 9 Mar 2024 13:14:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: James Gowans <jgowans@amazon.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Patrick Roy <roypat@amazon.co.uk>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 Derek Manwaring <derekmn@amazon.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Nikita Kalyazin <kalyazin@amazon.co.uk>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>,
 "mst@redhat.com" <mst@redhat.com>, "somlo@cmu.edu" <somlo@cmu.edu>,
 Alexander Graf <graf@amazon.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
Message-ID: <ZexEkGkNe_7UY7w6@kernel.org>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeudRmZz7M6fWPVM@google.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=rppt@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 08, 2024 at 03:22:50PM -0800, Sean Christopherson wrote:
> On Fri, Mar 08, 2024, James Gowans wrote:
> > However, memfd_secret doesn’t work out the box for KVM guest memory; the
> > main reason seems to be that the GUP path is intentionally disabled for
> > memfd_secret, so if we use a memfd_secret backed VMA for a memslot then
> > KVM is not able to fault the memory in. If it’s been pre-faulted in by
> > userspace then it seems to work.
> 
> Huh, that _shouldn't_ work.  The folio_is_secretmem() in gup_pte_range() is
> supposed to prevent the "fast gup" path from getting secretmem pages.

I suspect this works because KVM only calls gup on faults and if the memory
was pre-faulted via memfd_secret there won't be faults and no gups from
KVM.
 
> > With this in mind, what’s the best way to solve getting guest RAM out of
> > the direct map? Is memfd_secret integration with KVM the way to go, or
> > should we build a solution on top of guest_memfd, for example via some
> > flag that causes it to leave memory in the host userspace’s page tables,
> > but removes it from the direct map? 
> 
> memfd_secret obviously gets you a PoC much faster, but in the long term I'm quite
> sure you'll be fighting memfd_secret all the way.  E.g. it's not dumpable, it
> deliberately allocates at 4KiB granularity (though I suspect the bug you found
> means that it can be inadvertantly mapped with 2MiB hugepages), it has no line
> of sight to taking userspace out of the equation, etc.
> 
> With guest_memfd on the other hand, everyone contributing to and maintaining it
> has goals that are *very* closely aligned with what you want to do.

I agree with Sean, guest_memfd seems a better interface to use. It's
integrated by design with KVM and removing guest memory from the direct map
looks like a natural enhancement to guest_memfd. 

Unless I'm missing something, for fast-and-dirty POC it'll be a oneliner
that adds set_memory_np() to kvm_gmem_get_folio() and then figuring out
what to do with virtio :)

-- 
Sincerely yours,
Mike.

