Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4819DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 07:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOB5Z-0000CB-CM; Thu, 19 Dec 2024 02:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOB5T-0008Vv-2d; Thu, 19 Dec 2024 02:36:47 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOB5R-0000Lc-4E; Thu, 19 Dec 2024 02:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734593805; x=1766129805;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Gvc0SwrNU+az+om9HHFCHVWCt6tpqRvu0V8LhzumCaQ=;
 b=dy/XwAGHrQlxUYYJMTOuBYQyPUcgyJYB4uD/7T6P78pvahOO3sYQdpb4
 msh/dliixSmuz5er1meqIqbaPrZpcCZJ20OHep400zdwMsbdNCknLCfbh
 NapBR3A7d8XlrXvo/SJXmD8W+vKOTU00UCA6hSPrsONpYWdAoesdEmr8O
 Sc9iyBxTFcRZLwTxR1q2wfTZUomGBwrIue1AT7SI+TNT7V/0/ijGPqhLY
 spT3Q+1cMgEUacz2FSU3te/1mqE+bvtCsHCXk48gZaY8FMSGK0xeLmDzu
 Z5JfD3G31UP2Tnugdw4aiS9J3ylkzz5IRcIyand9WrdRFWk/GlZh2XyZ7 g==;
X-CSE-ConnectionGUID: 6IHJ7FJwQVe6l9CIDz/gsg==
X-CSE-MsgGUID: rcfn521zSxOrVKYbGSumlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52501878"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="52501878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 23:36:42 -0800
X-CSE-ConnectionGUID: Iqt26HL5RCukxSoZhzGQUg==
X-CSE-MsgGUID: 92/48LjAQry/y59yfZf+tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="129089182"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 18 Dec 2024 23:36:41 -0800
Date: Thu, 19 Dec 2024 15:55:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 7/7] rust: pl011: simplify handling of the FIFO enabled
 bit in LCR
Message-ID: <Z2PRaazDXAkN65hF@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212172209.533779-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 12, 2024 at 06:22:04PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 18:22:04 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 7/7] rust: pl011: simplify handling of the FIFO enabled bit
>  in LCR
> X-Mailer: git-send-email 2.47.1
> 
> Use ==/!= instead of going through bool and xor.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 6 ++----
>  rust/hw/char/pl011/src/lib.rs    | 6 ------
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


