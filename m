Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1977CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJlQ-0002Pn-1g; Wed, 29 May 2024 09:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCJlO-0002PF-BI
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:54:46 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCJlL-0003Ov-8a
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716990884; x=1748526884;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fWr3mfW8IQ5iVX/mRhzfvVJbpcUHDR5OYiEUyX5ZpJI=;
 b=HNwJIPFL1OYYAdPN5lP/cApdDQ7fdgjZ6s+goka7HZgmxGgzQi8t3DeQ
 i5rXyq/v4ZsHog6QlNhU7VQeHWd8XE3l+LGJnUxIftrL1K+XcPzWAiSSt
 WYkn1lKVxgq7bHyaWOPW6DBSLxfiFpB5PivNdHcJdROgMvYSj8wDa1wMG
 V1AxiK4ZMjVW5dWNfqNNRsKDVTZdps7d+I8dYHlp6yph8EHgXQB7ipFD8
 +6zBKY9iPiG21sWtuwnaiiJpWZL4TpcrO+F7veWLHhkxi1Qw4UkyoEITE
 9rASh6A2hAyZL+uGDihJCOWX7Dj+L5mwMuYHympwM1P7oKErU04Zo+Psp A==;
X-CSE-ConnectionGUID: 7CmRiHceRUaV0++vAm3Uvw==
X-CSE-MsgGUID: UwfByJr6TQev3z13Q8PHNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17226110"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="17226110"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2024 06:54:40 -0700
X-CSE-ConnectionGUID: 3BTqzFJbQEuSXs4Kq/toWw==
X-CSE-MsgGUID: Ztd7+xNdQBCUsK30zrqXlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="66306587"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 29 May 2024 06:54:37 -0700
Date: Wed, 29 May 2024 22:10:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQIC4gQmVycmFuZ++/vSI=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Message-ID: <Zlc3ONhFa90wdcQp@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527195944.GA913874@fedora.redhat.com>
 <ZlV+Su4hziCFymVt@intel.com>
 <20240528130518.GA993828@fedora.redhat.com>
 <D9370410-E32D-4235-8CF0-87E620398246@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9370410-E32D-4235-8CF0-87E620398246@ynddal.dk>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

Hi Stefan and Mads,

On Wed, May 29, 2024 at 11:33:42AM +0200, Mads Ynddal wrote:
> Date: Wed, 29 May 2024 11:33:42 +0200
> From: Mads Ynddal <mads@ynddal.dk>
> Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
> X-Mailer: Apple Mail (2.3774.600.62)
> 
> 
> >> Maybe later, Rust-simpletrace and python-simpletrace can differ, e.g.
> >> the former goes for performance and the latter for scalability.
> > 
> > Rewriting an existing, maintained component without buy-in from the
> > maintainers is risky. Mads is the maintainer of simpletrace.py and I am
> > the overall tracing maintainer. While the performance improvement is
> > nice, I'm a skeptical about the need for this and wonder whether thought
> > was put into how simpletrace should evolve.
> > 
> > There are disadvantages to maintaining multiple implementations:
> > - File format changes need to be coordinated across implementations to
> >  prevent compatibility issues. In other words, changing the
> >  trace-events format becomes harder and discourages future work.
> > - Multiple implementations makes life harder for users because they need
> >  to decide between implementations and understand the trade-offs.
> > - There is more maintenance overall.
> > 
> > I think we should have a single simpletrace implementation to avoid
> > these issues. The Python implementation is more convenient for
> > user-written trace analysis scripts. The Rust implementation has better
> > performance (although I'm not aware of efforts to improve the Python
> > implementation's performance, so who knows).
> > 
> > I'm ambivalent about why a reimplementation is necessary. What I would
> > like to see first is the TCG binary tracing functionality. Find the
> > limits of the Python simpletrace implementation and then it will be
> > clear whether a Rust reimplementation makes sense.
> > 
> > If Mads agrees, I am happy with a Rust reimplementation, but please
> > demonstrate why a reimplementation is necessary first.
> > 
> > Stefan
> 
> I didn't want to shoot down the idea, since it seemed like somebody had a plan
> with GSoC. But I actually agree, that I'm not quite convinced.
> 
> I think I'd need to see some data that showed the Python version is inadequate.
> I know Python is not the fastest, but is it so prohibitively slow, that we
> cannot make the TCG analysis? I'm not saying it can't be true, but it'd be nice
> to see it demonstrated before making decisions.
> 
> Because, as you point out, there's a lot of downsides to having two versions. So
> the benefits have to clearly outweigh the additional work.
> 
> I have a lot of other questions, but let's maybe start with the core idea first.
> 
> —
> Mads Ynddal
>

I really appreciate your patience and explanations, and your feedback
and review has helped me a lot!

Yes, simple repetition creates much maintenance burden (though I'm happy
to help with), and the argument for current performance isn't convincing
enough.

Getting back to the project itself, as you have said, the core is still
further support for TCG-related traces, and I'll continue to work on it,
and then look back based on such work to see what issues there are with
traces or what improvements can be made.

Thanks again!

Regards,
Zhao


