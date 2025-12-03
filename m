Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC2BD12D77
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoPe-0001LF-4C; Wed, 03 Dec 2025 10:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoPJ-0001Ac-AO; Wed, 03 Dec 2025 10:04:45 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoPF-0000IH-WB; Wed, 03 Dec 2025 10:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764774278; x=1796310278;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/IYOndO6KXs4LxlX6qXO7YoyTKxD1aGlepAOyOJwnSw=;
 b=SQDL4aQv0WRYY+fMfJhUytv/t2jFJ9r/ShKs3baldVR0Y6IXvcXN25bu
 gLy3rzCsiQtjb0NlTxTclkZ/ycGxk4prEq86+xj5YE7M5/nDeV0Xk6TZN
 RcFKs50FDpglJgyI3STJCToEIPrT3lWQIeheiilEvN0KBFcJNXoE7Q1RZ
 mbl5w8NJOJPsgP+JMXDUY/LQMiQb2pHEoUakOSXIQ+5DfW/EOUBN4T3BG
 R//IwtHfmFNHj4HXVaJ2DbVHAVHSP+fMugz43xjhCYUf40Ug6Hgl4hAN+
 xyPHjcLcGd+PVYpwSwEKWoFVPqkNhxhzV3mmf5fpL3TerlvVIlfe9v+jW A==;
X-CSE-ConnectionGUID: w+j4zPZKSf2oUhAuMfzrPg==
X-CSE-MsgGUID: /w+iBX+kT7KwuymPS176/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66844192"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="66844192"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 07:04:31 -0800
X-CSE-ConnectionGUID: +OddCAsxSCiHHaPIl8cRhA==
X-CSE-MsgGUID: d94l/S0JTMu65u9MSB9PLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="225668514"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2025 07:04:29 -0800
Date: Wed, 3 Dec 2025 23:29:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 7/9] rust: move strict lints handling to meson.build
Message-ID: <aTBXSBCgegBKVNNn@intel.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127132036.84384-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 27, 2025 at 02:20:34PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Nov 2025 14:20:34 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 7/9] rust: move strict lints handling to meson.build
> X-Mailer: git-send-email 2.51.1
> 
> Simplify rustc_args.py, and align its code with what Meson's own Cargo.toml
> translator does in v1.10.
> 
> Bump unknown_lints to "forbid", so that it will certainly override Cargo.toml's
> "allow" level.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                |  7 +++----
>  scripts/rust/rustc_args.py | 20 ++------------------
>  2 files changed, 5 insertions(+), 22 deletions(-)

After simplification, it has become more readable.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


