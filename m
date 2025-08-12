Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E738CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 15:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulqlH-0001HD-E7; Tue, 12 Aug 2025 11:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ulql7-0001Fp-QV; Tue, 12 Aug 2025 11:17:55 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ulqkx-0001Sy-As; Tue, 12 Aug 2025 11:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755011863; x=1786547863;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3uVy5fm0KqGsfq4C65CV/shj9B2bZzaaYfgbLDrDKd4=;
 b=b4WTyg77FRB3mdODjRTTy3Mjvwl5KM7yccnhwCW4UT+1+rZActfDtUmk
 c+DDWNs72jJYnwZNJDGbkuz4OMV/Q5pHXP474AZgmZ3LuhDHOUKXU75en
 j4hGBFURZ6z+qQBQRLe7UWIo+ozGut73rHYtWqBisWk3SDCn/dx3SMbgK
 LSW0SAk02IYQyy/d3nBj7OrwB9M85X+xtnfZ9R7+mCpzO2dx3BViKv9nV
 6WvMyyrG5RqzQP0uafUCNKk6Bi8Riqxmr1+/2J92I6ND3H4ahUeftaGZd
 3sY4JSYpPuPP+O6K+j1mJYBD53vbm4X9j4EKas0k8TrWDXb+v6wkJdAdY g==;
X-CSE-ConnectionGUID: MEJXTqZSRuWYAlbqgUV+2A==
X-CSE-MsgGUID: k7EOh7dWRrCUJoMAdtdqcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74870784"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="74870784"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 08:17:34 -0700
X-CSE-ConnectionGUID: Fh55jcrgR36fEdysJB96RQ==
X-CSE-MsgGUID: Sgv1v1ZFScKU4cHjz+EOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="171552087"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 12 Aug 2025 08:17:31 -0700
Date: Tue, 12 Aug 2025 23:39:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 16/26] memory: Make flatview_do_translate() return a
 pointer to MemoryRegionSection
Message-ID: <aJtgIBgl8JzDsJ1O@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-17-zhao1.liu@intel.com>
 <beab841b-9c69-43d2-b996-879eee9e1120@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beab841b-9c69-43d2-b996-879eee9e1120@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 03:57:17PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:57:17 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 16/26] memory: Make flatview_do_translate() return a
>  pointer to MemoryRegionSection
> 
> On 8/7/25 14:30, Zhao Liu wrote:
> > Rust side will use cell::Opaque<> to hide details of C structure, and
> > this could help avoid the direct operation on C memory from Rust side.
> > 
> > Therefore, it's necessary to wrap a translation binding and make it only
> > return the pointer to MemoryRegionSection, instead of the copy.
> > 
> > As the first step, make flatview_do_translate return a pointer to
> > MemoryRegionSection, so that we can build a wrapper based on it.
> 
> Independent of Rust, doing the copy as late as possible is good, but make it
> return a "const MemoryRegionSection*" so that there's no risk of overwriting
> data.

Yes, const MemoryRegionSection* is helpful...

> Hopefully this does not show a bigger problem!

...then we will get `*const bindings::MemoryRegionSection` from
flatview_translate_section().

This is mainly about how to construct Opaque<T> from `*cont T`:

impl FlatView {
    fn translate(
        &self,
        addr: GuestAddress,
        len: GuestUsize,
        is_write: bool,
    ) -> Option<(&MemoryRegionSection, MemoryRegionAddress, GuestUsize)> {
        ...
        let ptr = unsafe {
            flatview_translate_section(
                self.as_mut_ptr(),
                addr.raw_value(),
                &mut raw_addr,
                &mut remain,
                is_write,
                MEMTXATTRS_UNSPECIFIED,
            )
        };

        ...

------> // Note here, Opaque<>::from_raw() requires *mut T.
	// And we can definitely convert *cont T to *mut T!
        let s = unsafe { <FlatView as GuestMemory>::R::from_raw(ptr as *mut _) };
        ...
    }

But look closer to Opaque<>, it has 2 safe methods: as_mut_ptr() &
raw_get().

These 2 methods indicate that the T pointed by Qpaque<T> is mutable,
which has the conflict with the original `*const bindings::MemoryRegionSection`.

So from this point, it seems unsafe to use Qpaque<> on this case.

To address this, I think we need:
 - rich comments about this MemoryRegionSection is actually immuatble.
 - modify other C functions to accept `const *MemoryRegionSection` as
   argument.

What do you think?

Thanks,
Zhao


