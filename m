Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75200C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 21:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkstc-0004mB-IV; Thu, 14 Mar 2024 17:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=796226c42=derekmn@amazon.com>)
 id 1rksta-0004ls-W8
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:45:51 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=796226c42=derekmn@amazon.com>)
 id 1rkstY-0000aN-Jd
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1710452749; x=1741988749;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vp3hGSwgMbzRk72sOUpHptWRQ85XgRAAacWGIwKWzDg=;
 b=aa0rWVgZtS8PibnoevugUC5l4uek1U9VIEoUzzgIBjeTqOf35o+if16x
 QDAj1P4Ymbhr6+LNqvY7ldJ9QH+AxGkAjArnN5alHiOKKNqsiWDDIQG7j
 IcK1Lt0H90qEPhvjyFP+QY8iACuIPtjiK5pNkQVmOGs3RB/dm81Q+qSKP 0=;
X-IronPort-AV: E=Sophos;i="6.07,126,1708387200"; d="scan'208";a="332923184"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-33001.sea14.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 21:45:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:4706]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.10:2525] with
 esmtp (Farcaster)
 id b3e2a354-b5d8-40da-9532-79da56e6a481; Thu, 14 Mar 2024 21:45:42 +0000 (UTC)
X-Farcaster-Flow-ID: b3e2a354-b5d8-40da-9532-79da56e6a481
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 14 Mar 2024 21:45:35 +0000
Received: from [10.119.229.181] (10.119.229.181) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 14 Mar 2024 21:45:34 +0000
Message-ID: <404fec0f-430b-44f1-8cdf-13573f0ae522@amazon.com>
Date: Thu, 14 Mar 2024 14:45:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
To: Sean Christopherson <seanjc@google.com>, James Gowans <jgowans@amazon.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Patrick Roy
 <roypat@amazon.co.uk>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Nikita Kalyazin <kalyazin@amazon.co.uk>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>, "Liam.Howlett@oracle.com"
 <Liam.Howlett@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "mst@redhat.com" <mst@redhat.com>,
 "somlo@cmu.edu" <somlo@cmu.edu>, Alexander Graf <graf@amazon.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>, <xmarcalx@amazon.com>, <tabba@google.com>,
 <qperret@google.com>, <kvmarm@lists.linux.dev>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com>
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <ZeudRmZz7M6fWPVM@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.119.229.181]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)
Received-SPF: pass client-ip=207.171.190.10;
 envelope-from=prvs=796226c42=derekmn@amazon.com; helo=smtp-fw-33001.amazon.com
X-Spam_score_int: -128
X-Spam_score: -12.9
X-Spam_bar: ------------
X-Spam_report: (-12.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 15:22:50 -0800, Sean Christopherson wrote:
> On Fri, Mar 08, 2024, James Gowans wrote:
> > We are also aware of ongoing work on guest_memfd. The current
> > implementation unmaps guest memory from VMM address space, but leaves it
> > in the kernel’s direct map. We’re not looking at unmapping from VMM
> > userspace yet; we still need guest RAM there for PV drivers like virtio
> > to continue to work. So KVM’s gmem doesn’t seem like the right solution?
>
> We (and by "we", I really mean the pKVM folks) are also working on allowing
> userspace to mmap() guest_memfd[*].  pKVM aside, the long term vision I have for
> guest_memfd is to be able to use it for non-CoCo VMs, precisely for the security
> and robustness benefits it can bring.
>
> What I am hoping to do with guest_memfd is get userspace to only map memory it
> needs, e.g. for emulated/synthetic devices, on-demand.  I.e. to get to a state
> where guest memory is mapped only when it needs to be.

Thank you for the direction, this is super helpful.

We are new to the guest_memfd space, and for simplicity we'd prefer to
leave guest_memfd completely mapped in userspace. Even in the long term,
we actually don't have any use for unmapping from host userspace. The
current form of marking pages shared doesn't quite align with what we're
trying to do either since it also shares the pages with the host kernel.

What are your thoughts on a flag for KVM_CREATE_GUEST_MEMFD that only
removes from the host kernel's direct map, but leaves everything mapped
in userspace?

Derek

