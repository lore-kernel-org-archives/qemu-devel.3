Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41B4E7717F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 16:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKJqq-0008U0-Fg; Sun, 08 Dec 2024 11:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKJqp-0008Tf-AF; Sun, 08 Dec 2024 11:09:43 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKJqn-0007De-CZ; Sun, 08 Dec 2024 11:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733674181; x=1765210181;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dP9Ygx8gHJBEw6OspYnn8BAypKnfmjjrM+Iep0CyiiE=;
 b=dOmvNCUjbK3J1YnLYW/+8zCiJ9WeajHV7DrqJtwqU9jL1WY6n0yga8hZ
 jHwvtn2eBKMw5rmuIRgiDgHNRmVNX+zhQaBGiEBw+ecJXydUI/fByIZr0
 7IfyPcEEuahnzg550vaXK56oFoxkHuouvVtvOXbRPfamWdU+NOpOduCji
 pIZLRxeZWWOhxCFBPp+x72r5qRmzeSxIBYG1Zy1YG5QaQWix3KrLKntjK
 nCZdv1ugN7RL8lGj0EAyv6nlq1fGxzGhGDsq2gcZo9ztGihu4XaZK38IL
 X0XkLWeVlDFMVFEVn7e3VN4U0RWuDMnSOALxHGRxii6qMOy8vzNSXP+/y g==;
X-CSE-ConnectionGUID: M8hYtCXHSxe+EJaYlxVE8Q==
X-CSE-MsgGUID: jL4KWTgkRWWv8sbUEweHSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37756337"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; d="scan'208";a="37756337"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2024 08:09:37 -0800
X-CSE-ConnectionGUID: IK6Dg4cXTJ+KhF7Q5eQy9g==
X-CSE-MsgGUID: lEG4mZq3R26qhOgmKKrBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; d="scan'208";a="125701071"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 08 Dec 2024 08:09:36 -0800
Date: Mon, 9 Dec 2024 00:27:48 +0800
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
Message-ID: <Z1XJBJp+l92+OrY9@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-5-zhao1.liu@intel.com>
 <6108dfe6-f629-431c-be91-51abff338e85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6108dfe6-f629-431c-be91-51abff338e85@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
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

On Thu, Dec 05, 2024 at 07:53:42PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 19:53:42 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 04/13] rust: add bindings for gpio_{in|out} initialization
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > The qdev_init_gpio_{in|out} are qdev interfaces, so that it's natural to
> > wrap them as DeviceState's methods in Rust API, which could eliminate
> > unsafe cases in the device lib.
> > 
> > Wrap qdev_init_gpio_{in|out} as methods in a new trait DeviceGPIOImpl.
> > 
> > In addition, for qdev_init_gpio_in(), to convert the idiomatic Rust
> > callback into a C-style callback qemu_irq_handler, add a handler pointer
> > member in DeviceGPIOImpl. For any device needs to initialize GPIO in, it
> > needs to define a handler. And for device which just wants to initialize
> > GPIO out, it can leave the GPIO_IRQ_HANDLER as None.
> 
> This has the same issue as timers, in that you could have (especially once
> someone adds named GPIOs) multiple handlers.  So we need the same kind of
> Fn-based thing here too.

I will refer to the timer callback prototype you suggested and try that
way. Will you rework the timer binding soon? (I'm sorry for bringing such
burden to you).

> > +/// Trait that defines the irq handler for GPIO in.
> > +pub trait DeviceGPIOImpl {
> > +    const GPIO_IRQ_HANDLER: Option<fn(&mut Self, lines_num: u32, level: u32)> = None;
> 
> Ah, I see that you're placing the qdev_init_gpio_in here so that you
> only make that accessible for devices that did implement DeviceGPIOImpl.
> However you are not guaranteeing that this _is_ a DeviceState.

Thank you, I really couldn't think of a good way to implement the
DeviceState method...One reason is that DeviceImpl is a bit confusing to
me, and please see the comment below.

> If the handler can be passed as a function, the problem of getting the
> GPIO_INT_HANDLER does not exist anymore.  So with the code in rust-next you
> can add these to a trait like
> 
> /// Trait for methods of [`DeviceState`] and its subclasses.
> pub trait DeviceMethods: ObjectDeref
> where
>     Self::Target: IsA<DeviceState>,
> {
>     fn init_gpio_in<F: ...)(&self, lines_num: u32, f: &F) {
>     }
> }
> 
> impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState>
> {}
> 

Thank you for your idea! This is a true implementation of the DeviceState
method. I'll try this way!

Additionally, the current DeviceImpl trait is quite special. Although in
Rust, DeviceImpl traits are implemented for device states, DeviceImpl is
actually used for device classes.

Semantically, it might be more natural for DeviceImpl to be a trait for
device classes. However, parameters of its methods are DeviceState, so
it makes sense as a trait for states in Rust. 

This seems to be a different design before C and Rust Qdev.

> > +    fn init_gpio_out(&self, pins: &InterruptSource, lines_num: u32) {
> > +        unsafe {
> > +            qdev_init_gpio_out(addr_of!(*self) as *mut _, pins.as_ptr(), lines_num as c_int);
> > +        }
> > +    }
> > +}
> 
> Pass a slice &[InterruptSource], and get the "len" from the length of the
> slice.

Thanks! Will change this.

Regards,
Zhao


