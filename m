Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46BBCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxm36-0002oe-0T; Mon, 07 Oct 2024 07:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxm33-0002oF-Ao; Mon, 07 Oct 2024 07:37:09 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxm30-000336-Ov; Mon, 07 Oct 2024 07:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728301027; x=1759837027;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jaVghokLkYagComBJOIsqVtMl7fwxtcDqAjAsloR16M=;
 b=kUdlt26rj2xuEPDGSDQy2j6gZRIN/KiW3NDVfSepp1VwvMMKqOh1flvi
 hCkVcMf46Y2FNI9VTE4tyYKDow0/VvHjPphM+32P0OdmL1VY+zCZ1M9nr
 9ZyM3nBa/CfEW6zR/O79ohSkdoPkRrkaTFZIUqCkGMtKXEaypdiFtLfi1
 w3lGMWvvxBKMJoTQ357uVhEb5PXS9AVi1ScDOrbiZW/EiFX5Fg+Hp/H7Q
 CEyY7zv8HCZCaoIcRWii3+sAcVSIaDmqWGqdr6rcGUxi8nST+3aOosoG8
 l+X7YY0ura0vV/qXY6FMpvaIbjoiBdsKKQY66AU7/AEMOcT14il1YWB7/ w==;
X-CSE-ConnectionGUID: JQ7StqtbTaC0JHrXpLiYCA==
X-CSE-MsgGUID: UJGLbFIdQ7WQ8hoAJC5MJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="31237685"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="31237685"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 04:37:03 -0700
X-CSE-ConnectionGUID: 0/ZcA+bqQ8i8F/qPbC/qAA==
X-CSE-MsgGUID: b1Gs2tQfTSqj5/6woMuvZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="98764773"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 07 Oct 2024 04:36:57 -0700
Date: Mon, 7 Oct 2024 19:53:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 7/7] i386/pc: Support cache topology in -machine for
 PC machine
Message-ID: <ZwPLpOt/DIvNO70f@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
 <20240908125920.1160236-8-zhao1.liu@intel.com>
 <20240917101631.00003dcb@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917101631.00003dcb@Huawei.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 17, 2024 at 10:16:31AM +0100, Jonathan Cameron wrote:
> Date: Tue, 17 Sep 2024 10:16:31 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [PATCH v2 7/7] i386/pc: Support cache topology in -machine for
>  PC machine
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Sun,  8 Sep 2024 20:59:20 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Allow user to configure l1d, l1i, l2 and l3 cache topologies for PC
> > machine.
> > 
> > Additionally, add the document of "-machine smp-cache" in
> > qemu-options.hx.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>
> Trivial language suggestions.
> In general looks good to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Hopefully QOM maintainers and others will get to this soon. 
> I'd like Ali's ARM series to land this cycle as well
> as the lack of this support has been a pain point for us
> for a while.
>
> Jonathan

Thanks! I'll refresh a new version.

[snip]

> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index d94e2cbbaeb1..3936ff3e77f9 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -39,7 +39,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
> >      "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
> >      "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> >      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
> > -    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
> > +    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
> > +    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
> 
> Now my cxl-fmw stuff has competition for most hideous element :)
> When we add a few more properties maybe we'll get an even longer line!

May JSON support can save us :). When I have time I will consider this.
Command line's keyval format is more convenient for configuring a single
element in an array.
 
> >      QEMU_ARCH_ALL)
> >  SRST
> >  ``-machine [type=]name[,prop=value[,...]]``
> > @@ -159,6 +160,31 @@ SRST
> >          ::
> >  
> >              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
> > +
> > +    ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
> > +        Define cache properties (now only the cache topology level) for SMP
> > +        system.
> 
> I'd drop the 'now only' bit.  Just means we have add noise updating that
> later.   It's easy enough to look down and see what is available anyway give
> the parameter docs follow immediately after this.

Agree.

> > +
> > +        ``cache=cachename`` specifies the cache that the properties will be
> > +        applied on. This field is the combination of cache level and cache
> > +        type. Currently it supports ``l1d`` (L1 data cache), ``l1i`` (L1
> 
> Drop the word Currently as I don't think it adds anything to he meaning.
> We are never going to add docs that say 'previously it supported' or 'in the
> future it will support'.
> 
> 	   "Supports ...
> 

Thanks! I will change to "It supports ..."

> > +        instruction cache), ``l2`` (L2 unified cache) and ``l3`` (L3 unified
> > +        cache).
> > +
> > +        ``topology=topologylevel`` sets the cache topology level. It accepts
> > +        CPU topology levels including ``thread``, ``core``, ``module``,
> > +        ``cluster``, ``die``, ``socket``, ``book``, ``drawer`` and a special
> > +        value ``default``. If ``default`` is set, then the cache topology will
> > +        follow the architecture's default cache topology model. If other CPU
> If another topology level is set
> 
> would be clearer.   I briefly read this as saying the topology for another CPU
> rather than a different value here.

Ah, yes, I agree.

> > +        topology level is set, the cache will be shared at corresponding CPU
> > +        topology level. For example, ``topology=core`` makes the cache shared
> > +        in a core.
> "by all threads within a core." perhaps?

Nice, it's more accurate.

Thanks,
Zhao


