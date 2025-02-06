Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4D6C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2TU-0004WS-1l; Thu, 06 Feb 2025 09:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tg2TS-0004Vr-Ja; Thu, 06 Feb 2025 09:03:22 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tg2TP-0006xT-Og; Thu, 06 Feb 2025 09:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738850600; x=1770386600;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5HfmyYU47Yo8Mg89L6hc3hs2QgBq3rcWfXeIDFRabrY=;
 b=LfBItjXCcZxo8/OU7hDSCNlnf2wKIalpBwYgrWeQRhu21qyBv8wxB4XI
 iQgaejmFJYfy1kDrqNYvonOdVXxRNDnKUdJvBGedG/ow8MMWh+Bn9HMse
 KNOxYdiojnhUdXuxqKBEBfqOIeXCYwL+/QqTvW+O7gGXlC3YY8u2r/cNQ
 ejUjyWBJ6o+LQd7jT3UkjYtySvIjbmvL3gS8cvPOGbpfJtxNmousP5M1X
 gMSPKWLfq68yV/WcdISe8NpmptfcfA8H80hBDVVBl24Q5+L/BZKbNFgR2
 ycKlZlhti+9ZAv9OUjkqVG8R/gXS53a9OIDOL9lQwLk2zqsphu2V8blNQ w==;
X-CSE-ConnectionGUID: bQYpwbjSSiqQxFn5V1MzEA==
X-CSE-MsgGUID: PkojNNIqTAumsNBn14epMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="27054493"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="27054493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 06:03:16 -0800
X-CSE-ConnectionGUID: 7pf8A9zfSR2Dg+23jhjvlQ==
X-CSE-MsgGUID: vlg2A+STQTW+U7ie6oNbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111068581"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 06 Feb 2025 06:03:10 -0800
Date: Thu, 6 Feb 2025 22:22:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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
Message-ID: <Z6TFr49Cnhe1s4/5@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org> <Z6SG2NLxxhz4adlV@intel.com>
 <Z6SEIqhJEWrMWTU1@redhat.com> <878qqjqskm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qqjqskm.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

> >> > > The select&umask is the common way for x86 to identify the PMU event,
> >> > > so support this way as the "x86-default" format in kvm-pmu-filter
> >> > > object.
> >> > 
> >> > So, format 'raw' lets you specify the PMU event code as a number, wheras
> >> > 'x86-default' lets you specify it as select and umask, correct?
> >> 
> >> Yes!
> >> 
> >> > Why do we want both?
> >> 
> >> This 2 formats are both wildly used in x86(for example, in perf tool).
> >> 
> >> x86 documents usually specify the umask and select fields.
> >> 
> >> But raw format could also be applied for ARM since ARM just uses a number
> >> to encode event.
> 
> Is it really too much to ask of the client to compute a raw value from
> umask and select values?

I understand you're wondering if we can omit the select+umask format...

In principle, having either one should work correctly... The additional
support for the umask+select format is more user-friendly and doesn't
introduce much complexity in the code.

My own observation is that Intel's doc rarely uses the raw format
directly, whereas AMD uses the raw format relatively more often.
Personally, when using the perf tool, I prefer the umask+select format.

Even if only the raw format is supported, users still need to be aware
of the umask+select format because there is the third format - "masked
entry" (which tries to mask a group of events with same select, patch 4).

So I would like to keep both raw and umask+select formats if possible.

...

> >> > > +#
> >> > > +# x86 PMU event encoding with select and umask.
> >> > > +# raw_event = ((select & 0xf00UL) << 24) | \
> >> > > +#              (select) & 0xff) | \
> >> > > +#              ((umask) & 0xff) << 8)
> >> > 
> >> > Sphinx rejects this with "Unexpected indentation."
> >> > 
> >> > Is the formula needed here?
> >> 
> >> I tried to explain the relationship between raw format and umask+select.
> >> 
> >> Emm, where do you think is the right place to put the document like
> >> this?
> 
> Do users need to know how to compute the raw event value from @select
> and @umask?

Yes, because it's also a unified calculation. AMD and Intel have
differences in bits for supported select field, but this calculation
(which follows from the KVM code) makes both compatible.

> If yes, is C code the best way?
> 
> Here's another way:
> 
>     bits  0..7 : bits 0..7 of @select
>     bits  8..15: @umask
>     bits 24..27: bits 8..11 of @select
>     all other bits: zero
>

Thank you! This is what I want.



