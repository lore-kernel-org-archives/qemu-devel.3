Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNANo-0002Fa-3t; Thu, 05 Jun 2025 09:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNANm-0002EA-M3; Thu, 05 Jun 2025 09:11:46 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNANh-0006TL-Jr; Thu, 05 Jun 2025 09:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749129101; x=1780665101;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xa8+LxgCMzkYjHiAGIqcU7vYGCd726rIkIvYKgcBOII=;
 b=NnuGnjszVY+j1XdN135bOAgh03D2p7XmyXvhxWucvKI0PsnYmlvV8zNK
 RZyQ2AmxFiOTZe9FPQMG9/4tuOE1zp2Z7CcZ/4CP8yDn/FgLXN5k1Kjxu
 FaTMkc56iWWQfugTgcr2x6WEdEpJ3YS8FlQ80fLHANkprZUyurvUxVBxQ
 +e0Ken7HG4SdahfM8qsYR2y5li6vSKFB56UTCAzpAsAK99s/q7VKb0PHF
 jRHoACMeKfXHUqTkBcbtIdhiNxf/c47ayM9hd6w+V5Vv+mBjkfiJC1Khs
 lw4wKTGnarqGD8ax9SXgTc0JXvkD4+uuvJJ7KD6xFKapWxsGNY4ZiHGIl w==;
X-CSE-ConnectionGUID: ypUE6xOzRri1W/ZxBYU9Sg==
X-CSE-MsgGUID: K0qi2XQBTDq4tWIpZxCdiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="61909319"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="61909319"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:11:38 -0700
X-CSE-ConnectionGUID: AMQMf3ReRma0EM02Vv1JpA==
X-CSE-MsgGUID: SlACTmYTSyO5ibUTAOL32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="150384292"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 05 Jun 2025 06:11:37 -0700
Date: Thu, 5 Jun 2025 21:32:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/14] util/error: allow non-NUL-terminated err->src
Message-ID: <aEGcg/vj/WTgAIta@intel.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
 <20250605101544.368953-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605101544.368953-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On Thu, Jun 05, 2025 at 12:15:33PM +0200, Paolo Bonzini wrote:
> Date: Thu,  5 Jun 2025 12:15:33 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/14] util/error: allow non-NUL-terminated err->src
> X-Mailer: git-send-email 2.49.0
> 
> Rust makes the current file available as a statically-allocated string,
> but without a NUL terminator.  Allow this by storing an optional maximum
> length in the Error.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/error-internal.h | 9 ++++++++-
>  util/error.c                  | 5 +++--
>  2 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


