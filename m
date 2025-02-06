Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB90C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyI1-0002NK-Rh; Thu, 06 Feb 2025 04:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfyHy-0002Lw-QG; Thu, 06 Feb 2025 04:35:14 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfyHv-0007qb-Q2; Thu, 06 Feb 2025 04:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738834512; x=1770370512;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SbzsFpxSlqt0LRVCVphwfchnZcpRBWTRP4V0UBxDljg=;
 b=KtNH0nNEz4WS/0uh7TOqmTQh+JIRSdNSdBm3lfcQ64I6NFHvClIZcyaC
 LfRTkg4AhquK1SQ69NNDM6vRUy/t4W0EG0rKdfaecvDwSPFHrRN0zoJ2b
 ARKrU61gYqlpvaui/NDbFSwQJSGZMHK3Bn6FG4DVk1MjewwQi1a7J+2vY
 oc9JSPqVzit8WIdAOcxsqQWWarxTcf/YJnj7P+XEv8Xu6hnUkIgQJNzg8
 5FdXfd5z/Ei0RxRaOgcyRrWyFVKAQiiUFE+YsC+ItUXpCZaRQtJDB1Car
 85vBuLqdsmJvtcbSwn8zFvWVCD6nOS4iXSlsSf3ziM7QkaEkTXHg09e0Z w==;
X-CSE-ConnectionGUID: f2qfNfpmTUO5SmaRTc3PSg==
X-CSE-MsgGUID: OIxj/snRRxeBba9W5XksNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61905380"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="61905380"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 01:35:08 -0800
X-CSE-ConnectionGUID: 2gIBkdsDS86vB5dYK1Hsqw==
X-CSE-MsgGUID: Mm5+m0RnTiC1gkfud4HxFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142041740"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 06 Feb 2025 01:35:03 -0800
Date: Thu, 6 Feb 2025 17:54:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
Message-ID: <Z6SG2NLxxhz4adlV@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfj01z8x.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Wed, Feb 05, 2025 at 11:07:10AM +0100, Markus Armbruster wrote:
> Date: Wed, 05 Feb 2025 11:07:10 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask
>  format in KVM PMU filter
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > The select&umask is the common way for x86 to identify the PMU event,
> > so support this way as the "x86-default" format in kvm-pmu-filter
> > object.
> 
> So, format 'raw' lets you specify the PMU event code as a number, wheras
> 'x86-default' lets you specify it as select and umask, correct?

Yes!

> Why do we want both?

This 2 formats are both wildly used in x86(for example, in perf tool).

x86 documents usually specify the umask and select fields.

But raw format could also be applied for ARM since ARM just uses a number
to encode event.

> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> [...]
> 
> > diff --git a/qapi/kvm.json b/qapi/kvm.json
> > index d51aeeba7cd8..93b869e3f90c 100644
> > --- a/qapi/kvm.json
> > +++ b/qapi/kvm.json
> > @@ -27,11 +27,13 @@
> >  #
> >  # @raw: the encoded event code that KVM can directly consume.
> >  #
> > +# @x86-default: standard x86 encoding format with select and umask.
> 
> Why is this named -default?

Intel and AMD both use umask+select to encode events, but this format
doesn't have a name... so I call it `default`, or what about
"x86-umask-select"?

> > +#
> >  # Since 10.0
> >  ##
> >  { 'enum': 'KVMPMUEventEncodeFmt',
> >    'prefix': 'KVM_PMU_EVENT_FMT',
> > -  'data': ['raw'] }
> > +  'data': ['raw', 'x86-default'] }
> >  
> >  ##
> >  # @KVMPMURawEvent:
> > @@ -46,6 +48,25 @@
> >  { 'struct': 'KVMPMURawEvent',
> >    'data': { 'code': 'uint64' } }
> >  
> > +##
> > +# @KVMPMUX86DefalutEvent:
> 
> Default, I suppose.

Thanks!

> > +#
> > +# x86 PMU event encoding with select and umask.
> > +# raw_event = ((select & 0xf00UL) << 24) | \
> > +#              (select) & 0xff) | \
> > +#              ((umask) & 0xff) << 8)
> 
> Sphinx rejects this with "Unexpected indentation."
> 
> Is the formula needed here?

I tried to explain the relationship between raw format and umask+select.

Emm, where do you think is the right place to put the document like
this?

...

> > +##
> > +# @KVMPMUX86DefalutEventVariant:
> > +#
> > +# The variant of KVMPMUX86DefalutEvent with the string, rather than
> > +# the numeric value.
> > +#
> > +# @select: x86 PMU event select field.  This field is a 12-bit
> > +#     unsigned number string.
> > +#
> > +# @umask: x86 PMU event umask field. This field is a uint8 string.
> 
> Why are these strings?  How are they parsed into numbers?

In practice, the values associated with PMU events (code for arm, select&
umask for x86) are often expressed in hexadecimal. Further, from linux
perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
s390 uses decimal value.

Therefore, it is necessary to support hexadecimal in order to honor PMU
conventions.

However, unfortunately, standard JSON (RFC 8259) does not support
hexadecimal numbers. So I can only consider using the numeric string in
the QAPI and then parsing it to a number.

I parse this string into number by qemu_strtou64().


