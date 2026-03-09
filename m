Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FD4F3C26A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzb3G-0002CC-EN; Mon, 09 Mar 2026 09:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzb39-0002Bp-Vb; Mon, 09 Mar 2026 09:53:36 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzb36-0006rB-KN; Mon, 09 Mar 2026 09:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773064413; x=1804600413;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cIVgUpGmS0BGN4DiHlAK1Xk2bzz98JuTFMyOMf4rApQ=;
 b=WGwoi18MrjE3W205qS1JrJpXSSNBEY2zVdr5/hpVogKPRP/PXfRaTrBQ
 6SXYEF6WuYF1sDJS78pCETpeHt/bOqjeyU7J+YE4BoOckxI7nNL0/MzQZ
 gIPAEqkJjleA81MDuXYZ5TT6Mu+6DVHxMM3C7pE/Ls8/tM2B845f9S06S
 CvIxqzGzD3qIZBpbc1tChlpINvMw9CG2UUKPktMNuAtU4Bfzp+MLoPUL9
 px9HvkhTR4I+T6tQ66XbZE1DG0XZCCLwhP3H8VAe2w6vjBN/7BOrRSpT4
 CY1emkACCMr/zUuTbclTD38dNVIZBRkd/M1cR+Rwwvd+aI+kykL2DOyTJ w==;
X-CSE-ConnectionGUID: UZ3wWGy9SgaqgRc82u/zIQ==
X-CSE-MsgGUID: 93h0IndJQJuZLDbcfiv5mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="76690436"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="76690436"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:53:30 -0700
X-CSE-ConnectionGUID: 5RKwQITPQoeSkpHRa0kO7A==
X-CSE-MsgGUID: 3OyWIHpQSiiaY7yBDHNidQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="242780912"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2026 06:53:28 -0700
Date: Mon, 9 Mar 2026 22:19:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: fix NULL pointer dereference in
 legacy-cache=off handling
Message-ID: <aa7W+oqYHTfa8UH9@intel.com>
References: <20260305060431.30347-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305060431.30347-1-heifetz@yandex-team.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Mar 05, 2026 at 11:04:31AM +0500, Sergei Heifetz wrote:
> Date: Thu,  5 Mar 2026 11:04:31 +0500
> From: Sergei Heifetz <heifetz@yandex-team.com>
> Subject: [PATCH] target/i386: fix NULL pointer dereference in
>  legacy-cache=off handling
> X-Mailer: git-send-email 2.34.1
> 
> The check that xcc->model is not NULL occurs after it is dereferenced
> inside x86_cpu_get_versioned_cache_info(), so something like
> `-cpu host,legacy-cache=off` leads to a segfault rather than an error.
> This patch fixes that.
> 
> Fixes: cca0a000d06f897411a8a ("target/i386: allow versioned CPUs to specify new cache_info")
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>  target/i386/cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


