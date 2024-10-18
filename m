Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D640ED2127B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 08:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ieD-0000rH-5S; Fri, 18 Oct 2024 04:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1ieA-0000q6-3k; Fri, 18 Oct 2024 04:47:46 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1ie8-0003nP-Dn; Fri, 18 Oct 2024 04:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729241264; x=1760777264;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=plBfgMHQMuI+dLmqLkuBbIQUiwBm4swhKQlf4bzVhk8=;
 b=eAg8CLRIPrlXDWG+NytNYuzSvu8a1cRnY9PbU3eAGqdWeinL7iLiGlj3
 oiLZmD4u6SrpavJWbycD/osaoVaOIRomIZ9nuwFQ5e+7AXYbzGUrBAyE8
 xZv37BnKxdRfsilj5QyLGr21yCwmzGlq8XarvuH4e0546fwYFliMNCnT6
 CEnHRDxmRQxN7bNob4mYaVSM+0i4KcTDnfuElT1g8JLKn19RX9KGzwij1
 4B023z7/RjvyT7fElPLjcBR4lwc74arl7GXyJtHk8bnFvyBFG6DgUEIt8
 tl23/ZWJALAPlcgmkaPcWwFzFvGdQPYmPKS1sNXuB8LlH9md3dl4Rkahj g==;
X-CSE-ConnectionGUID: 2aoj5lNvSiCnV8N35vdfww==
X-CSE-MsgGUID: Yjg6M8D8Qn2f/XOVEEo2fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39306052"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39306052"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 01:47:40 -0700
X-CSE-ConnectionGUID: 1X6bbWVLRPKGDBLVB3+qyQ==
X-CSE-MsgGUID: 0qGpU8v8T3qusDQ6TdvBUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="102105838"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 18 Oct 2024 01:47:35 -0700
Date: Fri, 18 Oct 2024 17:03:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 6/7] i386/pc: Support cache topology in -machine for
 PC machine
Message-ID: <ZxIkdyJ2ysibi74R@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-7-zhao1.liu@intel.com>
 <ZxEs3DGGgCqGT5yK@redhat.com> <ZxHcsPyqT6MLJ9hG@intel.com>
 <ZxIVC-XQaMqOy6Fw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxIVC-XQaMqOy6Fw@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

On Fri, Oct 18, 2024 at 08:58:03AM +0100, Daniel P. Berrangé wrote:
> Date: Fri, 18 Oct 2024 08:58:03 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH v3 6/7] i386/pc: Support cache topology in -machine for
>  PC machine
> 
> On Fri, Oct 18, 2024 at 11:57:36AM +0800, Zhao Liu wrote:
> > Hi Daniel,
> > 
> > > > +    ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
> > > > +        Define cache properties for SMP system.
> > > > +
> > > > +        ``cache=cachename`` specifies the cache that the properties will be
> > > > +        applied on. This field is the combination of cache level and cache
> > > > +        type. It supports ``l1d`` (L1 data cache), ``l1i`` (L1 instruction
> > > > +        cache), ``l2`` (L2 unified cache) and ``l3`` (L3 unified cache).
> > > > +
> > > > +        ``topology=topologylevel`` sets the cache topology level. It accepts
> > > > +        CPU topology levels including ``thread``, ``core``, ``module``,
> > > > +        ``cluster``, ``die``, ``socket``, ``book``, ``drawer`` and a special
> > > > +        value ``default``. If ``default`` is set, then the cache topology will
> > > > +        follow the architecture's default cache topology model. If another
> > > > +        topology level is set, the cache will be shared at corresponding CPU
> > > > +        topology level. For example, ``topology=core`` makes the cache shared
> > > > +        by all threads within a core.
> > > > +
> > > > +        Example:
> > > > +
> > > > +        ::
> > > > +
> > > > +            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
> > > 
> > > There are 4 cache types, l1d, l1i, l2, l3.
> > > 
> > > In this example you've only set properties for l1d, l1i caches.
> > > 
> > > What does this mean for l2 / l3 caches ?
> > 
> > Omitting "cache" will default to using the "default" level.
> > 
> > I think I should add the above description to the documentation.
> > 
> > > Are they reported as not existing, or are they to be reported at
> > > some built-in default topology level.
> > 
> > It's the latter.
> > 
> > If a machine doesn't support l2/l3, then QEMU will also report the error
> > like:
> > 
> > qemu-system-*: l2 cache topology not supported by this machine
> 
> Ok, that's good.
> 
> > > If the latter, how does the user know what that built-in default is, 
> > 
> > Currently, the default cache model for x86 is L1 per core, L2 per core,
> > and L3 per die. Similar to the topology levels, there is still no way to
> > expose this to users. I can descript default cache model in doc.
> > 
> > But I feel like we're back to the situation we discussed earlier:
> > "default" CPU topology support should be related to the CPU model, but
> > in practice, QEMU supports it at the machine level. The cache topology
> > depends on CPU topology support and can only continue to be added on top
> > of the machine.
> > 
> > So do you think we can add topology and cache information in CpuModelInfo
> > so that query-cpu-model-expansion can expose default CPU/cache topology
> > information to users?
> > 
> > This way, users can customize CPU/cache topology in -smp and
> > -machine smp-cache. Although the QMP command is targeted at the CPU model
> > while our CLI is at the machine level, at least we can expose the
> > information to users.
> > 
> > If you agree to expose the default topology/cache info in
> > query-cpu-model-expansion, can I work on this in a separate series? :)
> 
> Yeah, lets worry about that another day.
> 
> It it sufficient to just encourage users to always specify
> the full set of caches.

Thanks!

> > > Can we explicitly disable a l2/l3 cache, or must it always exists ?
> > 
> > Now we can't disable it through -machine smp-cache (while x86 CPU support
> > l3-cache=off), but as you mentioned, I can try using "invalid" to support
> > this scenario, which would be more general. Similarly, if you agree, I
> > can also add this support in a separate series.
> 
> If we decide to offer a way to disable caches, probably better to have
> a name like 'disabled' for such a setting, and yes, we don't need todo
> that now.

Yes, "disabled" is better.

Regards,
Zhao

 

