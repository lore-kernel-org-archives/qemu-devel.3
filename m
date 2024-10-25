Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3554DD0C5F8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4H1f-0007Ae-22; Fri, 25 Oct 2024 05:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4H1X-0007AC-TT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:54:28 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4H1V-0005jE-KU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729850066; x=1761386066;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1e8CKrSCaJfh4of/dCdiXZLWpTodBCTemiyWfh340YQ=;
 b=Kni6lHEMEedrhTKeKWWZ0OJuX7OC6yQxsMmdrJ1nnwYIkuOqhQIScJWO
 J/LO8vGnletBWTZg1UIxquVxOh+Ln5iTfhIC6KKt23WacO6YstmatJRg+
 8+NNpk4Dm/PL4tOjBlQTsOk86bPluCIndRA3frXh9cJJ/zwuI8eEtWaqL
 AAAGcMIP1APOs1pqrmct1pWosbE5Pwf89pR4GnJct0vpi4nIwDwskQCnA
 96wDcspzp5u2dF7fpI22ZV08OouwG90zYb9GOXNam4pIiuaBITK+dy9Wc
 jSolk7fwAgFwJDg/2KEUY3lgyAKF9B9tmuZfxgvyNrtVqXt9cpm7yqYFu Q==;
X-CSE-ConnectionGUID: U4c8881fTaafSAeKbhJ8Fg==
X-CSE-MsgGUID: fY9SeW7qSEqZlxJA4qdy1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29623957"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="29623957"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2024 02:54:22 -0700
X-CSE-ConnectionGUID: W79WVS+2QniLoIG2zgmiGg==
X-CSE-MsgGUID: mrQCE6L3S1SvR9/LYSa9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="81699488"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 25 Oct 2024 02:54:21 -0700
Date: Fri, 25 Oct 2024 18:10:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 12/13] rust: provide safe wrapper for
 MaybeUninit::zeroed()
Message-ID: <ZxtungaSiLaalOcx@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Mon, Oct 21, 2024 at 06:35:37PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:37 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 12/13] rust: provide safe wrapper for
>  MaybeUninit::zeroed()
> X-Mailer: git-send-email 2.46.2
> 
> MaybeUninit::zeroed() is handy, but it introduces unsafe (and has a
> pretty heavy syntax in general).  Introduce a trait that provides the
> same functionality while staying within safe Rust.
> 
> In addition, MaybeUninit::zeroed() is not available as a "const"
> function until Rust 1.75.0, so this also prepares for having handwritten
> implementations of the trait until we can assume that version.
> 
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device_class.rs |  8 ++++++--
>  rust/hw/char/pl011/src/memory_ops.rs   | 11 +++++++----
>  rust/qemu-api/meson.build              |  1 +
>  rust/qemu-api/src/device_class.rs      |  8 ++++----
>  rust/qemu-api/src/lib.rs               |  1 +
>  rust/qemu-api/src/zeroable.rs          | 23 +++++++++++++++++++++++
>  6 files changed, 42 insertions(+), 10 deletions(-)
>  create mode 100644 rust/qemu-api/src/zeroable.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


