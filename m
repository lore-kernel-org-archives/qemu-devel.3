Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D92AFD0640
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0DsG-0000qS-N7; Wed, 11 Mar 2026 03:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w0DsD-0000pt-JC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:20:54 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w0DsB-0003CP-K4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773213652; x=1804749652;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4ZKAITOZ6IVgO7mEt+sJT3YogPjl9LQBhjgpgFwbuis=;
 b=c/xj1KFqFhyRkVBG7caO+wm8TWqg3/QlPOonEL7OGO9NnrqomPMgGJry
 3wm5jqFoLEYjSAipjhq6vubXJo1d3GflDd5vkg6FDxNFu/HZ64Q558rQ+
 HKggn7+aYVW5YTUlU3Vxexc+8546mOmQbyJkGNNl/c82PBkGFfpnaLeTZ
 Xp/Ul0Ml4r1vMwS1fjNlAJ33XoWN5jXhwRmLbt8Gd2RicY4pC/9qaR7oQ
 MI1X2s1ycmy+ea010aNHUZAZafNpBkCIlL7roxqOzKGUJ4b19PCbeSIH1
 YDT4WTPOuSwlBZEY5L/GR0Pg7zuDe6N8qbJbna9g03bRjAthpi5HKKl3Y g==;
X-CSE-ConnectionGUID: JXGYz6HkRGuJlVo+7il0ag==
X-CSE-MsgGUID: Kt/4HqTxS4ywsmLfINShKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85752388"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="85752388"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 00:20:50 -0700
X-CSE-ConnectionGUID: FbK/3rBOS/yosrzZ3ZdWKQ==
X-CSE-MsgGUID: 7pFjkEfaQXuxtHZIUaCGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="258286120"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 11 Mar 2026 00:20:48 -0700
Date: Wed, 11 Mar 2026 15:46:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH] coverity: fix coverity issues related to confidential
 guest reset
Message-ID: <abEd8jAaSGsaRK2P@intel.com>
References: <20260311034653.59826-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311034653.59826-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 11, 2026 at 09:16:53AM +0530, Ani Sinha wrote:
> Date: Wed, 11 Mar 2026 09:16:53 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH] coverity: fix coverity issues related to confidential
>  guest reset
> X-Mailer: git-send-email 2.42.0
> 
> Fix issues reported by Peter.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  system/runstate.c | 5 ++++-
>  target/i386/sev.c | 4 ----
>  2 files changed, 4 insertions(+), 5 deletions(-)

It's better to add Fixes tag or links.

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


