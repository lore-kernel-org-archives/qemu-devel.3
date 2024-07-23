Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF508C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGRn-0004n3-VY; Tue, 23 Jul 2024 10:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWGRl-0004cW-1A; Tue, 23 Jul 2024 10:24:57 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWGRd-0000OD-1n; Tue, 23 Jul 2024 10:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721744690; x=1753280690;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=596BeOYL/C3YYG4gWapj0nT35ULqFklo7XcRsaU+a60=;
 b=aTD2zwAwsIe509jYLMn73190qOa7EuXx6sNbkYEaMhrlo9goZ5JbsgVV
 TQc5YckbFEB8j3EOfWBhS3tI76vWAmOr8DXCMg64sM7Arpe3S36/rjnTU
 SrV+uK7X/g/9DzaakKZ88IM9cMZcX8vqb1n0AG3xfBHDmR+WbDJ30wres
 RRGZ0jRQ1je/NHa9tnnlHVnt4joRQx9APX6D3cEJ4dVMEnOiRrkxQ9C9L
 8/XCNR8k3pz8/eCPO5b3qUSeJ4rcy0FCx+ylyS7G8NjSbPOPNbnomBew1
 xUJD/KFdzwuAjygO9aO97wULtvz3Ku817Tblon2xX5rvvo4s9NZ93CN+5 Q==;
X-CSE-ConnectionGUID: p+t/JGkPSrSZxFaG+r1WPA==
X-CSE-MsgGUID: m9ifGGQnRtyIhmhM8fNmxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="41900222"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="41900222"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 07:24:47 -0700
X-CSE-ConnectionGUID: hXBJ3rbPRQalpxStCGyFjw==
X-CSE-MsgGUID: 4ge7qOlyTr2QSQ3s+KE7WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="52188455"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 23 Jul 2024 07:24:41 -0700
Date: Tue, 23 Jul 2024 22:40:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 1/8] hw/core: Make CPU topology enumeration arch-agnostic
Message-ID: <Zp/A2W5A0BqjRjR2@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-2-zhao1.liu@intel.com>
 <875xsx4l13.fsf@pond.sub.org> <Zp5mRrjuZWnE+9gz@intel.com>
 <87ed7kwh2x.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed7kwh2x.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, Jul 23, 2024 at 12:14:30PM +0200, Markus Armbruster wrote:
> Date: Tue, 23 Jul 2024 12:14:30 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 1/8] hw/core: Make CPU topology enumeration
>  arch-agnostic
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Hi Markus,
> >
> > On Mon, Jul 22, 2024 at 03:24:24PM +0200, Markus Armbruster wrote:
> >> Date: Mon, 22 Jul 2024 15:24:24 +0200
> >> From: Markus Armbruster <armbru@redhat.com>
> >> Subject: Re: [PATCH 1/8] hw/core: Make CPU topology enumeration
> >>  arch-agnostic
> >> 
> >> One little thing...
> >> 
> >> Zhao Liu <zhao1.liu@intel.com> writes:
> >> 
> >> > Cache topology needs to be defined based on CPU topology levels. Thus,
> >> > define CPU topology enumeration in qapi/machine.json to make it generic
> >> > for all architectures.
> >> >
> >> > To match the general topology naming style, rename CPU_TOPO_LEVEL_SMT
> >> > and CPU_TOPO_LEVEL_PACKAGE to CPU_TOPO_LEVEL_THREAD and
> >> > CPU_TOPO_LEVEL_SOCKET.
> >> >
> >> > Also, enumerate additional topology levels for non-i386 arches, and add
> >> > a CPU_TOPO_LEVEL_DEFAULT to help future smp-cache object de-compatibilize
> >> > arch-specific cache topology settings.
> >> >
> >> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >> 
> >> [...]
> >> 
> >> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> >> > index fa6bd71d1280..82413c668bdb 100644
> >> > --- a/qapi/machine-common.json
> >> > +++ b/qapi/machine-common.json
> >> > @@ -5,7 +5,7 @@
> >> >  # See the COPYING file in the top-level directory.
> >> >  
> >> >  ##
> >> > -# = Machines S390 data types
> >> > +# = Common machine types
> >> >  ##
> >> >  
> >> >  ##
> >> > @@ -19,3 +19,48 @@
> >> >  { 'enum': 'CpuS390Entitlement',
> >> >    'prefix': 'S390_CPU_ENTITLEMENT',
> >> >    'data': [ 'auto', 'low', 'medium', 'high' ] }
> >> > +
> >> > +##
> >> > +# @CpuTopologyLevel:
> >> > +#
> >> > +# An enumeration of CPU topology levels.
> >> > +#
> >> > +# @invalid: Invalid topology level.
> >> > +#
> >> > +# @thread: thread level, which would also be called SMT level or
> >> > +#     logical processor level.  The @threads option in
> >> > +#     SMPConfiguration is used to configure the topology of this
> >> > +#     level.
> >> > +#
> >> > +# @core: core level.  The @cores option in SMPConfiguration is used
> >> > +#     to configure the topology of this level.
> >> > +#
> >> > +# @module: module level.  The @modules option in SMPConfiguration is
> >> > +#     used to configure the topology of this level.
> >> > +#
> >> > +# @cluster: cluster level.  The @clusters option in SMPConfiguration
> >> > +#     is used to configure the topology of this level.
> >> > +#
> >> > +# @die: die level.  The @dies option in SMPConfiguration is used to
> >> > +#     configure the topology of this level.
> >> > +#
> >> > +# @socket: socket level, which would also be called package level.
> >> > +#     The @sockets option in SMPConfiguration is used to configure
> >> > +#     the topology of this level.
> >> > +#
> >> > +# @book: book level.  The @books option in SMPConfiguration is used
> >> > +#     to configure the topology of this level.
> >> > +#
> >> > +# @drawer: drawer level.  The @drawers option in SMPConfiguration is
> >> > +#     used to configure the topology of this level.
> >> > +#
> >> > +# @default: default level.  Some architectures will have default
> >> > +#     topology settings (e.g., cache topology), and this special
> >> > +#     level means following the architecture-specific settings.
> >> > +#
> >> > +# Since: 9.1
> >> > +##
> >> > +{ 'enum': 'CpuTopologyLevel',
> >> > +  'prefix': 'CPU_TOPO_LEVEL',
> >> 
> >> Why set a 'prefix'?
> >> 
> >
> > Because my previous i386 commit 6ddeb0ec8c29 ("i386/cpu: Introduce bitmap
> > to cache available CPU topology levels") introduced the level
> > enumeration with such prefix. For naming consistency, and to shorten the
> > length of the name, I've used the same prefix here as well.
> >
> > I've sensed that you don't like the TOPO abbreviation and I'll remove the
> > prefix :-).
> 
> Consistency is good, but I'd rather achieve it by consistently using
> "topology".
> 
> I never liked the 'prefix' feature much.  We have it because the mapping
> from camel case to upper case with underscores is heuristical, and can
> result in something undesirable.  See commit 351d36e454c (qapi: allow
> override of default enum prefix naming).  Using it just to shorten
> generated identifiers is a bad idea.

Thanks for your clarification! I see, I will drop the prefix.

Regards,
Zhao



