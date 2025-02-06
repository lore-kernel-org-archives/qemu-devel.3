Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B956C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyju-0005aG-4z; Thu, 06 Feb 2025 05:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfyjf-0005Wo-66; Thu, 06 Feb 2025 05:03:52 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfyjd-00073A-DZ; Thu, 06 Feb 2025 05:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738836230; x=1770372230;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7pDNFxNaET2eGasSL540VZ+DJEMvoRrgCBkaR20O+b4=;
 b=Tj+m8jk/tqBHeFg7+xMLM5v8HhuML9PIr+xfFZ2y/G/XzNMUIMMbwm1o
 L71KzczdtENCyz1mAr1CCxMRiespf98/nq+32nngPCM7bstQnIMGWsTh6
 Cpyr6VDLP2S2ISUfO2zOExvNxfKT3tjf+XnTsy+FkAiRrO58g8Arhz5xi
 3wlD0uYnrti8xkVK5Zipdi14oAi+g4uFkKL7b88zG7S08WZKrUA+olTSS
 SXVLiqewA/VnkzZT8RcrcrzzJdKBcGccsNjfhgJoNVF1MSoFCg+C+UIy4
 DXIDKXQmOwVePYSKz1SnLYaXWR3DGzo+fP/NPEajZQl5VWtFmW0De8zFp A==;
X-CSE-ConnectionGUID: c+brNjAlTmSmzZC0tLsk/A==
X-CSE-MsgGUID: wK+JWYM8Q9WvcqkEWFUaaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39128497"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="39128497"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 02:03:47 -0800
X-CSE-ConnectionGUID: GSllaTxxSPq4BmXigMPvrQ==
X-CSE-MsgGUID: ZZoAHGUYR1GRPioCuYhj3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111693786"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 06 Feb 2025 02:03:42 -0800
Date: Thu, 6 Feb 2025 18:23:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
Message-ID: <Z6SNj4HZ4+k1uXhr@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org> <Z6SG2NLxxhz4adlV@intel.com>
 <Z6SEIqhJEWrMWTU1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6SEIqhJEWrMWTU1@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

> > > > +##
> > > > +# @KVMPMUX86DefalutEventVariant:
> 
> Typo   s/Defalut/Default/ - repeated many times in this patch.

My bad! Will fix!

> > > > +#
> > > > +# The variant of KVMPMUX86DefalutEvent with the string, rather than
> > > > +# the numeric value.
> > > > +#
> > > > +# @select: x86 PMU event select field.  This field is a 12-bit
> > > > +#     unsigned number string.
> > > > +#
> > > > +# @umask: x86 PMU event umask field. This field is a uint8 string.
> > > 
> > > Why are these strings?  How are they parsed into numbers?
> > 
> > In practice, the values associated with PMU events (code for arm, select&
> > umask for x86) are often expressed in hexadecimal. Further, from linux
> > perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
> > arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
> > s390 uses decimal value.
> > 
> > Therefore, it is necessary to support hexadecimal in order to honor PMU
> > conventions.
> 
> IMHO having a data format that matches an arbitrary external tool is not
> a goal for QMP. It should be neutral and exclusively use the normal JSON
> encoding, ie base-10 decimal. Yes, this means a user/client may have to
> convert from hex to dec before sending data over QMP. This is true of
> many areas of QMP/QEMU config though and thus normal/expected behaviour.
>

Thanks! This will simplify the code a lot.


