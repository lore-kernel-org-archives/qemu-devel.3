Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF9CC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkRRC-0007nv-4F; Tue, 18 Feb 2025 12:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkRR5-0007nF-J1; Tue, 18 Feb 2025 12:31:09 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkRQz-0001lY-5r; Tue, 18 Feb 2025 12:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739899861; x=1771435861;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vrbtIkajmTzzwRv+nIlgYsykkmPfEN/3RskWFbENmKo=;
 b=F6WiByEBgh8Z7pq5QWpOrtm7ezWtqbjZWRkUn5PuyXIXt5mGFFj0xy5k
 PWzg8PkZVFZBMUpGdX+bfAEsk5oCIsoz2iDxwKBpS/agvle6TwUa1e+07
 l0W8PEWHW6UKJW5BFaKun/9/VCvnHAko1ZPz1uFXEZx5rxaEYtT6s87A2
 SI7Lm88zPkPvR93AEaerZWeVigMIHSFQEI3TiWjXdeIFEhMHCpzDoQqoN
 JpOU6SkTyENjTkcCxiXrMvgztmjlcaR9eY7fPekDJyUWqExVf25OGCGhE
 MSVi6xm5UcNCLU5gpFCHpOa+LLj6y9H84bPZ3kpTCjES7zSWa1SJi8/AM A==;
X-CSE-ConnectionGUID: MWnhIyw2S+OYTttOcSVhfw==
X-CSE-MsgGUID: YcyHZkR4RDC+NdErAdwJ2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51230082"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="51230082"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 09:30:54 -0800
X-CSE-ConnectionGUID: c2EeLITaTYmjm8tS4jcXRg==
X-CSE-MsgGUID: B2UXB1xLRIC0323uFfyQZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="114644628"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 18 Feb 2025 09:30:53 -0800
Date: Wed, 19 Feb 2025 01:50:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: Prefer link_with over link_whole
Message-ID: <Z7TIY2YWBahIElOb@intel.com>
References: <20250218083734.3345966-1-zhao1.liu@intel.com>
 <88a20e34-5aa8-4351-a33f-4df110933e35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a20e34-5aa8-4351-a33f-4df110933e35@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

On Tue, Feb 18, 2025 at 09:58:44AM +0100, Paolo Bonzini wrote:
> Date: Tue, 18 Feb 2025 09:58:44 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH] rust: Prefer link_with over link_whole
> 
> On 2/18/25 09:37, Zhao Liu wrote:
> > The commit fccb744f41c6 ("gdbstub: Try unlinking the unix socket before
> > binding") causes the compilation of rust-qemu-api-integration to fail,
> > because rust-qemu-api-integration uses link_whole which meets the
> > duplicate symbol linker error.
> > 
> > Though it's not the issue of link_whole used by Rust side, there's no
> > need to use link_whole.
> > 
> > Use link_with, which may also bring some benefits, such as faster
> > linking or smaller output files.
> 
> link_with, if I remember correctly, drops the constructors.  Using it in
> rust_devices_ss therefore prevents the devices from being registered with
> QOM.

Interesting, I test with link_with and HPET QOM type can be registered.

I find this is because `module_init` macro adds `#[used]` for `LOAD_MODULE`,
which prevents linker dropping QOM type.

Without `#[used]`, both link_with and link_whole will optimize
`LOAD_MODULE`... So here `#[used]` is the key to getting everything to work
properly.

> The real issue is lack of support for "objects" in Meson for Rust
> executables.  A patch to fix that is under review, after which it will be
> possible to build Rust executables using the same "dependency" objects as C
> code.

HMM, but with link_with, everything seems to compile fine?

Thanks,
Zhao


