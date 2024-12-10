Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A94E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2QP-0003xx-Ku; Tue, 10 Dec 2024 10:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2QN-0003xP-70; Tue, 10 Dec 2024 10:45:23 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2QL-0002Ig-Ha; Tue, 10 Dec 2024 10:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733845522; x=1765381522;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AJEsJknm/vruoIxesXs3sCkydsxxzNnKtARs2ZjoeH8=;
 b=Q0Vb8XHnafWyYmaWdh3rQ+/v0Jnd5OAHLKTH4i2jyuJCxuOIVcpdzf5Y
 yokH/J3XCnyVJqRm2FZn2pNXBDidW6HFDtlyDWl+2Acd4ylTe3JskeW9N
 Skg8eEX3iDXwS3ZnILgrmUkHpF4THkGk+iVMQ8Qn23p2fmoDlNVAYUuIj
 qLx3P1BF33+7XrPExTdD89qdSYm102+A3kvrcgcyjOukMVXSvIjnhd5RD
 2KqeP7iOZJeGVoEDeDbzM9E7+pMB4q1tk5Re1dnMvrv1SQSpMCDtaO5tl
 hng3nBvC7rqr2P6NUkzRs6sFTvUZPyNPiAhpUJh0bfjNs+D+97pUr50rB g==;
X-CSE-ConnectionGUID: qglbXXN6TTysXZSNhD0R1Q==
X-CSE-MsgGUID: LMpGR1BeSt648LdXlpw3QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34331804"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="34331804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 07:45:19 -0800
X-CSE-ConnectionGUID: qnoT8xIxQg+8eHv3x89j5w==
X-CSE-MsgGUID: a4hOrKXLRi+EXH8cQE0rsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="95509127"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 10 Dec 2024 07:45:17 -0800
Date: Wed, 11 Dec 2024 00:03:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 10/26] rust: qom: move ClassInitImpl to the instance side
Message-ID: <Z1hmU9vpnsUuXY5+@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Mon, Dec 09, 2024 at 01:37:01PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:01 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/26] rust: qom: move ClassInitImpl to the instance side
> X-Mailer: git-send-email 2.47.1
> 
> Put all traits on the instance struct, which makes it possible to reuse
> class structs if no new virtual methods or class fields are added.
> This is almost always the case for devices (because they are leaf
> classes), which is the primary use case for Rust.
> 
> This is also simpler: soon we will find the implemented methods without
> macros, and this removes the need to go from the class struct to the
> instance struct to find the implementation of the *Impl traits.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 4 ++--
>  rust/qemu-api/src/definitions.rs | 8 ++++----
>  rust/qemu-api/tests/tests.rs     | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


