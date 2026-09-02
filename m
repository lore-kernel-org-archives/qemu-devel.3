Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FA3C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1e78-0005m1-OT; Wed, 02 Sep 2026 02:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1e76-0005lf-SM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:06:24 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1e74-0002aw-Ca
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788329183; x=1819865183;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=30PdNXZ4Rm1fvccHWu5lIhtWaMGN1b3G+A64sJB2l2U=;
 b=B7UlQjeGQlAxWgrvWi40dfpP982kgFvq4C1lta4ziFzdHQBTnrh3+Y6T
 ZTkxXsFIPQncEPlviiu3r+ovMj5lW7RB6eR39ZqUfrkr/FgUSSP4f30N2
 wI3BZxHpyeb6Vz3kc+ZXxpShl76dasKp7nggQIRxdyl9G9TKVLXdlwrdR
 8GKqJdtCRwcpEIBXRpLeuIXOGeTLNDCa7mjwN7SxN9LRMt7Br40RqRss1
 iutbooIwnSJYNKYPEO2ejVhsbS88RkHu7rQXSOiZeee2PGYrps8760p85
 jMWoVG48AWhuNHGs08Lbx/fL1qRdb++T3arPG0eqHNHlqj4cAd5/qw0Wb A==;
X-CSE-ConnectionGUID: XVz09wSbTHSHGS4o3rKrfA==
X-CSE-MsgGUID: OjxPpYlER4GUDmn06XWyGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106144963"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="106144963"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 23:06:20 -0700
X-CSE-ConnectionGUID: nxLlhbebQSqwn5roHMzsgg==
X-CSE-MsgGUID: LWqVFBzNSRS4DoDCKwClzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="273082895"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa004.jf.intel.com with ESMTP; 01 Sep 2026 23:06:18 -0700
Date: Wed, 2 Sep 2026 14:06:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 17/20] target/i386/tcg: implement CCMP/CTEST
Message-ID: <ape82TgVc32+rvu3@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-18-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

>  static uint32_t glue(compute_aco_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
>  {
>      DATA_TYPE src2 = dst - src1;
> diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
> index 6ddd64fcb07..a43b42badc0 100644
> --- a/target/i386/tcg/cc_helper.c
> +++ b/target/i386/tcg/cc_helper.c
> @@ -111,6 +111,13 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
>      case CC_OP_ADCOX:
>          return compute_all_adcox(dst, src1, src2);
>  
> +    case CC_OP_CCMPB:
> +        return compute_all_ccmpb(dst, src1, src2);
> +    case CC_OP_CCMPW:
> +        return compute_all_ccmpw(dst, src1, src2);
> +    case CC_OP_CCMPL:
> +        return compute_all_ccmpl(dst, src1, src2);
> +
>      case CC_OP_MULB:
>          flags = compute_aco_mul(src1);
>          goto psz_b;
> @@ -232,6 +239,9 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
>          goto psz_l;
>  
>  #ifdef TARGET_X86_64
> +    case CC_OP_CCMPQ:
> +        return compute_all_ccmpq(dst, src1, src2);
> +
>      case CC_OP_MULQ:
>          flags = compute_aco_mul(src1);
>          goto psz_q;

IIUC, it seems helper_cc_compute_c() missed CCMP ops, afterall it said
"should never happen" for default case:

target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
                                 target_ulong src2, int op)
{
    switch (op) {
    default: /* should never happen */
    ...

I think we would need a compute_c_ccmp helper.

Thanks,
Zhao


