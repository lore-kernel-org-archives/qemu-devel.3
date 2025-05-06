Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0EDC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCi6-0000xe-4o; Tue, 06 May 2025 03:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCi1-0000x9-Nj; Tue, 06 May 2025 03:27:23 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCChz-0005F6-Vo; Tue, 06 May 2025 03:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746516440; x=1778052440;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=k7xjwy/7vKGYXMz2765wgqEtgqBWFgD/wU7Zjdb7FaA=;
 b=UX1v5WOsZ5CmBVDaIDl7nXZXoOLjKmTSigcBityutA7qUOt2vc12f6Ow
 Lczwvv5eHtzpHrsfKyZe7HgTFH5qAxwCWeZgkcUeUHK8GvVg8aGLj3AOU
 gjHj3RG2LFmKxLlOwUGN5wzejoxugTVieqr81n7ftvsI0rpn9Ab2gsRcx
 jWs0Lp1e8OfS3oTqj4T0xoKHscA5QTPDLfjHJ4HhIFLOvzrVOzpPeSuHW
 DYGIg68KW1X+kns3dUmiZ36tDxPBZ+SsnWSLSWLb03Vwu8bjkdwKYRqFr
 2nzv4s0tE4ppCOQ3bt47RoOxklUuOjgoCilyOBE09tGemEJhtI+EB6z9Q A==;
X-CSE-ConnectionGUID: o7YbiKd1Q6eUxS/AC0GUyg==
X-CSE-MsgGUID: ofFkkkbYTNOBeCue9HnujA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58792631"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="58792631"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 00:27:07 -0700
X-CSE-ConnectionGUID: Hfo7/A7cSbu+/h9BFTyfow==
X-CSE-MsgGUID: ROC315cgSsS75mV8gOzosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="135913354"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 00:27:06 -0700
Date: Tue, 6 May 2025 15:48:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 05/11] rust: qemu_api_macros: make pattern matching more
 readable and efficient
Message-ID: <aBm+ty12seysteC5@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 11:04:30AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:30 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/11] rust: qemu_api_macros: make pattern matching more
>  readable and efficient
> X-Mailer: git-send-email 2.49.0
> 
> "let ... else" is useful when visiting syntax trees; it avoids multiple
> levels of indentation and places the error close to the pattern.
> 
> While at it, use "ref" to avoid moving the syntax tree objects.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs | 84 +++++++++++++++------------------
>  1 file changed, 37 insertions(+), 47 deletions(-)

Good improvement!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


