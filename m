Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8922C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbb8-0002xI-N3; Wed, 05 Feb 2025 04:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfbam-0002u9-Ag; Wed, 05 Feb 2025 04:21:10 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfbaj-0006qJ-Sx; Wed, 05 Feb 2025 04:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738747266; x=1770283266;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=56YG1c6IAIg9q7pHPYpqG3eIIpnnTeky04Rw2vBMQro=;
 b=VB6MBCX+D97ORgjjOjjvSloFJ4i46p0gensW/xkGZYsEMNlcQDXG59vY
 GfhjWQK8Ws3cnMInMISe0foU0PQVzJGhlxOiX+bs54VMEDqhNrZ90MMhJ
 6T/NrgiD/ymtMIg+OkS1NJVJQ3XlW4d1Rv4kplkXuaaK00hcKq3pwtlh2
 FSAYcLyQSdVjT7JtC0kwuiQHPVdYIaMecz7UWYirCX4Cz4yNy6Y2Dnjnx
 LbHDHn+uqWWLHUPOXSfuDrzYDTt0uiEhvQoa3zk4lu1cnxA4ukf0iNyac
 Z8Oju8QGsYTJeTKKHMsWiY9vd0sxZk5FhVwFRwZZOV+99hTVDGgybOGzS A==;
X-CSE-ConnectionGUID: 25zGqCIKTRSTUY0h/EBO6g==
X-CSE-MsgGUID: FG/106HVSNaQHvmmOIiPKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49953593"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49953593"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 01:21:03 -0800
X-CSE-ConnectionGUID: k7DuzR3lQyyCo7Fz+E4wEA==
X-CSE-MsgGUID: 1LV8+IShRnmxQX//AdMedQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="111381205"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 01:21:01 -0800
Date: Wed, 5 Feb 2025 17:40:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
Message-ID: <Z6MyDtU8zpLxU1xo@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
 <Z5c8gVcUn4rzVpID@intel.com>
 <CABgObfbLaHXtoGAkUVW9CUXio-N_1A=Awq0=ZCY3G8sAO+9NXQ@mail.gmail.com>
 <Z6Mrs4l+fRF7jcay@intel.com>
 <8e5cbee9-4a37-4a7f-948d-52dccb27ddd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5cbee9-4a37-4a7f-948d-52dccb27ddd6@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Wed, Feb 05, 2025 at 10:10:01AM +0100, Paolo Bonzini wrote:
> Date: Wed, 5 Feb 2025 10:10:01 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
> 
> On 2/5/25 10:13, Zhao Liu wrote:
> > > > * The use of from():
> > > > 
> > > >                  let clk = bindings::qdev_init_clock_in(...)
> > > >                  Owned::from(&*clk)
> > > 
> > > In this case the C side wants to manage the reference that
> > > qdev_init_clock_in() returns; it is dropped in
> > > qdev_finalize_clocklist(). So Rust code needs to increase the
> > > refcount.
> > 
> > Pls forgive me for one more question about qdev_init_clock_in() on the C
> > side. :-)
> > 
> > qdev_init_clock_in() didn't unref `clk` after object_property_add_child(),
> > so it is intentional, to make the ref count of `clk` be 2:
> >   * 1 count is held by clocklist until qdev_finalize_clocklist().
> >   * another 1 is held by its parent via QOM Child<>.
> > 
> > Am I understanding it correctly?
> 
> Yes, that's more precise.  In Rust it will be 3, the two above plus the
> Owned<Clock>.

Thanks!

> Ah wait... qdev_finalize_clocklist() is only called _after_ the Rust struct
> is Drop::drop-ped, because device_finalize() is called after the subclass's
> instance_finalize.
> 
> So the result of qdev_init_clock_in(), strictly speaking, does not have to
> be an Owned<Clock>.  It can also be a &'device Clock; either is possible.
> Would you prefer that, or do you think it's enough to add a comment?
> 

I prefer the latter, i.e., keep current Owned<Clock> and add a comment
to mention something like "Although strictly speaking, it does not have
to be an Owned<Clock>. Owned<> is still worth favor to use to protect
Rust code from FFI. When unsure whether to use Owned<>, then use Owned<>."

-Zhao


