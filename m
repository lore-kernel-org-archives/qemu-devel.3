Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD71C5475B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 02:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rimj1-0005de-Nw; Fri, 08 Mar 2024 21:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=791ae7193=derekmn@amazon.com>)
 id 1rimiz-0005dM-Gc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 21:46:13 -0500
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=791ae7193=derekmn@amazon.com>)
 id 1rimir-0007Xa-El
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 21:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1709952366; x=1741488366;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FaGxOMw8hAeHVyQkCVZb0DCHhnDYyHKuxNIwAvfWDWA=;
 b=UiGeFX4VXOFm9itDRjwetd6/yiALuc0NFJw+jipkVRc7gm01QbbkXvw/
 HL2YdoQKn1lgM/vqMgu9TatXVeoS5Szgn/iZJ0rSikhQncoOAgzLLaSYq
 VcX2WWTFMayj1JEejNCOPO0Xk8SxBca7atw9fss8C2vAGTyM4bXgrQqkN c=;
X-IronPort-AV: E=Sophos;i="6.07,111,1708387200"; d="scan'208";a="643486831"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 02:46:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:58391]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.222:2525]
 with esmtp (Farcaster)
 id 8be3daf9-db1b-4473-aca9-d0c64320ade8; Sat, 9 Mar 2024 02:46:01 +0000 (UTC)
X-Farcaster-Flow-ID: 8be3daf9-db1b-4473-aca9-d0c64320ade8
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 9 Mar 2024 02:46:01 +0000
Received: from [192.168.12.128] (10.106.101.5) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 9 Mar 2024 02:45:59 +0000
Message-ID: <8e3c2b45-356d-4ca9-bebc-012505235142@amazon.com>
Date: Fri, 8 Mar 2024 19:45:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
Content-Language: en-US
To: David Matlack <dmatlack@google.com>, Brendan Jackman <jackmanb@google.com>
CC: "Gowans, James" <jgowans@amazon.com>, "seanjc@google.com"
 <seanjc@google.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "Roy, Patrick" <roypat@amazon.co.uk>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Woodhouse, David"
 <dwmw@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>, "Liam.Howlett@oracle.com"
 <Liam.Howlett@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "mst@redhat.com" <mst@redhat.com>,
 "somlo@cmu.edu" <somlo@cmu.edu>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>, <tabba@google.com>,
 <qperret@google.com>, <jason.cj.chen@intel.com>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <CA+i-1C34VT5oFQL7en1n+MdRrO7AXaAMdNVvjFPxOaTDGXu9Dw@mail.gmail.com>
 <CALzav=fO2hpaErSRHGCJCKTrJKD7b9F5oEg7Ljhb0u1gB=VKwg@mail.gmail.com>
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <CALzav=fO2hpaErSRHGCJCKTrJKD7b9F5oEg7Ljhb0u1gB=VKwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.101.5]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=791ae7193=derekmn@amazon.com; helo=smtp-fw-52003.amazon.com
X-Spam_score_int: -124
X-Spam_score: -12.5
X-Spam_bar: ------------
X-Spam_report: (-12.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
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

On 2024-03-08 10:36-0700, David Matlack wrote:
> On Fri, Mar 8, 2024 at 8:25 AM Brendan Jackman <jackmanb@google.com> wrote:
> > On Fri, 8 Mar 2024 at 16:50, Gowans, James <jgowans@amazon> wrote:
> > > Our goal is to more completely address the class of issues whose leak
> > > origin is categorized as "Mapped memory" [1].
> >
> > Did you forget a link below? I'm interested in hearing about that
> > categorisation.

The paper from Hertogh, et al. is https://download.vusec.net/papers/quarantine_raid23.pdf
specifically Table 1.

> > It's perhaps a bigger hammer than you are looking for, but the
> > solution we're working on at Google is "Address Space Isolation" (ASI)
> > - the latest posting about that is [2].
>
> I think what James is looking for (and what we are also interested
> in), is _eliminating_ the ability to access guest memory from the
> direct map entirely.

Actually, just preventing speculation of guest memory through the
direct map is sufficient for our current focus.

Brendan,
I will look into the general ASI approach, thank you. Did you consider
memfd_secret or a guest_memfd-based approach for Userspace-ASI? Based on
Sean's earlier reply to James it sounds like the vision of guest_memfd
aligns with ASI's goals.

Derek

