Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A05C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 09:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZotR-0007nz-M3; Fri, 02 Aug 2024 05:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZotP-0007mS-37; Fri, 02 Aug 2024 05:48:11 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZotL-0004UB-AP; Fri, 02 Aug 2024 05:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722592087; x=1754128087;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kqQcjt8ahHm0LUdDkgUTxKLsmqLB40UCsPTMULgSq+s=;
 b=keQxVZuCewglwo14QDdpYhCHfzVNPznhmoXEyrNMrTLAvpsbpmlveA0J
 pVCvdO4s6XPrF6zH2uObhmbLd/zbd3HYk7WKgdfRsWg/8DEi9ynBpxCzO
 AFHcJXUmjQoexAiz7/ZhM3MnvtAYx+Q3fKhq9Vvhju7yflru6bXsEyTkh
 VTTctHNOeJVr05nA+jrP5kKYYlkmcOd3OtlFjE7AfYqy0Z83V2J2riths
 qpipXlGuIrL70WwXyNv+Ot9wpu20Y2WH0dYKdocNf0JSwkODhtOofclLP
 hiNCHq/q6JO9waEMDUCg8UWHQ8O15HscFO7irwc4C9Dh1gWTmfzPgFRAj w==;
X-CSE-ConnectionGUID: p3A2ucubRXOIiuiNm1j38g==
X-CSE-MsgGUID: NOZtKxZ0TD6fsc//uVbupA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20774530"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="20774530"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 02:48:03 -0700
X-CSE-ConnectionGUID: Kgw64EYBRCWfML41yTcO+w==
X-CSE-MsgGUID: BweuvkbuTiWba31HNNVsCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="55267892"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 02 Aug 2024 02:47:58 -0700
Date: Fri, 2 Aug 2024 18:03:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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
Message-ID: <ZqyvAWQdmW41D5H1@intel.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
 <b10545d1-8e81-44f0-8e13-eee393ea4d1b@redhat.com>
 <ZqyovJZkOjm6HZFv@intel.com>
 <45e9258c-b370-4b5c-884b-80a21f69cee8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e9258c-b370-4b5c-884b-80a21f69cee8@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
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

On Fri, Aug 02, 2024 at 05:41:57PM +0800, Shaoqin Huang wrote:
> Date: Fri, 2 Aug 2024 17:41:57 +0800
> From: Shaoqin Huang <shahuang@redhat.com>
> Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
> 
> Hi Zhao,
> 
> On 8/2/24 17:37, Zhao Liu wrote:
> > Hello Shaoqin,
> > 
> > On Fri, Aug 02, 2024 at 05:01:47PM +0800, Shaoqin Huang wrote:
> > > Date: Fri, 2 Aug 2024 17:01:47 +0800
> > > From: Shaoqin Huang <shahuang@redhat.com>
> > > Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
> > > 
> > > Hi Zhao,
> > > 
> > > On 7/10/24 12:51, Zhao Liu wrote:
> > > > Hi QEMU maintainers, arm and PMU folks,
> > > > 
> > > > I picked up Shaoqing's previous work [1] on the KVM PMU filter for arm,
> > > > and now is trying to support this feature for x86 with a JSON-compatible
> > > > API.
> > > > 
> > > > While arm and x86 use different KVM ioctls to configure the PMU filter,
> > > > considering they all have similar inputs (PMU event + action), it is
> > > > still possible to abstract a generic, cross-architecture kvm-pmu-filter
> > > > object and provide users with a sufficiently generic or near-consistent
> > > > QAPI interface.
> > > > 
> > > > That's what I did in this series, a new kvm-pmu-filter object, with the
> > > > API like:
> > > > 
> > > > -object '{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0xc4"}]}'
> > > > 
> > > > For i386, this object is inserted into kvm accelerator and is extended
> > > > to support fixed-counter and more formats ("x86-default" and
> > > > "x86-masked-entry"):
> > > > 
> > > > -accel kvm,pmu-filter=f0 \
> > > > -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","x86-fixed-counter":{"action":"allow","bitmap":"0x0"},"events":[{"action":"allow","format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"action":"allow","format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'
> > > 
> > > What if I want to create the PMU Filter on ARM to deny the event range
> > > [0x5,0x10], and allow deny event 0x13, how should I write the json?
> > > 
> > 
> > Cuurently this doesn't support the event range (since the raw format of
> > x86 event cannot be said to be continuous).
> > 
> > So with the basic support, we need to configure events one by one:
> > 
> > -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0x5"},{"action":"allow","format":"raw","select":"0x6"},{"action":"allow","format":"raw","code":"0x7"},{"action":"allow","format":"raw","code":"0x8"},{"action":"allow","format":"raw","code":"0x9"},{"action":"allow","format":"raw","code":"0x10"},{"action":"deny","format":"raw","code":"0x13"}]}'
> > 
> > This one looks a lot more complicated, but in the future, arm could
> > further support event-range (maybe implement event-range via mask), but
> > I think this could be arch-specific format since not all architectures'
> > events are continuous.
> > 
> > Additional, I'm a bit confused by your example, and I hope you can help
> > me understand that: when configuring 0x5~0x10 to be allow, isn't it true
> > that all other events are denied by default, so denying 0x13 again is a
> > redundant operation? What is the default action for all other events
> > except 0x5~0x10 and 0x13?
> > 
> > If we specify action as allow for 0x5~0x10 and deny for the rest by
> > default, then there is no need to set an action for each event but only
> > a global one (as suggested by Dapeng), so the above command line can be
> > simplified as:
> > 
> > -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":"0x5"},{"format":"raw","select":"0x6"},{"format":"raw","code":"0x7"},{"format":"raw","code":"0x8"},{"format":"raw","code":"0x9"},{"format":"raw","code":"0x10"}]}'
> > 
> 
> Yes you are right. On Arm when you first set the PMU Filter, if the first
> filter is allow, then all other event will be denied by default. The reverse
> is also the same, if the first filter is deny, then all other event will be
> allowed by default.
> 
> On ARM the PMU Filter is much more simper than x86 I think. We only need to
> care about the special event with allow or deny action.
> 
> If we don't support event range filter, I think that's fine. This can be
> added in the future.

This is good news for me, I can implement global action in the next
version and iterate further! Thank you for your confirmation!

Regards,
Zhao


