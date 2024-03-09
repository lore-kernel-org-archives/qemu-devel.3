Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC80C54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 05:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rioqR-0004XO-Kt; Sat, 09 Mar 2024 00:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <willy@infradead.org>)
 id 1rioqP-0004XE-RT
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 00:02:01 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <willy@infradead.org>)
 id 1rioqN-0002ep-Uk
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 00:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=+dmMM5sP7jm3IQ10EcQ/oF53RCutABKC3zszuGrAmug=; b=eRJRVBpP+hDPeoTydnpfcslrF5
 OKFRYKTa5B6RZFEBTEK6/4mjHjm28ta2hKtmtGrqjxGKR5O734E0NeGJmlm7ExuM2STIynpmddZ9H
 qO8ZldGhRT0e1F6gZPRniijUVk0O+fBLf1pg06nGeYsL+0mcB/0raj038qT01w/YGdX0qjqJ8YeQt
 woBYG23ofHBQd1n1UALctDWDNUNohTngFj1uTLmnn31gMErQOZ2xlbFW/LMNQsPG2daE8JQDEHeW2
 RJOJ4cJJAouXMC0fwU/wHVZlFwOQTNDearcplJIJuDsDRdR576zbwrra/FDh9Ne3MLTh9A8/t2JUa
 BZxbM+cA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rioq9-0000000D3Cq-1PKl;
 Sat, 09 Mar 2024 05:01:45 +0000
Date: Sat, 9 Mar 2024 05:01:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "seanjc@google.com" <seanjc@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "Roy, Patrick" <roypat@amazon.co.uk>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "Manwaring, Derek" <derekmn@amazon.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>,
 "mst@redhat.com" <mst@redhat.com>, "somlo@cmu.edu" <somlo@cmu.edu>,
 "Graf (AWS), Alexander" <graf@amazon.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
Message-ID: <ZevtORMrVbTsauzn@casper.infradead.org>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=willy@infradead.org; helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Fri, Mar 08, 2024 at 03:50:05PM +0000, Gowans, James wrote:
> Currently when using anonymous memory for KVM guest RAM, the memory all
> remains mapped into the kernel direct map. We are looking at options to
> get KVM guest memory out of the kernel’s direct map as a principled
> approach to mitigating speculative execution issues in the host kernel.
> Our goal is to more completely address the class of issues whose leak
> origin is categorized as "Mapped memory" [1].

One of the things that is holding Linux back is the inability to do I/O
to memory which is not part of memmap.  _So Much_ of our infrastructure
is based on having a struct page available to stick into an sglist, bio,
skb_frag, or whatever.  The solution to this is to move to a (phys_addr,
length) tuple instead of (page, offset, len) tuple.  I call this "phyr"
and I've written about it before.  I'm not working on this as I have
quite enough to do with the folio work, but I hope somebody works on it
before I get time to.

