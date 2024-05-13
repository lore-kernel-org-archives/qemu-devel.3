Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27E0C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 22:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6dkS-0008Gu-Dy; Mon, 13 May 2024 18:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=856bc4aeb=derekmn@amazon.com>)
 id 1s6dkN-000898-Ed
 for qemu-devel@nongnu.org; Mon, 13 May 2024 18:02:16 -0400
Received: from smtp-fw-9105.amazon.com ([207.171.188.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=856bc4aeb=derekmn@amazon.com>)
 id 1s6dkL-0006gG-5l
 for qemu-devel@nongnu.org; Mon, 13 May 2024 18:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1715637734; x=1747173734;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5+iQQpOEZdEkzvrHSJ41DjlAjDtbE5SACcQXxQVlFBs=;
 b=YM0fzoYhz8qGsunBElkHLQDbg2oiVC5oknDhL7SIRcyoYEfYopn7y07y
 rNT5DUq7fUA2/dTV9ujZNyXiOM00LvZU2lMvXTeyKtasocNUShutmIJuW
 Myh51Mah2vyFno03eaiEkgNc7l8g75pHYbyEk2MkZSjHRcpGCWeVE/uT3 w=;
X-IronPort-AV: E=Sophos;i="6.08,159,1712620800"; d="scan'208";a="726172843"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 22:02:08 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:19998]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.254:2525]
 with esmtp (Farcaster)
 id 166c483a-d211-48eb-b873-34e5ed9da520; Mon, 13 May 2024 22:01:52 +0000 (UTC)
X-Farcaster-Flow-ID: 166c483a-d211-48eb-b873-34e5ed9da520
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 22:01:49 +0000
Received: from [192.168.232.44] (10.106.101.48) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 22:01:48 +0000
Message-ID: <7107a45b-0635-4040-9f4c-288708b13c04@amazon.com>
Date: Mon, 13 May 2024 15:01:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
To: Sean Christopherson <seanjc@google.com>, James Gowans <jgowans@amazon.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>, Nikita Kalyazin <kalyazin@amazon.co.uk>,
 "rppt@kernel.org" <rppt@kernel.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Patrick Roy <roypat@amazon.co.uk>, "somlo@cmu.edu"
 <somlo@cmu.edu>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, David Woodhouse
 <dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Alexander Graf <graf@amazon.de>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>, "mst@redhat.com" <mst@redhat.com>, 
 Moritz Lipp <mlipp@amazon.at>, Claudio Canella <canellac@amazon.at>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com> <ZexEkGkNe_7UY7w6@kernel.org>
 <58f39f23-0314-4e34-a8c7-30c3a1ae4777@amazon.co.uk>
 <ZkI0SCMARCB9bAfc@google.com>
 <aaf684b5eb3a3fe9cfbb6205c16f0973c6f8bb07.camel@amazon.com>
 <ZkJFIpEHIQvfuzx1@google.com>
 <f880d0187e2d482bc8a8095cf5b7404ea9d6fb03.camel@amazon.com>
 <ZkJ37uwNOPis0EnW@google.com>
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <ZkJ37uwNOPis0EnW@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.101.48]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)
Received-SPF: pass client-ip=207.171.188.204;
 envelope-from=prvs=856bc4aeb=derekmn@amazon.com; helo=smtp-fw-9105.amazon.com
X-Spam_score_int: -128
X-Spam_score: -12.9
X-Spam_bar: ------------
X-Spam_report: (-12.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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

On 2024-05-13 13:36-0700, Sean Christopherson wrote:
> Hmm, a slightly crazy idea (ok, maybe wildly crazy) would be to support mapping
> all of guest_memfd into kernel address space, but as USER=1 mappings.  I.e. don't
> require a carve-out from userspace, but do require CLAC/STAC when access guest
> memory from the kernel.  I think/hope that would provide the speculative execution
> mitigation properties you're looking for?

This is interesting. I'm hesitant to rely on SMAP since it can be
enforced too late by the microarchitecture. But Canella, et al. [1] did
say in 2019 that the kernel->user access route seemed to be free of any
"Meltdown" effects. LASS sounds like it will be even stronger, though
it's not clear to me from Intel's programming reference that speculative
scenarios are in scope [2]. AMD does list SMAP specifically as a
feature that can control speculation [3].

I don't see an equivalent read-access control on ARM. It has PXN for
execute. Read access can probably also be controlled?  But I think for
the non-CoCo case we should favor solutions that are less dependent on
hardware-specific protections.

Derek


[1] https://www.usenix.org/system/files/sec19-canella.pdf
[2] https://cdrdv2.intel.com/v1/dl/getContent/671368
[3] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/software-techniques-for-managing-speculation.pdf

