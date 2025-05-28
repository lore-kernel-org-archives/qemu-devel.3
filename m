Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB8EC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 07:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBgr-0001fh-1r; Wed, 28 May 2025 03:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKBgo-0001et-Rg; Wed, 28 May 2025 03:59:06 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKBgm-0002i7-F0; Wed, 28 May 2025 03:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748419144; x=1779955144;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9rDHtWPUg/MosXmpkGkMSUu6rsT8SpDCjTYfvSpiacw=;
 b=MdW+d1r+dVh83MPcUxJXl9KI1nMHCmRcn7uQ3mLtCfxTF+DVtrOHwYAy
 spkBoZDd1MpdJT5IPSnhNvd9w7SaHl+q3pyspt62hiKdCYAfWFgq8o2fw
 v9/rViMccIXPQrOpnuGvbiZrBDaWi3lcbOUpxiFe9aG7QWXIwP0FGKA+K
 /ZwOD/eBZZ9RVWnNmjH5pEzLaO4WVNoKTglpHO4bS3W20ZDk9TNsKT1yV
 MRSCNhV/utc99OKO+97ZvjNTpyK0wYSwHgPftD8rtE6TzpNUG+MdG/iAq
 DRZ58DYd/kjn4CWIa/htwMj/XamNh5IpIwpaimFj2kDE8OGy/qc6dudhA g==;
X-CSE-ConnectionGUID: bWn8YiQETkKrkwdqKptYAw==
X-CSE-MsgGUID: 1OTpE1N6T4KurqEHmbUP5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50319262"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="50319262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 00:59:00 -0700
X-CSE-ConnectionGUID: bN7RlZ/9Q6SETWDrzc0SCg==
X-CSE-MsgGUID: SBqhHIFOQqaluconM7yFFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143146571"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 28 May 2025 00:58:58 -0700
Date: Wed, 28 May 2025 16:20:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/12] util/error: make func optional
Message-ID: <aDbHONQNGrXBxmuL@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 26, 2025 at 04:24:49PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:49 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/12] util/error: make func optional
> X-Mailer: git-send-email 2.49.0
> 
> The function name is not available in Rust, so make it optional.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/error.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

panic::Location does not provide function name information. Although
there are macros that could print function names [*] (as I'm sure you've
noticed :) ), that way - printing the information based on some macros -
would definitely require some wrapping or modification of Err().

Comparing with that, current implementation looks better in general.

[*]: https://stackoverflow.com/a/63904992/24336517

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



