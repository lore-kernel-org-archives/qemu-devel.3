Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4696FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIeY-0003G6-La; Tue, 04 Nov 2025 10:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIeV-0003Bz-6n; Tue, 04 Nov 2025 10:08:55 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIeS-0004pI-8V; Tue, 04 Nov 2025 10:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762268932; x=1793804932;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KpJRVZW+6EbG9bYu9D7ISGWrEf8TMPCUQSWjm8yEhOQ=;
 b=FkLZM7D+1rNAL5sMV0+BWTgAVw2N/5OGK5u6gLXmSt8boY640ukrrM5T
 205cbZupptMgikxFSE+K0+ufbPAdQQsH0D0BQ0tcqEbIDQgbzVxJtLnwv
 jThTplvwm45tjoRvX6mpyzGEG/pfjuhdXBuwny7SuY0W8O4qOMbaAU1IO
 Wv+4oumhYS7hYpJu61SSRPkQnNCCdK7Fl7vqzqS+tt1kijnEo/6jHSdCs
 Ld1R0t+GZltiexZKN491xrv9YRyT4TXXvL0lyKzNau0UvQq4hzIXaZ62d
 qEjpUCs+ccHLdYi4pyn57XDlhIG3XE6GWF6LvHvUHV+tRkXo04D5SmrrM A==;
X-CSE-ConnectionGUID: u/3iEa5lR0qv6e8h6ueLow==
X-CSE-MsgGUID: Gz4/57ZKQeWzd44ZgNtxIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64292482"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64292482"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 07:08:49 -0800
X-CSE-ConnectionGUID: T7+vRJonRRG901vmdr5t8A==
X-CSE-MsgGUID: 1Hf29rBUTLSqWsqMHU0m3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187034932"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2025 07:08:48 -0800
Date: Tue, 4 Nov 2025 23:31:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/4] rust/util: use anyhow's native chaining capabilities
Message-ID: <aQocNkSa/xJtjkdE@intel.com>
References: <20251031152540.293293-1-pbonzini@redhat.com>
 <20251031152540.293293-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031152540.293293-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

On Fri, Oct 31, 2025 at 04:25:37PM +0100, Paolo Bonzini wrote:
> Date: Fri, 31 Oct 2025 16:25:37 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/4] rust/util: use anyhow's native chaining capabilities
> X-Mailer: git-send-email 2.51.1
> 
> This simplifies conversions, making it possible to convert any error
> into a QEMU util::Error with ".into()" (and therefore with "?").
> 
> The cost is having a separate constructor for when the error is a simple
> string, but that is made easier by the ensure! macro.  If necessary,
> another macro similar to "anyhow!" can be returned, but for now there
> is no need for that.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/src/error.rs | 160 +++++++++++++++--------------------------
>  1 file changed, 59 insertions(+), 101 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


