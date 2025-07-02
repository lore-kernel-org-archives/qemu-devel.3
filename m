Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C4FC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 04:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWpYM-0001h6-Eu; Wed, 02 Jul 2025 00:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWpY6-0001gA-OA; Wed, 02 Jul 2025 00:58:26 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWpY4-0005hi-Lg; Wed, 02 Jul 2025 00:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751432301; x=1782968301;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hcjSv6YuUYUHJ3M3kRfBMjY/KnSHcslCYgA8Hr9fhHI=;
 b=IG6g3YzxGa/f9WA04RYspkp8jq86B4UcESjdID55iItGEOOw8MM5PUZu
 jpke7EtSjy1lCzYBjRqWAasffTXCO74KzSqM8EK5ggw/K5dvZDvwzLdIG
 m7l7n70OPl8Hvs2rma16G9taz0a1pFrGXBFHYjGE5SpIWzciYWxJyqBpn
 5ANZiuK01ry5b96Tthv+voHfCP3gbB0DQvcBuWhWzLsaJ5rl8KpBmz8hK
 iIJurtUrCQ+ooeUTm44EbQcBSoT5JSRngAv4yWYyjyT5yN6khb8dXHw6L
 XyaNPRu9sJSVjVSEZmYGArVl33YDPrhUDyKzwr4EZ6iGZzppVhkP6HcRr w==;
X-CSE-ConnectionGUID: L1q8RWpwQaOywovOL4Uqaw==
X-CSE-MsgGUID: 1RQRUM2dTEGFvqjkWWs7eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57493262"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="57493262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 21:58:14 -0700
X-CSE-ConnectionGUID: KbtBOj5hTmCzbQkpD0FVNg==
X-CSE-MsgGUID: W9Gn4OazRjOIYTE3mf/g6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="154514218"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 01 Jul 2025 21:58:11 -0700
Date: Wed, 2 Jul 2025 13:19:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <aGTBaN/Nu3AYMHUU@intel.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com>
 <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com> <20250701150500.3a4001e9@fedora>
 <aGQ-ke-pZhzLnr8t@char.us.oracle.com> <aGS9E6pT0I57gn+e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGS9E6pT0I57gn+e@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > > > Could you please tell me what the Windows's wrong code is? And what's
> > > > wrong when someone is following the hardware spec?
> > > 
> > > the reason is that it's reserved on AMD hence software shouldn't even try
> > > to use it or make any decisions based on that.
> > > 
> > > 
> > > PS:
> > > on contrary, doing such ad-hoc 'cleanups' for the sake of misbehaving
> > > guest would actually complicate QEMU for no big reason.
> > 
> > The guest is not misbehaving. It is following the spec.
> 
> (That's my thinking, and please feel free to correct me.)
> 
> I had the same thought. Windows guys could also say they didn't access
> the reserved MSR unconditionally, and they followed the CPUID feature
> bit to access that MSR. When CPUID is set, it indicates that feature is
> implemented.
> 
> At least I think it makes sense to rely on the CPUID to access the MSR.
> Just as an example, it's unlikely that after the software finds a CPUID
> of 1, it still need to download the latest spec version to confirm
> whether the feature is actually implemented or reserved.

If the encountered feature bit is indeed not expected (truly reserved),
the processor would be considered faulty and may be fixed in a new
stepping. This is similar to the debate over whether software should
adhere to the spec or whether hardware (emulation) should comply.

> Based on the above point, this CPUID feature bit is set to 1 in KVM and
> KVM also adds emulation (as a fix) specifically for this MSR. This means
> that Guest is considered to have valid access to this feature MSR,
> except that if Guest doesn't get what it wants, then it is reasonable
> for Guest to assume that the current (v)CPU lacks hardware support and
> mark it as "unsupported processor".
 

