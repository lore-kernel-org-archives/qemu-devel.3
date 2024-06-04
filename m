Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E1CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEWTc-0002zl-JR; Tue, 04 Jun 2024 11:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEWTb-0002zI-32; Tue, 04 Jun 2024 11:53:31 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEWTY-0000cP-CU; Tue, 04 Jun 2024 11:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717516408; x=1749052408;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IBh4cRZ5Gd6TO3btnDYuVa+tLMDOJq9bXCSjiq19S8g=;
 b=SOrqSrZLqdVA7joTJb/8g7m8ViW7LY2yNJm6u1JS8tDbWmDAms0V+C8T
 cpjIow0466FSwqYSV/djONlrTuxbNBoaaIb1vBaU8nKm1si6mqfUdnwRn
 Me7r6y2y38BEXsmyUpryAklyNxbHh3hmR1xTSiQHswerQJbusOCLvJt+G
 wzUG7Hbwv7F79x7RIEONggIdVYBRWijeKJhEulwBCE9soTampTSXz8gBD
 7ERb0lfTqO9m4NY+ho3h/mMEs3eKEA0IzqLwIo7DkPsTZQbPKs4amDEv6
 dLGL2QY49Zer+rrTZwaZL3e+isMcO8BE9FCV6R+9Jsds0fJVlOceK1b67 Q==;
X-CSE-ConnectionGUID: LslorJrxSjWOu+98veeUQA==
X-CSE-MsgGUID: wkuC033wRW+mHOALRCkkig==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31571571"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="31571571"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 08:53:24 -0700
X-CSE-ConnectionGUID: ksKFdK+nR9iExjBaDjLmig==
X-CSE-MsgGUID: 1nv681oTSPinEBAr57ciog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="60472787"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 04 Jun 2024 08:53:19 -0700
Date: Wed, 5 Jun 2024 00:08:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
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
Subject: Re: [RFC v2 3/7] hw/core: Add cache topology options in -smp
Message-ID: <Zl88DYwLE3ScDF5F@intel.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <20240530101539.768484-4-zhao1.liu@intel.com>
 <87sext9jfo.fsf@pond.sub.org> <Zl7fHop_GaiJt6AE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl7fHop_GaiJt6AE@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Markus and Daniel,

(I replied to both of you because I discussed the idea of cache object
at the end)

On Tue, Jun 04, 2024 at 10:32:14AM +0100, Daniel P. Berrang¨¦ wrote:
> Date: Tue, 4 Jun 2024 10:32:14 +0100
> From: "Daniel P. Berrang¨¦" <berrange@redhat.com>
> Subject: Re: [RFC v2 3/7] hw/core: Add cache topology options in -smp
> 
> On Tue, Jun 04, 2024 at 10:54:51AM +0200, Markus Armbruster wrote:
> > Zhao Liu <zhao1.liu@intel.com> writes:
> > 
> > > Add "l1d-cache", "l1i-cache". "l2-cache", and "l3-cache" options in
> > > -smp to define the cache topology for SMP system.
> > >
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > 
> > [...]
> > 
> > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > index 7ac5a05bb9c9..8fa5af69b1bf 100644
> > > --- a/qapi/machine.json
> > > +++ b/qapi/machine.json
> > > @@ -1746,6 +1746,23 @@
> > >  #
> > >  # @threads: number of threads per core
> > >  #
> > > +# @l1d-cache: topology hierarchy of L1 data cache. It accepts the CPU
> > > +#     topology enumeration as the parameter, i.e., CPUs in the same
> > > +#     topology container share the same L1 data cache. (since 9.1)
> > > +#
> > > +# @l1i-cache: topology hierarchy of L1 instruction cache. It accepts
> > > +#     the CPU topology enumeration as the parameter, i.e., CPUs in the
> > > +#     same topology container share the same L1 instruction cache.
> > > +#     (since 9.1)
> > > +#
> > > +# @l2-cache: topology hierarchy of L2 unified cache. It accepts the CPU
> > > +#     topology enumeration as the parameter, i.e., CPUs in the same
> > > +#     topology container share the same L2 unified cache. (since 9.1)
> > > +#
> > > +# @l3-cache: topology hierarchy of L3 unified cache. It accepts the CPU
> > > +#     topology enumeration as the parameter, i.e., CPUs in the same
> > > +#     topology container share the same L3 unified cache. (since 9.1)
> > > +#
> > >  # Since: 6.1
> > >  ##
> > 
> > The new members are all optional.  What does "absent" mean?  No such
> > cache?  Some default topology?

I suppose "absent" means using the the default arch-specific cache topo.

For example, x86 has its own default cache topo. my purpose in providing
this interface is to allow users to override the default (arch-specific)
cache topology.

Daniel suggested in cover letter's reply that I could add the value
¡°default¡±, I think omitting it would have the same effect as setting it
to ¡°default¡±, and omitting it shouldn't be regarded as disabling a
particular cache, since the interface is only about the topology!

> > Is this sufficiently general?  Do all machines of interest have a split
> > level 1 cache, a level 2 cache, and a level 3 cache?

The different cache support can be extended by such control fields in
MachineClass:

typedef struct {
    ...
    bool l1_separated_cache_supported;
    bool l2_unified_cache_supported;
    bool l3_unified_cache_supported;
} SMPCompatProps;

For example, if a machine with l1 unified cache appears, it can add the
"l1_unified_cache_supported", and add "l1" option in QAPI.

Then separate L1 cache has ¡°l1i¡± and ¡°l1d¡± options, and unified L1 cache
should have ¡°l1¡± option.

> Level 4 cache is apparently a thing
> 
> https://www.guru3d.com/story/intel-confirms-l4-cache-in-upcoming-meteor-lake-cpus/
> 
> but given that any new cache levels will require new code in QEMU to
> wire up, its not a big deal to add new properties at the same time.
> 
> That said see my reply just now to the cover letter, where I suggest
> we should have a "caches" property that takes an array of cache
> info objects.

Yes, I agree.

> > 
> > Is the CPU topology level the only cache property we'll want to
> > configure here?  If the answer isn't "yes", then we should perhaps wrap
> > it in an object, so we can easily add more members later.
> 
> Cache size is a piece of info I could see us wanting to express

For the simplicity and clarity, I think it's better to only cover
topology in -smp, including the current CPU topology and the cache
topology I'm working on.

I've thought about the idea of converting the cache into the device,
which in turn could define more properties for the cache.

This one is mostly in connection with the previous qom-topo idea (aka
abstracting CPU topology device [1]):

    -device cpu-socket,id=sock0 \
    -device cpu-die,id=die0,parent=sock0 \
    -device cpu-core,id=core0,parent=die0,nr-threads=2 \
    -device cpu-cache,id=cache0,parent=core0,level=l1,type=inst \
    -device cpu-cache,id=cache1,parent=core0,level=l1,type=data \
    -device cpu-cache,id=cache2,parent=core0,level=l2,type=unif \
    -device cpu-cache,id=cache3,parent=die0,level=l3,type=unif

Cache device idea was mainly to support hybrid cache topology, because
Intel client hybrid architecture has hybrid cache topology (on MTL,
compute die has a L3 and SOC die has no L3).

Based on such a cache device, we can define more properties for the
cache and also meet flexible topology requirements at the same time.

This cache device I had planned to implement after the cpu topo device.
It's a long and hard way to go, I wonder if this future I'm portraying
will alleviate your concerns about more cache properties support. ;-)

Soon I'm also planning to refresh the qom-topo series again, reducing
hack changes, deleting dead codes, etc. Maybe it shouldn't be called
qom-topo, because I want to display topology tree in qom path by
qdev_set_id().

[1]: https://lore.kernel.org/qemu-devel/20231130144203.2307629-1-zhao1.liu@linux.intel.com/

> > Two spaces between sentences for consistency, please.
> >

Sure, thanks!

Regards,
Zhao


