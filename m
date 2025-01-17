Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A41DC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYk1A-0005JJ-Ki; Fri, 17 Jan 2025 05:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYk17-0005Im-Em; Fri, 17 Jan 2025 05:55:57 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYk15-0000B8-70; Fri, 17 Jan 2025 05:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737111355; x=1768647355;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zzlSGjWEBiAzt8BVRjUGQb5eR0GNjttLRovMi6NHpw8=;
 b=CAOtcoJfRre2hY8I6RYNwYWT6FrJSVnfNZ5OsOgRUJ239doVq8kJfn9L
 yvaVn0VYR3yTeDYneoWUsCPJ7TsvXnIwrrNctaC3xv7yzDlpAe39NEGe9
 KdE/TxVIIpT1vuwXe5DfDXgH6AVYFjoiSKiPnFQBqLvdywzh2RgH/g7y8
 LvKpXgfTzIiKTjlhhr0CD1xVzLoS9UoZ88UmvoQmVYsInILZZnu2U1BHS
 7VU1r31YCRL+zRibcSsMKIHe8oJuMNkjBg7xFq/xsNS/5iM98+52gg871
 blReO0fegWY+WsFNT6uLOomSCgOUHVC7KdEENCfcBPqRCoe7lwdVCNurO Q==;
X-CSE-ConnectionGUID: rr4+uPvIT0KeDjrtLKzHxg==
X-CSE-MsgGUID: oVuR8izBQeaoZvDZyA53eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="55087976"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; d="scan'208";a="55087976"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2025 02:55:50 -0800
X-CSE-ConnectionGUID: V1FA4IXLQVGkTQjCoCX9Rw==
X-CSE-MsgGUID: eJQ2ZzsoSBS2BfP2KBqnjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="136656268"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Jan 2025 02:55:46 -0800
Date: Fri, 17 Jan 2025 19:14:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 04/13] rust: add bindings for gpio_{in|out} initialization
Message-ID: <Z4o7nbonhTHftVXq@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-5-zhao1.liu@intel.com>
 <6108dfe6-f629-431c-be91-51abff338e85@redhat.com>
 <Z1XJBJp+l92+OrY9@intel.com>
 <CABgObfaeoLociD5rzptg4Uj4anMonc0M8iP_TK3qa-17FecR2A@mail.gmail.com>
 <Z4h3Q/JBxtWxi+bK@intel.com>
 <CABgObfYeRASh3oao6fpKBcijnhGaMKdAWsAQbrya7rwwOJfE1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYeRASh3oao6fpKBcijnhGaMKdAWsAQbrya7rwwOJfE1g@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> >         unsafe {
> >             qdev_init_gpio_in(
> >                 self.upcast::<DeviceState>() as *const DeviceState as *mut DeviceState,
> 
> I think you can use self.as_mut_ptr::<DeviceState>() or something like that.

Yes, thank you!

> 
> >         assert!(pins.len() > 0);
> 
> !pins.is_empty().

Yes.

> But I am not sure it's needed...
> >
> >         unsafe {
> >             qdev_init_gpio_out(
> >                 self.upcast::<DeviceState>() as *const DeviceState as *mut DeviceState,
> >                 pins[0].as_ptr(),
> >                 pins.len() as c_int,
> 
> ... if you use instead pins.as_ptr() without the initial dereference.

Emm, pins.as_ptr() returns `*const InterruptSource`, which can't be
converted to `*mut *mut IRQState` with InterruptSource::as_ptr().

So I haven't thought of a better way yet...

> > impl HPETState {
> >     ...
> >
> >     fn handle_legacy_irq(&self, irq: u32, level: u32) {
> >         if irq == HPET_LEGACY_PIT_INT {
> >             if !self.is_legacy_mode() {
> >                 self.irqs[0].set(level != 0);
> >             }
> >         } else {
> >             self.rtc_irq_level.set(level as u8);
> 
> Any reason why you defined rtc_irq_level as InterruptSource<u8>
> instead of InterruptSource<u32>?

Thanks! I missed to clean up this, having previously used u8.

Regards,
Zhao


