Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07A9C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6V1y-0003YL-Dn; Mon, 13 May 2024 08:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8567b36a1=roypat@amazon.co.uk>)
 id 1s6SyP-0004aN-Tx
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:32:05 -0400
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8567b36a1=roypat@amazon.co.uk>)
 id 1s6SyL-0002Jd-Eq
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1715596318; x=1747132318;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uQIw9i/g+I3Ll0Kcnj1kLLWW5A3sw6sKhdQsGDX0E88=;
 b=JjWla/uwjMwRUNXOhkxG+7f+zVreNbnoe5sBuOdub0f6Zt1qw8wRd55G
 tqfkyW4C2DPojB7aRv9EJTK+rCSFL+IWmlEdcpSeAxSUgB4tHc8z6HowI
 eF+B6lOi3AKBrksiJSwLcpLpS3/1w0z0Rta8R63gD7ajQAEdvoybcfhMI g=;
X-IronPort-AV: E=Sophos;i="6.08,158,1712620800"; d="scan'208";a="653737330"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 10:31:53 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.44.209:28793]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.82.155:2525]
 with esmtp (Farcaster)
 id 24678bc8-ee46-4086-b40e-d21a7295c070; Mon, 13 May 2024 10:31:51 +0000 (UTC)
X-Farcaster-Flow-ID: 24678bc8-ee46-4086-b40e-d21a7295c070
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 10:31:51 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 10:31:51 +0000
Received: from [127.0.0.1] (172.19.88.180) by mail-relay.amazon.com
 (10.252.135.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Mon, 13 May 2024 10:31:49 +0000
Message-ID: <58f39f23-0314-4e34-a8c7-30c3a1ae4777@amazon.co.uk>
Date: Mon, 13 May 2024 11:31:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
To: Mike Rapoport <rppt@kernel.org>, Sean Christopherson <seanjc@google.com>
CC: James Gowans <jgowans@amazon.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, Derek Manwaring <derekmn@amazon.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Nikita Kalyazin <kalyazin@amazon.co.uk>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>, "Liam.Howlett@oracle.com"
 <Liam.Howlett@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "mst@redhat.com" <mst@redhat.com>,
 "somlo@cmu.edu" <somlo@cmu.edu>, Alexander Graf <graf@amazon.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com> <ZexEkGkNe_7UY7w6@kernel.org>
Content-Language: en-US
From: Patrick Roy <roypat@amazon.co.uk>
Autocrypt: addr=roypat@amazon.co.uk; keydata=
 xjMEY0UgYhYJKwYBBAHaRw8BAQdA7lj+ADr5b96qBcdINFVJSOg8RGtKthL5x77F2ABMh4PN
 NVBhdHJpY2sgUm95IChHaXRodWIga2V5IGFtYXpvbikgPHJveXBhdEBhbWF6b24uY28udWs+
 wpMEExYKADsWIQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbAwULCQgHAgIiAgYVCgkI
 CwIEFgIDAQIeBwIXgAAKCRBVg4tqeAbEAmQKAQC1jMl/KT9pQHEdALF7SA1iJ9tpA5ppl1J9
 AOIP7Nr9SwD/fvIWkq0QDnq69eK7HqW14CA7AToCF6NBqZ8r7ksi+QLOOARjRSBiEgorBgEE
 AZdVAQUBAQdAqoMhGmiXJ3DMGeXrlaDA+v/aF/ah7ARbFV4ukHyz+CkDAQgHwngEGBYKACAW
 IQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbDAAKCRBVg4tqeAbEAtjHAQDkh5jZRIsZ
 7JMNkPMSCd5PuSy0/Gdx8LGgsxxPMZwePgEAn5Tnh4fVbf00esnoK588bYQgJBioXtuXhtom
 8hlxFQM=
In-Reply-To: <ZexEkGkNe_7UY7w6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=52.119.213.156;
 envelope-from=prvs=8567b36a1=roypat@amazon.co.uk;
 helo=smtp-fw-52005.amazon.com
X-Spam_score_int: -122
X-Spam_score: -12.3
X-Spam_bar: ------------
X-Spam_report: (-12.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 May 2024 08:43:48 -0400
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

Hi all,

On 3/9/24 11:14, Mike Rapoport wrote:

>>> >>> With this in mind, what’s the best way to solve getting guest RAM out of
>>> >>> the direct map? Is memfd_secret integration with KVM the way to go, or
>>> >>> should we build a solution on top of guest_memfd, for example via some
>>> >>> flag that causes it to leave memory in the host userspace’s page tables,
>>> >>> but removes it from the direct map?
>> >> memfd_secret obviously gets you a PoC much faster, but in the long term I'm quite
>> >> sure you'll be fighting memfd_secret all the way.  E.g. it's not dumpable, it
>> >> deliberately allocates at 4KiB granularity (though I suspect the bug you found
>> >> means that it can be inadvertantly mapped with 2MiB hugepages), it has no line
>> >> of sight to taking userspace out of the equation, etc.
>> >>
>> >> With guest_memfd on the other hand, everyone contributing to and maintaining it
>> >> has goals that are *very* closely aligned with what you want to do.
> > I agree with Sean, guest_memfd seems a better interface to use. It's
> > integrated by design with KVM and removing guest memory from the direct map
> > looks like a natural enhancement to guest_memfd.
> >
> > Unless I'm missing something, for fast-and-dirty POC it'll be a oneliner
> > that adds set_memory_np() to kvm_gmem_get_folio() and then figuring out
> > what to do with virtio :)

We’ve been playing around with extending guest_memfd to remove guest memory
from the direct map. Removal from direct map aspect is indeed fairly
straight-forward; since we cannot map guest_memfd, we don’t need to worry about
folios without direct map entries getting to places where they will cause
kernel panics.

However, we ran into problems running non-CoCo VMs with guest_memfd for guest
memory, independent of direct map entries being available or not. There’s a
handful of places where a traditional KVM / Userspace setup currently touches
guest memory:

* Loading the Guest Kernel into guest-owned memory
* Instruction fetch from arbitrary guest addresses and guest page table walks  
  for MMIO emulation (for example for IOAPIC accesses)
* kvm-clock
* I/O devices

With guest_memfd, if the guest is running from guest-private memory, these need
to be rethought, since now the memory is unavailable to userspace, and KVM is
not enlightened about guest_memfd’s existance everywhere (when I was
experimenting with this, it generally read garbage data from the shared VMA,
but I think I’ve since seen some patches floating around that would make it
return -EFAULT instead).

CoCo VMs have various methods for working around these: You load a guest kernel
using some “populate on first access” mechanism [1], kvm-clock and I/O is
solved by having the guest mark the relevant address ranges as “shared” ahead
of time [2] and bounce buffering via swiotlb [4], and Intel TDX solves the
instruction emulation problem for MMIO by injecting a #VE and having the guest
do the emulation itself [3].

For non-CoCo VMs, where memory is not encrypted, and the threat model assumes a
trusted host userspace, we would like to avoid changing the VM model so
completely. If we adopt CoCo’s approaches where KVM / Userspace touches guest
memory we would get all the complexity, yet none of the encryption.
Particularly the complexity on the MMIO path seems nasty, but x86 does not
pre-decode instructions on MMIO exits (which are just EPT_VIOLATIONs) like it
does for PIO exits, so I also don’t really see a way around it in the
guest_memfd model.

We’ve played around a lot with allowing userspace mappings of guest_memfd, and
then having KVM internally access guest_memfd via userspace page tables (and
came up with multiple hacky ways to boot simple Linux initrds from
guest_memfd), but this is fairly awkward for two reasons:

1. Now lots of codepaths in KVM end up accessing guest_memfd, which from my
understanding goes against the guest_memfd goal of making machine checks
because of incorrect accesses to TDX memory impossible, and
2. We need to somehow get a userspace mapping of guest_memfd into KVM (a hacky
way I could make this work was setting up kvm_user_memory_region2 with
userspace_addr set to a mmap of guest_memory, which actually "works" for
everything but kvm-clock, but I also realized later that this is just
memfd_secret with extra steps).

We also played around with having KVM access guest_memfd through the direct map
(by temporarily reinserting pages into it when needed), but this again means
lots of KVM code learns about how to access guest RAM via guest_memfd.

There are a few other features we need to support, such as serving page faults
using UFFD, which we are not too sure how to realize with guest_memfd since
UFFD is VMA based (although to me some sort of “UFFD-for-FD” sounds like
something that’d be useful even outside of our guest_memfd usecase).

With these challenges in mind, some variant of memfd_secret continues to look
attractive for the non-CoCo case. Perhaps a variant that supports in-kernel
faults and provides some way for gfn_to_pfn_cache users like kvm-clock to
restore the direct map entries.

Sean, you mentioned that you envision guest_memfd also supporting non-CoCo VMs.
Do you have some thoughts about how to make the above cases work in the
guest_memfd context?

> > --
> > Sincerely yours,
> > Mike.

Best,
Patrick

[1]: https://lore.kernel.org/kvm/20240404185034.3184582-1-pbonzini@redhat.com/T/#m4cc08ce3142a313d96951c2b1286eb290c7d1dac
[2]: https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/kvmclock.c#L227
[3]: https://www.kernel.org/doc/html/next/x86/tdx.html#mmio-handling
[4]: https://www.kernel.org/doc/html/next/x86/tdx.html#shared-memory-conversions


