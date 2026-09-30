Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4117CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpiW-0000Zz-Mx; Wed, 30 Sep 2026 04:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBphl-0000NC-S2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:30:25 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBphk-0000cc-2j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790757021; x=1822293021;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Pf18yQUCwan8rRDVqYFkleuFkH3zcrW95OQKzgc+Ezg=;
 b=XaYt2fI+aFM3bVkip65iYAzLzMYVP0LN5me9QjlcV8y57LnEiqLJF4+z
 ILt+mnkwzdjXt9BVY/z8eTKR1UpW+ryo8eT+H2fguxUNYT4BMZchzCTJJ
 ZJDI+c6t8qli09Iwe50UFmh9x9zoLgqherys4sjhZeNNdzPCSKMJGlcFe
 R4Iq2hWKSBqLSGDGsTRWjv8hF/yNcAd7vDI1XRjC4qbojJMJtznAIeSOP
 aVCWeHH3wskLkkj7ACF28KkTsMN1biKOPDbXV9CZdyDXQvkee9UJnl6LT
 5lZrv3fpRcgJ5iLbIaxCb0zBE07SCQ2/pgqrjP7yTAIEoppCo4irXAhtd A==;
X-CSE-ConnectionGUID: 8neh346VTC+QWd+9UWyZXw==
X-CSE-MsgGUID: UrATJgN0QkK5cbrU4doJtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90530807"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90530807"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:30:18 -0700
X-CSE-ConnectionGUID: 83HDwGt1S1mfdG9uolc7bA==
X-CSE-MsgGUID: VwPKADXoRr+vfSm5Zr79hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="275184197"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2026 01:30:16 -0700
Date: Wed, 30 Sep 2026 16:30:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Andrey Polivoda <apolivodaa433@gmail.com>
Subject: Re: [PATCH 2/3] target/i386/tcg: move validate_vex() before all
 operand decoding
Message-ID: <arzIl3Z54sS2FDMa@intel.com>
References: <20260930065406.738374-1-pbonzini@redhat.com>
 <20260930065406.738374-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930065406.738374-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 30, 2026 at 08:54:05AM +0200, Paolo Bonzini wrote:
> Date: Wed, 30 Sep 2026 08:54:05 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/3] target/i386/tcg: move validate_vex() before all
>  operand decoding
> X-Mailer: git-send-email 2.55.0
> 
> Operand sizes are computed in decode_insn(), because s->rip_offset has to
> be known before decode_modrm() computes a RIP-relative address.  However,
> validate_vex() runs later and, for X86_VEX_REPScalar instructions, it must
> be able to turn e->s2 into X86_SIZE_ss or X86_SIZE_sd in presence of a
> memory operand.  But right now decode_op_size() has already run, and
> therefore decode->op[2].ot stays MO_128; the instruction therefore
> accesses 16 bytes of memory instead of 4 or 8.
> 
> The only user of s->rip_offset is decode_modrm(), which is called from
> decode_ops(), so the size computation can move there, after validate_vex().
> Thanks to the previous patch, the CR0.TS and CR0.EM checks come after
> decode_ops(), so #UD for an invalid VEX.L still has priority over #NM.
> 
> This way, when validate_vex() adjusts the X86OpEntry, decode_op_size()
> picks up the result.  This behaves as intended by commit b7d4ec4832d
> ("target/i386/tcg: move VEX validation early", 2026-08-26), and fixes
> REPScalar instructions that have a memory operand.
> 
> This also applies to unary operations, which need to ignore VEX.L.
> While this could also be fixed by using "dq" for the operand size, it
> is untidy that simply setting "s->vex_l = 0" does not do the right thing.
> 
> Fixes: b7d4ec4832d ("target/i386/tcg: move VEX validation early", 2026-08-26)
> Reported-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/decode-new.c.inc | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


