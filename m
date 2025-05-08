Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E22C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 03:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCrul-0006AV-32; Wed, 07 May 2025 23:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCrui-00067w-Eo
 for qemu-devel@nongnu.org; Wed, 07 May 2025 23:27:12 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCrug-0004ja-GX
 for qemu-devel@nongnu.org; Wed, 07 May 2025 23:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746674830; x=1778210830;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=u1cPUNvH+ejgTBykEDHRQ59Zj9LvTxinqbTXaZLsO1w=;
 b=Y1aEhXbKHN3s+YW6PahtqFCfSuwUe+Matg44fIBf9jp5rSA0CwLGkZeS
 hC92ADFS/4yjbgYB/81th1XBb7ACrG9OqrLDizbl3exe+9L3ZL1Es4GiA
 DJxtApdIchKqhPTXcW/k1/CLFGQ2c0binxeUdVR1KnFr9wTN75nXbvian
 leOCzuhW8ERf4C5E/x7fuIJfC60hNktz+KYYQDl3s8i2CIQlW/4JfAO0F
 vWq4X1S9PDN2MwX4ITBkwge+cTaNU0zNt8QdWurfz8exNXm0EVhIX8ULJ
 kr4bKEbBsPV1U1m+puV5XdJIXaHTVDUYOyV/u5nkknM8zQTN4IBK+WFwJ g==;
X-CSE-ConnectionGUID: G4QBGl/RTA+KsHbYT2i1Tg==
X-CSE-MsgGUID: fx7ga9gUTHyEkBb5AchTHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59427205"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="59427205"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 20:27:07 -0700
X-CSE-ConnectionGUID: 45Q0kRY2TXSTy94qdNzoPw==
X-CSE-MsgGUID: M2bArtdGQP6YM+Esb+x4HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="141113564"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 07 May 2025 20:27:06 -0700
Date: Thu, 8 May 2025 11:48:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 3/4] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
Message-ID: <aBwpd8W2A7DBdmKm@intel.com>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <20250213142613.151308-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142613.151308-4-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Feb 13, 2025 at 02:26:12PM +0000, Peter Maydell wrote:
> Date: Thu, 13 Feb 2025 14:26:12 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 3/4] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
> X-Mailer: git-send-email 2.43.0
> 
> The x86 DE bit in the FPU and MXCSR status is supposed to be set
> when an input denormal is consumed. We didn't previously report
> this from softfloat, so the x86 code either simply didn't set
> the DE bit or else incorrectly wired it up to denormal_flushed,
> depending on which register you looked at.
> 
> Now we have input_denormal_used we can wire up these DE bits
> with the semantics they are supposed to have.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/tcg/fpu_helper.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


