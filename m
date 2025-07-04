Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212CDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXd14-0003E0-Er; Fri, 04 Jul 2025 05:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd13-0003Dr-CS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:47:33 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd11-0005xa-MB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751622452; x=1783158452;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rwcV4sKt2apMOij/fd7gqN4SDf9ludDIO8eQzpKKmmU=;
 b=XRLMz55F3A45t1GYTbun+7rP+XHdDklF48P2ULtLA7/hT9uF8WFAGNHa
 TT3cslG+q1jMHRhhxvQZGFWla05V7LHaCDeB7+fLrpapYtJzQfrXhZtxc
 2HEmqSbtrNuN+QjBk0q9yY44umj35C3DFu2ENQsgABK4G/M+uz56OzZ2+
 PIPKiCZExnPUpJIH7QbTF8gXfdxJ3SXka+DeZljMAe/WqeP9FPUqWBTC7
 pAYyyN8oQL+mVbGReZ8HXOswpEs8Sd0X4KXMvtS3+C+AxBCPBKLyZfE2U
 w3p3SrA4WySr2ghQ/H/sbDhhj1QhR6kBaUvsGT8oGbaZuRC0cp0JpmeWU w==;
X-CSE-ConnectionGUID: /0juOBrlTrOpJVTesJDUkQ==
X-CSE-MsgGUID: 3RXkdCHYRyC6l/w+tGFHjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53822771"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53822771"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:47:31 -0700
X-CSE-ConnectionGUID: D88yNNy9R3W90/RTEHWY5w==
X-CSE-MsgGUID: nzajWCfyRq6N1rnT0cGAgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="185560658"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 04 Jul 2025 02:47:29 -0700
Date: Fri, 4 Jul 2025 18:08:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 19/39] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Message-ID: <aGeoN6UchE6YynU7@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-20-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-20-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

On Thu, Jul 03, 2025 at 07:32:25PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:25 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 19/39] accel/nvmm: Replace @dirty field by generic
>  CPUState::vcpu_dirty field
> X-Mailer: git-send-email 2.49.0
> 
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


