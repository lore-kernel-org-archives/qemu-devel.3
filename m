Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAACDCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7t-0000fW-9j; Sat, 30 Aug 2025 11:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urtsx-0004Il-Qa; Fri, 29 Aug 2025 03:50:59 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urtsv-0006gr-UN; Fri, 29 Aug 2025 03:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756453858; x=1787989858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=QPEJir6EjmeNzXcBe5S+2ANBcv/Su28ie2voF3z2HDQ=;
 b=i3aQHHVyZ3pfAKrctXi+gyVksyZrKfZLEz3/aOGK7f8A93sUtuyOYDtm
 adf7KLRngsNbqbgvroShGm4xBaQPep9Auc6BzIdyYuIYnQTjoGjB9D5GD
 H8crflxVC3f60MwD027QXUQtLdi3csTmhWZYWT48r0fu8S2kK5loEDLbi
 5NDlHyqHP0LXkNfczEYtuECwzh4pz+Ub5HpgImsTP80G76TqQJo7+XsD/
 QdS3HpM8SzQXHStozdXLS2ZMVV+AmVrAOqZJQ1ZjpV0IUrTIwFFq+xEIo
 7xACgp6ppqcsyV7fjDY3x0uOV2zOd4utCe0SgWBCJ/atOZgxw59IyyQek g==;
X-CSE-ConnectionGUID: BL+GBCVZRaaSs7arrI+H4A==
X-CSE-MsgGUID: hXqoUEEHQsiWMA5hWBUiFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69834688"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="69834688"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:50:54 -0700
X-CSE-ConnectionGUID: /hDteVzKSy2RNl6HZSxkwQ==
X-CSE-MsgGUID: WFUHO3eZRmmUvUkhCSvixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170223083"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2025 00:50:51 -0700
Date: Fri, 29 Aug 2025 16:12:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 08/22] rust: move VMState handling to QOM module
Message-ID: <aLFg9wBU0ROh1DaG@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-9-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 27, 2025 at 02:41:30PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:30 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 08/22] rust: move VMState handling to QOM module
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to split vmstate to a standalone crate next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/qemu-api/src/qom.rs     |  3 +++
>  rust/qemu-api/src/vmstate.rs | 10 +++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


