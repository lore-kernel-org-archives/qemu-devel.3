Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9067DC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hHP-00057z-AF; Wed, 02 Sep 2026 05:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1hHN-00057q-Gd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:29:13 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1hHL-0003rR-Qp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788341352; x=1819877352;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UwB/TDt/a3IX2wvZU5qTgcoLfAdVq0ON6D66Ubkr0bo=;
 b=n0esiD+SdgqOs6M5lwdSXHFvJ6yoKQGICGxszdIixuLCPAKKelVIEL6X
 6fHdM03WYlLxrNLj9biTlvjAdxycvmhpiFdzHWqW4ZOx78bZP1bPzy206
 3yg/Tvw/jlUQiLMw9Wpqwp9NFPoC58f+pUpx/ATUZAVQ0pW19sNw4/KZM
 kdTCzsn1aae+7gcQEGqXrlEkrGHTnV/A6zwS6wkQhThq/cEYc4eiLo1Cm
 Hgq5kzY7pw9SMi6s7UV1i2X8pxL+Bmw4CNssMsUXgHewZcRvVKEip48DS
 NdnAk89oUSjSXmUiXCa2pSP2AAwseHsnyDieJZcHYtA4d6mRqVWdZjFrD w==;
X-CSE-ConnectionGUID: 1M4+6wr+QPKvXKFZpbhB1g==
X-CSE-MsgGUID: p1Gq1FBKSwiQhTiWUSZf/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87932061"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="87932061"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:29:08 -0700
X-CSE-ConnectionGUID: 3WLnx81QSKK1FhYlOExetg==
X-CSE-MsgGUID: HZdzVu/qQheXlHIZX2WxkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="307575336"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa001.jf.intel.com with ESMTP; 02 Sep 2026 02:29:07 -0700
Date: Wed, 2 Sep 2026 17:29:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 20/20] target/i386/tcg: optimize CCMP
Message-ID: <apfsYkfCVJAsOD5p@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-21-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-21-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Aug 25, 2026 at 02:29:21PM +0200, Paolo Bonzini wrote:
> Date: Tue, 25 Aug 2026 14:29:21 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 20/20] target/i386/tcg: optimize CCMP
> X-Mailer: git-send-email 2.55.0
> 
> If possible, modify conditionally the input arguments to generate the
> flags requested by dfv; this way CCMP can use CC_OP_SUB* instead of having
> to compute the carry-out vector by hand.  This happens relatively often
> for dfv=0, and also for dfv=sf for code produced by clang.
> 
> Of the combinations that cannot be optimized, both GCC and clang generate
> dfv=zf.  GCC also generates OS and OSZ.
> 
> Do not bother doing this for CTEST; the savings are modest because it
> does not need complex code to compute the carry-out vector (CC_SRC
> is always 0).  In addition, trivially replacing the arguments to the AND
> would only support dfv=0 (produced by -2 & 2) or dfv=S (produced by -2 &
> -2), because TEST cannot produce any value where CF or OF are not zero.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/emit.c.inc | 56 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 1144953abb1..7641b2fc104 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -1749,6 +1749,53 @@ static void gen_dfv_movcond(DisasContext *s, X86DecodedInsn *decode, int cond, u
>                         decode->cc_dst, tcg_constant_tl(dst));
>  }
>  
> +static bool gen_ccmp_movcond(DisasContext *s, int cond, uint32_t dfv, MemOp ot)
> +{
> +    target_ulong op0, op1, max_int;
> +    if (cond == CCMP_T) {
> +        return true;
> +    }

should we return false for CCMP_F? Or...

> +}
> +
>  static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
>  static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
>  {
> @@ -1757,16 +1804,15 @@ static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
>      MemOp ot = decode->op[1].ot;
>      TCGv cout;
>  
> -    switch (cond) {
> -    case CCMP_T:
> +    if (gen_ccmp_movcond(s, cond, dfv, ot)) {
> +        /* Including CCMP_T, aka "normal" CMP.  */
>          gen_SUB(s, decode);
>          return;
> -    case CCMP_F:
> +    }
> +    if (cond == CCMP_F) {
>          decode->cc_op = CC_OP_EFLAGS;
>          decode->cc_src = tcg_constant_tl(dfv);
>          return;
> -    default:
> -        break;
>      }

...check the CCMP_F and return first:

if (cond == CCMP_F) {
    ...
    return;
}

if (gen_ccmp_movcond(s, cond, dfv, ot)) {
   ...
   return;
}

Thanks,
Zhao


