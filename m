Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B1AE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 15:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJwxR-0005SR-SX; Sat, 07 Dec 2024 10:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwxO-0005S5-Qp; Sat, 07 Dec 2024 10:42:58 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwxN-000229-An; Sat, 07 Dec 2024 10:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733586177; x=1765122177;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ox3STfwhqfQej4dr7pPylHNN7+q2kt4Vm5hxoC76TJ8=;
 b=RNtnMe0qLnjdYk75NL+I4qRvokDWYbBor2gYQwTWff9QLHg4f6FFZplF
 Jg3WNSw5vpUpL3pmb/4RS6CoBon4N7Z5TfQvk413w5Op8PevSssiHxM4i
 6n5Ou3kmoTUdOCBOOy0FzV74kEbXaFuujKdRnRwqs2i06rwlMiQ1UysQg
 wGvb3jOAdfrR09T0xd9c24rFp70W8H7U4ZrnhdgIkppMuFPEbAM+e19Mt
 T9+GuNQ9082iV4kHRuWnfDTHOeQrENlaxy41xes1wxZnWvS5CF5BOjvhk
 6Y+mtsWCu7SHug5XJGOm9xA7Xr5Z+yskIncNrBJqzp8wAVbFDiKE2Yltb A==;
X-CSE-ConnectionGUID: U1jlkpJYQSuc2Fun1V3gsA==
X-CSE-MsgGUID: zGj82a50TqCMiOpB0p5KMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34046518"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="34046518"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2024 07:42:54 -0800
X-CSE-ConnectionGUID: LAcFfVrER0CXFOybfOwHUg==
X-CSE-MsgGUID: D0eL4D9RRkWp5pcTteEnpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="95037350"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 07 Dec 2024 07:42:52 -0800
Date: Sun, 8 Dec 2024 00:01:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 05/13] rust: add a bit operation binding for deposit64
Message-ID: <Z1RxQU7sgxi2WJxQ@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-6-zhao1.liu@intel.com>
 <adb80a8c-ee40-4d8e-898b-a62d12746aa9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb80a8c-ee40-4d8e-898b-a62d12746aa9@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 05, 2024 at 05:09:42PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 17:09:42 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 05/13] rust: add a bit operation binding for deposit64
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > +pub fn deposit64(value: u64, start: usize, length: usize, fieldval: u64) -> u64 {
> > +    /* FIXME: Implement a more elegant check with error handling support? */
> > +    assert!(length > 0 && length <= 64 - start);
> > +
> > +    let mask = (u64::MAX >> (64 - length)) << start;
> > +    (value & !mask) | ((fieldval << start) & mask)
> > +}
> 
> This should be more generic and implemented as a trait that is
> implemented by u8/u16/u32/u64.

Yes, I agree!

> It's okay to rewrite these utility
> functions in Rust instead of relying on bindgen, because the way
> you'd like to use them is likely different from C.  Something like:
> 
> pub trait IntegerExt
> {
>     fn deposit(self, start: u32, length: u32, fieldval: U) -> Self;
> }
> 
> impl IntegerExt for u64
> {
>     fn deposit(self, start: usize, length: usize, fieldval: u64) -> u64 {
>         /* FIXME: Implement a more elegant check with error handling support? */
>         assert!(length > 0 && length <= 64 - start);
> 
>         let mask = (u64::MAX >> (64 - length)) << start;
>         (value & !mask) | ((fieldval << start) & mask)
>     }
> }

Then C and Rust would be using completely different bitops library, is
it necessary to implement the C interface directly in Rust instead of
keeping the C implementation (when Rust is enabled)?

> And we can add a "prelude" module so that you can do
> 
> use qemu_api::prelude::*;
> 
> and get all these useful traits at once.  I will send a patch after
> fleshing the idea out a bit more.

Thanks! Cross fingers.

Regards,
Zhao



