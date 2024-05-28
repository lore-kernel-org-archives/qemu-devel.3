Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8490C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsvL-00049Y-RS; Tue, 28 May 2024 05:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBsvJ-00048j-Pf
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:15:13 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBsvH-0002mt-Ig
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716887712; x=1748423712;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=M1P2chnfxBPTg+5wFSQkved4diqgBKMoDlJ61DiKDU0=;
 b=Wn9vMxYUYbDSwkmBRyZiA6/ApjVct8spevbmiKxK/nZKWSG7UPyWLTDk
 vtNvzYuHNnlMrIJ45FSwFJeuGHemEpPYX58WCJ0AcmdcULk9M28atD06n
 lNJB8FxX6HCIEG++o2fe/hZlQprIT6M+2xVJj3UE/NSo8GbRnahcLNkj6
 qQGHDouvJ+KoPHUUmeOlv1/m6LrB+D4cSV8MQ3juKW7uoUDbrtqeo6gwC
 RDXGaaAgvUXdSgoa384OtGYGuqGPQ3EMtZ8tmtQZGfDtmEX8DefyvB0rU
 0I+2In2ShlJ0srVGb4LufztUFpON2/2Y/TqKs2ucvWTUIjuEw0e54i38D Q==;
X-CSE-ConnectionGUID: fliM7tUDTkiEhyBAlTZIqA==
X-CSE-MsgGUID: tpYTdOG6QgeAu6LB+u+6ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24635704"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="24635704"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 02:15:09 -0700
X-CSE-ConnectionGUID: UUuqX5YkT3G0YgHeETrGAw==
X-CSE-MsgGUID: yinUyxEgTrq1gnKxUBzwQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="66214879"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 28 May 2024 02:15:06 -0700
Date: Tue, 28 May 2024 17:30:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 4/6] scripts/simpletrace-rust: Parse and check trace recode
 file
Message-ID: <ZlWkNfAQ5zI34/UA@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-5-zhao1.liu@intel.com>
 <20240527204406.GE913874@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527204406.GE913874@fedora.redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

> > +fn read_trace_records(
> > +    events: &Vec<Event>,
> > +    fobj: &File,
> > +    analyzer: &mut Formatter,
> > +    read_header: bool,
> > +) -> Result<Vec<String>>
> > +{
> > +    /* backtrace::Backtrace needs this env variable. */
> > +    env::set_var("RUST_BACKTRACE", "1");
> > +    let bt = Backtrace::new();
> > +    let raw_frame = bt.frames().first().unwrap();
> > +    let frameinfo = raw_frame.symbols().first().unwrap();
> > +
> > +    let dropped_event = Event::build(
> > +        "Dropped_Event(uint64_t num_events_dropped)",
> > +        frameinfo.lineno().unwrap() + 1,
> > +        frameinfo.filename().unwrap().to_str().unwrap(),
> > +    )
> > +    .unwrap();
> 
> Is the backtrace necessary? This trick was used in Python where it's
> part of the standard library, but I don't think there is any need for
> Dropped_Event to refer to this line in the source code.
>
> Maybe Rust has a way to do this at compile-time or you can hardcode
> values instead.

Thanks your reminder, I'll think about the hardcode approach as the
easiest solution...removing the backtrace can help a lot here.

Regards,
Zhao


