Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDA5CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwds7-0007Nd-R8; Thu, 11 Sep 2025 05:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwds4-0007Mv-8D
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:45:40 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwdrw-0003BY-Ar
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757583932; x=1789119932;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=M5NUiD5lZIGjNEagvFU9izwPjfG4M2CncUk1AjL7PKU=;
 b=Aks2OhpAbSUEIc2SAyoY+IX4sBDu0TCmmolsc0+K5H7xCPUYuC6oc5hj
 CYMwUp6nkapo0L9eR8WJJgOsuqBIbNYKBJGcrmal92Rjex5Z/DByIhLaR
 YHFtZvlveoRmrXmbmlKlHMyerYm1lXDz2p1p9BV2I6c+Ug59KjnqAOkvn
 epn74JUcRmH/LpU6k9mXFZ455FkB8p8W7wcUzfM1vSFEEHOiS9cwptTKe
 tkkowdsz2LGn8bB6438r7crh9WUx8yv6w8a8M7t8wJsgiM5R7mnz1wuEc
 WvjFBoMdcKjyqFfCzUpthqK7SONXSVBzETGlXfvwK8AtPZ19KW1BnhiB9 g==;
X-CSE-ConnectionGUID: 1OC0rAvZRNixCZMU4qSZrQ==
X-CSE-MsgGUID: HeA+vLY8Rx6kbR1ZvCPQrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="60058319"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="60058319"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 02:45:24 -0700
X-CSE-ConnectionGUID: SsgBFixeTmiTiDyNOOm2Cw==
X-CSE-MsgGUID: hpUwRtASSUmA/JqVoBLiZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="204643372"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 11 Sep 2025 02:45:23 -0700
Date: Thu, 11 Sep 2025 18:07:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/33] rust: vmstate: use const_refs_to_static
Message-ID: <aMKfVKfdouRf/La3@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 08, 2025 at 12:49:40PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:40 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/33] rust: vmstate: use const_refs_to_static
> X-Mailer: git-send-email 2.51.0
> 
> The VMStateDescriptionBuilder already needs const_refs_static, so
> use it to remove the need for vmstate_clock! and vmstate_struct!,
> as well as to simplify the implementation for scalars.
> 
> If the consts in the VMState trait can reference to static
> VMStateDescription, scalars do not need the info_enum_to_ref!
> indirection and structs can implement the VMState trait themselves.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst                  |   5 -
>  rust/hw/char/pl011/src/device.rs     |  19 ++-
>  rust/hw/timer/hpet/src/device.rs     |   8 +-
>  rust/qemu-api/src/assertions.rs      |   4 -
>  rust/qemu-api/src/vmstate.rs         | 229 +++++++--------------------
>  rust/qemu-api/tests/vmstate_tests.rs |  65 +++++---
>  6 files changed, 113 insertions(+), 217 deletions(-)

Good improvement!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


