Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C568D2AB2C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 08:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t64Dm-0006vH-J5; Wed, 30 Oct 2024 04:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t64Dh-0006ut-Hn
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:38:25 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t64Dg-0000z9-3D
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730277504; x=1761813504;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kCWpwSoH8/QxyQAdbgqCWPxs0u19d5JyPUtRBeyKLFg=;
 b=SUKnsbVjj/HW1WB0pZJbUEE+NaKw6k5Srhxo/33D/97TekEVTn5wBqv4
 ln+OuCmB8w/ot2I2P6hfwSiYKJ3RDXd0Vxa6YY9GGRVXAMApf6VO++7Gw
 9iJH8Lmi/GFzFoGxzjWkSB+2Q5mz4qJgA6I4eK6hGERpvYhqUAph2gM8R
 X3puQlqDGowKWOVPMH7oWCJLBS+ajaKBrLlNpNPBZl6bYRaOeUPhkzW7U
 yI7M/BGK6oFAHOuGbgCywPfkiQKtZzO4scKs1d3dBbksEiRMnu+UsHQWs
 Akzes8VpaVbcfF7vjeTahy9A4iQR7vqtPtSFFXnrQajc0JP5PKHwUUy5U Q==;
X-CSE-ConnectionGUID: VQ8+QjWGTMie62FCcck+RQ==
X-CSE-MsgGUID: eg/z7o8STBiyHJgrcHdgjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30178497"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="30178497"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 01:38:22 -0700
X-CSE-ConnectionGUID: 5/YOCTMWQK+T7tTo82Cw9Q==
X-CSE-MsgGUID: gC9LwmpTR/GkdzzoERlyBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="86845104"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2024 01:38:20 -0700
Date: Wed, 30 Oct 2024 16:54:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tao1.su@linux.intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 7/8] target/i386: Add AVX512 state when AVX10 is supported
Message-ID: <ZyH0UBMCOCLcXVx1@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 04:18:57PM +0100, Paolo Bonzini wrote:
> Date: Tue, 29 Oct 2024 16:18:57 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 7/8] target/i386: Add AVX512 state when AVX10 is supported
> X-Mailer: git-send-email 2.47.0
> 
> From: Tao Su <tao1.su@linux.intel.com>
> 
> AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
> are identical to AVX512 state regardless of the supported vector lengths.
> 
> Given that some E-cores will support AVX10 but not support AVX512, add
> AVX512 state components to guest when AVX10 is enabled.
> 
> Based on a patch by Tao Su <tao1.su@linux.intel.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


