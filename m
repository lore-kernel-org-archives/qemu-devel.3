Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2BFC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzcI-0005KG-53; Thu, 07 Aug 2025 08:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzbz-0004ry-Is; Thu, 07 Aug 2025 08:20:52 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzbw-0007X1-2C; Thu, 07 Aug 2025 08:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754569244; x=1786105244;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LbVxg0tKIbggmoAuf8j2u/UMS8LEZN+sQQ8SOVsObjc=;
 b=bpa2an+ExJ6gZ/4hZwEhoAujN/fgBUrGjjNzGFnjnIyeN0LDRtwgaajw
 N5IsCPeScPiUEFnVksjEPKvHBJXyaIK7VRWmwkTyZHCuMeyfCXJQweje9
 MEyiVYDkvbndmlfepMOkuGbXfXVHTv1LOipdcLtS4ySd6mcuktvf/GMjk
 9hJF0zALUKPElgp3YZxAmPOY75JlCrX1X8ojxSwx1tZvKasiw61uBu0vO
 TcHhsVUZKpPdFoWqRk8TTAyD/TAAZC0wpVg59ksMXTsiB2DZ8wult1CM/
 gbuwZcjnWIpMHUZbYt3J0ElRHkLV3iyVOOHqtS6d/MuwQcHW4zqW1rCxm A==;
X-CSE-ConnectionGUID: Y777dCGYQVSvlAiW3f+ZUw==
X-CSE-MsgGUID: AvirijgETzaiw+/vV0Ha4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56112770"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56112770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:20:41 -0700
X-CSE-ConnectionGUID: zo1DajA+Sx2xisqn95LPFw==
X-CSE-MsgGUID: I++JlNjPR7icqrpPYWmI+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164947891"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 07 Aug 2025 05:20:39 -0700
Date: Thu, 7 Aug 2025 20:42:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 00/26] rust/memory: Integrate the vm-memory API from rust-vmm
Message-ID: <aJSfKZLeNeIhbYjx@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 07, 2025 at 08:30:01PM +0800, Zhao Liu wrote:
> Date: Thu, 7 Aug 2025 20:30:01 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [RFC 00/26] rust/memory: Integrate the vm-memory API from rust-vmm
> X-Mailer: git-send-email 2.34.1
> 
> Hi,
> 
> This RFC series explores integrating the vm-memory API into QEMU's
> rust/memory bindings.
> 
> Thanks to Paolo and Manos's many suggestions and feedback, I have
> resolved many issues over the past few months, but there are still
> some open issues that I would like to discuss.
> 
> This series finally provides the following safe interfaces in Rust:
>  * AddressSpace::write in Rust <=> address_space_write in C
>    - **but only** supports MEMTXATTRS_UNSPECIFIED
> 
>  * AddressSpace::read in Rust <=> address_space_read_full in C
>    - **but only** supports MEMTXATTRS_UNSPECIFIED.
> 
>  * AddressSpace::store in Rust <=> address_space_st{size} in C
>    - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.
> 
>  * AddressSpace::load in Rust <=> address_space_ld{size} in C
>    - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.
> 
> And this series involves changes mainly to these three parts:
>  * NEW QEMU memory APIs wrapper at C side.
>  * Extra changes for vm-memory (downstream for now).
>  * NEW QEMU memory bindings/APIs based on vm-memory at Rust side.
> 
> Although the number of line changes appears to be significant, more
> than half of them are documentation and comments.
> 
> (Note: the latest vm-memory v0.16.2 crate didn't contain Paolo's
>  commit 5f59e29c3d30 ("guest_memory: let multiple regions slice one
>  global bitmap"), so I have to pull the vm-memory from github directly.)
> 
> Thanks for your feedback!

BTW, this is my branch which includes all the patches:

https://gitlab.com/zhao.liu/qemu/-/tree/rust-vm-memory-v1-08-04-2025

Regards,
Zhao


