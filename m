Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EAAE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 15:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJwtE-0004UH-Qq; Sat, 07 Dec 2024 10:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwtB-0004Tq-M6; Sat, 07 Dec 2024 10:38:37 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwt9-0001gb-9G; Sat, 07 Dec 2024 10:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733585915; x=1765121915;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LVWUC2lzgj8dQpedDG4fFrO1tbS8tgOz8K6Dn0GhqPA=;
 b=Gs97YDqZlaAU9GyomkKJzILliBBQUjAsghOT32XHuiy4CSmJzNZd7lI3
 ah1NV5ZnBO+gDynzL5uqKtzGKC0WsckGa8ChFLtpa0LI6JVkNA997JWYP
 hC68+QpD+IKWEpQvqfOglTuKdb5nneb0omixa9AHlZHI8eHfJSEax7lAa
 WvRLVA0gQz658jS7kDJBhG+Ut8EttHnOSAq+eF6PqVftzfQnNY6TeplYc
 NzNGDQ0cvcL81GRE+IrKCS3EL3bB1OPpXNCNpZPQYDzHkbJtiSjvtO4qu
 NSCV9Pp5sm0u064a/QuBHVsZy7y8ACWUDeH+mcZ5QQNLgjFe9DUapUvbm w==;
X-CSE-ConnectionGUID: SdZOWMCjSU27NNocda13ow==
X-CSE-MsgGUID: AAlEKb6oS5OqAtvpXA6AQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34167809"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="34167809"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2024 07:38:30 -0800
X-CSE-ConnectionGUID: hdIdVQCLRHe9Gb2IeH6CmA==
X-CSE-MsgGUID: HNEN8FDvQS+bHmK1+RpAag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="125578083"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 07 Dec 2024 07:38:28 -0800
Date: Sat, 7 Dec 2024 23:56:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 03/13] rust/cell: add get_mut() method for BqlCell
Message-ID: <Z1RwOR3RWQTjrnYs@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-4-zhao1.liu@intel.com>
 <75edc6e5-e65f-40c0-90ee-6ac1fa018f5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75edc6e5-e65f-40c0-90ee-6ac1fa018f5c@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Thu, Dec 05, 2024 at 04:55:47PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 16:55:47 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 03/13] rust/cell: add get_mut() method for BqlCell
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > The get_mut() is useful when doing compound assignment operations, e.g.,
> > *c.get_mut() += 1.
> > 
> > Implement get_mut() for BqlCell by referring to Cell.
> 
> I think you can't do this because the BQL might be released while the owner has a &mut.  Like:

Thanks for pointing that out, I really didn't think of that, I
understand how that would break the atomicity of the BQL lock, right?

>    let mtx = Mutex<BqlCell<u32>>::new();
>    let guard = mtx.lock();
>    let cell = &mut *guard;
>    let inner = cell.get_mut(cell);
>    // anything that releases bql_lock
>    *inner += 1;
> 
> On the other hand I don't think you need it.  You have just two uses.
> 
> First, this one:
> 
> +        if set && self.is_int_level_triggered() {
> +            // If Timer N Interrupt Enable bit is 0, "the timer will
> +            // still operate and generate appropriate status bits, but
> +            // will not cause an interrupt"
> +            *self.get_state_mut().int_status.get_mut() |= mask;
> +        } else {
> +            *self.get_state_mut().int_status.get_mut() &= !mask;
> +        }
> 
> Where you can just write
> 
>     self.get_state_ref().update_int_status(self.index,
>         set && self.is_int_level_triggered())
> 
> and the HPETState can do something like
> 
>     fn update_int_status(&self, index: u32, level: bool) {
>         self.int_status.set(deposit64(self.int_status.get(), bit, 1, level as u64));
>     }

Yes, it's clearer!

> For hpet_fw_cfg you have unsafe in the device and it's better if you do:
> 
> -        self.hpet_id.set(unsafe { hpet_fw_cfg.assign_hpet_id() });
> +        self.hpet_id.set(fw_cfg_config::assign_hpet_id());
> 
> with methods like this that do the unsafe access:
> 
> impl fw_cfg_config {
>     pub(crate) fn assign_hpet_id() -> usize {
>         assert!(bql_locked());
>         // SAFETY: all accesses go through these methods, which guarantee
>         // that the accesses are protected by the BQL.
>         let fw_cfg = unsafe { &mut *hpet_fw_cfg };

Nice idea!

>         if self.count == u8::MAX {
>             // first instance
>             fw_cfg.count = 0;
>         }

Will something like ¡°anything that releases bql_lock¡± happen here?
There seems to be no atomicity guarantee here.

>         if fw_cfg.count == 8 {
>             // TODO: Add error binding: error_setg()
>             panic!("Only 8 instances of HPET is allowed");
>         }
> 
>         let id: usize = fw_cfg.count.into();
>         fw_cfg.count += 1;
>         id
>     }
> }
> 
> and you can assert bql_locked by hand instead of using the BqlCell.

Thanks! I can also add a line of doc for bql_locked that it can be used
directly without BqlCell if necessary.

And if you also agree the Phillipe's idea, I also need to add BqlCell
for fw_cfg field in HPETClass :-).

Regards,
Zhao



