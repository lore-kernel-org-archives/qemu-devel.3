Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5348CC54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 01:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHCCM-0004K3-IS; Mon, 19 May 2025 21:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHCCJ-0004IQ-IO
 for qemu-devel@nongnu.org; Mon, 19 May 2025 21:55:15 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHCCH-0004v2-Mm
 for qemu-devel@nongnu.org; Mon, 19 May 2025 21:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747706114; x=1779242114;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=qtJxdGfWg/K0ia1OgQB9y/YcvmKNhsVHqeya3tdjo6s=;
 b=WLDsLMoGCufgE4jkDLTxRJ4EUh8dBUcot3Bga9MvLTNAHGutoOydzwvy
 CI81can/ZVuE/DZjVMGTh9Bg5+Ls9HeXnurMi8kcqF/wz1Lm1hLYCBkDH
 FX97Jv9xcYaTXa3PxYkbXftH3gDsljAJ7/aHYLXGHgyRE7K+CZ7YEn4pO
 IKZf6FNQ1GqHjK0FkUFo/KQxZki7P3O+etSYBrJ5JtxyyPBg6ahXd7wLK
 3JApJWtI8QLS86EN2thqYqvyUniV/feo5ZfBPC5TWzD9ZLlVI5lruanzL
 IXhM2CdjHSd37LAzO6fCBvDCTFIme2us/eshEQJpMPQqctN0lSDaJIEzz g==;
X-CSE-ConnectionGUID: SDSjI/tORfGU6rLZArjFDw==
X-CSE-MsgGUID: 2gd6OFxGT4OBlBK8H18jHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49553609"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49553609"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2025 18:55:10 -0700
X-CSE-ConnectionGUID: Lhb3fv1fRKeskCj3EECZZQ==
X-CSE-MsgGUID: alA7/sGxSQaH0cjSqM63wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144662910"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2025 18:55:08 -0700
Date: Tue, 20 May 2025 10:16:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 2/4] target/i386: Use correct type for
 get_float_exception_flags() values
Message-ID: <aCvl7mx4YI4g8+gT@intel.com>
References: <20250519145114.2786534-1-peter.maydell@linaro.org>
 <20250519145114.2786534-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250519145114.2786534-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

On Mon, May 19, 2025 at 03:51:12PM +0100, Peter Maydell wrote:
> Date: Mon, 19 May 2025 15:51:12 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH v2 2/4] target/i386: Use correct type for
>  get_float_exception_flags() values
> X-Mailer: git-send-email 2.43.0
> 
> The softfloat get_float_exception_flags() function returns 'int', but
> in various places in target/i386 we incorrectly store the returned
> value into a uint8_t.  This currently has no ill effects because i386
> doesn't care about any of the float_flag enum values above 0x40.
> However, we want to start using float_flag_input_denormal_used, which
> is 0x4000.
> 
> Switch to using 'int' so that we can handle all the possible valid
> float_flag_* values. This includes changing the return type of
> save_exception_flags() and the argument to merge_exception_flags().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/ops_sse.h        | 16 +++----
>  target/i386/tcg/fpu_helper.c | 82 ++++++++++++++++++------------------
>  2 files changed, 49 insertions(+), 49 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


