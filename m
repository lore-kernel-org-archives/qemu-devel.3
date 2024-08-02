Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27BBC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 09:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZoTY-00042A-H2; Fri, 02 Aug 2024 05:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZoTW-0003yc-5d; Fri, 02 Aug 2024 05:21:26 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZoTT-0000G2-8l; Fri, 02 Aug 2024 05:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722590484; x=1754126484;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7Ylgc3CpS+KKKaRf0YkWoRkezg56OZwlHf9RcSjeBPQ=;
 b=Cgfkg5PniZXIBxwEHW1TSPOeOoQYYVk8A8Y1JWI6/wCU/N6hTW7aNKh1
 h4F11tfIRek6kzIorT9wqJHrmHpFox6y+ceDBveU7PD2frAia5Y0Xv6HZ
 sNBmlHmrqJBNw3XkNysyKZ/kpVGiaSvfE4etWb9lV2pYIvg8RTxvXqPxr
 0rDmn+8ngntKcG+ek4srJJiq0blQyAkJaDfnSSZL57B49Ukf5c8rLtToi
 phSaAIS1eYyw/4E9TBV9ulBS6BVX12rcoTO3DceKln2vdRMtDczCPDw31
 eUprYRvAWHsWFyDFZnTybKNDr/Bq3tDKjGiHJ/7QA1Co+6zS838f52Yka Q==;
X-CSE-ConnectionGUID: gCmc9SEdQQq823pkVD7imA==
X-CSE-MsgGUID: rHdNFORPSQiwzWoam/kMEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="31973466"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="31973466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 02:21:19 -0700
X-CSE-ConnectionGUID: HX7qJS+PSha7LUgrRP/K9A==
X-CSE-MsgGUID: tuxTmRO+Rcy99EjBNQzK3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="56109681"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 02 Aug 2024 02:21:12 -0700
Date: Fri, 2 Aug 2024 17:37:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yuan Yao <yuan.yao@intel.com>,
 Xiong Zhang <xiong.y.zhang@intel.com>, Mingwei Zhang <mizhang@google.com>,
 Jim Mattson <jmattson@google.com>
Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
Message-ID: <ZqyovJZkOjm6HZFv@intel.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
 <b10545d1-8e81-44f0-8e13-eee393ea4d1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b10545d1-8e81-44f0-8e13-eee393ea4d1b@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

Hello Shaoqin,

On Fri, Aug 02, 2024 at 05:01:47PM +0800, Shaoqin Huang wrote:
> Date: Fri, 2 Aug 2024 17:01:47 +0800
> From: Shaoqin Huang <shahuang@redhat.com>
> Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
> 
> Hi Zhao,
> 
> On 7/10/24 12:51, Zhao Liu wrote:
> > Hi QEMU maintainers, arm and PMU folks,
> > 
> > I picked up Shaoqing's previous work [1] on the KVM PMU filter for arm,
> > and now is trying to support this feature for x86 with a JSON-compatible
> > API.
> > 
> > While arm and x86 use different KVM ioctls to configure the PMU filter,
> > considering they all have similar inputs (PMU event + action), it is
> > still possible to abstract a generic, cross-architecture kvm-pmu-filter
> > object and provide users with a sufficiently generic or near-consistent
> > QAPI interface.
> > 
> > That's what I did in this series, a new kvm-pmu-filter object, with the
> > API like:
> > 
> > -object '{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0xc4"}]}'
> > 
> > For i386, this object is inserted into kvm accelerator and is extended
> > to support fixed-counter and more formats ("x86-default" and
> > "x86-masked-entry"):
> > 
> > -accel kvm,pmu-filter=f0 \
> > -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","x86-fixed-counter":{"action":"allow","bitmap":"0x0"},"events":[{"action":"allow","format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"action":"allow","format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'
> 
> What if I want to create the PMU Filter on ARM to deny the event range
> [0x5,0x10], and allow deny event 0x13, how should I write the json?
>

Cuurently this doesn't support the event range (since the raw format of
x86 event cannot be said to be continuous).

So with the basic support, we need to configure events one by one:

-object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0x5"},{"action":"allow","format":"raw","select":"0x6"},{"action":"allow","format":"raw","code":"0x7"},{"action":"allow","format":"raw","code":"0x8"},{"action":"allow","format":"raw","code":"0x9"},{"action":"allow","format":"raw","code":"0x10"},{"action":"deny","format":"raw","code":"0x13"}]}'

This one looks a lot more complicated, but in the future, arm could
further support event-range (maybe implement event-range via mask), but
I think this could be arch-specific format since not all architectures'
events are continuous.

Additional, I'm a bit confused by your example, and I hope you can help
me understand that: when configuring 0x5~0x10 to be allow, isn't it true
that all other events are denied by default, so denying 0x13 again is a
redundant operation? What is the default action for all other events
except 0x5~0x10 and 0x13?

If we specify action as allow for 0x5~0x10 and deny for the rest by
default, then there is no need to set an action for each event but only
a global one (as suggested by Dapeng), so the above command line can be
simplified as:

-object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":"0x5"},{"format":"raw","select":"0x6"},{"format":"raw","code":"0x7"},{"format":"raw","code":"0x8"},{"format":"raw","code":"0x9"},{"format":"raw","code":"0x10"}]}'

Thanks,
Zhao


