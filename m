Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D646E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2cj-0007EZ-Ti; Tue, 10 Dec 2024 10:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2ch-0007Dr-MP; Tue, 10 Dec 2024 10:58:07 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2cf-0003Tk-Pv; Tue, 10 Dec 2024 10:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733846285; x=1765382285;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=91TFU63MdkcGXJ9nNkZtJv4ux63u+oj0HjRHaAp0tO4=;
 b=frgkgBgZvIoNGkcXFmdMT+E5/4VQDJbLRsotXvepnt2DxwIB5RWfuAK6
 AWpXit0aYRjpm4qVzu0XtvD5A2Mr03pVtmucDO4yamGzsRmQW82eFr7e8
 ZztyNqA6KQ0MgWJH0qfr4dqgXQPiWroVYUFzsmj6al4GJQKoDvif5Zwpp
 CcQYUg35cJsQWqpTASxXqKzZtFB85h0fGzlsL0GKlAqz9szMJ+XldoWdP
 xRNLhAQzJOASU6XjGS3VDjLSSIBw4803a/ClBgK1XOccojwactGBsZTOX
 3gIIkzdLAVqK7jgxjHU58YqrHyQbtI03fs4wSfDTfExtHHnMV3rYXyylR w==;
X-CSE-ConnectionGUID: 5BYhGl3ETs+WfuwPVtrXBg==
X-CSE-MsgGUID: fTlAqFJ2T0mYk0N6IrvuTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51722717"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="51722717"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 07:58:02 -0800
X-CSE-ConnectionGUID: wcF/JyfdTuCLt8RNcoW3Ww==
X-CSE-MsgGUID: ZGit2JApSkSp6sggL0LdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="100407709"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 10 Dec 2024 07:58:01 -0800
Date: Wed, 11 Dec 2024 00:16:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 13/26] rust: qom: automatically use Drop trait to
 implement instance_finalize
Message-ID: <Z1hpT6F9jVlj2+ba@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-14-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 09, 2024 at 01:37:04PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:04 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 13/26] rust: qom: automatically use Drop trait to implement
>  instance_finalize
> X-Mailer: git-send-email 2.47.1
> 
> Replace the customizable INSTANCE_FINALIZE with a generic function
> that drops the Rust object.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/definitions.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Great idea. It nicely balances the differences between Rust and C QOM
conventions.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


