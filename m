Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02DCC8303C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9yf-0001xs-DN; Wed, 02 Jul 2025 22:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uX9yc-0001xi-UT
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:47:06 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uX9yV-0007Jg-HV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510819; x=1783046819;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YQKtRaNRYRjIQE4Tta3bfFtvYj5tYn61eQlM6o0Zgvk=;
 b=MNiue9zX4RRPrAEN1077WsJCh95oOXVovMHf88qT5pAch0pC5Tmve8DS
 HXF4Y1+bphPdU8YUGHirGKIw+K794JDsa2pBtqcyJUZYbhJ957zKrcJta
 bVrB9A9tPNbo1HagSbkSe3/Q/SfwQi7zpaC6VZ6EEjn76XsNjzWMmuwMm
 JJpS1hGnyBM0mD2kDtdl7rkhGH26zb1YZ0fmltdG4ukit1JFRdlJEGtG8
 j8Khx9jL52aSYEZ2Fj+NmuV1RJzBAJJKaqLWzhhQ81TEpAcoGjnFF9ZPI
 ktpXC/YdfCUAs9FpxAekv5bbqx8vuPsbYw3Fa8BJv0O8SrMWM1z30D8HO Q==;
X-CSE-ConnectionGUID: bt6ruLVnTBWm/Wc+Y5gePg==
X-CSE-MsgGUID: r8uX3c3VQmi0VG5g5jbSBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53968149"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53968149"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:46:55 -0700
X-CSE-ConnectionGUID: ndHCoYGpTCG8xz42ywH23g==
X-CSE-MsgGUID: ozwhK9u6Qg6C73wBId+dcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="154321851"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 02 Jul 2025 19:46:52 -0700
Date: Thu, 3 Jul 2025 11:08:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
Message-ID: <aGX0Im2F6R4nTUh4@intel.com>
References: <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
 <aGTmFGC9vZB2yEwv@intel.com>
 <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
 <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
 <f7545434-f51f-4cb5-b1b9-afbaa26d11e8@intel.com>
 <CABgObfax21xZDKGN9b8tH-HBVeEgTjWD-xLO6DRkr3uCvkyHQQ@mail.gmail.com>
 <a7d2691b-ce43-454e-aec9-3589787dea5c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d2691b-ce43-454e-aec9-3589787dea5c@intel.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 03, 2025 at 09:03:10AM +0800, Xiaoyao Li wrote:
> Date: Thu, 3 Jul 2025 09:03:10 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
>  instance_post_init calls
> 
> On 7/3/2025 2:54 AM, Paolo Bonzini wrote:
> > Il mer 2 lug 2025, 09:25 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
> > 
> > > IIRC that's on rhel QEMU which ports the TDX code before it's merged
> > > upstream. Now TDX is upstreamed, it works with upstream compat property
> > > and I think future new compat property won't affect TDX or anything,
> > > since it's compat property and it's to guarantee the existing behavior
> > > when introducing new behavior?
> > > 
> > 
> > It's a compat property that is only added by RHEL-specific machine types.
> > But the bug is not specific to RHEL, it just happens that no upstream
> > machine type has compat properties that overlap with TDX adjustments of
> > CPUID.
> > 
> > > In general I don't see how the reverse order makes sense: the subclass
> > > > knows what the superclass does, so it can do the right thing if it runs
> > > > last; but the superclass cannot know what all of its subclasses do in
> > > > post_init, so it makes less sense to run it last.
> > > 
> > > I agree in general the parent to child order makes more sense,
> > > especially when we treat .instance_init() as the phase 1 init and
> > > .post_instance_init() as the phase 2 init.
> > > 
> > > But the original purpose of introducing .post_instance_init() was to
> > > ensure qdev_prop_set_globals() is called at last for Device. Reverse the
> > > order breaks this purpose.
> > > 
> > 
> > Not "last", but "after instance_init". Anything that happens in the child
> > class's instance_post_init can be moved at the end of instance_init, just
> > like the refactoring that I did for risc-v.
> 
> Move into the end of instance_init() can surely work. But it requires to
> split the code in instance_post_init() to different child's instance_init()
> or making sure the code in instance_post_init() is called at the end of each
> lowest child class.

Initially, when I proposed the split approach, it wasn't about
splitting for the sake of splitting, nor for the sake of "work".

A more granular split is just a means, and the goal is to place things
at different stages in the most appropriate locations.

> Besides, it also leads to a rule that child of Device's
> .post_instance_init() needs to be careful about changing the property or
> anything that might affect the property,

I believe that's how things should be. instance_post_init() provides an
opportunity to tweak properties. The order of instance_post_init()
reflects the dependency relationships for property adjustments. As I
mentioned earlier, if a property doesn't need to consider other factors
and is simply being initialized, instance_init() is the most appropriate
place for it.

> because it might break the usage of global properties.

Breaking global properties is just one example. Essentially, properties
like "vendor" don't adhere well to the semantics of QOM.

> This can surely work. But to me, it seems to make code worse not better.

IMO, it's not the split that makes things worse, but rather the improper
use of instance_post_init() that makes everything about the x86 CPU
fragile. Ideally, QOM/qdev should focus on their own abstraction order,
while the leaf-class should do the right thing in the right place, which
is the most solid situation.


