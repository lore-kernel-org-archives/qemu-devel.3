Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6C0E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 06:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNntC-000190-T5; Wed, 18 Dec 2024 01:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNntA-000186-Kd; Wed, 18 Dec 2024 01:50:32 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNnt8-00050N-5x; Wed, 18 Dec 2024 01:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734504630; x=1766040630;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Coeb0/EJZfk8W8t/7szNv8f/QMvQSM5Hksl+GpfjeW0=;
 b=GmIh4Y4QJBKlBYJ0SEUrlbUzfWfVdMZv8JzGwSuv2WD9i0g3beJAdFxN
 v2LFC1+KwbNrCP8ZJM1KiH+2jUiDfhubo7rlp7Gtvi0xuEvZbVsufCLU0
 w+EX4cLy51+wi9GoIEmvZSULYyaKbnmLkwdv71U+HvxowiM9FPnraIItq
 T25gZT52bpFc7hVxzyTwTQ/FBlHaD+Vb29eGpuW30F/teEYbgbebneo0G
 5MzH5WbRqaw/6sSaKq/Sb+/3sPLygKD1fzzej215lLXuGaTY7/gulevA6
 UIoJOucqAgWtIoubWSDnCskD5HtP+11+s5ujh3AyldVOsYJhyRPF0imj6 A==;
X-CSE-ConnectionGUID: eUvdtILERM66kspsupBvEg==
X-CSE-MsgGUID: kAP/p5AsR+eGe8frTlsFqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34998226"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="34998226"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 22:50:26 -0800
X-CSE-ConnectionGUID: UdqYtNE4R62+jjyMZ5EzKw==
X-CSE-MsgGUID: cClgMYqtTW6kPRukSwZBdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="101902041"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 17 Dec 2024 22:50:24 -0800
Date: Wed, 18 Dec 2024 15:09:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 26/26] rust: callbacks: allow passing optional callbacks
 as ()
Message-ID: <Z2J1EI+R51GqPhVA@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-27-pbonzini@redhat.com>
 <Z2GjLOppRcHFBpAT@intel.com>
 <CABgObfYE8z5QeVSWT7odaPcZYNfW0Ox1gNmGyCvj0YRTsDEGrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYE8z5QeVSWT7odaPcZYNfW0Ox1gNmGyCvj0YRTsDEGrg@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Dec 17, 2024 at 05:40:14PM +0100, Paolo Bonzini wrote:
> Date: Tue, 17 Dec 2024 17:40:14 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 26/26] rust: callbacks: allow passing optional
>  callbacks as ()
> 
> Il mar 17 dic 2024, 16:55 Zhao Liu <zhao1.liu@intel.com> ha scritto:
> 
> > On Mon, Dec 09, 2024 at 01:37:17PM +0100, Paolo Bonzini wrote:
> > > Date: Mon,  9 Dec 2024 13:37:17 +0100
> > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > Subject: [PATCH 26/26] rust: callbacks: allow passing optional callbacks
> > as
> > >  ()
> > > X-Mailer: git-send-email 2.47.1
> > >
> > > In some cases, callbacks are optional.  Using "Some(function)" and "None"
> > > does not work well, because when someone writes "None" the compiler does
> > > not know what to use for "F" in "Option<F>".
> >
> > I understand the direct use case is MemoryRegionOps, which has optional
> > callbacks. However, I'm not quite sure how exactly it should be applied
> > to C bindings and how it will play with Option<callback>.
> >
> 
> You wouldn't use Option<callback> at all, using () instead of None; the
> difference is that () does not have a parameter while None does (and the
> compiler cannot infer it). But I am okay with leaving this patch behind
> until there's a need.

Am I using the wrong terminology? Function pointers in a structure should
be called a vtable, rather than callbacks (for example, methods in TypeInfo,
read/write methods in MemoryRegionOps). Callbacks are typically function
pointers used as function parameters (for example, timer/gpio). So, is the
callback implementation here only used for the latter case?

Thanks,
Zhao


