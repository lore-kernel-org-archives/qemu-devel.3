Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2A2E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBdp-0003Ak-VM; Tue, 07 Jan 2025 10:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVBdn-0002y4-Os; Tue, 07 Jan 2025 10:37:11 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVBdl-0005YM-M8; Tue, 07 Jan 2025 10:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736264229; x=1767800229;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XCZzl+buYDclRmkgsVH4Yt09a40/e44VZXfhyc5VbpQ=;
 b=Yhz3Bd0e0q5Ai0Uz14ixFK6eriVIsULXq0oMCQAtOxV17zqLlKO69Mw6
 9d8okJBeycCvgr/zB8MewUmq5FJhkQNOgimLihzIUL8HO+HLUJVo8jFsf
 YqM/MS9lbeUu4cQNfigwYUOLym/gnoOtFA0t+ES55zewKugcI4fSyVaVU
 qQP2MxOsqynfehnIRYlU63TvHpsBEs+MWnyy2UJnglM/ghfdHhJcmk0Ab
 xvcPY1uwgayJknpfxeMSLDp57AGbz29A7FtBDletMUWyp1JcaC68HyNjm
 gTF8rP8TCLenMA/Vb+SAov9QreR6yKxcGRs1PKOUOtK1kVWabAsoNJEVD Q==;
X-CSE-ConnectionGUID: VmHZWESXRDuXcBQ07bAMnA==
X-CSE-MsgGUID: R2/oXIxkRBuS0ypDYVtsKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="58918289"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; d="scan'208";a="58918289"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2025 07:37:06 -0800
X-CSE-ConnectionGUID: cAaLE8/KTEantrsyvHyn2w==
X-CSE-MsgGUID: qL2+2CzjQHazhhTdck2m1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="126095713"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 07 Jan 2025 07:37:04 -0800
Date: Tue, 7 Jan 2025 23:55:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
Message-ID: <Z31OiMcYT/66AGDt@intel.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
 <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
 <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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

On Mon, Jan 06, 2025 at 04:21:16PM +0100, Paolo Bonzini wrote:
> Date: Mon, 6 Jan 2025 16:21:16 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
>  ClassInitImpl<>
> 
> Il lun 6 gen 2025, 14:32 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:
> 
> > I think here I agree with Philippe that we might as well
> > provide only the new API to Rust devices.
> >
> 
> Ok, I wasn't thinking of doing that because there isn't right now an easy
> way to add interfaces to Rust-defined classes. However, all devices are
> Resettable and Device isn't defined in Rust, so it's not hard to add a
> ResettableImpl trait in rust/qemu-api/srv/qdev.rs, and initialize it for
> all devices.
> 
> If anybody wants to do it as an exercise, I am happy to help, otherwise I
> can prepare a patch too.
>

If possible and if no one else wants to practice, I would also like to
give it a try (I'll add it to my list).

Zhao


