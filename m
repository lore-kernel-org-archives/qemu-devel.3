Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC532C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 07:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukdZM-0007Ot-TE; Sat, 09 Aug 2025 03:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukdYw-0007LK-Fz; Sat, 09 Aug 2025 03:00:18 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukdYt-0001pZ-ML; Sat, 09 Aug 2025 03:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754722816; x=1786258816;
 h=date:from:to:subject:message-id:references:mime-version:
 in-reply-to; bh=jWAJJZJYoSL/1+1FyWJ/8dG4v148oK9n9O/bfalXsNg=;
 b=UFVCCbjmD5Llc0PBwFHWSHgkcFGXAIfMNKtEXU/ryzm6kVs7CzWbOAi/
 3hi9KAAKIotqdA8VLwjvgTzIJFVpWqBxg9+lN5kmC3YNbwBTKHq2pGe6C
 7SJAYt7Caq4uuq8Nz0/ka8iJfaGPzUGPWJ82S3Qe+akhMGnEBU+FCUqFK
 WtE8iWAivR5n4kIYBWApu39ZdfHM2cJq08UsWmGYF1R2/D/NWe5dzRvfc
 1YEbrMzWdvfIVfnXgf52blQ+aVO8EdCZWW8nrYJAy4dVDzFW04nezzs0S
 agbsP2DDxX+4XB13OgvD/zJpqW+suFhAcCUWiz+HoeY4d6BF46As0Bs7B w==;
X-CSE-ConnectionGUID: qAiOVuBoRNmYyFi0qK9oYA==
X-CSE-MsgGUID: xNNOg4SJQT62XLoY6JRQGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="59673186"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="59673186"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2025 00:00:11 -0700
X-CSE-ConnectionGUID: K18upPvaR5ugUhEkd5SnVg==
X-CSE-MsgGUID: iM54Oq14RiqtsZBadXQU+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="165147944"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 09 Aug 2025 00:00:08 -0700
Date: Sat, 9 Aug 2025 15:21:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 13/26] rust: Add RCU bindings
Message-ID: <aJb3C8qbXQ1zx306@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-14-zhao1.liu@intel.com>
 <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
 <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

Thank you both!!

Please correct me is I'm wrong :).

On Thu, Aug 07, 2025 at 03:38:52PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:38:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 13/26] rust: Add RCU bindings
> 
> On 8/7/25 14:29, Manos Pitsidianakis wrote:
> 
> > > +//! Bindings for `rcu_read_lock` and `rcu_read_unlock`.
> > > +//! More details about RCU in QEMU, please refer docs/devel/rcu.rst.
> > > +
> > 
> > How about a RAII guard type? e.g. RCUGuard and runs `rcu_read_unlock` on Drop.
> 
> Clippy says Rcu not RCU.  :)
> 
> You're right, not just because it's nice but also because it bounds the
> dereference of the FlatView.  Something like this build on top of the guard
> object:
> 
> pub struct RcuCell<T> {
>     data: AtomicPtr<T>
> }
> 
> impl<T> RcuCell {
>     pub fn raw_get(&self) -> *mut T {
>         self.data.load(Ordering::Acquire)

I understand this tries to provide an equivalent to qatomic_rcu_read.
Ordering::Acquire is especially necessary, because at C side,
qatomic_rcu_read has a barrier.

>     }
> 
>     pub fn get<'g>(&self, _: &'g RcuGuard) -> Option<&'g T> {
>         unsafe {
>             self.raw_get().as_ref()
>         }
>     }
> }
> 
> Using this is a bit ugly, because you need transmute, but it's isolated:
> 
> impl AddressSpace {
>    pub fn get_flatview(&self, rcu: &'g Guard) -> &'g FlatView {

IIUC, this lifetime is using the "branded type" pattern as ParentInit.

>        let flatp = unsafe {
>            std::mem::transmute::<&*mut FlatView, &RcuCell<FlatView>>(
>                &self.0.as_ptr().current_map)
>        };
>        flatp.get(rcu)
>    }
> }
> 
> impl GuestAddressSpace for AddressSpace {
>     fn memory(&self) -> Self::T {
>         let rcu = RcuGuard::guard();
>         FlatViewRefGuard::new(self.get_flatview(rcu))
>     }
> }

With RcuGuard, then we are actually calling qatomic_rcu_read in the
rcu critical section, which greatly enhances safety. This is a good
design for RCU binding.

> > Destructors are not guaranteed to run or run only once, but the former
> > should happen when things go wrong e.g. crashes/aborts. You can add a
> > flag in the RCUGuard to make sure Drop runs unlock only once (since it
> > takes &mut and not ownership)
> 
> Yeah I think many things would go wrong if Arc could run its drop
> implementation more than once.
 
Good point.

In addition, about rcu_read_lock_held(), I thought at C side, there're
so many comments are saying "Called within RCU critical section" but
without any check.

So I wonder whether we should do some check for RCU critical section,
just like bql check via `assert!(bql_locked())`. Maybe we can have a
Rcu debug feature to cover all these checks.

Thanks,
Zhao



