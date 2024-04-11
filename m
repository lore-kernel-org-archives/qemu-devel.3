Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5DBC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvTY-0002TM-UJ; Thu, 11 Apr 2024 10:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ruvT9-0002QQ-7C
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:32:04 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ruvT4-0001Xi-TK
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712845920; x=1744381920;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9iYwU/GixJig1EPBHxi1sh8g6A/f9aPX/0fmYayaLLI=;
 b=dtUJlIShNVRzuIFfsu6n4kcx6dqHQrOYiKsjMeHJSQW/wZOV+GVKidu7
 vaVwOI2QVClcXoTXBF+KK6j9LnGtFGJ3D9gcUaMXK0PZ8KD+cIONulMhk
 AUGfZFqhWq/j2lx054R1dYzDaFGjiVRlu/mz6u6eqfnG/HxxhHqUL2aUN
 UlTfgtvfMMI/EzmvpRf1/0limuIr1cT/XilSt/81F6tsF0993Lh27Gtct
 fnriML4Lqvb9T6YMY+tjf2PHv3Y/qypknoMDIiRdSvGlPmON52KT8m4Jj
 dc8vttAf9Tf975N/7yCFh55mIyVUmFtjEf28/CE/effh/TGFeM4++Wqjk A==;
X-CSE-ConnectionGUID: fD33OqOwSEO1m3wi72MJgg==
X-CSE-MsgGUID: wV2rY5iASdi39sqafMO01w==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25712645"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; d="scan'208";a="25712645"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2024 07:31:56 -0700
X-CSE-ConnectionGUID: 5OwuhGWCTGq7kKD8g0a7WA==
X-CSE-MsgGUID: r+Ll/ui8TKCz6eWLNkK3+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; d="scan'208";a="21358377"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 11 Apr 2024 07:31:55 -0700
Date: Thu, 11 Apr 2024 22:45:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH for-9.1 10/19] target/i386: generalize gen_movl_seg_T0
Message-ID: <Zhf3pDGRxqRmr5np@intel.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409164323.776660-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Paolo,

On Tue, Apr 09, 2024 at 06:43:14PM +0200, Paolo Bonzini wrote:
> Date: Tue,  9 Apr 2024 18:43:14 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH for-9.1 10/19] target/i386: generalize gen_movl_seg_T0
> X-Mailer: git-send-email 2.44.0
> 
> In the new decoder it is sometimes easier to put the segment
> in T1 instead of T0, usually because another operand was loaded
> by common code in T0.  Genrealize gen_movl_seg_T0 to allow
> using any source.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/translate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index de1ccb6ea7f..8a34e50c452 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2531,12 +2531,12 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
>      tcg_gen_shli_tl(cpu_seg_base[seg_reg], selector, 4);
>  }
>  
> -/* move T0 to seg_reg and compute if the CPU state may change. Never
> +/* move SRC to seg_reg and compute if the CPU state may change. Never
>     call this function with seg_reg == R_CS */
> -static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
> +static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
>  {
>      if (PE(s) && !VM86(s)) {
> -        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
> +        tcg_gen_trunc_tl_i32(s->tmp2_i32, src);
>          gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), s->tmp2_i32);
>          /* abort translation because the addseg value may change or
>             because ss32 may change. For R_SS, translation must always

This patch missed to include another gen_movl_seg_T0() use in emit.c.inc,
which was cleaned up later in patch 11. We could move that cleanup into
this patch to avoid compiling failures.

-Zhao


