Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A47D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 04:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Sff-0002HQ-MG; Wed, 23 Oct 2024 00:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3Sfd-0002HI-Ar
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 00:08:29 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3Sfa-00030I-AZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 00:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729656506; x=1761192506;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=P0B2FQX8LuiyImCOngEFfeJ26YeZKKBdezKhubvqy5Q=;
 b=cuFQ8Dj+UWPeCrjzq8KPQ02UZMqDESWsb20Ia0x2WHvjm0BV+jKE4iuf
 KGaTUJc3nNsNpLlMxess7geRIjcUnowZRu6xWA/LQsOd53NXjPThjVyPc
 wKQYfLFCyaTNeXHXT9ykP8qJtT4cKKmu6gQ1NOXs+N4Qgj+VasVNVncOl
 GrhRNH/GmRoafx5rH5fRyMJeUXr1fw24LxFE9xem+Mnk+Au1THMGRsNjO
 nJa0WpvonOrtnnRvrKFPTXpKd7ZSs0Lb/vEwZggdECMClq/kfForurEER
 Ipp8ivq6DVY7Si9GUBGvnXzI/apd8Bmag1fYFLSB9umvsxfCvLvejV5LA Q==;
X-CSE-ConnectionGUID: mUD/i5c5QxWUdidcC6vzCQ==
X-CSE-MsgGUID: 7mQhK3kPQNWPq+ZO+DFL7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39771057"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39771057"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 21:08:24 -0700
X-CSE-ConnectionGUID: s2gwVw5iRWqUvL2Wsvn9LQ==
X-CSE-MsgGUID: ut/RmKR+R8GThvstTZJRiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="80145512"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 22 Oct 2024 21:08:22 -0700
Date: Wed, 23 Oct 2024 12:24:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 04/13] rust: do not use --no-size_t-is-usize
Message-ID: <Zxh6h02hlPFwqNrX@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

On Mon, Oct 21, 2024 at 06:35:29PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:29 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 04/13] rust: do not use --no-size_t-is-usize
> X-Mailer: git-send-email 2.46.2
> 
> This not necessary and makes it harder to write code that
> is portable between 32- and 64-bit systems: it adds extra casts even
> though size_of, align_of or offset_of already return the right type.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                      | 1 -
>  rust/qemu-api/src/definitions.rs | 6 +++---
>  2 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


