Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F17AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtMx-0003TD-5t; Mon, 22 Jul 2024 09:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVtMn-0003Pl-20; Mon, 22 Jul 2024 09:46:17 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVtMi-0005DF-JP; Mon, 22 Jul 2024 09:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721655973; x=1753191973;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0VBpJCAF/a++txWiiz/0DTFqCVwBxK6I/Uf6ZwYzsFM=;
 b=GB+Z8DDaW4U5ycMiudD0lY5wB28u2FrQjt00F2+6HbL4xqYzSaSW9ZQY
 17N0D/vbYCXivP1+FIyHyXzQSZ/Sn2eeBMku4QOhE1d8RubJXPi4o7JpF
 t4MMIY5Oo2VvoAjwZEfjDrzAWOpUuCbBBwOkcxrkvA+d6uj7Nd63csKHj
 PAc0Zh3M2dUsa0Y2IUaMRFyQ5pfQosxPtpWLMhIVdm/r16dfq6gipmSH6
 tbLkhluQhiEmHiikf96guzdtl8bx0XATFZT3dYPHLvDHYvJM4HgL7lU0R
 PUAQzEwI00wyrNe+Gc8ZbhFgU/ath2WQTbP7EwNTl/9lXsYd3wZrinaNg w==;
X-CSE-ConnectionGUID: UgtzinQeRkanvnJa9vjibw==
X-CSE-MsgGUID: RJhdkX3jR7mRuDP5a80kRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19353449"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="19353449"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 06:46:04 -0700
X-CSE-ConnectionGUID: KKANULJsSICbrZipe8omdg==
X-CSE-MsgGUID: A6QV4KAqQ76bUFCb7lKS1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="51954848"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 22 Jul 2024 06:45:59 -0700
Date: Mon, 22 Jul 2024 22:01:42 +0800
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
Message-ID: <Zp5mRrjuZWnE+9gz@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-2-zhao1.liu@intel.com>
 <875xsx4l13.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xsx4l13.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

Hi Markus,

On Mon, Jul 22, 2024 at 03:24:24PM +0200, Markus Armbruster wrote:
> Date: Mon, 22 Jul 2024 15:24:24 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 1/8] hw/core: Make CPU topology enumeration
>  arch-agnostic
> 
> One little thing...
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Cache topology needs to be defined based on CPU topology levels. Thus,
> > define CPU topology enumeration in qapi/machine.json to make it generic
> > for all architectures.
> >
> > To match the general topology naming style, rename CPU_TOPO_LEVEL_SMT
> > and CPU_TOPO_LEVEL_PACKAGE to CPU_TOPO_LEVEL_THREAD and
> > CPU_TOPO_LEVEL_SOCKET.
> >
> > Also, enumerate additional topology levels for non-i386 arches, and add
> > a CPU_TOPO_LEVEL_DEFAULT to help future smp-cache object de-compatibilize
> > arch-specific cache topology settings.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> [...]
> 
> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > index fa6bd71d1280..82413c668bdb 100644
> > --- a/qapi/machine-common.json
> > +++ b/qapi/machine-common.json
> > @@ -5,7 +5,7 @@
> >  # See the COPYING file in the top-level directory.
> >  
> >  ##
> > -# = Machines S390 data types
> > +# = Common machine types
> >  ##
> >  
> >  ##
> > @@ -19,3 +19,48 @@
> >  { 'enum': 'CpuS390Entitlement',
> >    'prefix': 'S390_CPU_ENTITLEMENT',
> >    'data': [ 'auto', 'low', 'medium', 'high' ] }
> > +
> > +##
> > +# @CpuTopologyLevel:
> > +#
> > +# An enumeration of CPU topology levels.
> > +#
> > +# @invalid: Invalid topology level.
> > +#
> > +# @thread: thread level, which would also be called SMT level or
> > +#     logical processor level.  The @threads option in
> > +#     SMPConfiguration is used to configure the topology of this
> > +#     level.
> > +#
> > +# @core: core level.  The @cores option in SMPConfiguration is used
> > +#     to configure the topology of this level.
> > +#
> > +# @module: module level.  The @modules option in SMPConfiguration is
> > +#     used to configure the topology of this level.
> > +#
> > +# @cluster: cluster level.  The @clusters option in SMPConfiguration
> > +#     is used to configure the topology of this level.
> > +#
> > +# @die: die level.  The @dies option in SMPConfiguration is used to
> > +#     configure the topology of this level.
> > +#
> > +# @socket: socket level, which would also be called package level.
> > +#     The @sockets option in SMPConfiguration is used to configure
> > +#     the topology of this level.
> > +#
> > +# @book: book level.  The @books option in SMPConfiguration is used
> > +#     to configure the topology of this level.
> > +#
> > +# @drawer: drawer level.  The @drawers option in SMPConfiguration is
> > +#     used to configure the topology of this level.
> > +#
> > +# @default: default level.  Some architectures will have default
> > +#     topology settings (e.g., cache topology), and this special
> > +#     level means following the architecture-specific settings.
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'CpuTopologyLevel',
> > +  'prefix': 'CPU_TOPO_LEVEL',
> 
> Why set a 'prefix'?
> 

Because my previous i386 commit 6ddeb0ec8c29 ("i386/cpu: Introduce bitmap
to cache available CPU topology levels") introduced the level
enumeration with such prefix. For naming consistency, and to shorten the
length of the name, I've used the same prefix here as well.

I've sensed that you don't like the TOPO abbreviation and I'll remove the
prefix :-).

Thanks,
Zhao



