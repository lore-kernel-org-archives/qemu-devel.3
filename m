Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1474C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwqJ-0005RK-K7; Thu, 25 Jul 2024 07:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWwqF-0005OE-DX; Thu, 25 Jul 2024 07:41:03 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWwqB-0001WG-5P; Thu, 25 Jul 2024 07:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721907659; x=1753443659;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+MUHoDV+o+BAqrEJb2hWev0rKEyLw15W/zcIr7FnVd4=;
 b=cDPafLSoYUzJ1SzRf2Jno+oUY2xoV1X5cuSiGxRI5kASBZywwddEjR5B
 zkw769mjzklhAqOSzYsZvPEZJi3WrH7mD05qlLqbvh3AuGqXNa1xW8Rl0
 yMqltV0WNWIXnj7JobUT20Cl8rew1E+sUo0jGrCkI6MTnnidpEbrQGs2y
 TVMxtvjFsfZqEFghHRCrzPzkECDkAgW8RyJZmMDvJNoUNLDy4FMhi122U
 255zBaxrGezLZWkWVA1efUDWZHvoghIPtVyGtJ2KQTJkC2ZUSYedcMKpw
 dw7gZ1RQRRW/Vb97yG5lBIf0IUxNuVsA6oqP8Dc6hbEto0xnIYjQtVcCg w==;
X-CSE-ConnectionGUID: qVIjQ/YgTlmgbc+nVQzsFw==
X-CSE-MsgGUID: LZ4gCAZHQkypOK99BTLwCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19512927"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="19512927"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 04:40:51 -0700
X-CSE-ConnectionGUID: IvbzGUkuRsqjmtEJqj5HHA==
X-CSE-MsgGUID: OUEK940ySL6fN9WTOTAudg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="53664396"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 25 Jul 2024 04:40:46 -0700
Date: Thu, 25 Jul 2024 19:56:30 +0800
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
Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
Message-ID: <ZqI9bqQDVUU7liW1@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-3-zhao1.liu@intel.com>
 <87wmld361y.fsf@pond.sub.org> <Zp5tBHBoeXZy44ys@intel.com>
 <87h6cfowei.fsf@pond.sub.org> <ZqEV8uErCn+QkOw8@intel.com>
 <871q3hua56.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q3hua56.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Thu, Jul 25, 2024 at 10:51:49AM +0200, Markus Armbruster wrote:

[snip]

> >> What's the use case?  The commit messages don't tell.
> >
> > i386 has the default cache topology model: l1 per core/l2 per core/l3
> > per die.
> >
> > Cache topology affects scheduler performance, e.g., kernel's cluster
> > scheduling.
> >
> > Of course I can hardcode some cache topology model in the specific cpu
> > model that corresponds to the actual hardware, but for -cpu host/max,
> > the default i386 cache topology model has no flexibility, and the
> > host-cpu-cache option doesn't have enough fine-grained control over the
> > cache topology.
> >
> > So I want to provide a way to allow user create more fleasible cache
> > topology. Just like cpu topology.
> 
> 
> So the use case is exposing a configurable cache topology to the guest
> in order to increase performance.  Performance can increase when the
> configured virtual topology is closer to the physical topology than a
> default topology would be.  This can be the case with CPU host or max.
> 
> Correct?

Yes! That's x86 use case. Jonathan also helped me explain his ARM use case.

> >> Why does that use case make no sense without SMP?
> >
> > As the example I mentioned, for Intel hyrbid architecture, P cores has
> > l2 per core and E cores has l2 per module. Then either setting the l2
> > topology level as core nor module, can emulate the real case.
> >
> > Even considering the more extreme case of Intel 14th MTL CPU, where
> > some E cores have L3 and some don't even have L3. As well as the last
> > time you and Daniel mentioned that in the future we could consider
> > covering more cache properties such as cache size. But the l3 size can
> > be different in the same system, like AMD's x3D technology. So
> > generally configuring properties for @name in a list can't take into
> > account the differences of heterogeneous caches with the same @name.
> >
> > Hope my poor english explains the problem well. :-)
> 
> I think I understand why you want to configure caches.  My question was
> about the connection to SMP.
> 
> Say we run a guest with a single core, no SMP.  Could configuring caches
> still be useful then?

No, for this case the CPU topology (of x86) would be 1 core per module, 1
module per die, 1 die per socket.

Then this core actually owns the l1/l2/l3.

> >> Can the same @name occur multiple times?  Documentation doesn't tell.
> >> If yes, what does that mean?
> >
> > Yes, this means the later one will override the previous one with the same
> > name.
> 
> Needs documenting.
> 
> If you make it an error, you don't have to document it :)

OK!

> >> Say we later add value "l1" for unified level 1 cache.  Would "l1" then
> >> conflict with "l1d" and "l1u"?
> >
> > Yes, we should check in smp/machine code and ban l1 and l1i/l1d at the
> > same time. This check I suppose is easy to add.
> >
> >> May @topo be "invalid"?  Documentation doesn't tell.  If yes, what does
> >> that mean?
> >
> > Yes, just follow the intel's spec, invalid means the current topology
> > information is invalid, which is used to encode x86 CPUIDs. So when I
> > move this level to qapi, I just keeped this. Otherwise, I need to
> > re-implement the i386 specific invalid level.
> 
> I'm afraid I don't understand what is supposed to happen when I tell
> QEMU to make a cache's topology invalid.

Currently this series doesn't allow users to set invalid, if they do, QEMU
reports an error.

So this invalid is just for QEMU internal use. Do you think it's okay?

[snip]

> > Ah, I also considerred this. I didn't use "type" because people usually
> > uses cache type to indicate INSTRUCTION/DATA/UNIFIED and cache level to
> > indicate LEVEL 1/LEVEL 2/LEVEL 3. The enumeration here is a combination of
> > type+level. So I think it's better to avoid the type term.
> 
> SmpCacheLevelAndType is quite a mouthful.

Better name! Thanks!

Regards,
Zhao


