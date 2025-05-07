Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8066CC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 12:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCeFh-0000BC-SC; Wed, 07 May 2025 08:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCeFg-0000Aa-2R
 for qemu-devel@nongnu.org; Wed, 07 May 2025 08:51:56 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCeFe-0006Jw-86
 for qemu-devel@nongnu.org; Wed, 07 May 2025 08:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746622314; x=1778158314;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=u7gGagi+UA8FI7CxgiDR/Io6Lb2t24L/iv1V75g400w=;
 b=SUzZEViVW8OAk5mUeCP5bGknv2UKOQ0INGVm6Tv7j4JbFzcWa5LE0FV4
 qihve1pbVxruSvMSx9a0ft06DckaE/tfXgkMKIotX3WxYonTuiQqUdeha
 XgqAqKBPDO7orku3vqWd2Wl+g2rclznd431ATBA34r2njsNCqGO3NDXlC
 l4GRx2LBFUwSqvu2OncNm1OzUb3cEY3C0s0yztw4ALVT4/J5vjSHgygAd
 7fzF+DcZcH4bsSBCjTcCAG1cvF96Yh4uINzMUo0F9uT4a5lDQIZC03siJ
 d2kyzumzUWgRWvx0VE0MifqAnDkygfBjkYT4ZkUR7ax2QgmRJDBH/bMIN w==;
X-CSE-ConnectionGUID: TFCAWFcJScKIX5BDEPGcpQ==
X-CSE-MsgGUID: 0s8bS65pTmyGTBKJrFAVHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48250685"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="48250685"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 05:51:52 -0700
X-CSE-ConnectionGUID: 9uMFJ/RqS9S8qbK04j8Rlw==
X-CSE-MsgGUID: pRKy3hJ1QBOpfU+3v86h7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="136344015"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2025 05:51:51 -0700
Date: Wed, 7 May 2025 21:12:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 2/4] target/i386: Use correct type for
 get_float_exception_flags() values
Message-ID: <aBtcU6c+UTyvbt13@intel.com>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <20250213142613.151308-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142613.151308-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Thu, Feb 13, 2025 at 02:26:11PM +0000, Peter Maydell wrote:
> Date: Thu, 13 Feb 2025 14:26:11 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 2/4] target/i386: Use correct type for
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
> ---
>  target/i386/ops_sse.h        | 16 +++----
>  target/i386/tcg/fpu_helper.c | 82 ++++++++++++++++++------------------
>  2 files changed, 49 insertions(+), 49 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


